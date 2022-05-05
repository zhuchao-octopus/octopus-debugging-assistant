unit OcProtocol;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Actions,
  IdHashMessageDigest,
  ComObj,
  StrUtils,
  Octopus_CRC;

// type OCCOMPROTOCAL_STATUS=();
const
  OCCOMPROTOCAL_HEAD = $0101; // $55AA;
  OCCOMPROTOCAL_END = $7E; // $AA55;

  OCCOMPROTOCAL_START = 10; // 连接，要求对方回复 状态是否可以连接
  OCCOMPROTOCAL_ACK = 11; // 一般相应，要求对方相应当前状态
  OCCOMPROTOCAL_READY = 12; // 准备就绪标记
  OCCOMPROTOCAL_OVER = 13; // 任务结束标记
  OCCOMPROTOCAL_GOT = $0E00; // 14; //数据包确认标记收到标记 ,复合在高字节

  OCCOMPROTOCAL_I2C_READ = 50;
  OCCOMPROTOCAL_I2C_WRITE = 51;
  OCCOMPROTOCAL_SPI_READ = 52;
  OCCOMPROTOCAL_SPI_WRITE = 53;
  OCCOMPROTOCAL_WIFI_READ = 54;
  OCCOMPROTOCAL_WIFI_WRITE = 55;
  OCCOMPROTOCAL_UART_READ = 56;
  OCCOMPROTOCAL_UART_WRITE = 57;

  OCCOMPROTOCAL_DATA1 = 101; // 标准协议数据 最大负载是512字节
  OCCOMPROTOCAL_DATA2 = 102; // 非标准协议表示数据是连续的，没有分包，或者说只有一个包

  OCCOMPROTOCAL_ERROR = $FFFF;
  OCCOMPROTOCAL_NONE = $0000;
  OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT = 1023;

  OCCOMPROTOCAL_WM_ACK = WM_APP + 100;

  OCCOMPROTOCAL_PACK_PACKPAYLOAD_MAX_LENGTH = 500;
  OCCOMPROTOCAL_PACK_MAX_LENGTH = 512;
type

  POcComPack = ^TOcComPack;

  TOcComPack = packed record // 12+512 =524
    Head: WORD; // 头部识别码 2
    PID: WORD; // 包的类型  2
    Index: byte; // 包的索引  2
    Length: WORD; // 实际数据长度
    data: array [0 .. OCCOMPROTOCAL_PACK_PACKPAYLOAD_MAX_LENGTH] of byte; // 包后面的数据
    //CRC: byte; // CRC校验    2
    //EndFlag:byte;
  end;

  TOcComPackHead = packed record // 用于头部识别
    Head: WORD; // 头部识别码 4
    PID: WORD; // 包的类型  1
    Index: byte; // 包的索引  2
    Length: WORD; // 包的总长度 2
  end;

type
  TCallBackFun = Procedure(OcComPack: TOcComPack) of object;

  TOcComProtocal = class
  private
    FPackList_RB: Array [0 .. OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT]
      of TOcComPack;
    FPackList_RB_Top: integer;
    FPackList_RB_Count: integer;
    FNeedCRC16: Boolean;
    FCallBackFun: TCallBackFun;
  public

    Constructor Create();
    destructor Destroy;
    function AddPackToPackList(OcComPack: POcComPack):Integer;
    function CreatePack(Id: byte): TOcComPack;
    function ParserPack(buff: PByte; Len: integer): integer;
    function GetPackByIndex(i: integer): TOcComPack;
    function GetBytesValue(i: integer): Int64;
    procedure ClearPacks();
    function CheckPackMinLength(p: POcComPack; Len: integer): Boolean;
    function CheckPackLength(p: POcComPack; Len: integer): Boolean;
    function CheckPackCRC(p: POcComPack; Len: integer): Boolean;
    function IsParserComplete(): Boolean;
    function WaitingForACK(OcComPack: TOcComPackHead; timeOut: integer): Boolean;
    function GetLastPackHead(): TOcComPackHead;
    function GetLastPack(): TOcComPack;
    function CalCRC16(AData: array of byte; Length: integer): WORD; // 计算法

    property CallBackFun: TCallBackFun read FCallBackFun write FCallBackFun;
    property PackList_RB_Top: integer read FPackList_RB_Top;
    property PackList_RB_Count: integer read FPackList_RB_Count;
    property NeedCRC16: Boolean read FNeedCRC16 write FNeedCRC16;

  end;

function EncryptInt(d: integer): string;
function DecryptInt(ks: string): integer;

implementation

Constructor TOcComProtocal.Create();
begin
  FPackList_RB_Top := 0;
  FPackList_RB_Count := 0;
  ZeroMemory(@FPackList_RB, SizeOf(TOcComPack) * Length(FPackList_RB));
end;

Destructor TOcComProtocal.Destroy;
begin

end;

function TOcComProtocal.IsParserComplete: Boolean;
//var
// PackSize:Integer;
begin
  Result := false;
  //PackSize := SizeOf(TOcComPackHead) + p.Length + 2;//包的实际有效长度
  //if (((GetLastPackHead.Total - GetLastPackHead.Index) = 1) and
  //  (GetLastPackHead.PID > OCCOMPROTOCAL_DATA1)) or
  //  (GetLastPackHead.PID = OCCOMPROTOCAL_OVER) then
  //if(GetLastPack.EndFlag = OCCOMPROTOCAL_END) then
  Result := True; // 解析到最后一个包了， 确认解析完成，中间有可能丢包不管,或者客户端发送了结束命令
end;

function TOcComProtocal.GetLastPackHead(): TOcComPackHead;
begin
  Result.PID := OCCOMPROTOCAL_ERROR;
  CopyMemory(@Result, @FPackList_RB[FPackList_RB_Top], SizeOf(TOcComPackHead));
end;


function TOcComProtocal.GetLastPack(): TOcComPack;
begin
  CopyMemory(@Result, @FPackList_RB[FPackList_RB_Top], SizeOf(TOcComPack));
end;

function TOcComProtocal.WaitingForACK(OcComPack: TOcComPackHead;
  timeOut: integer): Boolean;
var
  Oc: TOcComPack;
  Start: real;
begin
  Result := false;
  Start := GetTickCount;
  while (True) do
  begin
    if (GetTickCount - Start) > timeOut then
    begin
      break; // 超时推出
    end;

    Oc := FPackList_RB[FPackList_RB_Top];
    if (Oc.Head = OcComPack.Head) and (Oc.PID = byte(OcComPack.PID)) and
      (Oc.Index = OcComPack.Index) {and (Oc.Total = OcComPack.Total)} and
      (Oc.Length = OcComPack.Length) and
      ((Oc.PID and $FF00) = OCCOMPROTOCAL_GOT) then // 表示这个包收到
    begin
      Result := True;
      break;
    end;
  end;
end;

function TOcComProtocal.AddPackToPackList(OcComPack: POcComPack):Integer;
  var PackSize:Integer;
begin
  PackSize := SizeOf(TOcComPackHead) + OcComPack.Length + 2;//包的实际有效长度
  INC(FPackList_RB_Top);
  if FPackList_RB_Top > OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT then
    FPackList_RB_Top := 0; // Ring buffer
  CopyMemory(@FPackList_RB[FPackList_RB_Top], OcComPack, PackSize);
  INC(FPackList_RB_Count);
  Result:= PackSize;
end;

function TOcComProtocal.CreatePack(Id: byte): TOcComPack;
var
  OcComPack: TOcComPack;
begin
  OcComPack.Length := SizeOf(TOcComPackHead);
  OcComPack.Head := OCCOMPROTOCAL_HEAD;
  OcComPack.PID := Id;
  Result := OcComPack;
end;

function TOcComProtocal.CheckPackMinLength(p: POcComPack; Len: integer): Boolean;
begin
  Result := True;
  if Len < (SizeOf(TOcComPackHead) + 2) then // 长度不够，小于最小包长度
    Result := false;
end;

function TOcComProtocal.CheckPackLength(p: POcComPack; Len: integer): Boolean;
// 这里描述是否继续等待
var
  PackSize :Integer;
begin
  Result := True;
  PackSize := SizeOf(TOcComPackHead) + p.Length + 2;//包的实际有效长度
  if (Len < PackSize) { 收到的数据不够 }
  then
  begin // 包描述的长度要小于等于最大允许的包长度
    Result := false; // 说明数据不全，继续等待数据
  end;
  if(Len > OCCOMPROTOCAL_PACK_PACKPAYLOAD_MAX_LENGTH) { 包长是合法的,不能超过最大包长 } then
  begin
    Result:=false;
  end;
end;

function TOcComProtocal.CheckPackCRC(p: POcComPack; Len: integer): Boolean;
// 问题包，这里检查包是否出错，是否要丢弃
var
  CRC1: WORD;//CRC
  CRC2: WORD;//END_FLAG
  PackSize: integer;
begin
  Result := false;
  //PackSize := SizeOf(TOcComPackHead) + p.Length + 2;//包的实际有效长度
  {CRC2 := p.data[p.Length - SizeOf(TOcComPackHead) - 1]; // 包围错误
  CRC2 := CRC2 SHL 8 + p.data[p.Length - SizeOf(TOcComPackHead) - 2];
  if (CRC2 <> OCCOMPROTOCAL_END) then // 包尾部丢失
  begin
    CRC1 := CalCRC16(p.data, p.Length - SizeOf(TOcComPackHead) - 2);
    if CRC1 <> CRC2 then // CRC 不对
      Result := false;
  end;}

  if((p.Length + SizeOf(TOcComPackHead)) >= len) then
   Exit;

  CRC1 := p.data[p.Length];
  CRC2 := p.data[p.Length + 1];
  if(CRC2 = OCCOMPROTOCAL_END) then
    Result:=true;
end;

function TOcComProtocal.ParserPack(buff: PByte; Len: integer): integer;
var
  i: integer;
  p: POcComPack;
  //p2: TOcComPackHead;
  //pw: PByte;
begin
  i := 0;
  if Len < SizeOf(TOcComPackHead) then // 数据包最小长度验证 ，数据不够，继续等等新的数据
  begin
     Exit;
  end;
  while (True) do
  begin
    Result := i;
    p := @buff[i];

    if(CheckPackMinLength(p,Len - i) = false) then
    begin
      break;//数据不够，继续等等新的数据
    end;

    if p^.Head = OCCOMPROTOCAL_HEAD then //对包头
    begin
      //if CheckPackLength(p, Len) = false then // 数据包合法长度描述有问题，负载不全 继续等待新的数据
      //begin
      //  break; // 负载不全，等待更多数据
      //end;
      if CheckPackCRC(p, Len - i) then //找包围 Len - i剩余长度
      begin
        i:= i+ AddPackToPackList(p);
        if Assigned(FCallBackFun) then
        begin
          FCallBackFun(GetLastPack());
        end;
      end
      else
      begin
        break; // 负载不全，等待更多数据
      end;
    end
    else
    begin
      INC(i); // 继续寻找
    end;
  end;
end;

function TOcComProtocal.GetPackByIndex(i: integer): TOcComPack;
begin
  Result := FPackList_RB[i];
end;

function TOcComProtocal.GetBytesValue(i: integer): Int64;
var
  j: integer;
  // b:byte;
begin
  Result := 0;
  // b:=
  for j := 0 to self.GetPackByIndex(i).Length - SizeOf(TOcComPackHead) - 1 do
  begin
    // str := str + Format('%.02x ', [self.FOcComProtocal.GetPackByIndex(i).data[j]]);
    Result := (Result shl 8) + GetPackByIndex(i).data[j];
  end;

end;

procedure TOcComProtocal.ClearPacks();
begin
  FPackList_RB_Top := 0;
  FPackList_RB_Count := 0;
  ZeroMemory(@FPackList_RB, SizeOf(TOcComPack) * Length(FPackList_RB));
end;

function GetGUI(): String;
var
  FGuid: TGUID;
begin
  CreateGUID(FGuid);
  Result := GUIDToString(FGuid);
  Result := Result + ' ' + IntToStr(Length(Result));
  Result := Copy(GUIDToString(FGuid), 2, 36);
end;

function GetGUID(): String;
var
  AGuid: TGUID;
  sGUID: string;
begin
  sGUID := CreateClassID;
  Delete(sGUID, 1, 1);
  Delete(sGUID, Length(sGUID), 1);
  sGUID := StringReplace(sGUID, '-', '', [rfReplaceAll]);
  Result := sGUID;
end;

function GetMD5(Str: String): String;
var
  MD5: TIdHashMessageDigest5;
begin
  MD5 := TIdHashMessageDigest5.Create;
  Result := MD5.HashStringAsHex(Str);
end;

// Encrypt integer to str
function EncryptInt(d: integer): string;
var
  i: integer;
  cd: array [0 .. 7] of byte;
begin
  cd[1] := Random(256);
  cd[4] := Random(cd[1]);
  cd[6] := Random(cd[1] + cd[4]);
  cd[2] := (((d div $10000) mod $100) + cd[1]) xor cd[4];
  cd[3] := (((d div $100) mod $100) - cd[2]) xor (cd[1] - cd[4]);
  cd[5] := ((d mod $100) - cd[6]) xor (cd[1] + cd[3]);
  cd[7] := ((d div $1000000) mod $100) + cd[1] + cd[5];
  cd[0] := ((cd[1] xor cd[2]) xor cd[3]) + (cd[4] or cd[5]) + (cd[6] and cd[7]);
  Result := '';
  for i := 0 to 7 do
    Result := Result + IntToHex(cd[i], 2);
end;

function DecryptInt(ks: string): integer;
var
  i: integer;
  cd: array [0 .. 7] of byte;
  s: string;
begin
  for i := 0 to 7 do
  begin
    s := '$' + ks[i + i + 1] + ks[i + i + 2];
    cd[i] := StrToInt(s);
  end;

  if cd[0] <> byte(((cd[1] xor cd[2]) xor cd[3]) + (cd[4] or cd[5]) +
    (cd[6] and cd[7])) then
  begin
    Result := 0;
    Exit;
  end;
  cd[7] := cd[7] - cd[1] - cd[5];
  cd[5] := (cd[5] xor (cd[1] + cd[3])) + cd[6];
  cd[3] := (cd[3] xor (cd[1] - cd[4])) + cd[2];
  cd[2] := (cd[2] xor cd[4]) - cd[1];
  Result := cd[7] * $1000000 + cd[2] * $10000 + cd[3] * $100 + cd[5];
end;

function TOcComProtocal.CalCRC16(AData: array of byte; Length: integer): WORD;
// 计算法
const
  GENP = $A001;
var
  CRC: WORD;
  i: integer;
  tmp: byte;
  procedure CalOneByte(AByte: byte); // 计算1个字节的校验码
  var
    j: integer;
  begin
    CRC := CRC xor AByte; // 将数据与CRC寄存器的低8位进行异或
    for j := 0 to 7 do // 对每一位进行校验
    begin
      tmp := CRC and 1; // 取出最低位
      CRC := CRC shr 1; // 寄存器向右移一位
      CRC := CRC and $7FFF; // 将最高位置0
      if tmp = 1 then // 检测移出的位，如果为1，那么与多项式异或
        CRC := CRC xor GENP;
      CRC := CRC and $FFFF;
    end;
  end;

begin
  CRC := $FFFF; // 将余数设定为FFFF
  for i := 0 to Length - 1 do // 对每一个字节进行校验
    CalOneByte(AData[i]);
  Result := CRC;
end;

end.
