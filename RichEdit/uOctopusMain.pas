unit uOctopusMain;

interface

uses
  System.SysUtils, System.StrUtils, Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, Vcl.ClipBrd,
  Vcl.ToolWin, Vcl.ActnList, System.Actions, System.ImageList, Vcl.ImgList, Vcl.StdActns, Vcl.ExtActns,
  Vcl.Tabs, VCLTee.TeCanvas, Vcl.Grids, Vcl.WinXCtrls, Vcl.TabNotBk, Vcl.Themes,

  IniFiles,
  OcComPortObj,
  uGlobalFunction;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FilePrintItem: TMenuItem;
    FileExitItem: TMenuItem;
    EditUndoItem: TMenuItem;
    EditCutItem: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
    RichEditMenu: TMenuItem;
    RichEditTransparentItem: TMenuItem;
    RichEditWordWrapItem: TMenuItem;
    RichEditBoldItem: TMenuItem;
    RichEditItalicItem: TMenuItem;
    RichEditUnderlineItem: TMenuItem;
    RichEditStrikeoutItem: TMenuItem;
    RichEditAlignLeftItem: TMenuItem;
    RichEditAlignCenterItem: TMenuItem;
    RichEditAlignRightItem: TMenuItem;
    RichEditBulletsItem: TMenuItem;
    RichEditSuperscriptItem: TMenuItem;
    RichEditSubscriptItem: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    HelpAboutItem: TMenuItem;
    miEditFont: TMenuItem;

    FontDialog: TFontDialog;
    StandardUartToolBar: TToolBar;
    StandardToolBar: TToolBar;

    OpenButton: TToolButton;
    SaveButton: TToolButton;
    PrintButton: TToolButton;
    ToolButton5: TToolButton;
    UndoButton: TToolButton;
    CutButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    ToolButton7: TToolButton;
    FontName: TComboBox;
    FontSize: TEdit;
    ToolButton8: TToolButton;
    UpDown1: TUpDown;
    BoldButton: TToolButton;
    ItalicButton: TToolButton;
    UnderlineButton: TToolButton;
    ToolButton1: TToolButton;
    LeftAlign: TToolButton;
    CenterAlign: TToolButton;
    RightAlign: TToolButton;
    BulletsButton: TToolButton;

    FileNewButton: TToolButton;
    StrikeoutButton: TToolButton;
    ToolButton2: TToolButton;
    FGColorBox: TColorBox;
    BGColorBox: TColorBox;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    SupersciptButton: TToolButton;
    SubscriptButton: TToolButton;
    ToolButton6: TToolButton;

    EditCutCmd: TEditCut;
    EditCopyCmd: TEditCopy;
    EditPasteCmd: TEditPaste;
    EditUndoCmd: TEditUndo;
    EditFontCmd: TFontEdit;
    FileSaveAsCmd: TFileSaveAs;
    FormatRichEditBoldCmd: TRichEditBold;
    FormatRichEditItalicCmd: TRichEditItalic;
    FormatRichEditUnderlineCmd: TRichEditUnderline;
    FormatRichEditStrikeOutCmd: TRichEditStrikeOut;
    FormatRichEditBulletsCmd: TRichEditBullets;
    FormatRichEditAlignLeftCmd: TRichEditAlignLeft;
    FormatRichEditAlignRightCmd: TRichEditAlignRight;
    FormatRichEditAlignCenterCmd: TRichEditAlignCenter;
    SuperscriptCmd: TAction;
    SubscriptCmd: TAction;
    ToolbarImages: TImageList;
    ActionList: TActionList;
    FileNewCmd: TAction;
    FileOpenCmd: TFileOpen;
    FileSaveCmd: TAction;
    FilePrintCmd: TPrintDlg;
    FileExitCmd: TFileExit;

    ComboBoxEx1: TComboBoxEx;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Setting1: TMenuItem;
    ools1: TMenuItem;
    Panel1: TPanel;
    SV_R: TSplitView;
    Panel2: TPanel;
    Panel25: TPanel;
    Panel7: TPanel;
    Memo2: TMemo;
    Panel8: TPanel;
    Button7: TButton;
    Button8: TButton;
    Button25: TButton;
    Panel13: TPanel;
    Memo3: TMemo;
    Button9: TButton;
    Button11: TButton;
    Panel4: TPanel;
    StringGrid1: TStringGrid;
    Panel14: TPanel;
    Button1: TButton;
    Button3: TButton;
    Panel5: TPanel;
    Memo5: TMemo;
    Panel16: TPanel;
    Button16: TButton;
    Button27: TButton;
    Button28: TButton;
    Panel18: TPanel;
    Label18: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    ComboBox12: TComboBox;
    ComboBox9: TComboBox;
    ComboBox10: TComboBox;
    ComboBox11: TComboBox;
    Splitter1: TSplitter;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    Skins1: TMenuItem;
    View1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    RichEditor: TRichEdit;
    TabSheet2: TTabSheet;
    StatusPanel: TPanel;
    PageControl2: TPageControl;
    TabSheet_SendingData: TTabSheet;
    TabSheet_BatchData: TTabSheet;
    TabSheet_ProtocolData: TTabSheet;
    FormatToolBar1: TMenuItem;
    Uart1: TMenuItem;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    Button2: TButton;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SelectionChange(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure FileNew(Sender: TObject);
    procedure FileOpenAccept(Sender: TObject);
    procedure FileOpenBeforeExecute(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrintAccept(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure SelectFont(Sender: TObject);
    procedure SelectFontBeforeExecute(Sender: TObject);

    procedure FontSizeChange(Sender: TObject);
    procedure FontNameChange(Sender: TObject);

    procedure RichEditChange(Sender: TObject);
    procedure RichEditTransparentItemClick(Sender: TObject);
    procedure RichEditorLinkClick(Sender: TCustomRichEdit; const URL: string; Button: TMouseButton);
    procedure RichEditorClick(Sender: TObject);
    procedure FGColorBoxChange(Sender: TObject);
    procedure BGColorBoxChange(Sender: TObject);
    procedure SuperscriptCmdExecute(Sender: TObject);
    procedure SuperscriptCmdUpdate(Sender: TObject);
    procedure SubscriptCmdExecute(Sender: TObject);
    procedure SubscriptCmdUpdate(Sender: TObject);
    procedure RichEditWordWrapItemClick(Sender: TObject);
    procedure Setting1Click(Sender: TObject);

    procedure InitSkinsMenu(ParentMenu: TMenuItem; OnClicEvent: TOnClicEvent);
    procedure SkinsMenuOnClick(Sender: TObject);
    procedure Skins1Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid1FixedCellClick(Sender: TObject; ACol, ARow: Integer);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure Uart1Click(Sender: TObject);
    procedure FormatToolBar1Click(Sender: TObject);
  private
    OctopusCfgDir: String;
    OctopusCfgDir_LogFileName: String;

    SkinMenuItem: TMenuItem;
    FCheck, FNoCheck: TBitmap;

    FFileName: string;
    FUpdating: Boolean;
    FDragOfs: Integer;
    FDragging: Boolean;
    function CurrText: TTextAttributes;
    procedure GetFontNames;
    procedure SetFileName(const FileName: String);
    procedure CheckFileSave;
    procedure UpdateCursorPos;

    procedure PerformFileOpen(const AFileName: string);
    procedure SetModified(Value: Boolean);

    function GetStringGridValidStr(sStr: String): String;
    procedure InitStringGrid();
    procedure StringGridSelectCell(ACol, ARow: Integer);
    procedure StringGridSave();
    procedure StringGridLoad();

    procedure InitUartsParameters();

    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    Procedure SystemMessage_WMMenuSelect(var Msg: TWMMenuSelect); message WM_SysCommand;
  end;

const
  CHECKCOL: Integer = 3;
  DATACOL: Integer = 2;

var
  MainForm: TMainForm;

implementation

uses uOctopusAbout, RichEdit, Winapi.ShellAPI, System.UITypes, System.IOUtils,
  uSetting;

resourcestring
  sSaveChanges = 'Save changes to %s?';
  sOverWrite = 'OK to overwrite %s';
  sUntitled = 'Untitled';
  sModified = 'Modified';
  sColRowInfo = 'Line: %3d   Col: %3d';
  sScrollPos = 'Scroll Pos: (%d, %d)';
  sOpenLink = 'Open link: %s ?';

const
  RulerAdj = 4 / 3;
  GutterWid = 6;

{$R *.dfm}
  { Event Handlers }

procedure TMainForm.SystemMessage_WMMenuSelect(var Msg: TWMMenuSelect);
begin
  inherited;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
  FileOpenCmd.Dialog.InitialDir := ExtractFilePath(ParamStr(0));
  FileSaveAsCmd.Dialog.InitialDir := FileOpenCmd.Dialog.InitialDir;
  SetFileName(sUntitled);
  GetFontNames;
  SelectionChange(Self);

  CurrText.Name := string(DefFontData.Name);
  CurrText.Size := -MulDiv(DefFontData.Height, 72, Screen.PixelsPerInch);
  RichEditTransparentItem.Checked := RichEditor.Transparent;
  RichEditWordWrapItem.Checked := RichEditor.ScrollBars = ssVertical;
  RichEditor.ShowURLHint := True; // TODO remove this when we set it in the DFM

  InitSkinsMenu(Skins1, SkinsMenuOnClick);
  InitStringGrid();
  InitUartsParameters();

  FormatToolBar1.Checked := StandardToolBar.Visible;
  Uart1.Checked := StandardUartToolBar.Visible;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  UpdateCursorPos;
  DragAcceptFiles(Handle, True);
  RichEditChange(nil);
  RichEditor.SetFocus;
  { Check if we should load a file from the command line, assuming the default file is not available }
  if TFile.Exists('overview.rtf') then
    PerformFileOpen('overview.rtf')
  else if TFile.Exists('..\..\overview.rtf') then
    PerformFileOpen('..\..\overview.rtf')
  else if (ParamCount > 0) and TFile.Exists(ParamStr(1)) then
    PerformFileOpen(ParamStr(1));
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  SelectionChange(Sender);
  RichEditor.Invalidate;
end;

procedure TMainForm.FormatToolBar1Click(Sender: TObject);
begin
  StandardToolBar.Visible := not StandardToolBar.Visible;
  FormatToolBar1.Checked := StandardToolBar.Visible;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
    CheckFileSave;
  except
    CanClose := False;
  end;
end;

procedure TMainForm.Uart1Click(Sender: TObject);
begin
  StandardUartToolBar.Visible := not StandardUartToolBar.Visible;
  Uart1.Checked := StandardUartToolBar.Visible;
end;

/// ///////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////
procedure TMainForm.SelectionChange(Sender: TObject);
begin
  try
    FUpdating := True;
    FontSize.Text := IntToStr(RichEditor.SelAttributes.Size);
    FontName.Text := RichEditor.SelAttributes.Name;
    FGColorBox.Selected := RichEditor.SelAttributes.Color;
    BGColorBox.Selected := RichEditor.SelAttributes.BackColor;
    UpdateCursorPos();
  finally
    FUpdating := False;
  end;
end;

procedure TMainForm.FGColorBoxChange(Sender: TObject);
var
  Color: TColor;
begin
  Color := FGColorBox.Selected;
  RichEditor.SelAttributes.Color := Color;
end;

procedure TMainForm.BGColorBoxChange(Sender: TObject);
begin
  RichEditor.SelAttributes.BackColor := BGColorBox.Selected;
end;

function TMainForm.CurrText: TTextAttributes;
begin
  if RichEditor.SelLength > 0 then
    Result := RichEditor.SelAttributes
  else
    Result := RichEditor.DefAttributes;
end;

procedure TMainForm.RichEditorClick(Sender: TObject);
begin
  UpdateCursorPos;
end;

procedure TMainForm.RichEditorLinkClick(Sender: TCustomRichEdit; const URL: string; Button: TMouseButton);
begin
  if (Button = mbLeft) and (MessageDlg(Format(sOpenLink, [URL]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    ShellExecute(Handle, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL)
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric; FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure TMainForm.GetFontNames;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := True;
end;

procedure TMainForm.SetFileName(const FileName: String);
begin
  FFileName := FileName;
  Caption := Format('%s - %s', [ExtractFileName(FileName), Application.Title]);
end;

procedure TMainForm.CheckFileSave;
var
  SaveResp: Integer;
begin
  if not RichEditor.Modified then
    Exit;
  SaveResp := MessageDlg(Format(sSaveChanges, [FFileName]), mtConfirmation, mbYesNoCancel, 0);
  case SaveResp of
    idYes:
      FileSave(Self);
    idNo: { Nothing }
      ;
    idCancel:
      Abort;
  end;
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  if Length(Application.Hint) > 0 then
  begin
    // StatusBar.SimplePanel := True;
    // StatusBar.SimpleText := Application.Hint;
  end
  else; // StatusBar.SimplePanel := False;
end;

procedure TMainForm.SubscriptCmdExecute(Sender: TObject);
begin
  RichEditor.SelAttributes.Subscript := sstSubscript;
end;

procedure TMainForm.SubscriptCmdUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked := RichEditor.SelAttributes.Subscript = sstSubscript;
end;

procedure TMainForm.SuperscriptCmdExecute(Sender: TObject);
begin
  RichEditor.SelAttributes.Subscript := sstSuperscript;
end;

procedure TMainForm.SuperscriptCmdUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked := RichEditor.SelAttributes.Subscript = sstSuperscript;
end;

procedure TMainForm.FileNew(Sender: TObject);
begin
  SetFileName(sUntitled);
  RichEditor.Lines.Clear;
  RichEditor.Modified := False;
  SetModified(False);
end;

procedure TMainForm.PerformFileOpen(const AFileName: string);
begin
  RichEditor.Lines.LoadFromFile(AFileName);
  SetFileName(AFileName);
  RichEditor.SetFocus;
  RichEditor.Modified := False;
  SetModified(False);
end;

procedure TMainForm.FileOpenAccept(Sender: TObject);
begin
  PerformFileOpen(FileOpenCmd.Dialog.FileName);
  RichEditor.ReadOnly := ofReadOnly in FileOpenCmd.Dialog.Options;
end;

procedure TMainForm.FileOpenBeforeExecute(Sender: TObject);
begin
  CheckFileSave;
end;

procedure TMainForm.FileSave(Sender: TObject);
begin
  if FFileName = sUntitled then
    FileSaveAs(Sender)
  else
  begin
    RichEditor.Lines.SaveToFile(FFileName);
    RichEditor.Modified := False;
    SetModified(False);
  end;
end;

procedure TMainForm.FileSaveAs(Sender: TObject);
begin
  if FileExists(FileSaveAsCmd.Dialog.FileName) then
    if MessageDlg(Format(sOverWrite, [FileSaveAsCmd.Dialog.FileName]), mtConfirmation, mbYesNoCancel, 0) <> idYes then
      Exit;
  RichEditor.Lines.SaveToFile(FileSaveAsCmd.Dialog.FileName);
  SetFileName(FileSaveAsCmd.Dialog.FileName);
  RichEditor.Modified := False;
  SetModified(False);
end;

procedure TMainForm.FilePrintAccept(Sender: TObject);
begin
  RichEditor.Print(FFileName);
end;

procedure TMainForm.HelpAbout(Sender: TObject);
begin
  with TAboutBox.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainForm.SelectFont(Sender: TObject);
begin
  CurrText.Assign(FontDialog.Font);
  SelectionChange(Self);
  RichEditor.SetFocus;
end;

procedure TMainForm.SelectFontBeforeExecute(Sender: TObject);
begin
  FontDialog.Font.Assign(RichEditor.SelAttributes);
end;

procedure TMainForm.FontSizeChange(Sender: TObject);
begin
  if FUpdating then
    Exit;
  CurrText.Size := StrToInt(FontSize.Text);
end;

procedure TMainForm.FontNameChange(Sender: TObject);
begin
  if FUpdating then
    Exit;
  CurrText.Name := FontName.Items[FontName.ItemIndex];
end;

procedure TMainForm.UpdateCursorPos;
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(RichEditor.Handle, EM_EXLINEFROMCHAR, 0, RichEditor.SelStart);
  CharPos.X := (RichEditor.SelStart - SendMessage(RichEditor.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  // StatusBar.Panels[0].Text := Format(sColRowInfo, [CharPos.Y, CharPos.X]);
  // StatusBar.Panels[1].Text := Format(sScrollPos, [RichEditor.ScrollPosition.X, RichEditor.ScrollPosition.Y]);
end;

procedure TMainForm.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array [0 .. MAX_PATH] of Char;
begin
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      CheckFileSave;
      PerformFileOpen(CFileName);
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TMainForm.RichEditChange(Sender: TObject);
begin
  SetModified(RichEditor.Modified);
  UpdateCursorPos;
end;

procedure TMainForm.RichEditTransparentItemClick(Sender: TObject);
begin
  RichEditTransparentItem.Checked := not RichEditTransparentItem.Checked;
  RichEditor.Transparent := RichEditTransparentItem.Checked;
end;

procedure TMainForm.RichEditWordWrapItemClick(Sender: TObject);
begin
  RichEditWordWrapItem.Checked := not RichEditWordWrapItem.Checked;
  if RichEditWordWrapItem.Checked then
    RichEditor.ScrollBars := ssVertical
  else
    RichEditor.ScrollBars := ssBoth;
end;

procedure TMainForm.SetModified(Value: Boolean);
begin
  if Value then
    // StatusBar.Panels[2].Text := sModified
  else; // StatusBar.Panels[2].Text := '';
end;

procedure TMainForm.Setting1Click(Sender: TObject);
begin
  SettingPagesDlg.Show();
end;

/// ///////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////

procedure TMainForm.InitSkinsMenu(ParentMenu: TMenuItem; OnClicEvent: TOnClicEvent);
var
  // StyleName: string;
  i: Integer;
  MenuItem: TMenuItem;
  // Menu: HMENU;
begin
  ParentMenu.Clear;
  for i := Low(TStyleManager.StyleNames) to High(TStyleManager.StyleNames) do
  begin
    MenuItem := TMenuItem.Create(nil);
    MenuItem.Caption := TStyleManager.StyleNames[i]; // StyleName;
    MenuItem.Tag := i;
    ParentMenu.Add(MenuItem);
    MenuItem.OnClick := OnClicEvent;
  end;
end;

procedure TMainForm.SkinsMenuOnClick(Sender: TObject);
var
  str: String;
begin;
  // TStyleManager.SetStyle(TMenuItem(Sender).Caption);
  str := GetStyle(TMenuItem(Sender).Tag);
  if str <> '' then
  begin
    // for i := Low(TStyleManager.StyleNames) to High(TStyleManager.StyleNames) do
    SkinMenuItem := TMenuItem(Sender);
    AdjustSetStyle(str);
    TMenuItem(Sender).Checked := True;
  end;
end;

procedure TMainForm.Skins1Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to Skins1.Count - 1 do
  begin
    if Skins1.Items[i] = Self.SkinMenuItem then
      Skins1.Items[i].Checked := True
    else
      Skins1.Items[i].Checked := False;
  end;
  if Self.SkinMenuItem = nil then
  begin
    Skins1.Items[0].Checked := True;
    Self.SkinMenuItem := Skins1.Items[0];
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TMainForm.GetStringGridValidStr(sStr: String): String;
var
  strstr: String;
  Pos: Integer;
begin
  Result := '';
  // str := Trim(sStr);
  Pos := PosEx('#', sStr);
  if (Pos > 0) then
    strstr := Copy(sStr, 1, Pos - 1)
  else
    strstr := sStr;
  Pos := PosEx('//', strstr);
  if (Pos > 0) then
    Result := Trim(Copy(strstr, 1, Pos - 1))
  else
    Result := Trim(strstr)
end;

procedure TMainForm.InitStringGrid();
var
  bmp: TBitmap;
  i: Integer;
  // GridRect: TGridRect;
begin
  try
    FCheck := TBitmap.Create;
    FNoCheck := TBitmap.Create;
    bmp := TBitmap.Create;
    bmp.Handle := LoadBitmap(0, PChar(OBM_CHECKBOXES));
    bmp.PixelFormat := pf32bit;
    bmp.HandleType := bmDIB;
    bmp.Transparent := True;
    bmp.TransparentColor := clWhite;
    // Bmp.Canvas.Brush.Color := clWhite;
    // Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));

    FNoCheck.PixelFormat := pf32bit;
    FNoCheck.HandleType := bmDIB;
    FNoCheck.Transparent := True;
    FNoCheck.TransparentColor := clWhite;
    with FNoCheck do
    begin
      Width := bmp.Width div 4;
      Height := bmp.Height div 3;
      Canvas.CopyRect(Canvas.cliprect, bmp.Canvas, Canvas.cliprect);
    end;
    with FCheck do
    begin
      Width := bmp.Width div 4;
      Height := bmp.Height div 3;
      Canvas.CopyRect(Canvas.cliprect, bmp.Canvas, Rect(Width, 0, 2 * Width, Height));
    end;
  finally
    DeleteObject(bmp.Handle);
    bmp.Free;
  end;

  StringGrid1.RowCount := 520;
  StringGrid1.DefaultRowHeight := 26;
  StringGrid1.ColCount := 7;
  StringGrid1.ColWidths[0] := 50;
  StringGrid1.ColWidths[1] := 50;
  StringGrid1.ColWidths[2] := 300;
  StringGrid1.ColWidths[3] := 32;
  StringGrid1.ColWidths[4] := 40;
  StringGrid1.ColWidths[5] := 40;
  StringGrid1.FixedCols := 2;
  StringGrid1.FixedRows := 1;

  StringGrid1.Cells[0, 0] := 'String';
  StringGrid1.Cells[1, 0] := 'Byte';
  StringGrid1.Cells[2, 0] := 'Content For Sending';

  StringGrid1.Cells[4, 0] := 'Loop';
  StringGrid1.Cells[5, 0] := 'Interval';
  StringGrid1.Cells[6, 0] := 'Comments';
  StringGrid1.Align := alClient;
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    StringGrid1.Cells[0, i] := Format('%.04d ', [i]); // '0' + inttostr(i)
    StringGrid1.Cells[1, i] := Format('%.04x ', [i]);

    StringGrid1.Cells[CHECKCOL, i] := '0';
    StringGrid1.Cells[4, i] := '2';
    StringGrid1.Cells[5, i] := '1000';
  end;

end;

procedure TMainForm.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  try
    if (ACol = CHECKCOL) and (ARow > 0) then
    begin
      // StringGrid1.BeginUpdate;
      // if not(gdFixed in State) then
      with TStringGrid(Sender).Canvas do
      begin
        Brush.Color := clWindow;
        fillRect(Rect);
        if StringGrid1.Cells[ACol, ARow] = '1' then
          Draw((Rect.Right + Rect.Left - FCheck.Width) div 2 - 2, (Rect.Bottom + Rect.Top - FCheck.Height) div 2, FCheck)
        else
          Draw((Rect.Right + Rect.Left - FCheck.Width) div 2 - 2, (Rect.Bottom + Rect.Top - FCheck.Height) div 2, FNoCheck);
      end;
      // StringGrid1.EndUpdate;
    end;
  except
  end;
end;

procedure TMainForm.StringGrid1FixedCellClick(Sender: TObject; ACol, ARow: Integer);
var
  str: String;
  OcComPortObj: TOcComPortObj;
begin
  if ARow <= 0 then
  begin
    // if ACol = 0 then
    // MessageBox(Application.Handle, PChar('这一列发送字符串'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    // if ACol = 1 then
    // MessageBox(Application.Handle, PChar('这一列发送字节（十六进制）'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    Exit;
  end;

  StringGrid1.Options := StringGrid1.Options - [goEditing];
  // OcComPortObj := GetDeciceByFullName(Notebook2.ActivePage);
  OcComPortObj := SettingPagesDlg.getCurrentDevice();
  if OcComPortObj = nil then
  begin
    MessageBox(Application.Handle, PChar('No device!! You need to open a device,please use F1 to get help'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    Exit;
  end;
  if not OcComPortObj.Connected then
  begin
    MessageBox(Application.Handle, PChar('No device!! You need to open a device,please use F1 to get help'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    Exit;
  end;

  StringGridSelectCell(ACol, ARow);
  str := GetStringGridValidStr(StringGrid1.Cells[2, ARow]);

  if ACol = 0 then
  begin
    OcComPortObj.FalconComSendData_Common(str, 0);
  end;
  if ACol = 1 then
  begin
    OcComPortObj.FalconComSendData_Common(str, 1);
  end;
end;

procedure TMainForm.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (StringGrid1.Col = 4) or (StringGrid1.Col = 5) then
  begin
    if not(Key in ['0' .. '9', #8]) then
      Key := #0;
  end;
end;

procedure TMainForm.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  StringGrid1_Col, StringGrid1_Row: Integer;
begin
  StringGrid1.MouseToCell(X, Y, StringGrid1_Col, StringGrid1_Row);
  if (StringGrid1_Col = CHECKCOL) OR (StringGrid1_Col = 1) OR (StringGrid1_Col = 0) then
    StringGridSelectCell(StringGrid1_Col, StringGrid1_Row);

  if StringGrid1_Col = DATACOL then
    StringGrid1.Col := DATACOL;
end;

procedure TMainForm.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  StringGrid1_Col, StringGrid1_Row: Integer;
begin
  StringGrid1.MouseToCell(X, Y, StringGrid1_Col, StringGrid1_Row);
  if StringGrid1_Col = DATACOL then
    StringGrid1.Col := DATACOL;
end;

procedure TMainForm.StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if StringGrid1.Col <> 2 then
    StringGrid1.Col := 2;
  // Handled:=true;
end;

procedure TMainForm.StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if StringGrid1.Col <> 2 then
    StringGrid1.Col := 2;
end;

procedure TMainForm.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  // StringGrid1.MouseToCell(X, Y, StringGrid1_Col, StringGrid1_Row);
  with StringGrid1 do
  begin
    if ACol = CHECKCOL then // 多选项列不编辑不选中
    begin
      Options := Options - [goEditing];
      Options := Options + [goRowSelect];
      CanSelect := False;
      // Memo1.Lines.Add(IntToStr(ACol) + ',' + IntToStr(ARow) + ',False ' + boolToStr(CanSelect));
    end
    else
    begin
      CanSelect := True;
      Options := Options + [goEditing];
      Options := Options - [goRowSelect];
      // Memo1.Lines.Add(IntToStr(ACol) + ',' + IntToStr(ARow) + ',True ' + boolToStr(CanSelect));
    end;
  end;
end;

procedure TMainForm.StringGridSelectCell(ACol, ARow: Integer);
var
  GridRect: TGridRect;
begin
  StringGrid1.BeginUpdate;
  if (ACol = CHECKCOL) and (ARow > 0) then
  begin
    if StringGrid1.Cells[ACol, ARow] = '1' then
      StringGrid1.Cells[ACol, ARow] := '0'
    else if StringGrid1.Cells[ACol, ARow] = '0' then
      StringGrid1.Cells[ACol, ARow] := '1'
    else
      StringGrid1.Cells[ACol, ARow] := '0'
  end;

  if ((ACol = 1) OR (ACol = 0)) and (ARow > 0) then
  begin
    with GridRect do
    begin
      Top := ARow;
      Left := 0;
      Bottom := ARow;
      Right := 6;
    end;
    StringGrid1.Selection := GridRect;
    // StringGrid1.Options := StringGrid1.Options + [goRowSelect];
  end;
  StringGrid1.EndUpdate;
end;

procedure TMainForm.StringGridSave();
var
  Octopusini: TIniFile;
  s: String;
  i: Integer;
begin
  s := OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
  try
    Octopusini := TIniFile.Create(s);
    for i := 1 to StringGrid1.RowCount - 1 do
    begin
      Octopusini.WriteString('MyCustData', IntToStr(i) + '_2', StringGrid1.Cells[2, i]);
      // Octopusini.WriteString('MyCustData', IntToStr(i) + '_5', StringGrid1.Cells[5, i]);
    end;
  finally
    Octopusini.Free;
  end;
end;

procedure TMainForm.StringGridLoad();
var
  Octopusini: TIniFile;
  s: String;
  i: Integer;
begin
  s := OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
  try
    Octopusini := TIniFile.Create(s);
    for i := 1 to StringGrid1.RowCount - 1 do
    begin
      StringGrid1.Cells[2, i] := Octopusini.ReadString('MyCustData', IntToStr(i) + '_2', '');
      // StringGrid1.Cells[5, i] := Octopusini.ReadString('MyCustData', IntToStr(i) + '_5', '');
    end;
  finally
    Octopusini.Free;
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TMainForm.InitUartsParameters();
begin
  if SettingPagesDlg = nil then
    SettingPagesDlg := TSettingPagesDlg.Create(nil);

  Self.ComboBoxEx1.Images := SettingPagesDlg.ComboBoxEx1.Images;
  Self.ComboBoxEx1.Items := SettingPagesDlg.ComboBoxEx1.Items;

  Self.ComboBox1.Items := SettingPagesDlg.ComboBox1.Items;
  Self.ComboBox2.Items := SettingPagesDlg.ComboBox7.Items;
end;

end.
