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
  CRC,
  System.SyncObjs,
  System.Generics.Collections,
  OctopusFrameQueue;

/// /////////////////////////////////////////////////////////////////////////////
// type OCCOMPROTOCAL_STATUS=();

type

  TPTLStatus = (MCU_UPDATE_STATE_IDLE, MCU_UPDATE_STATE_CHECK, MCU_UPDATE_STATE_INIT, MCU_UPDATE_STATE_ERASE, MCU_UPDATE_STATE_RECEIVING,
    MCU_UPDATE_STATE_UPDATING, MCU_UPDATE_STATE_COMPLETE, MCU_UPDATE_STATE_EXIT, MCU_UPDATE_STATE_ERROR);

  // ģ������
  TPTLFrameType = (
    // MCU -> SOC Module IDs
    MCU_TO_SOC_MOD_SYSTEM = $00, // System initialization
    MCU_TO_SOC_MOD_UPDATE = $01, // System update
    MCU_TO_SOC_MOD_TRANSFER = $02, // Data transfer
    MCU_TO_SOC_MOD_CARINFOR = $03, // IPC carinfor
    MCU_TO_SOC_MOD_SETUP = $04, // Settings
    MCU_TO_SOC_MOD_KEY = $05, // KEY
    MCU_TO_SOC_MOD_CAN = $06, // CAN
    MCU_TO_SOC_MOD_IPC = $07, // IPC socket

    // SOC -> MCU Module IDs
    SOC_TO_MCU_MOD_SYSTEM = $80, // System initialization
    SOC_TO_MCU_MOD_UPDATE = $81, // System update
    SOC_TO_MCU_MOD_TRANSFER = $82, // Data transfer
    SOC_TO_MCU_MOD_CARINFOR = $83, // IPC carinfor
    SOC_TO_MCU_MOD_SETUP = $84, // Settings
    SOC_TO_MCU_MOD_KEY = $85, // KEY
    SOC_TO_MCU_MOD_CAN = $86, // CAN
    SOC_TO_MCU_MOD_IPC = $87 // IPC socket
    );

  TPTLFrameCmd = (
    /// MOD_SYSTEM commands
    FRAME_CMD_SYSTEM_HANDSHAKE = $00, ///< System handshake
    FRAME_CMD_SYSTEM_ACC_STATE = $01, ///< ACC state
    FRAME_CMD_SYSTEM_APP_STATE = $02, ///< Application state
    FRAME_CMD_SYSTEM_POWER_ON = $03,  ///< Power on
    FRAME_CMD_SYSTEM_POWER_OFF = $04, ///< Power off
    FRAME_CMD_SYSTEM_SAVE_DATA = $05, ///< Power off

    // MOD_UPDATE commands
    FRAME_CMD_UPDATE_CHECK_FW_STATE = $06,  ///< Check firmware state
    FRAME_CMD_UPDATE_FW_STATE = $07, ///< Update firmware state
    FRAME_CMD_UPDATE_ENTER_FW_UPGRADE_MODE = $08, ///< Enter firmware update mode
    FRAME_CMD_UPDATE_EXITS_FW_UPGRADE_MODE = $09,  ///< Exit firmware update mode
    FRAME_CMD_UPDATE_REQUEST_FW_DATA = $0A,    ///< Send firmware data
    FRAME_CMD_UPDATE_SEND_FW_DATA = $0B,    ///< Send firmware data
    FRAME_CMD_UPDATE_REBOOT = $0C,          ///< Reboot system

    // MOD_TRANSFER commands
    FRAME_CMD_TRANSFER_A2M = $0D, ///< A2M data transfer
    FRAME_CMD_TRANSFER_M2A = $0E, ///< M2A data transfer

    // MOD_METER commands
    FRAME_CMD_METER_RPM_SPEED = $0F,    ///< RPM and speed
    FRAME_CMD_METER_FUEL_TEMPTER = $10, ///< Fuel and temperature
    FRAME_CMD_METER_SOC = $11,          ///< State of charge (SOC)

    // MOD_INDICATOR commands
    FRAME_CMD_CARINFOR_INDICATOR = $12, ///< Indicator status
    FRAME_CMD_CARINFOR_METER = $13,     ///< Indicator status
    FRAME_CMD_CARINFOR_BATTERY = $14,
    FRAME_CMD_CARINFOR_ERROR = $15, ///< Error information

    // MOD_DRIV_INFO commands
    FRAME_CMD_DRIVINFO_ODO = $16,             ///< Odometer data
    FRAME_CMD_DRIVINFO_DRIV_DATA = $17,       ///< Driving data
    FRAME_CMD_DRIVINFO_GEAR = $18,            ///< Gear information
    FRAME_CMD_DRIVINFO_NAVI = $19,            ///< Navigation data
    FRAME_CMD_DRIVINFO_DRIV_DATA_CLEAR = $1A, ///< Clear driving data

    // MOD_SETUP commands
    FRAME_CMD_SETUP_UPDATE_TIME = $1B, ///< Update time
    FRAME_CMD_SETUP_SET_TIME = $1C,    ///< Set time
    FRAME_CMD_SETUP_KEY = $1D,         ///< Key input

    FRAME_CMD_CAR_SET_LIGHT = $1E,
    FRAME_CMD_CAR_SET_GEAR_LEVEL = $1F,

    FRAME_CMD_CARINFOR_MAX = $64
    );

  // Define a structure for the UART frame
  TOctopusUARTFrame = record
    Header: byte; // Frame header identifier
    FrameType: TPTLFrameType; // Type of the frame (Command, Data, etc.)
    Command: TPTLFrameCmd; // Specific command identifier
    DataLength: byte; // Length of the data segment
    HeaderChecksum: byte; // Checksum for header validation
    data: array [0 .. 254] of byte; // Data segment (max 255 bytes frame size)
    DataChecksum: byte; // Checksum for data validation
  end;

  TPOctopusUARTFrame = ^TOctopusUARTFrame;

  TCallBackFun = Procedure(POctopusUARTFrame: TPOctopusUARTFrame) of object;

  TOctopusUartProtocol = class
  private
    FCallBackFun: TCallBackFun;
    FFrameQueue: TOctopusFrameQueue; // ���д洢����������֡
    FQueueLock: TCriticalSection; // �̰߳�ȫ��
  public

    Constructor Create();
    destructor Destroy;
    property CallBackFun: TCallBackFun read FCallBackFun write FCallBackFun;
    function GetFrameCmdDescription(ACommand: byte): string;

    function WaitingForACK(OcComPack: TOctopusUARTFrame; timeOut: Integer): Boolean; overload;
    // function WaitingForACK(OcComPack: TOcComPackHead2; timeOut: Integer): Boolean; overload;
    function WaitingForACK(ACK: Integer; timeOut: Integer): Boolean; overload;

    function GetProtocolHeaderSize: Integer;
    // Function to build the frame structure
    function BuildUARTFrame(AHeader: byte; AFrameType: TPTLFrameType; ACommand: TPTLFrameCmd; AData: array of byte; ALength: Integer)
      : TOctopusUARTFrame; overload;
    function BuildUARTFrame(AFrameType: TPTLFrameType; ACommand: TPTLFrameCmd; AData: array of byte; ALength: Integer): TOctopusUARTFrame; overload;

    function SerializeUARTFrame(Frame: TOctopusUARTFrame): TBytes;
    function ParserUartFrame(buff: PByte; Count: Integer): Integer;
    function PopParsedFrame(out Frame: TOctopusUARTFrame): Boolean;
    function PeekParsedFrame(out Frame: TOctopusUARTFrame): Boolean;
    function PeekLastParsedFrame(out Frame: TOctopusUARTFrame): Boolean;
    function FrameToHexString(PFrame: TPOctopusUARTFrame): string;
    function GetFrameCount: Integer;

    procedure ProcessParsedFrame(Frame: PByte; FrameLen: Integer);
    procedure ClearFrame();
  end;

const
  OCTOPUS_UART_PROTOCAL_HEAD = $AA;

implementation

Constructor TOctopusUartProtocol.Create();
begin
  FFrameQueue := TOctopusFrameQueue.Create;
  FQueueLock := TCriticalSection.Create;
end;

Destructor TOctopusUartProtocol.Destroy;
begin
  FFrameQueue.Free;
  FQueueLock.Free;
end;

function TOctopusUartProtocol.GetFrameCmdDescription(ACommand: byte): string;
begin
    Result := 'Unknown Command';
end;

function TOctopusUartProtocol.WaitingForACK(OcComPack: TOctopusUARTFrame; timeOut: Integer): Boolean;
var
  Oc: TOctopusUARTFrame;
  Start: real;
  peekret: Boolean;
begin
  Result := false;
  Start := GetTickCount;
  while (True) do
  begin
    if (GetTickCount - Start) > timeOut then
    begin
      break; // ��ʱ�Ƴ�
    end;

    peekret := PeekParsedFrame(Oc);
    if not peekret then
      Exit;

    if (Oc.Header = OcComPack.Header) and (Ord(Oc.FrameType) = Ord(OcComPack.FrameType)) and (Oc.Command = OcComPack.Command) and
      (Oc.DataLength = OcComPack.DataLength) then
    begin
      Result := True;
      break;
    end;
  end;
end;

function TOctopusUartProtocol.WaitingForACK(ACK: Integer; timeOut: Integer): Boolean;
var
  Oc: TOctopusUARTFrame;
  Start: real;
  peekret: Boolean;
begin
  Result := false;
  Start := GetTickCount;
  while (True) do
  begin
    if (GetTickCount - Start) > timeOut then
    begin
      break; // ��ʱ�Ƴ�
    end;

    peekret := PeekParsedFrame(Oc);
    if not peekret then
      Exit;

    if Oc.data[0] = ACK then // 0x59 89 Y
    begin
      Result := True;
      break;
    end;

    // Application.
  end;
end;

/// //////////////////////////////////////////////////////////////////////////////////////////////////////////
// Helper function to calculate checksum
function CalculateChecksum(Buffer: array of byte; Length: Integer): byte;
var
  i: Integer;
  Sum: byte;
begin
  Sum := 0;
  for i := 0 to Length - 1 do
    Sum := Sum + Buffer[i];
  Result := byte(not Sum + 1);
end;

function CalculateChecksum_2(Buffer: PByte; Length: Integer): byte;
var
  i: Integer;
  Sum: Word;
begin
  Sum := 0;
  for i := 0 to Length - 1 do
    Sum := Sum + Buffer[i];

  Result := byte(not Sum + 1);
  // Result := byte(-Sum and $FF);
end;

function TOctopusUartProtocol.GetProtocolHeaderSize: Integer;
begin

  // [ Header ][ Frame Type ][ Command ][ Data Length ][ Header Checksum ]
  // Э��ͷ���Ĺ̶���С
  Result := 5;
end;

// Function to build the frame structure
function TOctopusUartProtocol.BuildUARTFrame(AHeader: byte; AFrameType: TPTLFrameType; ACommand: TPTLFrameCmd; AData: array of byte; ALength: Integer)
  : TOctopusUARTFrame;
var
  Frame: TOctopusUARTFrame;
  i: Integer;
  ChecksumArray: array of byte;
begin
  // ��ʼ�� Frame ͷ��
  Frame.Header := AHeader;
  Frame.FrameType := AFrameType;
  Frame.Command := ACommand;
  Frame.DataLength := ALength;

  // ֱ��������ݶ�
  if ALength > 0 then
    Move(AData[0], Frame.data[0], ALength);

  // ���� Header У���
  SetLength(ChecksumArray, 4);
  ChecksumArray[0] := AHeader;
  ChecksumArray[1] := byte(AFrameType);
  ChecksumArray[2] := byte(ACommand);
  ChecksumArray[3] := Frame.DataLength;
  Frame.HeaderChecksum := CalculateChecksum(ChecksumArray, Length(ChecksumArray));

  // �������ݶ�У��ͣ������� DataLength ����HEARD CRC
  SetLength(ChecksumArray, ALength + 1);
  ChecksumArray[0] := Frame.DataLength;
  ChecksumArray[0] := Frame.HeaderChecksum;
  // �������ݵ�У������
  if ALength > 0 then
    Move(AData[0], ChecksumArray[1], ALength);

  // �������յ�����У���
  Frame.DataChecksum := CalculateChecksum(ChecksumArray, Length(ChecksumArray));

  // ���ع����õ� Frame
  Result := Frame;
end;

function TOctopusUartProtocol.BuildUARTFrame(AFrameType: TPTLFrameType; ACommand: TPTLFrameCmd; AData: array of byte; ALength: Integer): TOctopusUARTFrame;
begin
  Result := BuildUARTFrame(OCTOPUS_UART_PROTOCAL_HEAD, AFrameType, ACommand, AData, ALength);
end;

// Function to serialize the frame into a byte stream for UART transmission
function TOctopusUartProtocol.SerializeUARTFrame(Frame: TOctopusUARTFrame): TBytes;
var
  i: Integer;
begin
  SetLength(Result, 5 + Frame.DataLength + 1);
  Result[0] := Frame.Header;
  Result[1] := Ord(Frame.FrameType);
  Result[2] := Ord(Frame.Command);
  Result[3] := Frame.DataLength;
  Result[4] := Frame.HeaderChecksum;

  for i := 0 to Frame.DataLength - 1 do
    Result[5 + i] := Frame.data[i];

  Result[5 + Frame.DataLength] := Frame.DataChecksum;
end;

function TOctopusUartProtocol.ParserUartFrame(buff: PByte; Count: Integer): Integer;
var
  i, FrameLen, DataLen: Integer;
  FrameType, Command, HeaderChecksum, DataChecksum: byte;
  // Address: DWord;
begin
  Result := 0; // ��ʼ�����ѵ����ֽ���
  i := 0;

  while (i < Count) do
  begin
    // 1. ����֡ͷ
    if (buff[i] = $55) or (buff[i] = $AA) then
    begin
      // 2. ���ʣ�������Ƿ��㹻��ȡͷ����Ϣ
      if (Count - i) < GetProtocolHeaderSize() + 1 then
        break;

      // 3. ��ȡͷ����Ϣ
      FrameType := buff[i + 1];
      Command := buff[i + 2];
      DataLen := buff[i + 3];
      HeaderChecksum := buff[i + 4];

      // 4. ����֡�ܳ��� (Header + Data + DataChecksum)
      FrameLen := GetProtocolHeaderSize() + DataLen + 1;

      // 5. ����Ƿ����㹻����������������֡
      if (Count - i) < FrameLen then
        break;

      // 6. У�� HeaderChecksum
      if CalculateChecksum_2(@buff[i], GetProtocolHeaderSize() - 1) <> HeaderChecksum then
      begin
        Inc(i); // У��ʧ�ܣ��������ֽ�
        Continue;
      end;

      // 7. У�� DataChecksum
      DataChecksum := buff[i + GetProtocolHeaderSize() + DataLen];
      if CalculateChecksum_2(@buff[i + 4], DataLen + 1) <> DataChecksum then
      begin
        Inc(i); // У��ʧ�ܣ��������ֽ�
        Continue;
      end;

      // 8. ��ȡ Data ����
      // ����ǰ4�ֽ��ǵ�ַ��֮������Ч����
      // Address := (buff[i + 5] shl 24) or (buff[i + 6] shl 16) or (buff[i + 7] shl 8) or buff[i + 8];
      ProcessParsedFrame(@buff[i], FrameLen);

      // 9. �ۼ������ѵ��ֽ���
      Inc(Result, FrameLen);

      // 10. ���� i ָ�룬�����Ѵ����֡
      Inc(i, FrameLen);
    end
    else
    begin
      Inc(i);
      Inc(Result); // ��֡ͷ���ֽ�Ҳ����������
    end;
  end;
end;

function TOctopusUartProtocol.PopParsedFrame(out Frame: TOctopusUARTFrame): Boolean;
var
  TempFrame: TArray<byte>;
begin
  Result := false;

  // 1. �̰߳�ȫ�شӶ�����ȡ������
  FQueueLock.Acquire;
  try
    if FFrameQueue.Count > 0 then
    begin

      if (FFrameQueue.Dequeue(TempFrame)) then // ��ȡ�����е��ֽ�����
      begin
        // 2. ���ֽ��������Ϊ TOctopusUARTFrame
        Frame.Header := TempFrame[0];
        Frame.FrameType := TPTLFrameType(TempFrame[1]);
        Frame.Command := TPTLFrameCmd(TempFrame[2]);
        Frame.DataLength := TempFrame[3];
        Frame.HeaderChecksum := TempFrame[4];
        Move(TempFrame[5], Frame.data[0], Frame.DataLength);
        Frame.DataChecksum := TempFrame[5 + Frame.DataLength];
        Result := True;
      end;
    end;
  finally
    FQueueLock.Release;
  end;
end;

function TOctopusUartProtocol.PeekParsedFrame(out Frame: TOctopusUARTFrame): Boolean;
var
  TempFrame: TArray<byte>;
begin
  Result := false;
  // 1. �̰߳�ȫ�ط��ʶ���
  FQueueLock.Acquire;
  try
    if FFrameQueue.Count > 0 then
    begin
      // Peek ������ֻ�Ƕ�ȡ����ɾ��
      if FFrameQueue.Peek(TempFrame) then
      begin
        // 2. ���ֽ��������Ϊ TOctopusUARTFrame
        Frame.Header := TempFrame[0];
        Frame.FrameType := TPTLFrameType(TempFrame[1]);
        Frame.Command := TPTLFrameCmd(TempFrame[2]);
        Frame.DataLength := TempFrame[3];
        Frame.HeaderChecksum := TempFrame[4];

        // 3. ���� Data ����
        if Frame.DataLength > 0 then
          Move(TempFrame[5], Frame.data[0], Frame.DataLength);

        // 4. ��ȡ DataChecksum
        Frame.DataChecksum := TempFrame[5 + Frame.DataLength];
        Result := True;
      end;
    end;
  finally
    FQueueLock.Release;
  end;
end;

function TOctopusUartProtocol.PeekLastParsedFrame(out Frame: TOctopusUARTFrame): Boolean;
var
  TempFrame: TArray<byte>;
begin
  Result := false;
  // 1. �̰߳�ȫ�ط��ʶ���
  FQueueLock.Acquire;
  try
    if FFrameQueue.Count > 0 then
    begin
      // Peek ������ֻ�Ƕ�ȡ����ɾ��
      if FFrameQueue.PeekLast(TempFrame) then
      begin
        // 2. ���ֽ��������Ϊ TOctopusUARTFrame
        Frame.Header := TempFrame[0];
        Frame.FrameType := TPTLFrameType(TempFrame[1]);
        Frame.Command := TPTLFrameCmd(TempFrame[2]);
        Frame.DataLength := TempFrame[3];
        Frame.HeaderChecksum := TempFrame[4];

        // 3. ���� Data ����
        if Frame.DataLength > 0 then
          Move(TempFrame[5], Frame.data[0], Frame.DataLength);

        // 4. ��ȡ DataChecksum
        Frame.DataChecksum := TempFrame[5 + Frame.DataLength];
        Result := True;
      end;
    end;
  finally
    FQueueLock.Release;
  end;
end;

procedure TOctopusUartProtocol.ProcessParsedFrame(Frame: PByte; FrameLen: Integer);
var
  FrameData: TBytes;
  OctopusUARTFrame: TOctopusUARTFrame;
begin
  // 1. �������������
  if (Frame = nil) or (FrameLen < GetProtocolHeaderSize()) then
    Exit;

  SetLength(FrameData, FrameLen);
  CopyMemory(@FrameData[0], Frame, FrameLen);

  if FrameLen < GetProtocolHeaderSize() + FrameData[3] + 1 then
    Exit;

  // 2. ��ʼ���ṹ��
  FillChar(OctopusUARTFrame, SizeOf(OctopusUARTFrame), 0);
  OctopusUARTFrame.Header := FrameData[0];
  OctopusUARTFrame.FrameType := TPTLFrameType(FrameData[1]);
  OctopusUARTFrame.Command := TPTLFrameCmd(FrameData[2]);
  OctopusUARTFrame.DataLength := FrameData[3];
  OctopusUARTFrame.HeaderChecksum := FrameData[4];

  if OctopusUARTFrame.DataLength > 0 then
    CopyMemory(@OctopusUARTFrame.data[0], @FrameData[5], OctopusUARTFrame.DataLength);

  OctopusUARTFrame.DataChecksum := FrameData[5 + OctopusUARTFrame.DataLength];

  if Assigned(FCallBackFun) then
    FCallBackFun(@OctopusUARTFrame);

  // 3. �̰߳�ȫ���
  FQueueLock.Acquire;
  try
    FFrameQueue.Enqueue(FrameData);
  finally
    FQueueLock.Release;
  end;
end;

function TOctopusUartProtocol.FrameToHexString(PFrame: TPOctopusUARTFrame): string;
var
  FrameBytes: TBytes;
  i: Integer;
  HexBuilder: TStringBuilder;
begin
  // 1. ���л�֡����
  FrameBytes := SerializeUARTFrame(PFrame^);

  // 2. ʹ�� TStringBuilder ����ʮ�������ַ�����Ч�ʸ���
  HexBuilder := TStringBuilder.Create;
  try
    for i := 0 to High(FrameBytes) do
    begin
      HexBuilder.AppendFormat('%2.2x ', [FrameBytes[i]]);
    end;

    // 3. ȥ��ĩβ����ո񲢷��ؽ��
    Result := Trim(HexBuilder.ToString);
  finally
    HexBuilder.Free;
  end;
end;

function TOctopusUartProtocol.GetFrameCount: Integer;
begin
  FQueueLock.Acquire;
  try
    Result := FFrameQueue.Count;
  finally
    FQueueLock.Release;
  end;
end;

procedure TOctopusUartProtocol.ClearFrame();
begin

  // 2. �̰߳�ȫ�ؽ��ֽ�������ӵ�����
  FQueueLock.Acquire;
  try
    FFrameQueue.Clear; // ���ֽ�����������
  finally
    FQueueLock.Release;
  end;
end;

initialization

InitCRC8Tab($8C); // ������CRC8��(256��)�����ڿ��ٲ�����

finalization

end.
