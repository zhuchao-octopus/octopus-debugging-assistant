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
  CRC;

// type OCCOMPROTOCAL_STATUS=();
const
  OCCOMPROTOCAL_HEAD = $0101; // $55AA;
  OCCOMPROTOCAL_HEAD2 = $0AFF; // 不同的头码，不同数据格式

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

  OCCOMPROTOCAL_DATA1 = $FA; // 标准协议数据 最大负载是512字节
  OCCOMPROTOCAL_DATA2 = $FB; // 非标准协议表示数据是连续的没有分包或者说只有一个包
  OCCOMPROTOCAL_DATA_OVER = $FD; // 数据发送完成

  OCCOMPROTOCAL_ERROR = $FFFF;
  OCCOMPROTOCAL_NONE = $0000;
  OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT = 1024 * 4;

  OCCOMPROTOCAL_WM_ACK = WM_APP + 100;

  OCCOMPROTOCAL_PACK_PACKPAYLOAD_MAX_LENGTH = 500;
  OCCOMPROTOCAL_PACK_MAX_LENGTH = 512;

type

  POcComPack = ^TOcComPack;
  POcComPack2 = ^TOcComPackHead2;

  TOcComPack = packed record // 7+500 =524
    Head: WORD; // 头部识别码 2
    PID: WORD; // 包的类型  2
    Index: byte; // 包的索引  1
    Length: WORD; // 实际数据长度  2
    data: array [0 .. OCCOMPROTOCAL_PACK_PACKPAYLOAD_MAX_LENGTH] of byte; // 包后面的数据 500
    // CRC: byte; // CRC校验    2
    // EndFlag:byte; 1
  end;

  TOcComPackHead = packed record // 用于头部识别
    Head: WORD; // 头部识别码 2
    PID: WORD; // 包的类型  2
    Index: byte; // 包的索引  1
    Length: WORD; // 实际数据长度2
  end;

  TOcComPackHead2 = packed record // 用于头部识别
    Head: WORD; // 头部识别码 2
    PID: WORD; // 包的类型  2 //命令+设备地址各一个字节
    Length: byte; // 包的总长度  1
  end;

type
  TCallBackFun = Procedure(OcComPack: POcComPack) of object;

  TOcComProtocal = class
  private
    FPackList_RB: Array [0 .. OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT] of TOcComPack;
    FPackList_RB_Top: Integer;
    FPackList_RB_Count: Integer;
    FPackList_RB_NewIndex: Integer;
    FNeedCRC16: Boolean;
    FCallBackFun: TCallBackFun;
  public

    Constructor Create();
    destructor Destroy;

    function CreatePack(Id: byte): TOcComPack; overload;
    function CreatePack(Head: WORD; Id: byte): TOcComPack; overload;

    function AddPackToPackList(OcComPack: POcComPack): Integer; overload;
    function AddPackToPackList(OcComPack: POcComPack2): Integer; overload;

    function CheckPackCRC(p: POcComPack; bLength: Integer): Boolean; overload;
    function CheckPackCRC(p: POcComPack2; bLength: Integer): Boolean; overload;

    function WaitingForACK(OcComPack: TOcComPackHead; timeOut: Integer): Boolean; overload;
    function WaitingForACK(OcComPack: TOcComPackHead2; timeOut: Integer): Boolean; overload;
    function WaitingForACK(ACK: Integer; timeOut: Integer): Boolean; overload;

    function GetLastPackHead(): TOcComPackHead;
    function GetLastPack(): POcComPack;
    function GetNewPack(): POcComPack;

    function GetPackByIndex(i: Integer): TOcComPack;
    function GetBytesValue(i: Integer): Int64;
    procedure ClearPacks();
    function CheckPackMinLength(bLength: Integer): Boolean;
    function CheckPackLength(p: POcComPack; bLength: Integer): Boolean;

    function ParserPack(buff: PByte; Count: Integer): Integer;

    property CallBackFun: TCallBackFun read FCallBackFun write FCallBackFun;
    property PackList_RB_Top: Integer read FPackList_RB_Top;
    property PackList_RB_Count: Integer read FPackList_RB_Count;
    property NeedCRC16: Boolean read FNeedCRC16 write FNeedCRC16;

  end;

implementation

Constructor TOcComProtocal.Create();
begin
  FPackList_RB_Top := 0;
  FPackList_RB_Count := 0;
  FPackList_RB_NewIndex := -1;
  ZeroMemory(@FPackList_RB, SizeOf(TOcComPack) * Length(FPackList_RB));
end;

Destructor TOcComProtocal.Destroy;
begin

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

function TOcComProtocal.CreatePack(Head: WORD; Id: byte): TOcComPack;
var
  OcComPack: TOcComPack;
begin
  OcComPack.Length := SizeOf(TOcComPackHead);
  OcComPack.Head := Head;
  OcComPack.PID := Id;
  Result := OcComPack;
end;

function TOcComProtocal.AddPackToPackList(OcComPack: POcComPack): Integer;
var
  PackSize: Integer;
begin
  PackSize := SizeOf(TOcComPackHead) + OcComPack.Length + 2; // 包的实际有效长度
  INC(FPackList_RB_Top);
  if FPackList_RB_Top > OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT then
    FPackList_RB_Top := 0; // Ring buffer
  CopyMemory(@FPackList_RB[FPackList_RB_Top], OcComPack, PackSize);
  INC(FPackList_RB_Count);
  Result := PackSize;
end;

function TOcComProtocal.AddPackToPackList(OcComPack: POcComPack2): Integer;
var
  PackSize: Integer;
  comPack: TOcComPack;
  pb: PByte;
begin
  // PackSize := OcComPack.Length; // 包的实际有效长度
  INC(FPackList_RB_Top);
  if FPackList_RB_Top > OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT then
    FPackList_RB_Top := 0; // Ring buffer

  comPack.Head := OcComPack.Head;
  comPack.PID := OcComPack.PID;
  comPack.Index := 0;
  comPack.Length := OcComPack.Length - 5 - 1; // 负载的长度不包括了CRC
  pb := PByte(OcComPack);
  CopyMemory(@comPack.data[0], pb + 5, comPack.Length + 1); // 拷贝负载数据 和 CRC

  PackSize := SizeOf(TOcComPackHead) + comPack.Length + 2 { 校验码+结束标记 }; // 包的实际总长度
  CopyMemory(@FPackList_RB[FPackList_RB_Top], @comPack, PackSize);
  INC(FPackList_RB_Count);

  Result := OcComPack.Length;
end;

function TOcComProtocal.CheckPackCRC(p: POcComPack; bLength: Integer): Boolean;
// 问题包，这里检查包是否出错，是否要丢弃
var
  CRC1: WORD; // CRC
  CRC2: WORD; // END_FLAG
  PackSize: Integer;
begin
  Result := false;
  if p.Head = OCCOMPROTOCAL_HEAD then
  begin
    // if ((p.Length + SizeOf(TOcComPackHead) + 3) > bLength) then
    // Exit; // 数据不完整

    CRC1 := p.data[p.Length]; // checksum
    CRC2 := p.data[p.Length + 1];
    if (CRC2 = OCCOMPROTOCAL_END) then
      Result := True;
  end;
end;

function TOcComProtocal.CheckPackCRC(p: POcComPack2; bLength: Integer): Boolean;
var
  CRC1: WORD; // CRC
  CRC2: WORD; // END_FLAG
  i: Integer;
  pb: PByte;
begin
  Result := false;
  if p.Head = OCCOMPROTOCAL_HEAD2 then
  begin
    pb := PByte(p);
    if (p.Length > bLength) then // p.Length 为数据包的总长度
      Exit; // 数据不完整

    CRC1 := (pb + (p.Length - 1))^;
    CRC2 := 0;
    for i := 0 to p.Length - 2 do
    begin
      CRC2 := QuickCRC8(pb^, CRC2); // 快速查表计算CRC
      INC(pb);
    end;

    if (CRC2 = CRC1) then
      Result := True;
  end;
end;

function TOcComProtocal.WaitingForACK(OcComPack: TOcComPackHead; timeOut: Integer): Boolean;
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
    if (Oc.Head = OcComPack.Head) and (Oc.PID = byte(OcComPack.PID)) and (Oc.Index = OcComPack.Index) { and (Oc.Total = OcComPack.Total) } and (Oc.Length = OcComPack.Length) and
      ((Oc.PID and $FF00) = OCCOMPROTOCAL_GOT) then // 表示这个包收到
    begin
      Result := True;
      break;
    end;
  end;
end;

function TOcComProtocal.WaitingForACK(OcComPack: TOcComPackHead2; timeOut: Integer): Boolean;
var
  Oc: TOcComPack;
  Start: real;
  // pb: PByte;
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
    if (Oc.Head = OcComPack.Head) and (Oc.PID = byte(OcComPack.PID)) and (Oc.Length = OcComPack.Length) then // 表示这个包收到
    begin
      if Oc.data[0] = 89 then // 0x59 89 Y
      begin
        Result := True;
        break;
      end;
    end;
  end;
end;

function TOcComProtocal.WaitingForACK(ACK: Integer; timeOut: Integer): Boolean;
var
  pOc: POcComPack;
  Start: real;
  // pb: PByte;
begin
  Result := false;
  Start := GetTickCount;
  while (True) do
  begin
    if (GetTickCount - Start) > timeOut then
    begin
      break; // 超时推出
    end;
    pOc := GetNewPack();
    // if (Oc.Head = OcComPack.Head) and (Oc.PID = byte(OcComPack.PID)) and (Oc.Length = OcComPack.Length) then // 表示这个包收到
    if pOc <> nil then
    begin
      if pOc.data[0] = ACK then // 0x59 89 Y
      begin
        Result := True;
        break;
      end;
    end;
    //Application.
  end;
end;

function TOcComProtocal.GetNewPack(): POcComPack;
begin
  Result := nil;
  if (FPackList_RB_NewIndex <> FPackList_RB_Top) then
  begin
     Result:= GetLastPack();
     FPackList_RB_NewIndex:= FPackList_RB_Top;
  end
end;

function TOcComProtocal.GetLastPackHead(): TOcComPackHead;
begin
  Result.PID := OCCOMPROTOCAL_ERROR;
  CopyMemory(@Result, @FPackList_RB[FPackList_RB_Top], SizeOf(TOcComPackHead));
end;

function TOcComProtocal.GetLastPack(): POcComPack;
begin
  // CopyMemory(@Result, @FPackList_RB[FPackList_RB_Top], SizeOf(TOcComPack));
  Result := @FPackList_RB[FPackList_RB_Top];
end;

function TOcComProtocal.GetPackByIndex(i: Integer): TOcComPack;
begin
  Result := FPackList_RB[i];
end;

function TOcComProtocal.GetBytesValue(i: Integer): Int64;
var
  j: Integer;
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

function TOcComProtocal.CheckPackMinLength(bLength: Integer): Boolean;
begin
  Result := True;
  if bLength < (SizeOf(TOcComPackHead2)) then // 长度不够，小于最小包长度
    Result := false;
end;

function TOcComProtocal.CheckPackLength(p: POcComPack; bLength: Integer): Boolean;
// 这里描述是否继续等待
var
  PackSize: Integer;
begin
  Result := True;
  PackSize := SizeOf(TOcComPackHead) + p.Length + 2; // 包的实际有效长度
  if (bLength < PackSize) { 收到的数据不够 }
  then
  begin // 包描述的长度要小于等于最大允许的包长度
    Result := false; // 说明数据不全，继续等待数据
  end;
  if (bLength > OCCOMPROTOCAL_PACK_PACKPAYLOAD_MAX_LENGTH) { 包长是合法的,不能超过最大包长 } then
  begin
    Result := false;
  end;
end;

function CRC8(p: POcComPack): byte;
var
  pb: PByte;
  i: Integer;
begin
  pb := @p;
  Result := 0;
  for i := 0 to p.Length - 2 do
  begin
    // result := CalCRC8(data,result,GenPoly8); // 按位计算CRC
    Result := QuickCRC8(pb^, Result); // 快速查表计算CRC
  end;
end;

function TOcComProtocal.ParserPack(buff: PByte; Count: Integer): Integer;
var
  iByte: Integer; // 记录消费掉的字节个数
  p1: POcComPack;
  p2: POcComPack2;
  // pw: PByte;
begin
  iByte := 0;
  Result := 0; // 记录消费掉的字节个数

  while (True) do
  begin
    Result := iByte; // 记录消费掉的字节个数

    if (not CheckPackMinLength(Count - Result)) then
      break; // 退出需要更多数据

    p1 := @buff[iByte];
    p2 := @buff[iByte];

    if (p1^.Head = OCCOMPROTOCAL_HEAD) then // 对包头
    begin
      if (SizeOf(TOcComPackHead) + p1^.Length + 2) > (Count - iByte) then
      begin
        break; // 负载不全，等待更多数据
      end
      else if CheckPackCRC(p1, Count - iByte) then
      begin
        iByte := iByte + AddPackToPackList(p1);
        if Assigned(FCallBackFun) then
          FCallBackFun(GetLastPack());
        continue;
      end
      else
      begin
        INC(iByte); // 丢弃无效的数据包
      end;
    end
    else if (p2^.Head = OCCOMPROTOCAL_HEAD2) then // 对包头
    begin
      if p2^.Length > (Count - iByte) then
      begin
        break; // 负载不全，等待更多数据
      end
      else if CheckPackCRC(p2, Count - iByte) then
      begin
        iByte := iByte + AddPackToPackList(p2);
        if Assigned(FCallBackFun) then
          FCallBackFun(GetLastPack());
        continue;
      end
      else
      begin
        INC(iByte); // 丢弃无效的数据包
      end;
    end

    else
    begin
      INC(iByte); // 继续寻找，跳过的字节数
    end;
    // Result := iByte;//记录消费掉的字节个数
  end; // while

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

initialization

InitCRC8Tab($8C); // 先生成CRC8表(256项)，用于快速查表计算

finalization

end.
