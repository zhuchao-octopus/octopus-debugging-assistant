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
  OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT = 1024 * 4;

  OCCOMPROTOCAL_HEAD = $0101; // $55AA;
  OCCOMPROTOCAL_HEAD2 = $0AFF; // ��ͬ��ͷ�룬��ͬ���ݸ�ʽ
  // OCCOMPROTOCAL_HEAD2_BigEndian = $FF0A; //��˴洢
  OCCOMPROTOCAL_END = $7E; // $AA55;

  // һ������
  OCCOMPROTOCAL_DATA = $DA; // ��׼Э������ �������512�ֽ�
  // OCCOMPROTOCAL_DATA2 = $DB; // �Ǳ�׼Э���ʾ������������û�зְ�����˵ֻ��һ����
  OCCOMPROTOCAL_DATA_COMPLETE = $DC; // ���ݷ������
  OCCOMPROTOCAL_OVER = OCCOMPROTOCAL_DATA_COMPLETE; // ����������

  OCCOMPROTOCAL_REBOOT = $BB; // reboot
  OCCOMPROTOCAL_INBOOT = $B1; // start to boot loacd
  OCCOMPROTOCAL_INAPP = $BA; // start to app

  OCCOMPROTOCAL_START = $00; // ���ӣ�Ҫ��Է��ظ� ״̬�Ƿ��������
  OCCOMPROTOCAL_ACK = $01; // һ����Ӧ��Ҫ��Է���Ӧ��ǰ״̬
  OCCOMPROTOCAL_CONFIRM = $02; // ���ݰ�ȷ�ϱ���յ���� ,�����ڸ��ֽ�

  // ��������
  OCCOMPROTOCAL_FLASH_READ = $F0;
  OCCOMPROTOCAL_FLASH_WRITE = $F1;

  // OCCOMPROTOCAL_I2C_READ = 50;
  // OCCOMPROTOCAL_I2C_WRITE = 51;
  // OCCOMPROTOCAL_SPI_READ = 52;
  // OCCOMPROTOCAL_SPI_WRITE = 53;
  // OCCOMPROTOCAL_WIFI_READ = 54;
  // OCCOMPROTOCAL_WIFI_WRITE = 55;
  // OCCOMPROTOCAL_UART_READ = 56;
  // OCCOMPROTOCAL_UART_WRITE = 57;

  // OCCOMPROTOCAL_ERROR = $FFFF;
  // OCCOMPROTOCAL_NONE = $0000;


  // OCCOMPROTOCAL_WM_ACK = WM_APP + 100;

  OCCOMPROTOCAL_PACK_MAX_LENGTH = 512;
  OCCOMPROTOCAL_PACK_PACKPAYLOAD_MAX_LENGTH = OCCOMPROTOCAL_PACK_MAX_LENGTH - 7;

type

  POcComPack = ^TOcComPack;
  POcComPackHead2 = ^TOcComPackHead2;

  TOcComPack = packed record // 7+512 =519 //ʵ����������������ĳ��Ȳ�Ҫ����512����ҪԤ��CRC�ͽ�����
    Head: WORD; // ͷ��ʶ���� 2
    PID: WORD; // ��������  2
    Index: byte; // ��������  1
    Length: WORD; // ʵ�����ݳ���  2
    data: array [0 .. 511] of byte; // �����������
    // CRC: byte; // CRCУ��    2 //��䵽��Ч���صĺ���
    // EndFlag:byte; 1
  end;

  TOcComPackHead = packed record // ����ͷ��ʶ��
    Head: WORD; // ͷ��ʶ���� 2
    PID: WORD; // ��������  2
    Index: byte; // ��������  1
    Length: WORD; // ʵ�����ݳ���2
  end;

  // ����ͷ��ʶ�𣬼����������������ݰ�
  TOcComPackHead2 = packed record // ����ͷ��ʶ�𣬼����������������ݰ�
    Head: WORD; // ͷ��ʶ���� 2
    PID: WORD; // ��������  2 //����+�豸��ַ��һ���ֽ�
    Length: byte; // �����ܳ���  1
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

    function CreatePack(Id: WORD): TOcComPack; overload;
    function CreatePack(Head: WORD; Id: WORD): TOcComPack; overload;

    function AddPackToPackList(OcComPack: POcComPack): Integer; overload;
    function AddPackToPackList(OcComPack: POcComPackHead2; bLength: Integer): Integer; overload;

    function CheckPackCRC(p: POcComPack; bLength: Integer): Boolean; overload;
    function CheckPackCRC(p: POcComPackHead2; bLength: Integer): Boolean; overload;

    function WaitingForACK(OcComPack: TOcComPackHead; timeOut: Integer): Boolean; overload;
    // function WaitingForACK(OcComPack: TOcComPackHead2; timeOut: Integer): Boolean; overload;
    function WaitingForACK(ACK: Integer; timeOut: Integer): Boolean; overload;

    // function GetLastPackHead(): TOcComPackHead;
    function GetLastPack(): POcComPack;
    function GetNewPack(): POcComPack;

    function GetPackByIndex(i: Integer): TOcComPack;
    function GetBytesValue(i: Integer): Int64;
    procedure ClearPacks();
    function CheckPackMinLength(bLength: Integer): Boolean;
    function CheckPackLength(p: POcComPack; bLength: Integer): Boolean;
    procedure SetCRC8(pPOcComPack: POcComPack);
    procedure SetEndFlag(pPOcComPack: POcComPack);

    function ParserPack(buff: PByte; Count: Integer): Integer;
    function CheckHeadCount(buff: PByte; Count: Integer): Integer;
    function PackAppendInvalidData(pPOcComPack: POcComPack): Integer;

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

function TOcComProtocal.CreatePack(Id: WORD): TOcComPack;
var
  OcComPack: TOcComPack;
begin
  ZeroMemory(@OcComPack, SizeOf(TOcComPack));
  OcComPack.Head := OCCOMPROTOCAL_HEAD; // 2
  OcComPack.PID := Id; // 2
  OcComPack.Index := 0; // 1
  OcComPack.Length := 0; // û������      //2
  Result := OcComPack;
end;

function TOcComProtocal.CreatePack(Head: WORD; Id: WORD): TOcComPack;
var
  OcComPack: TOcComPack;
begin
  ZeroMemory(@OcComPack, SizeOf(TOcComPack));
  OcComPack.Head := Head; // 2
  OcComPack.PID := Id; // 2
  OcComPack.Index := 0; // 1
  OcComPack.Length := 0; // û������      //2
  Result := OcComPack;
end;

function TOcComProtocal.AddPackToPackList(OcComPack: POcComPack): Integer;
var
  PackSize: Integer;
begin
  PackSize := SizeOf(TOcComPackHead) + OcComPack.Length + 2; // ����ʵ����Ч����
  INC(FPackList_RB_Top);
  if FPackList_RB_Top > OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT then
    FPackList_RB_Top := 0; // Ring buffer
  CopyMemory(@FPackList_RB[FPackList_RB_Top], OcComPack, PackSize);
  INC(FPackList_RB_Count);
  Result := PackSize;
end;

function TOcComProtocal.AddPackToPackList(OcComPack: POcComPackHead2; bLength: Integer): Integer;
var
  PackSize: Integer;
  comPack: TOcComPack;
  pb: PByte;
begin
  // PackSize := OcComPack.Length; // ����ʵ����Ч����
  INC(FPackList_RB_Top);
  if FPackList_RB_Top > OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT then
    FPackList_RB_Top := 0; // Ring buffer

  comPack.Head := OcComPack.Head;
  comPack.PID := OcComPack.PID;
  comPack.Index := 0;
  comPack.Length := OcComPack.Length - 5 - 1; // ���صĳ��Ȳ�������CRC
  pb := PByte(OcComPack);
  CopyMemory(@comPack.data[0], pb + 5, comPack.Length + 1); // ������������ �� CRC

  PackSize := SizeOf(TOcComPackHead) + comPack.Length + 2 { У����+������� }; // ����ʵ���ܳ���
  CopyMemory(@FPackList_RB[FPackList_RB_Top], @comPack, PackSize);
  INC(FPackList_RB_Count);

  Result := OcComPack.Length;
end;

function TOcComProtocal.CheckPackCRC(p: POcComPack; bLength: Integer): Boolean;
// ���������������Ƿ�����Ƿ�Ҫ����
var
  CRC1: WORD; // CRC
  CRC2: WORD; // END_FLAG
  PackSize: Integer;
begin
  Result := false;
  if p.Head = OCCOMPROTOCAL_HEAD then
  begin
    // if ((p.Length + SizeOf(TOcComPackHead) + 3) > bLength) then
    // Exit; // ���ݲ�����

    CRC1 := p.data[p.Length]; // checksum
    CRC2 := p.data[p.Length + 1];
    if (CRC2 = OCCOMPROTOCAL_END) then
      Result := True;
  end;
end;

function TOcComProtocal.CheckPackCRC(p: POcComPackHead2; bLength: Integer): Boolean;
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
    // if (p.Length > bLength) then // p.Length Ϊ���ݰ����ܳ���
    // Exit; // ���ݲ�����

    CRC1 := (pb + (p.Length - 1))^;
    CRC2 := 0;
    for i := 0 to p.Length - 2 do
    begin
      CRC2 := QuickCRC8(pb^, CRC2); // ���ٲ�����CRC
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
      break; // ��ʱ�Ƴ�
    end;

    Oc := FPackList_RB[FPackList_RB_Top];
    if (Oc.Head = OcComPack.Head) and (Oc.PID = byte(OcComPack.PID)) and (Oc.Index = OcComPack.Index) { and (Oc.Total = OcComPack.Total) } and
      (Oc.Length = OcComPack.Length) then // ��ʾ������յ�
    begin
      Result := True;
      break;
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
      break; // ��ʱ�Ƴ�
    end;
    pOc := GetNewPack();
    // if (Oc.Head = OcComPack.Head) and (Oc.PID = byte(OcComPack.PID)) and (Oc.Length = OcComPack.Length) then // ��ʾ������յ�
    if pOc <> nil then
    begin
      if pOc.data[0] = ACK then // 0x59 89 Y
      begin
        Result := True;
        break;
      end;
    end;
    // Application.
  end;
end;

function TOcComProtocal.GetNewPack(): POcComPack;
begin
  Result := nil;
  if (FPackList_RB_NewIndex <> FPackList_RB_Top) then
  begin
    Result := GetLastPack();
    FPackList_RB_NewIndex := FPackList_RB_Top;
  end
end;

// function TOcComProtocal.GetLastPackHead(): TOcComPackHead;
// begin
// Result.PID := OCCOMPROTOCAL_ERROR;
// CopyMemory(@Result, @FPackList_RB[FPackList_RB_Top], SizeOf(TOcComPackHead));
// end;

function TOcComProtocal.GetLastPack(): POcComPack;
begin
  // CopyMemory(@Result, @FPackList_RB[FPackList_RB_Top], SizeOf(TOcComPack));
  // if(FPackList_RB_Top < 0) then Result:= nil;
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
  if bLength < (SizeOf(TOcComPackHead2)) then // ���Ȳ�����С����С������
    Result := false;
end;

function TOcComProtocal.CheckPackLength(p: POcComPack; bLength: Integer): Boolean;
// ���������Ƿ�����ȴ�
var
  PackSize: Integer;
begin
  Result := True;
  PackSize := SizeOf(TOcComPackHead) + p.Length + 2; // ����ʵ����Ч����
  if (bLength < PackSize) { �յ������ݲ��� }
  then
  begin // �������ĳ���ҪС�ڵ����������İ�����
    Result := false; // ˵�����ݲ�ȫ�������ȴ�����
  end;
  if (bLength > OCCOMPROTOCAL_PACK_PACKPAYLOAD_MAX_LENGTH) { �����ǺϷ���,���ܳ��������� } then
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
  for i := 0 to (SizeOf(TOcComPackHead) + p.Length - 1) do
  begin
    // result := CalCRC8(data,result,GenPoly8); // ��λ����CRC
    Result := QuickCRC8(pb^, Result); // ���ٲ�����CRC
    INC(pb);
  end;
end;

function TOcComProtocal.CheckHeadCount(buff: PByte; Count: Integer): Integer;
var
  iByte: Integer; // ��¼���ѵ����ֽڸ���
  p1: POcComPack;
  p2: POcComPackHead2;
begin
  { iByte := 0;
    Result := 0;
    if (Count < 2) then
    exit;
    p1 := @buff[iByte];
    p2 := @buff[iByte];
    if (p1^.Head = OCCOMPROTOCAL_HEAD) then // �԰�ͷ }
end;

function TOcComProtocal.ParserPack(buff: PByte; Count: Integer): Integer;
var
  iByte: Integer; // ��¼���ѵ����ֽڸ���
  p1: POcComPack;
  p2: POcComPackHead2;

  OcComPack: TOcComPack; // ��Ч�����ݴ����ʾ
  // OcComPack_Count: Integer;
begin
  iByte := 0;
  Result := 0; // ��¼���ѵ����ֽڸ���

  OcComPack.Head := 0;
  OcComPack.PID := 0;
  OcComPack.Length := 0;

  while (True) do
  begin
    Result := iByte; // ��¼���ѵ����ֽڸ���
    if (Count - iByte < 2) then
      break;

    p1 := @buff[iByte];
    p2 := @buff[iByte];

    if (p1^.Head = OCCOMPROTOCAL_HEAD) then // �԰�ͷ
    begin
      if (not CheckPackMinLength(Count - iByte)) then
        break // ͷ�벻ȫ����Ҫ��������
      else if (SizeOf(TOcComPackHead) + p1^.Length + 2) > (Count - iByte) then
        break // ���ز�ȫ,��Ҫ��������
      else if CheckPackCRC(p1, Count - iByte) then
      begin
        iByte := iByte + AddPackToPackList(p1);
        if Assigned(FCallBackFun) then
          FCallBackFun(GetLastPack());
        continue;
      end
      else
      begin
        INC(iByte); // ������Ч�����ݰ�
      end;
    end
    else if (p2^.Head = OCCOMPROTOCAL_HEAD2) then // �԰�ͷ
    begin
      if (not CheckPackMinLength(Count - iByte)) then
        break // ͷ�벻ȫ����Ҫ��������
      else if p2^.Length > (Count - iByte) then
        break // ���ز�ȫ����Ҫ��������
      else if CheckPackCRC(p2, Count - iByte) then
      begin
        iByte := iByte + AddPackToPackList(p2, Count - iByte);
        if Assigned(FCallBackFun) then
          FCallBackFun(GetLastPack());
        continue;
      end
      else
      begin
        INC(iByte); // ������Ч�����ݰ�
      end;
    end

    else
    begin
      OcComPack.data[OcComPack.Length] := buff[iByte];
      OcComPack.Length := OcComPack.Length + 1;
      INC(iByte); // ����Ѱ�ң��������ֽ���  //��¼���ѵ����ֽڸ���
    end;

  end; // while

  // ����пռ���������ݼӵ���һ������β��
  // if(OcComPack.Length > 0) then
  // PackAppendInvalidData(@OcComPack);
  if Assigned(FCallBackFun) and (OcComPack.Length > 0) then
  begin
    FCallBackFun(@OcComPack); // ��ӡ��������
  end;
  OcComPack.Length := 0;
end;

function TOcComProtocal.PackAppendInvalidData(pPOcComPack: POcComPack): Integer;
var
  p: POcComPack;
begin
  Result := 0;
  p := GetLastPack();
  if p = nil then
    exit;
  if p.Head = 0 then
    exit;

  if (p.Length + pPOcComPack.Length) > OCCOMPROTOCAL_PACK_PACKPAYLOAD_MAX_LENGTH then
    exit; // û�пռ���

  CopyMemory(@p.data[p.Length + 2], pPOcComPack, pPOcComPack.Length);
  pPOcComPack.Length := 0;
  Result := p.Length;
end;

procedure TOcComProtocal.SetCRC8(pPOcComPack: POcComPack);
var
  CRC: byte;
  // i: Integer;
begin;
  CRC := CRC8(pPOcComPack); // ���ٲ�����CRC
  // i :=  pPOcComPack.Length;
  // if i > SizeOf(TOcComPack) then
  pPOcComPack.data[pPOcComPack.Length] := CRC;
end;

procedure TOcComProtocal.SetEndFlag(pPOcComPack: POcComPack);
var
  CRC: byte;
  // i: Integer;
begin;
  // i := SizeOf(TOcComPackHead) + pPOcComPack.Length + 1;
  pPOcComPack.data[pPOcComPack.Length + 1] := OCCOMPROTOCAL_END;
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

InitCRC8Tab($8C); // ������CRC8��(256��)�����ڿ��ٲ�����

finalization

end.
