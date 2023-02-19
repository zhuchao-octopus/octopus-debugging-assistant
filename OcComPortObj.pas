unit OcComPortObj;

interface

uses
  Vcl.StdCtrls,
  Vcl.forms,
  Vcl.Controls,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Actions,
  CPort,
  OcProtocol,
  VCLTee.Series,
  RegularExpressions;

type
  TRECEIVE_FORMAT = (ASCIIFormat, HexadecimalFormat, Graphic, OctopusProtocol, SaveToFile);
  TSEND_FORMAT = (S_ASCIIFormat, S_HexadecimalFormat, S_OctopusProtocol);

const
  INPUT_OUTPUT_BUFFER_SIZE = 2097152; // 1048576;

const
  COM_PROTOCOL_KEEP_MAX_BUFFER_SIZE = 524288; // 1048576;

const
  OCTOPUS_BACKGROUD_STRING_TRIGGERLINE = 80;

const
  SEND_FLAG = '-> ';

const
  RECEIVE_FORMAT_String: array [TRECEIVE_FORMAT] of string =
   ('ASCII Format            字符串 ',
    'Hexadecimal Format 十六进制 ',
    'Graphic                   图形 ',
    'Octopus Protocol     协议 ',
    'File                          文件 ');

  MAX_BAUDRATE_INDEX: integer = 15;

type
  TCallBackFun = Procedure(Count: integer = 0) of object;
  TProtocolCallBackFun = Procedure(TypeID: integer) of object;

  TOcComPortObjPara = packed record
    ComportFullName: String;
    Port: String; // change com port;
    BaudRate: integer;
    DataBits: integer;
    StopBits: integer;
    ParityBits: integer;
    FlowControl: integer;
    ReceiveFormat: integer;
    SendFormat: integer;
    LogMemo: TMemo; // j
    ShowDate: Boolean;
    ShowTime: Boolean;
    ShowLineNumber: Boolean;
    ShowSendedLog: Boolean;
    HexModeWithString: Boolean; // o
  end;

  // thread for background monitoring of port events
type
  TComUIHandleThread = class;
  TComPackParserHandleThread = class;

  TOcComPortObj = class(TComport)
  private
    FOcComPortObjPara: TOcComPortObjPara;
    // Port: String; // change com port;
    // BaudRate: Integer;
    // DataBits: Integer;
    // StopBits: Integer;
    // ParityBits: Integer;
    // FlowControl: Integer;
    FSendFormat: integer; // h
    FReceiveFormat: integer; // i
    FLogMemo: TMemo; // j
    FShowDate: Boolean;
    FShowTime: Boolean;
    FShowLineNumber: Boolean;
    FShowSendingLog: Boolean;
    FHexModeWithString: Boolean; // o
    FHexModeFormatCount: integer;
    FBaudRateIndex:Integer;

    FComReceiveBuffer: array [0 .. INPUT_OUTPUT_BUFFER_SIZE] of Byte;
    // 1024 * 1024 =  1048576 =1M // for com port receive buffer
    FComReceiveInternalBuffer: array of Byte; // for 异步处理
    FFastLineSeries: TFastLineSeries;

    FComReceiveString: String;
    FStringInternalMemo: TMemo;
    FComUIHandleThread: TComUIHandleThread; // 异步线程
    FBackGroundProcessRecordCount: integer;
    FComHandleThread_Wait: Boolean; // 同步变量
    FComPackParserThread: TComPackParserHandleThread;
    FProtocalData: integer;
    FNeedCRC16: Boolean;
    FComReceiveCount: Int64;
    FComProcessedCount: Int64;
    FComSentCount: Int64;
    FCallBackFun: TCallBackFun;
    FProtocolCallBackFun: TProtocolCallBackFun;
    FComportFullName: String;
    FullLogFileName: String;
    FFileStream: TFileStream;
    FFileStreamName: String;
    FOcComProtocal: TOcComProtocal;
    FCompatibleUnicode: Boolean;
    FExcelAppRows: Int64;

    FCommadLineStr: String;
    FPreCommadLineStr: String;
    FLastLineStr: String;
    FCommandHistory: TStringList;
    FCommandHistoryIndex: integer;
    FNeedNewLine: Boolean;
    FLogScrollMode: Boolean;
    procedure OcComPortObjRxChar(Sender: TObject; Count: integer);
    procedure OcComPortObjRxProtocol(OcComPack: POcComPack);
    function GetLineNumberDateTimeStamp(N: Int64): String;
    function SaveToTheExcelFile(Length: integer; Rows: integer): integer;
    procedure KeyPress(Sender: TObject; var Key: Char);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure RunWindosShellCmd(str: string);
    function GetConfiguration(): TOcComPortObjPara;
  public
    ExcelApp: Variant;

    Constructor Create(AOwner: TComponent; DeviceName: String);
    destructor Destroy; override;
    // procedure OcComPortObjInit(OcComPortObjPara: TOcComPortObjPara);
    procedure OcComPortObjInit2(a, b: String; c, d, e, f, g, h, i: integer; j: TMemo; k, l, m, N, o: Boolean);
    procedure ClearInternalBuff(id: integer = 100);

    function getCMDStr(): String;
    procedure SaveLog(FullLogFilePath: String);
    procedure Log(const Msg: string);
    procedure LogBuff(flag: String; const Buff: Array of Byte; Count: integer);
    procedure ClearLog();

    function IsLogBottom(): Boolean;
    procedure LogBottomMod(const Msg: string; appendMod: Boolean; bottomMod: Boolean);

    property OcComPortObjPara: TOcComPortObjPara read GetConfiguration write FOcComPortObjPara;
    property LogMemo: TMemo read FLogMemo write FLogMemo;
    property StringInternalMemo: TMemo read FStringInternalMemo write FStringInternalMemo;
    property CallBackFun: TCallBackFun read FCallBackFun write FCallBackFun;
    property ProtocolCallBackFun: TProtocolCallBackFun read FProtocolCallBackFun write FProtocolCallBackFun;
    property ComReceiveCount: Int64 read FComReceiveCount;
    property ComProcessedCount: Int64 read FComProcessedCount;
    property ComSentCount: Int64 read FComSentCount;
    property ComHandleThread_AsynCount: integer read FBackGroundProcessRecordCount write FBackGroundProcessRecordCount default OCTOPUS_BACKGROUD_STRING_TRIGGERLINE;
    property HexModeFormatCount: integer read FHexModeFormatCount write FHexModeFormatCount default 16;
    property FileStream: TFileStream read FFileStream write FFileStream default nil;
    property FileStreamName: String read FFileStreamName write FFileStreamName;
    property ProtocalData: integer read FProtocalData write FProtocalData default -1;
    property FastLineSeries: TFastLineSeries read FFastLineSeries write FFastLineSeries;

    property ReceiveFormat: integer read FReceiveFormat write FReceiveFormat;
    property SendFormat: integer read FSendFormat write FSendFormat default 0;

    property CompatibleUnicode: Boolean read FCompatibleUnicode write FCompatibleUnicode default True;
    property NeedCRC16: Boolean read FNeedCRC16 write FNeedCRC16 default false;
    property ShowSendedLog: Boolean read FShowSendingLog write FShowSendingLog;
    property ShowLineNumber: Boolean read FShowLineNumber write FShowLineNumber;
    property LogScrollMode: Boolean read FLogScrollMode write FLogScrollMode default True;
    property BaudRateIndex: Integer read FBaudRateIndex write FBaudRateIndex;

    property CommadLineStr: String read FCommadLineStr write FCommadLineStr;

    function FalconComSendBuffer(const Buffer: array of Byte; Count: integer): Bool;
    // function FalconComSendBufferWaitACK(Buffer: array of Byte; Count: Integer): Bool;
    function FalconComSendData_Common(str: string; SendFormat: integer): Bool;
    function FalconComSendData_Terminal(str: string; SendFormat: integer): Bool;
    function FalconComSendData_MultiTimes(str: string; SendFormat: integer): Bool;

    procedure SendProtocolACK(); // 发送ACK
    function WaitProtocolACK(ACK: integer; timeOut: integer): Boolean;
    function WaitProtocolACK2(ACKBuffer: array of Byte; bCount: integer; timeOut: integer): Boolean;

    function SendProtocolData(TypeID: Word; const Buffer: Array Of Byte; Count: integer; NeedACK: Boolean): Boolean; overload;
    function SendProtocolData(Head: Word; TypeID: Word; const Buffer: Array Of Byte; Count: integer; NeedACK: Boolean): Boolean; overload;
    function SendProtocolPackage(pPOcComPack: POcComPack): Boolean; overload;
    // function SendProtocolPackage(pPOcComPack: POcComPack2): Boolean; overload;
    function SendProtocolPackageWaitACK(pPOcComPack: POcComPack; ACK: integer): Boolean;

    function GetPacks(): integer;
    procedure PrintReceivedProtocolData(Index: integer);
    procedure PrintProtocolPack(flag: String; OcComPack: POcComPack);
    procedure RequestProtocolConnection(); // 发送连接请求

  end;

  TComUIHandleThread = class(TThread)
  private
    FOcComPortObj: TOcComPortObj;
    FUIStartIndex: Int64;
    FNeedToReset: integer;
    // FThreadSync_BusyFlag:Boolean;
  protected
    constructor Create(OcComPortObj: TOcComPortObj);
    procedure Execute; override;
  public
    property ResetID: integer read FNeedToReset write FNeedToReset default -1;
  end;

  TComPackParserHandleThread = class(TThread)
  private
    FOcComPortObj: TOcComPortObj;
    FOcComProtocal: TOcComProtocal;
    FStartIndex: Int64;
  protected
    constructor Create(OcComPortObj: TOcComPortObj; OcComProtocal: TOcComProtocal);
    procedure Execute; override;
    // procedure RequestConnection();
    // procedure SendPackData()
  public
    procedure StopReSetClear();
  end;

var
  Critical: TRTLCriticalSection;
  CmdDir: String;

implementation

uses Unit200;

function readFileToStream(FileName: String): TFileStream;
var
  FileStream: TFileStream;
begin
  Result := nil;
  try
    FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareExclusive);
    FileStream.Position := 0;
    Result := FileStream;
  except
  end;
end;

function writeFileToStream(FileStream: TFileStream; Buffer: array of Byte; Len: integer): integer;
begin
  try
    Result := FileStream.Write(Buffer, Len);
  except
  end;
end;

function FalconGetComPort(str: string): string;
const
  pattern = 'COM +d';
var
  ss: string;
  i1, i2: integer;
  pStr: Pchar;
  // match: TMatch;
begin
  str := Trim(str);
  pStr := StrRScan(Pchar(str), 'C');
  if (Pos('COM', pStr) > 0) then
  begin
    i1 := 1;
    i2 := Pos(')', pStr);
    if ((i2 - i1) > 1) then
    begin
      ss := Copy(pStr, i1, i2 - i1);
    end;
  end
  else if (Pos('PID', str) > 0) then
    ss := Copy(str, Pos('PID', str), 10)
  else
    ss := '';

  Result := ss;
end;

function GetSystemDateTimeStampStr2(types: integer): string;
var
  LocalSystemTime: _SYSTEMTIME;
  d, t: String;
begin
  Result := '';
  GetLocalTime(LocalSystemTime);
  if types = 0 then // 日期
  begin
    d := Format('[%0.4d%0.2d%0.2d]', [LocalSystemTime.wYear, LocalSystemTime.wMonth, LocalSystemTime.wDay]);
    Result := d + ' ';
  end;
  if types = 1 then // 时间
  begin
    t := Format('[%0.2d:%0.2d:%0.2d]', [LocalSystemTime.wHour, LocalSystemTime.wMinute, LocalSystemTime.wSecond]);
    Result := t + ' ';
  end;

  if types = 2 then
  begin
    d := Format('[%0.4d%0.2d%0.2d', [LocalSystemTime.wYear, LocalSystemTime.wMonth, LocalSystemTime.wDay]);
    t := Format('%0.2d:%0.2d:%0.2d]', [LocalSystemTime.wHour, LocalSystemTime.wMinute, LocalSystemTime.wSecond]);
    Result := d + ' ' + t + ' ';
  end;
end;

function GetLineNumberStrForLog(LineNumber: Int64): string;
begin
  // Result := '';
  // if (LineNumber < 0) then
  // LineNumber := 0;
  // if LineNumber < 100 then
  // Result := Format('%0.2d| ', [LineNumber])
  // else if LineNumber < 1000 then
  // Result := Format('%0.3d| ', [LineNumber])
  // else if LineNumber < 10000 then
  // Result := Format('%0.4d| ', [LineNumber])
  if LineNumber < 100000 then
    Result := Format('%0.5d| ', [LineNumber])

  else if LineNumber < 1000000 then
    Result := Format('%0.6d| ', [LineNumber])
  else if LineNumber < 10000000 then
    Result := Format('%0.7d| ', [LineNumber])
  else
    Result := Format('%0.10d| ', [LineNumber])
end;

constructor TComPackParserHandleThread.Create(OcComPortObj: TOcComPortObj; OcComProtocal: TOcComProtocal); // 数据特殊处理线程后台进行
begin
  inherited Create(True); // 先挂起
  FStartIndex := 0;
  self.FOcComPortObj := OcComPortObj;
  self.Suspended := True;
  FOcComProtocal := OcComProtocal;
end;

procedure TComPackParserHandleThread.StopReSetClear();
// var
// f: Boolean;
begin
  // f := self.Suspended;
  if not self.Suspended then
  begin
    self.Suspended := True; // 重置解析线程的时候，清空所有缓存
    self.FOcComPortObj.ClearInternalBuff();
  end;
  self.FOcComProtocal.ClearPacks;
  self.FStartIndex := 0;
  // self.Suspended:=f;
end;

procedure TComPackParserHandleThread.Execute;
var
  j: Int64;
begin
  while (self.Terminated = false) do
  begin
    { if (self.FOcComProtocal.GetLastPackHead.PID = OCCOMPROTOCAL_DATA2) then
      begin
      // 非标准超大数据包处理
      if (Length(FOcComPortObj.FComReceiveInternalBuffer) - FStartIndex <
      self.FOcComProtocal.GetLastPackHead.Length) then
      Continue; // 没有完成继续处理
      FStartIndex := FStartIndex + self.FOcComProtocal.GetLastPackHead.Length;
      // 超大数据包处理完毕，跳过
      end; }

    try
      if Length(FOcComPortObj.FComReceiveInternalBuffer) > SizeOf(TOcComPackHead) then
      begin
        j := self.FOcComProtocal.ParserPack(@FOcComPortObj.FComReceiveInternalBuffer[FStartIndex], Length(FOcComPortObj.FComReceiveInternalBuffer) - FStartIndex);

        FStartIndex := FStartIndex + j;
      end
      else
      begin
        self.Suspended := True; // 数据不足，挂起休眠
      end;
    except
    end;

    // if FStartIndex > Length(FOcComPortObj.FComReceiveInternalBuffer)-SizeOf(TOcComPack2) then //解析完毕
    // if FOcComProtocal.IsParserComplete { and (Length(FOcComPortObj.FComReceiveInternalBuffer) > 0) }

    if FStartIndex >= Length(FOcComPortObj.FComReceiveInternalBuffer) - 1 then // 解析完毕 then
    // 解析任务完毕，清缓存
    begin
      // EnterCriticalSection(Critical);
      FOcComPortObj.ClearInternalBuff();
      // LeaveCriticalSection(Critical);
      FStartIndex := 0; // 再这里复位，复位了不清解析后的数据
      self.Suspended := True;
    end;
    // if  FOcComPortObj.FComPackParserThread.Suspended or (Length(FOcComPortObj.FComReceiveInternalBuffer) > COM_PROTOCOL_KEEP_MAX_BUFFER_SIZE) then //解析线程任务还没有完成 不清缓存
    // begin //清内部缓存，后台线程挂起，或缓存过大,后台线程强制清缓存
    // end
  end; // while(not Self.Terminated) do
end;

constructor TComUIHandleThread.Create(OcComPortObj: TOcComPortObj);
// 数据特殊处理线程后台进行
begin
  inherited Create(True); // 先挂起
  self.FOcComPortObj := OcComPortObj;
  self.Suspended := True;
end;

procedure TComUIHandleThread.Execute;
var
  j: Int64;
  s, f: String;
begin
  j := 0;
  s := '';
  f := '%-' + IntToStr(FOcComPortObj.FHexModeFormatCount * 3 + 10) + 's';
  while (self.Terminated = false) do
  begin
    // ReStart:
    if FOcComPortObj.FComHandleThread_Wait then
      Continue;
    case FNeedToReset of // 强制切换接收格式清先前的缓存
      0:
        FOcComPortObj.ClearInternalBuff(0);
      1:
        FOcComPortObj.ClearInternalBuff(1);
    end;
    /// ////////////////////////////////////////////////////////////////////////////////////////////////////////ASCIIFormat
    if self.FOcComPortObj.FReceiveFormat = Ord(ASCIIFormat) then
    begin
      if FUIStartIndex = 0 then
      begin
        s := FOcComPortObj.StringInternalMemo.Lines.Strings[FUIStartIndex];
        if Trim(FOcComPortObj.LogMemo.Lines.Strings[FOcComPortObj.LogMemo.Lines.Count - 1]) = '' then
        begin
          // FOcComPortObj.LogMemo.Lines.Delete(FOcComPortObj.LogMemo.Lines.Count-1);
          s := FOcComPortObj.GetLineNumberDateTimeStamp(FOcComPortObj.LogMemo.Lines.Count - 1) + Trim(FOcComPortObj.StringInternalMemo.Lines.Strings[FUIStartIndex]);

          FOcComPortObj.LogMemo.Lines.Strings[FOcComPortObj.LogMemo.Lines.Count - 1] := s;
        end
        else if (Length(s) > 0) and (s[1] = #10) then // #13#10,分开发送导致无法正确的换行
          FOcComPortObj.LogMemo.Lines.Add(s)
        else
          FOcComPortObj.LogMemo.Lines.Strings[FOcComPortObj.LogMemo.Lines.Count - 1] := FOcComPortObj.LogMemo.Lines.Strings[FOcComPortObj.LogMemo.Lines.Count - 1] +
            Trim(FOcComPortObj.StringInternalMemo.Lines.Strings[FUIStartIndex]);
      end
      else
      begin
        s := FOcComPortObj.GetLineNumberDateTimeStamp(FOcComPortObj.LogMemo.Lines.Count) + Trim(FOcComPortObj.StringInternalMemo.Lines.Strings[FUIStartIndex]);
        FOcComPortObj.LogMemo.Lines.Add(s);
      end;

      FOcComPortObj.FComProcessedCount := FOcComPortObj.FComProcessedCount + Length(FOcComPortObj.StringInternalMemo.Lines.Strings[FUIStartIndex]);

      if Assigned(FOcComPortObj.FCallBackFun) then
        FOcComPortObj.FCallBackFun();
      INC(FUIStartIndex);

      if FUIStartIndex >= FOcComPortObj.StringInternalMemo.Lines.Count then
      begin
        if FOcComPortObj.FComHandleThread_Wait then
          Continue;
        if FUIStartIndex < FOcComPortObj.StringInternalMemo.Lines.Count then
          Continue;
        EnterCriticalSection(Critical);
        FOcComPortObj.ClearInternalBuff();
        LeaveCriticalSection(Critical);

        FOcComPortObj.FLastLineStr := FOcComPortObj.LogMemo.Lines.Strings[FOcComPortObj.LogMemo.Lines.Count - 1];
        self.Suspended := True; // 忙完了挂起
        Continue;
      end;
    end
    /// ////////////////////////////////////////////////////////////////////////////////////////////////////////hex
    else if self.FOcComPortObj.FReceiveFormat = Ord(HexadecimalFormat) then
    begin
      if FUIStartIndex < Length(FOcComPortObj.FComReceiveInternalBuffer) then
      begin // 有数据处理数据
        s := s + Format('%.02x ', [FOcComPortObj.FComReceiveInternalBuffer[FUIStartIndex]]);
        INC(FOcComPortObj.FComProcessedCount);
        if FOcComPortObj.FHexModeFormatCount > 0 then
        begin
          if ((FUIStartIndex + 1) mod FOcComPortObj.FHexModeFormatCount) = 0 then
          begin
            j := FUIStartIndex + 1;
            if FOcComPortObj.FHexModeWithString then
              s := Format(f, [Trim(s)]);
            s := s + ByteToWideString2(@FOcComPortObj.FComReceiveInternalBuffer[FUIStartIndex - FOcComPortObj.FHexModeFormatCount + 1], FOcComPortObj.FHexModeFormatCount);
            FOcComPortObj.Log(s);
            s := ''; // 这时J 的值无意义
          end;
        end; //
        INC(FUIStartIndex);
      end;

      if FUIStartIndex >= Length(FOcComPortObj.FComReceiveInternalBuffer) then
      begin // 没有数据准备清场
        if s <> '' then
        begin
          if FOcComPortObj.FHexModeWithString then
          begin
            s := Format(f, [Trim(s)]);
            if FOcComPortObj.FHexModeFormatCount > 0 then
            begin
              // s := Format('%-' + IntToStr(FOcComPortObj.FHexModeFormatCount * 3) + 's', [s]);
              s := s + ByteToWideString2(@FOcComPortObj.FComReceiveInternalBuffer[j], FOcComPortObj.FHexModeFormatCount);
            end
            else
              s := s + ByteToWideString2(@FOcComPortObj.FComReceiveInternalBuffer[j], Length(FOcComPortObj.FComReceiveInternalBuffer) - j)
          end;
          FOcComPortObj.Log(s);
          s := '';
        end;

        if FUIStartIndex < Length(FOcComPortObj.FComReceiveInternalBuffer) then
          Continue;
        if FOcComPortObj.FComHandleThread_Wait then
          Continue;
        j := 0;
        s := '';

        EnterCriticalSection(Critical);
        FOcComPortObj.ClearInternalBuff();
        LeaveCriticalSection(Critical);

        self.Suspended := True; // 忙完了挂起
        Continue;
      end;
    end // hex
    /// ////////////////////////////////////////////////////////////////////////////////////////////////////////Graphic
    else if self.FOcComPortObj.FReceiveFormat = Ord(Graphic) then
    begin
      { if FUIStartIndex < Length(FOcComPortObj.FComReceiveInternalBuffer) then
        begin // 有数据处理数据
        self.FOcComPortObj.FastLineSeries.AddY
        (FOcComPortObj.FComReceiveInternalBuffer[FUIStartIndex]);
        // self.FOcComPortObj.FastLineSeries.AddArray(FOcComPortObj.FComReceiveInternalBuffer);
        if Assigned(FOcComPortObj.FCallBackFun) then
        FOcComPortObj.FCallBackFun(1);
        INC(FUIStartIndex);
        INC(FOcComPortObj.FComProcessedCount);
        end;
        if FUIStartIndex >= Length(FOcComPortObj.FComReceiveInternalBuffer) then
        begin // 没有数据准备清场
        if FUIStartIndex < Length(FOcComPortObj.FComReceiveInternalBuffer) then
        Continue;
        if FOcComPortObj.FComHandleThread_Wait then
        Continue;
        EnterCriticalSection(Critical);
        FOcComPortObj.ClearInternalBuff();
        LeaveCriticalSection(Critical);
        self.Suspended := True; // 忙完了挂起
        Continue;
        end; }
    end; // ord(Graphic)

  end; // while(not Self.Terminated) do

end;

Constructor TOcComPortObj.Create(AOwner: TComponent; DeviceName: String);
begin
  inherited Create(nil);
  self.FComportFullName := Trim(DeviceName);
  self.Port := FalconGetComPort(DeviceName);
  self.LogMemo := TMemo.Create(nil);
  self.LogMemo.ScrollBars := ssBoth;
  self.LogMemo.ReadOnly := True;
  self.LogMemo.DoubleBuffered := True;
  // self.LogMemo.Parent.DoubleBuffered:=true;
  // self.LogMemo.Parent.Parent.DoubleBuffered:=true;
  // self.MemoTemp.Parent:=AOwner;
  self.StringInternalMemo := TMemo.Create(nil);
  self.StringInternalMemo.ScrollBars := ssBoth;
  self.StringInternalMemo.ReadOnly := True;
  self.StringInternalMemo.DoubleBuffered := True;
  self.StringInternalMemo.Visible := false;

  self.Buffer.InputSize := INPUT_OUTPUT_BUFFER_SIZE;
  self.Buffer.OutputSize := INPUT_OUTPUT_BUFFER_SIZE;

  FComUIHandleThread := TComUIHandleThread.Create(self);
  FOcComProtocal := TOcComProtocal.Create;
  FComPackParserThread := TComPackParserHandleThread.Create(self, FOcComProtocal);
  self.FComReceiveCount := 0;
  self.FComProcessedCount := 0;
  self.FBackGroundProcessRecordCount := OCTOPUS_BACKGROUD_STRING_TRIGGERLINE;
  self.ClearInternalBuff;
  self.FHexModeWithString := True;
  self.FHexModeFormatCount := 16;
  SetLength(FComReceiveInternalBuffer, 0);
  FullLogFileName := '';
  FFileStream := nil;

  FProtocalData := 1;
  FCompatibleUnicode := True;
  FExcelAppRows := 0;
  FShowLineNumber := false;
  FCommadLineStr := '';
  FLastLineStr := '';
  FNeedNewLine := false;
  // LogMemo.ReadOnly:=false;
  FCommandHistory := TStringList.Create;
  FCommandHistoryIndex := 0;
  FLogScrollMode := True;
  FSendFormat := 0;

  Timeouts.ReadInterval := 10;
end;

// destroy component
destructor TOcComPortObj.Destroy;
begin
  self.FStringInternalMemo.Free;
  self.FLogMemo.Free;
  FComUIHandleThread.Terminate;
  FComUIHandleThread.Free;
  FComPackParserThread.Terminate;
  FComPackParserThread.Free;
  if FFileStream <> nil then
    FreeAndNil(FFileStream);
  inherited Destroy;
end;

function TOcComPortObj.GetConfiguration(): TOcComPortObjPara;
//var
//  FOcComPortObjPara: TOcComPortObjPara;
begin
  FOcComPortObjPara.Port := self.Port;
  FOcComPortObjPara.ComportFullName := self.FComportFullName;
  FOcComPortObjPara.BaudRate := Ord(self.BaudRate);
  FOcComPortObjPara.DataBits := Ord(self.DataBits);
  FOcComPortObjPara.StopBits := Ord(self.StopBits);
  FOcComPortObjPara.ParityBits := Ord(self.Parity.Bits);
  FOcComPortObjPara.FlowControl := Ord(self.FlowControl.FlowControl);
  FOcComPortObjPara.ReceiveFormat := self.FReceiveFormat;
  FOcComPortObjPara.SendFormat := self.FSendFormat;
  FOcComPortObjPara.LogMemo := self.LogMemo;
  FOcComPortObjPara.ShowDate := self.FShowDate;
  FOcComPortObjPara.ShowTime := self.FShowTime;
  FOcComPortObjPara.ShowLineNumber := self.FShowLineNumber;
  FOcComPortObjPara.ShowSendedLog := self.FShowSendingLog;
  FOcComPortObjPara.HexModeWithString := self.FHexModeWithString;
  Result := FOcComPortObjPara;
end;

procedure TOcComPortObj.OcComPortObjInit2(a, b: String; c, d, e, f, g, h, i: integer; j: TMemo; k, l, m, N, o: Boolean);
var
  threadsuspended: Boolean;
  // oldi:integer;
begin
  // if(self.OnRxChar = nil) then
  self.OnRxChar := OcComPortObjRxChar;
  // if(self.FOcComProtocal.CallBackFun = nil) then
  self.FOcComProtocal.CallBackFun := self.OcComPortObjRxProtocol;

  if a <> '' then
    self.FComportFullName := a;
  if b <> '' then
    self.Port := b;
  if (c > MAX_BAUDRATE_INDEX) or (c < 0) then
    self.BaudRate := TBaudRate(0)
  else
    self.BaudRate := TBaudRate(c);
  if (d >= 0) then
    self.DataBits := TDataBits(d);
  if (e >= 0) then
    self.StopBits := TStopBits(e);
  if (f >= 0) then
    self.Parity.Bits := TParityBits(f);
  if (g >= 0) then
    self.FlowControl.FlowControl := TFlowControl(g);
  if (h >= 0) then
    self.FSendFormat := h;

  if (FReceiveFormat <> i) and (i >= 0) then // 切换接收格式 ,需要重置缓存
  begin
    threadsuspended := FComUIHandleThread.Suspended;
    if not threadsuspended then
    begin
      self.FComUIHandleThread.Suspended := True;
      // 如果工作线程已经在运行， 通过 ResetID 让工作线程自行重置
      self.FComUIHandleThread.ResetID := self.FReceiveFormat; // 通知线程重置先前的缓存
    end
    else
      self.ClearInternalBuff; // 否则直接重置
    FComPackParserThread.StopReSetClear; // 重置解析线程
    if FFileStream <> nil then
    begin
      FreeAndNil(FFileStream);
      self.FFileStreamName := '';
    end;
    self.FReceiveFormat := i;
    self.FComUIHandleThread.Suspended := threadsuspended;
    // 让UI 线程自行结束返回，避免在切换格式的时候丢失数据
  end;

  if j <> nil then
  begin
    if self.FLogMemo <> j then
    begin
      self.FLogMemo.Free;
      self.FLogMemo := j;
    end;
  end;
  if self.FLogMemo = nil then
    self.LogMemo := TMemo.Create(nil);

  self.FShowDate := k;
  self.FShowTime := l;
  self.FShowLineNumber := m;
  self.FShowSendingLog := N;
  self.FHexModeWithString := o;

  LogMemo.OnKeyDown := self.KeyDown;
  LogMemo.OnKeyPress := self.KeyPress;
  LogMemo.OnMouseDown := self.MouseDown;
  FNeedNewLine := True;
end;

procedure TOcComPortObj.ClearInternalBuff(id: integer = 100);
// ClearInternelLogBuff(); //不随便清楚内部缓存
begin
  case id of
    0:
      if self.StringInternalMemo.Parent <> nil then
      begin
        self.StringInternalMemo.Clear; // 清字符串缓存区域
        FComUIHandleThread.FUIStartIndex := 0;
        FComUIHandleThread.ResetID := -1; // 复位，避免反复重置
      end;
    1:
      begin
        FComUIHandleThread.FUIStartIndex := 0; // 清字节流缓存
        SetLength(self.FComReceiveInternalBuffer, 0);
        FComUIHandleThread.ResetID := -1; // 复位，避免反复重置
      end
  else
    begin
      if self.StringInternalMemo.Parent <> nil then
      begin
        self.StringInternalMemo.Clear;
        FComUIHandleThread.FUIStartIndex := 0;
        SetLength(self.FComReceiveInternalBuffer, 0);
        FComUIHandleThread.ResetID := -1; // 复位，避免反复重置
      end;
    end;
  end;

end;

procedure TOcComPortObj.ClearLog;
begin
  if self.LogMemo.Showing then
  begin
    self.LogMemo.Clear;
    self.FComProcessedCount := 0;
    self.FComReceiveCount := 0;
    self.FComSentCount := 0;
    self.FComPackParserThread.StopReSetClear;
    self.FOcComProtocal.ClearPacks;
    if Assigned(FCallBackFun) then
      FCallBackFun();
  end;
end;

procedure TOcComPortObj.LogBuff(flag: String; const Buff: Array of Byte; Count: integer);
var
  str: String;
  i, j: integer;
  f: string;
begin
  str := '';
  if (Count <= 0) then
    exit;
  j := 0;
  f := '%-' + IntToStr(FHexModeFormatCount * 3 + 10) + 's';
  for i := 0 to Count - 1 do
  begin
    str := str + Format('%.02x ', [Buff[i]]);
    INC(j);
    if ((i + 1) mod FHexModeFormatCount) = 0 then
    begin
      str := Format(f, [Trim(str)]);
      str := str + ByteToWideString2(@Buff[i - FHexModeFormatCount + 1], FHexModeFormatCount);
      Log(flag + str);
      str := '';
      j := 0;
    end;
  end;

  str := Format(f, [Trim(str)]);
  str := str + ByteToWideString2(@Buff[Count - j], j);
  Log(flag + str);
end;

procedure TOcComPortObj.Log(const Msg: string);
var
  i, PreLogLinesCount: Int64;
  str: String;
  isBottom: Boolean;
begin

  if (LogMemo = nil) or (LogMemo.Parent = nil) then
  begin
    MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  isBottom := IsLogBottom();
  PreLogLinesCount := LogMemo.Lines.Count;
  LogMemo.Lines.BeginUpdate;
  LogMemo.Lines.Append(Msg);

  if FShowLineNumber or FShowDate or FShowTime then
  begin
    for i := PreLogLinesCount to LogMemo.Lines.Count - 1 do
    begin
      str := GetLineNumberDateTimeStamp(i) + LogMemo.Lines.Strings[i];
      LogMemo.Lines.Strings[i] := str;
    end;
  end;
  LogMemo.Lines.EndUpdate;

  if FLogScrollMode and isBottom then
    LogMemo.Perform(WM_VSCROLL, SB_BOTTOM, 0);
  if Assigned(FCallBackFun) then
    FCallBackFun();
end;

procedure TOcComPortObj.LogBottomMod(const Msg: string; appendMod: Boolean; bottomMod: Boolean);
// var
// i: Int64;
// str: String;
begin
  if (LogMemo = nil) or (LogMemo.Parent = nil) then
  begin
    exit;
  end;
  if appendMod then
  begin
    if (not bottomMod) then
    begin
      LogMemo.Lines.BeginUpdate;
      LogMemo.Lines.Add(Msg);
      LogMemo.Lines.EndUpdate;
    end
    else
    begin // bottomMod 底部跟踪模式
      LogMemo.Lines.Add(Msg);
    end;
  end
  else
  begin
    if (not bottomMod) then
    begin
      LogMemo.Lines.BeginUpdate;
      LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] := LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] + Msg;
      LogMemo.Lines.EndUpdate;
    end
    else
    begin // bottomMod 底部跟踪模式
      LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] := LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] + Msg;
    end;
  end;
end;

function TOcComPortObj.IsLogBottom(): Boolean;
var
  SF: TScrollInfo;
  currentPos: integer;
begin
  SF.fMask := SIF_ALL;
  SF.cbSize := SizeOf(SF);
  GetScrollInfo(LogMemo.Handle, SB_VERT, SF);
  currentPos := SF.nPos + SF.nPage;
  Result := false;
  if currentPos >= SF.nMax - 20 then
  begin
    // '滚动条到达底部'
    Result := True;
  end;
end;

// for send file 默认 十六进制发送
function TOcComPortObj.FalconComSendBuffer(const Buffer: array of Byte; Count: integer): Bool;
begin
  Result := True;
  if self.connected then
  begin
    try
      // LogBuff('-> ', Buffer, Count);
      self.Write(Buffer, Count);
      FComSentCount := FComSentCount + Count;
    except
      Log('Sorry Write to device fail!!');
      exit;
    end;
  end
  else
  begin
    Log('Device was closed,please open a device.');
    exit;
  end;
end;

// 一般发送
function TOcComPortObj.FalconComSendData_Common(str: string; SendFormat: integer): Bool;
var
  buf: array [0 .. 1023] of Byte;
  bLength: integer;
  s, tempstr: string;
begin
  Result := True;
  if SendFormat = Ord(S_ASCIIFormat) then // send string ascci char
  begin
    tempstr := str;
    str := str + #13#10;
    if self.connected then
    begin
      if FShowSendingLog then
      begin
        if FReceiveFormat = 1 then
          Log(SEND_FLAG + tempstr) // 十六进制接收采用单行LOG 的方式，会自起新行。
        else
          Log(SEND_FLAG + str); // new ling in memo for receive data 发送字符串,后面自带换行
      end;

      try
        self.writestr(str);
        FComSentCount := FComSentCount + Length(str);
      except
        Result := false;
        Log('Sorry Write to device fail!!');
        exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      exit;
    end;
    exit;
  end;
  if SendFormat = Ord(S_HexadecimalFormat) then
  begin
    if self.connected then
    begin
      s := FormatHexStrToByte(Trim(str), buf, bLength);
      if FShowSendingLog then
        Log(SEND_FLAG + s); // Log(''); // new line prepare to receive

      try
        self.Write(buf, bLength);
        FComSentCount := FComSentCount + bLength;
      except
        Log('Sorry Write to device fail!!');
        exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      exit;
    end;
  end;
  if SendFormat = Ord(S_OctopusProtocol) then
  begin
    if checkIsHexStr(str) then
    begin
      s := FormatHexStrToByte(Trim(str), buf, bLength);
      SendProtocolData(OCCOMPROTOCAL_HEAD2, OCCOMPROTOCAL_DATA, buf, bLength, false);
    end
    else
    begin
      WideStringToByte(str, buf);
      bLength := Length(str);
      SendProtocolData(OCCOMPROTOCAL_HEAD2, OCCOMPROTOCAL_DATA, buf, bLength, false);
    end;

    FComSentCount := FComSentCount + bLength;
  end;

  if Assigned(FCallBackFun) then
    FCallBackFun();
end;

// 终端模式发送
function TOcComPortObj.FalconComSendData_Terminal(str: string; SendFormat: integer): Bool;
var
  buf: array [0 .. 1023] of Byte;
  bLength: integer;
  s: string;
begin
  Result := True;
  if SendFormat = Ord(S_ASCIIFormat) then // send string ascci char
  begin
    if self.connected then
    begin
      try
        if (Length(str) > 0) and (str[Length(str)] = #9) then
        begin
        end
        else
          str := str + #13;
        writestr(str);

        FComSentCount := FComSentCount + Length(str);
      except
        Result := false;
        Log('Sorry Write to device fail!!');
        exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      exit;
    end;
    exit;
  end;
  if SendFormat = Ord(S_HexadecimalFormat) then
  begin
    if self.connected then
    begin
      s := FormatHexStrToByte(Trim(str), buf, bLength);
      // Len := (Length(str) + 2) div 3;
      try
        self.Write(buf, bLength);
        FComSentCount := FComSentCount + bLength;
      except
        Log('Sorry Write to device fail!!');
        exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      exit;
    end;
  end;
  if SendFormat = Ord(S_OctopusProtocol) then
  begin
    s := FormatHexStrToByte(Trim(str), buf, bLength);
    // Len := (Length(str) + 2) div 3;
    SendProtocolData(OCCOMPROTOCAL_DATA, buf, bLength, false);
  end;
end;

// 多次发送 ,块发送，循环发送，区别是不另外预留新行供接收使用
function TOcComPortObj.FalconComSendData_MultiTimes(str: string; SendFormat: integer): Bool;
var
  buf: array [0 .. 1023] of Byte;
  bLength: integer;
  s: string;
begin
  Result := True;
  if SendFormat = Ord(S_ASCIIFormat) then // send string ascci char
  begin
    str := str + #13#10;
    if self.connected then
    begin
      if FShowSendingLog then
        Log(SEND_FLAG + str);

      try
        self.writestr(str);
        FComSentCount := FComSentCount + Length(str);
      except
        Result := false;
        Log('Sorry Write to device fail!!');
        exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      exit;
    end;
    exit;
  end;
  if SendFormat = Ord(S_HexadecimalFormat) then
  begin
    if self.connected then
    begin
      s := FormatHexStrToByte(Trim(str), buf, bLength);
      if FShowSendingLog then
        Log(SEND_FLAG + s);

      try
        self.Write(buf, bLength);
        FComSentCount := FComSentCount + bLength;
      except
        Log('Sorry Write to device fail!!');
        exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      exit;
    end;
  end;

  if SendFormat = Ord(S_OctopusProtocol) then
  begin
    if checkIsHexStr(str) then
    begin
      s := FormatHexStrToByte(Trim(str), buf, bLength);
      SendProtocolData(OCCOMPROTOCAL_HEAD2, OCCOMPROTOCAL_DATA, buf, bLength, false);
    end
    else
    begin
      WideStringToByte(str, buf);
      bLength := Length(str);
      SendProtocolData(OCCOMPROTOCAL_HEAD2, OCCOMPROTOCAL_DATA, buf, bLength, false);
    end;
    FComSentCount := FComSentCount + bLength;
  end;

  if Assigned(FCallBackFun) then
    FCallBackFun();
end;

function TOcComPortObj.GetLineNumberDateTimeStamp(N: Int64): String;
var
  ln, d, t, dt: String;
begin
  Result := '';
  if FShowLineNumber then
  begin
    ln := GetLineNumberStrForLog(N);
    Result := ln;
  end;
  if (FShowDate and FShowTime) then
  begin
    dt := GetSystemDateTimeStampStr2(2);
    Result := ln + dt;
    exit;
  end;
  if FShowDate then
  begin
    d := GetSystemDateTimeStampStr2(0);
    Result := ln + d;
  end;
  if FShowTime then
  begin
    t := GetSystemDateTimeStampStr2(1);
    Result := ln + t;
  end;
end;

function TOcComPortObj.SaveToTheExcelFile(Length: integer; Rows: integer): integer;
var
  // FileName: String;
  i: integer;
begin
  if Rows = 0 then
    Rows := 1;
  Result := Rows;
  if Length = 0 then
    exit;

  try
    for i := 0 to Length - 1 do
    begin
      ExcelApp.Cells[Rows, 2].Value := FComReceiveBuffer[i];
      INC(Rows);
    end;
  finally
    // ExcelApp.SaveAs(self.FileStreamName);
  end;
  Result := Rows;
end;

procedure TOcComPortObj.OcComPortObjRxChar(Sender: TObject; Count: integer);
var
  i: integer;
  PreLogLinesCount: Int64;
  s, ln: String;
  Buff: array of Byte;
  f: Text;
  isBottom: Boolean;
begin
  FComReceiveString := '';
  s := '';
  ln := '';
  FComReceiveCount := FComReceiveCount + Count;
  FComReceiveString := '';
  isBottom := IsLogBottom();

  if FReceiveFormat = Ord(ASCIIFormat) then // receive as string
  begin
    try
      if FCompatibleUnicode then
        ReadUnicodeString(FComReceiveString, Count) // 可以读中文
      else
        ReadStr(FComReceiveString, Count);

      // 兼容 \R
      if (Pos(#13#10, FComReceiveString) <= 0) and (Count <= 2048) then
      begin
        if (Pos(#10, FComReceiveString) > 0) then
          FComReceiveString := StringReplace(FComReceiveString, #10, #13#10, [rfReplaceAll]);
        if (Pos(#13, FComReceiveString) > 0) then
          FComReceiveString := StringReplace(FComReceiveString, #$D, #13#10, [rfReplaceAll]);
      end;
    Except
    end;

    if FShowLineNumber or FShowDate or FShowTime then
    begin
      FComHandleThread_Wait := True;
      EnterCriticalSection(Critical);
      StringInternalMemo.Lines.BeginUpdate;
      StringInternalMemo.Lines.Strings[StringInternalMemo.Lines.Count - 1] := StringInternalMemo.Lines.Strings[StringInternalMemo.Lines.Count - 1] + FComReceiveString;
      StringInternalMemo.Lines.EndUpdate;
      self.FComHandleThread_Wait := false;
      LeaveCriticalSection(Critical);
      if StringInternalMemo.Lines.Count >= FBackGroundProcessRecordCount then
      begin
        if FComUIHandleThread.Suspended then
          FComUIHandleThread.Suspended := false; // 启动后台线程
        exit;
      end;
      if (FComUIHandleThread.Suspended = false) then // 后台正在处理数据
        exit; // 数据转入后台处理，等待后台线程处理完成
      if (FComUIHandleThread.Suspended) then // 无需后台处理数据，或者后台数据处理完成，事情做完了就挂起
      begin
        ClearInternalBuff(); // 不能少，清楚后台BUFFER ，转入前台处理
        PreLogLinesCount := LogMemo.Lines.Count;

        LogMemo.Lines.BeginUpdate;

        if (FComReceiveString[1] = #13) or (FComReceiveString[1] = #10) then
          // #13#10,分开发送导致无法正确的换行
          // LogMemo.Lines.Add(FComReceiveString)
          LogBottomMod(FComReceiveString, True, isBottom)
        else // 自动分行
          LogBottomMod(FComReceiveString, false, isBottom);
        // LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] := LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] + FComReceiveString;

        /// /////////////////////////////////////////////////////////////////////
        // 显示行号
        for i := PreLogLinesCount to LogMemo.Lines.Count - 1 do
        begin
          LogMemo.Lines.Strings[i] := GetLineNumberDateTimeStamp(i) + LogMemo.Lines.Strings[i];
        end;

        LogMemo.Lines.EndUpdate;

        FComProcessedCount := FComProcessedCount + Length(FComReceiveString);
        FLastLineStr := LogMemo.Lines.Strings[LogMemo.Lines.Count - 1];
        // if Assigned(FCallBackFun) then
        // FCallBackFun();
      end;
    end
    else
    begin // 无需特殊处理，不额外显示日期日期信息
      if FNeedNewLine then
      begin
        if (FComReceiveString[Length(FComReceiveString)] = #13) or (FComReceiveString[Length(FComReceiveString)] = #10) then // \r\n
          FNeedNewLine := True
        else
          FNeedNewLine := false;

        FComReceiveString := TrimRight(FComReceiveString);

        // LogMemo.Lines.BeginUpdate;
        // LogMemo.Lines.Add(FComReceiveString);
        // LogMemo.Lines.EndUpdate;
        LogBottomMod(FComReceiveString, True, isBottom);
      end
      else
      begin
        if (FComReceiveString[Length(FComReceiveString)] = #13) or (FComReceiveString[Length(FComReceiveString)] = #10) then // \r\n
          FNeedNewLine := True
        else
          FNeedNewLine := false;

        FComReceiveString := TrimRight(FComReceiveString);
        LogBottomMod(FComReceiveString, false, isBottom);
        // LogMemo.Lines.BeginUpdate;
        // LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] := LogMemo.Lines.Strings
        // [LogMemo.Lines.Count - 1] + FComReceiveString;
        // LogMemo.Lines.EndUpdate;
      end;

      FComProcessedCount := FComProcessedCount + Length(FComReceiveString);
      FLastLineStr := LogMemo.Lines.Strings[LogMemo.Lines.Count - 1];
      // if Assigned(FCallBackFun) then
      // FCallBackFun();
    end;
  end
  /// ///////////////////////////////////////////////////////////////////////////
  else if FReceiveFormat = Ord(HexadecimalFormat) then // receive as hex format
  begin
    // ZeroMemory(@FComReceiveBuffer, SizeOf(FComReceiveBuffer));
    FComHandleThread_Wait := True;
    try
      Read(FComReceiveBuffer, Count);
    Except
    end;
    // EnterCriticalSection(Critical);
    if Length(FComReceiveInternalBuffer) = 0 then
      ClearInternalBuff;
    SetLength(FComReceiveInternalBuffer, Length(FComReceiveInternalBuffer) + Count);
    CopyMemory(@FComReceiveInternalBuffer[Length(FComReceiveInternalBuffer) - Count], @FComReceiveBuffer, Count);
    // LeaveCriticalSection(Critical);
    FComHandleThread_Wait := false;
    if FComUIHandleThread.Suspended then
    begin
      FComUIHandleThread.Suspended := false; // 启动UI工作线程
    end;
  end
  /// //////////////////////////////////////////////////////////////////////////
  else if FReceiveFormat = Ord(Graphic) then // receive as Graphic
  begin
    { ZeroMemory(@FComReceiveBuffer, SizeOf(FComReceiveBuffer));
      self.FComHandleThread_Wait := True;
      try
      self.Read(FComReceiveBuffer, Count);
      Except
      end;
      self.FComHandleThread_Wait := True;
      EnterCriticalSection(Critical);
      if Length(FComReceiveInternalBuffer) = 0 then
      self.ClearInternalBuff;
      SetLength(FComReceiveInternalBuffer,
      Length(FComReceiveInternalBuffer) + Count);
      CopyMemory(@FComReceiveInternalBuffer[Length(FComReceiveInternalBuffer) -
      Count], @FComReceiveBuffer, Count);
      LeaveCriticalSection(Critical);
      FComHandleThread_Wait := false;
      if FComUIHandleThread.Suspended then
      begin
      FComUIHandleThread.Suspended := false; // 启动UI工作线程 绘制图形
      end; }
  end
  /// ///////////////////////////////////////////////////////////////////////////
  else if FReceiveFormat = Ord(OctopusProtocol) then
  // receive as OctopusProtocol pack
  begin
    ZeroMemory(@FComReceiveBuffer, SizeOf(FComReceiveBuffer));
    FComHandleThread_Wait := True;
    try
      FComProcessedCount := FComProcessedCount + self.Read(FComReceiveBuffer, Count);
    Except
    end;

    FComHandleThread_Wait := True;
    EnterCriticalSection(Critical);
    if Length(FComReceiveInternalBuffer) = 0 then
      self.ClearInternalBuff;
    SetLength(FComReceiveInternalBuffer, Length(FComReceiveInternalBuffer) + Count);
    CopyMemory(@FComReceiveInternalBuffer[Length(FComReceiveInternalBuffer) - Count], @FComReceiveBuffer, Count);
    LeaveCriticalSection(Critical);
    self.FComHandleThread_Wait := false;
    if (FComPackParserThread.Suspended) { and (FProtocalData > 0) } then
    begin
      FComPackParserThread.Suspended := false; // 启动协议解析线程
    end;
  end
  /// ///////////////////////////////////////////////////////////////////////////
  else if FReceiveFormat = Ord(SaveToFile) then // for File save to file
  begin
    if (CompareText(ExtractFileExt(self.FileStreamName), '.txt') = 0) or (CompareText(ExtractFileExt(self.FileStreamName), '.log') = 0) then
    begin
      AssignFile(f, self.FileStreamName);
      Append(f); // 打开准备追加
      if FCompatibleUnicode then
        self.ReadUnicodeString(FComReceiveString, Count) // 可以读中文
      else
        self.ReadStr(FComReceiveString, Count);
      Writeln(f, FComReceiveString);
      CloseFile(f);
      FComProcessedCount := FComProcessedCount + Count;
      // if Assigned(FCallBackFun) then
      // FCallBackFun();
    end
    else if (CompareText(ExtractFileExt(self.FileStreamName), '.xls') = 0) or (CompareText(ExtractFileExt(self.FileStreamName), '.xlsx') = 0) then
    begin
      ZeroMemory(@FComReceiveBuffer, SizeOf(FComReceiveBuffer));
      i := self.Read(FComReceiveBuffer, Count);
      FExcelAppRows := SaveToTheExcelFile(i, FExcelAppRows);
    end
    else
    begin
      ZeroMemory(@FComReceiveBuffer, SizeOf(FComReceiveBuffer));
      Read(FComReceiveBuffer, Count);
      if FileStream <> nil then
      begin
        SetLength(Buff, Count);
        CopyMemory(Buff, @FComReceiveBuffer, Count);
        FComProcessedCount := FComProcessedCount + FileStream.Write(Buff, Count);

        // if Assigned(FCallBackFun) then
        // FCallBackFun();
      end
    end;
  end;

  /// ///////////////////////////////////////////////////////////////////////////
  if Assigned(FCallBackFun) then
    FCallBackFun();
  if FReceiveFormat = Ord(ASCIIFormat) then
  begin
    if (FLogScrollMode) and (Length(FComReceiveString) > 0) and isBottom then
    begin
      LogMemo.Perform(WM_VSCROLL, SB_BOTTOM, 0);
      LogMemo.Perform(WM_HSCROLL, SB_LEFT, 0);
    end;
  end;
end;

procedure TOcComPortObj.RequestProtocolConnection;
// var
// b: array of Byte;
begin
  // SendProtocolData(b, 0, OCCOMPROTOCAL_START, false);
end;

procedure TOcComPortObj.SendProtocolACK();
// var
// b: array of Byte;
begin
  // SendProtocolData(b, 0, OCCOMPROTOCAL_ACK, false);
end;

function TOcComPortObj.SendProtocolPackage(pPOcComPack: POcComPack): Boolean;
var
  p: pbyte;
  ilength: integer;
begin
  p := pbyte(pPOcComPack);
  ilength := SizeOf(TOcComPackHead) + pPOcComPack.Length + 2; { crc + end }

  if FShowSendingLog then
    LogBuff('-> ', p^, ilength);

  // PrintSendProtocolPack(OcComPack);
  // 串口写入数据
  FalconComSendBuffer(p^, ilength); // 校验位和结束标记可有可无
  Result := True;
end;

function TOcComPortObj.SendProtocolPackageWaitACK(pPOcComPack: POcComPack; ACK: integer): Boolean;
var
  // p: pbyte;
  // ilength: integer;
  reTryCount: integer;
begin
  Result := True;
  reTryCount := 0;
  SendProtocolPackage(pPOcComPack);
  while (not WaitProtocolACK(ACK, 2000)) do
  begin
    INC(reTryCount);
    if reTryCount > 10 then // >=11
    begin
      Log('No ack from device transmit failed!');
      Result := false;
      exit;
    end;
    Log('Time Out Try ... ' + IntToStr(reTryCount));
    SendProtocolPackage(pPOcComPack);
  end;
end;

function TOcComPortObj.SendProtocolData(TypeID: Word; const Buffer: Array Of Byte; Count: integer; NeedACK: Boolean): Boolean;
begin
  Result := SendProtocolData(OCCOMPROTOCAL_HEAD, TypeID, Buffer, Count, NeedACK);
end;

function TOcComPortObj.SendProtocolData(Head: Word; TypeID: Word; const Buffer: Array Of Byte; Count: integer; NeedACK: Boolean): Boolean;
var
  OcComPack: TOcComPack;
  // OcComPackHead: TOcComPackHead;
  packs, i, j: integer;
  PaLoad_Max_Length: integer;
begin
  OcComPack := FOcComProtocal.CreatePack(Head, TypeID);
  Result := True;
  PaLoad_Max_Length := OCCOMPROTOCAL_PACK_PACKPAYLOAD_MAX_LENGTH;
  j := 0; // 分包数据索引

  case OcComPack.PID of
    OCCOMPROTOCAL_START, OCCOMPROTOCAL_OVER, OCCOMPROTOCAL_ACK:
      begin
        FOcComProtocal.SetCRC8(@OcComPack);
        FOcComProtocal.SetEndFlag(@OcComPack);
        SendProtocolPackage(@OcComPack);
      end;
    OCCOMPROTOCAL_DATA:
      begin
        packs := 1; // 默认情况下一个包处理
        if Count > PaLoad_Max_Length then // 需要分包
        begin
          packs := (Count div PaLoad_Max_Length);
          if (Count mod PaLoad_Max_Length) > 0 then
            packs := packs + 1;
        end;

        for i := 0 to packs - 1 do
        begin
          j := PaLoad_Max_Length * i;
          if j >= Count then
            break;

          if NeedACK then
            OcComPack.PID := MakeWord(OCCOMPROTOCAL_ACK, TypeID)
          else
            OcComPack.PID := TypeID;

          OcComPack.Index := i;
          if Count > PaLoad_Max_Length then // 需要分包
            OcComPack.Length := PaLoad_Max_Length
          else
            OcComPack.Length := Count;

          CopyMemory(@OcComPack.data[0], @Buffer[j], OcComPack.Length);
          FOcComProtocal.SetCRC8(@OcComPack);
          FOcComProtocal.SetEndFlag(@OcComPack);
          SendProtocolPackage(@OcComPack);
        end; // for

      end; // OCCOMPROTOCAL_DATA1:
  end; // case
end;

function TOcComPortObj.WaitProtocolACK(ACK: integer; timeOut: integer): Boolean;
var
  pOc: POcComPack;
  Start: real;
begin
  Result := false;
  Start := GetTickCount;

  while (True) do
  begin
    Application.ProcessMessages;
    pOc := self.FOcComProtocal.GetNewPack();

    if pOc <> nil then
    begin
      if pOc.data[0] = ACK then // 0x59 89 Y
      begin
        Result := True;
        break;
      end;
    end;

    if (GetTickCount - Start) > timeOut then
    begin
      break; // 超时推出
    end;
  end; // while (True) do

end;

function TOcComPortObj.WaitProtocolACK2(ACKBuffer: array of Byte; bCount: integer; timeOut: integer): Boolean;
var
  pOc: POcComPack;
  Start: real;
  ilength: integer;
begin
  Result := false;
  Start := GetTickCount;
  while (True) do
  begin
    Application.ProcessMessages;
    pOc := self.FOcComProtocal.GetNewPack();

    if pOc <> nil then
    begin
      // iOK := 0;
      ilength := bCount;
      while (ilength >= 0) do
      begin
        if (pOc.data[bCount] <> ACKBuffer[bCount]) then
          break;

        Dec(ilength);
      end;

      if (ilength = bCount) then
      begin
        Result := True;
        break;
      end;
    end;

    if (GetTickCount - Start) > timeOut then
    begin
      break; // 超时推出
    end;

  end;
end;

// 包解析完成后回调
procedure TOcComPortObj.OcComPortObjRxProtocol(OcComPack: POcComPack);
begin
  case OcComPack.PID of
    OCCOMPROTOCAL_ACK: // 客户端简单应答，表示可以连接 //收到应答
      begin
      end;
    OCCOMPROTOCAL_DATA: // 收到客户端的数据包
      begin
      end;
    OCCOMPROTOCAL_OVER: // 接收完毕 一个大的任务完成
      begin
      end;
  else
    begin

    end;
  end;

  if (OcComPack.Head = 0) and (OcComPack.PID = 0) and (OcComPack.Length > 0) then
    LogBuff('', OcComPack.data, OcComPack.Length)
  else
    PrintProtocolPack('', OcComPack);
  // PrintReceivedProtocolData(-1); // 输出最新收到的包 ，非保准超大数据包没有保存，
  if Assigned(FCallBackFun) then
    FCallBackFun();
end;

procedure TOcComPortObj.PrintProtocolPack(flag: String; OcComPack: POcComPack);
var
  j, l: integer;
  str, f: String;
begin
  str := flag;
  // s := '';

  str := str + Format('%.04x ', [OcComPack.Head]);
  str := str + Format('%.04x ', [OcComPack.PID]);
  str := str + Format('%.02x ', [OcComPack.Index]);
  // str := str + Format('%.04x ', [OcComPack.Total]);
  str := str + Format('%.04x ', [OcComPack.Length]);
  for j := 0 to OcComPack.Length + 1 do
  begin
    str := str + Format('%.02x ', [OcComPack.data[j]]);
  end;
  // str := str + Format('%.04x ', [OcComPack.CRC]);
  l := OcComPack.Length + SizeOf(TOcComPackHead);
  if (l <= 16) then
    f := '%-' + IntToStr(16 * 3 + 10) + 's'
  else if (l <= 32) then
    f := '%-' + IntToStr(32 * 3 + 10) + 's'
  else
    f := '%-' + IntToStr(l * 3 + 10) + 's';

  if FHexModeWithString then
    str := Format(f, [Trim(str)]);
  str := str + ByteToWideString2(@OcComPack.data, OcComPack.Length);
  Log(str);
end;

procedure TOcComPortObj.PrintReceivedProtocolData(Index: integer);
var
  i, j: integer;
  str: String;
begin
  str := '';
  if (Index = -1) then
    i := self.FOcComProtocal.PackList_RB_Top
  else
    i := Index;

  // for i := Low(self.FOcComProtocal.FPackList) to High(self.FOcComProtocal.FPackList) do
  begin
    str := str + Format('%.04x ', [self.FOcComProtocal.GetPackByIndex(i).Head]);
    str := str + Format('%.04x ', [self.FOcComProtocal.GetPackByIndex(i).PID]);
    str := str + Format('%.04x ', [self.FOcComProtocal.GetPackByIndex(i).Index]);
    // str := str + Format('%.04x ',
    // [self.FOcComProtocal.GetPackByIndex(i).Total]);
    // str:=str+Format('%.02x ', [self.FOcComProtocal.FPackList[i].CRC]);
    str := str + Format('%.04x, ', [self.FOcComProtocal.GetPackByIndex(i).Length]);
    for j := 0 to self.FOcComProtocal.GetPackByIndex(i).Length - SizeOf(TOcComPackHead) - 1 do
    begin
      str := str + Format('%.02x ', [self.FOcComProtocal.GetPackByIndex(i).data[j]]);
    end;
    self.Log(str);

    { v := FOcComProtocal.GetBytesValue(i);
      if (v > 65525) then
      v := 65535;

      FastLineSeries.AddY(v);
      str := ''; }
  end;

end;

procedure TOcComPortObj.SaveLog(FullLogFilePath: String);
begin
  if FullLogFilePath <> '' then
  begin
    self.LogMemo.Lines.SaveToFile(FullLogFilePath);
    FullLogFileName := FullLogFilePath;
  end
  else if FullLogFileName <> '' then
    self.LogMemo.Lines.SaveToFile(FullLogFileName);
end;

function TOcComPortObj.GetPacks: integer;
begin
  Result := self.FOcComProtocal.PackList_RB_Count;
end;

function TOcComPortObj.getCMDStr(): String;
var
  LastStr: String;
  jh: integer;
  my: integer;
begin
  LastStr := Trim(LogMemo.Lines.Strings[LogMemo.Lines.Count - 1]);
  jh := Pos('#', LastStr);
  my := Pos('$', LastStr);
  if jh > 0 then
  begin
    Result := Copy(LastStr, jh + 1, Length(LastStr));
  end
  else if my > 0 then
  begin
    Result := Copy(LastStr, my + 1, Length(LastStr));
  end
  else
  begin
    Result := '';
  end;
end;

procedure TOcComPortObj.KeyPress(Sender: TObject; var Key: Char);
var
  CurrentLine: integer;
  // thid: Dword;
  i, j, Len: integer;
  cmd: String;
  LastStr: String;
begin
  if self.connected = false then
  begin
    exit;
  end;
  CurrentLine := LogMemo.CaretPos.Y; // 光标所在的行

  if (Key = #13) then
  begin

    FCommadLineStr := getCMDStr();
    if LogMemo.ReadOnly or (Trim(FCommadLineStr) = '') then
    begin
      LogMemo.ReadOnly := false;
      FalconComSendData_Terminal(' ', self.FSendFormat);
      FCommadLineStr := '';
      Key := #0;
      exit;
    end;

    // CurrentLine := LogMemo.CaretPos.Y;
    // LastStr := Trim(LogMemo.Lines.Strings[CurrentLine]);
    cmd := Trim(FCommadLineStr); // Trim(copy(LastStr,j+3,Length(LastStr)-j+2));
    if cmd <> '' then
    begin
      self.FNeedNewLine := True;
      self.FalconComSendData_Terminal(cmd, self.FSendFormat);
    end;
    FPreCommadLineStr := FCommadLineStr;
    if (FCommandHistory.IndexOf(FPreCommadLineStr) < 0) and (FPreCommadLineStr <> '') then
    begin
      FCommandHistory.Add(FPreCommadLineStr);
      FCommandHistoryIndex := FCommandHistory.Count - 1;
    end;
    FCommadLineStr := '';
    cmd := '';
    Key := #0;
    exit;
  end;

  if (Key = #9) then
  begin
    FCommadLineStr := getCMDStr();
    LastStr := LogMemo.Lines.Strings[CurrentLine];
    cmd := Trim(FCommadLineStr) + Key;
    if cmd = Key then
    begin
      Key := #0;
      exit; // 只有tab
    end;
    Log('');
    FalconComSendData_Terminal(cmd, self.FSendFormat);
    FPreCommadLineStr := FCommadLineStr;
    FCommadLineStr := '';
    Key := #0;
    cmd := '';
  end;

  if Key = #8 then // 删除
  begin
    CurrentLine := LogMemo.CaretPos.Y;
    LastStr := LogMemo.Lines.Strings[CurrentLine];
    Len := Length(Trim(FLastLineStr));
    i := Pos(Trim(FCommadLineStr), LastStr);
    j := Pos(Trim(FPreCommadLineStr), LastStr);

    if (Trim(FCommadLineStr) = Trim(LastStr)) then // 光标最后的空行
    begin
      delete(FCommadLineStr, Length(FCommadLineStr), Length(FCommadLineStr));
      exit;
    end
    else if Length(LastStr) > Len then // 有输入删
    begin
      exit;
    end;

    if (j > 0) then // 最后一行有回显
    begin
      LastStr := LogMemo.Lines.Strings[CurrentLine];
      delete(FPreCommadLineStr, Length(FPreCommadLineStr), Length(FPreCommadLineStr));
    end
    // 当前输入
    else if (i > 0) and (Length(FCommadLineStr) > 0) then
    begin
      delete(FCommadLineStr, Length(FCommadLineStr), Length(FCommadLineStr));
      if (i <= Len) then
        Key := #0;
    end
    else
    begin
      Key := #0;
      exit;
    end;
  end; // if key=#8 then

  if ((Key <> #13) and (Key <> #8) and (Key <> #0)) then
  begin
    // FCommadLineStr := FCommadLineStr + Key;
  end;

  if ((Key = #38) OR (Key = #40)) then
  begin
  end;
end;

procedure TOcComPortObj.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  cmdbuf: array [0 .. 1] of Byte;
  CurrentLine: integer;
  // thid: Dword;
  i, j: integer;
  LastStr: String;
  MaskedKeyState: TShiftState;
begin
  MaskedKeyState := Shift * [ssShift, ssAlt, ssCtrl, ssLeft, ssRight, ssMiddle, ssDouble, ssTouch, ssPen, ssCommand];
  if (Key <> VK_RETURN) and (Key <> VK_PRIOR) and (Key <> VK_NEXT) and (Key <> VK_HOME) and (Key <> VK_END) and (MaskedKeyState = []) then
  begin
    FLogMemo.SelStart := Length(LogMemo.Text);
    FLogMemo.Perform(WM_VSCROLL, SB_BOTTOM, 0);
  end;

  if (Key = VK_LEFT) or (Key = 38) OR (Key = 39) OR (Key = 40) then // 方向键回溯历史
  BEGIN
    CurrentLine := LogMemo.Lines.Count - 1; // LogMemo.CaretPos.y;
    LastStr := LogMemo.Lines.Strings[CurrentLine];
    i := Pos(FCommadLineStr, LastStr);
    j := Pos(FPreCommadLineStr, LastStr);

    if (FCommandHistoryIndex <= 0) and (FCommandHistory.Count > 0) then
      FCommandHistoryIndex := FCommandHistory.Count - 1
    else
      FCommandHistoryIndex := 0;

    if (FCommandHistory.Count <= 0) then
    begin
      Key := 0;
      exit;
    end;

    if (Length(LastStr) > Length(FLastLineStr)) then
      delete(LastStr, Length(FLastLineStr) + 1, Length(LastStr) - Length(FLastLineStr));

    if (i > 1) then
    begin
      LogMemo.Lines.Strings[CurrentLine] := LastStr + FCommandHistory.Strings[FCommandHistoryIndex];
    end
    else if (j > 1) then
    begin
      LogMemo.Lines.Strings[CurrentLine] := LastStr + FCommandHistory.Strings[FCommandHistoryIndex];
    end
    else if (FPreCommadLineStr <> '') then
    begin
      LogMemo.Lines.Strings[CurrentLine] := LastStr + FCommandHistory.Strings[FCommandHistoryIndex];
    end
    else
    begin
      LogMemo.Lines.Strings[CurrentLine] := LastStr + FCommandHistory.Strings[FCommandHistoryIndex];
    end;

    FCommandHistoryIndex := FCommandHistoryIndex - 1;
    Key := 0;
    exit;
  END;

  if (Shift = [ssCtrl]) then
  begin
    if (Key = $43) then // Control+VK_C
    begin
      cmdbuf[0] := $03;
      if (self.connected) and (Trim(LogMemo.SelText) = '') then
        self.FalconComSendBuffer(cmdbuf, 1)
    end
    else if (Key = 70) then // Control+VK_F
    begin

    end
    else if (Key = $56) then // Control+VK_V
    begin
    end;
  end;

  if (Key = $1B) then // ESC
  begin
    if not self.LogMemo.ReadOnly then
      FLogMemo.ReadOnly := True;
  end;
end;

procedure TOcComPortObj.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if (self.LogMemo <> nil) and (LogMemo.Parent <> nil) then
  begin
    if Assigned(FCallBackFun) then
      FCallBackFun();
  end;
end;

procedure TOcComPortObj.RunWindosShellCmd(str: string);
const
  { 设置ReadBuffer的大小 }
  ReadBufferSize = 2400;
var
  Security: TSecurityAttributes;
  ReadPipe, WritePipe: THandle;
  Start: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  Buffer: Pchar;
  BytesRead: Dword;
  // aprun: Dword;
  buf: string;
  cmdstr: string;
begin
  cmdstr := str;
  if Trim(cmdstr) = '' then
    ExitThread(4);

  with Security do
  begin
    nlength := SizeOf(TSecurityAttributes);
    binherithandle := True;
    lpsecuritydescriptor := nil;
  end;
  { 创建一个命名管道用来捕获console程序的输出 }
  if Createpipe(ReadPipe, WritePipe, @Security, 0) then
  begin
    Buffer := AllocMem(ReadBufferSize + 1);
    FillChar(Start, SizeOf(Start), #0);
    { 设置console程序的启动属性 }
    with Start do
    begin
      cb := SizeOf(Start);
      Start.lpReserved := nil;
      lpDesktop := nil;
      lpTitle := nil;
      dwX := 0;
      dwY := 0;
      dwXSize := 0;
      dwYSize := 0;
      dwXCountChars := 0;
      dwYCountChars := 0;
      dwFillAttribute := 0;
      cbReserved2 := 0;
      lpReserved2 := nil;
      hStdOutput := WritePipe; // 将输出定向到我们建立的WritePipe上
      hStdInput := ReadPipe; // 将输入定向到我们建立的ReadPipe上
      hStdError := WritePipe; // 将错误输出定向到我们建立的WritePipe上
      dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
      wShowWindow := SW_HIDE; // 设置窗口为hide
    end;
    try // NORMAL_PRIORITY_CLASS
      { 创建一个子进程，运行console程序 }
      if CreateProcess(nil, Pchar(cmdstr), @Security, @Security, True, REALTIME_PRIORITY_CLASS, nil, nil, Start, ProcessInfo) then
      begin
        { 等待进程运行结束 }
        WaitForSingleObject(ProcessInfo.hProcess, WAIT_TIMEOUT); // INFINITE
        // 关闭输出...开始没有关掉它，结果如果没有输出的话，程序死掉了。
        CloseHandle(WritePipe);

        buf := '';
        // 读取console程序的输出
        repeat
          // application.ProcessMessages;
          BytesRead := 0;
          ReadFile(ReadPipe, Buffer[0], ReadBufferSize, BytesRead, nil);
          Buffer[BytesRead] := #0; // 字符串结束符
          // OemToAnsi(Buffer,Buffer);
          buf := buf + string(Buffer);
        until (BytesRead < ReadBufferSize);
        // When expression returns True, the repeat statement terminates.
        Log(buf);

      end;
    finally
      FreeMem(Buffer);
      TerminateProcess(ProcessInfo.hProcess, 1);
      CloseHandle(ProcessInfo.hProcess);
      CloseHandle(ProcessInfo.hThread);
      CloseHandle(ReadPipe);
      Log(CmdDir + '>');
      ExitThread(4);
    end;
  end;
end;

Initialization

InitializeCriticalSection(Critical);

Finalization

DeleteCriticalSection(Critical);

end.
