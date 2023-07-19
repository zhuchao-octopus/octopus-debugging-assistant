unit uOctopusMain;

interface

uses
  System.SysUtils, System.StrUtils, Winapi.Windows, Winapi.Messages, Winapi.WinInet, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, Vcl.ClipBrd,
  Vcl.ToolWin, Vcl.ActnList, System.Actions, System.ImageList, Vcl.ImgList, Vcl.StdActns, Vcl.ExtActns,
  Vcl.Tabs, VCLTee.TeCanvas, Vcl.Grids, Vcl.WinXCtrls, Vcl.TabNotBk, Vcl.Themes,

  IniFiles,
  OcComPortObj,
  Vcl.MyPageEdit,
  uOctopusFunction, Vcl.OleCtrls, SHDocVw;

type
  TMainOctopusDebuggingDevelopmentForm = class(TForm)
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
    EditFontItem: TMenuItem;

    FontDialog: TFontDialog;
    StandardToolBar1: TToolBar;
    StandardToolBar2: TToolBar;

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
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    SettingItem1: TMenuItem;
    ToolsMenu: TMenuItem;
    Panel1: TPanel;
    SV_R: TSplitView;
    Panel2: TPanel;
    Panel25: TPanel;
    Panel7: TPanel;
    Memo2: TMemo;
    Panel8: TPanel;
    Button102: TButton;
    Button103: TButton;
    Button105: TButton;
    Panel13: TPanel;
    Memo1: TMemo;
    Button100: TButton;
    Button101: TButton;
    Panel200: TPanel;
    StringGrid1: TStringGrid;
    Panel201: TPanel;
    Button201: TButton;
    Button200: TButton;
    Panel5: TPanel;
    Memo3: TMemo;
    Panel16: TPanel;
    Button301: TButton;
    Button300: TButton;
    Button302: TButton;
    Panel18: TPanel;
    Label003: TLabel;
    Label002: TLabel;
    Label001: TLabel;
    Label000: TLabel;
    ComboBox304: TComboBox;
    ComboBox301: TComboBox;
    ComboBox302: TComboBox;
    ComboBox303: TComboBox;
    Splitter1: TSplitter;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    SkinsMenu: TMenuItem;
    ViewMenu: TMenuItem;
    PageControl1: TMyPageEdit;
    PageControl2: TPageControl;
    StatusPanel: TPanel;

    TabSheet_SendingData: TTabSheet;
    TabSheet_BatchData: TTabSheet;
    TabSheet_ProtocolData: TTabSheet;
    FormatToolBarMenuItem1: TMenuItem;
    FormatToolBarMenuItem2: TMenuItem;
    ToolButton11: TToolButton;
    ToolButton13: TToolButton;
    Button104: TButton;
    ToggleSwitchDeviceOnOff: TToggleSwitch;
    ToolButton14: TToolButton;
    COMMenu: TMenuItem;
    StatusBar1: TStatusBar;
    N8: TMenuItem;
    TopLevelMenuItem: TMenuItem;
    N9: TMenuItem;
    SettingItem2: TMenuItem;
    ToolButton12: TToolButton;
    ToolButton15: TToolButton;
    RightOperationPanel1: TMenuItem;
    LptatpMenuItem: TMenuItem;
    RptatpMenuItem: TMenuItem;
    N10: TMenuItem;
    RptabpMenuItem: TMenuItem;
    RptarpMenuItem: TMenuItem;
    LptabpMenuItem: TMenuItem;
    LptalpMenuItem: TMenuItem;
    ToolButton16: TToolButton;
    EnglishMenuItem: TMenuItem;
    N11: TMenuItem;
    ChineseMenuItem: TMenuItem;
    FindDialog1: TFindDialog;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    ScreenshotTool1: TMenuItem;
    ScreenshotTool2: TMenuItem;
    DataEncryption1: TMenuItem;
    CRC1: TMenuItem;
    MachineLearningOfNeuralNetworks1: TMenuItem;
    N12: TMenuItem;
    ProblemFeedback1: TMenuItem;
    WelcomeAndHelp1: TMenuItem;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    Encoding1: TMenuItem;
    ASCIIItem: TMenuItem;
    ANSIItem: TMenuItem;
    BigEndianUnicodeEncodingItem: TMenuItem;
    UnicodeEncodingItem: TMenuItem;
    UTF7EncodingItem: TMenuItem;
    UTF8EncodingItem: TMenuItem;
    N13: TMenuItem;
    ConverttoAnsi1: TMenuItem;
    ConverttoUTF81: TMenuItem;
    N14: TMenuItem;
    CharacteSets1: TMenuItem;
    DefaultItem: TMenuItem;
    ConverttoUTF82: TMenuItem;
    Search1: TMenuItem;
    N15: TMenuItem;
    PopupMenu1: TPopupMenu;
    CloseTheDevice1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    N16: TMenuItem;
    ShowLinesNumberItem: TMenuItem;
    N17: TMenuItem;
    HexModeItem: TMenuItem;
    QuickTerminalCommandsItem: TMenuItem;
    DownloadUpdate1: TMenuItem;
    N18: TMenuItem;
    PageSetting1: TMenuItem;
    N19: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SelectionChange(Sender: TObject);

    procedure FileNew(Sender: TObject);
    procedure FileOpenAccept(Sender: TObject);
    procedure FileOpenBeforeExecute(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrintAccept(Sender: TObject);

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
    procedure SettingItem1Click(Sender: TObject);

    procedure HelpAbout(Sender: TObject);
    procedure SkinsMenuClick(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid1FixedCellClick(Sender: TObject; ACol, ARow: Integer);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure FormatToolBarMenuItem2Click(Sender: TObject);
    procedure FormatToolBarMenuItem1Click(Sender: TObject);

    procedure ToolButton13Click(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure ToggleSwitchDeviceOnOffClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TopLevelMenuItemClick(Sender: TObject);
    procedure SettingItem2Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure RightOperationPanel1Click(Sender: TObject);
    procedure RptatpMenuItemClick(Sender: TObject);
    procedure RptabpMenuItemClick(Sender: TObject);
    procedure RptarpMenuItemClick(Sender: TObject);
    procedure LptatpMenuItemClick(Sender: TObject);
    procedure LptabpMenuItemClick(Sender: TObject);
    procedure LptalpMenuItemClick(Sender: TObject);
    procedure ViewMenuClick(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure HelpMenuClick(Sender: TObject);
    procedure EnglishMenuItemClick(Sender: TObject);
    procedure ChineseMenuItemClick(Sender: TObject);
    procedure FindDialog1Close(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure FindDialog1Show(Sender: TObject);
    procedure Button201Click(Sender: TObject);
    procedure Button200Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button102Click(Sender: TObject);
    procedure Button100Click(Sender: TObject);
    procedure Button101Click(Sender: TObject);
    procedure Button103Click(Sender: TObject);
    procedure Button104Click(Sender: TObject);
    procedure Button105Click(Sender: TObject);
    procedure Button300Click(Sender: TObject);
    procedure Button301Click(Sender: TObject);
    procedure Button302Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ProblemFeedback1Click(Sender: TObject);
    procedure ScreenshotTool2Click(Sender: TObject);
    procedure ScreenshotTool1Click(Sender: TObject);
    procedure DataEncryption1Click(Sender: TObject);
    procedure CRC1Click(Sender: TObject);
    procedure WelcomeAndHelp1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure Encoding1Click(Sender: TObject);
    procedure ConverttoUTF81Click(Sender: TObject);
    procedure ConverttoAnsi1Click(Sender: TObject);
    procedure CharacteSets1Click(Sender: TObject);
    procedure DefaultItemClick(Sender: TObject);
    procedure ASCIIItemClick(Sender: TObject);
    procedure ANSIItemClick(Sender: TObject);
    procedure UTF7EncodingItemClick(Sender: TObject);
    procedure UTF8EncodingItemClick(Sender: TObject);
    procedure BigEndianUnicodeEncodingItemClick(Sender: TObject);
    procedure UnicodeEncodingItemClick(Sender: TObject);
    procedure ConverttoUTF82Click(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure CloseTheDevice1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure ToolButton19Click(Sender: TObject);
    procedure ShowLinesNumberItemClick(Sender: TObject);
    procedure HexModeItemClick(Sender: TObject);
    procedure FileSaveAsCmdBeforeExecute(Sender: TObject);
    procedure RichEditMenuClick(Sender: TObject);
    procedure QuickTerminalCommandsItemClick(Sender: TObject);
    procedure DownloadUpdate1Click(Sender: TObject);
    procedure SV_ROpened(Sender: TObject);
    procedure SV_RClosed(Sender: TObject);
    procedure FontDialogShow(Sender: TObject);
    procedure PageSetting1Click(Sender: TObject);

  private
    OcComPortObj_Loop: TOcComPortObj;
    LoopingString: String;
    FVersionNumberStr: String;
    CMyRichEdit: TMyRichEdit;
    WebBrowser: TWebBrowser;
    SkinMenuItem: TMenuItem;
    FThemeSkinName: String;

    FCheck, FNoCheck: TBitmap;
    Fprogress, FprogressMax: Integer;

    FFilePathName: string;
    FUpdating: Boolean;
    FDragOfs: Integer;
    FDragging: Boolean;

    procedure ShowHint(Sender: TObject);

    function CurrTextAttributes(): TTextAttributes;
    procedure SynchroSetMyRichEditFont(MyRichEdit: TMyRichEdit; Style: Integer);
    procedure SetMyRichEditFont(MyRichEdit: TMyRichEdit);
    procedure SynchroFontDialog(MyRichEdit: TMyRichEdit; Style: Integer);

    procedure GetFontNames();
    procedure SetPathFileName(const FileName: String);
    procedure CheckFileSave();
    procedure UpdateCursorPos();

    procedure PerformFileOpen(const AFileName: string); overload;
    procedure PerformFileOpen(const AFileName: string; PageName: String); overload;
    procedure LoadNewFileFromTo(PathFileName: String);
    procedure LoadUntitledContent(MyRichEdit: TMyRichEdit; const AFileName: string);

    procedure SetModified(Value: Boolean);
    procedure UpdateStatus(Value: String);

    function GetStringGridValidStr(sStr: String): String;
    function GetCurrentPageName(): String;
    function GetCurrentDevice(): TOcComPortObj;
    function SearchMemo(Memo: TMyRichEdit; const SearchString: string; Options: TFindOptions): Boolean;

    procedure ShowSearchDialog();
    procedure CreateMyObjectPage(PageName: String; PageType: Integer);
    procedure InitAllUartDevices();
    procedure GetAndOpenADevices(OcComPortObj: TOcComPortObj); overload;
    procedure GetAndOpenADevices(DeviceName: String); overload;
    procedure GetAndRemoveDevices(DeviceName: String);

    procedure SkinsMenuOnClick(Sender: TObject);
    procedure InitSkinsMenu(ParentMenu: TMenuItem; OnClicEvent: TOnClicEvent);

    procedure InitStringGrid();
    procedure StringGridSelectCell(ACol, ARow: Integer);
    procedure StringGridSave();
    procedure StringGridLoad();

    procedure InitUartsParameters();
    procedure InitUartsMenu(ParentMenu: TMenuItem; OnClicEvent: TOnClicEvent);
    procedure COM1MenuItemOnClick(Sender: TObject);

    procedure InitMainUI();
    procedure AdjustUI();
    procedure InitUserConfiguration();

    procedure UpdateUartToolBar();
    procedure UpdateMainMenu();

    procedure StatusBar1DrawProgress(progress: Integer; progressMax: Integer);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure StatusBarPrintFileSize();
    procedure ShowStartComments(OcComPortObj: TOcComPortObj);
    procedure SaveProjectSetting(SavePrivate: Boolean);
    procedure LoadProjectSetting();

    procedure ShowHideRLPanel(RL: Integer = 1); overload;
    procedure ShowHideRLPanel(OpenClose: Boolean; RL: Integer = 1); overload;
    procedure SendFileAsBin(OcComPortObj: TOcComPortObj; FileName: String);
    procedure SendFileAsHex(OcComPortObj: TOcComPortObj; FileName: String);

    procedure AcceptCommandLine();
    procedure MyAppMsg(var Msg: TMsg; var Handled: Boolean);
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    Procedure SystemMessage_WMMenuSelect(var Msg: TWMMenuSelect); message WM_SysCommand;
    procedure OcComPortObjCallBack(Count: Integer);
    Procedure SettingChangedCallBackFuntion(Obj: TObject);
    procedure EventCallBackFuntion(Obj: TObject);
  end;

const
  CHECKCOL: Integer = 3;
  DATACOL: Integer = 2;

var
  MainOctopusDebuggingDevelopmentForm: TMainOctopusDebuggingDevelopmentForm;

implementation

uses uOctopusAbout, RichEdit, Winapi.ShellAPI, System.UITypes, System.IOUtils, Winapi.ShlObj, Winapi.ActiveX, System.Win.ComObj,
  uSetting, math, OcProtocol, CPort, uMainSetting, uSMTP, uEncryptionDecryption, uCRC,
  Screenshot, uScreenMain, uCommand, uDownloader, uPageSetup;

resourcestring
  sSaveChanges = 'Save changes to %s?';
  sOverWrite = 'The file already exists, if you need to overwrite it %s';
  sUntitled = 'Untitled';
  sModified = 'Modified';
  sColRowInfo = 'Line: %3d  Col: %3d';
  sScrollPos = 'Scroll Pos: %d, %d';
  sOpenLink = 'Open link: %s ?';
  sSaved = 'The File Saved';

const
  RulerAdj = 4 / 3;
  GutterWid = 6;

{$R *.dfm}
  { Event Handlers }

Function CheckUrl(URL: string): Boolean;
var
  hSession, hfile, hRequest: hInternet;
  dwindex, dwcodelen: dword;
  dwcode: array [1 .. 20] of Char;
  res: PChar;
begin
  Result := false;
  if Pos('http://', LowerCase(URL)) = 0 then
    URL := 'http://' + URL;

  hSession := InternetOpen('InetURL:/1.0', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(hSession) then
  begin
    hfile := InternetOpenUrl(hSession, PChar(URL), nil, 0, INTERNET_FLAG_RELOAD, 0);
    dwindex := 0;
    dwcodelen := 10;
    HttpQueryInfo(hfile, HTTP_QUERY_STATUS_CODE, @dwcode, dwcodelen, dwindex);
    res := PChar(@dwcode);
    Result := (res = '200') or (res = '302'); // 200,302δ�ض�λ��־
    if Assigned(hfile) then
      InternetCloseHandle(hfile);
    InternetCloseHandle(hSession);
  end;
end;

procedure DelayDelay(msec: Integer);
var
  FirstTickCount: real;
begin
  FirstTickCount := GetTickCount();
  FirstTickCount := FirstTickCount + msec;
  While FirstTickCount > GetTickCount() do
    Application.ProcessMessages;
end;

procedure Delay(MSecs: Longint);
var
  FirstTickCount, Now: Longint;
begin
  FirstTickCount := GetTickCount();
  repeat
    Application.ProcessMessages;
    Now := GetTickCount();
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;

procedure TMainOctopusDebuggingDevelopmentForm.ShowHideRLPanel(OpenClose: Boolean; RL: Integer = 1);
begin
  if RL = 1 then
  begin
    if not OpenClose then
    begin
      SV_R.Close;
    end
    else
    begin
      if SV_R.Width < 30 then
        SV_R.Width := 400;
      Splitter1.Align := alLeft;
      SV_R.Align := alRight;
      SV_R.Placement := svpRight;
      SV_R.Open;
      AdjustUI();
    end;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ShowHideRLPanel(RL: Integer);
begin
  if RL = 1 then
  begin
    if SV_R.Opened then
      SV_R.Close
    else
    begin
      if SV_R.Width < 30 then
      begin
        SV_R.Width := 400;
      end;
      SV_R.Open;
      AdjustUI();
    end;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SystemMessage_WMMenuSelect(var Msg: TWMMenuSelect);
begin
  inherited;
end;

procedure TMainOctopusDebuggingDevelopmentForm.MyAppMsg(var Msg: TMsg; var Handled: Boolean);
var
  OcComPortObj: TOcComPortObj;
  keyState: TKeyBoardState;
  i: Integer;
begin
  case Msg.message of
    WM_LBUTTONDOWN:
      begin
        // TStringGridEx(StringGrid1).MouseToCell(LoWord(Msg.LParam), HiWord(Msg.LParam), StringGrid1_Col, StringGrid1_Row);
      end;
    WM_KEYDOWN:
      begin
        if Msg.wParam = VK_TAB then
        begin
        end;
        if Msg.wParam = VK_CONTROL then
        begin
          OcComPortObj := Self.GetCurrentDevice();
          if (OcComPortObj <> nil) then
          begin
            if OcComPortObj.Connected then
            begin
              OcComPortObj.MouseTextSelection := True;
            end;
          end;
        end;

        if (Msg.wParam = VK_F1) then
        begin
          ShowHideRLPanel(1);
          Handled := True;
        end;

        if Msg.wParam = VK_F2 then
        begin
          ShowHideRLPanel(1);
          Handled := True;
        end;

        if (Msg.wParam = VK_ESCAPE) then
        begin
          OcComPortObj := Self.GetCurrentDevice();
          if (OcComPortObj <> nil) then
          begin
            OcComPortObj.SetLogComponentReadOnly(True);
          end;

          ShowHideRLPanel(1);
          Handled := True;
        end;

        GetKeyboardstate(keyState);

        if (Msg.wParam = VK_F3) or ((keyState[VK_LCONTROL] = 129) and (Msg.wParam = 70)) then
        begin
          ShowSearchDialog();
          Handled := True;
        end;
      end; // WM_KEYDOWN:begin
    WM_KEYUP:
      begin
        if (Msg.wParam = VK_F1) then
        begin
          Handled := True;
        end;
        if Msg.wParam = VK_CONTROL then
        begin
          OcComPortObj := Self.GetCurrentDevice();
          if (OcComPortObj <> nil) then
          begin
            OcComPortObj.MouseTextSelection := false;
            OcComPortObj.StartFlushOutCackedString();
          end;
        end;
      end;
  end; // case   msg.message   of
end;

procedure TMainOctopusDebuggingDevelopmentForm.FormCreate(Sender: TObject);
/// var
/// OcComPortObj: TOcComPortObj;
begin
  InitMainUI();
  InitSkinsMenu(SkinsMenu, SkinsMenuOnClick);
  InitStringGrid();
  InitUartsParameters();

  InitAllUartDevices();

  InitUartsMenu(COMMenu, COM1MenuItemOnClick);
  UpdateUartToolBar();
  LoadProjectSetting();
  SettingPagesDlg.LoadOrCreateLaunguageFromFile(Self, True);

  InitUserConfiguration();
  DragAcceptFiles(Handle, True);
  Application.OnMessage := MyAppMsg;

end;

procedure TMainOctopusDebuggingDevelopmentForm.FormResize(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);

  if CMyRichEdit <> nil then
  begin
    SelectionChange(Sender);
    CMyRichEdit.Invalidate;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.FormShow(Sender: TObject);
begin
  AcceptCommandLine();
  if SV_R.Opened then
  begin
    AdjustUI();
  end
  else
  begin
    Self.Splitter1.Visible := false;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
    /// CheckFileSave;
    Self.PageControl1.FreeAll;
    SaveProjectSetting(True);

  except
    CanClose := false;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.AcceptCommandLine();
var
  SelectedFile: string;
begin
  /// ShowMessage(getCommandLine());
  SelectedFile := ParamStr(1); // 获取命令行参数中的第二个参数，即选中的文件路径
  if FileExists(SelectedFile) then
  begin
    LoadNewFileFromTo(SelectedFile);
    Self.SV_R.Close;
    Self.StandardToolBar1.Visible := True;
    Self.StandardToolBar2.Visible := false;
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////
/// richedit
procedure TMainOctopusDebuggingDevelopmentForm.ShowHint(Sender: TObject);
begin
  if Length(Application.Hint) > 0 then
  begin
    // StatusBar1.SimplePanel := True;
    // StatusBar1.SimpleText := Application.Hint;
    StatusBar1.Panels[1].Text := Application.Hint;
  end;
  // else StatusBar1.SimplePanel := False;
end;

procedure TMainOctopusDebuggingDevelopmentForm.LoadUntitledContent(MyRichEdit: TMyRichEdit; const AFileName: string);
var
  FileNameNoExt: String;
begin
  if MyRichEdit = nil then
    exit;
  /// UpdateCursorPos;
  /// DragAcceptFiles(Handle, True);
  /// RichEditChange(nil);
  MyRichEdit.SetFocus;
  /// Check if we should load a file from the command line, assuming the default file is not available
  if TFile.Exists(AFileName) then
  begin
    MyRichEdit.LoadFrom(AFileName);
    MyRichEdit.SetFocus;
    FileNameNoExt := ExtractFileNameNoExt(AFileName);
    PageControl1.SetPageName(FileNameNoExt, PageControl1.ActivePageIndex);
    SetModified(false);
    SetPathFileName(AFileName);
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SelectionChange(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  try
    FUpdating := True;
    FontSize.Text := IntToStr(CMyRichEdit.SelAttributes.Size);
    FontName.Text := CMyRichEdit.SelAttributes.Name;
    FGColorBox.Selected := CMyRichEdit.SelAttributes.Color;
    BGColorBox.Selected := CMyRichEdit.SelAttributes.BackColor;
    UpdateCursorPos();
  finally
    FUpdating := false;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.RichEditChange(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  SetModified(CMyRichEdit.Modified);
  UpdateCursorPos;
end;

procedure TMainOctopusDebuggingDevelopmentForm.FGColorBoxChange(Sender: TObject);
var
  Color: TColor;
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  Color := FGColorBox.Selected;
  CMyRichEdit.SelAttributes.Color := Color;
end;

procedure TMainOctopusDebuggingDevelopmentForm.BGColorBoxChange(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  CMyRichEdit.SelAttributes.BackColor := BGColorBox.Selected;
end;

function TMainOctopusDebuggingDevelopmentForm.CurrTextAttributes: TTextAttributes;
begin
  /// Result := nil;
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  if CMyRichEdit.SelLength > 0 then
    Result := CMyRichEdit.SelAttributes
  else
    Result := CMyRichEdit.DefAttributes;
end;

procedure TMainOctopusDebuggingDevelopmentForm.RichEditorClick(Sender: TObject);
begin
  UpdateCursorPos;
end;

procedure TMainOctopusDebuggingDevelopmentForm.RichEditorLinkClick(Sender: TCustomRichEdit; const URL: string; Button: TMouseButton);
begin
  if (Button = mbLeft) and (MessageDlg(Format(sOpenLink, [URL]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    ShellExecute(Handle, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL)
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric; FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure TMainOctopusDebuggingDevelopmentForm.GetFontNames;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := True;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SetPathFileName(const FileName: String);
begin
  FFilePathName := FileName;
  Caption := Format('%s - %s', [Application.Title, FileName]);
  /// ExtractFileName
  StatusBar1.Panels[2].Text := FFilePathName;
end;

procedure TMainOctopusDebuggingDevelopmentForm.CharacteSets1Click(Sender: TObject);
begin
  EditFontItem.Click;
end;

procedure TMainOctopusDebuggingDevelopmentForm.CheckFileSave;
var
  SaveResp: Integer;
begin
  if CMyRichEdit = nil then
    exit;
  if not CMyRichEdit.Modified then
    exit;
  SaveResp := MessageDlg(Format(sSaveChanges, [FFilePathName]), mtConfirmation, mbYesNoCancel, 0);
  case SaveResp of
    idYes:
      FileSave(Self);
    idNo:
      /// Nothing
      ;
    idCancel:
      Abort;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SubscriptCmdExecute(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  CMyRichEdit.SelAttributes.Subscript := sstSubscript;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SubscriptCmdUpdate(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  (Sender as TAction).Checked := CMyRichEdit.SelAttributes.Subscript = sstSubscript;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SuperscriptCmdExecute(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  CMyRichEdit.SelAttributes.Subscript := sstSuperscript;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SuperscriptCmdUpdate(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  (Sender as TAction).Checked := CMyRichEdit.SelAttributes.Subscript = sstSuperscript;
end;

procedure TMainOctopusDebuggingDevelopmentForm.PageControl1Change(Sender: TObject);
var
  MyRichEdit: TMyRichEdit;
begin
  /// showmessage(intTostr(PageControl1.ActivePageIndex));
  MyRichEdit := Self.PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if MyRichEdit <> nil then
  begin
    Self.CMyRichEdit := MyRichEdit;
    SynchroSetMyRichEditFont(MyRichEdit, MyRichEdit.FStyle);
  end;
  CommandFrm.OcComPortObj := Self.GetCurrentDevice();
  Self.UpdateUartToolBar();
  StatusBarPrintFileSize();
end;

procedure TMainOctopusDebuggingDevelopmentForm.PageControl2Change(Sender: TObject);
begin
  AdjustUI();
end;

procedure TMainOctopusDebuggingDevelopmentForm.PageSetting1Click(Sender: TObject);
begin
  /// CMyRichEdit.Paragraph.FirstIndent := 12;
  /// CMyRichEdit.Paragraph.LeftIndent := 10;
  /// SelectionChange(Sender);
  PageSetupFrm.CMyRichEdit := Self.CMyRichEdit;
  PageSetupFrm.Show();
end;

/// 创建一个空的未命名的文档
procedure TMainOctopusDebuggingDevelopmentForm.FileNew(Sender: TObject);
var
  PageIndex: Integer;
begin
  CreateMyObjectPage(sUntitled, 0);
  CMyRichEdit := PageControl1.GetEdit(sUntitled);
  if CMyRichEdit = nil then
    exit;

  LoadUntitledContent(CMyRichEdit, ExtractFilePath(Application.Exename) + '\' + sUntitled + '.rtf');
  /// SetPathFileName(sUntitled);
  /// CMyRichEdit.Clear();
  /// CMyRichEdit.Modified := false;
  /// SetModified(false);
end;

procedure TMainOctopusDebuggingDevelopmentForm.PerformFileOpen(const AFileName: string);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  CMyRichEdit.LoadFrom(AFileName);
  SetPathFileName(AFileName);
  CMyRichEdit.SetFocus;
  CMyRichEdit.Modified := false;
  SetModified(false);
end;

procedure TMainOctopusDebuggingDevelopmentForm.PerformFileOpen(const AFileName: string; PageName: String);
var
  FileNameNoExt: String;
begin
  CMyRichEdit := PageControl1.GetEdit(PageName);
  if CMyRichEdit = nil then
    exit;

  CMyRichEdit.LoadFrom(AFileName);
  SetPathFileName(AFileName);

  FileNameNoExt := ExtractFileNameNoExt(AFileName);
  PageControl1.SetPageName(FileNameNoExt, PageControl1.GetPageIndex(PageName));
  CMyRichEdit.SetFocus;
  CMyRichEdit.Modified := false;
  SetModified(false);
end;

procedure TMainOctopusDebuggingDevelopmentForm.LoadNewFileFromTo(PathFileName: String);
var
  FileNameNoExt: String;
  MyRichEdit: TMyRichEdit;
  NewPageName: String;
  /// PageIndex:Integer;
begin
  FileNew(Self);
  if PageControl1.GetActivePageName = sUntitled then
  begin
    MyRichEdit := PageControl1.LoadFileFrom(PathFileName, sUntitled);
    if MyRichEdit <> nil then
    begin
      MyRichEdit.ReadOnly := ofReadOnly in FileOpenCmd.Dialog.Options;
      MyRichEdit.SetFocus;
      FileNameNoExt := ExtractFileNameNoExt(PathFileName);
      PageControl1.SetPageName(FileNameNoExt, PageControl1.ActivePageIndex);
      SetModified(false);
      SetPathFileName(PathFileName);
    end
    else
      UpdateStatus('Load file failed!');
  end
  else
    UpdateStatus('Load file failed!');
end;

procedure TMainOctopusDebuggingDevelopmentForm.FileOpenAccept(Sender: TObject);
begin
  LoadNewFileFromTo(FileOpenCmd.Dialog.FileName);
end;

procedure TMainOctopusDebuggingDevelopmentForm.FileOpenBeforeExecute(Sender: TObject);
begin
  /// CheckFileSave;
end;

procedure TMainOctopusDebuggingDevelopmentForm.FileSave(Sender: TObject);
begin
  // if CMyRichEdit = nil then
  CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;

  if FFilePathName <> '' then
  begin
    CMyRichEdit.SaveTo(FFilePathName);
    CMyRichEdit.Modified := false;
    SetModified(false);
    UpdateStatus(sSaved);
  end
  else
  /// if (FFilePathName = sUntitled) or (FFilePathName = '') then
  begin
    FileSaveAs(Sender);
  end
end;

procedure TMainOctopusDebuggingDevelopmentForm.FileSaveAs(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
  FileNameNoExt: String;
begin
  OcComPortObj := GetCurrentDevice();
  CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);

  if CMyRichEdit = nil then
    exit;

  if (OcComPortObj <> nil) then
    FileSaveAsCmd.Dialog.FileName := SettingPagesDlg.OctopusCfgDir_LogFilePath + '\' + OcComPortObj.Port + '_' + GetSystemDateTimeStampStr + '.log';

  if FileSaveAsCmd.Dialog.FileName = '' then
  begin
    FileSaveAsItem.Click;
    if FileSaveAsCmd.Dialog.FileName <> '' then
    begin
      SetPathFileName(FileSaveAsCmd.Dialog.FileName);
      FileNameNoExt := ExtractFileNameNoExt(FileSaveAsCmd.Dialog.FileName);
      PageControl1.SetPageName(FileNameNoExt, PageControl1.ActivePageIndex);
    end;
    exit;
  end;

  if FileExists(FileSaveAsCmd.Dialog.FileName) then
    if MessageDlg(Format(sOverWrite, [FileSaveAsCmd.Dialog.FileName]), mtConfirmation, mbYesNoCancel, 0) <> idYes then
      exit;

  CMyRichEdit.SaveTo(FileSaveAsCmd.Dialog.FileName);
  SetPathFileName(FileSaveAsCmd.Dialog.FileName);
  CMyRichEdit.Modified := false;
  SetModified(false);
  UpdateStatus(sSaved);
end;

procedure TMainOctopusDebuggingDevelopmentForm.FileSaveAsCmdBeforeExecute(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetCurrentDevice();
  if (OcComPortObj <> nil) then
    FileSaveAsCmd.Dialog.FileName := SettingPagesDlg.OctopusCfgDir_LogFilePath + OcComPortObj.Port + '_' + GetSystemDateTimeStampStr + '.log';
end;

procedure TMainOctopusDebuggingDevelopmentForm.FilePrintAccept(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  CMyRichEdit.Print(FFilePathName);
end;

procedure TMainOctopusDebuggingDevelopmentForm.SelectFont(Sender: TObject);
begin
  /// if CMyRichEdit = nil then
  CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  if FontDialog.Execute then
  begin
    /// CurrTextAttributes.Assign(FontDialog.Font);
    SetMyRichEditFont(CMyRichEdit);
  end;
  SelectionChange(Self);
  /// CMyRichEdit.SetFocus;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SelectFontBeforeExecute(Sender: TObject);
begin
  FontDialog.Font.Assign(CMyRichEdit.SelAttributes);
end;

procedure TMainOctopusDebuggingDevelopmentForm.FontSizeChange(Sender: TObject);
begin
  if FUpdating then
    exit;
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  CurrTextAttributes.Size := StrToInt(FontSize.Text);
end;

procedure TMainOctopusDebuggingDevelopmentForm.FontDialogShow(Sender: TObject);
begin
  SynchroFontDialog(Self.CMyRichEdit, Self.CMyRichEdit.FStyle);
end;

procedure TMainOctopusDebuggingDevelopmentForm.FontNameChange(Sender: TObject);
begin
  if FUpdating then
    exit;
  CurrTextAttributes.Name := FontName.Items[FontName.ItemIndex];
end;

procedure TMainOctopusDebuggingDevelopmentForm.UpdateCursorPos;
var
  CharPos: TPoint;
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  CharPos.Y := SendMessage(CMyRichEdit.Handle, EM_EXLINEFROMCHAR, 0, CMyRichEdit.SelStart);
  CharPos.X := (CMyRichEdit.SelStart - SendMessage(CMyRichEdit.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  StatusBar1.Panels[0].Text := Format(sColRowInfo, [CharPos.Y, CharPos.X]);
  StatusBar1.Panels[1].Text := Format(sScrollPos, [CMyRichEdit.ScrollPosition.X, CMyRichEdit.ScrollPosition.Y]);
end;

procedure TMainOctopusDebuggingDevelopmentForm.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array [0 .. MAX_PATH] of Char;
  FileNameNoExt: String;
begin
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      /// CheckFileSave;
      { FileNew(Self);
        if PageControl1.GetActivePageName = sUntitled then
        begin
        PerformFileOpen(CFileName);
        FileNameNoExt := ExtractFileNameNoExt(CFileName);
        PageControl1.SetPageName(FileNameNoExt, PageControl1.ActivePageIndex);
        end; }
      LoadNewFileFromTo(CFileName);
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.RichEditMenuClick(Sender: TObject);
begin
  if CMyRichEdit = nil then
  begin
    HexModeItem.Checked := CMyRichEdit.FHexadecimalMode;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.RichEditTransparentItemClick(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;
  RichEditTransparentItem.Checked := not RichEditTransparentItem.Checked;
  CMyRichEdit.Transparent := RichEditTransparentItem.Checked;
end;

procedure TMainOctopusDebuggingDevelopmentForm.RichEditWordWrapItemClick(Sender: TObject);
begin
  if CMyRichEdit = nil then
    CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  if CMyRichEdit = nil then
    exit;

  RichEditWordWrapItem.Checked := not RichEditWordWrapItem.Checked;
  CMyRichEdit.WordWrap := RichEditWordWrapItem.Checked;

  if RichEditWordWrapItem.Checked then
    CMyRichEdit.ScrollBars := ssVertical
  else
    CMyRichEdit.ScrollBars := ssBoth;
end;

procedure TMainOctopusDebuggingDevelopmentForm.RightOperationPanel1Click(Sender: TObject);
begin
  RightOperationPanel1.Checked := not RightOperationPanel1.Checked;
  ShowHideRLPanel(RightOperationPanel1.Checked);
end;

procedure TMainOctopusDebuggingDevelopmentForm.SetModified(Value: Boolean);
begin
  if Value then
    StatusBar1.Panels[1].Text := sModified
  else
    StatusBar1.Panels[1].Text := WEB_SITE;
end;

procedure TMainOctopusDebuggingDevelopmentForm.UpdateStatus(Value: String);
begin
  StatusBar1.Panels[1].Text := Value;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SynchroSetMyRichEditFont(MyRichEdit: TMyRichEdit; Style: Integer);
begin
  if MyRichEdit = nil then
    exit;
  if Style = 1 then
  begin
    /// 控制台风格
    MyRichEdit.Color := SettingPagesDlg.ColorBoxContentBG.Selected;
    MyRichEdit.Font := SettingPagesDlg.FontDialogConsole.Font;
    FontDialog.Font := MyRichEdit.Font;
    MyRichEdit.Transparent := false;
    MyRichEdit.ParentColor := false;
  end
  else
  /// 文本编辑模式黑白默认
  begin
    MyRichEdit.Color := clWhite;
    if MyRichEdit.PlainText then // 纯文本应用全局字体
    begin
      /// FontDialog.Font.Color := clBlack;
      MyRichEdit.Font := FontDialog.Font;
    end;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SetMyRichEditFont(MyRichEdit: TMyRichEdit);
begin
  if MyRichEdit = nil then
    exit;
  if MyRichEdit.FStyle = 1 then
  begin
    /// 控制台风格
    MyRichEdit.Color := SettingPagesDlg.ColorBoxContentBG.Selected;
    MyRichEdit.Font := Self.FontDialog.Font;
    MyRichEdit.Transparent := false;
    MyRichEdit.ParentColor := false;
    SettingPagesDlg.FontDialogConsole.Font := MyRichEdit.Font;
    SettingPagesDlg.ColorBoxText.Selected := MyRichEdit.Font.Color;
  end
  else
  /// 文本编辑模式黑白默认
  begin
    MyRichEdit.Color := clWhite;
    if MyRichEdit.PlainText then // 纯文本应用全局字体
    begin
      /// FontDialog.Font.Color := clBlack;
      MyRichEdit.Font := FontDialog.Font;
    end;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SynchroFontDialog(MyRichEdit: TMyRichEdit; Style: Integer);
begin
  if MyRichEdit = nil then
    exit;
  if MyRichEdit.FStyle = 1 then
  begin
    /// 控制台风格
    Self.FontDialog.Font := MyRichEdit.Font;
  end
  else
  /// 文本编辑模式黑白默认
  begin
    Self.FontDialog.Font := MyRichEdit.Font;
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////
/// click event
procedure TMainOctopusDebuggingDevelopmentForm.SV_RClosed(Sender: TObject);
begin
  Splitter1.Visible := false;
  Splitter1.Align := alNone;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SV_ROpened(Sender: TObject);
begin
  Splitter1.Visible := True;
  Splitter1.Align := alRight;
end;

procedure TMainOctopusDebuggingDevelopmentForm.FormatToolBarMenuItem1Click(Sender: TObject);
begin
  StandardToolBar1.Visible := not StandardToolBar1.Visible;
  FormatToolBarMenuItem1.Checked := StandardToolBar1.Visible;
end;

procedure TMainOctopusDebuggingDevelopmentForm.FormatToolBarMenuItem2Click(Sender: TObject);
begin
  StandardToolBar2.Visible := not StandardToolBar2.Visible;
  FormatToolBarMenuItem2.Checked := StandardToolBar2.Visible;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ShowLinesNumberItemClick(Sender: TObject);
begin
  // if (CMyRichEdit <> nil) and (not CMyRichEdit.FShowLinesNumber) then
  // CMyRichEdit.ShowLinesNumber();
end;

procedure TMainOctopusDebuggingDevelopmentForm.MenuItem2Click(Sender: TObject);
begin
  if CMyRichEdit <> nil then
  begin
    CMyRichEdit.CopyToClipboard;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.MenuItem3Click(Sender: TObject);
begin
  if CMyRichEdit <> nil then
  begin
    CMyRichEdit.PasteFromClipboard;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.MenuItem4Click(Sender: TObject);
begin
  if CMyRichEdit <> nil then
  begin
    CMyRichEdit.SelectAll;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.MenuItem6Click(Sender: TObject);
begin
  if CMyRichEdit <> nil then
  begin
    CMyRichEdit.Clear;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.MenuItem7Click(Sender: TObject);
begin
  if CMyRichEdit <> nil then
  begin
    FileSaveAsItem.Click;
  end;

end;

procedure TMainOctopusDebuggingDevelopmentForm.Search1Click(Sender: TObject);
begin
  ShowSearchDialog();
end;

procedure TMainOctopusDebuggingDevelopmentForm.ScreenshotTool1Click(Sender: TObject);
begin
  WindowState := wsMinimized;
  Hide;
  sleep(100);
  ScreenshotFrm.MouseDownStart := True;
  ScreenshotFrm.MouseUpDone := True;
  ScreenshotFrm.CopyScreenToBmp(ScreenshotFrm.Image1);
  WindowState := wsNormal;

  if ScreenshotFrm.ShowModal = mrOk then
  begin
    if ScreenshotFrm.ScreenShotBitmap <> nil then
    begin
      ScreenMainFrm.Image1.Picture.Assign(ScreenshotFrm.ScreenShotBitmap);
      ScreenMainFrm.WindowState := wsNormal;
      // ScreenMainFrm.FilePath := FILE_DATA_ANN;
      // ScreenMainFrm.FileName := FStockDrawKLines.stock.GetLevelKey();
      Show();
      ScreenMainFrm.Show;
    end
    else
    begin
      Show();
    end;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ScreenshotTool2Click(Sender: TObject);
begin
  ScreenMainFrm.WindowState := wsNormal;
  ScreenMainFrm.Show();
end;

procedure TMainOctopusDebuggingDevelopmentForm.DataEncryption1Click(Sender: TObject);
begin
  DecryptEncryptFrm.Show();
end;

procedure TMainOctopusDebuggingDevelopmentForm.DefaultItemClick(Sender: TObject);
begin
  CMyRichEdit.LoadFrom(CMyRichEdit.FFileName, TEncoding.Default);
end;

procedure TMainOctopusDebuggingDevelopmentForm.DownloadUpdate1Click(Sender: TObject);
begin
  DownloaderFrm.ShowModal();
end;

procedure TMainOctopusDebuggingDevelopmentForm.ASCIIItemClick(Sender: TObject);
begin
  CMyRichEdit.LoadFrom(CMyRichEdit.FFileName, TEncoding.ASCII);
end;

procedure TMainOctopusDebuggingDevelopmentForm.ANSIItemClick(Sender: TObject);
begin
  CMyRichEdit.LoadFrom(CMyRichEdit.FFileName, TEncoding.ANSI);
end;

procedure TMainOctopusDebuggingDevelopmentForm.UTF7EncodingItemClick(Sender: TObject);
begin
  CMyRichEdit.LoadFrom(CMyRichEdit.FFileName, TEncoding.UTF7);
end;

procedure TMainOctopusDebuggingDevelopmentForm.UTF8EncodingItemClick(Sender: TObject);
begin
  CMyRichEdit.LoadFrom(CMyRichEdit.FFileName, TEncoding.UTF8);
end;

procedure TMainOctopusDebuggingDevelopmentForm.UnicodeEncodingItemClick(Sender: TObject);
begin
  CMyRichEdit.LoadFrom(CMyRichEdit.FFileName, TEncoding.Unicode);
end;

procedure TMainOctopusDebuggingDevelopmentForm.BigEndianUnicodeEncodingItemClick(Sender: TObject);
begin
  CMyRichEdit.LoadFrom(CMyRichEdit.FFileName, TEncoding.BigEndianUnicode);
end;

procedure TMainOctopusDebuggingDevelopmentForm.CRC1Click(Sender: TObject);
begin
  CRCFrm.Show();
end;

procedure TMainOctopusDebuggingDevelopmentForm.ProblemFeedback1Click(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_NOTOPMOST, Left, Top, Width, Height, 0);
  TopLevelMenuItem.Checked := false;
  SubmitProblemFrm.Show();
end;

procedure TMainOctopusDebuggingDevelopmentForm.QuickTerminalCommandsItemClick(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice();
  CommandFrm.OcComPortObj := OcComPortObj;
  CommandFrm.Show();
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button100Click(Sender: TObject);
var
  s, ss: String;
  b: array of byte;
  i: Integer;
begin
  s := Trim(Memo1.Text);
  i := Length(AnsiString(s));
  SetLength(b, i);
  WideStringToByte(s, b);
  ss := '';
  for i := 0 to Length(b) - 1 do
  begin
    ss := ss + Format('%.02x ', [b[i]]);
  end;
  Memo2.Lines.Add(ss);
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button101Click(Sender: TObject);
var
  str, s: String;
  buf: array [0 .. 1023] of byte;
begin
  str := Trim(Memo2.Text);
  s := '';
  s := FormatHexStr(Trim(str), buf);
  Memo1.Lines.Append(ByteToWideString(@buf, Length(buf)));
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button102Click(Sender: TObject);
begin
  Memo2.Clear;
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button103Click(Sender: TObject);
var
  buffer: array [0 .. 255] of byte;
  ss: String;
  OcComPortObj: TOcComPortObj;
  bLength: Integer;
  BytesWritten: Cardinal;
begin

  OcComPortObj := Self.GetCurrentDevice(); // GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if (OcComPortObj = nil) then
  begin
    /// Log0('No device is found,please open a device.');
    /// MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  if (not OcComPortObj.Connected) then
  begin
    /// Log0('No device is found,please open a device.');
    /// MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  ss := Trim(Memo2.Text);
  OcComPortObj.FalconComSendData_MultiTimes(ss, 0);
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button104Click(Sender: TObject);
var
  buffer: array [0 .. 255] of byte;
  ss: String;
  OcComPortObj: TOcComPortObj;
  bLength: Integer;
  BytesWritten: Cardinal;
begin

  OcComPortObj := Self.GetCurrentDevice(); // GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if (OcComPortObj = nil) then
  begin
    /// Log0('No device is found,please open a device.');
    /// MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  if (not OcComPortObj.Connected) then
  begin
    /// Log0('No device is found,please open a device.');
    /// MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  ss := Trim(Memo2.Text);
  OcComPortObj.FalconComSendData_MultiTimes(ss, 1);
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button105Click(Sender: TObject);
var
  i, bLength: Integer;
  buffer: array [0 .. 20000] of byte;
  ss: String;
begin
  ss := '';
  Memo2.Text := Trim(Memo2.Text);
  for i := 0 to Memo2.Lines.Count - 1 do
    ss := ss + Trim(Memo2.Lines.Strings[i]) + ' ';
  try
    // ss := FormatHexStrToByte(ss, buffer,bLength);
    ss := FormatHexStrToBuffer(ss, buffer, bLength);
  except
    showmessage('There are too many datas to fomat!!!!!!!!!!');
  end;

  Memo2.Text := ss;
  i := Pos('(', Button105.Caption);
  if i > 0 then
    Button105.Caption := Copy(Button105.Caption, 1, i - 1) + '( ' + IntToStr(bLength) + ' ) Bytes'
  else
    Button105.Caption := Button105.Caption + ' ( ' + IntToStr(bLength) + ' ) Bytes';
end;

procedure TMainOctopusDebuggingDevelopmentForm.Timer1Timer(Sender: TObject);
var
  sStr: string;
  i, j, Count, delayCount: Integer;
  OcComPortObj: TOcComPortObj;
begin

  if (OcComPortObj_Loop = nil) or (not OcComPortObj_Loop.Connected) then
    exit;
  Timer1.Tag := 1;
  Timer1.Enabled := false;
  Button200.Caption := 'Stop Looping';
  Button201.Caption := LoopingString + '...';
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    if Timer1.Tag = 0 then
      break;
    if Trim(StringGrid1.Cells[CHECKCOL, i]) = '1' then
    begin
      if Timer1.Tag = 0 then
        break;

      try
        sStr := GetStringGridValidStr(StringGrid1.Cells[2, i]);
        Count := StrToInt(Trim(StringGrid1.Cells[4, i]));
        delayCount := StrToInt(Trim(StringGrid1.Cells[5, i]));
        if Count = 0 then
        begin
          While (True) do
          begin
            OcComPortObj.FalconComSendData_MultiTimes(sStr, OcComPortObj.SendFormat);
            Delay(delayCount);
            if Timer1.Tag = 0 then
              break;
          end;
        end
        else
        begin
          for j := 0 to Count - 1 do
          begin
            OcComPortObj.FalconComSendData_MultiTimes(sStr, OcComPortObj.SendFormat);
            Delay(delayCount);
            if Timer1.Tag = 0 then
              break;
          end;
        end;

        Delay(delayCount);
      Except
        continue;
      end;
    end;

  end; // for

  if Timer1.Tag <> 0 then
  begin
    Button201.Caption := 'Looping... ' + IntToStr(Button201.Tag);
    Button201.Tag := Button201.Tag + 1;
    Timer1.Enabled := True;
  end
  else
  begin
    Button200.Caption := 'Loop Stopped';
    Button201.Caption := LoopingString;
    OcComPortObj_Loop := nil;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button200Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  Timer1.Tag := 0;
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button201Click(Sender: TObject);
var
  /// i: Integer;
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice(); // GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj = nil then
  begin
    exit;
  end;

  if not OcComPortObj.Connected then
  begin
    OcComPortObj.Log('No device was Connected,please open a device.');
    MessageBox(Application.Handle, 'No device was Connected,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    Timer1.Enabled := false;
    exit;
  end;

  if (Timer1.Tag >= 1) or (Timer1.Enabled) then
  begin
    MessageBox(Application.Handle, 'Looping, please stop it first��', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  LoopingString := Button201.Caption;
  if OcComPortObj.Connected then
  begin
    Timer1.Enabled := false;
    Button201.Tag := 0;

    OcComPortObj_Loop := OcComPortObj;
    Timer1.Enabled := True;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button300Click(Sender: TObject);
begin
  Memo3.Clear;
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button301Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
  str: String;
  Datas: array [0 .. 1023] of byte;
  Ret: Boolean;
  i, AdressCount, Count2, WantReadCount: Integer;
  ID: Word;
  Addressb: array [0 .. 9] of byte;
  rwCount: Integer;
  SL: TStringList;
begin
  OcComPortObj := Self.GetCurrentDevice();
  if (OcComPortObj = nil) then
  begin
    // Log0('No device is found,please open a device.');
    /// MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  if (not OcComPortObj.Connected) then
  begin
    // Log0('No device is found,please open a device.');
    /// MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  SL := TStringList.Create;
  // ExtractStrings([ ' '],   [],   PChar(str),   SL); ExtractStrings�����ָ��ַ���
  AdressCount := FormatHexStrToByte2(Trim(ComboBox302.Text), Addressb);
  WantReadCount := StrToInt(Trim(ComboBox303.Text));
  str := '';
  for i := 0 to Memo3.Lines.Count - 1 do
    str := str + Trim(Memo3.Lines.Strings[i]) + ' ';
  str := Trim(str);

  if str = '' then
    exit;
  case ComboBox301.ItemIndex of
    Ord(S_ASCIIFormat):
      begin
        WideStringToByte(str, Datas);
        Count2 := Length(str);
      end;
    Ord(S_HexadecimalFormat):
      begin
        if (AdressCount > 1) then
          str := FormatHexStrToBuffer(str, &Datas[1], Count2)
        else
          str := FormatHexStrToBuffer(str, Datas, Count2);
      end;
    Ord(S_OctopusProtocol):
      begin
        if not checkIsHexStr(str) then
        begin
          WideStringToByte(str, Datas);
          Count2 := Length(str);
        end
        else
        begin
          if (AdressCount > 1) then
            str := FormatHexStrToBuffer(str, &Datas[1], Count2)
          else
            str := FormatHexStrToBuffer(str, Datas, Count2);
        end;
      end;
  end;

  OcComPortObj.SendProtocolData(OCCOMPROTOCAL_HEAD2, OCCOMPROTOCAL_DATA, Datas, Count2, false);
  SL.Clear;
  SL.Free;
end;

procedure TMainOctopusDebuggingDevelopmentForm.Button302Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
  FileStream: TFileStream;
  FileNameLoaded: String;
begin

  OcComPortObj := Self.GetCurrentDevice();
  /// GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if OcComPortObj = nil then
  begin
    OcComPortObj.Log('No device is found,please open a device.');
    MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  if not OcComPortObj.Connected then
  begin
    OcComPortObj.Log('No device is found,please open a device.');
    MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  FileNameLoaded := 'Null';
  if OpenDialog1.Execute then
  begin
    FileNameLoaded := OpenDialog1.FileName;
    if FileExists(FileNameLoaded) then
    begin
      FileStream := readFileToStream(FileNameLoaded);
      OcComPortObj.Log(' ');
      OcComPortObj.Log('File Name: ' + FileNameLoaded);
      OcComPortObj.Log('File Size: ' + IntToStr(FileStream.Size) + ' Bytes');
      // OcComPortObj.Log('This file have been loaded,press the left-bottom button to start sending');
      if (FileStream.Size > 1024 * 1024 * 5) then
      begin
        OcComPortObj.Log('This file size is too biger,only support less then 5M size file.');
      end;
      FileStream.Free;
      FileStream := nil;
    end;
  end;

  if not FileExists(FileNameLoaded) then
  begin
    OcComPortObj.Log('Do not exist the file ' + FileNameLoaded);
    exit;
  end;

  ComboBox301.ItemIndex := 0;
  ComboBox2.ItemIndex := Ord(OctopusProtocol);
  ComboBox2.OnChange(Self);

  if IsHexFile(FileNameLoaded) then
  begin
    SendFileAsHex(OcComPortObj, FileNameLoaded);
  end
  else if IsBinFile(FileNameLoaded) then
  begin
    SendFileAsBin(OcComPortObj, FileNameLoaded);
  end
  else
  begin
    /// SendFileAsCommon(OcComPortObj);
  end;

  if (FileStream <> nil) then
  begin
    FileStream.Free;
  end;
  FileStream := nil;
end;

procedure TMainOctopusDebuggingDevelopmentForm.FindDialog1Close(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice();
  if OcComPortObj <> nil then
    OcComPortObj.LogScrollMode := True;
  Self.Show;
end;

procedure TMainOctopusDebuggingDevelopmentForm.FindDialog1Find(Sender: TObject);
var
  FindStr: String;
  OcComPortObj: TOcComPortObj;
  Memo: TMyRichEdit;
  bRet: Boolean;
Label ReStart;
begin
  OcComPortObj := Self.GetCurrentDevice();
  with Sender as TFindDialog do
  begin
    FindStr := FindText;
    if (OcComPortObj = nil) or (OcComPortObj.LogObject = nil) or (OcComPortObj.LogObject.Parent = nil) then
    begin
      Memo := Self.CMyRichEdit;
    end
    else
    begin
      Memo := OcComPortObj.LogObject;
    end;
    if Memo = nil then
      exit;
    if Memo.Parent = nil then
      exit;

  ReStart:
    bRet := SearchMemo(Memo, FindStr, Options);

    if bRet = false then
    begin
      if frDown in Options then
      begin
        if MessageBox(Handle, PWideChar(Concat('Not found "', FindStr, '" restart seach from the beginning of the file��')), PChar(Application.Title), MB_YESNO) = ID_YES then
        begin
          Memo.SelStart := 0;
          goto ReStart;
        end;
      end
      else
      begin
        if MessageBox(Handle, PWideChar(Concat('Not found "', FindStr, '" restart seach from the end of the file��       ')), PChar(Application.Title), MB_YESNO) = ID_YES then
        begin
          Memo.SelStart := Memo.GetTextLen;
          goto ReStart;
        end;
      end;
    end;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.FindDialog1Show(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice();
  if OcComPortObj = nil then
    exit;
  OcComPortObj.LogScrollMode := false;
end;

procedure TMainOctopusDebuggingDevelopmentForm.WelcomeAndHelp1Click(Sender: TObject);
var
  Types: Integer;
  str: String;
begin
  /// ShellExecute(Application.Handle, nil, 'http://1234998.cn', nil, nil, SW_SHOWNORMAL);
  /// if Self.WebBrowser = nil then
  /// begin
  CreateMyObjectPage('Welcome And Help', 1);
  /// end;

  if Self.WebBrowser <> nil then
  begin
    Types := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
    str := 'file:///' + ExtractFileDir(Application.Exename) + '\Octopus Software.html';
    if CheckUrl('http://www.baidu.com') then
    /// if internetGetConnectedState(@types,0) then
    begin
      str := ByteToWideString(@testbuff, Length(testbuff));
    end;
    Self.WebBrowser.Navigate(str); // (DEFAULT_WEBSITE_ADDRESS);
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.HelpAbout(Sender: TObject);
begin
  with TAboutBox.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.HelpMenuClick(Sender: TObject);
begin
  case SettingPagesDlg.ComboBox8.ItemIndex of
    0:
      begin
        EnglishMenuItem.Checked := True;
        ChineseMenuItem.Checked := false;
      end;
    1:
      begin
        ChineseMenuItem.Checked := True;
        EnglishMenuItem.Checked := false;
      end;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.HexModeItemClick(Sender: TObject);
/// var
/// OcComPortObj: TOcComPortObj;
begin
  /// OcComPortObj := Self.GetCurrentDevice();
  if CMyRichEdit <> nil then
  begin
    HexModeItem.Checked := not HexModeItem.Checked;
    CMyRichEdit.SetHexadecimalMode(HexModeItem.Checked);
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.Encoding1Click(Sender: TObject);
begin
  DefaultItem.Checked := false;
  ASCIIItem.Checked := false;
  ANSIItem.Checked := false;
  UTF7EncodingItem.Checked := false;
  UTF8EncodingItem.Checked := false;
  UnicodeEncodingItem.Checked := false;
  BigEndianUnicodeEncodingItem.Checked := false;
  if CMyRichEdit <> nil then
  begin
    if CMyRichEdit.Lines.Encoding = TEncoding.Default then
      DefaultItem.Checked := True
    else if CMyRichEdit.Lines.Encoding = TEncoding.ASCII then
      ASCIIItem.Checked := True
    else if CMyRichEdit.Lines.Encoding = TEncoding.ANSI then
      ANSIItem.Checked := True
    else if CMyRichEdit.Lines.Encoding = TEncoding.UTF7 then
      UTF7EncodingItem.Checked := True
    else if CMyRichEdit.Lines.Encoding = TEncoding.UTF8 then
      UTF8EncodingItem.Checked := True
    else if CMyRichEdit.Lines.Encoding = TEncoding.Unicode then
      UnicodeEncodingItem.Checked := True
    else if CMyRichEdit.Lines.Encoding = TEncoding.BigEndianUnicode then
      BigEndianUnicodeEncodingItem.Checked := True
    else
      DefaultItem.Checked := True;
  end
  else
    DefaultItem.Checked := True;
end;

procedure TMainOctopusDebuggingDevelopmentForm.EnglishMenuItemClick(Sender: TObject);
begin
  SettingPagesDlg.LoadLaunguageFromFile(Self, SettingPagesDlg.OctopusCfgDir + CONFIGURATION_DIR + 'Lang_EN.ini', false);
  SettingPagesDlg.ComboBox8.ItemIndex := 0;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ChineseMenuItemClick(Sender: TObject);
begin
  SettingPagesDlg.LoadLaunguageFromFile(Self, SettingPagesDlg.OctopusCfgDir + CONFIGURATION_DIR + 'Lang_CN.ini', false);
  SettingPagesDlg.ComboBox8.ItemIndex := 1;
end;

procedure TMainOctopusDebuggingDevelopmentForm.CloseTheDevice1Click(Sender: TObject);
begin
  ToolButton13.Click;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ViewMenuClick(Sender: TObject);
begin
  UpdateMainMenu();
end;

procedure TMainOctopusDebuggingDevelopmentForm.LptatpMenuItemClick(Sender: TObject);
begin
  Self.PageControl1.TabPosition := tpTop;
end;

procedure TMainOctopusDebuggingDevelopmentForm.LptabpMenuItemClick(Sender: TObject);
begin
  Self.PageControl1.TabPosition := tpBottom;
end;

procedure TMainOctopusDebuggingDevelopmentForm.LptalpMenuItemClick(Sender: TObject);
begin
  Self.PageControl1.TabPosition := tpLeft;
end;

procedure TMainOctopusDebuggingDevelopmentForm.RptatpMenuItemClick(Sender: TObject);
begin
  Self.PageControl2.TabPosition := tpTop;
end;

procedure TMainOctopusDebuggingDevelopmentForm.RptarpMenuItemClick(Sender: TObject);
begin
  Self.PageControl2.TabPosition := tpRight;
end;

procedure TMainOctopusDebuggingDevelopmentForm.RptabpMenuItemClick(Sender: TObject);
begin
  Self.PageControl2.TabPosition := tpBottom;
end;

procedure TMainOctopusDebuggingDevelopmentForm.TopLevelMenuItemClick(Sender: TObject);
begin
  TopLevelMenuItem.Checked := not TopLevelMenuItem.Checked;
  if TopLevelMenuItem.Checked then
  begin
    SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, 0);
  end
  else
  begin
    SetWindowPos(Handle, HWND_NOTOPMOST, Left, Top, Width, Height, 0);
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SettingItem1Click(Sender: TObject);
begin
  SettingPagesDlg.CheckBox35.Checked := ShowLinesNumberItem.Checked;
  /// SettingPagesDlg.ShowModal();
  SettingPagesDlg.Show();
  InitUartsParameters();
  UpdateUartToolBar();
  AlphaBlend := SettingPagesDlg.AlphaBlend;
  AlphaBlendValue := SettingPagesDlg.AlphaBlendValue;

  CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  SynchroSetMyRichEditFont(CMyRichEdit, CMyRichEdit.FStyle);
end;

procedure TMainOctopusDebuggingDevelopmentForm.SettingItem2Click(Sender: TObject);
begin
  SettingItem1.Click;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SkinsMenuClick(Sender: TObject);
var
  i: Integer;
begin
  if FThemeSkinName <> '' then
  begin
    for i := 0 to SkinsMenu.Count - 1 do
    begin
      if GetStyle(i) = FThemeSkinName then
        SkinsMenu.Items[i].Checked := True
      else
        SkinsMenu.Items[i].Checked := false;
    end;
  end
  else if Self.SkinMenuItem <> nil then
  begin
    for i := 0 to SkinsMenu.Count - 1 do
    begin
      if SkinsMenu.Items[i] = Self.SkinMenuItem then
        SkinsMenu.Items[i].Checked := True
      else
        SkinsMenu.Items[i].Checked := false;
    end;
  end
  else
  begin
    SkinsMenu.Items[0].Checked := True;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ToggleSwitchDeviceOnOffClick(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice();
  if OcComPortObj <> nil then
  begin
    if ToggleSwitchDeviceOnOff.IsOn then
    begin
      ComboBox1.OnChange(Self);
      ComboBox2.OnChange(Self);
      SettingPagesDlg.openDevice(OcComPortObj);
      ToggleSwitchDeviceOnOff.ThumbColor := clRed;
    end
    else
    begin
      SettingPagesDlg.closeDevice(OcComPortObj);
      ToggleSwitchDeviceOnOff.ThumbColor := clWindowText;
    end;

    if OcComPortObj.Connected then
    begin
      ToggleSwitchDeviceOnOff.State := tssOn;
      ToggleSwitchDeviceOnOff.ThumbColor := clRed;
    end
    else
    begin
      ToggleSwitchDeviceOnOff.State := tssOff;
      ToggleSwitchDeviceOnOff.ThumbColor := clWindowText;
    end;
  end
  else
  begin
    ToggleSwitchDeviceOnOff.State := tssOff;
    ToggleSwitchDeviceOnOff.ThumbColor := clWindowText;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.Splitter1Moved(Sender: TObject);
begin
  AdjustUI();
end;

procedure TMainOctopusDebuggingDevelopmentForm.COM1MenuItemOnClick(Sender: TObject);
var
  PageName: String;
begin
  GetAndOpenADevices(SettingPagesDlg.getDeciceByIndex((TMenuItem(Sender)).Tag));
end;

procedure TMainOctopusDebuggingDevelopmentForm.ComboBox1Change(Sender: TObject);
var
  str: String;
  btl: Integer;
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice();
  /// GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if OcComPortObj = nil then
  begin
    /// MessageBox(Handle, 'Please specify a device for custom baudrate.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  if (ComboBox1.ItemIndex <= MAX_BAUDRATE_INDEX) then // High(TBaudRate))
  begin
    OcComPortObj.BaudRate := TBaudRate(ComboBox1.ItemIndex);
    // OcComPortObj.BaudRateIndex := ComboBox1.ItemIndex;
  end
  else
  begin
    OcComPortObj.BaudRate := TBaudRate(0);
    OcComPortObj.CustomBaudRate := StrToInt(ComboBox1.Text);
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ComboBox2Change(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice();
  if OcComPortObj = nil then
    exit;
  /// if (ComboBox2.ItemIndex = Ord(Graphic)) then
  /// OcComPortObj.FastLineSeries := self.CharInitSeries(True);
  OcComPortObj.ReceiveFormat := ComboBox2.ItemIndex;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ConverttoAnsi1Click(Sender: TObject);
begin
  if CMyRichEdit <> nil then
  begin
    CMyRichEdit.ConvertEncoding(TEncoding.ANSI);
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ConverttoUTF81Click(Sender: TObject);
begin
  if CMyRichEdit <> nil then
  begin
    CMyRichEdit.ConvertEncoding(TEncoding.UTF8);
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ConverttoUTF82Click(Sender: TObject);
begin
  if CMyRichEdit <> nil then
  begin
    CMyRichEdit.ConvertToUTF8WithBOM();
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ToolButton12Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice();
  if OcComPortObj <> nil then
  begin
    OcComPortObj.ClearLog();
    OcComPortObj.ClearInternalBuff();
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ToolButton13Click(Sender: TObject);
begin
  GetAndRemoveDevices(Self.GetCurrentPageName());
  UpdateUartToolBar();
end;

procedure TMainOctopusDebuggingDevelopmentForm.ToolButton16Click(Sender: TObject);
begin
  SettingItem1.Click;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ToolButton19Click(Sender: TObject);
begin

end;

/// ///////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////
/// init
procedure TMainOctopusDebuggingDevelopmentForm.InitMainUI();
begin
  ToggleSwitchDeviceOnOff.Height := 25;
  StandardToolBar2.Height := 33;
  Application.Title := OCTOPUS_APPLICATION_TITLE_NAME;
  Self.Caption := OCTOPUS_APPLICATION_TITLE_NAME;
  Self.Icon := Application.Icon;
  Application.OnHint := ShowHint;

  if SettingPagesDlg = nil then
  begin
    SettingPagesDlg := TSettingPagesDlg.Create(nil);
    SettingPagesDlg.SettingChangedCallBackFuntion := Self.SettingChangedCallBackFuntion;
  end;
  Self.Caption := OCTOPUS_APPLICATION_TITLE_NAME + ' (' + SettingPagesDlg.VersionNumberStr + ')';

  CMyRichEdit := PageControl1.GetEdit(PageControl1.ActivePageIndex);
  FileOpenCmd.Dialog.InitialDir := ExtractFilePath(ParamStr(0));
  FileSaveAsCmd.Dialog.InitialDir := FileOpenCmd.Dialog.InitialDir;
  FVersionNumberStr := GetBuildInfo(Application.Exename);
  // SetFileName(sUntitled);
  GetFontNames;
  SelectionChange(Self);
  UpdateMainMenu();
  AdjustUI();

end;

procedure TMainOctopusDebuggingDevelopmentForm.UpdateMainMenu();
begin
  FormatToolBarMenuItem1.Checked := StandardToolBar1.Visible;
  FormatToolBarMenuItem2.Checked := StandardToolBar2.Visible;
  RightOperationPanel1.Checked := Self.SV_R.Opened;

  RptatpMenuItem.Checked := false;
  RptabpMenuItem.Checked := false;
  RptarpMenuItem.Checked := false;
  LptatpMenuItem.Checked := false;
  LptabpMenuItem.Checked := false;
  LptalpMenuItem.Checked := false;

  if Self.PageControl1.TabPosition = tpTop then
    LptatpMenuItem.Checked := True;
  if Self.PageControl1.TabPosition = tpBottom then
    LptabpMenuItem.Checked := True;
  if Self.PageControl1.TabPosition = tpLeft then
    LptalpMenuItem.Checked := True;

  if Self.PageControl2.TabPosition = tpTop then
    RptatpMenuItem.Checked := True;
  if Self.PageControl2.TabPosition = tpBottom then
    RptabpMenuItem.Checked := True;
  if Self.PageControl2.TabPosition = tpRight then
    RptarpMenuItem.Checked := True;

  if (CMyRichEdit <> nil) then
    ShowLinesNumberItem.Checked := CMyRichEdit.FShowLinesNumber;
end;

procedure TMainOctopusDebuggingDevelopmentForm.AdjustUI();
begin
  Button100.Width := Memo1.Width;
  Button101.Width := Button100.Width;

  Button104.Width := Button100.Width - Button102.Width - Button103.Width - 4;
  Button105.Width := Button100.Width;

  Button201.Width := Panel201.Width - Button200.Width - 4;

  ComboBox301.Width := Memo3.Width - 74;
  ComboBox302.Width := ComboBox301.Width;
  ComboBox303.Width := ComboBox301.Width;
  ComboBox304.Width := ComboBox301.Width;

  Button302.Width := Memo3.Width;
  Button301.Width := Button302.Width - Button300.Width - 2;
end;

procedure TMainOctopusDebuggingDevelopmentForm.InitUserConfiguration();
begin
  if (CMyRichEdit <> nil) then
  begin
    /// CurrText.Name := string(DefFontData.Name);
    /// CurrText.Size := -MulDiv(DefFontData.Height, 72, Screen.PixelsPerInch);
    /// CurrText.Name := FontDialog.Font.Name;
    /// CurrText.Size := FontDialog.Font.Size;
    RichEditTransparentItem.Checked := CMyRichEdit.Transparent;
    RichEditWordWrapItem.Checked := CMyRichEdit.ScrollBars = ssVertical;
    CMyRichEdit.WordWrap := RichEditWordWrapItem.Checked;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.UpdateUartToolBar();
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice();
  if OcComPortObj <> nil then
  begin
    if Ord(OcComPortObj.BaudRate) = 0 then
    begin
      Self.ComboBox1.ItemIndex := Self.ComboBox1.Items.IndexOf(IntToStr(OcComPortObj.CustomBaudRate));
    end
    else
    begin
      Self.ComboBox1.ItemIndex := Ord(OcComPortObj.BaudRate);
    end;
    Self.ComboBox2.ItemIndex := Ord(OcComPortObj.ReceiveFormat);
    if OcComPortObj.Connected then
    begin
      ToggleSwitchDeviceOnOff.State := tssOn;
      ToggleSwitchDeviceOnOff.ThumbColor := clRed;
    end
    else
    begin
      ToggleSwitchDeviceOnOff.State := tssOff;
      ToggleSwitchDeviceOnOff.ThumbColor := clWindowText;
    end;
  end
  else
  begin
    ToggleSwitchDeviceOnOff.State := tssOff;
    ToggleSwitchDeviceOnOff.ThumbColor := clWindowText;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.InitSkinsMenu(ParentMenu: TMenuItem; OnClicEvent: TOnClicEvent);
var
  i: Integer;
  MenuItem: TMenuItem;
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

procedure TMainOctopusDebuggingDevelopmentForm.SkinsMenuOnClick(Sender: TObject);
var
  str: String;
begin;
  // TStyleManager.SetStyle(TMenuItem(Sender).Caption);
  str := GetStyle(TMenuItem(Sender).Tag);
  if str <> '' then
  begin
    // for i := Low(TStyleManager.StyleNames) to High(TStyleManager.StyleNames) do
    SkinMenuItem := TMenuItem(Sender);
    FThemeSkinName := str;
    AdjustSetStyle(str);
    TMenuItem(Sender).Checked := True;
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// StringGridL
function TMainOctopusDebuggingDevelopmentForm.GetStringGridValidStr(sStr: String): String;
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

procedure TMainOctopusDebuggingDevelopmentForm.InitStringGrid();
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
  StringGrid1.DefaultRowHeight := 28;
  StringGrid1.ColCount := 6;
  StringGrid1.ColWidths[0] := 50;
  StringGrid1.ColWidths[1] := 50;
  StringGrid1.ColWidths[2] := 300;
  StringGrid1.ColWidths[3] := 32;
  StringGrid1.ColWidths[4] := 40;
  StringGrid1.ColWidths[5] := 40;
  StringGrid1.FixedCols := 2;
  StringGrid1.FixedRows := 1;

  StringGrid1.Cells[0, 0] := 'TEXT';
  StringGrid1.Cells[1, 0] := 'BYTE';
  StringGrid1.Cells[2, 0] := 'CONTENT FOR SENDING';

  StringGrid1.Cells[4, 0] := 'LOOP';
  StringGrid1.Cells[5, 0] := 'MS';
  /// StringGrid1.Cells[6, 0] := 'Comments';
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

procedure TMainOctopusDebuggingDevelopmentForm.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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

procedure TMainOctopusDebuggingDevelopmentForm.StringGrid1FixedCellClick(Sender: TObject; ACol, ARow: Integer);
var
  str: String;
  OcComPortObj: TOcComPortObj;
begin
  if ARow <= 0 then
  begin
    // if ACol = 0 then
    // MessageBox(Application.Handle, PChar('��һ�з����ַ���'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    // if ACol = 1 then
    // MessageBox(Application.Handle, PChar('��һ�з����ֽڣ�ʮ�����ƣ�'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  StringGrid1.Options := StringGrid1.Options - [goEditing];
  OcComPortObj := Self.GetCurrentDevice();
  if OcComPortObj = nil then
  begin
    /// MessageBox(Application.Handle, PChar('No device!! You need to open a device,please use F1 to get help'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  if not OcComPortObj.Connected then
  begin
    /// MessageBox(Application.Handle, PChar('No device!! You need to open a device,please use F1 to get help'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
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

procedure TMainOctopusDebuggingDevelopmentForm.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (StringGrid1.Col = 4) or (StringGrid1.Col = 5) then
  begin
    if not(Key in ['0' .. '9', #8]) then
      Key := #0;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  StringGrid1_Col, StringGrid1_Row: Integer;
begin
  StringGrid1.MouseToCell(X, Y, StringGrid1_Col, StringGrid1_Row);
  if (StringGrid1_Col = CHECKCOL) OR (StringGrid1_Col = 1) OR (StringGrid1_Col = 0) then
    StringGridSelectCell(StringGrid1_Col, StringGrid1_Row);

  if StringGrid1_Col = DATACOL then
    StringGrid1.Col := DATACOL;
end;

procedure TMainOctopusDebuggingDevelopmentForm.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  StringGrid1_Col, StringGrid1_Row: Integer;
begin
  StringGrid1.MouseToCell(X, Y, StringGrid1_Col, StringGrid1_Row);
  if StringGrid1_Col = DATACOL then
    StringGrid1.Col := DATACOL;
end;

procedure TMainOctopusDebuggingDevelopmentForm.StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if StringGrid1.Col <> 2 then
    StringGrid1.Col := 2;
  // Handled:=true;
end;

procedure TMainOctopusDebuggingDevelopmentForm.StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if StringGrid1.Col <> 2 then
    StringGrid1.Col := 2;
end;

procedure TMainOctopusDebuggingDevelopmentForm.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  // StringGrid1.MouseToCell(X, Y, StringGrid1_Col, StringGrid1_Row);
  with StringGrid1 do
  begin
    if ACol = CHECKCOL then
    begin
      Options := Options - [goEditing];
      Options := Options + [goRowSelect];
      CanSelect := false;
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

procedure TMainOctopusDebuggingDevelopmentForm.StringGridSelectCell(ACol, ARow: Integer);
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

procedure TMainOctopusDebuggingDevelopmentForm.StringGridSave();
var
  Octopusini: TIniFile;
  s: String;
  i: Integer;
begin
  s := SettingPagesDlg.OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
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

procedure TMainOctopusDebuggingDevelopmentForm.StringGridLoad();
var
  Octopusini: TIniFile;
  s: String;
  i: Integer;
begin
  s := SettingPagesDlg.OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
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
/// uart
procedure TMainOctopusDebuggingDevelopmentForm.InitUartsParameters();
/// var
/// i: Integer;
begin
  // Self.ComboBoxEx1.Images := SettingPagesDlg.ComboBoxEx1.Images;
  // Self.ComboBoxEx1.Items := SettingPagesDlg.ComboBoxEx1.Items;

  Self.ComboBox1.Items := SettingPagesDlg.ComboBox1.Items;
  /// Self.ComboBox1.Items.Delete(0); // ɾ���Զ��岨����
  Self.ComboBox2.Items := SettingPagesDlg.ComboBox7.Items;
end;

procedure TMainOctopusDebuggingDevelopmentForm.InitUartsMenu(ParentMenu: TMenuItem; OnClicEvent: TOnClicEvent);
var
  i: Integer;
  MenuItem: TMenuItem;
  OcComPortObj: TOcComPortObj;
begin
  ParentMenu.Clear;
  /// ToolbarImages.ad
  for i := 0 to SettingPagesDlg.ComboBoxEx1.Items.Count - 1 do
  begin
    MenuItem := TMenuItem.Create(nil);
    OcComPortObj := SettingPagesDlg.getDeciceByIndex(i);
    if OcComPortObj <> nil then
    begin
      MenuItem.Caption := OcComPortObj.ComportFullName;
      MenuItem.Tag := i;
      ParentMenu.Add(MenuItem);
      MenuItem.OnClick := OnClicEvent;
    end;
  end;
end;

/// function TMainForm.GetSelectedDeviceName(): String;
/// begin
/// Result := '';
/// if (ComboBoxEx1.Items.Count > 0) and (ComboBoxEx1.ItemIndex >= 0) then
/// Result := ComboBoxEx1.Items[ComboBoxEx1.ItemIndex];
/// end;

function TMainOctopusDebuggingDevelopmentForm.GetCurrentPageName(): String;
begin
  if Self.PageControl1.PageCount > 0 then
    Result := Self.PageControl1.GetActivePageName
  else
    Result := '';
end;

function TMainOctopusDebuggingDevelopmentForm.GetCurrentDevice(): TOcComPortObj;
var
  OcComPortObj: TOcComPortObj;
  ActivePageName: String;
begin
  ActivePageName := GetCurrentPageName();
  OcComPortObj := SettingPagesDlg.GetDeciceByFullName(ActivePageName);
  Result := OcComPortObj;
end;

procedure TMainOctopusDebuggingDevelopmentForm.GetAndRemoveDevices(DeviceName: String);
var
  OcComPortObj: TOcComPortObj;
  ActivePageIndex: Integer;
begin
  OcComPortObj := SettingPagesDlg.GetDeciceByFullName(DeviceName);
  if OcComPortObj <> nil then
  begin
    SettingPagesDlg.closeDevice(DeviceName);
  end;
  ActivePageIndex := PageControl1.ActivePageIndex;
  PageControl1.DeletePage(DeviceName);
  ActivePageIndex := Max(0, PageControl1.PageCount - 1);
  PageControl1.ActivePageIndex := ActivePageIndex;
  CMyRichEdit := nil;
end;

procedure TMainOctopusDebuggingDevelopmentForm.GetAndOpenADevices(DeviceName: String);
var
  OcComPortObj: TOcComPortObj;
  PageIndex: Integer;
begin
  OcComPortObj := SettingPagesDlg.GetDeciceByFullName(DeviceName);
  if OcComPortObj = nil then
    exit;
  GetAndOpenADevices(OcComPortObj);
end;

procedure TMainOctopusDebuggingDevelopmentForm.GetAndOpenADevices(OcComPortObj: TOcComPortObj);
var
  PageIndex: Integer;
  MyRichEdit: TMyRichEdit;
begin
  if OcComPortObj = nil then
    exit;
  CreateMyObjectPage(OcComPortObj.ComportFullName, 0);
  MyRichEdit := PageControl1.GetEdit(OcComPortObj.ComportFullName);
  MyRichEdit.FStyle := 1;
  OcComPortObj.SetLogComponent(MyRichEdit);
  OcComPortObj.SetMsgCallbackFunction(OcComPortObjCallBack);
  OcComPortObj.SetCacheComponent(Self);
  OcComPortObj.SaveLog(SettingPagesDlg.OctopusCfgDir_LogFilePath);
  SynchroSetMyRichEditFont(MyRichEdit, MyRichEdit.FStyle);
  if not OcComPortObj.Connected then
  begin
    SettingPagesDlg.openDevice(OcComPortObj);
    Self.UpdateUartToolBar();
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.CreateMyObjectPage(PageName: String; PageType: Integer);
var
  MyRichEdit: TMyRichEdit;
  PageIndex: Integer;
begin
  PageControl1.CreatePage(PageName, PageType);
  PageIndex := PageControl1.GetPageIndex(PageName);
  PageControl1.ActivePageIndex := PageIndex;
  if PageType = 0 then
  begin
    MyRichEdit := PageControl1.GetEdit(PageName);
    if MyRichEdit <> nil then
    begin
      MyRichEdit.OnClick := Self.RichEditorClick;
      MyRichEdit.OnLinkClick := Self.RichEditorLinkClick;
      MyRichEdit.PopupMenu := Self.PopupMenu1;
      MyRichEdit.PlainText := false;
      MyRichEdit.ParentFont := false;
      MyRichEdit.SpellChecking := True;
      /// 这个属性只在Memo、RichEdit和DBMemo组件中使用。通常在切换当前焦点控件时，我们通常使用Tab键。
      /// 但在上述三种组件中，编辑文本时常用Tab键来跳过若干个空格使文本对齐，这时就会有冲突。
      /// 所以应将WantTabs设置为True，这样子在组件内就可以使用Tab键来编辑文本。
      MyRichEdit.WantTabs := True;
      /// 需要回车键，否则无法回车换行
      MyRichEdit.WantReturns := True;
      /// 用于设定Momo组件是否具有自动折行功能。
      MyRichEdit.WordWrap := false;

      MyRichEdit.OnChange := nil;
      MyRichEdit.OnSelectionChange := Self.SelectionChange;
    end;
  end;
  if (PageType = 1) and (WebBrowser = nil) then
  begin
    WebBrowser := PageControl1.GetWebBrowser(PageName);
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.InitAllUartDevices();
var
  i: Integer;
  OcComPortObj: TOcComPortObj;
  MyRichEdit: TMyRichEdit;
begin
  WelcomeAndHelp1.Click;
  if ParamStr(1) <> '' then
    exit;
  /// 外部参数启动，作为文本编辑器器使用，不需要打开端口

  for i := 0 to SettingPagesDlg.ComboBoxEx1.Items.Count - 1 do
  begin
    OcComPortObj := SettingPagesDlg.getDeciceByIndex(i);
    if OcComPortObj = nil then
      exit;
    CreateMyObjectPage(OcComPortObj.ComportFullName, 0);
    MyRichEdit := PageControl1.GetEdit(OcComPortObj.ComportFullName);
    MyRichEdit.FStyle := 1;
    OcComPortObj.SetLogComponent(MyRichEdit);
    OcComPortObj.SetMsgCallbackFunction(OcComPortObjCallBack);
    OcComPortObj.SetCacheComponent(Self);

    ShowStartComments(OcComPortObj);
    SynchroSetMyRichEditFont(MyRichEdit, MyRichEdit.FStyle);

    OcComPortObj.SaveLog(SettingPagesDlg.OctopusCfgDir_LogFilePath);
    if i >= 5 then
      break;
  end;

end;

/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// uart call back
procedure TMainOctopusDebuggingDevelopmentForm.OcComPortObjCallBack(Count: Integer);
begin
  StatusBarPrintFileSize();
end;

Procedure TMainOctopusDebuggingDevelopmentForm.SettingChangedCallBackFuntion(Obj: TObject);
begin
  UpdateUartToolBar();
end;

procedure TMainOctopusDebuggingDevelopmentForm.EventCallBackFuntion(Obj: TObject);
begin
  try
    StatusBar1.Panels[1].Text := 'error!';
    TMyRichEdit(Obj).Font := FontDialog.Font;
    TMyRichEdit(Obj).SelStart := MaxInt;
  finally
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.StatusBar1DrawProgress(progress: Integer; progressMax: Integer);
begin
  StatusBar1.Panels[1].Style := psOwnerDraw;
  Self.Fprogress := progress;
  Self.FprogressMax := progressMax;
  StatusBar1.Repaint;
end;

procedure TMainOctopusDebuggingDevelopmentForm.StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
  str: String;
begin
  try
    if (Panel.Index = 1) and (Fprogress = 0) and (FprogressMax = 0) then
    begin
      str := 'http://www.1234998.top';
      with StatusBar1.Canvas do
      begin
        Brush.Color := clMenuBar;
        Font.Color := clBlack;
        Rectangle(Rect.Left, Rect.Top, Rect.Width, Rect.Height);
        TextOut(Rect.Left, Rect.Top, str);
        // TextOut(Rect.TopLeft.X+3,Rect.TopLeft.Y, str);
      end;
      exit;
    end;
    if (Panel.Index = 1) and (Fprogress >= 0) and (FprogressMax > 0) and (Fprogress <= FprogressMax) then
    begin
      str := IntToStr(Floor(Fprogress / FprogressMax * 100)) + '%';
      with StatusBar1.Canvas do
      begin
        Brush.Color := $00641F04;
        Font.Color := clWhite;
        X := Floor((Rect.Right - Rect.Left) * Fprogress / FprogressMax);
        Rectangle(Rect.Left, Rect.Top, Rect.Left + X, Rect.Bottom - 1);
        TextOut(Rect.Left + X - TextWidth(str) - 1, Rect.Top, str);
        // TextOut(Rect.TopLeft.X+3,Rect.TopLeft.Y, str);
      end;
    end;
  Except
    showmessage('unknow error!');
  end;

end;

procedure TMainOctopusDebuggingDevelopmentForm.StatusBarPrintFileSize();
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice();
  if (OcComPortObj = nil) then
    exit;
  StatusBar1.Panels.BeginUpdate;
  if (OcComPortObj.LogObject <> nil) then
  /// and (OcComPortObj.Connected)
  begin

    StatusBar1.Panels.Items[2].Text := OcComPortObj.Port + ' | Sent: ' + IntToStr(OcComPortObj.ComSentCount) + ' Bytes' + ' | Received: ' + IntToStr(OcComPortObj.ComReceiveCount) + ' Bytes' +
      ' | Processed: ' + IntToStr(OcComPortObj.ComProcessedCount) + ' Bytes' + ' | Total: ' + IntToStr(Length(OcComPortObj.LogObject.Text)) + ' Bytes' + ' | Line: ' +
      IntToStr(OcComPortObj.LogObject.CaretPos.Y) + ' | Lines: ' + IntToStr(OcComPortObj.LogObject.Lines.Count) + ' | Packs: ' + IntToStr(OcComPortObj.GetPacks);

    // StatusBar1.Panels.EndUpdate;
  end
  else
  begin
    /// StatusBar1.Panels.Items[2].Text := OcComPortObj.Port + ' | Sent: ' + IntToStr(OcComPortObj.ComSentCount) + ' Bytes | ' + 'Received: ' + IntToStr(OcComPortObj.ComReceiveCount) + ' Bytes | ' +
    /// 'Processed: ' + IntToStr(OcComPortObj.ComProcessedCount) + ' Bytes | ' + 'Total: ' + IntToStr(Length(Memo1.Text)) + ' Bytes | ' + 'Line: ' + IntToStr(Memo1.CaretPos.Y) + ' | ' + 'Lines: ' +
    /// IntToStr(Memo1.Lines.Count) + ' | Packs: ' + IntToStr(OcComPortObj.GetPacks);
  end;
  StatusBar1.Panels.EndUpdate;
  /// StatusBar1.Update;
  /// Application.ProcessMessages;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ShowStartComments(OcComPortObj: TOcComPortObj);
begin
  OcComPortObj.DebugLog('#################################################################');
  // OcComPortObj.DebugLog(APPLICATION_TITLE + FVersionNumberStr);
  OcComPortObj.DebugLog('Octopus Serial Port Debugging And Development Assistant ' + FVersionNumberStr);
  OcComPortObj.DebugLog('Home Page: ' + WEB_SITE + ' ');
  // OcComPortObj.DebugLog('Function  :' + 'ESC��F1��F2��F3');
  OcComPortObj.DebugLog('#################################################################');
  OcComPortObj.DebugLog('' + OcComPortObj.ComportFullName + ' ');
end;

procedure TMainOctopusDebuggingDevelopmentForm.SaveProjectSetting(SavePrivate: Boolean);
var
  Octopusini: TIniFile;
  s: String;
  i: Integer;
  str: String;
begin
  try
    if not DirectoryExists(SettingPagesDlg.OctopusCfgDir) then
      CreateDir(SettingPagesDlg.OctopusCfgDir);
    if not DirectoryExists(SettingPagesDlg.OctopusCfgDir + CONFIGURATION_DIR) then
      CreateDir(SettingPagesDlg.OctopusCfgDir + CONFIGURATION_DIR);

    if SavePrivate then
    begin
      s := SettingPagesDlg.OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';

      Octopusini := TIniFile.Create(s);
      for i := 1 to StringGrid1.RowCount - 1 do
      begin
        Octopusini.WriteString('MyCustData', IntToStr(i) + '_2', StringGrid1.Cells[2, i]);
        /// Octopusini.WriteString('MyCustData', IntToStr(i) + '_6', StringGrid1.Cells[6, i]);
      end;

      if SkinMenuItem <> nil then
        str := GetStyle(TMenuItem(SkinMenuItem).Tag)
      else
        str := TStyleManager.StyleNames[0];

      Octopusini.WriteBool('MyPreference', 'CHINESEUI', ChineseMenuItem.Checked);
      Octopusini.WriteBool('MyPreference', 'ALPHABLEND', Self.AlphaBlend);
      Octopusini.WriteBool('MyPreference', 'SVR_OPEN', SV_R.Opened);
      Octopusini.WriteInteger('MyPreference', 'SVR_WIDTH', SV_R.Width);

      Octopusini.WriteString('MyPreference', 'MAINUIFONTNAME', MainOctopusDebuggingDevelopmentForm.Font.Name);
      Octopusini.WriteInteger('MyPreference', 'MAINUIFONTSIZE', MainOctopusDebuggingDevelopmentForm.Font.Size);
      Octopusini.WriteInteger('MyPreference', 'MAINUIFONTCOLOR', MainOctopusDebuggingDevelopmentForm.Font.Color);

      Octopusini.WriteBool('MyPreference', 'StandardToolBar1', StandardToolBar1.Visible);
      Octopusini.WriteBool('MyPreference', 'StandardToolBar2', StandardToolBar2.Visible);
      Octopusini.WriteInteger('MyPreference', 'PageControl1', Ord(Self.PageControl1.TabPosition));
      Octopusini.WriteInteger('MyPreference', 'PageControl2', Ord(Self.PageControl2.TabPosition));
      Octopusini.WriteInteger('MyPreference', 'PageControl2ActivePageIndex', Ord(Self.PageControl2.ActivePageIndex));

      Octopusini.WriteString('Configuration', 'VERSIONNUMBER64', FVersionNumberStr);
      Octopusini.WriteString('Configuration', 'THEME_SKIN', str);

      Octopusini.WriteString('Configuration', 'CONTENT_FONTNAME', FontDialog.Font.Name);
      Octopusini.WriteInteger('Configuration', 'CONTENT_FONTSIZE', FontDialog.Font.Size);
      Octopusini.WriteInteger('Configuration', 'CONTENT_FONTCOLOR', FontDialog.Font.Color);

      /// Octopusini.WriteInteger('Configuration', 'CONTENT_BACKGROUNDCOLOR', SettingPagesDlg.ColorBoxContent.Selected);

      Octopusini.WriteBool('Configuration', 'APPLICATION_EXPLORER_MENU_ITEM', SettingPagesDlg.CheckBoxShortcutForExplorer.Checked);
      Octopusini.WriteBool('Configuration', 'APPLICATION_DESKTOP_MENU_ITEM', SettingPagesDlg.CheckBoxDesktopShortcutMenu.Checked);
    end;
  finally
    Octopusini.Free;
  end;

end;

procedure TMainOctopusDebuggingDevelopmentForm.LoadProjectSetting();
var
  Octopusini: TIniFile;
  s: string;
  i: Integer;
  /// ThemeSkinName: String;
  b: Boolean;
begin
  Octopusini := nil;
  if not DirectoryExists(SettingPagesDlg.OctopusCfgDir) then
    exit;
  s := SettingPagesDlg.OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
  if (not FileExists(s)) then
    exit;
  try
    Octopusini := TIniFile.Create(s);
    for i := 1 to StringGrid1.RowCount - 1 do
    begin
      StringGrid1.Cells[2, i] := Octopusini.ReadString('MyCustData', IntToStr(i) + '_2', '');
      /// StringGrid1.Cells[6, i] := Octopusini.ReadString('MyCustData', IntToStr(i) + '_6', '');
    end;

    FThemeSkinName := Octopusini.ReadString('MyPreference', 'THEME_SKIN', TStyleManager.StyleNames[0]);
    SV_R.Width := Octopusini.ReadInteger('MyPreference', 'SVR_WIDTH', SV_R.Width);
    SV_R.Opened := Octopusini.ReadBool('MyPreference', 'SVR_OPEN', false);

    StandardToolBar1.Visible := Octopusini.ReadBool('MyPreference', 'StandardToolBar1', false);
    StandardToolBar2.Visible := Octopusini.ReadBool('MyPreference', 'StandardToolBar2', True);
    i := Octopusini.ReadInteger('MyPreference', 'PageControl1', 1);
    PageControl1.TabPosition := TTabPosition(i);
    i := Octopusini.ReadInteger('MyPreference', 'PageControl2', 1);
    PageControl2.TabPosition := TTabPosition(i);

    i := Octopusini.ReadInteger('MyPreference', 'PageControl2ActivePageIndex', 0);
    PageControl2.ActivePageIndex := i;

    b := Octopusini.ReadBool('MyPreference', 'CHINESEUI', false);
    if (b) then
      SettingPagesDlg.ComboBox8.ItemIndex := 1;

    FontDialog.Font.Name := Octopusini.ReadString('Configuration', 'CONTENT_FONTNAME', '新宋体');
    FontDialog.Font.Size := Octopusini.ReadInteger('Configuration', 'CONTENT_FONTSIZE', 14);
    FontDialog.Font.Color := Octopusini.ReadInteger('Configuration', 'CONTENT_FONTCOLOR', clBlack);
    FGColorBox.Selected := FontDialog.Font.Color;

    SettingPagesDlg.CheckBoxShortcutForExplorer.Checked := Octopusini.ReadBool('Configuration', 'APPLICATION_EXPLORER_MENU_ITEM', True);
    SettingPagesDlg.CheckBoxDesktopShortcutMenu.Checked := Octopusini.ReadBool('Configuration', 'APPLICATION_DESKTOP_MENU_ITEM', True);

    if FThemeSkinName <> '' then
      AdjustSetStyle(FThemeSkinName);
  finally
    Octopusini.Free;
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.ShowSearchDialog();
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := Self.GetCurrentDevice();
  if (OcComPortObj <> nil) and (OcComPortObj.LogObject <> nil) then
  begin
    with FindDialog1 do
    begin
      Left := Self.Left + 600;
      Top := Self.Top + 150;
      FindText := OcComPortObj.LogObject.SelText;
      Execute;
    end;
  end
  else if (CMyRichEdit <> nil) then
  begin
    with FindDialog1 do
    begin
      Left := Self.Left + 600;
      Top := Self.Top + 150;
      FindText := CMyRichEdit.SelText;
      Execute;
    end;
  end;
end;

function TMainOctopusDebuggingDevelopmentForm.SearchMemo(Memo: TMyRichEdit; const SearchString: string; Options: TFindOptions): Boolean;
var
  Size: Integer;
  // StringSearchOptions:TStringSearchOptions;
  buffer, p: PChar;
begin
  Result := false;
  if Length(SearchString) = 0 then
    exit;

  Size := Memo.GetTextLen;
  // Size := Length(Memo.Text);
  if (Size = 0) then
    exit;

  buffer := System.SysUtils.StrAlloc(Size + 1);
  try
    Memo.GetTextBuf(buffer, Size + 1);

    if frDown in Options then
      p := SearchBuf(buffer, Size, Memo.SelStart, Memo.SelLength, SearchString, [soDown])
    else
      p := SearchBuf(buffer, Size, Memo.SelStart, Memo.SelLength, SearchString, []);

    if (frMatchCase in Options) then
      p := SearchBuf(buffer, Size, Memo.SelStart, Memo.SelLength, SearchString, [soMatchCase]);

    if (frWholeWord in Options) then
      p := SearchBuf(buffer, Size, Memo.SelStart, Memo.SelLength, SearchString, [soWholeWord]);

    // P := SearchBuf(Buffer, Size, Memo.SelStart, Memo.SelLength, SearchString,StringSearchOptions);
    if p <> nil then
    begin
      Memo.SelStart := p - buffer;
      Memo.SelLength := Length(SearchString);
      Result := True;
    end;

  finally
    System.SysUtils.StrDispose(buffer);
  end;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SendFileAsHex(OcComPortObj: TOcComPortObj; FileName: String);
var
  SL: TStringList;
  i: Integer;
  str, tempstr: String;
  iLength: Integer;
  baseAddress: dword;
  dataType: String;
  Data: array [0 .. 511] of byte;
  bb4, bb3: byte;
  pPOcComPack: POcComPack;
  bCount: Integer;
  // iDataCount: Integer;
  // reTryCount: Integer;
  fileSent: Integer;
  checksum: Integer;
  bStatusOK: Boolean;
Label FINISHED_OVER;
begin
  SL := TStringList.Create;
  SL.LoadFromFile(FileName);
  if not OcComPortObj.Connected then
  begin
    OcComPortObj.Log('Device was closed,please open a device.');
    exit;
  end;

  ZeroMemory(@Data, 512);
  fileSent := 0;
  checksum := 0;

  Data[0] := $FF;
  Data[1] := $0A;

  Data[2] := OCCOMPROTOCAL_INBOOT; // ����bootLAOD
  Data[3] := $00;

  Data[4] := $00;

  Data[5] := $00; // ���ݳ���
  Data[6] := $00; // ���ݳ���

  Data[7] := $00; // ����
  Data[8] := $00; // ����
  pPOcComPack := @Data[0]; // ʵ�ʷ��͵�ʱ�򳤶Ȳ�����CRC

  bStatusOK := True;
  bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, OCCOMPROTOCAL_INBOOT);

  if not bStatusOK then
  begin
    OcComPortObj.Log('device is not ready to receive file!');
    exit;
  end;

  StatusBar1DrawProgress(0, 0);
  Data[2] := OCCOMPROTOCAL_FLASH_WRITE; // дFLASH

  for i := 0 to SL.Count - 1 do
  begin
    Application.ProcessMessages;
    if (not OcComPortObj.Connected) then
    begin
      bStatusOK := false;
      break;
    end;

    str := SL.Strings[i];
    if str[1] <> ':' then
    begin
      OcComPortObj.Log('The file format is wrong.');
      break;
    end;

    // OcComPortObj.Log('test ' + str);
    if str = ':00000001FF' then // �������
    begin
      Data[2] := OCCOMPROTOCAL_DATA_COMPLETE;
      Data[5] := 6;

      IntToBuffer(fileSent, &Data[7], 2);
      IntToBuffer(checksum, &Data[9], 4);
      pPOcComPack := @Data[0];

      bStatusOK := True;
      bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, Data[2]);

      DelayDelay(30);
      // OcComPortObj.Log('Length  :'+IntToStr(fileSent));
      // OcComPortObj.Log('CheckSum:'+IntToStr(checksum));
      OcComPortObj.LogBuff('file size:', &Data[7], 2);
      OcComPortObj.LogBuff('file summ:', &Data[9], 4);
      break;
    end;

    tempstr := Copy(str, 2, 2); // ���ݳ���
    FormatHexStrToBuffer(tempstr, &Data[5], bCount);
    iLength := Data[5]; // �ȶ�����Ч����,������CRC
    Data[5] := 4 { 32 Flash��ַ } + iLength; // ��Ч���ݵĳ���

    dataType := Copy(str, 8, 2); // ��������
    if dataType = '04' then // ��չ�ĸ�λ��ַ
    begin
      tempstr := Copy(str, 10, iLength * 2); // ����
      FormatHexStrToBuffer(tempstr, &Data[7], bCount);
      baseAddress := MakeDWord(MakeWord(Data[7], Data[8]), 0);
      bb4 := Data[7];
      bb3 := Data[8];
      // OcComPortObj.Log('Other Data��'+str);
    end
    else if dataType = '00' then
    begin
      tempstr := Copy(str, 4, 4); // ���ݵ�ַ
      FormatHexStrToBuffer(tempstr, &Data[9], bCount); // 9��10

      tempstr := Copy(str, 10, iLength * 2 + 2); // ���� ��2���ַ�ΪCRCһ���ֽ�
      FormatHexStrToBuffer(tempstr, &Data[11], bCount); // buffer�������CRC

      Data[7] := bb4;
      Data[8] := bb3;

      fileSent := fileSent + iLength;
      checksum := checksum + ChecksumBuffer(&Data[11], iLength); // ����sum��Ҫ����crc

      // Memo2.Lines.Append(FormatBufferToHexStr(&Data[11], iLength));

      pPOcComPack := @Data[0]; // ʵ�ʷ��͵�ʱ�򳤶Ȳ�����CRC
      bStatusOK := True;
      bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, Data[7]);

      StatusBar1DrawProgress(i + 1, SL.Count);
      if (not bStatusOK) then
        break;
    end
    else
    begin
      // OcComPortObj.Log('Other Data��'+str);
    end;
  end; // for

FINISHED_OVER:
  if bStatusOK = false then
  begin
    OcComPortObj.Log('Transmit file failed!');
  end
  else
  begin
    OcComPortObj.Log('Transmit file finished!');
    StatusBar1DrawProgress(SL.Count, SL.Count);
  end;
  SL.Free;
end;

procedure TMainOctopusDebuggingDevelopmentForm.SendFileAsBin(OcComPortObj: TOcComPortObj; FileName: String);
var
  // SL: TStringList;
  // i: Integer;
  tempstr: String;
  iLength: Integer;
  baseAddress: dword;
  // dataType: String;
  Data: array [0 .. 511] of byte;
  // bb4, bb3: byte;
  pPOcComPack: POcComPack;
  bCount: Integer;
  // iDataCount: Integer;
  // reTryCount: Integer;
  fileSent: Integer;
  checksum: dword;
  bStatusOK: Boolean;
  MemoryStream: TMemoryStream;
Label FINISHED_OVER;
const
  DEFAULT_LENGTH = 16;
begin

  if not OcComPortObj.Connected then
  begin
    OcComPortObj.Log('Device was closed,please open a device.');
    exit;
  end;

  MemoryStream := TMemoryStream.Create;
  MemoryStream.LoadFromFile(FileName);
  if (MemoryStream = nil) or (MemoryStream.Size = 0) then
  begin
    OcComPortObj.Log('FileStream = nil/File size = 0!');
    exit;
  end;

  ZeroMemory(@Data, 512);

  fileSent := 0;
  checksum := 0;
  // dataType := '00';

  Data[0] := $FF;
  Data[1] := $0A;

  Data[2] := OCCOMPROTOCAL_INBOOT; // ����bootLAOD
  Data[3] := $00;

  Data[4] := $00;

  Data[5] := $00; // ���ݳ��Ȳ��������ݰ�ͷ�ͺ���Ľ���λ/CRC
  Data[6] := $00; // ���ݳ��Ȳ��������ݰ�ͷ�ͺ���Ľ���λ/CRC
  // ʵ��
  Data[7] := $00; // ����
  Data[8] := $00; // ����
  Data[9] := $00; // ����
  Data[10] := $00; // ����
  // ����BOOT LOLOAD MODE
  pPOcComPack := @Data[0]; // ʵ�ʷ��͵�ʱ�򳤶Ȳ�����CRC
  bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, OCCOMPROTOCAL_INBOOT);
  if not bStatusOK then
  begin
    OcComPortObj.Log('device is not ready to receive file!');
    exit;
  end;

  try
    tempstr := Trim(ComboBox302.Text);
    FormatHexStrToBuffer(tempstr, &Data[7], bCount);
    baseAddress := MakeDWord(MakeWord(Data[7], Data[8]), MakeWord(Data[9], Data[10]));
  except
    OcComPortObj.Log('invalide base addresss =' + tempstr);
    exit;
  end;

  StatusBar1DrawProgress(0, 0);
  OcComPortObj.Log('Base Addresss: ' + tempstr);
  Data[2] := OCCOMPROTOCAL_FLASH_WRITE; // дFLASH

  // for i := 0 to SL.Count - 1 do
  while (True) do
  begin
    // Application.ProcessMessages;
    iLength := MemoryStream.Read(&Data[11], DEFAULT_LENGTH);
    if (iLength <= 0) then
    begin
      Data[2] := OCCOMPROTOCAL_DATA_COMPLETE;
      Data[5] := 6;
      IntToBuffer(MemoryStream.Size, &Data[7], 2);
      IntToBuffer(checksum, &Data[9], 4);
      pPOcComPack := @Data[0];
      bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, Data[2]);
      DelayDelay(30);
      OcComPortObj.LogBuff('file size:', &Data[7], 2);
      OcComPortObj.LogBuff('file summ:', &Data[9], 4);
      break;
    end;

    Data[5] := 4 { 32 Flash��ַ } + iLength; // ��Ч���ݳ��Ȳ��������ݰ�ͷ�ͺ���Ľ���λ/CRC

    // if dataType = '00' then
    begin
      IntToBuffer(baseAddress, &Data[7], 4);
      checksum := checksum + ChecksumBuffer(&Data[11], iLength); // ����sum
      pPOcComPack := @Data[0]; // ʵ�ʷ��͵�ʱ�򳤶Ȳ�����CRC

      bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, Data[7]);
      // OcComPortObj.LogBuff('>', Data, Data[5] + 7 + 1); // ����ʵ�峤��+��ͷ+CRC

      fileSent := fileSent + iLength;
      StatusBar1DrawProgress(fileSent, MemoryStream.Size);

      if (not bStatusOK) then
        break;
      baseAddress := baseAddress + DEFAULT_LENGTH;
    end;
    // else;
  end; // for

FINISHED_OVER:
  if bStatusOK = false then
    OcComPortObj.Log('Transmit file failed!')
  else
    OcComPortObj.Log('Transmit file finished!');
  MemoryStream.Free;
end;

end.
