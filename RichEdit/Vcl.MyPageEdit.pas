unit Vcl.MyPageEdit;

interface

uses
  System.SysUtils, System.StrUtils, Winapi.Windows, Winapi.Messages, Winapi.RichEdit, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, Vcl.ClipBrd,
  Vcl.ToolWin, Vcl.ActnList, System.Actions, System.ImageList, Vcl.ImgList, Vcl.StdActns, Vcl.ExtActns,
  Vcl.Tabs, VCLTee.TeCanvas, Vcl.Grids, Vcl.WinXCtrls, Vcl.TabNotBk, Vcl.Themes, SHDocVw, SyncObjs, Vcl.Printers;

type
  TEventCallBackFuntion = Procedure(Msg: String) of object;

  TMyMemo = class(TMemo)
  private
    FTAG: String;
    FSourceBytes: TBytes;
    FLock: TCriticalSection; // 用于线程同步的临界区对象
  protected
  public
    FStyle: Integer;
    FEncoding: TEncoding;
    FFileName: String;
    FHexadecimalMode: Boolean;
    FShowLinesNumber: Boolean;
    EventCallBackFuntion: TEventCallBackFuntion;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetLastLine(): String;
    function GetLine(Line: Integer): String;

    procedure Clear();
    procedure Log(const Msg: String);
    procedure LogLine(const Msg: String; Line: Integer);
    procedure LogEndLine(const Msg: String);
    procedure LogBuffer(const Buffer: array of Byte; Count: Integer);

    procedure SaveTo(const FileName: String); overload;
    procedure SaveTo(const FileName: String; Encoding: TEncoding); overload;
    procedure LoadFrom(FileName: String); overload;
    procedure LoadFrom(FileName: String; Encoding: TEncoding); overload;
    procedure ConvertEncoding(TargetEncoding: TEncoding);
    procedure ConvertToUTF8WithBOM();
    procedure ConvertEncoding3(TargetEncoding: TEncoding);
    procedure SetDefaultFormat();
    procedure SetHexadecimalMode(); overload;
    procedure SetHexadecimalMode(HexMode: Boolean); overload;
    procedure Print(TitleStr: string = 'No Title'); overload;
    procedure Print(UserPrinter: TPrinter; TitleStr: string = 'No Title'); overload;
  published
  end;

  TMyRichEdit = class(TRichEdit)
  private
    FTAG: String;
    FSourceBytes: TBytes;
    FLock: TCriticalSection; // 用于线程同步的临界区对象
    FPrevTimestamp: TDateTime;
  protected
  public
    FStyle: Integer;
    FEncoding: TEncoding;
    FFileName: String;
    FHexadecimalMode: Boolean;
    FShowLinesNumber: Boolean;
    EventCallBackFuntion: TEventCallBackFuntion;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetRichEditText(RichEdit: TRichEdit): WideString; overload;
    function GetRichEditText(RichEdit: TRichEdit; AnsiCodePage: UINT): AnsiString; overload;

    function GetLastLine(): String;
    function GetLine(Line: Integer): String;
    function IsModifiedByExternal(): Boolean;
    procedure Clear();
    procedure Log(const Msg: String);
    procedure LogLine(const Msg: String; Line: Integer);
    procedure LogEndLine(const Msg: String);
    procedure LogBuffer(const Buffer: array of Byte; Count: Integer);

    procedure SaveTo(const FileName: String); overload;
    procedure SaveTo(const FileName: String; Encoding: TEncoding); overload;
    procedure LoadFrom(FileName: String); overload;
    procedure LoadFrom(FileName: String; Encoding: TEncoding); overload;
    procedure ConvertEncoding(TargetEncoding: TEncoding);
    procedure ConvertToUTF8WithBOM();
    procedure ConvertEncoding3(TargetEncoding: TEncoding);
    procedure ShowLinesNumber();
    procedure SetDefaultFormat();
    procedure SetHexadecimalMode(); overload;
    procedure SetHexadecimalMode(HexMode: Boolean); overload;

  published
  end;

  TMyPageEdit = class(TPageControl)
  private
    FRichEditList: TList;
  protected
  public

    constructor Create(AOwner: TComponent); override;
    procedure CreatePage(PageName: String; PageType: Integer = 0);
    procedure DeletePage(PageName: String); overload;
    procedure DeletePageComponent(Index: Integer); overload;
    procedure SetPageName(PageName: String; PageIndex: Integer);

    procedure Log(Msg: String; Index: Integer);
    /// procedure Clear(Index: Integer);
    procedure FreeAll();

    function GetEdit(Index: Integer): TMyRichEdit; overload;
    function GetEdit(PageName: String): TMyRichEdit; overload;

    function GetMemo(Index: Integer): TMyMemo; overload;
    function GetMemo(PageName: String): TMyMemo; overload;

    function GetComponent(Index: Integer): TComponent; overload;
    function GetComponent(PageName: String): TComponent; overload;

    function GetWebBrowser(Index: Integer): TWebBrowser; overload;
    function GetWebBrowser(PageName: String): TWebBrowser; overload;

    function GetPageName(Index: Integer): String;
    function GetActivePageName(): String;
    function GetPageByName(PageName: String): TTabSheet;
    function GetPageByIndex(PageIndex: Integer): TTabSheet;
    function GetPageIndex(PageName: String): Integer;

    function LoadFileFrom(PathFileName: String; PageName: String): TMyRichEdit;
  published
  end;

function DetectTextFileEncoding(const FileName: string): TEncoding;

implementation

uses DataEngine;

/// //////////////////////////////////////////////////////////////////////////////
/// //////////////////////////////////////////////////////////////////////////////
/// Memo
constructor TMyMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLock := TCriticalSection.Create;
end;

destructor TMyMemo.Destroy;
begin
  FLock.Free;
  inherited Destroy;
end;

procedure TMyMemo.Clear();
begin
  FLock.Enter;
  try
    Self.Lines.Clear;
  finally
    FLock.Leave;
  end;
end;

procedure TMyMemo.Log(const Msg: String);
begin
  FLock.Enter;
  try
    try
      Self.Lines.Append(Msg);
    Except
      on E: Exception do
      begin
        if Assigned(EventCallBackFuntion) then
          EventCallBackFuntion(E.Message);
      end;
    end;
  finally
    FLock.Leave;
  end;
end;

procedure TMyMemo.LogLine(const Msg: String; Line: Integer);
begin
  if (Self.Lines.Count > 0) and (Line >= 0) and (Line < Self.Lines.Count) then
  begin
    FLock.Enter;
    try
      Lines.Strings[Line] := Msg;
    finally
      FLock.Leave;
    end;
  end
  else
    Log(Msg);
end;

procedure TMyMemo.LogEndLine(const Msg: String);
begin
  if Lines.Count > 0 then
  begin
    FLock.Enter;
    try
      Lines.Strings[Lines.Count - 1] := Lines.Strings[Lines.Count - 1] + Msg;
    finally
      FLock.Leave;
    end;
  end
  else
    Log(Msg);
end;

procedure TMyMemo.LogBuffer(const Buffer: array of Byte; Count: Integer);
var
  i: Integer;
  str: String;
begin
  str := '';
  for i := 0 to Count - 1 do
  begin
    str := str + Format('%.02x ', [Buffer[i]]);
    if ((i + 1) mod 16) = 0 then
    begin
      Log(str);
      str := '';
    end;
  end;
  if str <> '' then
    Log(str);
end;

function TMyMemo.GetLastLine(): String;
begin
  try
    if Lines.Count > 0 then
      Result := Lines.Strings[Lines.Count - 1]
    else
      Result := '';
  finally
    FLock.Leave;
  end;
end;

function TMyMemo.GetLine(Line: Integer): String;
begin
  Result := '';
  FLock.Enter;
  try
    if (Line < 0) or (Line >= Lines.Count) then
      Result := ''
    else
      Result := Lines.Strings[Line];
  finally
    FLock.Leave;
  end;
end;

procedure TMyMemo.SaveTo(const FileName: String);
begin
  Lines.SaveToFile(FileName);
  Self.FFileName := FileName;
end;

procedure TMyMemo.SaveTo(const FileName: String; Encoding: TEncoding);
begin
  Lines.SaveToFile(FileName, Encoding);
  Self.FFileName := FileName;
end;

procedure TMyMemo.LoadFrom(FileName: String);
begin
  if FileExists(FileName) then
  begin
    Self.Lines.LoadFromFile(FileName);
    Self.FFileName := FileName;
  end
  else if FileExists(Self.FFileName) then
  begin
    Self.Lines.LoadFromFile(Self.FFileName);
  end
  else
  begin
    /// ConvertEncoding(Self.Lines.Encoding);
  end;
end;

procedure TMyMemo.LoadFrom(FileName: String; Encoding: TEncoding);
begin
  if FileExists(FileName) then
  begin
    try
      Self.Lines.LoadFromFile(FileName, Encoding);
    Except
    end;
    Self.FFileName := FileName;
  end;
end;

procedure TMyMemo.ConvertEncoding(TargetEncoding: TEncoding);
var
  SourceBytes, TargetBytes: TBytes;
  SourceEncoding: TEncoding;
begin
  SourceEncoding := Self.Lines.Encoding;
  // 将Memo控件中的文本内容转换为源编码格式的字节序列
  SourceBytes := SourceEncoding.GetBytes(Text);

  // 将源编码格式的字节序列转换为目标编码格式的字节序列
  TargetBytes := TEncoding.Convert(SourceEncoding, TargetEncoding, SourceBytes);

  // 将目标编码格式的字节序列转换为字符串，并更新Memo控件的内容
  Text := TargetEncoding.GetString(TargetBytes);
end;

procedure TMyMemo.ConvertToUTF8WithBOM();
var
  UTF8Encoding: TEncoding;
  BOM: TBytes;
  TextBytes: TBytes;
begin
  // 创建UTF-8编码和BOM字节序列
  UTF8Encoding := TEncoding.UTF8;
  BOM := TEncoding.UTF8.GetPreamble;

  // 将UTF-8编码的文本转换为字节序列
  TextBytes := TEncoding.UTF8.GetBytes(Text);

  // 合并BOM和文本字节序列
  Text := UTF8Encoding.GetString(BOM + TextBytes);
end;

procedure TMyMemo.ConvertEncoding3(TargetEncoding: TEncoding);
var
  ss: TStringStream;
begin
  ss := TStringStream.Create(Text, TargetEncoding);
  Lines.LoadFromStream(ss);
  /// ss.Free;
end;

procedure TMyMemo.SetDefaultFormat();
begin
  Font.Charset := TFontCharset(DEFAULT_CHARSET);
  Font.Name := '新宋体';
  Font.Size := 14;
  SelStart := MaxInt;

  WantReturns := false;
  HideSelection := false;
  ParentFont := false;
end;

procedure TMyMemo.SetHexadecimalMode();
var
  SourceEncoding: TEncoding;
  /// i: Integer;
begin
  SourceEncoding := Self.Lines.Encoding;
  // 将Memo控件中的文本内容转换为源编码格式的字节序列
  FSourceBytes := SourceEncoding.GetBytes(Text);
  Self.Clear;
  LogBuffer(FSourceBytes, Length(FSourceBytes));
  DataEngineManager.Remove2(FTAG);
end;

procedure TMyMemo.SetHexadecimalMode(HexMode: Boolean);
begin
  FTAG := 'SetHexadecimalMode';
  if (not Self.FHexadecimalMode) and (HexMode) then
  begin
    FHexadecimalMode := true;
    if not DataEngineManager.Exist2(FTAG, nil) then
      DataEngineManager.DoAction(FTAG, SetHexadecimalMode);
  end;

  if (not HexMode) then
  begin
    LoadFrom('');
    FHexadecimalMode := false;
  end;
end;

procedure TMyMemo.Print(TitleStr: string);
var
  Left: Integer;
  Top: Integer;
  i, j, X, Y: Integer; // PageHeight,
  PagesStr: String;
  posX, posY, Posx1, posY1: Integer;
  PrintDialog1: TPrintDialog;
begin
  Left := 500;
  Top := 800;
  Y := Top; // 40
  X := Left; // 80
  j := 1;
  PrintDialog1 := TPrintDialog.Create(Application);
  if PrintDialog1.Execute then
    With Printer do
    begin
      BeginDoc; // 另存的打印的文件名 如何实现  默认为 .jnt
      Canvas.Font := Font;
      // -------------------------------------------------------------------------
      // 打印文件名的标题
      // TitleStr:='无标题';
      posX := (PageWidth div 2) - Length(TitleStr) * 50; // x+1800;
      posY := (PageHeight * 6) div 100;

      // 第N页的标题
      PagesStr := Format('第 %d 页', [Printer.PageNumber]);
      Posx1 := (PageWidth div 2) - Length(PagesStr) * 50;
      posY1 := (PageHeight * 92) div 100;
      // -------------------------------------------------------------------------
      for i := 0 to Lines.Count - 1 do
      begin
        Canvas.TextOut(X, Y, Lines[i]); // TextOut(Left,Top,string);
        Y := Y + Font.Size * 10; // Memo.Font.Size*10为行间距 第1行与第2行的间距,2和3,3与4,...

        if (Y > PageHeight - Top) then
        begin
          Canvas.TextOut(posX, posY, TitleStr);
          for j := 1 to Printer.PageNumber do
          begin
            PagesStr := Format('第 %d 页', [j]);
            Canvas.TextOut(Posx1, posY1, PagesStr);
            Application.ProcessMessages;
          end;
          NewPage;
          Y := Top;
        end;
      end;
      Canvas.TextOut(posX, posY, TitleStr);
      Canvas.TextOut(Posx1, posY1, Format('第 %d 页', [j]));
      // Form1.Label1.Caption:=System.Concat(' 正在打印',#13#10,TitleStr,#13#10,Format('第 %d 页',[j]));
      EndDoc;
      // Form1.Caption:= Format('x = %d y = %d Width = %d Height = %d ',[x,y,PageWidth,Pageheight]);
    end;
end;

procedure TMyMemo.Print(UserPrinter: TPrinter; TitleStr: string);
var
  Left: Integer;
  Top: Integer;
  i, j, X, Y: Integer; // PageHeight,
  PagesStr: String;
  posX, posY, Posx1, posY1: Integer;
  // PrintDialog1: TPrintDialog;
begin
  Left := 500;
  Top := 800;
  Y := Top; // 40
  X := Left; // 80
  j := 1;
  // PrintDialog1 := TPrintDialog.Create(Application);
  // if PrintDialog1.Execute then

  With Printer do
  begin
    BeginDoc; // 另存的打印的文件名 如何实现  默认为 .jnt
    Canvas.Font := Font;
    // -------------------------------------------------------------------------
    // 打印文件名的标题
    // TitleStr:='无标题';
    posX := (PageWidth div 2) - Length(TitleStr) * 50; // x+1800;
    posY := (PageHeight * 6) div 100;

    // 第N页的标题
    PagesStr := Format('第 %d 页', [Printer.PageNumber]);
    Posx1 := (PageWidth div 2) - Length(PagesStr) * 50;
    posY1 := (PageHeight * 92) div 100;
    // -------------------------------------------------------------------------
    for i := 0 to Lines.Count - 1 do
    begin
      Canvas.TextOut(X, Y, Lines[i]); // TextOut(Left,Top,string);
      Y := Y + Font.Size * 10; // Memo.Font.Size*10为行间距 第1行与第2行的间距,2和3,3与4,...

      if (Y > PageHeight - Top) then
      begin
        Canvas.TextOut(posX, posY, TitleStr);
        for j := 1 to Printer.PageNumber do
        begin
          PagesStr := Format('第 %d 页', [j]);
          Canvas.TextOut(Posx1, posY1, PagesStr);
          Application.ProcessMessages;
        end;
        NewPage;
        Y := Top;
      end;
    end;
    Canvas.TextOut(posX, posY, TitleStr);
    Canvas.TextOut(Posx1, posY1, Format('第 %d 页', [j]));
    // Form1.Label1.Caption:=System.Concat(' 正在打印',#13#10,TitleStr,#13#10,Format('第 %d 页',[j]));
    EndDoc;
    // Form1.Caption:= Format('x = %d y = %d Width = %d Height = %d ',[x,y,PageWidth,Pageheight]);
  end;
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// RichEdit
constructor TMyRichEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLock := TCriticalSection.Create;
end;

destructor TMyRichEdit.Destroy;
begin
  FLock.Free;
  inherited Destroy;
end;

procedure TMyRichEdit.Clear();
begin
  FLock.Enter;
  try
    Self.Lines.Clear;
  finally
    FLock.Leave;
  end;
end;

procedure TMyRichEdit.Log(const Msg: String);
begin

  FLock.Enter;
  try
    try
      Self.Lines.Append(Msg);
    Except
      on E: Exception do
      begin
        if Assigned(EventCallBackFuntion) then
          EventCallBackFuntion(E.Message);
      end;
    end;
  finally
    FLock.Leave;
  end;

  /// Except
  /// ShowMessage('This error message is due to ??');
  /// if Assigned(EventCallBackFuntion) then
  /// EventCallBackFuntion(Self);
  /// end;
end;

procedure TMyRichEdit.LogLine(const Msg: String; Line: Integer);
begin
  if (Self.Lines.Count > 0) and (Line >= 0) and (Line < Self.Lines.Count) then
  begin
    FLock.Enter;
    try
      Lines.Strings[Line] := Msg;
    finally
      FLock.Leave;
    end;
  end
  else
    Log(Msg);
end;

procedure TMyRichEdit.LogEndLine(const Msg: String);
begin
  if Lines.Count > 0 then
  begin
    FLock.Enter;
    try
      Lines.Strings[Lines.Count - 1] := Lines.Strings[Lines.Count - 1] + Msg;
    finally
      FLock.Leave;
    end;
  end
  else
    Log(Msg);
end;

procedure TMyRichEdit.LogBuffer(const Buffer: array of Byte; Count: Integer);
var
  i: Integer;
  str: String;
begin
  str := '';
  for i := 0 to Count - 1 do
  begin
    str := str + Format('%.02x ', [Buffer[i]]);
    if ((i + 1) mod 16) = 0 then
    begin
      Log(str);
      str := '';
    end;
  end;
  if str <> '' then
    Log(str);
end;

function TMyRichEdit.GetLastLine(): String;
begin
  try
    if Lines.Count > 0 then
      Result := Lines.Strings[Lines.Count - 1]
    else
      Result := '';
  finally
    FLock.Leave;
  end;
end;

function TMyRichEdit.GetLine(Line: Integer): String;
begin
  Result := '';
  FLock.Enter;
  try
    if (Line < 0) or (Line >= Lines.Count) then
      Result := ''
    else
      Result := Lines.Strings[Line];
  finally
    FLock.Leave;
  end;
end;

function TMyRichEdit.IsModifiedByExternal(): Boolean;
var
  CurrentTimestamp: TDateTime;
begin
  CurrentTimestamp := FileAge(Self.FFileName);
  if CurrentTimestamp <> FPrevTimestamp then
  begin
    /// ShowMessage('The file has been modified externally.');
    // Do something in response to the external modification
  end;
end;

procedure TMyRichEdit.SaveTo(const FileName: String);
var
  ext: String;
begin
  ext := LowerCase(ExtractFileExt(FFileName));
  if (ext = '.txt') or (ext = '.log') or (ext = '') then
    Self.PlainText := true
  else
    Self.PlainText := false;

  if (ext <> '.rtf') then
    Self.PlainText := true
  else
    Self.PlainText := false;

  Lines.SaveToFile(FileName);
  Self.FFileName := FileName;
  Self.FPrevTimestamp := FileAge(FileName);
end;

procedure TMyRichEdit.SaveTo(const FileName: String; Encoding: TEncoding);
var
  ext: String;
begin
  ext := LowerCase(ExtractFileExt(FFileName));
  if (ext = '.txt') or (ext = '.log') or (ext = '') then
    Self.PlainText := true
  else
    Self.PlainText := false;

  if (ext <> '.rtf') then
    Self.PlainText := true
  else
    Self.PlainText := false;

  Lines.SaveToFile(FileName, Encoding);
  Self.FFileName := FileName;
  Self.FPrevTimestamp := FileAge(FileName);
end;

procedure TMyRichEdit.LoadFrom(FileName: String);
begin
  if FileExists(FileName) then
  begin
    Self.Lines.LoadFromFile(FileName);
    Self.FFileName := FileName;
  end
  else if FileExists(Self.FFileName) then
  begin
    Self.Lines.LoadFromFile(Self.FFileName);
  end
  else
  begin
    /// ConvertEncoding(Self.Lines.Encoding);
  end;
end;

procedure TMyRichEdit.LoadFrom(FileName: String; Encoding: TEncoding);
begin
  if FileExists(FileName) then
  begin
    try
      Self.Lines.LoadFromFile(FileName, Encoding);
    Except
    end;
    Self.FFileName := FileName;
  end;
end;

procedure TMyRichEdit.ConvertEncoding(TargetEncoding: TEncoding);
var
  SourceBytes, TargetBytes: TBytes;
  SourceEncoding: TEncoding;
begin
  SourceEncoding := Self.Lines.Encoding;
  // 将Memo控件中的文本内容转换为源编码格式的字节序列
  SourceBytes := SourceEncoding.GetBytes(Text);

  // 将源编码格式的字节序列转换为目标编码格式的字节序列
  TargetBytes := TEncoding.Convert(SourceEncoding, TargetEncoding, SourceBytes);

  // 将目标编码格式的字节序列转换为字符串，并更新Memo控件的内容
  Text := TargetEncoding.GetString(TargetBytes);
end;

procedure TMyRichEdit.ConvertToUTF8WithBOM();
var
  UTF8Encoding: TEncoding;
  BOM: TBytes;
  TextBytes: TBytes;
begin
  // 创建UTF-8编码和BOM字节序列
  UTF8Encoding := TEncoding.UTF8;
  BOM := TEncoding.UTF8.GetPreamble;

  // 将UTF-8编码的文本转换为字节序列
  TextBytes := TEncoding.UTF8.GetBytes(Text);

  // 合并BOM和文本字节序列
  Text := UTF8Encoding.GetString(BOM + TextBytes);
end;

procedure TMyRichEdit.ConvertEncoding3(TargetEncoding: TEncoding);
var
  ss: TStringStream;
begin
  ss := TStringStream.Create(Text, TargetEncoding);
  Lines.LoadFromStream(ss);
  /// ss.Free;
end;

function TMyRichEdit.GetRichEditText(RichEdit: TRichEdit): WideString;
var
  GetTextLengthEx: TGetTextLengthEx;
  GetTextEx: TGetTextEx;
  Len: Integer;
begin
  GetTextLengthEx.flags := GTL_DEFAULT;
  GetTextLengthEx.codepage := 1200;
  Len := SendMessage(RichEdit.Handle, EM_GETTEXTLENGTHEX, wParam(@GetTextLengthEx), 0);
  if Len = E_INVALIDARG then
    raise Exception.Create('EM_GETTEXTLENGTHEX failed');
  SetLength(Result, Len);
  if Len = 0 then
    Exit;
  GetTextEx.cb := (Length(Result) + 1) * SizeOf(WideChar);
  GetTextEx.flags := GTL_DEFAULT;
  GetTextEx.codepage := 1200;
  GetTextEx.lpDefaultChar := nil;
  GetTextEx.lpUsedDefChar := nil;
  SendMessage(RichEdit.Handle, EM_GETTEXTEX, wParam(@GetTextEx), LPARAM(PWideChar(Result)));
end;

function TMyRichEdit.GetRichEditText(RichEdit: TRichEdit; AnsiCodePage: UINT): AnsiString;
var
  GetTextLengthEx: TGetTextLengthEx;
  GetTextEx: TGetTextEx;
  Len: Integer;
begin
  GetTextLengthEx.flags := GTL_DEFAULT;
  GetTextLengthEx.codepage := AnsiCodePage;
  Len := SendMessage(RichEdit.Handle, EM_GETTEXTLENGTHEX, wParam(@GetTextLengthEx), 0);
  if Len = E_INVALIDARG then
    raise Exception.Create('EM_GETTEXTLENGTHEX failed');
  SetLength(Result, Len);
  if Len = 0 then
    Exit;
  GetTextEx.cb := (Length(Result) + 1) * SizeOf(AnsiChar);
  GetTextEx.flags := GTL_DEFAULT;
  GetTextEx.codepage := AnsiCodePage;
  GetTextEx.lpDefaultChar := nil;
  GetTextEx.lpUsedDefChar := nil;
  SendMessage(RichEdit.Handle, EM_GETTEXTEX, wParam(@GetTextEx), LPARAM(PWideChar(Result)));
end;

// 取得文件编码
function DetectTextFileEncoding(const FileName: string): TEncoding;
var
  Buffer: array [0 .. 3] of Byte;
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    Stream.ReadBuffer(Buffer, SizeOf(Buffer));
    if (Buffer[0] = $FF) and (Buffer[1] = $FE) then
      Result := TEncoding.Unicode
      /// Little-Endian UTF-16
    else if (Buffer[0] = $FE) and (Buffer[1] = $FF) then
      Result := TEncoding.BigEndianUnicode
      /// Big-Endian UTF-16
    else if (Buffer[0] = $EF) and (Buffer[1] = $BB) and (Buffer[2] = $BF) then
      Result := TEncoding.UTF8
      /// UTF-8 带BOM 编码（UTF8）
    else if (Buffer[0] = $2B) and (Buffer[1] = $2F) and (Buffer[2] = $76) then
      Result := TEncoding.UTF7
    else
      Result := TEncoding.Default; // 默认使用系统默认编码
  finally
    Stream.Free;
  end;
end;

procedure TMyRichEdit.ShowLinesNumber();
const
  PFNS_PAREN = $000; // e.g. 1)
  PFNS_PARENS = $100; // e.g. (1)
  PFNS_PERIOD = $200; // e.g. 1.
  PFNS_PLAIN = $300;
  PFNS_NONUMBER = $400;

const
  PFN_NONE = $00000000; // 无
  PFN_BULLET = $00000001; // 黑色实心圆点
  PFN_ARABIC = $00000002; // 0,1,2
  PFN_LCLETTER = $00000003; // a,b,c
  PFN_UCLETTER = $00000004; // A,B,C
  PFN_LCROMAN = $00000005; // i,ii,iii
  PFN_UCROMAN = $00000006; // I,II,III

var
  pf: PARAFORMAT2;
begin
  FillChar(pf, SizeOf(PARAFORMAT2), #0);
  pf.cbSize := SizeOf(PARAFORMAT2);
  // PFM_NUMBERING: wNumbering 值有效
  // PFM_NUMBERINGSTYLE: wNumberingStyle值有效
  // PFM_NUMBERINGSTART: wNumberingStart值有效
  // PFM_STARTINDENT: dxStartIndent值有效
  pf.dwMask := PFM_NUMBERING or PFM_NUMBERINGSTYLE or PFM_NUMBERINGSTART or PFM_STARTINDENT; // or PFM_OFFSET;

  pf.wNumberingStyle := PFNS_PERIOD; // 设置行号的样式，可以为“)”，“.”，“()”
  pf.wNumberingStart := 1; // 设置行号起始值
  pf.wNumbering := PFN_ARABIC; // 设置行号的格式，可以为阿拉伯数字或者英文字母等格式
  pf.dxStartIndent := 90; // 设置行首缩进值

  SelectAll;
  SendMessage(Handle, EM_SETPARAFORMAT, 0, LPARAM(@pf));
  SelStart := 0;
  SelLength := 0;
  FShowLinesNumber := true;
end;

procedure TMyRichEdit.SetDefaultFormat();
begin
  Font.Charset := TFontCharset(DEFAULT_CHARSET);
  Font.Name := '新宋体';
  Font.Size := 14;
  SelStart := MaxInt;
  SelAttributes.Name := Font.Name;
  SelAttributes.Size := Font.Size;
  SelAttributes.Color := Font.Color;
  SelAttributes.Style := Font.Style;
  SelAttributes.Charset := Font.Charset;

  WantReturns := false;
  HideSelection := false;
  EnableURLs := true;
  ParentFont := false;
end;

procedure TMyRichEdit.SetHexadecimalMode();
var
  SourceEncoding: TEncoding;
  /// i: Integer;
begin
  SourceEncoding := Self.Lines.Encoding;
  // 将Memo控件中的文本内容转换为源编码格式的字节序列
  FSourceBytes := SourceEncoding.GetBytes(Text);
  Self.Clear;
  LogBuffer(FSourceBytes, Length(FSourceBytes));
  DataEngineManager.Remove2(FTAG);
end;

procedure TMyRichEdit.SetHexadecimalMode(HexMode: Boolean);
begin
  FTAG := 'SetHexadecimalMode';
  if (not Self.FHexadecimalMode) and (HexMode) then
  begin
    FHexadecimalMode := true;
    if not DataEngineManager.Exist2(FTAG, nil) then
      DataEngineManager.DoAction(FTAG, SetHexadecimalMode);
  end;

  if (not HexMode) then
  begin
    LoadFrom('');
    FHexadecimalMode := false;
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
///
/// /////////////////////////////////////////////////////////////////////////////
///
constructor TMyPageEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRichEditList := TList.Create;
end;

function TMyPageEdit.GetPageIndex(PageName: String): Integer;
var
  TabSheet: TTabSheet;
begin
  Result := -1;
  TabSheet := GetPageByName(PageName);
  if TabSheet <> nil then
  begin
    Result := TabSheet.PageIndex;
  end;
end;

function TMyPageEdit.GetPageByName(PageName: String): TTabSheet;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.PageCount - 1 do
  begin
    if Self.Pages[i].Caption = PageName then
    begin
      Result := Self.Pages[i];
      break;
    end;
  end;
end;

function TMyPageEdit.GetPageByIndex(PageIndex: Integer): TTabSheet;
begin
  Result := nil;
  if (PageIndex >= 0) and (PageIndex < Self.PageCount) and (Self.PageCount > 0) then
  begin
    Result := Self.Pages[PageIndex];
  end;
end;

procedure TMyPageEdit.SetPageName(PageName: String; PageIndex: Integer);
var
  TabSheet: TTabSheet;
begin
  if Trim(PageName) = '' then
    Exit;

  TabSheet := GetPageByIndex(PageIndex);
  if TabSheet <> nil then
  begin
    TabSheet.Caption := PageName;
  end;
end;

procedure TMyPageEdit.CreatePage(PageName: String; PageType: Integer);
var
  NewTab: TTabSheet;
  NewRichEdit: TMyRichEdit;
  MyMemo: TMyMemo;
  WebBrowser: TWebBrowser;
  // f: TFont;
begin
  if FRichEditList = nil then
    FRichEditList := TList.Create;
  if PageType = 0 then
  begin
    if GetPageByName(PageName) = nil then
    begin
      NewTab := TTabSheet.Create(Self);
      NewTab.PageControl := Self;
      NewTab.Caption := PageName;

      NewRichEdit := TMyRichEdit.Create(NewTab);
      NewRichEdit.Parent := NewTab;
      NewRichEdit.Align := alClient;
      NewRichEdit.BorderStyle := bsNone;
      NewRichEdit.ScrollBars := ssBoth;
      NewRichEdit.DoubleBuffered := true;
      NewRichEdit.FDoubleBuffered := true;
      NewRichEdit.FDoubleBufferedSaved := true;
      NewRichEdit.ParentDoubleBuffered := true;
      NewRichEdit.SetDefaultFormat();
      FRichEditList.Add(NewRichEdit);

      { NewRichEdit.LineNumbersPanel := TMyPanel.Create(NewTab);
        NewRichEdit.LineNumbersPanel.Parent := NewTab;
        NewRichEdit.LineNumbersPanel.Font := NewRichEdit.Font;
        NewRichEdit.LineNumbersPanel.Align := alLeft;
        NewRichEdit.LineNumbersPanel.BevelOuter := bvNone;
        NewRichEdit.LineNumbersPanel.Caption := '';
        NewRichEdit.LineNumbersPanel.Height := NewRichEdit.Height;
        NewRichEdit.LineNumbersPanel.Width := 30;
        NewRichEdit.LineNumbersPanel.DoubleBuffered := true;
        NewRichEdit.LineNumbersPanel.SetParentDoubleBuffered(true);
        NewRichEdit.LineNumbersPanel.y:= NewRichEdit.Top; }
    end;
  end

  else if PageType = 1 then
  begin
    if GetPageByName(PageName) = nil then
    begin
      NewTab := TTabSheet.Create(Self);
      NewTab.PageControl := Self;
      NewTab.Caption := PageName;

      WebBrowser := TWebBrowser.Create(NewTab);
      WebBrowser.SetParentComponent(NewTab);
      WebBrowser.Align := alClient;
      WebBrowser.silent := true; // 屏蔽脚本错误
      FRichEditList.Add(WebBrowser);
    end;
  end

  else if PageType = 2 then
  begin
    if GetPageByName(PageName) = nil then
    begin
      NewTab := TTabSheet.Create(Self);
      NewTab.PageControl := Self;
      NewTab.Caption := PageName;

      MyMemo := TMyMemo.Create(NewTab);
      MyMemo.Parent := NewTab;
      MyMemo.Align := alClient;
      MyMemo.BorderStyle := bsNone;
      MyMemo.ScrollBars := ssBoth;
      MyMemo.DoubleBuffered := true;
      MyMemo.FDoubleBuffered := true;
      MyMemo.FDoubleBufferedSaved := true;
      MyMemo.ParentDoubleBuffered := true;
      MyMemo.SetDefaultFormat();
      MyMemo.FStyle := 1;
      /// 文本风格样式，TMemo只有黑白风格
      FRichEditList.Add(MyMemo);
    end;
  end;

end;

procedure TMyPageEdit.DeletePage(PageName: String);
var
  NewTab: TTabSheet;
begin
  NewTab := GetPageByName(PageName);
  if NewTab <> nil then
  begin
    DeletePageComponent(NewTab.PageIndex);
    NewTab.Free;
    NewTab := nil;
  end;
end;

procedure TMyPageEdit.DeletePageComponent(Index: Integer);
var
  NewRichEdit: TRichEdit;
begin
  if FRichEditList = nil then
    Exit;
  if Index >= FRichEditList.Count then
    Exit;
  if Index < 0 then
    Exit;

  NewRichEdit := FRichEditList.Items[Index];
  FRichEditList.Delete(Index);
  NewRichEdit.Free;

end;

function TMyPageEdit.GetEdit(Index: Integer): TMyRichEdit;
var
  tmpComponent: TComponent;
begin
  Result := nil;
  if FRichEditList = nil then
    Exit;
  if Index >= FRichEditList.Count then
    Exit;
  if Index < 0 then
    Exit;
  tmpComponent := FRichEditList.Items[Index];
  if tmpComponent is TMyRichEdit then
    Result := TMyRichEdit(tmpComponent);
end;

function TMyPageEdit.GetEdit(PageName: String): TMyRichEdit;
var
  NewTab: TTabSheet;
begin
  Result := nil;
  NewTab := GetPageByName(PageName);
  if NewTab <> nil then
  begin
    Result := GetEdit(NewTab.PageIndex);
  end;
end;

function TMyPageEdit.GetMemo(Index: Integer): TMyMemo;
var
  tmpComponent: TComponent;
begin
  Result := nil;
  if FRichEditList = nil then
    Exit;
  if Index >= FRichEditList.Count then
    Exit;
  if Index < 0 then
    Exit;
  tmpComponent := FRichEditList.Items[Index];
  if tmpComponent is TMyMemo then
    Result := TMyMemo(tmpComponent);
end;

function TMyPageEdit.GetMemo(PageName: String): TMyMemo;
var
  NewTab: TTabSheet;
begin
  Result := nil;
  NewTab := GetPageByName(PageName);
  if NewTab <> nil then
  begin
    Result := GetMemo(NewTab.PageIndex);
  end;
end;

function TMyPageEdit.GetComponent(Index: Integer): TComponent;
begin
  Result := nil;
  if FRichEditList = nil then
    Exit;
  if Index >= FRichEditList.Count then
    Exit;
  if Index < 0 then
    Exit;
  Result := FRichEditList.Items[Index];
end;

function TMyPageEdit.GetComponent(PageName: String): TComponent;
var
  TabSheet: TTabSheet;
begin
  Result := nil;
  TabSheet := GetPageByName(PageName);
  if TabSheet <> nil then
  begin
    Result := GetComponent(TabSheet.PageIndex);
  end;
end;
{ procedure TMyPageEdit.Log(Msg: String; Index: Integer);
  var
  NewRichEdit: TTextControl;
  begin
  NewRichEdit := GetEdit(Index);
  if NewRichEdit <> nil then
  begin
  NewRichEdit.Log(Msg);
  end;
  end; }

function TMyPageEdit.GetPageName(Index: Integer): String;
begin
  Result := 'Null';
  if ((Index < 0) or (Index >= Self.PageCount)) then
    Exit;

  Result := Self.Pages[Index].Caption;
end;

function TMyPageEdit.GetActivePageName(): String;
begin
  Result := Self.ActivePage.Caption;
end;

{ procedure TMyPageEdit.Clear(Index: Integer);
  var
  NewRichEdit: TTextControl;
  begin
  NewRichEdit := GetEdit(Index);
  if NewRichEdit <> nil then
  begin
  NewRichEdit.Clear;
  end;
  end; }

function TMyPageEdit.GetWebBrowser(Index: Integer): TWebBrowser;
var
  tmpComponent: TComponent;
begin
  Result := nil;
  if FRichEditList = nil then
    Exit;
  if Index >= FRichEditList.Count then
    Exit;
  if Index < 0 then
    Exit;
  tmpComponent := FRichEditList.Items[Index];
  if tmpComponent is TWebBrowser then
    Result := TWebBrowser(tmpComponent);
end;

function TMyPageEdit.GetWebBrowser(PageName: String): TWebBrowser;
var
  NewTab: TTabSheet;
begin
  Result := nil;
  NewTab := GetPageByName(PageName);
  if NewTab <> nil then
  begin
    Result := GetWebBrowser(NewTab.PageIndex);
  end;
end;

function TMyPageEdit.LoadFileFrom(PathFileName: String; PageName: String): TMyRichEdit;
begin
  Result := GetEdit(PageName);
  if Result <> nil then
  begin
    Result.LoadFrom(PathFileName);
  end;
end;

procedure TMyPageEdit.FreeAll();
var
  i: Integer;
begin
  for i := 0 to Self.FRichEditList.Count - 1 do
  begin
  end;
  FRichEditList.Clear;
end;

procedure TMyPageEdit.Log(Msg: String; Index: Integer);
var
  Component: TComponent;
begin
  Component := GetComponent(Index);
  if Component is TMyMemo then
  begin
    TMyMemo(Component).Log(Msg);
  end;
end;

end.
