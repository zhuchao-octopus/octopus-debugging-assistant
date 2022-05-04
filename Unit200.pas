unit Unit200;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit,
  Vcl.WinXCtrls, Vcl.Menus, IniFiles, Vcl.Themes, unit100;

Const
{$IFDEF CPU64BITS}
  APPLICATION_TITLE = '八爪鱼串口调试开发助手 64bit '; // for 64 bit;
{$ELSE}
  APPLICATION_TITLE = '八爪鱼串口调试开发助手 32bit '; // for 32 bit;
{$ENDIF}
  E_MAIL = 'Octopus@1234998.cn';
  WEB_SITE = 'http://www.1234998.cn';
  RELEASE_MOD = '0';
  DEFAULT_SV_R_WIDTH = 400;
  CONFIGURATION_DIR = '\Setting\';
  LOG_DIR = '\Logs\';
  DEFAULT_WEBSITE_ADDRESS = 'http://www.1234998.top';

{$IFDEF CPU64BITS}
  ApplicatonShortcutName = '八爪鱼串口终端'; // for 64 bit;
{$ELSE}
  ApplicatonShortcutName = '八爪鱼串口终端'; // for 32 bit;
{$ENDIF}
  ApplicatonShortcutName64 = '八爪鱼串口终端'; // for 64 bit;
  ApplicatonShortcutName32 = '八爪鱼串口终端'; // for 32 bit;

  DEFAULT_ADDRESSMAP_COLS = 32;
  DEFAULT_FIXED_COLS = 2;
  DEFAULT_MAX_CHART_POINTS = 30;

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
  OCCOMPROTOCAL_PACK_PACKPAYLOAD_HIGHT = 511;
  OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT = 1023;

type
  TOnClicEvent = procedure(Sender: TObject) of object;

  TLang = record
    Name: string;
    Caption1: string; // up caption;
    Caption2: string; // up caption;
  end;

var
  SystemMainMenu: TMainMenu;
  DefaultLauguageStr: array [0 .. 59] of TLang = (
    (
      Name: 'OPRATION_OPEN'; Caption1: '打开串口设备'; Caption2: 'Open The Device'),
    (Name: 'OPRATION_OPEN2'; Caption1: '打开 HID 设备';
    Caption2: 'Open The HID Device'), (Name: 'OPRATION_CLOSE'; Caption1: '关闭设备';
    Caption2: 'Close The Device'), (Name: 'Button4'; Caption1: '';
    Caption2: 'Get Ports'),

    (Name: 'Label2'; Caption1: ''; Caption2: 'Baud Rate'), (Name: 'Label5';
    Caption1: ''; Caption2: 'Parity'), (Name: 'Label9'; Caption1: '';
    Caption2: 'Stop Bits'), (Name: 'Label12'; Caption1: '';
    Caption2: 'Data Bits'), (Name: 'Label13'; Caption1: '';
    Caption2: 'SendFormat'), (Name: 'Label15'; Caption1: '';
    Caption2: 'FlowControl'), (Name: 'Button7'; Caption1: '';
    Caption2: 'Clear Above'), (Name: 'Button8'; Caption1: '';
    Caption2: 'Send Block Content Above'),

    (Name: 'CheckBox8'; Caption1: '';
    Caption2: 'Enable Auto Save The Log To File'), (Name: 'Button6';
    Caption1: ''; Caption2: 'Open The Log File Position'), (Name: 'Button5';
    Caption1: ''; Caption2: 'Clear Data Logs'), (Name: 'CheckBox7';
    Caption1: ''; Caption2: 'Enable Alpha Blend'), (Name: 'CheckBox2';
    Caption1: ''; Caption2: 'Always Stay At The Top'), (Name: 'CheckBox25';
    Caption1: ''; Caption2: 'Show The Time Stamp '), (Name: 'CheckBox3';
    Caption1: ''; Caption2: 'Show The Date Stamp'), (Name: 'CheckBox4';
    Caption1: ''; Caption2: 'Show Line Number For Log'), (Name: 'CheckBox5';
    Caption1: ''; Caption2: 'Show The Data You Are Sending'), (Name: 'Button1';
    Caption1: ''; Caption2: 'Start Loop For Sending Data'), (Name: 'Button3';
    Caption1: ''; Caption2: 'StopSend'), (Name: 'Label14'; Caption1: '';
    Caption2: 'The Loop Times You Want  '), (Name: 'Label4'; Caption1: '';
    Caption2: 'The Loop Interval'), (Name: 'CheckBox19'; Caption1: '';
    Caption2: 'Enable The Loop Funtion'), (Name: 'Label6'; Caption1: '';
    Caption2: 'Main Style'), (Name: 'Label7'; Caption1: '';
    Caption2: 'Protocol'), (Name: 'Label8'; Caption1: '';
    Caption2: 'DevAdress'), (Name: 'Button9'; Caption1: '';
    Caption2: 'Start Converting To Hexade'), (Name: 'Label10'; Caption1: '';
    Caption2: 'ReceiveFormat'), (Name: 'Label11'; Caption1: '';
    Caption2: 'ReadCount'), (Name: 'Label1'; Caption1: '';
    Caption2: 'Main Form AlphaBlend Value'), (Name: 'Label3'; Caption1: '';
    Caption2: 'Second Interval For Auto Saving'), (Name: 'Button11';
    Caption1: ''; Caption2: 'Start Converting To String'), (Name: 'Button10';
    Caption1: ''; Caption2: 'Clear Received Data Logs'), (Name: 'CheckBox6';
    Caption1: ''; Caption2: 'Switch To English Language'), (Name: 'CheckBox9';
    Caption1: ''; Caption2: 'Parse As String When Hexadecimal'),
    (Name: 'Button13'; Caption1: ''; Caption2: 'Data Received Direct to File'),
    (Name: 'Button14'; Caption1: ''; Caption2: 'FileFinished'),
    (Name: 'CheckBox1'; Caption1: ''; Caption2: 'Create Desktop Shortcut'),
    (Name: 'Button15'; Caption1: ''; Caption2: 'Show All Point'),
    (Name: 'Button16'; Caption1: ''; Caption2: 'Do The Operation'),
    (Name: 'Button26'; Caption1: ''; Caption2: 'Save Log As ...'),

    (Name: 'Button18'; Caption1: ''; Caption2: 'Zoom Out'), (Name: 'Button19';
    Caption1: ''; Caption2: 'Zoom In'), (Name: 'ButtonColor1'; Caption1: '';
    Caption2: 'Graphic One Color'), (Name: 'ButtonColor2'; Caption1: '';
    Caption2: 'Graphic Two Color'), (Name: 'Button20'; Caption1: '';
    Caption2: 'Export Data To Excel'), (Name: 'Button21'; Caption1: '';
    Caption2: 'Clear Graphic Data'), (Name: 'Button22'; Caption1: '';
    Caption2: 'Save Graphic to BMP'), (Name: 'Button23'; Caption1: '';
    Caption2: 'Load File'), (Name: 'Button24'; Caption1: '';
    Caption2: 'Send The File You Loaded'), (Name: 'CheckBox10'; Caption1: '';
    Caption2: 'Show All Data'), (Name: 'CheckBox11'; Caption1: '';
    Caption2: 'Overlap Graphics'), (Name: 'Label18'; Caption1: '';
    Caption2: 'Operation'), (Name: 'CheckBox12'; Caption1: '';
    Caption2: 'Compatible To Unicode'), (Name: 'Button12'; Caption1: '';
    Caption2: 'Font'), (Name: 'Button17'; Caption1: '';
    Caption2: 'Background Color For Message Log'), (Name: 'Button25';
    Caption1: ''; Caption2: 'Format To Hexade'));

  testbuff: Array [0 .. 17] of byte = (
    $68,
    $74,
    $74,
    $70,
    $3A,
    $2F,
    $2F,
    $31,
    $32,
    $33,
    $34,
    $39,
    $39,
    $38,
    $2E,
    $74,
    $6F,
    $70
  );

procedure AdjustComponenAttribute(Form: TForm);
function GetStyle(i: Integer): String;
procedure AdjustSetStyle(Style: String);
procedure AdjustComponentFont(Form: TForm; L: String = 'CN');
procedure LoadLaunguageFromFile(Form: TForm; Path: String);
procedure AppendSystemMenu(handle: Thandle; OnClicEvent: TOnClicEvent);
procedure LoadDefaultLaunguage(Form: TForm; Lang: String);
function ByteToWideString(buff: pbyte; len: Integer): String;
function ByteToWideString2(buff: pbyte; len: Integer): String; // 不要回车换行#13#10
procedure WideStringToByte(str: String; var buff: array of byte);
function GetDefaultLauguageStrByName(Name: String; Lang: String): String;
procedure SetButtonCaptionLeftAlign(btn: TButton);
function FormatHexStrToByte(sStr: string; var buf: array of byte): string;
function FormatHexStrToByte2(sStr: string; var buf: array of byte): Integer;
function SpaceCompress(s: string): string;
function GetBuildInfo(FileName: string): String;

implementation

function GetBuildInfo(FileName: string): String;
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
  V1, V2, V3, V4: Word;
begin
  Result := '';
  if not FileExists(FileName) then
    Exit;
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  if VerInfoSize = 0 then
    Exit;
  GetMem(VerInfo, VerInfoSize);
  if not GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, VerInfo) then
    Exit;
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
    Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3) + '.' +
      IntToStr(V4);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

function CharToDigit(c: Char): byte; // 字符表示的数，而不是对应的ASCII 值
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

function CharToByte(a, b: Char): byte;
begin
  Result := CharToDigit(a) * 16 + CharToDigit(b);
end;

function FormatHexStrToByte(sStr: string; var buf: array of byte): string;
var
  i, Count, bLen: Word;
  a,b:char;
begin
  sStr := sStr.UpperCase(Trim(sStr));
  //去掉中间可能的格式字符
  //sStr := StringReplace(sStr, '0x', ' ', [rfReplaceAll]); // 替换0x
  sStr := StringReplace(sStr, '0X', ' ', [rfReplaceAll]); // 替换0X
  sStr := StringReplace(sStr, ',', ' ', [rfReplaceAll]); // 替换 ,号
  sStr := StringReplace(sStr, '，', ' ', [rfReplaceAll]); // 替换 ,号
  sStr := StringReplace(sStr, ' ', ' ', [rfReplaceAll]); // 替换 tab

  //压缩中间空格,就是把多个空格替换成一个,并去掉两头的空格
  Result := Trim(SpaceCompress(sStr));

  Count := (length(Result) + 2) div 3;
  bLen := length(buf);
  ZeroMemory(@buf, bLen);

  for i := 1 to Count do
  begin
    a:= Result[i * 3 - 2];
    b:= Result[i * 3 - 1];
    buf[i - 1] := CharToByte(a,b);
  end;
  Result :='';
  for i := 1 to Count do
  begin
    Result := Result + Format('%.02x ', [buf[i - 1]]);
  end;
end;

function FormatHexStrToByte2(sStr: string; var buf: array of byte): Integer;
var
  i, Count, bLen: Word;
  a,b:char;
  strStr:String;
begin
  sStr := sStr.UpperCase(Trim(sStr));
  //去掉中间可能的格式字符
  //sStr := StringReplace(sStr, '0x', ' ', [rfReplaceAll]); // 替换0x
  sStr := StringReplace(sStr, '0X', ' ', [rfReplaceAll]); // 替换0X
  sStr := StringReplace(sStr, ',', ' ', [rfReplaceAll]); // 替换 ,号
  sStr := StringReplace(sStr, '，', ' ', [rfReplaceAll]); // 替换 ,号
  sStr := StringReplace(sStr, ' ', ' ', [rfReplaceAll]); // 替换 tab

  //压缩中间空格,就是把多个空格替换成一个,并去掉两头的空格
  strStr := Trim(SpaceCompress(sStr));

  Count := (length(strStr) + 2) div 3;
  bLen := length(buf);
  ZeroMemory(@buf, bLen);

  for i := 1 to Count do
  begin
    a:= strStr[i * 3 - 2];
    b:= strStr[i * 3 - 1];
    buf[i - 1] := CharToByte(a,b);
  end;
  Result := Count;
end;

function SpaceCompress(s: string): string;
var
  hs1, hs2: String;
begin
  hs1 := s;
  while (true) do
  begin
    hs2 := StringReplace(hs1, '  ', ' ', [rfReplaceAll]); // 删除'  '
    if hs1 = hs2 then
      break
    else
      hs1 := hs2;
  end;
  Result := hs1;
end;

procedure SetButtonCaptionLeftAlign(btn: TButton);
var
  Style: Integer;
begin
  Style := GetWindowLong(btn.handle, GWL_STYLE);
  Style := Style or BS_LEFT;
  SetWindowLong(btn.handle, GWL_STYLE, Style);
end;

function ByteToWideString(buff: pbyte; len: Integer): String;
var
  str: AnsiString;
  buffer: array of byte;
begin
  try
    SetLength(buffer, len);
    SetLength(str, len);
    // Move(buff, buffer, len);
    CopyMemory(buffer, buff, len);
    // Move(buffer, str[1], len);
    CopyMemory(@str[1], buffer, len);
    Result := str;
  Except
  end;
end;

function ByteToWideString2(buff: pbyte; len: Integer): String; // 不要回车换行#13#10
var
  str: AnsiString;
  buffer: array of byte;
begin
  try
    SetLength(buffer, len);
    SetLength(str, len);
    // Move(buff, buffer, len);
    CopyMemory(buffer, buff, len);
    // Move(buffer, str[1], len);
    CopyMemory(@str[1], buffer, len);
    str := StringReplace(str, chr(13) + chr(10), '', [rfReplaceAll]); // 删除回车
    Result := trim(str);
  Except
  end;
end;

procedure WideStringToByte(str: String; var buff: array of byte);
var
  // i:integer;
  astr: AnsiString;
begin
  astr := str;
  // setLength(@buff[0],Length(astr));
  CopyMemory(@buff, @astr[1], length(astr));
  // for i := 0 to sizeof(str)-1 do
  // buff[i+1]:=Byte(str[i]);
end;

procedure AppendSystemMenu(handle: Thandle; OnClicEvent: TOnClicEvent);
var
  // StyleName: string;
  i: Integer;
  MenuItem: TMenuItem;
  Menu: HMENU;

begin
  Menu := GetSysteMmenu(handle, false);
  if (SystemMainMenu = nil) then
    SystemMainMenu := TMainMenu.Create(nil);
  SystemMainMenu.Items.Clear;
  // for StyleName in TStyleManager.StyleNames do
  for i := Low(TStyleManager.StyleNames) to High(TStyleManager.StyleNames) do
  begin
    MenuItem := TMenuItem.Create(nil);
    MenuItem.Caption := TStyleManager.StyleNames[i]; // StyleName;
    // MenuItem.Tag := 1024 + i;
    SystemMainMenu.Items.Add(MenuItem);
    MenuItem.OnClick := OnClicEvent;
  end;
  AppendMenu(Menu, MF_SEPARATOR, 1023, 0);
  SystemMainMenu.Items.Caption := 'Theme';
  AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, SystemMainMenu.handle,
    PChar(SystemMainMenu.Items.Caption));
  // for i := Low(TStyleManager.StyleNames) to High(TStyleManager.StyleNames) do
  // AppendMenu(Menu,MF_POPUP,100+i,pchar(TStyleManager.StyleNames[i]));
  AppendMenu(GetSysteMmenu(handle, false), MF_SEPARATOR, 1024, nil);
  AppendMenu(GetSysteMmenu(handle, false), MF_UNCHECKED, 1025,
    PChar('Keep At The Top Always '));
  // AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, 1026, pchar(VERSIONNAME));
  // AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, 1027, pchar('English'));
  // AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, 1028,  pchar('Chinese'));
  AppendMenu(GetSysteMmenu(handle, false), MF_SEPARATOR, 1027, nil);
  AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, 1028,
    PChar('Help Support'));
  // AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, 1029, pchar(WEB_SITE));
end;

function GetStyle(i: Integer): String;
begin
  Result := TStyleManager.StyleNames[i];
end;

procedure AdjustSetStyle(Style: String);
// var
// StyleName: string;
begin
  TStyleManager.SetStyle(Style);
end;

procedure AdjustComponenAttribute(Form: TForm);
var
  i: Integer;
  tmpComponent: TComponent;
begin
  For i := 0 To Form.ComponentCount - 1 Do
  Begin
    tmpComponent := Form.Components[i];
    if tmpComponent is TPanel then
    begin
      TPanel(tmpComponent).ParentColor := true;
      TPanel(tmpComponent).ParentBackground := false;
    end;
    if tmpComponent is TGroupBox then
    begin
      TGroupBox(tmpComponent).ParentColor := true;
      TGroupBox(tmpComponent).ParentBackground := false;
    end;

  End;

end;

procedure AdjustComponentFont(Form: TForm; L: String); // 不包括日志的字体颜色
var
  f: TFont;
  i: Integer;
  tmpComponent: TComponent;
begin

  f := TFont.Create;
  if L = 'EN' then
  begin
    f.Charset := TFontCharset(DEFAULT_CHARSET);
    f.Color := clWindowText;
    f.Name := 'Segoe UI';
    f.Size := 10;
    // f.Style :=[fsBold];
  end
  else
  begin
    f.Charset := TFontCharset(DEFAULT_CHARSET);
    f.Color := clWindowText;
    f.Name := 'Segoe UI';
    f.Size := 10;
  end;
  For i := 0 To Form.ComponentCount - 1 Do
  Begin
    tmpComponent := Form.Components[i];
    if tmpComponent is TButton then
    begin
      TButton(tmpComponent).ParentFont := false;
      TButton(tmpComponent).Font := f;
    end;
    if tmpComponent is TCheckBox then
    begin
      TCheckBox(tmpComponent).ParentFont := false;
      TCheckBox(tmpComponent).Font := f;
    end;
    if tmpComponent is TLabel then
    begin
      TLabel(tmpComponent).ParentFont := false;
      TLabel(tmpComponent).Font := f;
    end;
    if tmpComponent is TPanel then
    begin
      TPanel(tmpComponent).ParentFont := false;
      TPanel(tmpComponent).Font := f;
    end;
    if tmpComponent is TComboBox then
    begin
      TComboBox(tmpComponent).ParentFont := false;
      TComboBox(tmpComponent).Font := f;
    end;
    if tmpComponent is TEdit then
    begin
      TEdit(tmpComponent).ParentFont := false;
      TEdit(tmpComponent).Font := f;
    end;
    if tmpComponent is TSplitView then
    begin
      TSplitView(tmpComponent).ParentFont := false;
      TSplitView(tmpComponent).Font := f;
    end;
    if tmpComponent is TStringGrid then
    begin
      TStringGrid(tmpComponent).ParentFont := false;
      TStringGrid(tmpComponent).Font := f;
    end;
  End;
end;

function GetDefaultLauguageStrByName(Name: String; Lang: String): String;
var
  i: Integer;
begin
  Result := '';
  for i := Low(DefaultLauguageStr) to High(DefaultLauguageStr) do
  begin
    if DefaultLauguageStr[i].Name = Name then
    begin
      if (Lang = 'CN') then
        Result := DefaultLauguageStr[i].Caption1
      else
        Result := DefaultLauguageStr[i].Caption2;
      break;
    end;
  end;
end;

function GetComponentLauguageName(Name: String): String;
var
  i: Integer;
begin
  Result := '';
  for i := Low(DefaultLauguageStr) to High(DefaultLauguageStr) do
  begin
    if DefaultLauguageStr[i].Name = Name then
    begin
      Result := 'MESSAGE_' + IntToStr(i);
      break;
    end;
  end;
end;

procedure LoadLaunguageFromFile(Form: TForm; Path: String);
var
  i: Integer;
  tmpComponent: TComponent;
  IniFiles: TIniFile;
  str: String;
begin
  if FileExists(Path) then
  begin
    IniFiles := TIniFile.Create(Path);
    For i := 0 To Form.ComponentCount - 1 Do
    Begin
      tmpComponent := Form.Components[i];
      str := GetComponentLauguageName(tmpComponent.Name);
      if str = '' then
        Continue;
      if tmpComponent is TButton then
        TButton(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE', str,
          TButton(tmpComponent).Caption);

      if tmpComponent is TCheckBox then
        TCheckBox(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE', str,
          TCheckBox(tmpComponent).Caption);

      if tmpComponent is TLabel then
        TLabel(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE', str,
          TLabel(tmpComponent).Caption);

      if tmpComponent is TMenuItem then
        TMenuItem(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE', str,
          TMenuItem(tmpComponent).Caption);
      // if tmpComponent is TNotebook then
      // begin
      // for j := 0 to TNotebook(tmpComponent).Pages.Count-1 do
      // begin
      // TNotebook(tmpComponent).Pages[j]:= IniFiles.ReadString('LANGUAGE', tmpComponent.Name, TNotebook(tmpComponent).Pages[j]);
      // end;
      // end;
    End;
  end
  else
  begin
    IniFiles := TIniFile.Create(Path);
    For i := 0 To Form.ComponentCount - 1 Do
    Begin
      tmpComponent := Form.Components[i];
      str := GetComponentLauguageName(tmpComponent.Name);
      if str = '' then
        Continue;
      if tmpComponent is TButton then
        IniFiles.WriteString('LANGUAGE', str, TButton(tmpComponent).Caption);
      if tmpComponent is TCheckBox then
        IniFiles.WriteString('LANGUAGE', str, TCheckBox(tmpComponent).Caption);
      if tmpComponent is TLabel then
        IniFiles.WriteString('LANGUAGE', str, TLabel(tmpComponent).Caption);
      if tmpComponent is TMenuItem then
        IniFiles.WriteString('LANGUAGE', str, TMenuItem(tmpComponent).Caption);
    End;
  end;
end;

procedure LoadDefaultLaunguage(Form: TForm; Lang: String);
var
  i: Integer;
  tmpComponent: TComponent;
begin
  if Lang = 'EN' then
  BEGIN
    For i := 0 To Form.ComponentCount - 1 Do
    Begin
      tmpComponent := Form.Components[i];
      if tmpComponent is TButton then
        TButton(tmpComponent).Caption := GetDefaultLauguageStrByName
          (tmpComponent.Name, 'EN');

      if tmpComponent is TCheckBox then
        TCheckBox(tmpComponent).Caption := GetDefaultLauguageStrByName
          (tmpComponent.Name, 'EN');

      if tmpComponent is TLabel then
        TLabel(tmpComponent).Caption := GetDefaultLauguageStrByName
          (tmpComponent.Name, 'EN');

      if tmpComponent is TMenuItem then
        TMenuItem(tmpComponent).Caption := GetDefaultLauguageStrByName
          (tmpComponent.Name, 'EN');
    End;
  END;
end;

end.
