unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.StdActns, Vcl.ExtActns, Vcl.ActnList,
  System.Actions, Vcl.PlatformDefaultStyleActnCtrls, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.TitleBarCtrls,
  Vcl.VirtualImageList, Vcl.Menus, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.Buttons,
  Vcl.TabNotBk, VCLTee.TeCanvas, Vcl.Grids, VCLTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, Vcl.OleCtrls,
  SHDocVw,
  ClassTFormDockHost, Vcl.BandActn, Vcl.Tabs;

type
  TFrmMain = class(TFormDockHost)
    ActionMainMenuBar1: TActionMainMenuBar;
    TitleBarPanel1: TTitleBarPanel;
    ActionManager1: TActionManager;

    DialogOpenPicture1: TOpenPicture;
    DialogSavePicture1: TSavePicture;
    DialogColorSelect1: TColorSelect;
    DialogFontEdit1: TFontEdit;
    DialogPrintDlg1: TPrintDlg;

    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    EditSelectAll1: TEditSelectAll;

    FileOpen1: TFileOpen;
    FileOpenWith1: TFileOpenWith;
    FileSaveAs1: TFileSaveAs;
    FilePrintSetup1: TFilePrintSetup;
    FilePageSetup1: TFilePageSetup;
    FileRun1: TFileRun;
    FileExit1: TFileExit;

    SearchFindNext1: TSearchFindNext;
    SearchReplace1: TSearchReplace;
    SearchFind1: TSearchFind;
    SearchFindFirst1: TSearchFindFirst;

    InternetBrowseURL1: TBrowseURL;
    InternetDownLoadURL1: TDownLoadURL;
    InternetSendMail1: TSendMail;

    BrowseForFolder1: TBrowseForFolder;

    ToolBar16: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;

    VirtualImageList16: TVirtualImageList;
    ImageCollection1: TImageCollection;
    VirtualImageList32: TVirtualImageList;
    Panel1: TPanel;
    TabSet1: TTabSet;
    StatusBar1: TStatusBar;
    Notebook1: TNotebook;
    Chart1: TChart;
    Series1: TFastLineSeries;
    WebBrowser1: TWebBrowser;
    Memo1: TMemo;
    OcDockRightPl: TPanel;
    OcDockRightSpl: TSplitter;
    act_Static: TAction;
    act_Dynamic: TAction;
    act_tabset_albottom: TAction;
    Action2: TAction;
    CustomizeActionBars1: TCustomizeActionBars;
    BitBtn1: TBitBtn;
    Timer1: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);

    procedure ToolButton3Click(Sender: TObject);

    procedure ToolButton2Click(Sender: TObject);
    procedure OcDockRightPlUnDock(Sender: TObject; Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
    procedure InternetBrowseURL1AfterBrowse(Sender: TObject);

    procedure act_DynamicExecute(Sender: TObject);
    procedure act_tabset_albottomExecute(Sender: TObject);
    procedure TabSet1DrawTab(Sender: TObject; TabCanvas: TCanvas; R: TRect;
      Index: Integer; Selected: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure ShowFrmDockableController();
  public
    procedure AfterConstruction; override;
    { Public declarations }

    function getNotebookName(): String; overload;
    function getNotebookName(Index: Integer): String; overload;
    function getNotebookIndex(NotebookName: String): Integer;
    function addNotebookItem(NotebookName: String): TPage;

    procedure synchTabsetAndNotebookItems();
    procedure MainTabSetChange(TabIndex: Integer);

    procedure initComponent();
    procedure SetAsMainForm();
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  Vcl.GraphUtil, Vcl.Themes, System.Types, System.Math, Winapi.GDIPAPI,
  Winapi.GDIPOBJ, uSetting, uGlobalFunction, uControllerPanel, OcComPortObj,
  DockExceptions,
  ClassTFormDockable,
  ClassTFormDockHostTabs,
  ClassTFormDockHostJoin,
  uDockableControllerPanel;

{$R *.dfm}

procedure TFrmMain.ShowFrmDockableController();
begin
  if FrmDockableController <> nil then
  begin
    // FrmDockableController := TFrmDockableController.Create(nil, [akRight], caHide, act_Static);
    OcDockRightPl.Width := 400;
    FrmDockableController.Width := OcDockRightPl.Width;
    FrmDockableController.Caption := '操作控制面板';
    FrmDockableController.Do_Dock(akRight, alRight, False);
    act_Static.Checked := True;
  end;
end;

function TFrmMain.getNotebookName(): String;
begin
  result := Notebook1.ActivePage; // .Pages[Notebook1.PageIndex];
end;

function TFrmMain.getNotebookName(Index: Integer): String;
begin
  if (Index >= 0) and (Index < Notebook1.Pages.Count) then
    result := Notebook1.Pages[Index]
  else
    result := '';
end;

function TFrmMain.getNotebookIndex(NotebookName: String): Integer;
begin
  result := Notebook1.Pages.IndexOfName(NotebookName);
end;

procedure TFrmMain.act_tabset_albottomExecute(Sender: TObject);
begin
  inherited;
  TabSet1.Align := alBottom;
end;

function TFrmMain.addNotebookItem(NotebookName: String): TPage;
var
  Index: Integer;
begin
  // result := nil;
  Notebook1.Pages.BeginUpdate;
  index := Notebook1.Pages.IndexOfName(NotebookName);
  if index < 0 then
    Notebook1.Pages.Append(NotebookName);

  Index := Notebook1.Pages.IndexOf(NotebookName);
  result := TPage(self.Notebook1.Pages.Objects[Index]);
  Notebook1.Pages.EndUpdate;
end;

procedure TFrmMain.MainTabSetChange(TabIndex: Integer);
begin
  if (TabIndex < 0) or (TabIndex >= Notebook1.Pages.Count) then
    Exit;
  Notebook1.PageIndex := TabIndex;
end;

procedure TFrmMain.OcDockRightPlUnDock(Sender: TObject; Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
begin
  inherited;
  if (FrmDockableController <> nil) then
    FrmDockableController.Close;
end;

procedure TFrmMain.synchTabsetAndNotebookItems();
begin
  TabSet1.Tabs.BeginUpdate;
  TabSet1.Tabs.Clear;
  // TabSet1.Tabs := Notebook1.Pages;
  TabSet1.Tabs.AddStrings(Notebook1.Pages);
  // Notebook1.PageIndex := TabSet1.TabIndex;
  TabSet1.Tabs.EndUpdate;
end;

procedure TFrmMain.act_DynamicExecute(Sender: TObject);
var
  DockableForm: TFormDockable;
begin
  inherited;
  DockableForm := TFrmDockableController.Create(nil, [akRight], caFree, nil);
  DockableForm.Caption := 'Dynamic form';
  self.ShowDockableForm(DockableForm);
end;

procedure TFrmMain.AfterConstruction();
// var
// DockableForm: TFormDockable;
begin
  self.SetAsMainForm;
  if FrmDockableController <> nil then
  begin
    // FrmDockableController := TFrmDockableController.Create(nil, [akRight], caHide, act_Static);
    FrmDockableController.Width := 360;
    FrmDockableController.Caption := '操作控制面板';
    FrmDockableController.Do_Dock(akRight, alRight, False);
    act_Static.Checked := True;
  end;
end;

procedure TFrmMain.BitBtn1Click(Sender: TObject);
begin
  Memo1.Lines.BeginUpdate;
  Memo1.Lines.Add('dafdfdf');
  Memo1.Lines.EndUpdate;

end;

procedure TFrmMain.SetAsMainForm();
var
  P: Pointer;
begin
  P := @Application.MainForm;
  Pointer(P^) := self;
end;

procedure TFrmMain.initComponent();
begin
  if SettingPagesDlg = nil then
    SettingPagesDlg := TSettingPagesDlg.Create(nil);

  self.CustomTitleBar.Height := 40;
  if SettingPagesDlg <> nil then
    Application.Title := APPLICATION_TITLE + SettingPagesDlg.VersionNumberStr;

  self.Caption := Application.Title;

  act_Static.OnExecute := self.TriggerDockableForm;

  synchTabsetAndNotebookItems();

  // self.ComboBoxEx1.Clear;
  // self.ComboBoxEx1.Items.AddStrings(SettingPagesDlg.ComboBoxEx1.Items);
  // self.ComboBoxEx1.ItemIndex := SettingPagesDlg.ComboBoxEx1.ItemIndex;

  // self.ComboBox1.Clear;
  // self.ComboBox1.Items.AddStrings(SettingPagesDlg.ComboBox1.Items);
  // self.ComboBox1.ItemIndex := SettingPagesDlg.ComboBox1.ItemIndex;

  // self.ComboBox2.Clear;
  // self.ComboBox2.Items.AddStrings(SettingPagesDlg.ComboBox7.Items);
  // self.ComboBox2.ItemIndex := SettingPagesDlg.ComboBox7.ItemIndex;

  TabSet1.TabIndex := 0;
  if FrmDockableController <> nil then
    FrmDockableController.Width := 360;
end;

procedure TFrmMain.InternetBrowseURL1AfterBrowse(Sender: TObject);
begin
  inherited;

end;

/// ///////////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////////
procedure TFrmMain.FormCreate(Sender: TObject);
begin
  initComponent();
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  initComponent();
  ShowFrmDockableController();
end;

procedure TFrmMain.TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  AllowChange := True;
  MainTabSetChange(NewTab);
end;

procedure TFrmMain.TabSet1DrawTab(Sender: TObject; TabCanvas: TCanvas; R: TRect;
  Index: Integer; Selected: Boolean);
var S : String;
begin

   //if IndexOfDisabledTab = Index
   //then
   //  TabCanvas.Font.Color := clGray
   //else
     TabCanvas.Font.Color := clBlack;

  S := TabSet1.Tabs.Strings[Index];
  TabCanvas.TextRect(R, S, [tfVerticalCenter,tfSingleLine]);
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  inherited;
 Memo1.Lines.BeginUpdate;
  Memo1.Lines.Add('dafdfdf');
  Memo1.Lines.EndUpdate;
end;

procedure TFrmMain.ToolButton1Click(Sender: TObject);
begin
  SettingPagesDlg.ShowModal();
end;

procedure TFrmMain.ToolButton2Click(Sender: TObject);
begin
  inherited;
  ShowFrmDockableController();
end;

procedure TFrmMain.ToolButton3Click(Sender: TObject);
begin
  FrmControllerPanel.show();
  // FrmDockableController.Close;
end;

procedure TFrmMain.ToolButton4Click(Sender: TObject);
var
  // bookPageName: String;
  OcComPortObj: TOcComPortObj;
  ParentPage: TPage;
  openStatus: Boolean;
begin
  // bookPageName := 'NotebookPage_' + intToStr(Notebook1.Pages.Count + 1);
  OcComPortObj := SettingPagesDlg.getAvailableDevice();
  if OcComPortObj = nil then
    Exit;
  if OcComPortObj.OcComPortObjPara.ComportFullName = '' then
    Exit;

  if OcComPortObj <> nil then
  begin
    ParentPage := addNotebookItem(OcComPortObj.OcComPortObjPara.ComportFullName);
    synchTabsetAndNotebookItems();

    if ParentPage = nil then
      Exit;
    ParentPage.DoubleBuffered := True;
    ParentPage.Visible := False;
    OcComPortObj.LogMemo.Lines.BeginUpdate;
    OcComPortObj.LogMemo.Parent := ParentPage;
    OcComPortObj.LogMemo.DoubleBuffered := True;
    OcComPortObj.LogMemo.Font := Memo1.Font;
    OcComPortObj.LogMemo.Color := Memo1.Color;
    OcComPortObj.LogMemo.Align := Memo1.Align;
    OcComPortObj.LogMemo.HideSelection := False;
    OcComPortObj.LogMemo.show;
    OcComPortObj.LogMemo.Lines.EndUpdate;
    ParentPage.Visible := True;

    TabSet1.TabIndex := (Notebook1.Pages.Count - 1);
    // Notebook1.Update;
  end;

  openStatus := SettingPagesDlg.openDevice(OcComPortObj);
  if openStatus then
  begin
    OcComPortObj.DebugLog('');
    OcComPortObj.DebugLog('################################################');
    OcComPortObj.DebugLog(APPLICATION_TITLE + SettingPagesDlg.VersionNumberStr);
    OcComPortObj.DebugLog('Home Page :' + WEB_SITE + ' ');
    OcComPortObj.DebugLog('Function  :' + 'ESC、F1、F2、F3');
    OcComPortObj.DebugLog('################################################');
    OcComPortObj.DebugLog(OcComPortObj.OcComPortObjPara.ComportFullName);
  end
  else
  begin
    OcComPortObj.DebugLog('Can not open  ' + OcComPortObj.OcComPortObjPara.ComportFullName);
    OcComPortObj.DebugLog('Open failed!!!!! the device may be in use');
    // MessageBox(Application.Handle, PChar('Open device ' + OcComPortObj.OcComPortObjPara.ComportFullName + ' failed, it may be in used.'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
  end;
end;

procedure TFrmMain.WMActivate(var Message: TWMActivate);
var
  LColor: TColor;
begin
  inherited;
  if CustomTitleBar.Enabled and Assigned(ActionMainMenuBar1) then
    ActionMainMenuBar1.Invalidate;

  if TOSVersion.Check(10) and CustomTitleBar.Enabled and not CustomTitleBar.SystemColors then
  begin
    if Active then
      LColor := CustomTitleBar.BackgroundColor
    else
      LColor := CustomTitleBar.InactiveBackgroundColor;

    ToolBar16.GradientStartColor := LColor;
    ToolBar16.GradientEndColor := LColor;
    // ToolBar32.GradientStartColor := LColor;
    // ToolBar32.GradientEndColor := LColor;
  end;
end;

end.
