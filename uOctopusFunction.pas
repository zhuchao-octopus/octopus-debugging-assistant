unit uOctopusFunction;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Buttons,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit, Vcl.Tabs,
  Vcl.WinXCtrls, Vcl.Menus, IniFiles, Vcl.Themes;

Const

{$IFDEF CPU64BITS}
  APPLICATION_TITLE_CN = '��צ�㴮�ڵ��Կ������� 64bit '; // for 64 bit;
{$ELSE}
  APPLICATION_TITLE_CN = '��צ�㴮�ڵ��Կ������� 32bit '; // for 32 bit;
{$ENDIF}
  OCTOPUS_DEFAULT_E_MAIL = 'Octopus@1234998.cn';
  OCTOPUS_DEFAULT_CONFIGURATION_DIR = '\Setting\';
  OCTOPUS_DEFAULT_LOG_DIR = '\Logs\';

  OCTOPUS_DEFAULT_WEBSITE_ADDRESS1 = 'http://www.1234998.cn';
  OCTOPUS_DEFAULT_WEBSITE_ADDRESS2 = 'http://www.1234998.top';

  OCTOPUS_UPGRADING_URL = 'http://47.106.172.94:8090/zhuchao/octopus/devices/getDeviceInfor';
  OCTOPUS_APPLICATION_TITLE_NAME = 'Octopus Serial Port Development & Debugging Assistant';
  OCTOPUS_DEBUGGING_AND_DEVELOPMENT_CLASSNAME = 'TMainOctopusDebuggingDevelopmentForm';

{$IFDEF CPU64BITS}
  OCTOPUS_SYSTEM_DESKTOP_SHORTCUT_NAME = 'Octopus Serial Development Assistant'; // for 64 bit;
  OCTOPUS_SYSTEM_EXPLORER_MENU_NAME = 'Edit With Octopus Development Assistant';
{$ELSE}
  OCTOPUS_SYSTEM_DESKTOP_SHORTCUT_NAME = 'Octopus Serial Development Assistant 32'; // for 32 bit;
  OCTOPUS_SYSTEM_EXPLORER_MENU_NAME = 'Edit With Octopus Development Assistant';
{$ENDIF}
  /// DEFAULT_ADDRESSMAP_COLS = 32;
  /// DEFAULT_FIXED_COLS = 2;
  /// DEFAULT_MAX_CHART_POINTS = 30;

  { OCCOMPROTOCAL_START = 10; // ���ӣ�Ҫ��Է��ظ� ״̬�Ƿ��������
    OCCOMPROTOCAL_ACK = 11; // һ����Ӧ��Ҫ��Է���Ӧ��ǰ״̬
    OCCOMPROTOCAL_READY = 12; // ׼���������
    OCCOMPROTOCAL_OVER = 13; // ����������
    OCCOMPROTOCAL_GOT = $0E00; // 14; //���ݰ�ȷ�ϱ���յ���� ,�����ڸ��ֽ�

    OCCOMPROTOCAL_I2C_READ = 50;
    OCCOMPROTOCAL_I2C_WRITE = 51;
    OCCOMPROTOCAL_SPI_READ = 52;
    OCCOMPROTOCAL_SPI_WRITE = 53;
    OCCOMPROTOCAL_WIFI_READ = 54;
    OCCOMPROTOCAL_WIFI_WRITE = 55;
    OCCOMPROTOCAL_UART_READ = 56;
    OCCOMPROTOCAL_UART_WRITE = 57;

    OCCOMPROTOCAL_DATA1 = $FC; // ��׼Э������ �������512�ֽ�
    OCCOMPROTOCAL_DATA2 = $FD; // �Ǳ�׼Э���ʾ�����������ģ�û�зְ�������˵ֻ��һ����

    OCCOMPROTOCAL_ERROR = $FFFF;
    OCCOMPROTOCAL_NONE = $0000;
    OCCOMPROTOCAL_PACK_PACKPAYLOAD_HIGHT = 511;
    OCCOMPROTOCAL_PACK_RING_BUFFER_HIGHT = 1023; }

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
      Name: 'OPRATION_OPEN'; Caption1: '�򿪴����豸'; Caption2: 'Open The Device'), (Name: 'OPRATION_OPEN2'; Caption1: '�� HID �豸'; Caption2: 'Open The HID Device'),
    (Name: 'OPRATION_CLOSE'; Caption1: '�ر�'; Caption2: 'Close The Device'), (Name: 'Button4'; Caption1: ''; Caption2: 'Get Ports'),

    (Name: 'Label2'; Caption1: ''; Caption2: 'Baud Rate'), (Name: 'Label5'; Caption1: ''; Caption2: 'Parity'), (Name: 'Label9'; Caption1: '';
    Caption2: 'Stop Bits'), (Name: 'Label12'; Caption1: ''; Caption2: 'Data Bits'), (Name: 'Label13'; Caption1: ''; Caption2: 'SendFormat'), (Name: 'Label15';
    Caption1: ''; Caption2: 'FlowControl'), (Name: 'Button7'; Caption1: ''; Caption2: 'Clear Above'), (Name: 'Button8'; Caption1: '';
    Caption2: 'Send Block Content Above'),

    (Name: 'CheckBox8'; Caption1: ''; Caption2: 'Enable Auto Save The Log To File'), (Name: 'Button6'; Caption1: ''; Caption2: 'Open The Log File Position'),
    (Name: 'Button5'; Caption1: ''; Caption2: 'Clear Data Logs'), (Name: 'CheckBox7'; Caption1: ''; Caption2: 'Enable Alpha Blend'), (Name: 'CheckBox2';
    Caption1: ''; Caption2: 'Always Stay At The Top'), (Name: 'CheckBox25'; Caption1: ''; Caption2: 'Show The Time Stamp '), (Name: 'CheckBox3'; Caption1: '';
    Caption2: 'Show The Date Stamp'), (Name: 'CheckBox4'; Caption1: ''; Caption2: 'Show Line Number For Log'), (Name: 'CheckBox5'; Caption1: '';
    Caption2: 'Show The Data You Are Sending'), (Name: 'Button1'; Caption1: ''; Caption2: 'Start Loop For Sending Data'), (Name: 'Button3'; Caption1: '';
    Caption2: 'StopSend'), (Name: 'Label14'; Caption1: ''; Caption2: 'The Loop Times You Want  '), (Name: 'Label4'; Caption1: '';
    Caption2: 'The Loop Interval'), (Name: 'CheckBox19'; Caption1: ''; Caption2: 'Enable The Loop Funtion'), (Name: 'Label6'; Caption1: '';
    Caption2: 'Main Style'), (Name: 'Label7'; Caption1: ''; Caption2: 'Protocol'), (Name: 'Label8'; Caption1: ''; Caption2: 'DevAdress'), (Name: 'Button9';
    Caption1: ''; Caption2: 'Start Converting To Hexade'), (Name: 'Label10'; Caption1: ''; Caption2: 'ReceiveFormat'), (Name: 'Label11'; Caption1: '';
    Caption2: 'ReadCount'), (Name: 'Label1'; Caption1: ''; Caption2: 'Main Form AlphaBlend Value'), (Name: 'Label3'; Caption1: '';
    Caption2: 'Second Interval For Auto Saving'), (Name: 'Button11'; Caption1: ''; Caption2: 'Start Converting To String'), (Name: 'Button10'; Caption1: '';
    Caption2: 'Clear Received Data Logs'), (Name: 'CheckBox6'; Caption1: ''; Caption2: 'Switch To English Language'), (Name: 'CheckBox9'; Caption1: '';
    Caption2: 'Parse As String When Hexadecimal'), (Name: 'Button13'; Caption1: ''; Caption2: 'Data Received Direct to File'), (Name: 'Button14'; Caption1: '';
    Caption2: 'FileFinished'), (Name: 'CheckBox1'; Caption1: ''; Caption2: 'Create Desktop Shortcut'), (Name: 'Button15'; Caption1: '';
    Caption2: 'Show All Point'), (Name: 'Button16'; Caption1: ''; Caption2: 'Do The Operation'), (Name: 'Button26'; Caption1: ''; Caption2: 'Save Log As ...'),

    (Name: 'Button18'; Caption1: ''; Caption2: 'Zoom Out'), (Name: 'Button19'; Caption1: ''; Caption2: 'Zoom In'), (Name: 'ButtonColor1'; Caption1: '';
    Caption2: 'Graphic One Color'), (Name: 'ButtonColor2'; Caption1: ''; Caption2: 'Graphic Two Color'), (Name: 'Button20'; Caption1: '';
    Caption2: 'Export Data To Excel'), (Name: 'Button21'; Caption1: ''; Caption2: 'Clear Graphic Data'), (Name: 'Button22'; Caption1: '';
    Caption2: 'Save Graphic to BMP'), (Name: 'Button23'; Caption1: ''; Caption2: 'Load File'), (Name: 'Button24'; Caption1: '';
    Caption2: 'Send The File You Loaded'), (Name: 'CheckBox10'; Caption1: ''; Caption2: 'Show All Data'), (Name: 'CheckBox11'; Caption1: '';
    Caption2: 'Overlap Graphics'), (Name: 'Label18'; Caption1: ''; Caption2: 'Operation'), (Name: 'CheckBox12'; Caption1: '';
    Caption2: 'Compatible To Unicode'), (Name: 'Button12'; Caption1: ''; Caption2: 'Font'), (Name: 'Button17'; Caption1: '';
    Caption2: 'Background Color For Message Log'), (Name: 'Button25'; Caption1: ''; Caption2: 'Format To Hexade'));

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

function GetDefaultLauguageStrByName(Name: String; Lang: String): String;
function GetStyle(i: Integer): String;

procedure SetButtonCaptionLeftAlign(btn: TButton);
procedure AdjustComponenAttribute(Form: TForm);

procedure AdjustSetStyle(Style: String);
procedure AdjustComponentFont(Form: TForm; Font: TFont = nil);
procedure LoadLaunguageFromFile(Form: TForm; Path: String);
procedure AppendSystemMenu(handle: Thandle; OnClicEvent: TOnClicEvent);
procedure LoadDefaultLaunguage(Form: TForm; Lang: String);

function ByteToWideString(const buff: pbyte; len: Integer): String;
function ByteToWideString2(const buff: pbyte; len: Integer): String; // ��Ҫ�س�����#13#10

procedure WideStringToByte(str: String; var buff: array of byte);

function FormatHexStr(hs: string; var buf: array of byte): string;
function FormatHexStrToByte(sStr: string; var buffer: array of byte; out bCount: Integer): string;
function FormatHexStrToByte2(sStr: string; var buffer: array of byte): Integer;
function FormatHexStrToBuffer(sStr: string; var buffer: array of byte; out bCount: Integer): string;

function FormatBufferToHexStr(Const buffer: array of byte; Const bCount: Integer): string;
function ChecksumBuffer(Const buffer: array of byte; Const bCount: Integer): Integer;

function SpaceCompress(s: string): string;
function GetBuildInfo(FileName: string): String;
function IsImageFile(const fn: string): Boolean;
function IsMovieFile(const fn: string): Boolean;
function IsTxtFile(const fn: string): Boolean;
function IsHexFile(const fn: string): Boolean;
function IsBinFile(const fn: string): Boolean;

function MakeWord(b2: byte; b1: byte): Word;
function MakeDWord(w2: Word; w1: Word): Dword;

procedure IntToBuffer(value: Int64; var buffer: array of byte; iCount: Integer);
procedure StrToBuffer(str: String; var buffer: array of byte);

function checkIsHexStr(sStr: String): Boolean;

function StrToEncode(str: string; AEncoding: TEncoding): TStringStream;
function StringStreamToHexStr(ss: TStringStream): String;

function FormatHexToAscii(hs: string; var buf: array of byte): Integer;
function CharToDigit(c: Char): byte;
function DateToChar(d: byte): Char;
function CharToByte(a, b: Char): byte;

procedure StringToAssci(str: string; var buf: array of byte);

function readFileToStream(FileName: String): TFileStream;
function writeFileToStream(FileStream: TFileStream; buffer: array of byte; len: Integer): Integer;

function DetectTextFileEncoding(const FileName: string): TEncoding;
function CompareVersion(LVersion, RVersion: String): Boolean;
function RemoveQuotes(const str: string): string;
function NormalizeLineBreaks(const S: string): string;

implementation

function NormalizeLineBreaks(const S: string): string;
var
  Temp: string;
begin
  // Step 1: �� Windows ��� CRLF �滻Ϊ LF
  Temp := StringReplace(S, #13#10, #10, [rfReplaceAll]);

  // Step 2: ������ CR����ʽ macOS���滻Ϊ LF
  Temp := StringReplace(Temp, #13, #10, [rfReplaceAll]);

  // ����ѡ��Step 3: �� LF#13������׼���滻Ϊ LF��Ҳ����ֻ����һ�� LF
  Temp := StringReplace(Temp, #10#13, #10, [rfReplaceAll]);

  // Step 4: ���ͳһ���л��з�Ϊ CRLF��Windows ���
  Result := StringReplace(Temp, #10, #13#10, [rfReplaceAll]);
end;

function RemoveQuotes(const str: string): string;
begin
  Result := str;
  if (Length(Result) >= 2) and (Result[1] = '"') and (Result[Length(Result)] = '"') then
    Result := Copy(Result, 2, Length(Result) - 2);
end;

function CompareVersion(LVersion, RVersion: String): Boolean;
var
  Liv, Riv: Integer;
  Lsv, Rsv: String;
begin
  Result := false;
  Lsv := StringReplace(LVersion, '.', '', [rfReplaceAll, rfIgnoreCase]);
  Lsv := StringReplace(Lsv, '"', '', [rfReplaceAll, rfIgnoreCase]);

  Rsv := StringReplace(RVersion, '.', '', [rfReplaceAll, rfIgnoreCase]);
  Rsv := StringReplace(Rsv, '"', '', [rfReplaceAll, rfIgnoreCase]);

  try
    Liv := StrToInt(Lsv);
    Riv := StrToInt(Rsv);
  Except
  end;
  if Riv > Liv then
    Result := true;
end;

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

function writeFileToStream(FileStream: TFileStream; buffer: array of byte; len: Integer): Integer;
begin
  try
    Result := FileStream.Write(buffer, len);
    // FileStream.Seek()
  except
  end;
end;

function DateToChar(d: byte): Char;
begin
  case d of
    0 .. 9:
      Result := Chr(Ord('0') + d);
    10 .. 15:
      Result := Chr(Ord('A') + d - 10);
  else
    Result := '0';
  end;
end;

procedure StringToAssci(str: string; var buf: array of byte);
var
  i: Integer;
begin
  for i := 0 to sizeof(buf) - 1 do
  begin
    if i > Length(str) - 1 then
      buf[i] := 0
    else
      buf[i] := Ord(str[i + 1]);
  end;
end;

function FormatHexStr(hs: string; var buf: array of byte): string;
var
  i, len: Word;
begin
  Result := '';
  len := (Length(hs) + 2) div 3;
  ZeroMemory(@buf, len * 2);

  for i := 1 to len do
  begin
    buf[i - 1] := CharToByte(hs[i * 3 - 2], hs[i * 3 - 1]);
  end;
  for i := 1 to len do
  begin
    Result := Result + Format('%.02x ', [buf[i - 1]]);
  end;
end;

function FormatHexToAscii(hs: string; var buf: array of byte): Integer;
var
  i, len: Word;
begin
  Result := Length(hs);
  len := (Length(hs) + 2) div 3;
  ZeroMemory(@buf, len * 2);

  for i := 1 to len do
  begin
    buf[i - 1] := CharToByte(hs[i * 3 - 2], hs[i * 3 - 1]);
  end;
end;

function StringStreamToHexStr(ss: TStringStream): String;
var
  i: Integer;
begin
  for i := 0 to ss.Size - 1 do
    Result := Result + Format('%.2x ', [ss.Bytes[i]]);
end;

function StrToEncode(str: string; AEncoding: TEncoding): TStringStream;
begin
  Result := TStringStream.Create(str, AEncoding);
end;

// ȡ���ļ�����
function DetectTextFileEncoding(const FileName: string): TEncoding;
var
  buffer: array [0 .. 3] of byte;
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    Stream.ReadBuffer(buffer, sizeof(buffer));
    if (buffer[0] = $FF) and (buffer[1] = $FE) then
      Result := TEncoding.Unicode
    else if (buffer[0] = $FE) and (buffer[1] = $FF) then
      Result := TEncoding.BigEndianUnicode
    else if (buffer[0] = $EF) and (buffer[1] = $BB) and (buffer[2] = $BF) then
      Result := TEncoding.UTF8
    else if (buffer[0] = $2B) and (buffer[1] = $2F) and (buffer[2] = $76) then
      Result := TEncoding.UTF7
    else
      Result := TEncoding.Default; // Ĭ��ʹ��ϵͳĬ�ϱ���
  finally
    Stream.Free;
  end;
end;

function checkIsHexStr(sStr: String): Boolean;
var
  i: Integer;
begin
  Result := true;
  sStr := UpperCase(Trim(sStr));
  sStr := StringReplace(sStr, '0X', ' ', [rfReplaceAll]); // �滻0X
  sStr := StringReplace(sStr, ',', ' ', [rfReplaceAll]); // �滻 ,��
  sStr := StringReplace(sStr, '��', ' ', [rfReplaceAll]); // �滻 ,��
  sStr := StringReplace(sStr, ' ', ' ', [rfReplaceAll]); // �滻 tab

  sStr := StringReplace(sStr, ' ', '', [rfReplaceAll]); // ȥ�����пտ�
  for i := 1 to Length(sStr) do // �ַ����� �� 1 .... Length(sStr)
  begin
    if not(sStr[i] in ['0' .. '9', 'A', 'B', 'C', 'D', 'E', 'F']) then
    begin
      Result := false;
      break;
    end;
  end;
end;

procedure StrToBuffer(str: String; var buffer: array of byte);
begin
  CopyMemory(@buffer, @str[1], Length(str));
end;

// ��̬��������Ϊ�����������ͨ����Length(buffer) ��ȡʵ�ʳ���
// &@ȡ��ַ����Ϊָ�봫���޷��õ�ʵ�ʵĳ���
// ��̬���������� VAR �ؼ��ֲ��������ô��ݣ�����Ҳ��ֵ����
procedure IntToBuffer(value: Int64; var buffer: array of byte; iCount: Integer);
var
  i, j: Integer;
begin
  // for I := 0 to iCount -1 do
  j := 0;
  for i := iCount - 1 downto 0 do
  begin
    buffer[j] := value shr (i * 8);
    INC(j);
    // if(j >= Length(buffer)) then
    // break;
  end;
end;

function MakeWord(b2: byte; b1: byte): Word;
begin
  Result := b2;
  Result := Result shl 8 + b1;
end;

function MakeDWord(w2: Word; w1: Word): Dword;
begin
  Result := w2;
  Result := Result shl 16 + w1;
end;

function IsImageFile(const fn: string): Boolean;
var
  extfn: String;
begin
  extfn := LowerCase(ExtractFileExt(fn));
  Result := (extfn = '.jpg') or (extfn = '.jpeg') or (extfn = '.gif') or (extfn = '.png') or (extfn = '.bmp');
end;

function IsMovieFile(const fn: string): Boolean;
var
  extfn: String;
begin
  extfn := LowerCase(ExtractFileExt(fn));
  Result := (extfn = '.rmvb') or (extfn = '.rm') or (extfn = '.mov') or (extfn = '.mkv') or (extfn = '.avi') or (extfn = '.flv');
end;

function IsTxtFile(const fn: string): Boolean;
var
  extfn: String;
begin
  extfn := LowerCase(ExtractFileExt(fn));
  Result := (extfn = '.txt') or (extfn = '.csv') or (extfn = '.cvs') or (extfn = '.scv');
end;

function IsHexFile(const fn: string): Boolean;
var
  extfn: String;
begin
  extfn := LowerCase(ExtractFileExt(fn));
  Result := (extfn = '.hex');
end;

function IsBinFile(const fn: string): Boolean;
var
  extfn: String;
begin
  extfn := LowerCase(ExtractFileExt(fn));
  Result := (extfn = '.bin') or (extfn = '.binary') or (extfn = '.elf') or (extfn = '.axf');
end;

function GetBuildInfo(FileName: string): String;
var
  VerInfoSize, VerValueSize, Dummy: Dword;
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
    Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3) + '.' + IntToStr(V4);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

function CharToDigit(c: Char): byte; // �ַ���ʾ�����������Ƕ�Ӧ��ASCII ֵ
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

function FormatHexStrToByte(sStr: string; var buffer: array of byte; out bCount: Integer): string;
var
  i, Count, bLen: Word;
  a, b: Char;
begin
  sStr := sStr.UpperCase(Trim(sStr));
  // ȥ���м���ܵĸ�ʽ�ַ�
  sStr := StringReplace(sStr, '0x', ' ', [rfReplaceAll]); // �滻0x
  sStr := StringReplace(sStr, '0X', ' ', [rfReplaceAll]); // �滻0X
  sStr := StringReplace(sStr, ',', ' ', [rfReplaceAll]); // �滻 ,��
  sStr := StringReplace(sStr, '��', ' ', [rfReplaceAll]); // �滻 ,��
  sStr := StringReplace(sStr, ' ', ' ', [rfReplaceAll]); // �滻 tab

  // ѹ���м�ո�,���ǰѶ���ո��滻��һ��,��ȥ����ͷ�Ŀո�
  Result := Trim(SpaceCompress(sStr));

  Count := (Length(Result) + 2) div 3;
  bCount := Count;

  bLen := Length(buffer);
  ZeroMemory(@buffer, bLen);

  for i := 1 to Count do
  begin
    a := Result[i * 3 - 2];
    b := Result[i * 3 - 1];
    buffer[i - 1] := CharToByte(a, b);
  end;

  Result := '';
  for i := 1 to Count do
  begin
    Result := Result + Format('%.02x ', [buffer[i - 1]]);
  end;
end;

function FormatHexStrToByte2(sStr: string; var buffer: array of byte): Integer;
var
  i, Count, bLen: Word;
  a, b: Char;
  strStr: String;
begin
  sStr := sStr.UpperCase(Trim(sStr));
  // ȥ���м���ܵĸ�ʽ�ַ�
  // sStr := StringReplace(sStr, '0x', ' ', [rfReplaceAll]); // �滻0x
  sStr := StringReplace(sStr, '0X', ' ', [rfReplaceAll]); // �滻0X
  sStr := StringReplace(sStr, ',', ' ', [rfReplaceAll]); // �滻 ,��
  sStr := StringReplace(sStr, '��', ' ', [rfReplaceAll]); // �滻 ,��
  sStr := StringReplace(sStr, ' ', ' ', [rfReplaceAll]); // �滻 tab

  // ѹ���м�ո�,���ǰѶ���ո��滻��һ��,��ȥ����ͷ�Ŀո�
  strStr := Trim(SpaceCompress(sStr));

  Count := (Length(strStr) + 2) div 3;
  bLen := Length(buffer);
  ZeroMemory(@buffer, bLen);

  for i := 1 to Count do
  begin
    a := strStr[i * 3 - 2];
    b := strStr[i * 3 - 1];
    buffer[i - 1] := CharToByte(a, b);
  end;
  Result := Count;
end;

function FormatHexStrToBuffer(sStr: string; var buffer: array of byte; out bCount: Integer): string;
var
  i, Count: Integer;
  a, b: Char;
begin
  sStr := sStr.UpperCase(Trim(sStr));
  // ȥ���м���ܵĸ�ʽ�ַ�
  // sStr := StringReplace(sStr, '0x', ' ', [rfReplaceAll]); // �滻0x
  sStr := StringReplace(sStr, '0X', ' ', [rfReplaceAll]); // �滻0X
  sStr := StringReplace(sStr, ',', ' ', [rfReplaceAll]); // �滻 ,��
  sStr := StringReplace(sStr, '��', ' ', [rfReplaceAll]); // �滻 ,��
  sStr := StringReplace(sStr, ' ', ' ', [rfReplaceAll]); // �滻 tab

  Result := StringReplace(sStr, ' ', '', [rfReplaceAll]); // ȥ�����пտ�

  Count := Length(Result) div 2;
  bCount := Count;
  // bLen := length(buf);
  // ZeroMemory(@buf, bLen);

  for i := 0 to Count - 1 do
  begin
    a := Result[i * 2 + 1];
    b := Result[i * 2 + 2];
    buffer[i] := CharToByte(a, b);
  end;
  Result := '';
  for i := 0 to Count - 1 do
  begin
    Result := Result + Format('%.02x ', [buffer[i]]);
  end;
end;

function FormatBufferToHexStr(Const buffer: array of byte; Const bCount: Integer): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to bCount - 1 do
  begin
    Result := Result + Format('%.02x ', [buffer[i]]);
  end;
end;

function ChecksumBuffer(Const buffer: array of byte; Const bCount: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to bCount - 1 do
  begin
    Result := Result + buffer[i];
  end;
end;

function SpaceCompress(s: string): string;
var
  hs1, hs2: String;
begin
  hs1 := s;
  while (true) do
  begin
    hs2 := StringReplace(hs1, '  ', ' ', [rfReplaceAll]); // ɾ��'  '
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

function StripNonAsciiExceptCRLF(const value: AnsiString): AnsiString;
var
  AnsiCh: AnsiChar;
begin
  for AnsiCh in value do
    if (AnsiCh >= #32) and (AnsiCh <= #127) and (AnsiCh <> #13) and (AnsiCh <> #10) then
      Result := Result + AnsiCh;
end;

function ByteToWideString(const buff: pbyte; len: Integer): String;
var
  str: AnsiString;
  // buffer: array of byte;
begin
  try
    // SetLength(buffer, len);
    SetLength(str, len);
    // Move(buff, buffer, len);
    // CopyMemory(buffer, buff, len);
    // Move(buffer, str[1], len);
    CopyMemory(@str[1], buff, len);
    Result := str;
  Except
  end;
end;

function ByteToWideString2(const buff: pbyte; len: Integer): String; // ��Ҫ�س�����#13#10
var
  str: AnsiString;
begin
  try
    SetLength(str, len);
    CopyMemory(@str[1], buff, len);
    str := StringReplace(str, Chr(13) + Chr(10), '', [rfReplaceAll]); // ɾ���س�
    Result := StripNonAsciiExceptCRLF(str);
  Except
  end;
end;

function ByteToWideString3(const buff: pbyte; len: Integer): String; // ��Ҫ�س�����#13#10
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
    str := StringReplace(str, Chr(13) + Chr(10), '', [rfReplaceAll]); // ɾ���س�
    Result := Trim(str);
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
  CopyMemory(@buff, @astr[1], Length(astr));
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
  AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, SystemMainMenu.handle, PChar(SystemMainMenu.Items.Caption));
  // for i := Low(TStyleManager.StyleNames) to High(TStyleManager.StyleNames) do
  // AppendMenu(Menu,MF_POPUP,100+i,pchar(TStyleManager.StyleNames[i]));
  AppendMenu(GetSysteMmenu(handle, false), MF_SEPARATOR, 1024, nil);
  AppendMenu(GetSysteMmenu(handle, false), MF_UNCHECKED, 1025, PChar('Keep At The Top Always '));
  // AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, 1026, pchar(VERSIONNAME));
  // AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, 1027, pchar('English'));
  // AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, 1028,  pchar('Chinese'));
  AppendMenu(GetSysteMmenu(handle, false), MF_SEPARATOR, 1027, nil);
  AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, 1028, PChar('Help Support'));
  // AppendMenu(GetSysteMmenu(handle, false), MF_POPUP, 1029, pchar(WEB_SITE));
end;

function GetStyle(i: Integer): String;
begin
  if (i >= 0) and (i <= High(TStyleManager.StyleNames)) then
    Result := TStyleManager.StyleNames[i]
  else
    Result := '';
end;

procedure AdjustSetStyle(Style: String);
begin
  try
    TStyleManager.SetStyle(Style);
  finally
  end;
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

procedure AdjustComponentFont(Form: TForm; Font: TFont); // ��������־��������ɫ
var
  f: TFont;
  i: Integer;
  tmpComponent: TComponent;
begin
  if Font <> nil then
  begin
    f := Font;
  end
  else
  begin // Ĭ������
    f := TFont.Create;
    f.Charset := TFontCharset(DEFAULT_CHARSET);
    f.Color := clWindowText;
    f.Name := 'Segoe UI';
    f.Size := 10;
    // f.Style :=[fsBold];
  end;

  Form.Font := f;
  Form.Font := f;
  For i := 0 To Form.ComponentCount - 1 Do
  Begin
    tmpComponent := Form.Components[i];

    if tmpComponent is TForm then
    begin
      TForm(tmpComponent).Font := f;
    end;

    if tmpComponent is TSplitView then
    begin
      // TSplitView(tmpComponent).ParentFont := false;
      TSplitView(tmpComponent).Font := f;
    end;

    if tmpComponent is TButton then
    begin
      // TButton(tmpComponent).ParentFont := false;
      TButton(tmpComponent).Font := f;
      TButton(tmpComponent).Height := 34;
    end;

    if tmpComponent is TSpeedButton then
    begin
      // TButton(tmpComponent).ParentFont := false;
      TSpeedButton(tmpComponent).Font := f;
      TSpeedButton(tmpComponent).Height := 34;
    end;

    if tmpComponent is TCheckBox then
    begin
      // TCheckBox(tmpComponent).ParentFont := false;
      TCheckBox(tmpComponent).Font := f;
    end;

    if tmpComponent is TLabel then
    begin
      // TLabel(tmpComponent).ParentFont := false;
      TLabel(tmpComponent).Font := f;
    end;

    if tmpComponent is TComboBox then
    begin
      // TComboBox(tmpComponent).ParentFont := false;
      TComboBox(tmpComponent).Font := f;
    end;

    if tmpComponent is TEdit then
    begin
      // TEdit(tmpComponent).ParentFont := false;
      TEdit(tmpComponent).Font := f;
    end;

    if tmpComponent is TComboBoxEx then
    begin
      // TComboBoxEx(tmpComponent).ParentFont := false;
      TComboBoxEx(tmpComponent).Font := f;
    end;

    if tmpComponent is TStringGrid then
    begin
      // TStringGrid(tmpComponent).ParentFont := false;
      TStringGrid(tmpComponent).Font := f;
    end;

    if tmpComponent is TPanel then
    begin
      // TPanel(tmpComponent).ParentFont := false;
      TPanel(tmpComponent).Font := f;
    end;

    if tmpComponent is TTabSet then
    begin
      // TTabSet(tmpComponent).ParentFont := false;
      TTabSet(tmpComponent).Font := f;
    end;

    if tmpComponent is TNoteBook then
    begin
      TNoteBook(tmpComponent).Font := f;
    end;

    if tmpComponent is TStatusBar then
    begin
      TStatusBar(tmpComponent).Font := f;
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
        TButton(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE', str, TButton(tmpComponent).Caption);

      if tmpComponent is TCheckBox then
        TCheckBox(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE', str, TCheckBox(tmpComponent).Caption);

      if tmpComponent is TLabel then
        TLabel(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE', str, TLabel(tmpComponent).Caption);

      if tmpComponent is TMenuItem then
        TMenuItem(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE', str, TMenuItem(tmpComponent).Caption);
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
        TButton(tmpComponent).Caption := GetDefaultLauguageStrByName(tmpComponent.Name, 'EN');

      if tmpComponent is TCheckBox then
        TCheckBox(tmpComponent).Caption := GetDefaultLauguageStrByName(tmpComponent.Name, 'EN');

      if tmpComponent is TLabel then
        TLabel(tmpComponent).Caption := GetDefaultLauguageStrByName(tmpComponent.Name, 'EN');

      if tmpComponent is TMenuItem then
        TMenuItem(tmpComponent).Caption := GetDefaultLauguageStrByName(tmpComponent.Name, 'EN');
    End;
  END;
end;

end.
