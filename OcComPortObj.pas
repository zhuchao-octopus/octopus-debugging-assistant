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
  TRECEIVE_FORMAT = (ASCIIFormat, HexadecimalFormat, Graphic, OctopusProtocol,
    SaveToFile);
  TSEND_FORMAT = (S_ASCIIFormat, S_HexadecimalFormat, S_OctopusProtocol);

const
  INPUT_OUTPUT_BUFFER_SIZE = 2097152; // 1048576;

const
  COM_PROTOCOL_KEEP_MAX_BUFFER_SIZE = 524288; // 1048576;

const
  OCTOPUS_BACKGROUD_STRING_TRIGGERLINE = 80;

const
  RECEIVE_FORMAT_String: array [TRECEIVE_FORMAT] of string =
    ('ASCII Format            字符串 ', 'Hexadecimal Format 十六进制 ',
    'Graphic                   图形 ', 'Octopus Protocol     协议图形 ',
    'File                          文件 ');

  MAX_BAUDRATE_INDEX:integer = 15;

type
  TCallBackFun = Procedure(Count: Integer = 0) of object;
  TProtocolCallBackFun = Procedure(TypeID: Integer) of object;

  TOcComPortObjPara = packed record
    ComportFullName: String;
    Port: String; // change com port;
    BaudRate: Integer;
    DataBits: Integer;
    StopBits: Integer;
    ParityBits: Integer;
    FlowControl: Integer;
    ReceiveFormat: Integer;
    SendFormat: Integer;
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
    // Port: String; // change com port;
    // BaudRate: Integer;
    // DataBits: Integer;
    // StopBits: Integer;
    // ParityBits: Integer;
    // FlowControl: Integer;
    FSendFormat: Integer; // h
    FReceiveFormat: Integer; // i
    FLogMemo: TMemo; // j
    FShowDate: Boolean;
    FShowTime: Boolean;
    FShowLineNumber: Boolean;
    FShowSendingLog: Boolean;
    FHexModeWithString: Boolean; // o
    FHexModeFormatCount: Integer;

    FComReceiveBuffer: array [0 .. INPUT_OUTPUT_BUFFER_SIZE] of Byte;
    // 1024 * 1024 =  1048576 =1M // for com port receive buffer
    FComReceiveInternalBuffer: array of Byte; // for 异步处理
    FFastLineSeries: TFastLineSeries;

    FComReceiveString: String;
    FStringInternalMemo: TMemo;
    FComUIHandleThread: TComUIHandleThread; // 异步线程
    FBackGroundProcessRecordCount: Integer;
    FComHandleThread_Wait: Boolean; // 同步变量
    FComPackParserThread: TComPackParserHandleThread;
    FProtocalData: Integer;
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
    FCommandHistoryIndex: Integer;
    FNeedNewLine: Boolean;
    FLogScrollMode: Boolean;
    procedure OcComPortObjRxChar(Sender: TObject; Count: Integer);
    procedure OcComPortObjRxProtocol(OcComPack2: TOcComPack2);
    function GetLineNumberDateTimeStamp(N: Int64): String;
    function SaveToTheExcelFile(Length: Integer; Rows: Integer): Integer;
    procedure KeyPress(Sender: TObject; var Key: Char);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure RunWindosShellCmd(str: string);
    function GetConfiguration(): TOcComPortObjPara;
  public
    ExcelApp: Variant;

    Constructor Create(AOwner: TComponent; DeviceName: String);
    destructor Destroy; override;
    // procedure OcComPortObjInit(OcComPortObjPara: TOcComPortObjPara);
    procedure OcComPortObjInit2(a, b: String; c, d, e, f, g, h, i: Integer;
      j: TMemo; k, l, m, N, o: Boolean);

    procedure SaveLog(FullLogFilePath: String);
    procedure Log(const Msg: string);
    procedure LogBuff(flag: String; const Buff: Array of Byte; Len: Integer);
    procedure ClearLog();
    procedure ClearInternalBuff(id: Integer = 100);
    procedure PrintReceivedProtocolData(Index: Integer);
    procedure PrintSendProtocolPack(OcComPack: TOcComPack);
    function IsLogBottom(): Boolean;
    procedure LogBottomMod(const Msg: string; appendMod: Boolean;
      bottomMod: Boolean);

    procedure RequestProtocolConnection(); // 发送连接请求
    procedure SendProtocolACK(); // 发送ACK
    function SendProtocolData(Buffer: Array Of Byte; Count: Integer;
      TypeID: Word; NeedACK: Boolean): Boolean;
    function GetPacks(): Integer;

    property OcComPortObjPara: TOcComPortObjPara read GetConfiguration;
    property LogMemo: TMemo read FLogMemo write FLogMemo;
    property StringInternalMemo: TMemo read FStringInternalMemo
      write FStringInternalMemo;
    property CallBackFun: TCallBackFun read FCallBackFun write FCallBackFun;
    property ProtocolCallBackFun: TProtocolCallBackFun read FProtocolCallBackFun
      write FProtocolCallBackFun;
    property ComReceiveCount: Int64 read FComReceiveCount;
    property ComProcessedCount: Int64 read FComProcessedCount;
    property ComSentCount: Int64 read FComSentCount;
    property ComHandleThread_AsynCount: Integer
      read FBackGroundProcessRecordCount write FBackGroundProcessRecordCount
      default OCTOPUS_BACKGROUD_STRING_TRIGGERLINE;
    property HexModeFormatCount: Integer read FHexModeFormatCount
      write FHexModeFormatCount default 16;
    property FileStream: TFileStream read FFileStream write FFileStream
      default nil;
    property FileStreamName: String read FFileStreamName write FFileStreamName;
    property ProtocalData: Integer read FProtocalData write FProtocalData
      default -1;
    property FastLineSeries: TFastLineSeries read FFastLineSeries
      write FFastLineSeries;

    property ReceiveFormat: Integer read FReceiveFormat write FReceiveFormat;
    property SendFormat: Integer read FSendFormat write FSendFormat default 0;

    property CompatibleUnicode: Boolean read FCompatibleUnicode
      write FCompatibleUnicode default True;
    property NeedCRC16: Boolean read FNeedCRC16 write FNeedCRC16 default false;
    property ShowSendedLog: Boolean read FShowSendingLog write FShowSendingLog;
    property ShowLineNumber: Boolean read FShowLineNumber write FShowLineNumber;
    property LogScrollMode: Boolean read FLogScrollMode write FLogScrollMode
      default True;

    function FalconComSendBuffer(Buffer: array of Byte; Len: Integer): Bool;
    function FalconComSendData_Common(str: string; SendFormat: Integer): Bool;
    function FalconComSendData_Terminal(str: string; SendFormat: Integer): Bool;
    function FalconComSendData_MultiTimes(str: string;
      SendFormat: Integer): Bool;
  end;

  TComUIHandleThread = class(TThread)
  private
    FOcComPortObj: TOcComPortObj;
    FUIStartIndex: Int64;
    FNeedToReset: Integer;
    // FThreadSync_BusyFlag:Boolean;
  protected
    constructor Create(OcComPortObj: TOcComPortObj);
    procedure Execute; override;
  public
    property ResetID: Integer read FNeedToReset write FNeedToReset default -1;
  end;

  TComPackParserHandleThread = class(TThread)
  private
    FOcComPortObj: TOcComPortObj;
    FOcComProtocal: TOcComProtocal;
    FStartIndex: Int64;
  protected
    constructor Create(OcComPortObj: TOcComPortObj;
      OcComProtocal: TOcComProtocal);
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

// uses unit100;

function readFileToStream(FileName: String): TFileStream;
var
  FileStream: TFileStream;
begin
  Result := nil;
  try
    FileStream := TFileStream.Create(FileName, fmOpenReadWrite or
      fmShareExclusive);
    FileStream.Position := 0;
    Result := FileStream;
  except
  end;
end;

function writeFileToStream(FileStream: TFileStream; Buffer: array of Byte;
  Len: Integer): Integer;
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
  i1, i2: Integer;
  pStr: Pchar;
  match: TMatch;
begin
  str := Trim(str);
  // match:=TRegEx.Match(str,pattern);
  // if match.Success then
  // ss:=match.Value;

  // pStr := StrRScan(Pchar(str), '(');
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

function CharToDigit(c: Char): Byte; // 字符表示的数，而不是对应的ASCII 值
begin
  case c of
    '0' .. '9':
      Result := Ord(c) - 48;
    'A' .. 'F':
      Result := Ord(c) - Ord('A') + 10;
    'a' .. 'f':
      Result := Ord(c) - Ord('a') + 10;
  else
    Result := 0;
  end;
end;

function CharToByte(c1, c2: Char): Byte;
begin
  Result := CharToDigit(c1) * 16 + CharToDigit(c2);
end;

function FormatHexStrToByte(hs: string; var buf: array of Byte): string;
var
  i, Len: Word;
begin
  Result := '';
  Len := (Length(hs) + 2) div 3;
  ZeroMemory(@buf, Len * 2);

  for i := 1 to Len do
  begin
    buf[i - 1] := CharToByte(hs[i * 3 - 2], hs[i * 3 - 1]);
  end;
  for i := 1 to Len do
  begin
    Result := Result + Format('%.02x ', [buf[i - 1]]);
  end;
end;

function GetSystemDateTimeStampStr2(types: Integer): string;
var
  LocalSystemTime: _SYSTEMTIME;
  d, t: String;
begin
  Result := '';
  GetLocalTime(LocalSystemTime);
  if types = 0 then // 日期
  begin
    d := Format('[%0.4d%0.2d%0.2d]', [LocalSystemTime.wYear,
      LocalSystemTime.wMonth, LocalSystemTime.wDay]);
    Result := d + ' ';
  end;
  if types = 1 then // 时间
  begin
    t := Format('[%0.2d:%0.2d:%0.2d]', [LocalSystemTime.wHour,
      LocalSystemTime.wMinute, LocalSystemTime.wSecond]);
    Result := t + ' ';
  end;

  if types = 2 then
  begin
    d := Format('[%0.4d%0.2d%0.2d', [LocalSystemTime.wYear,
      LocalSystemTime.wMonth, LocalSystemTime.wDay]);
    t := Format('%0.2d:%0.2d:%0.2d]', [LocalSystemTime.wHour,
      LocalSystemTime.wMinute, LocalSystemTime.wSecond]);
    Result := d + ' ' + t + ' ';
  end;
end;

function GetLineNumberStrForLog(LineNumber: Int64): string;
begin
  // Result := '';
  if (LineNumber < 0) then
    LineNumber := 0;
  if LineNumber < 100 then
    Result := Format('%0.2d| ', [LineNumber])
  else if LineNumber < 1000 then
    Result := Format('%0.3d| ', [LineNumber])
  else if LineNumber < 10000 then
    Result := Format('%0.4d| ', [LineNumber])
  else if LineNumber < 100000 then
    Result := Format('%0.5d| ', [LineNumber])
  else if LineNumber < 1000000 then
    Result := Format('%0.6d| ', [LineNumber])
  else if LineNumber < 10000000 then
    Result := Format('%0.7d| ', [LineNumber])
  else
    Result := Format('%0.8d| ', [LineNumber])
end;

function ByteToWideString2(Buff: pbyte; Len: Integer): String; // 不要回车换行#13#10
var
  str: AnsiString;
begin
  try
    SetLength(str, Len + 1);
    CopyMemory(@str[1], Buff, Len);
    str := StringReplace(str, chr(13) + chr(10), '', [rfReplaceAll]); // 删除回车
    Result := Trim(str);
  Except
  end;
end;

constructor TComPackParserHandleThread.Create(OcComPortObj: TOcComPortObj;
  OcComProtocal: TOcComProtocal); // 数据特殊处理线程后台进行
begin
  inherited Create(True); // 先挂起
  FStartIndex := 0;
  self.FOcComPortObj := OcComPortObj;
  self.Suspended := True;
  FOcComProtocal := OcComProtocal;
end;

procedure TComPackParserHandleThread.StopReSetClear();
var
  f: Boolean;
begin
  f := self.Suspended;
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
  s: String;
begin
  // j:=0;
  s := '';
  while (self.Terminated = false) do
  begin
    if (self.FOcComProtocal.GetLastPackHead.TypeID = OCCOMPROTOCAL_DATA2) then
    begin
      // 非标准超大数据包处理
      if (Length(FOcComPortObj.FComReceiveInternalBuffer) - FStartIndex <
        self.FOcComProtocal.GetLastPackHead.Length) then
        Continue; // 没有完成继续处理

      FStartIndex := FStartIndex + self.FOcComProtocal.GetLastPackHead.Length;
      // 超大数据包处理完毕，跳过
    end;

    try
      if Length(FOcComPortObj.FComReceiveInternalBuffer) >= SizeOf(TOcComPack2)
      then
      begin
        j := self.FOcComProtocal.ParserPack
          (@FOcComPortObj.FComReceiveInternalBuffer[FStartIndex],
          Length(FOcComPortObj.FComReceiveInternalBuffer) - FStartIndex);
        FStartIndex := FStartIndex + j;
      end
      else
      begin
        self.Suspended := True; // 数据不足，挂起休眠
      end;
    except
    end;

    // if FStartIndex > Length(FOcComPortObj.FComReceiveInternalBuffer)-SizeOf(TOcComPack2) then //解析完毕
    if self.FOcComProtocal.
      IsParserComplete { and (Length(FOcComPortObj.FComReceiveInternalBuffer) > 0) }
    then // 解析任务完毕，清缓存
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
  s: String;
begin
  j := 0;
  s := '';
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
        if Trim(FOcComPortObj.LogMemo.Lines.Strings
          [FOcComPortObj.LogMemo.Lines.Count - 1]) = '' then
        begin
          // FOcComPortObj.LogMemo.Lines.Delete(FOcComPortObj.LogMemo.Lines.Count-1);
          s := FOcComPortObj.GetLineNumberDateTimeStamp(FOcComPortObj.LogMemo.Lines.Count - 1) +Trim(FOcComPortObj.StringInternalMemo.Lines.Strings[FUIStartIndex]);

          FOcComPortObj.LogMemo.Lines.Strings[FOcComPortObj.LogMemo.Lines.Count - 1] := s;
        end
        else if (Length(s) > 0) and (s[1] = #10) then // #13#10,分开发送导致无法正确的换行
          FOcComPortObj.LogMemo.Lines.Add(s)
        else
          FOcComPortObj.LogMemo.Lines.Strings[FOcComPortObj.LogMemo.Lines.Count - 1] := FOcComPortObj.LogMemo.Lines.Strings
            [FOcComPortObj.LogMemo.Lines.Count - 1] + Trim(FOcComPortObj.StringInternalMemo.Lines.Strings[FUIStartIndex]);
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
        s := s + Format('%.02x ',
          [FOcComPortObj.FComReceiveInternalBuffer[FUIStartIndex]]);
        INC(FOcComPortObj.FComProcessedCount);
        if FOcComPortObj.FHexModeFormatCount > 0 then
        begin
          if ((FUIStartIndex + 1) mod FOcComPortObj.FHexModeFormatCount) = 0
          then
          begin
            j := FUIStartIndex + 1;
            if FOcComPortObj.FHexModeWithString then
              s := Trim(s) + '            ' + ByteToWideString2
                (@FOcComPortObj.FComReceiveInternalBuffer
                [FUIStartIndex - FOcComPortObj.FHexModeFormatCount + 1],
                FOcComPortObj.FHexModeFormatCount);
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
            if FOcComPortObj.FHexModeFormatCount > 0 then
            begin
              s := Format('%-' + IntToStr(FOcComPortObj.FHexModeFormatCount * 3)
                + 's', [s]);
              s := s + '           ' + ByteToWideString2
                (@FOcComPortObj.FComReceiveInternalBuffer[j],
                FOcComPortObj.FHexModeFormatCount);
            end
            else
              s := Trim(s) + '            ' + ByteToWideString2
                (@FOcComPortObj.FComReceiveInternalBuffer[j],
                Length(FOcComPortObj.FComReceiveInternalBuffer) - j)
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
      if FUIStartIndex < Length(FOcComPortObj.FComReceiveInternalBuffer) then
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
      end;
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
  FComPackParserThread := TComPackParserHandleThread.Create(self,
    FOcComProtocal);
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
var
  FOcComPortObjPara: TOcComPortObjPara;
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

procedure TOcComPortObj.OcComPortObjInit2(a, b: String;
  c, d, e, f, g, h, i: Integer; j: TMemo; k, l, m, N, o: Boolean);
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
  LogMemo.OnMouseDown:=Self.MouseDown;
  FNeedNewLine := True;
end;

{
  procedure TOcComPortObj.OcComPortObjInit(OcComPortObjPara: TOcComPortObjPara);
  begin
  self.OnRxChar := OcComPortObjRxChar;
  self.FComportFullName := OcComPortObjPara.ComportFullName;
  self.FReceiveFormat := OcComPortObjPara.ReceiveFormat;
  self.FSendFormat := OcComPortObjPara.SendFormat;
  self.LogMemo := OcComPortObjPara.LogMemo;
  self.FShowDate := OcComPortObjPara.ShowDate;
  self.FShowTime := OcComPortObjPara.ShowTime;
  self.FShowLineNumber := OcComPortObjPara.ShowLineNumber;
  self.FShowSendedLog := OcComPortObjPara.ShowSendedLog;
  self.FHexModeWithString := OcComPortObjPara.HexModeWithString;
  self.Port := OcComPortObjPara.Port;
  self.BaudRate := TBaudRate(OcComPortObjPara.BaudRate);
  self.DataBits := TDataBits(OcComPortObjPara.DataBits);
  self.StopBits := TStopBits(OcComPortObjPara.StopBits);
  self.Parity.Bits := TParityBits(OcComPortObjPara.ParityBits);
  self.FlowControl.FlowControl := TFlowControl(OcComPortObjPara.FlowControl);
  end; }

procedure TOcComPortObj.ClearInternalBuff(id: Integer = 100);
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
    FComPackParserThread.StopReSetClear;
    if Assigned(FCallBackFun) then
      FCallBackFun();
  end;
end;

procedure TOcComPortObj.LogBuff(flag: String; const Buff: Array of Byte;
  Len: Integer);
var
  str: String;
  i: Integer;
begin
  str := '';
  for i := Low(Buff) to Len - 1 do
    str := str + Format('%.02x ', [Buff[i]]);
  Log(flag + str);
end;

procedure TOcComPortObj.Log(const Msg: string);
var
  i, PreLogLinesCount: Int64;
  str: String;
  isBottom:boolean;
begin
  if (LogMemo = nil) or (LogMemo.Parent = nil) then
  begin
    Exit;
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

// for send file 默认 十六进制发送
function TOcComPortObj.FalconComSendBuffer(Buffer: array of Byte;
  Len: Integer): Bool;
begin
  Result := True;
  if self.connected then
  begin
    try
      self.Write(Buffer, Len);
      FComSentCount := FComSentCount + Len;
    except
      Log('Sorry Write to device fail!!');
      Exit;
    end;
  end
  else
  begin
    Log('Device was closed,please open a device.');
    Exit;
  end;
end;

procedure TOcComPortObj.LogBottomMod(const Msg: string; appendMod: Boolean;
  bottomMod: Boolean);
var
  i, PreLogLinesCount: Int64;
  str: String;
begin
  if (LogMemo = nil) or (LogMemo.Parent = nil) then
  begin
    Exit;
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
    begin //bottomMod 底部跟踪模式
      LogMemo.Lines.Add(Msg);
    end;
  end
  else
  begin
    if (not bottomMod) then
    begin
      LogMemo.Lines.BeginUpdate;
      LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] := LogMemo.Lines.Strings
        [LogMemo.Lines.Count - 1] + Msg;
      LogMemo.Lines.EndUpdate;
    end
    else
    begin //bottomMod 底部跟踪模式
      LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] := LogMemo.Lines.Strings
        [LogMemo.Lines.Count - 1] + Msg;
    end;
  end;
end;

function TOcComPortObj.IsLogBottom(): Boolean;
var
  SF: TScrollInfo;
  currentPos: Integer;
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

// 一般发送
function TOcComPortObj.FalconComSendData_Common(str: string;
  SendFormat: Integer): Bool;
var
  buf: array [0 .. 1023] of Byte;
  Len: Word;
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
          Log('> ' + tempstr) // 十六进制接收采用单行LOG 的方式，会自起新行。
        else
          Log('> ' + str); // new ling in memo for receive data 发送字符串,后面自带换行
      end;

      try
        self.writestr(str);
        FComSentCount := FComSentCount + Length(str);
      except
        Result := false;
        Log('Sorry Write to device fail!!');
        Exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      Exit;
    end;
    Exit;
  end;
  if SendFormat = Ord(S_HexadecimalFormat) then
  begin
    if self.connected then
    begin
      s := FormatHexStrToByte(Trim(str), buf);
      Len := (Length(str) + 2) div 3;
      if FShowSendingLog then
      begin
        Log('> ' + s);
        Log(''); // new line prepare to receive
      end;

      try
        self.Write(buf, Len);
        FComSentCount := FComSentCount + Len;
      except
        Log('Sorry Write to device fail!!');
        Exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      Exit;
    end;
  end;
  if SendFormat = Ord(S_OctopusProtocol) then
  begin
    s := FormatHexStrToByte(Trim(str), buf);
    Len := (Length(str) + 2) div 3;
    SendProtocolData(buf, Len, OCCOMPROTOCAL_DATA1, false);
  end;
end;

// 终端模式发送
function TOcComPortObj.FalconComSendData_Terminal(str: string;
  SendFormat: Integer): Bool;
var
  buf: array [0 .. 1023] of Byte;
  Len: Word;
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
        Exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      Exit;
    end;
    Exit;
  end;
  if SendFormat = Ord(S_HexadecimalFormat) then
  begin
    if self.connected then
    begin
      s := FormatHexStrToByte(Trim(str), buf);
      Len := (Length(str) + 2) div 3;
      try
        self.Write(buf, Len);
        FComSentCount := FComSentCount + Len;
      except
        Log('Sorry Write to device fail!!');
        Exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      Exit;
    end;
  end;
  if SendFormat = Ord(S_OctopusProtocol) then
  begin
    s := FormatHexStrToByte(Trim(str), buf);
    Len := (Length(str) + 2) div 3;
    self.SendProtocolData(buf, Len, OCCOMPROTOCAL_DATA1, false);
  end;
end;

// 多次发送 ,块发送，循环发送，区别是不另外预留新行供接收使用
function TOcComPortObj.FalconComSendData_MultiTimes(str: string;
  SendFormat: Integer): Bool;
var
  buf: array [0 .. 1023] of Byte;
  Len: Word;
  s: string;
begin
  Result := True;
  if SendFormat = Ord(S_ASCIIFormat) then // send string ascci char
  begin
    str := str + #13#10;
    if self.connected then
    begin
      if FShowSendingLog then
        Log('> ' + str);

      try
        self.writestr(str);
        FComSentCount := FComSentCount + Length(str);
      except
        Result := false;
        Log('Sorry Write to device fail!!');
        Exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      Exit;
    end;
    Exit;
  end;
  if SendFormat = Ord(S_HexadecimalFormat) then
  begin
    if self.connected then
    begin
      s := FormatHexStrToByte(Trim(str), buf);
      Len := (Length(str) + 2) div 3;
      if FShowSendingLog then
        Log('> ' + s);

      try
        self.Write(buf, Len);
        FComSentCount := FComSentCount + Len;
      except
        Log('Sorry Write to device fail!!');
        Exit;
      end;
    end
    else
    begin
      Log('Device was closed,please open a device.');
      Exit;
    end;
  end;

  if SendFormat = Ord(S_OctopusProtocol) then
  begin
    s := FormatHexStrToByte(Trim(str), buf);
    Len := (Length(str) + 2) div 3;
    self.SendProtocolData(buf, Len, OCCOMPROTOCAL_DATA1, false);
  end;
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
    Exit;
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

function TOcComPortObj.SaveToTheExcelFile(Length: Integer;
  Rows: Integer): Integer;
var
  FileName: String;
  i: Integer;
begin
  if Rows = 0 then
    Rows := 1;
  Result := Rows;
  if Length = 0 then
    Exit;

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

procedure TOcComPortObj.OcComPortObjRxChar(Sender: TObject; Count: Integer);
var
  i, Index: Integer;
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
          FComReceiveString := StringReplace(FComReceiveString, #10, #13#10,
            [rfReplaceAll]);
        if (Pos(#13, FComReceiveString) > 0) then
          FComReceiveString := StringReplace(FComReceiveString, #$D, #13#10,
            [rfReplaceAll]);
      end;
    Except
    end;

    if FShowLineNumber or FShowDate or FShowTime then
    begin
      FComHandleThread_Wait := True;
      EnterCriticalSection(Critical);
      StringInternalMemo.Lines.BeginUpdate;
      StringInternalMemo.Lines.Strings[StringInternalMemo.Lines.Count - 1] :=
        StringInternalMemo.Lines.Strings[StringInternalMemo.Lines.Count - 1] +
        FComReceiveString;
      StringInternalMemo.Lines.EndUpdate;
      self.FComHandleThread_Wait := false;
      LeaveCriticalSection(Critical);
      if StringInternalMemo.Lines.Count >= FBackGroundProcessRecordCount then
      begin
        if FComUIHandleThread.Suspended then
          FComUIHandleThread.Suspended := false; // 启动后台线程
        Exit;
      end;
      if (FComUIHandleThread.Suspended = false) then // 后台正在处理数据
        Exit; // 数据转入后台处理，等待后台线程处理完成
      if (FComUIHandleThread.Suspended) then // 无需后台处理数据，或者后台数据处理完成，事情做完了就挂起
      begin
        ClearInternalBuff(); // 不能少，清楚后台BUFFER ，转入前台处理
        PreLogLinesCount := LogMemo.Lines.Count;

        LogMemo.Lines.BeginUpdate;

        if (FComReceiveString[1] = #13) or (FComReceiveString[1] = #10) then
          // #13#10,分开发送导致无法正确的换行
          //LogMemo.Lines.Add(FComReceiveString)
          LogBottomMod(FComReceiveString, True, isBottom)
        else //自动分行
           LogBottomMod(FComReceiveString, false, isBottom);
          //LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] := LogMemo.Lines.Strings[LogMemo.Lines.Count - 1] + FComReceiveString;

        ////////////////////////////////////////////////////////////////////////
        //显示行号
        for i := PreLogLinesCount to LogMemo.Lines.Count - 1 do
        begin
          LogMemo.Lines.Strings[i] := GetLineNumberDateTimeStamp(i) +
            LogMemo.Lines.Strings[i];
        end;

        LogMemo.Lines.EndUpdate;

        FComProcessedCount := FComProcessedCount + Length(FComReceiveString);
        FLastLineStr := LogMemo.Lines.Strings[LogMemo.Lines.Count - 1];
        if Assigned(FCallBackFun) then
          FCallBackFun();
      end;
    end
    else
    begin // 无需特殊处理，不额外显示日期日期信息
      if FNeedNewLine then
      begin
        if (FComReceiveString[Length(FComReceiveString)] = #13) or
          (FComReceiveString[Length(FComReceiveString)] = #10) then // \r\n
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
        if (FComReceiveString[Length(FComReceiveString)] = #13) or
          (FComReceiveString[Length(FComReceiveString)] = #10) then // \r\n
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
      if Assigned(FCallBackFun) then
        FCallBackFun();
    end;
  end
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
    SetLength(FComReceiveInternalBuffer,
      Length(FComReceiveInternalBuffer) + Count);
    CopyMemory(@FComReceiveInternalBuffer[Length(FComReceiveInternalBuffer) -
      Count], @FComReceiveBuffer, Count);
    // LeaveCriticalSection(Critical);
    FComHandleThread_Wait := false;
    if FComUIHandleThread.Suspended then
    begin
      FComUIHandleThread.Suspended := false; // 启动UI工作线程
    end;
  end
  /// ////hex format
  else if FReceiveFormat = Ord(Graphic) then // receive as Graphic
  begin
    ZeroMemory(@FComReceiveBuffer, SizeOf(FComReceiveBuffer));
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
    end;
  end
  else if FReceiveFormat = Ord(OctopusProtocol) then
  // receive as OctopusProtocol pack
  begin
    ZeroMemory(@FComReceiveBuffer, SizeOf(FComReceiveBuffer));
    FComHandleThread_Wait := True;
    try
      FComProcessedCount := FComProcessedCount + self.
        Read(FComReceiveBuffer, Count);
      // self.Read(FComReceiveBuffer, Count);
    Except
    end;

    FComHandleThread_Wait := True;
    EnterCriticalSection(Critical);
    if Length(FComReceiveInternalBuffer) = 0 then
      self.ClearInternalBuff;
    SetLength(FComReceiveInternalBuffer,
      Length(FComReceiveInternalBuffer) + Count);
    CopyMemory(@FComReceiveInternalBuffer[Length(FComReceiveInternalBuffer) -
      Count], @FComReceiveBuffer, Count);
    LeaveCriticalSection(Critical);
    self.FComHandleThread_Wait := false;
    if (FComPackParserThread.Suspended) { and (FProtocalData > 0) } then
    begin
      FComPackParserThread.Suspended := false; // 启动协议解析线程
    end;
  end
  else if FReceiveFormat = Ord(SaveToFile) then // for File save to file
  begin
    if (CompareText(ExtractFileExt(self.FileStreamName), '.txt') = 0) or
      (CompareText(ExtractFileExt(self.FileStreamName), '.log') = 0) then
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
      if Assigned(FCallBackFun) then
        FCallBackFun();
    end
    else if (CompareText(ExtractFileExt(self.FileStreamName), '.xls') = 0) or
      (CompareText(ExtractFileExt(self.FileStreamName), '.xlsx') = 0) then
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
        FComProcessedCount := FComProcessedCount + FileStream.
          Write(Buff, Count);

        if Assigned(FCallBackFun) then
          FCallBackFun();
      end
    end;
  end;

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
var
  b: array of Byte;
begin
  SendProtocolData(b, 0, OCCOMPROTOCAL_START, false);
end;

procedure TOcComPortObj.SendProtocolACK();
var
  b: array of Byte;
begin
  SendProtocolData(b, 0, OCCOMPROTOCAL_ACK, false);
end;

function TOcComPortObj.SendProtocolData(Buffer: Array Of Byte; Count: Integer;
  TypeID: Word; NeedACK: Boolean): Boolean;
var
  p: pbyte;
  OcComPack: TOcComPack;
  OcComPack2: TOcComPack2;
  po: POcComPack;
  Len: Integer;
  // b:Array of Byte;
  packs, i, psize, j: Integer;
  PaLoad_Length: Integer;
begin
  OcComPack := self.FOcComProtocal.CreatePack(TypeID);
  Result := True;
  PaLoad_Length := OCCOMPROTOCAL_PACK_PACKPAYLOAD_HIGHT + 1;
  case OcComPack.TypeID of
    OCCOMPROTOCAL_START, OCCOMPROTOCAL_OVER, OCCOMPROTOCAL_ACK:
      begin
        psize := SizeOf(TOcComPack2); // 包头长度 + 有效符合+ CRC
        OcComPack.Length := psize;
        OcComPack.Index := 0;
        OcComPack.Total := 1;
        p := @OcComPack;
        self.FalconComSendBuffer(p^, OcComPack.Length);
        if FShowSendingLog then
          LogBuff('> ', p^, OcComPack.Length);
      end;
    OCCOMPROTOCAL_I2C_READ, OCCOMPROTOCAL_I2C_WRITE, OCCOMPROTOCAL_SPI_READ,
      OCCOMPROTOCAL_SPI_WRITE, OCCOMPROTOCAL_DATA1:
      begin

        Len := Count; // Length(Buffer); //暂时不考虑分包的问题 注意包的最大总长度限制
        packs := 1; // 默认情况下一个包处理
        if Len > PaLoad_Length then // 需要分包
        begin
          packs := (Len div PaLoad_Length);
          if (Len mod PaLoad_Length) > 0 then
            packs := packs + 1;
        end
        else
          packs := 1;
        j := 0;
        for i := 0 to packs - 1 do
        begin
          j := PaLoad_Length * i;
          if j >= Len then
            break;

          po := @OcComPack;
          po.Head := OCCOMPROTOCAL_HEAD;

          if NeedACK then
          begin
            po.TypeID := OCCOMPROTOCAL_ACK;
            po.TypeID := (po.TypeID shl 8) + TypeID;
          end
          else
            po.TypeID := TypeID;

          po.Index := i;
          po.Total := packs;
          po.Length := SizeOf(TOcComPack);

          if i = packs - 1 then
          begin
            PaLoad_Length := Len - j;
            po.Length := SizeOf(TOcComPack2) + PaLoad_Length + 2;
            // 包头长度 + 有效符合+ CRC
          end;
          CopyMemory(@po.data[0], @Buffer[j], PaLoad_Length);

          if FNeedCRC16 then
            po.CRC := self.FOcComProtocal.CalCRC16(po.data, PaLoad_Length)
          else
            po.CRC := OCCOMPROTOCAL_END;

          p := @OcComPack;
          self.FalconComSendBuffer(p^, po.Length); // 发送
          if FShowSendingLog then
            self.PrintSendProtocolPack(OcComPack);
          // LogBuff('>',p^,po.Length);
          if NeedACK then
          begin
            CopyMemory(@OcComPack2, @OcComPack, SizeOf(TOcComPack2));
            Result := self.FOcComProtocal.WaitingForACK(OcComPack2, 5000);
            if Result = false then
              Exit;
          end;
        end; // for

      end; // OCCOMPROTOCAL_DATA1:
  end; // case
end;

procedure TOcComPortObj.OcComPortObjRxProtocol(OcComPack2: TOcComPack2);
begin
  case OcComPack2.TypeID of
    OCCOMPROTOCAL_ACK: // 客户端简单应答，表示可以连接 //收到应答
      begin

      end;
    OCCOMPROTOCAL_READY: // 客户端已经就绪，可以操作
      begin

      end;
    OCCOMPROTOCAL_DATA1: // 收到客户端的数据包
      begin

      end;
    OCCOMPROTOCAL_DATA2: // 收到客户端的非标准数据包
      begin

      end;
    OCCOMPROTOCAL_OVER: // 接收完毕 一个大的任务完成
      begin

      end;
    OCCOMPROTOCAL_GOT: // 客户端收到数据包后发回的收到应答 ，以便发送下一个包
      begin

      end
  else
    begin

    end;
  end;
  // FComProcessedCount:=FComProcessedCount+OcComPack2.Length;
  if Assigned(FCallBackFun) then
    FCallBackFun();
  PrintReceivedProtocolData(-1); // 输出最新收到的包 ，非保准超大数据包没有保存，
end;

procedure TOcComPortObj.PrintSendProtocolPack(OcComPack: TOcComPack);
var
  j: Integer;
  str: String;
begin
  str := '> ';
  str := str + Format('%.04x ', [OcComPack.Head]);
  str := str + Format('%.04x ', [OcComPack.TypeID]);
  str := str + Format('%.04x ', [OcComPack.Index]);
  str := str + Format('%.04x ', [OcComPack.Total]);
  str := str + Format('%.04x, ', [OcComPack.Length]);
  for j := 0 to OcComPack.Length - SizeOf(TOcComPack2) - 1 - 2 do
  begin
    str := str + Format('%.02x ', [OcComPack.data[j]]);
  end;
  str := str + Format('%.04x ', [OcComPack.CRC]);
  self.Log(str + #13#10);
end;

procedure TOcComPortObj.PrintReceivedProtocolData(Index: Integer);
var
  i, j, v: Integer;
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
    str := str + Format('%.04x ',
      [self.FOcComProtocal.GetPackByIndex(i).TypeID]);
    str := str + Format('%.04x ',
      [self.FOcComProtocal.GetPackByIndex(i).Index]);
    str := str + Format('%.04x ',
      [self.FOcComProtocal.GetPackByIndex(i).Total]);
    // str:=str+Format('%.02x ', [self.FOcComProtocal.FPackList[i].CRC]);
    str := str + Format('%.04x, ',
      [self.FOcComProtocal.GetPackByIndex(i).Length]);
    for j := 0 to self.FOcComProtocal.GetPackByIndex(i).Length -
      SizeOf(TOcComPack2) - 1 do
    begin
      str := str + Format('%.02x ',
        [self.FOcComProtocal.GetPackByIndex(i).data[j]]);
    end;
    self.Log(str);

    v := FOcComProtocal.GetBytesValue(i);
    if (v > 65525) then
      v := 65535;

    FastLineSeries.AddY(v);
    str := '';
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

function TOcComPortObj.GetPacks: Integer;
begin
  Result := self.FOcComProtocal.PackList_RB_Count;
end;

procedure TOcComPortObj.KeyPress(Sender: TObject; var Key: Char);
var
  CurrentLine: Integer;
  // thid: Dword;
  i, j, Len: Integer;
  cmd: String;
  LastStr: String;
begin
  if self.connected = false then
  begin
    Exit;
  end;
  CurrentLine := LogMemo.CaretPos.y; // 光标所在的行

  if (Key = #13) then
  begin
    if LogMemo.ReadOnly or (Trim(FCommadLineStr) = '') then
    begin
      LogMemo.ReadOnly := false;
      FalconComSendData_Terminal(' ', self.FSendFormat);
      FCommadLineStr := '';
      Key := #0;
      Exit;
    end;

    CurrentLine := LogMemo.CaretPos.y;
    LastStr := Trim(LogMemo.Lines.Strings[CurrentLine]);
    cmd := Trim(FCommadLineStr); // Trim(copy(LastStr,j+3,Length(LastStr)-j+2));
    if cmd <> '' then
    begin
      self.FNeedNewLine := True;
      self.FalconComSendData_Terminal(cmd, self.FSendFormat);
    end;
    FPreCommadLineStr := FCommadLineStr;
    if (FCommandHistory.IndexOf(FPreCommadLineStr) < 0) and
      (FPreCommadLineStr <> '') then
    begin
      FCommandHistory.Add(FPreCommadLineStr);
      FCommandHistoryIndex := FCommandHistory.Count - 1;
    end;
    FCommadLineStr := '';
    cmd := '';
    Key := #0;
    Exit;
  end;

  if (Key = #9) then
  begin
    LastStr := LogMemo.Lines.Strings[CurrentLine];
    cmd := Trim(FCommadLineStr) + Key;
    if cmd = Key then
    begin
      Key := #0;
      Exit; // 只有tab
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
    CurrentLine := LogMemo.CaretPos.y;
    LastStr := LogMemo.Lines.Strings[CurrentLine];
    Len := Length(Trim(FLastLineStr));
    i := Pos(Trim(FCommadLineStr), LastStr);
    j := Pos(Trim(FPreCommadLineStr), LastStr);
    if (Trim(FCommadLineStr) = Trim(LastStr)) then // 光标最后的空行
    begin
      delete(FCommadLineStr, Length(FCommadLineStr), Length(FCommadLineStr));
      Exit;
    end
    else if Length(LastStr) > Len then // 有输入删
    begin
      Exit;
    end;
    if (j > 0) then // 最后一行有回显
    begin
      LastStr := LogMemo.Lines.Strings[CurrentLine];
      delete(FPreCommadLineStr, Length(FPreCommadLineStr),
        Length(FPreCommadLineStr));
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
      Exit;
    end;
  end; // if key=#8 then

  if ((Key <> #13) and (Key <> #8) and (Key <> #0)) then
  begin
    FCommadLineStr := FCommadLineStr + Key;
  end;

  if ((Key = #38) OR (Key = #40)) then
  begin
  end;
end;

procedure TOcComPortObj.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  cmdbuf: array [0 .. 1] of Byte;
  CurrentLine: Integer;
  thid: Dword;
  i, j: Integer;
  LastStr: String;
  MaskedKeyState: TShiftState;
begin
  MaskedKeyState := Shift * [ssShift, ssAlt, ssCtrl, ssLeft, ssRight, ssMiddle,
    ssDouble, ssTouch, ssPen, ssCommand];
  if (Key <> VK_RETURN) and (Key <> VK_PRIOR) and (Key <> VK_NEXT) and
    (Key <> VK_HOME) and (Key <> VK_END) and (MaskedKeyState = []) then
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
      Exit;
    end;

    if (Length(LastStr) > Length(FLastLineStr)) then
      delete(LastStr, Length(FLastLineStr) + 1,
        Length(LastStr) - Length(FLastLineStr));

    if (i > 1) then
    begin
      LogMemo.Lines.Strings[CurrentLine] := LastStr + FCommandHistory.Strings
        [FCommandHistoryIndex];
    end
    else if (j > 1) then
    begin
      LogMemo.Lines.Strings[CurrentLine] := LastStr + FCommandHistory.Strings
        [FCommandHistoryIndex];
    end
    else if (FPreCommadLineStr <> '') then
    begin
      LogMemo.Lines.Strings[CurrentLine] := LastStr + FCommandHistory.Strings
        [FCommandHistoryIndex];
    end
    else
    begin
      LogMemo.Lines.Strings[CurrentLine] := LastStr + FCommandHistory.Strings
        [FCommandHistoryIndex];
    end;

    FCommandHistoryIndex := FCommandHistoryIndex - 1;
    Key := 0;
    Exit;
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

procedure TOcComPortObj.MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (Self.LogMemo <> nil) and (LogMemo.Parent <> nil) then
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
  start: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  Buffer: Pchar;
  BytesRead: Dword;
  aprun: Dword;

  buf, strline: string;
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
    FillChar(start, SizeOf(start), #0);
    { 设置console程序的启动属性 }
    with start do
    begin
      cb := SizeOf(start);
      start.lpReserved := nil;
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
      if CreateProcess(nil, Pchar(cmdstr), @Security, @Security, True,
        REALTIME_PRIORITY_CLASS, nil, nil, start, ProcessInfo) then
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
