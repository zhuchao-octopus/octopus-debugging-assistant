unit ocGlobalUnit;

interface

uses windows, ComCtrls, Controls, SysUtils, classes, IniFiles,
  StdCtrls, ExtCtrls;

const
  MappingFileName = '_MyDllMouse';

const
  NotFoundDevice = 'NO Device Be Found.';

const
  CurrentVersion = '1.8.a';

const
  NextVersion = '1.8.b';

const
  APPLICATION_NAME = 'OCTOPUS'; // 应用程序名
  // SPYClass = 'SPYForm';  //监视窗口类名
  // 错误信息常量
  // ERROR_DATA_CONNECT = '连接数据库失败!';
  // ERROR_CREATE_MUTEX = '建立互斥对象失败!';
  // ERROR_CREATE_SPYWINDOW = '建立监视窗口失败!';
  // ERROR_CREATE_THREAD = '建立监视线程失败';
  // const ERROR_CREATE_FILEMAP = '建立内存文件映射失败';
  // ERROR_CREATE_HOOK = '挂钩失败!';
  // const ERROR_CREATE_DEBUGPROCESS = 'Fail to create monitor thread.';
  // ERROR_APP_RUNING = '程序已经运行!';
  // ERROR_REG_WINDOW = '注册窗口失败!';
  // ERROR_NOSEL_WINDOW = '未选择窗口!';
  // ERROR_FILE_NOPE = '文件不是有效的PE文件!';
  // ERROR_FILE_NOEXE = '文件不是有效的可执行文件!';
  // ERROR_FILE_NOFIND = '文件没找到!';

const
  MEMMERY_MAPPING_FILE_NAME = 'MyShareMemmeryMappingFileName';

type
  TShareMem = record
    data1: array [1 .. 2] of DWORD;
    data2: TMOUSEHOOKSTRUCT;
    IfRbutton: boolean;
    buffer: array [0 .. 1024] of char;
  end;

  TPShareMem = ^TShareMem;

  TDviceInfo = packed record
    Guid: string;
    Desc: string;
  end;

  TfileAttribute = record
    filename: string; // 4
    filesize: integer; // 2
  end;

  TProcessInfo = record
    ExeFileName: String;
    ProcessId: DWORD;
  end;

  TPProcessInfo = ^TProcessInfo;

type
  PThreadInfo = ^TThreadInfo;

  TThreadInfo = Record
    ThreadID: THandle;
    ThreadHandle: THandle;
  end;

  PApiInfo = ^TApiInfo;

  TApiInfo = Record // API信息结构
    FunAddress: Pointer; // 函数的入口地址
    FunName: array [0 .. 127] of char; // 函数名
    DLL: WORD; // 所属DLL号
  end;

  PBreakInfo = ^TBreakInfo;

  TBreakInfo = Packed Record // 断点信息
    OldCode: BYTE; // 函数入口处的代码
    FunAddress: Pointer; // 函数入口地址
    FunName: Pchar; // 函数名

    DLL: WORD; // 所属DLL号
  end;

  TPMoniterCOM = ^TMoniterCOM;

  TMoniterCOM = Record
    ComName: String;
    InQueue: DWORD;
    OuQueue: DWORD;
    Lpdcb: TDCB;
  end;

Function GetLocalHostName(): string;

function CheckUrl(url: string): boolean;

procedure ShowMyMessage(Handle: hwnd; MsgStr: string; msgtype: Cardinal);

Function StringToByteBuffer(str: String; var buffer: array of BYTE): integer;
Function ByteBufferToString(buffer: array of BYTE; Length: integer): String;
Function ByteBufferToHex(buffer: array of BYTE; Length: integer;
  Align: integer = 0; MapChar: boolean = False): String;
Function GetSubStringFromStrBuffer(var StrBuffer: String;
  Separator: String): String;
Procedure ByteBufferToStringList(buffer: array of BYTE; Length: integer;
  StrList: TStringList; Separator: BYTE);
// procedure  OscillographDraw(CurrentValue: integer;EndIndex: integer;ValueCount:Integer; ArrayValue: array of integer;paintbox:Tpaintbox);
procedure OscillographDraw(CurrentValue: integer; paintbox: Tpaintbox);
function IsVistaOs: boolean;

var

  CmdDir, CurrentComProject, OctopusCfgDir: string;
  CurrentComPort: string;
  DoShotCut: boolean;
  MoniterCOM: TMoniterCOM;
  DpIndex: integer;

  UpdateThreadHandle: DWORD;
  UpdateThreadID: DWORD;
  UpdateEventHandle: THandle; { 事件句柄 }

  // CmdLingstr:String;

  OscillographArrayValue: array [0 .. 199] of integer;
  EndIndex: integer = 0;
  ValueCount: integer = 0;

  xx, yy: Extended;

  VoShowPointNum: Double = 100;
  VO_BOTTOM_AXIS_STEP: Double = 10;
  VO_LEFT_AXIS_STEP: Double = 10;
  VO_ZOOM_PERCENT_STEP: Double = 1;
  Ch1DatumValue: Double = 50;
  Ch2DatumValue: Double = -50;
  VO_Y_MAX_VALUE: Double = 200;
  voMaxValue, voMiniValue, voCurrentValue: Double;

  OldX, OldY: Longint;
  ocCs: TRTLCriticalSection;

  ScreenX, ScreenY: integer;
  Octopusini: TIniFile;

implementation

uses WinSock, Wininet, psapi, TLHelp32, Graphics, ocPublicUnit;

procedure Check_Trap;
asm
  PUSHFD // 标志寄存器内容进栈
  POP EAX // 获得标志寄存器内容
  TEST AH,$01 // 测试陷阱标志
  JE @exit
  PUSH 0
  CALL ExitProcess // 判断出CPU处于单步模式，终止进程，当然，你可以狠点，比如关机什么的，看你的了：）
@exit:
end;

procedure Check_Bpx;
var
  DllName, ApiName: Pchar;
begin
  DllName := 'user32.dll';
  ApiName := 'MessageBoxA';
  asm
    PUSH DllName
    CALL GetModuleHandle // 获取user32模块的基地址
    PUSH ApiName
    PUSH EAX
    CALL GetProcAddress // 获取MessageBoxA函数的入口地址
    CMP BYTE PTR [EAX], $CC // 比较入口处首字节是否为$CC(int 3)
    JNE @exit
    PUSH 0
    CALL ExitProcess // 判断出MessageBoxA函数已经被设断点，终止进程。
  @exit:
  end;
end;

procedure Check_Debugger;
var
  DllName: Pchar;
  ApiName: Pchar;
begin
  DllName := 'kernel32.dll';
  ApiName := 'IsDebuggerPresent';
  asm
    PUSH DllName
    CALL GetModuleHandle
    PUSH ApiName
    PUSH EAX
    CALL GetProcAddress
    CMP EAX,0
    JZ @exit
    CALL EAX
    CMP EAX,1
    JNE @exit
    CALL ExitProcess
  @exit:
  end;
end;

procedure Check_SoftIce;
asm
  PUSH EBP
  PUSH Offset @seh_handler // 因为SoftIce不存时，将引发异常，故需要使用seh来处理
  PUSH FS:[0]
  MOV FS:[0],ESP // 安装seh
  MOV EBP,$4243484B // EBP=$4243484B,AX=4 为SoftIce接口参数
  MOV AX,$04
  INT 3
  POP FS:[0] // 缷载seh
  ADD ESP,4
  POP EBP
  CMP AL,4 // 若AL<>4则SOFTICE已经加载!!!
  JE @exit
  CALL ExitProcess // 若加载，则退出
@seh_handler:
  MOV EAX,[ESP+12]
  INC [EAX][TCONTEXT].Eip
  MOV EAX,0
  RET 16
@exit:
end;

Function GetSubStringFromStrBuffer(var StrBuffer: String;
  Separator: String): String;
var
  str: String;
begin
  str := trim(Copy(StrBuffer, 1, pos(Separator, StrBuffer) - 1));
  Delete(StrBuffer, 1, pos(Separator, StrBuffer));
  if pos(Separator, StrBuffer) < 0 then
    StrBuffer := '';
  Result := str;
end;

Function GetSubStringFromByteBuffer(var ByteBuffer: Array Of BYTE;
  Separator: BYTE): String;
var
  str: String;
  i: integer;
begin
  for i := 0 to high(ByteBuffer) do
  begin
    str := str + chr(ByteBuffer[i]);
    if ByteBuffer[i] = Separator then
    begin

    end;
  end;

end;

Function ByteBufferToHex(buffer: array of BYTE; Length: integer;
  Align: integer = 0; MapChar: boolean = False): String;
var
  i: integer;
  str: String;
  strchar: String;
begin

  strchar := '  ';
  if Align = 0 then
  begin
    for i := 0 to Length - 1 do
    begin
      str := str + Format('%2.2x ', [buffer[i]]);
    end;
    Result := str;
  end

  else if (Align = 16) then
  begin
    for i := 0 to Length - 1 do
    begin
      // str:=str+' ';
      str := str + Format('%2.2x ', [buffer[i]]);
      if MapChar then
        strchar := strchar + chr(buffer[i]);
      if ((i mod 16) = 15) or (i = Length - 1) then
      begin
        // str:=Format('%-50s ',[str]);
        str := str + strchar + #$0D#$0A;
      end;
    end;
    str := trim(str);
    Result := str;
  end

  else if (Align = 8) then
  begin
    for i := 0 to Length - 1 do
    begin
      str := str + Format('%2.2x ', [buffer[i]]);
      if ((i mod 8) = 7) or (i = Length - 1) then
        str := str + #$0D#$0A;
    end;
    str := trim(str);
    Result := str;
  end

  else // Align=0
  begin
    for i := 0 to Length - 1 do
    begin
      str := str + Format('%2.2x ', [buffer[i]]);
    end;
    Result := str;
  end;

end;

Function ByteBufferToString(buffer: array of BYTE; Length: integer): String;
var
  i: integer;
  str: String;
begin
  str := '';
  for i := 0 to Length - 1 do
  begin
    str := str + chr(buffer[i]);
  end;
  Result := str;

end;

Procedure ByteBufferToStringList(buffer: array of BYTE; Length: integer;
  StrList: TStringList; Separator: BYTE);
var
  i: integer;
  str: String;
begin
  try
    str := '';
    StrList.Clear;
    for i := 0 to Length - 1 do
    begin
      str := str + chr(buffer[i]);
      if buffer[i] = Separator then
      begin
        StrList.ADD(str);
        str := '';
      end;
    end;
    if str <> '' then
    begin
      StrList.ADD(str);
      str := '';
    end;
  finally
  end;

end;

Function StringToByteBuffer(str: String; var buffer: array of BYTE): integer;
var
  i: integer;
  // str:String;
begin
  for i := 1 to Length(str) do
  begin
    buffer[i - 1] := ord(str[i]);
  end;
  Result := i;
end;

{ ------------------------------------ }
{ 过程名:ShowError
  {过程功能:显示出错信息
  {过程参数:ErrorStr:错误信息
  {------------------------------------ }
procedure ShowMyMessage(Handle: hwnd; MsgStr: string; msgtype: Cardinal);
// MB_OK or MB_ICONERROR
begin
  MessageBox(Handle, Pchar(MsgStr), APPLICATION_NAME, msgtype);
end;

{ ------------------------------------ }
{ 过程名:MemoryMap;
  {过程功能:进行内存文件映射
  {过程参数:无
  {------------------------------------ }
procedure MemoryMapToFile(AppHandle: hwnd; pShareMemFile: TPShareMem);
var
  hMappingFile: THandle;
begin
  hMappingFile := OpenFileMapping(FILE_MAP_WRITE, False, MappingFileName);
  if hMappingFile = 0 then
  begin
    // hMappingFile := CreateFileMapping($FFFFFFFF,nil,PAGE_READWRITE,0,SizeOf(TShareMem),MappingFileName);
    hMappingFile := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, $FF,
      MEMMERY_MAPPING_FILE_NAME);
    // FirstProcess:=true;
  end;
  if (hMappingFile = 0) then
  begin
    ShowMyMessage(AppHandle, ERROR_CREATE_FILEMAP, MB_OK or MB_ICONERROR);
  end;
  pShareMemFile := MapViewOfFile(hMappingFile, FILE_MAP_WRITE or
    FILE_MAP_READ, 0, 0, 0);
  if (pShareMemFile = nil) then
  begin
    CloseHandle(hMappingFile);
    Exception.Create('ERROR_CREATE_FILEMAP');
  end;

end;

procedure OscillographDraw(CurrentValue: integer; paintbox: Tpaintbox);
var
  tmpbmp: TBitMap;
  x, y, i: integer;
begin
  //
  OscillographArrayValue[EndIndex] := CurrentValue;
  EndIndex := (EndIndex + 1) mod 200;
  ValueCount := ValueCount + 1;
  // 画背景
  tmpbmp := TBitMap.Create;
  try
    tmpbmp.Width := paintbox.Width;
    tmpbmp.Height := paintbox.Height;
    tmpbmp.Canvas.Pen.Color := clBlack;
    tmpbmp.Canvas.Brush.Color := clBlack;
    tmpbmp.Canvas.Rectangle(0, 0, tmpbmp.Width, paintbox.Height);

    tmpbmp.Canvas.Pen.Color := clGreen;
    y := 1;
    while y < tmpbmp.Height do
    begin
      tmpbmp.Canvas.MoveTo(0, y);
      tmpbmp.Canvas.LineTo(tmpbmp.Width, y);
      y := y + 10; // tmpbmp.Height div 10 ;//
    end;
    x := tmpbmp.Width - ((ValueCount mod 10) * 3) mod 10;

    while x > 0 do
    begin
      tmpbmp.Canvas.MoveTo(x, 0);
      tmpbmp.Canvas.LineTo(x, tmpbmp.Height);
      x := x - 10;
    end;

    // 画曲线
    tmpbmp.Canvas.Pen.Color := clLime;
    if ValueCount > 199 then
    begin
      for i := EndIndex - 1 to 199 do
      begin
        tmpbmp.Canvas.MoveTo(3 * i - ((EndIndex - 1) * 3),
          tmpbmp.Height - round(tmpbmp.Height / 100) *
          OscillographArrayValue[i]);
        tmpbmp.Canvas.LineTo(3 * (i + 1) - ((EndIndex - 1) * 3),
          tmpbmp.Height - round(tmpbmp.Height / 100) * OscillographArrayValue
          [(i + 1) mod 200]);
      end;
      for i := 0 to EndIndex - 1 do
      begin
        tmpbmp.Canvas.MoveTo(tmpbmp.Width - ((EndIndex - 1) * 3) + 3 * i,
          tmpbmp.Height - round(tmpbmp.Height / 100) *
          OscillographArrayValue[i]);
        tmpbmp.Canvas.LineTo(tmpbmp.Width - ((EndIndex - 1) * 3) + 3 * (i + 1),
          tmpbmp.Height - round(tmpbmp.Height / 100) *
          OscillographArrayValue[i + 1]);
      end;
    end
    else
    begin
      for i := 0 to EndIndex - 1 do
      begin
        tmpbmp.Canvas.MoveTo(tmpbmp.Width - ((EndIndex - 1) * 3) + 3 * i,
          tmpbmp.Height - round(tmpbmp.Height / 100) *
          OscillographArrayValue[i]);
        tmpbmp.Canvas.LineTo(tmpbmp.Width - ((EndIndex - 1) * 3) + 3 * (i + 1),
          tmpbmp.Height - round(tmpbmp.Height / 100) *
          OscillographArrayValue[i + 1]);
      end;
    end;
    paintbox.Canvas.Draw(0, 0, tmpbmp);
  finally
    tmpbmp.Free;
  end;
end;

Function CheckUrl(url: string): boolean;
var
  hSession, hfile, hRequest: hInternet;
  dwindex, dwcodelen: DWORD;
  dwcode: array [1 .. 20] of char;
  res: Pchar;
begin
  Result := False;
  if pos('http://', LowerCase(url)) = 0 then
    url := 'http://' + url;
  hSession := InternetOpen('InetURL:/1.0', INTERNET_OPEN_TYPE_PRECONFIG,
    nil, nil, 0);
  if Assigned(hSession) then
  begin
    hfile := InternetOpenUrl(hSession, Pchar(url), nil, 0,
      INTERNET_FLAG_RELOAD, 0);
    dwindex := 0;
    dwcodelen := 10;
    HttpQueryInfo(hfile, HTTP_QUERY_STATUS_CODE, @dwcode, dwcodelen, dwindex);
    res := Pchar(@dwcode);
    Result := (res = '200') or (res = '302'); // 200,302未重定位标志
    if Assigned(hfile) then
      InternetCloseHandle(hfile);
    InternetCloseHandle(hSession);
  end;
end;

Function GetLocalHostName(): string;
var
  ComputerName: Pchar;
  size: DWORD;
begin
  GetMem(ComputerName, 255);
  size := 255;
  // 获取计算机名称
  if GetComputerName(ComputerName, size) = False then
  begin
    // MessageBox( Handle, '获取计算机名称失败。' , '错误' , MB_OK+MB_ICONERROR);
    FreeMem(ComputerName);
    exit;
  end;
  Result := ComputerName + ' 本地机器';
  FreeMem(ComputerName);
end;

function IsVistaOs: boolean;
begin

  Result := not(Win32MajorVersion < 6);

end;

end.
