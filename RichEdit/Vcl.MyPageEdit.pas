unit Vcl.MyPageEdit;

interface

uses
  System.SysUtils, System.StrUtils, Winapi.Windows, Winapi.Messages, Winapi.RichEdit, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, Vcl.ClipBrd,
  Vcl.ToolWin, Vcl.ActnList, System.Actions, System.ImageList, Vcl.ImgList, Vcl.StdActns, Vcl.ExtActns,
  Vcl.Tabs, VCLTee.TeCanvas, Vcl.Grids, Vcl.WinXCtrls, Vcl.TabNotBk, Vcl.Themes, SHDocVw;

type
  TEventCallBackFuntion = Procedure(Obj: TObject) of object;

  TMyPanel = class(TPanel)
  private
    FDragOrigin: TPoint;
    FSizeRect: TRect;
    LineHeight: Integer;
    LinesCount: Integer;
    x, y: Integer;
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; x, y: Integer); override;
    procedure MouseMove(Shift: TShiftState; x, y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; x, y: Integer); override;
  end;

  TMyRichEdit = class(TRichEdit)
  private
    FTAG: String;
    FSourceBytes: TBytes;
    /// LineNumbersPanel: TMyPanel;
  protected
  public
    FStyle: Integer;
    FEncoding: TEncoding;
    FFileName: String;
    FHexadecimalMode: Boolean;
    FShowLinesNumber: Boolean;
    EventCallBackFuntion: TEventCallBackFuntion;

    function GetRichEditText(RichEdit: TRichEdit): WideString; overload;
    function GetRichEditText(RichEdit: TRichEdit; AnsiCodePage: UINT): AnsiString; overload;

    function GetLastLine(): String;
    function GetLine(Line: Integer): String;

    procedure Clear();
    procedure Log(const MSG: String);
    procedure LogLine(const MSG: String; Line: Integer);
    procedure LogEndLine(const MSG: String);
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

    procedure Log(MSG: String; Index: Integer);
    procedure Clear(Index: Integer);
    procedure FreeAll();

    function GetEdit(Index: Integer): TMyRichEdit; overload;
    function GetEdit(PageName: String): TMyRichEdit; overload;
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

procedure TMyPanel.Paint;
var
  i: Integer;
begin
  /// inherited;
  // Draw a sizing grip on the Canvas property
  // There's a size-grip glyph in the Marlett font,
  // so try the Canvas.TextOut method in combination
  // with the Canvas.Font property.
  // 设置Panel的宽度与RichEdit的行号列相匹配
  Self.LinesCount := Self.LinesCount + 10;
  /// Width := Canvas.TextWidth('9999') + 5;
  // 逐行绘制行号
  for i := 1 to Self.LinesCount do
    Caption := Caption + IntToStr(i) + #13;

  LineHeight := Canvas.TextHeight('123456789');
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(ClientRect);
  Canvas.TextOut(2, -y div LineHeight * LineHeight, Caption);
end;

procedure TMyPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; x, y: Integer);
begin

end;

procedure TMyPanel.MouseMove(Shift: TShiftState; x, y: Integer);
begin

end;

procedure TMyPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; x, y: Integer);
begin

end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
procedure TMyRichEdit.Clear();
begin
  Self.Lines.Clear;
end;

procedure TMyRichEdit.Log(const MSG: String);
begin
  try
    Self.Lines.Append(MSG);
  Except
    /// ShowMessage('This error message is due to ??');
    if Assigned(EventCallBackFuntion) then
      EventCallBackFuntion(Self);
  end;
end;

procedure TMyRichEdit.LogLine(const MSG: String; Line: Integer);
begin
  if (Self.Lines.Count > 0) and (Line >= 0) and (Line < Self.Lines.Count) then
    Lines.Strings[Line] := MSG
  else
    Log(MSG);
end;

procedure TMyRichEdit.LogEndLine(const MSG: String);
begin
  if Lines.Count > 0 then
    Lines.Strings[Lines.Count - 1] := Lines.Strings[Lines.Count - 1] + MSG
  else
    Log(MSG);
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
  if Lines.Count > 0 then
    Result := Lines.Strings[Lines.Count - 1]
  else
    Result := '';
end;

function TMyRichEdit.GetLine(Line: Integer): String;
begin
  Result := '';
  if (Line < 0) or (Line >= Lines.Count) then
    Result := ''
  else
    Result := Lines.Strings[Line];
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
  end;

  if PageType = 1 then
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

procedure TMyPageEdit.Log(MSG: String; Index: Integer);
var
  NewRichEdit: TMyRichEdit;
begin
  NewRichEdit := GetEdit(Index);
  if NewRichEdit <> nil then
  begin
    NewRichEdit.Lines.Append(MSG);
  end;
end;

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

procedure TMyPageEdit.Clear(Index: Integer);
var
  NewRichEdit: TMyRichEdit;
begin
  NewRichEdit := GetEdit(Index);
  if NewRichEdit <> nil then
  begin
    NewRichEdit.Clear;
  end;
end;

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
    Result.Modified := false;
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

end.
