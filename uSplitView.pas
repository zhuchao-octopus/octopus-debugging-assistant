// ---------------------------------------------------------------------------

// This software is Copyright (c) 2015 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

// ---------------------------------------------------------------------------

unit uSplitView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Actions,
  OcComPortObj,
  Vcl.Graphics,
  Vcl.HtmlHelpViewer,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  Vcl.StdCtrls,
  Vcl.CategoryButtons,
  Vcl.Buttons,
  Vcl.ImgList,
  Vcl.Imaging.PngImage,
  Vcl.ComCtrls,
  CPortCtl, Vcl.Grids, CPort,
  Vcl.Tabs, Vcl.Menus, Vcl.OleCtrls, SHDocVw,
  VCLTee.TeCanvas, VCLTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.TeeFunci, JvComponentBase, JvHidControllerClass, StrUtils,
  UnitCmdShell, Vcl.Mask;

type
  TChartAccess = class(TCustomAxisPanel);

  THIDReport = packed record
    ReportID: byte;
    Data: array [0 .. 64] of byte;
  end;

type
  TSplitViewForm = class(TForm)
    SV_L: TSplitView;
    DeviceIconList: TImageList;
    SV_R: TSplitView;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Timer2: TTimer;
    OpenDialog1: TOpenDialog;
    TabSet1: TTabSet;
    Notebook1: TNotebook;
    Panel17: TPanel;
    Panel3: TPanel;
    Button2: TButton;
    ComboBoxEx1: TComboBoxEx;
    Button4: TButton;
    Panel1: TPanel;
    Notebook2: TNotebook;
    TabSet2: TTabSet;
    Memo1: TMemo;
    TabSet3: TTabSet;
    Notebook3: TNotebook;
    Panel2: TPanel;
    Panel6: TPanel;
    cbxVclStyles: TComboBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    CheckBox8: TCheckBox;
    Edit3: TEdit;
    UpDown5: TUpDown;
    Button6: TButton;
    Button5: TButton;
    CheckBox7: TCheckBox;
    GroupBox4: TGroupBox;
    CheckBox2: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Timer3: TTimer;
    W1234998: TWebBrowser;
    PopupMenu1: TPopupMenu;
    CloseTheDevice1: TMenuItem;
    SaveDialog1: TSaveDialog;
    TrayIcon1: TTrayIcon;
    Chart1: TChart;
    Panel9: TPanel;
    GroupBox10: TGroupBox;
    CheckBox10: TCheckBox;
    Button15: TButton;
    Button18: TButton;
    Button19: TButton;
    ButtonColor1: TButtonColor;
    ButtonColor2: TButtonColor;
    CheckBox11: TCheckBox;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Panel10: TPanel;
    Memo5: TMemo;
    Panel5: TPanel;
    Panel7: TPanel;
    Memo2: TMemo;
    Panel8: TPanel;
    Button7: TButton;
    Button8: TButton;
    Panel12: TPanel;
    StringGrid1: TStringGrid;
    Panel4: TPanel;
    Button1: TButton;
    Button3: TButton;
    Panel13: TPanel;
    Memo3: TMemo;
    Button9: TButton;
    Button11: TButton;
    Panel14: TPanel;
    Panel15: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Panel16: TPanel;
    Button16: TButton;
    Panel18: TPanel;
    Label18: TLabel;
    ComboBox12: TComboBox;
    Label11: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    ComboBox9: TComboBox;
    ComboBox10: TComboBox;
    ComboBox11: TComboBox;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    Series1: TFastLineSeries;
    Splitter1: TSplitter;
    Button25: TButton;
    FindDialog1: TFindDialog;
    Panel19: TPanel;
    ComboBox6: TComboBox;
    Label13: TLabel;
    ComboBox5: TComboBox;
    Label15: TLabel;
    ComboBox4: TComboBox;
    Label5: TLabel;
    ComboBox3: TComboBox;
    Label9: TLabel;
    ComboBox2: TComboBox;
    Label12: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Panel20: TPanel;
    Button10: TButton;
    Button26: TButton;
    Button17: TButton;
    Button12: TButton;
    Button24: TButton;
    Button23: TButton;
    ComboBox7: TComboBox;
    Label10: TLabel;
    Panel11: TPanel;
    CheckBox12: TCheckBox;
    Combobox_CodePage: TComboBox;
    ComboBox8: TComboBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox1: TCheckBox;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Button13: TButton;
    LabeledEdit1: TLabeledEdit;
    Button14: TButton;
    Label4: TLabel;
    Button27: TButton;
    Button28: TButton;

    procedure FormCreate(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure ComboBoxEx1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StringGrid1FixedCellClick(Sender: TObject; ACol, ARow: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure UpDown2Changing(Sender: TObject; var AllowChange: Boolean);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure UpDown5Changing(Sender: TObject; var AllowChange: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure TabSet3Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure SV_ROpened(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure TabSet2Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure cbxVclStylesChange(Sender: TObject);
    procedure SV_RClosed(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox25Click(Sender: TObject);
    procedure ComboBox8Change(Sender: TObject);
    procedure CloseTheDevice1Click(Sender: TObject);
    procedure TabSet2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure W1234998NewWindow2(ASender: TObject; var ppDisp: IDispatch; var Cancel: WordBool);
    procedure ComboBox1Change(Sender: TObject);
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Button15Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure ButtonColor1Click(Sender: TObject);
    procedure ButtonColor2Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure JvHidDeviceController1DeviceChange(Sender: TObject);
    function JvHidDeviceController1Enumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
    function CheckHID(DeviceName: String): TJvHidDevice;
    function GetHID_IDX(DeviceName: String): Integer;
    function CheckHID_ShortName(DeviceName: String): String;

    procedure HIDWrite(HidDev: TJvHidDevice; buf: Array of byte; WriteCount: Integer; var BytesWritten: Cardinal);
    procedure JvHidDeviceController1DeviceData(HidDev: TJvHidDevice; ReportID: byte; const Data: Pointer; Size: Word);
    procedure Button16Click(Sender: TObject);
    procedure Edit22KeyPress(Sender: TObject; var Key: Char);
    procedure Button12Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);

    procedure Splitter1Moved(Sender: TObject);
    procedure ComboBox10KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox11KeyPress(Sender: TObject; var Key: Char);
    procedure SV_LClosed(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    function FormHelp(Command: Word; Data: NativeInt; var CallHelp: Boolean): Boolean;
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure Combobox_CodePageChange(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure FindDialog1Show(Sender: TObject);
    procedure FindDialog1Close(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);

    function GetStringGridValidStr(sStr: String): String;
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure StatusBar1DrawProgress(progress: Integer; progressMax: Integer);
  private
    // ComReceiveCount: Integer;
    // ComReceiveBuffer: array [0 .. 1048576] of Byte;
    // for com port receive buffer
    // ComReceiveBuffer:array of Byte;
    FJvHidDeviceController1: TJvHidDeviceController;

    OctopusCfgDir: String;
    OctopusCfgDir_LogFileName: String;
    // FFileStream: TFileStream;
    FullFileNameLoaded: String;
    OcComPortList: TStringList;
    OcHIDDeviceList: TStringList;
    UILanguage: String;
    // LoopStringList: TStringList;
    // FTimer1Timer_Count: Integer;
    FCheck, FNoCheck: TBitmap;

    Fprogress, FprogressMax: Integer;

    procedure MyAppMsg(var Msg: TMsg; var Handled: Boolean);
    Procedure WMSysCommand(var Msg: TWMMenuSelect); message WM_SysCommand;
    procedure WMDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE;
    procedure UIUpdateDeviceHandleProcess(DevideName: String = ''; ActionType: Integer = $8000);
    procedure OpenDevice2(DeviceFullName: String);
    procedure CloseDevice2(DeviceFullName: String);
    procedure TabSetChange(Sender: TObject; NewTab: Integer);
    procedure GetOctopusHelpFile();

    procedure RunWindosShellCmd(str: String; Memo: TMemo);

    function SearchMemo(Memo: TMemo; const SearchString: string; Options: TFindOptions): Boolean;
  public
    procedure ShowHideRLPanel(RL: Integer);
    procedure StatusBarPrintFileSize();
    procedure ProjectSave(SavePrivate: Boolean);
    procedure FalconLoadCfg();
    procedure UpdateUiLaunguage(Lang: String);
    procedure MultiCOMPort_UI_Update(DeviceName: String);

    function GetDeciceByFullName(DeviceName: string): TOcComPortObj;
    function GetDeciceByPort(Port: string): TOcComPortObj;
    function GetCurrentDeviceName(): String;

    procedure MultiComPortSaveLog();
    procedure UpdateOcComPortObjAtrribute();
    // procedure UpdateOcComPortObjAtrribute2(OcComPortObj: TOcComPortObj);
    procedure ShowTrayIcon(TrayIcon1: TTrayIcon);
    procedure OcComPortObjCallBack(Count: Integer);

    function CharGetBase(FastLineSeries: TFastLineSeries): Integer;
    function CharGetSeries(Title: String): TFastLineSeries;
    function CharGetSeries2(Index: Integer): TFastLineSeries;
    procedure CharResetSeries();
    procedure ReuseXValues(DoReuse: Boolean);
    function CharAddSeries(Base: Integer; Title: String; Color: TColor): TFastLineSeries;
    function CharAddSeries2(Base: Integer; Title: String): TFastLineSeries;
    procedure CharAppendBuffData(FastLineSeries: TFastLineSeries; Base: Integer; Buff: array of Double; Length: Integer);
    procedure CharAppendData(FastLineSeries: TFastLineSeries; Base: Integer; Data: Double);
    procedure CharMoveSeries(Index: Integer; Count: Integer);
    procedure CharInit(BOver: Boolean);
    function CharInitSeries(BOver: Boolean): TFastLineSeries;
    procedure CharStartASeries(Name: String; Buff: array of Double; Length: Integer);
    procedure CharZoomSeries(Count: Integer);
    procedure CharSeriesSetColor(Index: Integer; Color: TColor);
    function SaveToTheExcelFile(ExcelApp: Variant; Buff: array of byte; Length: Integer; Rows: Integer): Integer;

    procedure StopReceiveFile(OcComPortObj: TOcComPortObj);
    function getDeviceTabIndex(DeviceName: String): Integer;

    procedure SendFileAsCommon(OcComPortObj: TOcComPortObj);
    procedure SendFileAsHex(OcComPortObj: TOcComPortObj; FileName: String);
    procedure SendFileAsBin(OcComPortObj: TOcComPortObj; FileName: String);
  end;

var
  SplitViewForm: TSplitViewForm;
  MouseOldX, MouseOldY: Longint; // 使用前初始化OldX:=－1；

  CurrentDevices: TOcComPortObj;
  CurrentDevicesJvHidDevice: TJvHidDevice;
  VersionNumberStr: String;
  Commandhread: TCommandhread;
  CommandIndex: Integer;

procedure ShowStartComments(Lang: String);
function GetApplication(): TApplication;

implementation

uses
  Vcl.Themes, ocPcDeviceMgt, ShlObj, ActiveX, ComObj, IniFiles, ShellAPI,
  Unit200, Octopus_CRC, WinInet, OcDecrypt, OcProtocol, CRC, math,NetInterface,UnitDeviceThread;

{$R *.dfm}

type
  TFastAccess = class(TFastLineSeries);

function TSplitViewForm.getDeviceTabIndex(DeviceName: String): Integer;
begin
  Result := Notebook2.Pages.IndexOf(DeviceName);
end;

procedure Printf_crc_tab();
var
  i: Integer;
  str: String;
begin
  str := '';
  for i := Low(crc_tab16) to High(crc_tab16) do
  begin
    str := str + Format('0x%0.4x,', [crc_tab16[i]]);
  end;
  SplitViewForm.Memo1.Lines.Add(str);
end;

Function CheckUrl(url: string): Boolean;
var
  hSession, hfile, hRequest: hInternet;
  dwindex, dwcodelen: dword;
  dwcode: array [1 .. 20] of Char;
  res: PChar;
begin
  Result := False;
  if Pos('http://', LowerCase(url)) = 0 then
    url := 'http://' + url;

  hSession := InternetOpen('InetURL:/1.0', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(hSession) then
  begin
    hfile := InternetOpenUrl(hSession, PChar(url), nil, 0, INTERNET_FLAG_RELOAD, 0);
    dwindex := 0;
    dwcodelen := 10;
    HttpQueryInfo(hfile, HTTP_QUERY_STATUS_CODE, @dwcode, dwcodelen, dwindex);
    res := PChar(@dwcode);
    Result := (res = '200') or (res = '302'); // 200,302未重定位标志
    if Assigned(hfile) then
      InternetCloseHandle(hfile);
    InternetCloseHandle(hSession);
  end;
end;

procedure TSplitViewForm.GetOctopusHelpFile;
var
  Types: Integer;
  str: String;
begin
  Types := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;

  str := 'file:///' + ExtractFileDir(Application.Exename) + '\Octopus Software – 章鱼串口助手.html';
  if CheckUrl('http://www.baidu.com') then
  // if internetGetConnectedState(@types,0) then
  begin
    str := ByteToWideString(@testbuff, Length(testbuff));
  end;
  W1234998.Navigate(str); // (DEFAULT_WEBSITE_ADDRESS);
end;

procedure TSplitViewForm.CharSeriesSetColor(Index: Integer; Color: TColor);
var
  FastLineSeries: TFastLineSeries;
begin
  FastLineSeries := CharGetSeries2(Index);
  if FastLineSeries <> nil then
    FastLineSeries.Pen.Color := Color;

  Chart1.Invalidate;
end;

procedure TSplitViewForm.CharStartASeries(Name: String; Buff: array of Double; Length: Integer);
var
  FastLineSeries: TFastLineSeries;
  Base: Integer;
begin
  FastLineSeries := self.CharAddSeries2(0, Name);
  if CheckBox11.Checked then
    self.CharAppendBuffData(FastLineSeries, 0, Buff, Length)
  else
    self.CharAppendBuffData(FastLineSeries, FastLineSeries.Tag, Buff, Length);

  if CheckBox10.Checked then
    CharMoveSeries(0, Length);
end;

procedure TSplitViewForm.CharInit(BOver: Boolean);
var
  b: array [0 .. 90] of Double;
  i, w, j: Integer;
  a, Y: Double;
begin
  // 弧度的定义是：两条射线从圆心向圆周射出，形成一个夹角和夹角正对的一段弧。当这段弧长正好等于圆的半径时，两条射线的夹角大小为1弧度。
  CharResetSeries();
  self.CharAddSeries(0, 'test1', clFuchsia);
  self.CharAddSeries(0, 'test2', clYellow);
  for i := Low(b) to High(b) do
    b[i] := Random(20);

  if BOver then
    self.CharAppendBuffData(CharGetSeries('test1'), 0, b, Length(b))
  else
    self.CharAppendBuffData(CharGetSeries('test1'), 11, b, Length(b));

  w := 30;
  for j := 1 to Round(Length(b) / w) do
    for i := 0 to w - 1 do
    begin
      a := (i / w) * 2 * Pi; // 弧度角度化
      Y := Sin(a);
      Y := (Y + 1) * 5; // (1-y)*w/2;
      // b[i]:=y;
      self.CharAppendData(CharGetSeries('test2'), 0, Y);
    end;
  // self.CharAppendBuffData(CharGetSeries('test2'),0,b, Length(b));
end;

function TSplitViewForm.CharInitSeries(BOver: Boolean): TFastLineSeries;
begin
  CharResetSeries();
  Result := self.CharAddSeries(0, 'test1', clYellow);
end;

procedure TSplitViewForm.ReuseXValues(DoReuse: Boolean);
var
  t: Integer;
begin
  for t := 0 to Chart1.SeriesCount - 1 do
    TFastAccess(Chart1[t]).ReuseXValues := DoReuse;
end;

function TSplitViewForm.CharGetSeries(Title: String): TFastLineSeries;
var
  i: Integer;
begin
  Result := nil;
  if Title = '' then
  begin
    if Chart1.SeriesCount > 0 then
      Result := Chart1.Series[0] as TFastLineSeries;
    exit;
  end;
  for i := 0 to Chart1.SeriesCount - 1 do
  begin
    if Chart1.Series[i].Title = Title then
    begin
      Result := Chart1.Series[i] as TFastLineSeries;
      break;
    end;
  end;
end;

function TSplitViewForm.CharGetSeries2(Index: Integer): TFastLineSeries;
begin
  Result := nil;
  if (Chart1.SeriesCount > 0) and (Index < Chart1.SeriesCount) and (Index >= 0) then
    Result := Chart1.Series[Index] as TFastLineSeries;
end;

procedure TSplitViewForm.CharResetSeries;
begin
  Chart1.FreeAllSeries;
  Chart1.ClearChart;
  Chart1.Axes.FastCalc := True;
  Chart1.Legend.Hide;
  Chart1.Zoom.Animated := True;
  Chart1.Zoom.Allow := True;
  Chart1.Zoom.AnimatedSteps := 2;
  Chart1.Title.Visible := True;
  Chart1.Title.Alignment := taLeftJustify;
  // Chart1.Zoom.Direction:= gdFromTopLeft;
  // Hide grid lines:
  // Chart1.Axes.Bottom.Grid.Hide;
  // Chart1.Axes.Left.Grid.Hide;
  Chart1.View3D := False;
  Chart1.Axes.Bottom.Texts.Selected.Hover.Font.Color := clWhite;
  Chart1.Axes.Left.Texts.Selected.Hover.Font.Color := clWhite;

  TChartAccess(Chart1).ParallelThreads := 1; // TTeeCPU.NumberOfProcessors;
  Chart1.BevelOuter := bvNone;
  Chart1.Color := clBlack;
  Chart1.Title.Font.Color := RGBA(200, 150, 50, 0);
  Chart1.Axes.Left.Texts.Font.Color := clWhite;
  Chart1.Axes.Bottom.Texts.Font.Color := clWhite;

  // Chart1.Canvas.Pen.Width:=2;
end;

procedure TSplitViewForm.Chart1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  Procedure DrawCross(AX, AY: Integer);
  var
    Color: TColor;
    pwidth: Integer;
    PenStyle: TPenStyle;
    PenMode: TPenMode;
  begin
    Color := Chart1.Canvas.Pen.Color;
    pwidth := Chart1.Canvas.Pen.Width;
    PenStyle := Chart1.Canvas.Pen.Style;
    PenMode := Chart1.Canvas.Pen.Mode;
    With Chart1.Canvas do
    begin
      Pen.Color := clWhite;
      Pen.Style := psSolid;
      Pen.Mode := pmXor;
      Pen.Width := 1;
      MoveTo(AX, 0);
      LineTo(AX, Chart1.Height);
      MoveTo(0, AY);
      LineTo(Chart1.Width, AY);
    end;
    Chart1.Canvas.Pen.Style := PenStyle;
    Chart1.Canvas.Pen.Width := pwidth;
    Chart1.Canvas.Pen.Color := Color;
    Chart1.Canvas.Pen.Mode := PenMode;
  end;

var
  str: String;
begin
  if (MouseOldX <> -1) then
  begin
    DrawCross(MouseOldX, MouseOldY); { 画旧十字线 }
    MouseOldX := -1;
  end;
  { 检查当前鼠标点是否在指定范围内 }
  if PtInRect(Rect(0, 0, Chart1.Width, Chart1.Height), Point(X, Y)) then
  begin
    DrawCross(X, Y); { 在当前鼠标点画十字线 }
    MouseOldX := X;
    MouseOldY := Y;
    if Chart1.SeriesCount > 0 then
    begin
      // Chart1.Title.Text.Clear;
      str := 'X: ' + FloatToStr(Chart1.Series[0].XScreenToValue(X));
      Label16.Caption := str;
      str := 'Y: ' + FloatToStr(Chart1.Series[0].YScreenToValue(Y));
      Label17.Caption := str;
      // Chart1.Title.Text.BeginUpdate;
      // Chart1.Title.Text.Append(str);
      // Chart1.Title.Text.EndUpdate;
    end;
  end;
  // Chart1.Invalidate;
end;

function TSplitViewForm.CharGetBase(FastLineSeries: TFastLineSeries): Integer;
begin
  Result := FastLineSeries.Tag;
end;

function TSplitViewForm.CharAddSeries(Base: Integer; Title: String; Color: TColor): TFastLineSeries;
// var
// i:Integer;
begin
  Result := CharGetSeries(Title);
  if Result = nil then
  begin
    Result := TFastLineSeries.Create(nil);
    Chart1.AddSeries(Result);
    Result.DrawStyle := flAll;
    Result.Title := Title;
    Result.FastPen := True;
    Result.LinePen.Color := Color;
    Result.Pen.Width := 2;
    // i:= Chart1.SeriesList.IndexOf(Result);
  end;
end;

function TSplitViewForm.CharAddSeries2(Base: Integer; Title: String): TFastLineSeries;
var
  i: Integer;
begin
  Result := CharGetSeries(Title);
  if Result = nil then
  begin
    Result := TFastLineSeries.Create(nil);
    Chart1.AddSeries(Result);
    Result.DrawStyle := flAll;
    Result.Title := Title;
    Result.FastPen := True;
    Result.Pen.Width := 2;
    i := Chart1.SeriesList.IndexOf(Result);
    if i = 0 then
      Result.Tag := 0
    else
      Result.Tag := Round(Chart1.Series[i - 1].MaxYValue + 1);
  end;
end;

procedure TSplitViewForm.CharZoomSeries(Count: Integer);
begin
  Chart1.BottomAxis.Automatic := False;
  Chart1.BottomAxis.Maximum := Chart1.BottomAxis.Maximum + Count;
  Chart1.BottomAxis.Minimum := Chart1.BottomAxis.Minimum - Count; //
  Chart1.Invalidate;
end;

procedure TSplitViewForm.CharMoveSeries(Index: Integer; Count: Integer);
var
  a: Double;
begin
  a := Chart1.BottomAxis.Maximum - Chart1.BottomAxis.Minimum;
  if a <= DEFAULT_MAX_CHART_POINTS then
    exit;

  Chart1.BottomAxis.Automatic := False;
  Chart1.BottomAxis.Maximum := Chart1.BottomAxis.Maximum + Count;
  Chart1.BottomAxis.Minimum := Chart1.BottomAxis.Minimum + Count; //
  Chart1.Invalidate;
end;

procedure TSplitViewForm.CharAppendBuffData(FastLineSeries: TFastLineSeries; Base: Integer; Buff: array of Double; Length: Integer);
var
  i: Integer;
begin
  if FastLineSeries = nil then
    exit;
  for i := Low(Buff) to Length - 1 do
    FastLineSeries.AddY(Buff[i] + Base);
  // FastLineSeries.AddArray(Buff);
end;

procedure TSplitViewForm.CharAppendData(FastLineSeries: TFastLineSeries; Base: Integer; Data: Double);
// var
// i:Integer;
begin
  if FastLineSeries = nil then
    exit;
  FastLineSeries.AddY(Data + Base);
end;

function GetApplication(): TApplication;
begin
  Result := Application;
end;

{ 第一个参数是要建立快捷方式的文件, 这是必须的; 其他都是可选参数 }
{ 第二个参数是快捷方式名称, 缺省使用参数一的文件名 }
{ 第三个参数是指定目的文件夹, 缺省目的是桌面; 如果有第四个参数, 该参数将被忽略 }
{ 第四个参数是用常数的方式指定目的文件夹; 该系列常数定义在 ShlObj 单元, CSIDL_ 打头 }
// CreateShortcut(Application.ExeName, '', '', CSIDL_PROGRAMS);
// CreateShortcut(Application.ExeName, '', 'C:/');
function CreateShortcut(Exe: string; Lnk: string = ''; Dir: string = ''; ID: Integer = -1): Boolean;
var
  IObj: IUnknown;
  ILnk: IShellLink;
  IPFile: IPersistFile;
  PIDL: PItemIDList;
  InFolder: array [0 .. MAX_PATH] of Char;
  LinkFileName: WideString;
begin
  Result := False;
  if not FileExists(Exe) then
    exit;
  if Lnk = '' then
    Lnk := ChangeFileExt(ExtractFileName(Exe), '');
  IObj := CreateComObject(CLSID_ShellLink);
  ILnk := IObj as IShellLink;
  ILnk.SetPath(PChar(Exe));
  ILnk.SetWorkingDirectory(PChar(ExtractFilePath(Exe)));
  if (Dir = '') and (ID = -1) then
    ID := CSIDL_DESKTOP;
  if ID > -1 then
  begin
    SHGetSpecialFolderLocation(0, ID, PIDL);
    SHGetPathFromIDList(PIDL, InFolder);
    LinkFileName := Format('%s/%s.lnk', [InFolder, Lnk]);
  end
  else
  begin
    Dir := ExcludeTrailingPathDelimiter(Dir);
    if not DirectoryExists(Dir) then
      exit;
    LinkFileName := Format('%s/%s.lnk', [Dir, Lnk]);
  end;
  IPFile := IObj as IPersistFile;
  if IPFile.Save(PWideChar(LinkFileName), False) = 0 then
    Result := True;
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

function writeFileToStream(FileStream: TFileStream; buffer: array of byte; Len: Integer): Integer;
begin
  try
    Result := FileStream.Write(buffer, Len);
    // FileStream.Seek()
  except
  end;
end;

function CharToDigit(c: Char): byte;
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

function CharToByte(c1, c2: Char): byte;
begin
  Result := CharToDigit(c1) * 16 + CharToDigit(c2);
end;

function FormatHexStr(hs: string; var buf: array of byte): string;
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

function FormatHexToAscii(hs: string; var buf: array of byte): Integer;
var
  i, Len: Word;
begin
  Result := Length(hs);
  Len := (Length(hs) + 2) div 3;
  ZeroMemory(@buf, Len * 2);

  for i := 1 to Len do
  begin
    buf[i - 1] := CharToByte(hs[i * 3 - 2], hs[i * 3 - 1]);
  end;
end;

function FirstDriveFromMask(um: Integer): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to 25 do
  begin
    if Boolean(um and 1) then
      Result := Result + Char(Integer('A') + i);
    um := um shr 1;
  end;
end;

function FalconGetComPort(str: string): string;
// const
// pattern = 'COM +d';
var
  ss: string;
  i1, i2: Integer;
  pStr: PChar;
  // match: TMatch;
begin
  str := Trim(str);
  // match:=TRegEx.Match(str,pattern);
  // if match.Success then
  // ss:=match.Value;

  // pStr := StrRScan(Pchar(str), '(');
  pStr := StrRScan(PChar(str), 'C');
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

{
  function FalconGetComPort(str: string): string;
  var
  s: string;
  i1, i2: Integer;
  begin
  str := Trim(str);
  if (Pos('COM', str) > 0) then
  begin
  i1 := Pos('(', str) + 1;
  i2 := Pos(')', str);
  if ((i2 - i1) > 0) then
  s := Copy(str, i1, i2 - i1);
  end
  else if (Pos('PID', str) > 0) then
  s := Copy(str, Pos('PID', str), 10)
  else
  s := '';
  Result := s;
  end;
}
function GetSystemDateTimeStampStr(): string;
var
  // lpSystemTime:TSystemTime;
  LocalSystemTime: _SYSTEMTIME;
begin
  Result := '';
  // Getsystemtime(lpSystemTime);
  GetLocalTime(LocalSystemTime);
  // Result:=Format('[%0.4d\%0.2d\%0.2d\%0.2d:%0.2d:%0.2d] ',[lpSystemTime.wYear,lpSystemTime.wMonth,lpSystemTime.wDay,lpSystemTime.wHour,lpSystemTime.wMinute,lpSystemTime.wSecond]);
  Result := Format('%0.4d%0.2d%0.2d_%0.2d%0.2d%0.2d', [LocalSystemTime.wYear, LocalSystemTime.wMonth, LocalSystemTime.wDay, LocalSystemTime.wHour, LocalSystemTime.wMinute, LocalSystemTime.wSecond]);
end;

function GetSystemDateTimeStampStr2(): string;
var
  LocalSystemTime: _SYSTEMTIME;
  d, t: String;
begin
  Result := '';
  GetLocalTime(LocalSystemTime);
  if SplitViewForm.CheckBox3.Checked then // 日期
  begin
    d := Format('%0.4d%0.2d%0.2d', [LocalSystemTime.wYear, LocalSystemTime.wMonth, LocalSystemTime.wDay]);
    Result := d + ' ';
  end;
  if SplitViewForm.CheckBox25.Checked then // 时间
  begin
    t := Format('%0.2d:%0.2d:%0.2d', [LocalSystemTime.wHour, LocalSystemTime.wMinute, LocalSystemTime.wSecond]);
    Result := t + ' ';
  end;

  if SplitViewForm.CheckBox3.Checked and SplitViewForm.CheckBox25.Checked then
    Result := d + '/' + t + ' ';
end;

function GetLineNumberStrForLog(LineNumber: Int64): string;
begin
  Result := '';
  if not SplitViewForm.CheckBox4.Checked then
    exit;
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

procedure Log0(const Msg: string);
var
  // LocalSystemTime: _SYSTEMTIME;
  timeStr: String;
begin
  SplitViewForm.Memo1.Lines.BeginUpdate;
  timeStr := GetLineNumberStrForLog(SplitViewForm.Memo1.Lines.Count);
  if (SplitViewForm.CheckBox25.Checked or SplitViewForm.CheckBox3.Checked) then
  begin
    timeStr := timeStr + GetSystemDateTimeStampStr2();
  end;

  SplitViewForm.Memo1.Lines.Add(timeStr + Msg);
  SplitViewForm.Memo1.Lines.EndUpdate;
  // SplitViewForm.Memo1.Text:=Trim(SplitViewForm.Memo1.Text);
  // SplitViewForm.Memo1.SelStart:=Length(SplitViewForm.Memo1.Text);

  SplitViewForm.Memo1.Perform(WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure LogBuffer0(buf: array of byte; Len: Integer);
var
  i: Integer;
  str: String;
begin
  str := '';
  for i := 0 to Len - 1 do
  begin
    str := str + Format('%.02x ', [buf[i]]);
    if ((i + 1) mod 16) = 0 then
    begin
      Log0(str);
      str := '';
    end;
  end;
  if str <> '' then
    Log0(str);

end;

function GetSpecialFolderDir(const folderid: Integer): string;
var
  PIDL: PItemIDList; // pItemIDList;     // LPCITEMIDLIST
  buffer: array [0 .. 255] of Char;
begin
  // 取指定的文件夹项目表
  SHGetSpecialFolderLocation(Application.Handle, folderid, PIDL);
  SHGetPathFromIDList(PIDL, buffer); // 转换成文件系统的路径
  Result := strpas(buffer);
end;

Procedure TSplitViewForm.WMSysCommand(var Msg: TWMMenuSelect);
var
  str: String;
begin
  // Log(inttostr(SystemMainMenu.Handle));
  // Log(inttostr(Msg.Menu));
  // Log(inttostr(Msg.IDItem));
  // str:=GetStyle(Msg.IDItem-1);
  // Log(str);
  // if Msg.IDItem = 1026 then
  // Showmessage(Application.Title + '  ' + VERSIONNAME)
  if Msg.IDItem = 1025 then
  begin
    SetWindowPos(SplitViewForm.Handle, HWND_TOPMOST, SplitViewForm.Left, SplitViewForm.Top, SplitViewForm.Width, SplitViewForm.Height, 0);
  end
  else if { (Msg.Menu = SystemMainMenu.Handle) and }
    (Msg.IDItem >= LOW(TStyleManager.StyleNames)) and (Msg.IDItem <= High(TStyleManager.StyleNames)) then
  begin
    // Log(inttostr(Msg.Menu));
    // Log(inttostr(Msg.IDItem));
    str := GetStyle(Msg.IDItem - 1);
    if str <> '' then
      AdjustSetStyle(str);
  end
  else
    inherited;
end;

procedure TSplitViewForm.OcComPortObjCallBack(Count: Integer);
begin
  StatusBarPrintFileSize();
  if CheckBox10.Checked then
    CharMoveSeries(0, Count);
end;

procedure TSplitViewForm.StatusBar1DrawProgress(progress: Integer; progressMax: Integer);
begin
  StatusBar1.Panels[1].Style := psOwnerDraw;
  self.Fprogress := progress;
  self.FprogressMax := progressMax;
  StatusBar1.Repaint;
end;

procedure TSplitViewForm.StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
  str: String;
begin
  if (Panel.Index = 1) and (Fprogress = 0) and (FprogressMax = 0) then
  begin
    str := 'http://www.1234998.top';
    with StatusBar1.Canvas do
    begin
      Brush.Color := clMenuBar;
      Font.Color := clBlack;
      // X := Floor((Rect.Right - Rect.Left) * Fprogress / FprogressMax);
      Rectangle(Rect.Left, Rect.Top, Rect.Width, Rect.Height);
      TextOut(Rect.Left, Rect.Top, str);
      // TextOut(Rect.TopLeft.X+3,Rect.TopLeft.Y, str);
    end;
    exit;
  end;
  if (Panel.Index = 1) and (Fprogress >= 0) and (FprogressMax > 0) and (Fprogress <= FprogressMax) then
  begin
    str := IntToStr(Floor(self.Fprogress / self.FprogressMax * 100)) + '%';
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

end;

procedure TSplitViewForm.StatusBarPrintFileSize();
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(GetCurrentDeviceName());
  if (OcComPortObj = nil) then
  begin
    exit;
  end;
  if (OcComPortObj.LogMemo <> nil) and (OcComPortObj.Connected) then
  begin
    // StatusBar1.Panels.BeginUpdate;
    StatusBar1.Panels.Items[2].Text := OcComPortObj.Port + ' | Sent: ' + IntToStr(OcComPortObj.ComSentCount) + ' Bytes | ' + 'Received: ' + IntToStr(OcComPortObj.ComReceiveCount) + ' Bytes | ' +
      'Processed: ' + IntToStr(OcComPortObj.ComProcessedCount) + ' Bytes | ' + 'Total: ' + IntToStr(Length(OcComPortObj.LogMemo.Text)) + ' Bytes | ' + 'Line: ' +
      IntToStr(OcComPortObj.LogMemo.CaretPos.Y) + ' | ' + 'Lines: ' + IntToStr(OcComPortObj.LogMemo.Lines.Count) + ' | Packs: ' + IntToStr(OcComPortObj.GetPacks);
    // StatusBar1.Panels.EndUpdate;
  end
  else
  begin
    StatusBar1.Panels.Items[2].Text := OcComPortObj.Port + ' | Sent: ' + IntToStr(OcComPortObj.ComSentCount) + ' Bytes | ' + 'Received: ' + IntToStr(OcComPortObj.ComReceiveCount) + ' Bytes | ' +
      'Processed: ' + IntToStr(OcComPortObj.ComProcessedCount) + ' Bytes | ' + 'Total: ' + IntToStr(Length(Memo1.Text)) + ' Bytes | ' + 'Line: ' + IntToStr(Memo1.CaretPos.Y) + ' | ' + 'Lines: ' +
      IntToStr(Memo1.Lines.Count) + ' | Packs: ' + IntToStr(OcComPortObj.GetPacks);
  end;

  StatusBar1.Update;
  Application.ProcessMessages;
end;

procedure TSplitViewForm.Button10Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj = nil then
  begin
    if TabSet2.TabIndex = 0 then
      Memo1.Clear;
    StatusBar1.Panels.Items[2].Text := '';
    exit;
  end;
  if not OcComPortObj.Connected then
  begin
    if TabSet2.TabIndex = 0 then
      Memo1.Clear;
    StatusBar1.Panels.Items[2].Text := OcComPortObj.Port + ' | Sent: 0' + ' Bytes | ' + 'Received: 0' + ' Bytes | ' + 'Processed: 0' + ' Bytes | ' + 'Total: 0' + ' Bytes | ' + 'Line: 0' + ' | ' +
      'Lines: 0' + ' | Packs: 0';
    exit;
  end;
  OcComPortObj.ClearLog;
end;

procedure TSplitViewForm.Button9Click(Sender: TObject);
var
  s, ss: String;
  // P: Pchar;
  b: array of byte;
  i: Integer;
begin
  s := Trim(Memo3.Text);
  // Memo4.Lines.Add(Inttostr(Length(s)));
  // Memo4.Lines.Add(Inttostr(sizeof(s)));
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

procedure TSplitViewForm.ButtonColor1Click(Sender: TObject);
begin
  CharSeriesSetColor(0, ButtonColor1.SymbolColor);
end;

procedure TSplitViewForm.ButtonColor2Click(Sender: TObject);
begin
  CharSeriesSetColor(1, ButtonColor2.SymbolColor);
end;

procedure TSplitViewForm.Button11Click(Sender: TObject);
var
  str, s: String;
  // i: Integer;
  buf: array [0 .. 1023] of byte;
begin
  str := Trim(Memo2.Text);
  s := '';
  s := FormatHexStr(Trim(str), buf);
  // Memo3.Text := ByteToWideString(@buf, length(buf));
  Memo3.Lines.Append(ByteToWideString(@buf, Length(buf)));
end;

procedure TSplitViewForm.Button15Click(Sender: TObject);
begin
  CheckBox10.Checked := False;
  Chart1.BottomAxis.Automatic := True;
  Chart1.Invalidate;
end;

{
  I2C =0
  SPI
  RS232
  RS485
  RS422
  CAN
  IRDA
  ZigBee
  Wireless
  ModBus

}
procedure TSplitViewForm.Button16Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
  str: String;
  Datas: array [0 .. 1023] of byte;
  Ret: Boolean;
  i, AdressCount, Count2, WantReadCount: Integer;
  ID: Word;
  Addressb: array [0 .. 9] of byte;
  rwCount: Integer;
  // address1: String;
  // fT260_STATUS: Integer;
  SL: TStringList;
  // sendFormat:Integer;
begin

  OcComPortObj := GetDeciceByFullName(GetCurrentDeviceName());

  if (OcComPortObj = nil) then
  begin
    // Log0('No device is found,please open a device.');
    MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  if (not OcComPortObj.Connected) then
  begin
    // Log0('No device is found,please open a device.');
    MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  SL := TStringList.Create;
  // ExtractStrings([ ' '],   [],   PChar(str),   SL); ExtractStrings函数分割字符串
  AdressCount := FormatHexStrToByte2(Trim(ComboBox10.Text), Addressb);
  WantReadCount := StrToInt(Trim(ComboBox11.Text));
  str := '';
  for i := 0 to Memo5.Lines.Count - 1 do
    str := str + Trim(Memo5.Lines.Strings[i]) + ' ';
  str := Trim(str);
  // sendFormat:= ComboBox6.ItemIndex;

  case ComboBox6.ItemIndex of
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

  OcComPortObj.SendProtocolData(OCCOMPROTOCAL_HEAD2, OCCOMPROTOCAL_DATA, Datas, Count2, False);

  { case ComboBox9.ItemIndex of
    0: // octopus
    begin
    // ID := OCCOMPROTOCAL_DATA;
    OcComPortObj.SendProtocolData(OCCOMPROTOCAL_HEAD2, OCCOMPROTOCAL_DATA, Datas, Count2, False);
    end;
    1: // i2c
    begin
    // ID := OCCOMPROTOCAL_I2C_READ;
    end
    end; }

  SL.Clear;
  SL.Free;
end;

procedure TSplitViewForm.Button17Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if ColorDialog1.Execute then
  begin
    Memo1.Color := ColorDialog1.Color;
    if OcComPortObj <> nil then
      if OcComPortObj.LogMemo <> nil then
        OcComPortObj.LogMemo.Color := ColorDialog1.Color;
  end;
end;

procedure TSplitViewForm.Button12Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);

  if OcComPortObj = nil then
    FontDialog1.Font := OcComPortObj.LogMemo.Font
  else
    FontDialog1.Font := Memo1.Font;

  if FontDialog1.Execute then
  begin
    Memo1.Font := FontDialog1.Font;
    if OcComPortObj <> nil then
      if OcComPortObj.LogMemo <> nil then
        OcComPortObj.LogMemo.Font := FontDialog1.Font;
  end;
end;

procedure TSplitViewForm.Button13Click(Sender: TObject);
var
  i, bLength: Integer;
  buffer: array [0 .. 1020] of byte;
  ss: String;
  by: byte;
begin
  by := 0;
  for i := 0 to Memo2.Lines.Count - 1 do
    ss := ss + Trim(Memo2.Lines.Strings[i]) + ' ';
  try
    ss := FormatHexStrToByte(ss, buffer, bLength);
  except
    Showmessage('There are too many datas to fomat,but the max length is 1024.');
  end;

  for i := Low(buffer) to High(buffer) do
    by := QuickCRC8(buffer[i], by); // 快速查表计算CRC

  // by := by + buffer[i];

  Memo2.Text := ss + ' ' + Format('%.02x ', [by]);
end;

procedure TSplitViewForm.Button14Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
  CodePage: Integer;
  // data : array[0..255] of byte;
begin
  // zeroMemory(@data,sizeOf(data));
  // IntToBuffer(123456,Data,4);测试

  OcComPortObj := GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if OcComPortObj = nil then
  begin
    exit;
  end;
  OcComPortObj.Timeouts.ReadInterval := StrToInt(LabeledEdit1.Text);

  case Combobox_CodePage.ItemIndex of
    0:
      CodePage := 0;
    1:
      CodePage := 1;
    2:
      CodePage := 2;
    3:
      CodePage := 42;
    4:
      CodePage := CP_UTF7;
    5:
      CodePage := CP_UTF8;
  else
    CodePage := 0;
  end;
  OcComPortObj.CodePage := CodePage;
end;

procedure TSplitViewForm.StopReceiveFile(OcComPortObj: TOcComPortObj);
begin
  if OcComPortObj = nil then
  begin
    exit;
  end;
  try
    if (CompareText(ExtractFileExt(SaveDialog1.FileName), '.xls') = 0) or (CompareText(ExtractFileExt(SaveDialog1.FileName), '.xlsx') = 0) then
    begin

      OcComPortObj.FileStreamName := '';

    end // File Stream file free in OcComPortObj
    else
    begin
      OcComPortObj.FileStreamName := '';
      if OcComPortObj <> nil then
      begin
        OcComPortObj.FileStream.Free;
        OcComPortObj.FileStream := nil;
      end;
    end;
  except
  end;
end;

procedure TSplitViewForm.Button18Click(Sender: TObject);
begin
  CharZoomSeries(-10);
end;

procedure TSplitViewForm.Button19Click(Sender: TObject);
begin
  CharZoomSeries(10);
end;

procedure TSplitViewForm.Button1Click(Sender: TObject);
var
  i: Integer;
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj = nil then
  begin
    exit;
  end;

  if not OcComPortObj.Connected then
  begin
    // OcComPortObj.Log('The device was closed,please open a device.');
    exit;
  end;

  if OcComPortObj.Connected then
  begin
    { pif LoopStringList = nil then
      LoopStringList := TStringList.Create;
      LoopStringList.Clear;

      for i := 1 to StringGrid1.RowCount - 1 do
      begin
      if Trim(StringGrid1.Cells[1, i]) = '1' then
      LoopStringList.Append(Trim(StringGrid1.Cells[2, i]));
      end;


      FTimer1Timer_Count := UpDown3.Position;
      if (LoopStringList <> nil) and (LoopStringList.Count > 0) then
      begin
      if FTimer1Timer_Count > 0 then
      OcComPortObj.Log('The following data will be sent to device periodic,' +
      'top loop Count: ' + inttostr(FTimer1Timer_Count));

      for i := 0 to LoopStringList.Count - 1 do
      begin
      OcComPortObj.Log(LoopStringList.Strings[i]);
      end;
    }
    Timer1.Enabled := False;
    // Timer1.Interval := UpDown1.Position;
    Timer1.Enabled := True;
    { end
      else
      begin
      OcComPortObj.Log
      ('No data to send, please select data item by click checkbox item.');
      exit;
      end; }

  end;
end;

procedure TSplitViewForm.Button20Click(Sender: TObject);
var
  FileName: String;
  ExcelApp: Variant;
  i: Integer;
begin
  if (SaveDialog1.Execute) and (SaveDialog1.FileName <> '') then
  begin
    try
      FileName := Trim(SaveDialog1.FileName);
      ExcelApp := CreateOleObject('Excel.Application');
      ExcelApp.Visible := True;
      ExcelApp.Caption := Application.Title;
      ExcelApp.WorkBooks.Add; // 新增工作簿
      ExcelApp.Worksheets[1].Activate; // 打开第2个工作表
      ExcelApp.Cells[2, 1].Value := 'X';
      ExcelApp.Cells[2, 2].Value := 'Y';
      for i := 0 to Chart1.Series[0].Count - 1 do
      begin
        ExcelApp.Cells[i + 2, 1].Value := Chart1.Series[0].XValues.Value[i];
        ExcelApp.Cells[i + 2, 2].Value := Chart1.Series[0].YValues.Value[i];
      end;
      // ExcelApp.SaveAs(fileName);
      // ExcelApp.WorkBooks.Close;
      // ExcelApp.Quit;
      // ExcelApp:=Unassigned;//释放excel进程
      // Chart1.SaveToBitmapFile(fileName+'.bmp');
      // TeeSaveToVMLFile(Chart1, fileName+'.html');
    except
    end;
  end;

end;

function TSplitViewForm.SaveToTheExcelFile(ExcelApp: Variant; Buff: array of byte; Length: Integer; Rows: Integer): Integer;
var
  FileName: String;
  i: Integer;
begin
  Result := Rows;
  if Length = 0 then
    exit;

  try
    for i := 0 to Length - 1 do
    begin
      ExcelApp.Cells[Rows, 2].Value := Buff[i];
      INC(Rows);
    end;
  except
  end;
  Result := Rows;
end;

procedure TSplitViewForm.Button21Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj = nil then
  begin
    exit;
  end;
  OcComPortObj.FastLineSeries.Clear;
  // CharResetSeries();
end;

procedure TSplitViewForm.Button22Click(Sender: TObject);
begin
  if (SaveDialog1.Execute) and (SaveDialog1.FileName <> '') then
  begin
    Chart1.SaveToBitmapFile(SaveDialog1.FileName + '.bmp');
  end;

end;

procedure TSplitViewForm.Button23Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
  FileStream: TFileStream;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  { if OcComPortObj = nil then
    begin
    // OcComPortObj.Log('No device is found,please open a device.');
    MessageBox(SplitViewForm.Handle,
    PChar('     No device is found,please open a device.     '),
    PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
    end;
    if not OcComPortObj.Connected then
    begin
    // OcComPortObj.Log('Device was closed,please open a device.    ');
    MessageBox(SplitViewForm.Handle,
    PChar('     Device was closed,please open a device.     '),
    PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
    end; }

  if OpenDialog1.Execute then
  begin
    FullFileNameLoaded := OpenDialog1.FileName;
    if IsHexFile(FullFileNameLoaded) then
    begin
      // Memo1.Lines.LoadFromFile(FullFileNameLoaded);
    end;

    if FileExists(FullFileNameLoaded) then
    begin
      FileStream := readFileToStream(FullFileNameLoaded);
      OcComPortObj.Log(' ');
      OcComPortObj.Log('File Name: ' + FullFileNameLoaded);
      OcComPortObj.Log('File Size: ' + IntToStr(FileStream.Size) + ' Bytes');
      // OcComPortObj.Log('This file have been loaded,press the left-bottom button to start sending');
      if (FileStream.Size > 1024 * 1024 * 5) then
      begin
        OcComPortObj.Log('This file size is too biger,only support less then 5M size file.');
        FullFileNameLoaded := '';
      end;
      FileStream.Free;
      FileStream := nil;
    end;
  end;
end;

procedure TSplitViewForm.SendFileAsCommon(OcComPortObj: TOcComPortObj);
var
  i, Len: Integer;
  buffer: array [0 .. 31] of byte;
  ss: String;
begin
  { if (FFileStream <> nil) then
    begin
    // sz := FileStream.Size;
    FFileStream.Seek(0, soFromBeginning);
    if (not OcComPortObj.Connected) then
    begin
    OcComPortObj.Log('Device was closed,please open a device.');
    exit;
    end;
    OcComPortObj.Log('> Start Sending File:' + FullFileNameLoaded);

    while True do
    begin
    // Log('FileStream.Position='+Inttostr(FileStream.Position));
    ZeroMemory(@buffer, sizeof(buffer));
    Len := FFileStream.Read(buffer, sizeof(buffer));
    if (Len <= 0) then
    break;

    OcComPortObj.FalconComSendBuffer(buffer, Len);
    Application.ProcessMessages;
    ss := '';
    for i := 0 to Len - 1 do
    begin
    ss := ss + Format('%.02x ', [buffer[i]]);
    end;
    OcComPortObj.Log(ss);
    end;
    OcComPortObj.Log('File have been sent successfully。');
    FFileStream.Free;
    FFileStream := nil;
    FullFileNameLoaded := '';
    end; }
end;

procedure DelayDelay(msec: Integer);
// 延时函数，msec   为毫秒(千分之1秒)
var
  FirstTickCount: real;
begin
  FirstTickCount := GetTickCount();
  FirstTickCount := FirstTickCount + msec;
  While FirstTickCount > GetTickCount() do
    Application.ProcessMessages; // 关键在这里
end;

procedure TSplitViewForm.SendFileAsHex(OcComPortObj: TOcComPortObj; FileName: String);
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
  checksum: dword;
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
  // iDataCount := 0;
  fileSent := 0;
  checksum := 0;

  Data[0] := $FF;
  Data[1] := $0A;

  Data[2] := OCCOMPROTOCAL_INBOOT; // 进入bootLAOD
  Data[3] := $00;

  Data[4] := $00;

  Data[5] := $00; // 数据长度
  Data[6] := $00; // 数据长度

  Data[7] := $00; // 数据
  Data[8] := $00; // 数据
  pPOcComPack := @Data[0]; // 实际发送的时候长度不包括CRC
  bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, OCCOMPROTOCAL_INBOOT);

  if not bStatusOK then
  begin
    OcComPortObj.Log('device is not ready to receive file!');
    exit;
  end;
  // OcComPortObj.Log('Device is ready to receive file.');

  StatusBar1DrawProgress(0, 0);
  Data[2] := OCCOMPROTOCAL_FLASH_WRITE; // 写FLASH

  for i := 0 to SL.Count - 1 do
  begin
    Application.ProcessMessages;
    str := SL.Strings[i];
    if str[1] <> ':' then
    begin
      OcComPortObj.Log('The file format is wrong.');
      break;
    end;

    if str = ':00000001FF' then // 结束标记
    begin
      Data[2] := OCCOMPROTOCAL_DATA_COMPLETE;
      Data[5] := 6;
      IntToBuffer(fileSent, &Data[7], 2);
      IntToBuffer(checksum, &Data[9], 4);
      pPOcComPack := @Data[0];
      bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, Data[2]);
      DelayDelay(30);
      OcComPortObj.LogBuff('file size:', &Data[7], 2);
      OcComPortObj.LogBuff('file summ:', &Data[9], 4);
      break;
    end;

    tempstr := Copy(str, 2, 2); // 数据长度
    FormatHexStrToBuffer(tempstr, &Data[5], bCount);
    iLength := Data[5]; // 先读出有效负载,不包括CRC
    Data[5] := 4 { 32 Flash地址 } + iLength; // 有效数据的长度

    dataType := Copy(str, 8, 2); // 数据类型
    if dataType = '04' then // 扩展的高位地址
    begin
      tempstr := Copy(str, 10, iLength * 2); // 数据
      FormatHexStrToBuffer(tempstr, &Data[7], bCount);
      baseAddress := MakeDWord(MakeWord(Data[7], Data[8]), 0);
      bb4 := Data[7];
      bb3 := Data[8];
      // OcComPortObj.Log('Other Data：'+str);
    end
    else if dataType = '00' then
    begin
      // OcComPortObj.Log('Record Data Count:'+IntToStr(iDataCount));
      tempstr := Copy(str, 4, 4); // 数据地址
      FormatHexStrToBuffer(tempstr, &Data[9], bCount); // 9、10

      tempstr := Copy(str, 10, iLength * 2 + 2); // 数据 加2个字符为CRC一个字节
      FormatHexStrToBuffer(tempstr, &Data[11], bCount); // buffer里面包括CRC

      Data[7] := bb4;
      Data[8] := bb3;

      fileSent := fileSent + iLength;
      checksum := checksum + ChecksumBuffer(&Data[11], iLength); // 计算sum不要算上crc
      pPOcComPack := @Data[0]; // 实际发送的时候长度不包括CRC
      bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, Data[7]);

      StatusBar1DrawProgress(i + 1, SL.Count);
      if (not bStatusOK) then
        break;
    end
    else
    begin
      // OcComPortObj.Log('Other Data：'+str);
    end;
  end; // for

FINISHED_OVER:
  if bStatusOK = False then
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

procedure TSplitViewForm.SendFileAsBin(OcComPortObj: TOcComPortObj; FileName: String);
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

  Data[2] := OCCOMPROTOCAL_INBOOT; // 进入bootLAOD
  Data[3] := $00;

  Data[4] := $00;

  Data[5] := $00; // 数据长度不包括数据包头和后面的结束位/CRC
  Data[6] := $00; // 数据长度不包括数据包头和后面的结束位/CRC
  // 实体
  Data[7] := $00; // 数据
  Data[8] := $00; // 数据
  Data[9] := $00; // 数据
  Data[10] := $00; // 数据
  // 进入BOOT LOLOAD MODE
  pPOcComPack := @Data[0]; // 实际发送的时候长度不包括CRC
  bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, OCCOMPROTOCAL_INBOOT);
  if not bStatusOK then
  begin
    OcComPortObj.Log('device is not ready to receive file!');
    exit;
  end;

  // 准备传输数据
  try
    tempstr := Trim(ComboBox10.Text);
    FormatHexStrToBuffer(tempstr, &Data[7], bCount);
    baseAddress := MakeDWord(MakeWord(Data[7], Data[8]), MakeWord(Data[9], Data[10]));
  except
    OcComPortObj.Log('invalide base addresss =' + tempstr);
    exit;
  end;

  StatusBar1DrawProgress(0, 0);
  OcComPortObj.Log('Base Addresss: ' + tempstr);
  Data[2] := OCCOMPROTOCAL_FLASH_WRITE; // 写FLASH

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
      // 通知发送完成
      bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, Data[2]);
      DelayDelay(30);
      OcComPortObj.LogBuff('file size:', &Data[7], 2);
      OcComPortObj.LogBuff('file summ:', &Data[9], 4);
      break;
    end;

    Data[5] := 4 { 32 Flash地址 } + iLength; // 有效数据长度不包括数据包头和后面的结束位/CRC

    // if dataType = '00' then
    begin
      IntToBuffer(baseAddress, &Data[7], 4);
      checksum := checksum + ChecksumBuffer(&Data[11], iLength); // 计算sum
      pPOcComPack := @Data[0]; // 实际发送的时候长度不包括CRC

      // 发送数据
      bStatusOK := OcComPortObj.SendProtocolPackageWaitACK(pPOcComPack, Data[7]);
      // OcComPortObj.LogBuff('>', Data, Data[5] + 7 + 1); // 数据实体长度+包头+CRC

      fileSent := fileSent + iLength;
      StatusBar1DrawProgress(fileSent, MemoryStream.Size);

      if (not bStatusOK) then
        break;
      baseAddress := baseAddress + DEFAULT_LENGTH;
    end;
    // else;
  end; // for

FINISHED_OVER:
  if bStatusOK = False then
    OcComPortObj.Log('Transmit file failed!')
  else
    OcComPortObj.Log('Transmit file finished!');
  MemoryStream.Free;
end;

procedure TSplitViewForm.Button24Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  if ComboBoxEx1.Items.Count <= 0 then
    exit;
  OcComPortObj := GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if OcComPortObj = nil then
  begin
    OcComPortObj.Log('No device is found,please open a device.');
    exit;
  end;

  if not FileExists(FullFileNameLoaded) then
  begin
    OcComPortObj.Log('do not exist the file ' + FullFileNameLoaded);
    exit;
  end;

  if IsHexFile(FullFileNameLoaded) then
  begin
    SendFileAsHex(OcComPortObj, FullFileNameLoaded);
  end
  else
    SendFileAsCommon(OcComPortObj);
end;

procedure TSplitViewForm.Button25Click(Sender: TObject);
var
  i, bLength: Integer;
  buffer: array [0 .. 1023] of byte;
  ss: String;
  // OcComPortObj: TOcComPortObj;
begin
  // OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  // if ComboBox6.ItemIndex = ORD(S_HexadecimalFormat) then
  // if ComboBox6.ItemIndex <> ORD(S_HexadecimalFormat) then Exit;
  ss := '';
  Memo2.Text := Trim(Memo2.Text);

  for i := 0 to Memo2.Lines.Count - 1 do
    ss := ss + Trim(Memo2.Lines.Strings[i]) + ' ';

  try
    // ss := FormatHexStrToByte(ss, buffer,bLength);
    ss := FormatHexStrToBuffer(ss, buffer, bLength);
  except
    Showmessage('There are too many datas to fomat,but the max length is 1024.');
  end;

  // Len := (Length(ss) + 2) div 3;
  Memo2.Text := ss;
  i := Pos('(', Button25.Caption);
  if i > 0 then
    Button25.Caption := Copy(Button25.Caption, 1, i - 1) + '( ' + IntToStr(bLength) + ' ) Bytes'
  else
    Button25.Caption := Button25.Caption + ' ( ' + IntToStr(bLength) + ' ) Bytes';
end;

procedure TSplitViewForm.Button26Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj = nil then
    exit;
  SaveDialog1.FileName := GetSystemDateTimeStampStr + '_' + OcComPortObj.Port + '.log';

  if (SaveDialog1.Execute) and (SaveDialog1.FileName <> '') then
  begin
    if TabSet2.TabIndex = 0 then
      Memo1.Lines.SaveToFile(SaveDialog1.FileName)
    else if (OcComPortObj.LogMemo <> nil) then
      OcComPortObj.LogMemo.Lines.SaveToFile(SaveDialog1.FileName)
    else
      Memo1.Lines.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TSplitViewForm.Button27Click(Sender: TObject);
begin
  Memo5.Clear;
end;

procedure TSplitViewForm.Button28Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
  FileStream: TFileStream;
  FileNameLoaded: String;
begin
  if ComboBoxEx1.Items.Count <= 0 then
    exit;
  OcComPortObj := GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if OcComPortObj = nil then
  begin
    OcComPortObj.Log('No device is found,please open a device.');
    exit;
  end;

  if not OcComPortObj.Connected then
  begin
    OcComPortObj.Log('No device is found,please open a device.');
    exit;
  end;

  FileNameLoaded:='Null';
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

  ComboBox9.ItemIndex := 0; // octopus 协议发送文件
  ComboBox7.ItemIndex := Ord(OctopusProtocol);
  ComboBox7.OnChange(self);//设置协议接收格式

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
    SendFileAsCommon(OcComPortObj);
  end;

  if (FileStream <> nil) then
  begin
    FileStream.Free;
  end;
  FileStream := nil;
end;

procedure TSplitViewForm.Button2Click(Sender: TObject);
var
  ss: String;
  Index, ID, Idx: Integer;
  fT260_STATUS: Integer;
begin
  ss := Trim(Button2.Caption);
  Index := Pos('开', ss);
  ID := Pos('Open', ss);

  if (ComboBoxEx1.Items.Count <= 0) or (ComboBoxEx1.ItemIndex < 0) or (Trim(ComboBoxEx1.Text) = '') then
  begin
    // Log0('No device found');
    Button2.Caption := GetDefaultLauguageStrByName('OPRATION_OPEN', UILanguage);
    exit;
  end;

  if (Index > 0) or (ID > 0) then
  begin
    CurrentDevicesJvHidDevice := CheckHID(GetCurrentDeviceName());
    if (CurrentDevicesJvHidDevice <> nil) then
    begin
{$IFDEF CPU32BITS}
      Idx := GetHID_IDX(GetCurrentDeviceName());
      CurrentDevicesJvHidDevice := nil;
      // FJvHidDeviceController1.CheckOutByID(CurrentDevicesJvHidDevice,CurrentDevicesJvHidDevice.Attributes.VendorID,CurrentDevicesJvHidDevice.Attributes.ProductID);
      FJvHidDeviceController1.CheckOutByIndex(CurrentDevicesJvHidDevice, Idx);
      // fT260_STATUS := FT260_OpenByDevicePath(PChar(CurrentDevicesJvHidDevice.PnPInfo.DevicePath),@CurrentDevicesJvHidDevicePFT260_HANDLE);
      // fT260_STATUS := FT260_I2CMaster_Init(CurrentDevicesJvHidDevicePFT260_HANDLE, 200);
      Button2.Caption := GetDefaultLauguageStrByName('OPRATION_CLOSE', UILanguage) + ' ' + FalconGetComPort(GetCurrentDeviceName());
      Log0('Open device ' + CurrentDevicesJvHidDevice.PnPInfo.DevicePath);
{$ENDIF}
    end
    else
      OpenDevice2(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  end
  else
  begin
    if (CurrentDevicesJvHidDevice <> nil) then
    begin
{$IFDEF CPU32BITS}
      // Idx:=GetHID_IDX(GetCurrentDeviceName());
      if (CurrentDevicesJvHidDevice <> nil) then
        FJvHidDeviceController1.CheckIn(CurrentDevicesJvHidDevice);
      CurrentDevicesJvHidDevice := nil;
      // FT260_Close(@CurrentDevicesJvHidDevicePFT260_HANDLE);
      Button2.Caption := GetDefaultLauguageStrByName('OPRATION_OPEN2', UILanguage) + ' ' + FalconGetComPort(GetCurrentDeviceName());
{$ENDIF}
    end
    else
      CloseDevice2(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  end;

  MultiCOMPort_UI_Update(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  // Self.Update;
end;

procedure TSplitViewForm.Button3Click(Sender: TObject);
begin
  // Timer1.Enabled := False;
  Timer1.Tag := 0;
end;

procedure TSplitViewForm.Button4Click(Sender: TObject);
begin
  UIUpdateDeviceHandleProcess();
  ComboBoxEx1Change(self);
end;

procedure TSplitViewForm.Button5Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  if ComboBoxEx1.Items.Count <= 0 then
    exit;
  OcComPortObj := GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if OcComPortObj = nil then
  begin
    exit;
  end;
  if not OcComPortObj.Connected then
  begin
    exit;
  end;
  OcComPortObj.ClearLog;
  OcComPortObj.ClearInternalBuff; // 高级清楚内部缓存

  IF FileExists(OctopusCfgDir + CONFIGURATION_DIR + 'Lang_CN.ini') then
    DeleteFile(OctopusCfgDir + CONFIGURATION_DIR + 'Lang_CN.ini');
  IF FileExists(OctopusCfgDir + CONFIGURATION_DIR + 'Lang_EN.ini') then
    DeleteFile(OctopusCfgDir + CONFIGURATION_DIR + 'Lang_EN.ini');
end;

procedure TSplitViewForm.Button6Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(OctopusCfgDir), nil, nil, SW_SHOWNORMAL);
end;

procedure TSplitViewForm.Button7Click(Sender: TObject);
// var
// OcComPortObj: TOcComPortObj;
begin
  { OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
    if OcComPortObj = nil then
    begin
    exit;
    end;
    if not OcComPortObj.Connected then
    begin
    exit;
    end;
    OcComPortObj.ClearLog; }
  Memo2.Lines.Clear;
end;

procedure TSplitViewForm.Button8Click(Sender: TObject);
var
  // i: Integer;
  buffer: array [0 .. 255] of byte;
  ss: String;
  OcComPortObj: TOcComPortObj;
  JvHidDevice: TJvHidDevice;
  bLength: Integer;
  BytesWritten: Cardinal;
begin
  if ComboBoxEx1.Items.Count <= 0 then
    exit;
  OcComPortObj := GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  JvHidDevice := nil; // CurrentDevicesJvHidDevice;
  // self.CheckHID(self.GetCurrentDeviceName);
  if (OcComPortObj = nil) and (JvHidDevice = nil) then
  begin
    // Log0('No device is found,please open a device.');
    MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  if (not OcComPortObj.Connected) then
  begin
    // Log0('No device is found,please open a device.');
    MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  if (JvHidDevice <> nil) then
  begin
    ss := FormatHexStrToByte(Trim(Memo2.Text), buffer, bLength);
    // Count := (Length(ss) + 2) div 3;
    HIDWrite(JvHidDevice, buffer, bLength, BytesWritten);
    if BytesWritten > 0 then
      Log0(ss)
    else
    begin
      Log0('> ' + ss);
      Log0('Write faile');
    end;
  end
  else
  begin
    ss := Trim(Memo2.Text);
    OcComPortObj.FalconComSendData_MultiTimes(ss, ComboBox6.ItemIndex);
  end;
end;

procedure TSplitViewForm.cbxVclStylesChange(Sender: TObject);
begin
  if cbxVclStyles.Text <> '' then
  begin
    TStyleManager.SetStyle(cbxVclStyles.Text);
    SplitViewForm.Update;
    SplitViewForm.Repaint;
  end;
end;

procedure TSplitViewForm.CheckBox11Click(Sender: TObject);
begin
  CharInit(CheckBox11.Checked);
end;

procedure TSplitViewForm.CheckBox12Click(Sender: TObject);
begin
  UpdateOcComPortObjAtrribute();
  Combobox_CodePage.OnChange(self);
end;

procedure TSplitViewForm.CheckBox25Click(Sender: TObject);
begin
  UpdateOcComPortObjAtrribute();
end;

procedure TSplitViewForm.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then
    SetWindowPos(SplitViewForm.Handle, HWND_TOPMOST, SplitViewForm.Left, SplitViewForm.Top, SplitViewForm.Width, SplitViewForm.Height, 0)
  else
    SetWindowPos(SplitViewForm.Handle, HWND_NOTOPMOST, SplitViewForm.Left, SplitViewForm.Top, SplitViewForm.Width, SplitViewForm.Height, 0);
end;

procedure TSplitViewForm.CheckBox3Click(Sender: TObject);
begin
  UpdateOcComPortObjAtrribute();
end;

procedure TSplitViewForm.CheckBox4Click(Sender: TObject);
begin
  UpdateOcComPortObjAtrribute();
end;

procedure TSplitViewForm.CheckBox5Click(Sender: TObject);
begin
  UpdateOcComPortObjAtrribute();
end;

procedure TSplitViewForm.CheckBox7Click(Sender: TObject);
begin
  SplitViewForm.AlphaBlendValue := UpDown2.Position;
  SplitViewForm.AlphaBlend := CheckBox7.Checked;
end;

procedure TSplitViewForm.CheckBox8Click(Sender: TObject);
begin
  Timer2.Enabled := CheckBox8.Checked;
end;

procedure TSplitViewForm.ComboBox10KeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', 'a' .. 'f', 'A' .. 'F', ' ', #8]) then
    Key := #13;
end;

procedure TSplitViewForm.ComboBox11KeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', #8]) then
    Key := #13;
end;

procedure TSplitViewForm.ComboBox1Change(Sender: TObject);
var
  str: String;
  btl: Integer;
  OcComPortObj: TOcComPortObj;
begin

  if ComboBoxEx1.Items.Count <= 0 then
  begin
    MessageBox(SplitViewForm.Handle, 'Please specify a device for custom baudrate.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  OcComPortObj := GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if OcComPortObj = nil then
  begin
    MessageBox(SplitViewForm.Handle, 'Please specify a device for custom baudrate.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  if ComboBox1.ItemIndex = 0 then
  begin
    // str := inputbox(Application.Title, 'Please Input Custom Baudrate:', inttostr(OcComPortObj.CustomBaudRate));
    if InputQuery(Application.Title, 'Please Input Custom Baudrate:', str) then
    begin
      try
        btl := StrToInt(str);
        OcComPortObj.CustomBaudRate := btl;
        // ComboBox1.Text:= str;
        if ComboBox1.Items.IndexOf(str) < 0 then
          ComboBox1.Items.Add(str);
        // MessageBox(SplitViewForm.Handle, PChar('You have set custom baudrate to: ' + str + '.                    '), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
        OcComPortObj.Log('You have set the custom baudrate to: ' + str);
        // Combobox1.Items.Strings[0]:= Combobox1.Items.Strings[0]+' ('+ str+')';
        ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(str);
      except
        ComboBox1.ItemIndex := 13;
        MessageBox(SplitViewForm.Handle, 'Wrong baud rate,Please input a integer number. ', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
        exit;
      end;
    end
    else
    begin
      ComboBox1.ItemIndex := 13;
    end;
  end;

  if (ComboBox1.ItemIndex <= MAX_BAUDRATE_INDEX) then // High(TBaudRate))
  begin // 内置波特率
    OcComPortObj.BaudRate := TBaudRate(ComboBox1.ItemIndex);
  end
  else
  begin // 自定义波特率
    OcComPortObj.BaudRate := TBaudRate(0);
    OcComPortObj.CustomBaudRate := StrToInt(ComboBox1.Text);
  end;

end;

procedure TSplitViewForm.ComboBox6Change(Sender: TObject);
begin
  UpdateOcComPortObjAtrribute();
end;

procedure TSplitViewForm.ComboBox7Change(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin

  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj = nil then // 没有设备
  begin
    exit;
  end;

  if (ComboBox7.ItemIndex = Ord(SaveToFile)) and (OcComPortObj.FileStream = nil) then
  begin
    if (SaveDialog1.Execute) and (SaveDialog1.FileName <> '') then
    begin
      if (CompareText(ExtractFileExt(SaveDialog1.FileName), '.xls') = 0) or (CompareText(ExtractFileExt(SaveDialog1.FileName), '.xlsx') = 0) then
      begin
        try
          OcComPortObj.ExcelApp := CreateOleObject('Excel.Application');
          OcComPortObj.ExcelApp.Visible := True;
          OcComPortObj.ExcelApp.Caption := Application.Title;
          OcComPortObj.ExcelApp.WorkBooks.Add; // 新增工作簿
          OcComPortObj.ExcelApp.Worksheets[1].Activate; // 打开第2个工作表
        Except
          OcComPortObj.Log('Do not find Excel Application ');
        end;
      end
      else if (CompareText(ExtractFileExt(SaveDialog1.FileName), '.txt') = 0) and (CompareText(ExtractFileExt(SaveDialog1.FileName), '.log') = 0) then
      begin

      end
      else
      begin
        OcComPortObj.FileStream := TFileStream.Create(SaveDialog1.FileName, fmShareExclusive or fmCreate);
      end;

      OcComPortObj.Log('Data file save to ' + SaveDialog1.FileName);
      OcComPortObj.FileStreamName := Trim(SaveDialog1.FileName);
    end
    else
    begin
      ComboBox7.ItemIndex := Ord(ASCIIFormat);
    end;
  end
  else
    StopReceiveFile(OcComPortObj);

  if (ComboBox7.ItemIndex = Ord(Graphic)) then
    OcComPortObj.FastLineSeries := self.CharInitSeries(True);

  UpdateOcComPortObjAtrribute();
end;

procedure TSplitViewForm.ComboBox8Change(Sender: TObject);
begin
  UpdateOcComPortObjAtrribute();
end;

procedure TSplitViewForm.ComboBoxEx1Change(Sender: TObject);
var
  sDriverName: string;
  i: Integer;
begin
  if (ComboBoxEx1.Items.Count <= 0) or (ComboBoxEx1.Text = 'None') then
  begin
    Button2.Caption := GetDefaultLauguageStrByName('OPRATION_OPEN', UILanguage);
    exit;
  end;
  if ComboBoxEx1.ItemIndex < 0 then
    ComboBoxEx1.ItemIndex := 0;
  sDriverName := Trim(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  sDriverName := FalconGetComPort(sDriverName);

  if Pos('PID', sDriverName) > 0 then
  begin
    Button2.Caption := GetDefaultLauguageStrByName('OPRATION_OPEN2', UILanguage) + ' ' + sDriverName;
    exit;
  end;

  i := Notebook2.Pages.IndexOf(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if i >= 0 then
  begin
    TabSet2.TabIndex := i; // goto tab show
  end;

  MultiCOMPort_UI_Update(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
end;

procedure TSplitViewForm.Combobox_CodePageChange(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
  CodePage: Cardinal;
begin
  if not CheckBox12.Checked then
    exit;

  case Combobox_CodePage.ItemIndex of
    0:
      CodePage := 0;
    1:
      CodePage := 1;
    2:
      CodePage := 2;
    3:
      CodePage := 42;
    4:
      CodePage := CP_UTF7;
    5:
      CodePage := CP_UTF8;
  else
    CodePage := 0;
  end;

  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj = nil then // 没有设备
  begin
    exit;
  end;
  OcComPortObj.CodePage := CodePage;
end;

procedure TSplitViewForm.W1234998NewWindow2(ASender: TObject; var ppDisp: IDispatch; var Cancel: WordBool);
begin
  // Cancel:=True; //禁止弹出窗口
end;

procedure TSplitViewForm.WMDeviceChange(var Msg: TMessage);
var
  pHDR: PDEV_BROADCAST_HDR;
  pVOLUME: PDEV_BROADCAST_VOLUME;
  pOEM: PDEV_BROADCAST_OEM;
  pPORT: PDEV_BROADCAST_PORT;
  // dvName: string;
  DeviceType: string; // 设备类型，媒体设备，网络驱动器
  // DeviceAction: string; // 设备动作
  DeviceName: string; // 设备磁盘名
  // MCIO              : TMCI_Open_Parms;      //MMSystem
begin
  pPORT := nil;
  DeviceName := '';
  pHDR := PDEV_BROADCAST_HDR(Msg.LParam);
  if pHDR = nil then
    exit;
  // Log('Change= ' + inttostr(pHDR^.dbch_devicetype));
  case pHDR^.dbch_devicetype of
    DBT_DEVTYP_VOLUME:
      begin
        pVOLUME := PDEV_BROADCAST_VOLUME(pHDR);
        DeviceName := IntToHex(pVOLUME^.dbcv_unitmask, 8);
        if Boolean(pVOLUME^.dbcv_flags and DBTF_MEDIA) then
        begin
          DeviceType := '媒体设备 ';
        end
        else
        begin
          if Boolean(pVOLUME^.dbcv_flags and DBTF_NET) then
          begin
            DeviceType := '网络驱动器 ';
          end
          else
            DeviceType := '未知设备类型 0x' + IntToHex(pVOLUME^.dbcv_flags, 8) + ' ';
        end;

        DeviceName := FirstDriveFromMask(pVOLUME^.dbcv_unitmask) + ':';

        case GetDriveType(PChar(DeviceName)) of
          DRIVE_UNKNOWN:
            DeviceType := DeviceType + '未知类型';
          DRIVE_NO_ROOT_DIR:
            DeviceType := DeviceType + '根目录不存在';
          DRIVE_REMOVABLE:
            DeviceType := DeviceType + '可移除';
          DRIVE_FIXED:
            DeviceType := DeviceType + '不可移除';
          DRIVE_REMOTE:
            DeviceType := DeviceType + '网络';
          DRIVE_CDROM:
            DeviceType := DeviceType + 'CDROM';
          DRIVE_RAMDISK:
            DeviceType := DeviceType + 'RAM';
        end; // Case GetDriveType(PChar(DeviceName)) Of
      end; // DBT_DEVTYP_VOLUME
    DBT_DEVTYP_OEM:
      begin
        DeviceType := 'OEM- or IHV-defined device type. ';
        pOEM := PDEV_BROADCAST_OEM(pHDR);
        DeviceName := IntToHex(pOEM^.dbco_identifier, 8);
      end;
    DBT_DEVTYP_PORT:
      begin
        DeviceType := '端口设备（串并口） ';
        pPORT := PDEV_BROADCAST_PORT(pHDR);
        DeviceName := pPORT^.dbcp_name;
      end;
  end;

  case Msg.wParam of
    DBT_DEVNODES_CHANGED:
      begin
        // Log('Change.');
      end;
    DBT_DEVICEARRIVAL:
      begin
        if (pPORT <> nil) and (DeviceName <> '') then
        begin
          Log0('Device ' + DeviceName + ' attached' + #13#10);
          UIUpdateDeviceHandleProcess(DeviceName, DBT_DEVICEARRIVAL);
        end;
      end;
    DBT_DEVICEREMOVECOMPLETE:
      begin
        if (pPORT <> nil) and (DeviceName <> '') then
        begin
          Log0('Device ' + DeviceName + ' unattached');
          // if Trim(DeviceName) = OctopusComPort1.Port then
          // begin
          // OpenCloseTheDevice(false);
          // end;
          UIUpdateDeviceHandleProcess(DeviceName, DBT_DEVICEREMOVECOMPLETE);
        end;
      end;

    DBT_DEVICEREMOVEPENDING:
      begin

      end;

  end;
end;

procedure TSplitViewForm.UIUpdateDeviceHandleProcess(DevideName: String = ''; ActionType: Integer = $8000);
var
  imid, i: Integer;
  DevideNameList: TStringList;
  OcComPortObj: TOcComPortObj;
  s: String;
  IniFile: TIniFile;
begin
  try
    ComboBoxEx1.Clear;
    DeviceIconList.Clear;
    if OcComPortList = nil then
      OcComPortList := TStringList.Create;
    // OcComPortList.Clear;
    imid := 0;
    DevideNameList := TStringList.Create;
    GetTheHardDevice('ports', DeviceIconList, DevideNameList, imid);
    OcComPortObj := GetDeciceByPort(DevideName);

    if (OcComPortObj <> nil) and (ActionType = DBT_DEVICEREMOVECOMPLETE) then
    begin
      if OcComPortObj.Connected then
        CloseDevice2(OcComPortObj.OcComPortObjPara.ComportFullName);
      // OcComPortObj.Close;//设备移除，关闭它
    end;

    if DevideNameList.Count = 0 then
    begin
      ComboBoxEx1Change(self);
      exit;
    end;

    ComboBoxEx1.ItemsEx.BeginUpdate;
    ComboBoxEx1.Images := DeviceIconList;

    OcComPortList.BeginUpdate;
    for i := 0 to DevideNameList.Count - 1 do
    begin
      ComboBoxEx1.ItemsEx.AddItem(DevideNameList.Strings[i], imid, imid, imid, -1, nil);
      ComboBoxEx1.ItemsEx.Items[i].ImageIndex := imid;
      if (OcComPortList.IndexOf(DevideNameList.Strings[i])) < 0 then
      begin
        OcComPortObj := TOcComPortObj.Create(self, DevideNameList.Strings[i]);
        s := OctopusCfgDir + CONFIGURATION_DIR + OcComPortObj.OcComPortObjPara.ComportFullName + '.ini';

        // 配置非全局信息
        OcComPortObj.LoadSettings(stIniFile, s);
        try
          IniFile := TIniFile.Create(s);
          OcComPortObj.ReceiveFormat := IniFile.ReadInteger('', 'ReceiveFormat', 0);
          OcComPortObj.SendFormat := IniFile.ReadInteger('', 'SendFormat', 0);
        finally
          IniFile.Free;
        end;
        OcComPortList.AddObject(DevideNameList.Strings[i], OcComPortObj);
      end;
    end;

    for i := 0 to OcHIDDeviceList.Count - 1 do
    begin
      ComboBoxEx1.ItemsEx.AddItem(OcHIDDeviceList.Strings[i], 0, 0, 0, -1, nil);
    end;
    // ComboBoxEx1.ItemsEx.AddItem('NONE', imid, imid, imid, -1, nil);
    ComboBoxEx1.ItemsEx.EndUpdate;
    OcComPortList.EndUpdate;
    // ComboBoxEx1.Perform(CB_SHOWDROPDOWN, 1, 0);
  finally
    DevideNameList.Free;
  end;

end;

procedure TSplitViewForm.Edit22KeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', #8]) then
    Key := #13;
end;

procedure TSplitViewForm.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', #8]) then
  begin
    Key := #13;
    exit;
  end;

end;

procedure TSplitViewForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  FileName: String;
  // ShotCutName: String;
begin
  try
    ProjectSave(True);
    MultiComPortSaveLog();
    CurrentDevices := nil;
    if CheckBox1.Checked then
    begin
      CreateShortcut(Application.Exename, ApplicatonShortcutName);
      { if (ApplicatonShortcutName = ApplicatonShortcutName64) then
        begin
        FileName := ExtractFileDir(Application.Exename) + '\OctopusWin32.exe';
        ShotCutName := ApplicatonShortcutName32;
        end
        else
        begin
        FileName := ExtractFileDir(Application.Exename) + '\OctopusWin64.exe';
        ShotCutName := ApplicatonShortcutName64;
        end;
        if FileExists(FileName) then
        CreateShortcut(FileName, ShotCutName); }
    end;
  Finally
  end;
end;

procedure TSplitViewForm.TabSetChange(Sender: TObject; NewTab: Integer);
var
  i: Integer;
  str: String;
begin
  if NewTab < 0 then
    exit;
  if Sender = TObject(SplitViewForm.TabSet3) then
  begin
    Notebook3.PageIndex := NewTab;
    Splitter1Moved(self);
  end;

  if Sender = TObject(SplitViewForm.TabSet2) then
  begin
    Notebook2.PageIndex := NewTab;
    i := ComboBoxEx1.Items.IndexOf(Notebook2.Pages[NewTab]);
    if i >= 0 then // goto device
    begin
      ComboBoxEx1.ItemIndex := i;
      MultiCOMPort_UI_Update(self.GetCurrentDeviceName);
      // change devices configuration
      // TabSet3.TabIndex := 0;
      // Notebook3.PageIndex := 0;
      exit;
    end;
    if SplitViewForm.Notebook2.PageIndex = SplitViewForm.Notebook2.Pages.Count - 1 then
    // help  goto help website
    begin
      self.GetOctopusHelpFile();
    end
    else if SplitViewForm.Notebook2.PageIndex = SplitViewForm.Notebook2.Pages.Count - 2 then // 图形
    begin
      TabSet3.TabIndex := SplitViewForm.TabSet3.Tabs.Count - 1;
      Notebook3.PageIndex := Notebook3.Pages.Count - 1;
    end
    else
    begin
      // TabSet3.TabIndex := 0;
      // Notebook3.PageIndex := 0;
    end;
  end;

  if Sender = TObject(SplitViewForm.TabSet1) then
  begin
    Notebook1.PageIndex := NewTab;
  end;
end;

procedure InitFlashAdressMapping(Rows: Integer; Cols: Integer);
// var
// address, i: Integer;
begin
  // address := 0;
  { SplitViewForm.StringGrid2.RowCount := Rows + 1;
    SplitViewForm.StringGrid2.ColCount := Cols + 1;
    SplitViewForm.StringGrid2.ColWidths[0] := 100;
    for i := 1 to SplitViewForm.StringGrid2.RowCount - 1 do
    begin
    SplitViewForm.StringGrid2.Cells[0, i] := Format('%.08x ', [address]);
    // '0' + inttostr(i)
    address := address + Cols;
    end;
    for i := 1 to DEFAULT_ADDRESSMAP_COLS  do
    begin
    SplitViewForm.StringGrid2.ColWidths[i] := 35;
    SplitViewForm.StringGrid2.Cells[i, 0] := Format('%.02d', [i-1]);
    end; }
end;

procedure TSplitViewForm.FormCreate(Sender: TObject);
var
  i: Integer;
  bmp: TBitmap;
  j: TRECEIVE_FORMAT;
  GridRect: TGridRect;
  StyleName: String;
  ComComboBox: TComComboBox;
  OcComPortObj: TOcComPortObj;
  CheckDeviceThreak:TCheckDeviceThreak;
begin
  FJvHidDeviceController1 := TJvHidDeviceController.Create(nil);
  FJvHidDeviceController1.OnDeviceData := JvHidDeviceController1DeviceData;
  FJvHidDeviceController1.OnDeviceChange := JvHidDeviceController1DeviceChange;
  FJvHidDeviceController1.OnEnumerate := JvHidDeviceController1Enumerate;
  CurrentDevicesJvHidDevice := nil;
  CurrentDevices := nil;
  Application.OnMessage := MyAppMsg;
  ComComboBox := TComComboBox.Create(self);
  ComComboBox.Parent := self;
  ComComboBox.Visible := False;
  FCheck := TBitmap.Create;
  FNoCheck := TBitmap.Create;
  bmp := TBitmap.Create;
  // Bitmap.DrawMode   := dmTransparent;
  // Bitmap.OuterColor := Bitmap.PixelS[0,0];
  // ProgressBar1.Parent:=StatusBar1;
  FprogressMax := 0;
  Fprogress := 0;

  try
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

  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    StringGrid1.Cells[0, i] := Format('%.04d ', [i]); // '0' + inttostr(i)
    StringGrid1.Cells[3, i] := '1';
    StringGrid1.Cells[4, i] := '10';
  end;
  with GridRect do
  begin
    Top := 2;
    Left := 2;
    Bottom := 2;
    Right := 2;
  end;
  StringGrid1.Selection := GridRect;

  ComComboBox.ComProperty := cpBaudRate;
  ComComboBox.Refresh;
  ComboBox1.Items := ComComboBox.Items;
  ComboBox1.Items.Add('1000000');
  ComboBox1.Items.Add('1152000');
  ComboBox1.Items.Add('1500000');
  ComboBox1.Items.Add('2000000');
  ComboBox1.Items.Add('2500000');
  ComboBox1.Items.Add('3000000');
  ComboBox1.Items.Add('3500000');
  ComboBox1.Items.Add('4000000');

  ComComboBox.ComProperty := cpDataBits;
  ComComboBox.Refresh;
  ComboBox2.Items := ComComboBox.Items;
  // ComboBox2.ItemIndex := 3; // Ord(OctopusComPort1.DataBits);

  ComComboBox.ComProperty := cpStopBits;
  ComComboBox.Refresh;
  ComboBox3.Items := ComComboBox.Items;
  // ComboBox3.ItemIndex := 0; // Ord(OctopusComPort1.StopBits);

  ComComboBox.ComProperty := cpParity;
  ComComboBox.Refresh;
  ComboBox4.Items := ComComboBox.Items;
  // ComboBox4.ItemIndex := 0; // Ord(OctopusComPort1.Parity.Bits);

  ComComboBox.ComProperty := cpFlowControl;
  ComComboBox.Refresh;
  ComboBox5.Items := ComComboBox.Items;

  ComboBox7.Clear;
  // for j := Low(RECEIVE_FORMAT_String) to High(RECEIVE_FORMAT_String) do
  for j := ASCIIFormat to OctopusProtocol do
  begin
    ComboBox7.Items.Add(RECEIVE_FORMAT_String[j]);
  end;

  ComboBox7.ItemIndex := 0;

  for StyleName in TStyleManager.StyleNames do // 初始化主题风格
    cbxVclStyles.Items.Add(StyleName);
  cbxVclStyles.ItemIndex := cbxVclStyles.Items.IndexOf(TStyleManager.ActiveStyle.Name);
  Memo1.Clear;
  Memo1.Tag := 0;
  CharInit(False);

  OcHIDDeviceList := TStringList.Create;
  OctopusCfgDir := ExtractFilePath(Application.Exename) + '\';
  // OctopusCfgDir :=  GetSpecialFolderDir(35) + '\My Octopus\';

  SetCurrentDir(OctopusCfgDir);
  OctopusCfgDir_LogFileName := OctopusCfgDir + LOG_DIR + GetSystemDateTimeStampStr;
  if not DirectoryExists(OctopusCfgDir) then
    CreateDir(OctopusCfgDir);
  if not DirectoryExists(OctopusCfgDir + CONFIGURATION_DIR) then
    CreateDir(OctopusCfgDir + CONFIGURATION_DIR);
  if not DirectoryExists(OctopusCfgDir + LOG_DIR) then
    CreateDir(OctopusCfgDir + LOG_DIR);

  InitFlashAdressMapping(10, DEFAULT_ADDRESSMAP_COLS);
  SV_L.Width := Panel20.Width + 10;
  SV_R.Width := Button9.Width + 10;
  Splitter1.Left := SV_R.Left;
  Splitter1.Parent := SplitViewForm;
  Splitter1.Visible := SV_R.Opened;

  VersionNumberStr := GetBuildInfo(Application.Exename);

  //if GetSystemDefaultLangID() = 2052 then
  BEGIN
    UILanguage := 'CN';
    UpdateUiLaunguage('CN');
    ShowStartComments('CN');
  END;
  {else
  begin
    UILanguage := 'EN';
    UpdateUiLaunguage('EN');
    ShowStartComments('EN');
    CheckBox6.Checked := True;
  end;}

  AdjustComponentFont(SplitViewForm);
  AppendSystemMenu(self.Handle, nil);
  AdjustComponenAttribute(SplitViewForm);

  W1234998.silent := True; // 屏蔽脚本错误
  cbxVclStyles.OnChange(self); // 切换主题

  TabSet1.Tabs := Notebook1.Pages;
  TabSet2.Tabs := Notebook2.Pages;
  TabSet3.Tabs := Notebook3.Pages;

  TabSet1.TabIndex := 0;
  TabSet2.TabIndex := 0;
  TabSet3.TabIndex := 1;

  TabSetChange(TabSet1, 0);
  TabSetChange(TabSet2, 0);
  TabSetChange(TabSet3, 1);

  StatusBar1.Panels.Items[0].Width := StatusBar1.Canvas.TextWidth('操作说明： ESC、F1、F2 123456');
  StatusBar1.Panels.Items[1].Width := StatusBar1.Canvas.TextWidth(DEFAULT_WEBSITE_ADDRESS + ' 123456');
  StatusBar1.Panels.Items[1].Text := DEFAULT_WEBSITE_ADDRESS;
{$IFDEF CPU64BITS}
  TabSet2.SelectedColor := clYellow; // clHighlight; // for 64 bit;
{$ELSE}
  TabSet2.SelectedColor := clRed; // for 32 bit;
{$ENDIF}
  FalconLoadCfg(); // 载入全局设置
  Button4.OnClick(self); // 刷新设备列表
  // 初始化全局配置
  for i := 0 to OcComPortList.Count - 1 do
  begin
    OcComPortObj := TOcComPortObj(OcComPortList.Objects[i]);
    if (OcComPortObj <> nil) then
    begin
      OcComPortObj.OcComPortObjInit2('', '', 13, -1, -1, -1, -1, -1, -1, nil, CheckBox3.Checked, CheckBox25.Checked, CheckBox4.Checked, CheckBox5.Checked, True);

      case ComboBox8.ItemIndex of
        0:
          OcComPortObj.HexModeFormatCount := 16;
        1:
          OcComPortObj.HexModeFormatCount := 32;
        2:
          OcComPortObj.HexModeFormatCount := 0;
      else
        OcComPortObj.HexModeFormatCount := 0;
      end;
    end;
  end;
  ComboBoxEx1Change(self); // 刷新到默认串口设置界面

  try
  CheckDeviceThreak:=TCheckDeviceThreak.Create(true);
  CheckDeviceThreak.ApplicationFileName:=Application.ExeName;
  CheckDeviceThreak.Resume;
  finally
  end;
end;

function TSplitViewForm.FormHelp(Command: Word; Data: NativeInt; var CallHelp: Boolean): Boolean;
begin
  CallHelp := False;
end;

procedure TSplitViewForm.FormShow(Sender: TObject);
begin
  SplitViewForm.Memo1.SetFocus;
end;

procedure TSplitViewForm.ShowHideRLPanel(RL: Integer);
begin
  if RL = 0 then
  begin
    if SV_L.Opened then
      SV_L.Close
    else
      SV_L.Open;
  end;
  if RL = 1 then
  begin
    if SV_R.Opened then
      SV_R.Close
    else
    begin
      if SV_R.OpenedWidth < 20 then
      begin
        SV_R.OpenedWidth := 300;
      end;
      SV_R.Open;
    end;
  end;
end;

procedure TSplitViewForm.MyAppMsg(var Msg: TMsg; var Handled: Boolean);
var
  OcComPortObj: TOcComPortObj;
  keyState: TKeyBoardState;
  i: Integer;
begin
  case Msg.message of
    WM_KEYDOWN:
      begin
        if Msg.wParam = VK_TAB then
        begin

        end;
        if (Msg.wParam = VK_F1) then
        begin
          // Memo1.SetFocus;
          Handled := True;
          ShowHideRLPanel(0);
          Handled := True;
        end;
        if (Msg.wParam = VK_ESCAPE) then
        begin
          OcComPortObj := GetDeciceByFullName(GetCurrentDeviceName);
          i := getDeviceTabIndex(GetCurrentDeviceName);
          if (OcComPortObj <> nil) and (OcComPortObj.LogMemo <> nil) and (OcComPortObj.LogMemo.Parent <> nil) then
          begin
            if (TabSet2.TabIndex = i) then
              OcComPortObj.LogMemo.SetFocus;
            OcComPortObj.LogMemo.ReadOnly := True;
          end;

          if SV_L.Opened or SV_R.Opened then
          begin
            SV_L.Close;
            SV_R.Close;
            Handled := True;
            exit;
          end;
          if (not SV_L.Opened) and (not SV_R.Opened) then
          begin
            SV_L.Open;
            SV_R.Open;
            Handled := True;
          end;
        end;

        if Msg.wParam = VK_F2 then
        begin
          ShowHideRLPanel(1);
          Handled := True;
        end;

        if (Msg.wParam = VK_RETURN) and (SV_L.Opened) then
        begin
          if TabSet2.TabIndex < (TabSet2.Tabs.Count - DEFAULT_FIXED_COLS) then
          begin
            OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
            if (OcComPortObj <> nil) then
              if (OcComPortObj.LogMemo <> nil) and (OcComPortObj.LogMemo.Parent <> nil) then
                OcComPortObj.LogMemo.SetFocus;
          end;
        end;

        GetKeyboardstate(keyState);

        if (Msg.wParam = VK_F3) or ((keyState[VK_LCONTROL] = 129) and (Msg.wParam = 70)) then
        begin
          if TabSet2.TabIndex >= TabSet2.Tabs.Count - DEFAULT_FIXED_COLS then
            exit;

          OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
          if (OcComPortObj = nil) or (OcComPortObj.LogMemo = nil) or (OcComPortObj.LogMemo.Parent = nil) then
          begin
            with FindDialog1 do
            begin
              Left := self.Left + 600;
              Top := self.Top + 150;
              FindText := Memo1.SelText;
              Execute;
              Handled := True;
            end;
            exit;
          end;

          with FindDialog1 do
          begin
            Left := self.Left + 600;
            Top := self.Top + 150;
            FindText := OcComPortObj.LogMemo.SelText;
            Execute;
            Handled := True;
          end;
        end;

      end; // WM_KEYDOWN:begin
    WM_KEYUP:
      begin
        if (Msg.wParam = VK_F1) then
        begin
          Handled := True;
        end;
      end;
  end; // case   msg.message   of
end;

procedure TSplitViewForm.N1Click(Sender: TObject);
begin
  Button10.OnClick(Sender);
end;

procedure TSplitViewForm.N3Click(Sender: TObject);
begin
  Button26.OnClick(Sender);
end;

procedure TSplitViewForm.N5Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj <> nil then
  begin
    if (OcComPortObj.LogMemo <> nil) then
    begin
      OcComPortObj.LogMemo.CopyToClipboard;
    end
    else
    begin
      Memo1.CopyToClipboard;
    end;
  end;
end;

procedure TSplitViewForm.N6Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj <> nil then
  begin
    if (OcComPortObj.LogMemo <> nil) then
    begin
      N6.Enabled := not OcComPortObj.LogMemo.ReadOnly;
      if (N6.Enabled) then
        OcComPortObj.LogMemo.PasteFromClipboard;
      // OcComPortObj.CommadLineStr:=
    end;
  end;
end;

procedure TSplitViewForm.N7Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if (OcComPortObj <> nil) and (OcComPortObj.LogMemo <> nil) then
  begin
    OcComPortObj.LogMemo.SelectAll;
  end
  else if (Memo1.Tag = 0) and (TabSet2.TabIndex = 0) then
  begin
    Memo1.SelectAll;
  end;
end;

procedure TSplitViewForm.UpDown2Changing(Sender: TObject; var AllowChange: Boolean);
begin
  SplitViewForm.AlphaBlendValue := UpDown2.Position;
end;

procedure TSplitViewForm.UpDown5Changing(Sender: TObject; var AllowChange: Boolean);
begin
  Timer2.Interval := UpDown5.Position * 1000;
end;

procedure TSplitViewForm.imgMenuClick(Sender: TObject);
begin
  if SV_L.Opened then
    SV_L.Close
  else
    SV_L.Open;
end;

function TSplitViewForm.GetCurrentDeviceName(): String;
begin
  Result := '';
  if (ComboBoxEx1.Items.Count > 0) and (ComboBoxEx1.ItemIndex >= 0) then
    Result := ComboBoxEx1.Items[ComboBoxEx1.ItemIndex];
end;

function TSplitViewForm.CheckHID_ShortName(DeviceName: String): String;
begin;
end;

function TSplitViewForm.GetHID_IDX(DeviceName: String): Integer;
var
  str: String;
  i: Integer;
begin
  Result := -1;
  i := Pos('(', DeviceName);
  if (i > 0) and (DeviceName[Length(DeviceName)] = ')') then
  begin

    str := Copy(DeviceName, i + 1, Length(DeviceName) - i - 1);
    Result := StrToInt(str);
  end;

end;

function TSplitViewForm.CheckHID(DeviceName: String): TJvHidDevice;
var
  i: Integer;
begin
  Result := nil;
  if Pos('PID', DeviceName) > 0 then
  begin
    i := OcHIDDeviceList.IndexOf(DeviceName);
    Result := TJvHidDevice(OcHIDDeviceList.Objects[i]);
  end;
end;

procedure TSplitViewForm.JvHidDeviceController1DeviceChange(Sender: TObject);
begin
  if OcHIDDeviceList = nil then
    OcHIDDeviceList := TStringList.Create;
  OcHIDDeviceList.Clear;
  FJvHidDeviceController1.Enumerate;
end;

procedure TSplitViewForm.JvHidDeviceController1DeviceData(HidDev: TJvHidDevice; ReportID: byte; const Data: Pointer; Size: Word);
var
  i: Integer;
  str: string;
begin
  str := ''; // Format('ReportID: %.2x  Data: ', [ReportID]);
  for i := 0 to Size - 1 do
    str := str + Format('%.2x ', [Cardinal(PAnsiChar(Data)[i])]);
  Log0(str);
end;

function TSplitViewForm.JvHidDeviceController1Enumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;

var
  Name: String;
  Dev: TJvHidDevice;
begin
  Name := Format('%s VID 0x%.4x PID 0x%.4x(%d)', [HidDev.ProductName, HidDev.Attributes.VendorID, HidDev.Attributes.ProductID, Idx]);

  HidDev.NumInputBuffers := sizeof(THIDReport);
  HidDev.NumOverlappedBuffers := sizeof(THIDReport);
  // FJvHidDeviceController1.CheckOutByIndex(Dev, Idx);

  OcHIDDeviceList.AddObject(Name, Dev);

  Result := True;
end;

procedure TSplitViewForm.HIDWrite(HidDev: TJvHidDevice; buf: Array of byte; WriteCount: Integer; var BytesWritten: Cardinal);
var
  // Written: Cardinal;
  ToWrite: Cardinal;
  b: Boolean;
  Buff: Array [0 .. 512] of byte;
begin
  if Assigned(HidDev) then
  begin
    // SetLength(Buff, Length(buf) + 1);
    ZeroMemory(@Buff, Length(Buff));
    CopyMemory(@Buff[1], @buf, Length(buf));
    Buff[0] := 0;
    ToWrite := HidDev.Caps.OutputReportByteLength;
    if WriteCount > (HidDev.Caps.OutputReportByteLength - 1) then
    begin
      Log0('The data length should less than the devices OutputReportByteLength-1 =' + IntToStr(HidDev.Caps.OutputReportByteLength));
      exit;
    end;
    // ToWrite:= WriteCount+1;
    b := HidDev.WriteFile(Buff, ToWrite, BytesWritten);
  end;
end;

procedure TSplitViewForm.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  try
    if ACol = 1 then
    begin
      if not(gdFixed in State) then
        with TStringGrid(Sender).Canvas do
        begin
          Brush.Color := clWindow;
          fillRect(Rect);
          if StringGrid1.Cells[ACol, ARow] = '1' then
            Draw((Rect.Right + Rect.Left - FCheck.Width) div 2 - 2, (Rect.Bottom + Rect.Top - FCheck.Height) div 2, FCheck)
          else
            Draw((Rect.Right + Rect.Left - FCheck.Width) div 2 - 2, (Rect.Bottom + Rect.Top - FCheck.Height) div 2, FNoCheck);
        end;
    end;
  except
  end;
end;

function TSplitViewForm.GetStringGridValidStr(sStr: String): String;
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

procedure TSplitViewForm.StringGrid1FixedCellClick(Sender: TObject; ACol, ARow: Integer);
var
  GridRect: TGridRect;
  str: String;
  OcComPortObj: TOcComPortObj;
  JvHidDevice: TJvHidDevice;
  buffer: array [0 .. 512] of byte;
  bLength: Integer;
  BytesWritten: Cardinal;
begin
  OcComPortObj := GetDeciceByFullName(Notebook2.ActivePage);
  JvHidDevice := nil; // CurrentDevicesJvHidDevice;
  if ARow > 0 then
  begin
    StringGrid1.Row := ARow;
    str := GetStringGridValidStr(StringGrid1.Cells[2, ARow]);
    // Trim(StringGrid1.Cells[2, ARow]);
    if (str <> '') and (JvHidDevice <> nil) then
    begin
      str := FormatHexStrToByte(Trim(str), buffer, bLength);
      // Count := (Length(str) + 2) div 3;
      HIDWrite(JvHidDevice, buffer, bLength, BytesWritten);
      if (BytesWritten > 0) then
        Log0('> ' + str)
      else
      begin
        Log0('> ' + str);
        Log0('Write faile');
      end;
    end
    else if (OcComPortObj <> nil) then
    begin
      if ComboBox6.ItemIndex = 1 then
        OcComPortObj.FalconComSendData_Common(str, ComboBox6.ItemIndex) // HEX
      else
        OcComPortObj.FalconComSendData_Common(str, ComboBox6.ItemIndex);
      // ASCII
    end
    else
    begin
      MessageBox(Application.Handle, PChar('No device!! You need to open a device,please use F1 to see how to do that'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    end;

    { if StringGrid1.Col >= 3 then
      StringGrid1.Col := 2; // 指定列号

      if (StringGrid1.Col = 2) then
      StringGrid1.Col := 0;
      with GridRect do
      begin
      Top := StringGrid1.Selection.Top;
      Left := 0;
      Bottom := StringGrid1.Selection.Bottom;
      Right := StringGrid1.Selection.Right;
      end;
      StringGrid1.Selection := GridRect;
      // StringGrid1.Invalidate;
      if (StringGrid1.Col = 0) then
      StringGrid1.Col := 2; }

  end;
end;

procedure TSplitViewForm.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (StringGrid1.Col = 3) or (StringGrid1.Col = 4) then
  begin
    if not(Key in ['0' .. '9', #8]) then
      Key := #0;
  end;
end;

procedure TSplitViewForm.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  GridRect: TGridRect;
begin
  if StringGrid1.Row = 0 then
    exit;
  if (StringGrid1.Col = 1) then
  begin
    if StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row] <> '' then
      StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row] := ''
    else
      StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row] := '1';

    with GridRect do
    begin
      Top := StringGrid1.Selection.Top;
      Left := StringGrid1.Selection.Left + 1;
      Bottom := StringGrid1.Selection.Bottom;
      Right := StringGrid1.Selection.Right;
    end;
    StringGrid1.Selection := GridRect;
  end;

end;

procedure TSplitViewForm.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  GridRect: TGridRect;
begin
  if StringGrid1.Row = 0 then
    exit;
  if (StringGrid1.Col = 1) then
  begin
    with GridRect do
    begin
      Top := StringGrid1.Selection.Top;
      Left := StringGrid1.Selection.Left + 1;
      Bottom := StringGrid1.Selection.Bottom;
      Right := StringGrid1.Selection.Right;
    end;
    StringGrid1.Selection := GridRect;
  end;

end;

procedure TSplitViewForm.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  with StringGrid1 do
  begin
    if ACol in [1] then
      Options := Options - [goEditing]
    else
      Options := Options + [goEditing];
  end;
end;

procedure TSplitViewForm.SV_LClosed(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
  i: Integer;
begin
  OcComPortObj := GetDeciceByFullName(GetCurrentDeviceName);
  i := getDeviceTabIndex(GetCurrentDeviceName);
  if OcComPortObj <> nil then
  begin
    if (OcComPortObj.Connected) and (TabSet2.TabIndex = i) then
      OcComPortObj.LogMemo.SetFocus;
  end;
end;

procedure TSplitViewForm.SV_RClosed(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
  i: Integer;
begin
  OcComPortObj := GetDeciceByFullName(GetCurrentDeviceName);
  i := getDeviceTabIndex(GetCurrentDeviceName);
  if OcComPortObj <> nil then
  begin
    if OcComPortObj.Connected and (TabSet2.TabIndex = i) then
      OcComPortObj.LogMemo.SetFocus;
  end;
  Splitter1.Visible := False;
end;

procedure TSplitViewForm.SV_ROpened(Sender: TObject);
begin
  Splitter1.Left := SV_R.Left;
  Splitter1.Parent := SplitViewForm;
  Splitter1.Visible := True;
  Splitter1.Margins.Bottom := 26;
  Splitter1Moved(self);
end;

procedure TSplitViewForm.TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  TabSetChange(Sender, NewTab);
end;

procedure TSplitViewForm.TabSet2Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
var
  i: Integer;
begin
  TabSetChange(Sender, NewTab);
  i := ComboBoxEx1.Items.IndexOf(Notebook2.Pages[NewTab]);
  if i >= 0 then
  begin
    ComboBoxEx1.ItemIndex := i;
    MultiCOMPort_UI_Update(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  end;
end;

procedure TSplitViewForm.TabSet2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  OcComPortObj: TOcComPortObj;
  str: String;
  p: TPoint;
  i: Integer;
begin
  // if ComboBoxEx1.Items.Count <= 0 then
  // Exit;
  str := Trim(Notebook2.ActivePage);
  OcComPortObj := GetDeciceByFullName(str);
  if OcComPortObj = nil then
  begin
    exit;
  end;
  i := ComboBoxEx1.Items.IndexOf(OcComPortObj.OcComPortObjPara.ComportFullName);
  if i >= 0 then
  begin
    ComboBoxEx1.ItemIndex := i;
    ComboBoxEx1.OnChange(self);
  end;
  if Button = mbRight then
  begin
    if UILanguage = 'CN' then
      TabSet2.PopupMenu.Items.Items[0].Caption := '关闭这个设备'
    else
      TabSet2.PopupMenu.Items.Items[0].Caption := 'Close The Device';

    p.X := X + SV_L.Width;
    p.Y := Y + Memo1.Height;
    TabSet2.PopupMenu.Popup(ClientToScreen(p).X, ClientToScreen(p).Y);
    // TabSet2.PopupMenu.Popup(X,Y);
  end;
  if Button = mbMiddle then
    SV_L.Opened := not SV_L.Opened;
end;

procedure TSplitViewForm.TabSet3Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  TabSetChange(Sender, NewTab);
end;

procedure Delay(MSecs: Longint);
// 延时函数，MSecs单位为毫秒(千分之1秒)
var
  FirstTickCount, Now: Longint;
begin
  FirstTickCount := GetTickCount();
  repeat
    Application.ProcessMessages;
    Now := GetTickCount();
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;

procedure TSplitViewForm.Timer1Timer(Sender: TObject); // 循环发送
var
  sStr: string;
  i, j, Count, delayCount: Integer;
begin
  // EnterCriticalSection(Critical);
  if CurrentDevices = nil then
    CurrentDevices := GetDeciceByFullName(self.GetCurrentDeviceName);
  // OcComPortObj := CurrentDevices;
  if (CurrentDevices = nil) or (not CurrentDevices.Connected) then
  begin
    exit;
  end;

  // if FTimer1Timer_Count <> 0 then
  // CurrentDevices.Log('Loop Count --> ' + inttostr(FTimer1Timer_Count) + '');

  // if (FTimer1Timer_Count = 1) and (FTimer1Timer_Count > 0) then
  // begin
  // Timer1.Enabled := False;
  // end;
  Timer1.Tag := 1;
  Timer1.Enabled := False;
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    if Trim(StringGrid1.Cells[1, i]) = '1' then
    begin
      if Timer1.Tag = 0 then
        break;
      try
        sStr := GetStringGridValidStr(StringGrid1.Cells[2, i]);
        // Trim(StringGrid1.Cells[2, i]);
        Count := StrToInt(Trim(StringGrid1.Cells[3, i]));
        delayCount := StrToInt(Trim(StringGrid1.Cells[4, i]));
        if Count = 0 then
          While (True) do
          begin
            CurrentDevices.FalconComSendData_MultiTimes(sStr, ComboBox6.ItemIndex);
            Delay(delayCount);
            if Timer1.Tag = 0 then
              break;
          end
        else
          for j := 0 to Count - 1 do
          begin
            CurrentDevices.FalconComSendData_MultiTimes(sStr, ComboBox6.ItemIndex);
            Delay(delayCount);
          end;

        Delay(delayCount);
      Except
        continue;
      end;
    end;

  end;
  // Timer1.Enabled:=true;
  Timer1.Tag := 0;
  { for i := 0 to LoopStringList.Count - 1 do
    begin
    sStr := LoopStringList.Strings[i];
    if (sStr = '') then
    continue;
    //if ComboBox6.ItemIndex = 1 then
    CurrentDevices.FalconComSendData_MultiTimes(sStr, ComboBox6.ItemIndex)
    //else
    //  CurrentDevices.FalconComSendData_MultiTimes(sStr, ComboBox6.ItemIndex);
    end; }

  // if (FTimer1Timer_Count > 1) then
  // begin
  // FTimer1Timer_Count := FTimer1Timer_Count - 1;
  // end;
  // LeaveCriticalSection(Critical);
end;

procedure TSplitViewForm.Timer2Timer(Sender: TObject); // 自动保存log
begin
  if CheckBox8.Checked then
  begin
    MultiComPortSaveLog();
  end;
end;

procedure TSplitViewForm.Timer3Timer(Sender: TObject); // 项目配置自动保存
begin
  ProjectSave(True);
end;

procedure TSplitViewForm.MultiComPortSaveLog();
var
  i: Integer;
  OcComPortObj: TOcComPortObj;
begin
  for i := 0 to OcComPortList.Count - 1 do
  begin
    OcComPortObj := TOcComPortObj(OcComPortList.Objects[i]);
    if OcComPortObj <> nil then
    begin
      if OcComPortObj.Connected then
      begin
        OcComPortObj.SaveLog(OctopusCfgDir_LogFileName + '_' + OcComPortObj.Port + '.log');
      end;
    end;
  end;
end;

procedure TSplitViewForm.ProjectSave(SavePrivate: Boolean);
var
  Octopusini: TIniFile;
  s: String;
  i: Integer;
begin
  // EnterCriticalSection(Critical);
  if not DirectoryExists(OctopusCfgDir) then
    CreateDir(OctopusCfgDir);
  if not DirectoryExists(OctopusCfgDir + CONFIGURATION_DIR) then
    CreateDir(OctopusCfgDir + CONFIGURATION_DIR);
  Octopusini := nil;

  if SavePrivate then
  begin
    s := OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
    try
      Octopusini := TIniFile.Create(s);
      for i := 1 to StringGrid1.RowCount - 1 do
      begin
        Octopusini.WriteString('MyCustData', IntToStr(i) + '_2', SplitViewForm.StringGrid1.Cells[2, i]);
        Octopusini.WriteString('MyCustData', IntToStr(i) + '_5', SplitViewForm.StringGrid1.Cells[5, i]);
      end;
      Octopusini.WriteInteger('MyPreference', 'Theme', cbxVclStyles.ItemIndex);
      Octopusini.WriteInteger('MyPreference', 'SV_R_WIDTH', SV_R.Width);
      Octopusini.WriteInteger('MyPreference', 'MainFormWidth', SplitViewForm.Width);
      Octopusini.WriteInteger('MyPreference', 'MainFormHeight', SplitViewForm.Height);
      Octopusini.WriteString('MyPreference', 'FONTNAME', Memo1.Font.Name);
      Octopusini.WriteInteger('MyPreference', 'FONTSIZE', Memo1.Font.Size);
      Octopusini.WriteInteger('MyPreference', 'FONTCOLOR', Memo1.Font.Color);
      Octopusini.WriteInteger('MyPreference', 'BACKGROUNDCOLOR', Memo1.Color);

      Octopusini.WriteBool('MyPreference', 'EnglishLanguage', CheckBox6.Checked);
      Octopusini.WriteBool('MyPreference', 'DESKTOPSHOTCUT', CheckBox1.Checked);
      Octopusini.WriteBool('MyPreference', 'SHOWLINENUMBER', CheckBox4.Checked);
      Octopusini.WriteBool('MyPreference', 'ALPHABLEND', CheckBox7.Checked);
      Octopusini.WriteBool('MyPreference', 'CK8', CheckBox8.Checked);
      Octopusini.WriteBool('MyPreference', 'CK2', CheckBox2.Checked);
      Octopusini.WriteBool('MyPreference', 'CK3', CheckBox3.Checked);
      Octopusini.WriteBool('MyPreference', 'CK25', CheckBox25.Checked);
      // Octopusini.WriteBool('MyPreference', 'CK9', CheckBox9.Checked);
      Octopusini.WriteBool('MyPreference', 'CK5', CheckBox5.Checked);
      Octopusini.WriteBool('MyPreference', 'CK6', CheckBox6.Checked);
      Octopusini.WriteBool('MyPreference', 'CK12', CheckBox12.Checked);

      Octopusini.WriteBool('MyPreference', 'SV_LOPEN', SV_L.Opened);
      Octopusini.WriteBool('MyPreference', 'SV_ROPEN', SV_R.Opened);

      Octopusini.WriteInteger('MyPreference', 'CB8', ComboBox8.ItemIndex);
      Octopusini.WriteInteger('MyPreference', 'CB_CODE', Combobox_CodePage.ItemIndex);

      // Octopusini.WriteInteger('MyPreference', 'READINTERVAL', StrToInt(LabeledEdit1.Text));
    finally
      Octopusini.Free;
      // LeaveCriticalSection(Critical);
    end;
  end;
end;

procedure TSplitViewForm.FalconLoadCfg();
var
  Octopusini: TIniFile;
  s: string;
  i: Integer;

begin
  Octopusini := nil;
  if not DirectoryExists(OctopusCfgDir) then
    exit;
  s := OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
  if (not FileExists(s)) then
    exit;
  try
    Octopusini := TIniFile.Create(s);
    for i := 1 to StringGrid1.RowCount - 1 do
    begin
      StringGrid1.Cells[2, i] := Octopusini.ReadString('MyCustData', IntToStr(i) + '_2', '');
      StringGrid1.Cells[5, i] := Octopusini.ReadString('MyCustData', IntToStr(i) + '_5', '');
    end;

    cbxVclStyles.ItemIndex := Octopusini.ReadInteger('MyPreference', 'Theme', 0);
    SV_R.Width := Octopusini.ReadInteger('MyPreference', 'SV_R_WIDTH', SV_R.Width);
    SplitViewForm.Width := Octopusini.ReadInteger('MyPreference', 'MainFormWidth', 1228);
    SplitViewForm.Height := Octopusini.ReadInteger('MyPreference', 'MainFormHeight', 664);

    SV_L.Opened := Octopusini.ReadBool('MyPreference', 'SV_LOPEN', False);
    SV_R.Opened := Octopusini.ReadBool('MyPreference', 'SV_ROPEN', False);
    // UpDown3.Position := Octopusini.ReadInteger('MyPreference', 'LOOPCOUNT', 5);

    Memo1.Font.Name := Octopusini.ReadString('MyPreference', 'FONTNAME', '新宋体');
    Memo1.Font.Size := Octopusini.ReadInteger('MyPreference', 'FONTSIZE', 14);
    Memo1.Font.Color := Octopusini.ReadInteger('MyPreference', 'FONTCOLOR', clSilver);
    Memo1.Color := Octopusini.ReadInteger('MyPreference', 'BACKGROUNDCOLOR', clWindowText);

    // CheckBox4.Checked := Octopusini.ReadBool('MyPreference', 'SHOWLINENUMBER', False);
    CheckBox1.Checked := Octopusini.ReadBool('MyPreference', 'DESKTOPSHOTCUT', True);
    CheckBox7.Checked := Octopusini.ReadBool('MyPreference', 'ALPHABLEND', False);
    CheckBox8.Checked := Octopusini.ReadBool('MyPreference', 'CK8', CheckBox8.Checked);
    CheckBox2.Checked := Octopusini.ReadBool('MyPreference', 'CK2', CheckBox2.Checked);
    CheckBox3.Checked := Octopusini.ReadBool('MyPreference', 'CK3', CheckBox3.Checked);
    CheckBox25.Checked := Octopusini.ReadBool('MyPreference', 'CK25', CheckBox25.Checked);
    // CheckBox9.Checked := Octopusini.ReadBool('MyPreference', 'CK9',
    // CheckBox9.Checked);
    CheckBox5.Checked := Octopusini.ReadBool('MyPreference', 'CK5', CheckBox5.Checked);
    CheckBox6.Checked := Octopusini.ReadBool('MyPreference', 'CK6', CheckBox6.Checked);
    CheckBox12.Checked := Octopusini.ReadBool('MyPreference', 'CK12', True);

    ComboBox8.ItemIndex := Octopusini.ReadInteger('MyPreference', 'CB8', 0);
    Combobox_CodePage.ItemIndex := Octopusini.ReadInteger('MyPreference', 'CB_CODE', 0);

    // LabeledEdit1.Text:= IntToStr(Octopusini.ReadInteger('MyPreference', 'READINTERVAL',30));
  finally
    Octopusini.Free;
  end;
end;

procedure TSplitViewForm.FindDialog1Close(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj <> nil then
    OcComPortObj.LogScrollMode := True;
  self.Show;
end;

procedure TSplitViewForm.FindDialog1Find(Sender: TObject);
var
  FindStr: String;
  OcComPortObj: TOcComPortObj;
  Memo: TMemo;
  bRet: Boolean;
Label ReStart;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  with Sender as TFindDialog do
  begin
    FindStr := FindText;
    if (OcComPortObj = nil) or (OcComPortObj.LogMemo = nil) or (OcComPortObj.LogMemo.Parent = nil) then
    begin
      Memo := Memo1;
    end
    else
    begin
      Memo := OcComPortObj.LogMemo;
    end;
    if Memo = nil then
      exit;
    if Memo.Parent = nil then
      exit;

  ReStart:
    bRet := SearchMemo(Memo, FindStr, Options);

    if bRet = False then
    begin
      if frDown in Options then
      begin
        if MessageBox(Handle, PWideChar(Concat('Not found "', FindStr, '" restart seach from the beginning of the file？')), PChar(Application.Title), MB_YESNO) = ID_YES then
        begin
          Memo.SelStart := 0;
          goto ReStart;
        end;
      end
      else
      begin
        if MessageBox(Handle, PWideChar(Concat('Not found "', FindStr, '" restart seach from the end of the file？       ')), PChar(Application.Title), MB_YESNO) = ID_YES then
        begin
          Memo.SelStart := Memo.GetTextLen;
          goto ReStart;
        end;
      end;
    end;

  end;
end;

function TSplitViewForm.SearchMemo(Memo: TMemo; const SearchString: string; Options: TFindOptions): Boolean;
var
  Size: Integer;
  // StringSearchOptions:TStringSearchOptions;
  buffer, p: PChar;
begin
  Result := False;
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

procedure TSplitViewForm.CheckBox6Click(Sender: TObject);
begin
  if CheckBox6.Checked then
  BEGIN
    UpdateUiLaunguage('EN');
  END
  else
  begin
    UpdateUiLaunguage('CN');
  end;
  MultiCOMPort_UI_Update(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
end;

procedure TSplitViewForm.UpdateUiLaunguage(Lang: String);
var
  i: Integer;
  // OcComPortObj:TOcComPortObj;
begin
  // OcComPortObj:=nil;
  // if ComboBoxEx1.ItemIndex >=0 then
  // OcComPortObj := GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if Lang = 'EN' then
  begin
    UILanguage := 'EN';
    IF NOT FileExists(OctopusCfgDir + CONFIGURATION_DIR + 'Lang_EN.ini') then
      LoadDefaultLaunguage(SplitViewForm, 'EN');
    LoadLaunguageFromFile(SplitViewForm, OctopusCfgDir + CONFIGURATION_DIR + 'Lang_EN.ini');
    Application.Title := 'Octopus SerialPort Complex Terminal R2018a';
    SplitViewForm.Caption := 'Octopus SerialPort Complex Terminal R2018a';
    Notebook1.Pages[0] := 'Octopus Setting F1';
    Notebook1.Pages[1] := 'Advance';

    if Memo1.Tag = 0 then
      Notebook2.Pages[0] := 'Octopus ';

    Notebook2.Pages[Notebook2.Pages.Count - 1] := ' Help ';
    Notebook2.Pages[Notebook2.Pages.Count - 2] := ' Graphic ';
    Notebook3.Pages[0] := 'Send Data ';
    Notebook3.Pages[1] := 'Custom Send';
    Notebook3.Pages[2] := ' Protocol ';
    Notebook3.Pages[3] := ' Graphic ';

    for i := 0 to 2 do
    begin
      StringGrid1.Cells[0, 0] := 'Send';
      StringGrid1.Cells[1, 0] := ' x';
      StringGrid1.Cells[2, 0] := 'Data You Want To Send';
      StringGrid1.Cells[3, 0] := 'Times';
      StringGrid1.Cells[4, 0] := 'Delay';
      StringGrid1.Cells[5, 0] := 'Comments';
    end;
    StatusBar1.Panels.Items[0].Text := 'Hot Key ESC、F1、F2';
    AdjustComponentFont(SplitViewForm, 'EN');
  end
  else
  begin
    UILanguage := 'CN';
    IF NOT FileExists(OctopusCfgDir + CONFIGURATION_DIR + 'Lang_CN.ini') then
      LoadDefaultLaunguage(SplitViewForm, 'CN');
    LoadLaunguageFromFile(SplitViewForm, OctopusCfgDir + CONFIGURATION_DIR + 'Lang_CN.ini');
    Application.Title := APPLICATION_TITLE + VersionNumberStr;
    SplitViewForm.Caption := Application.Title;
    Notebook1.Pages[0] := 'Octopus 串口设置 F1';
    Notebook1.Pages[1] := '高级';

    if Memo1.Tag = 0 then // 设备关闭状态
      Notebook2.Pages[0] := '本地文件目录 ';

    Notebook2.Pages[Notebook2.Pages.Count - 1] := ' 帮助 ';
    Notebook2.Pages[Notebook2.Pages.Count - 2] := ' 图形 ';

    Notebook3.Pages[0] := '数据发送';
    Notebook3.Pages[1] := '批量发送 ';
    Notebook3.Pages[2] := '协议发送 ';
    Notebook3.Pages[3] := '图形 ';

    for i := 0 to 2 do
    begin
      StringGrid1.Cells[0, 0] := '发送';
      StringGrid1.Cells[1, 0] := ' ';
      StringGrid1.Cells[2, 0] := '数据内容';
      StringGrid1.Cells[3, 0] := '次数';
      StringGrid1.Cells[4, 0] := '间隔';
      StringGrid1.Cells[5, 0] := '备注';
    end;
    StatusBar1.Panels.Items[0].Text := '操作说明：ESC、F1、F2、F3';
  end;

  TabSet1.Tabs := Notebook1.Pages;
  TabSet2.Tabs := Notebook2.Pages;
  // TabSet3.Tabs := Notebook3.Pages;
  TabSetChange(TabSet1, 0);
  TabSetChange(TabSet2, 0);
  // TabSetChange(TabSet3, 0);
end;

procedure ShowStartComments(Lang: String);
begin
  if Lang = 'EN' then
  begin
    Log0('################################################');
    Log0('Octopus Serial Port Tool ' + VersionNumberStr);
    // Log0(VERSIONNAME); // 'Version  :2.00'
    Log0('Home Page :' + WEB_SITE + ' ');
    Log0('Function  :' + 'ESC、F1、F2、F3');
    Log0('################################################');
    LastCMDLineStr := GetCurrentDir() + '>';
    Log0('' + LastCMDLineStr);
    // SplitViewForm.Memo2.Clear;
    // SplitViewForm.Memo2.Lines.Add('//You can send any string and file to device at here.');
    // SplitViewForm.Memo2.Lines.Add('//Note:Hex data format like this: 0xal,5e 3f');
  end
  else
  begin
    Log0('################################################');
    Log0('' + APPLICATION_TITLE + VersionNumberStr);
    // Log0('' + VERSIONNAME); // 'Version  :2.00'
    Log0('Home Page :' + WEB_SITE + ' ');
    Log0('Function  :' + 'ESC、F1、F2、F3');
    Log0('################################################');
    LastCMDLineStr := GetCurrentDir() + '>';
    Log0('' + LastCMDLineStr);
    Log0('' + LastCMDLineStr);
  end;
  SplitViewForm.Memo1.Text := Trim(SplitViewForm.Memo1.Text);
  SplitViewForm.Memo1.SelStart := Length(SplitViewForm.Memo1.Text);

end;

procedure ShowStartComments2(OcComPortObj: TOcComPortObj);
begin
  if SplitViewForm.UILanguage = 'EN' then
  begin
    OcComPortObj.Log('################################################');
    OcComPortObj.Log('Octopus Serial Port Tool ' + VersionNumberStr);
    // OcComPortObj.Log(VERSIONNAME); // 'Version  :2.00'
    OcComPortObj.Log('Home Page :' + WEB_SITE + ' ');
    OcComPortObj.Log('Function  :' + 'ESC、F1、F2、F3');
    OcComPortObj.Log('################################################');
    SplitViewForm.Memo2.Clear;
    // SplitViewForm.Memo2.Lines.Add('//You can send any string and file to device at here.');
    // SplitViewForm.Memo2.Lines.Add('//Note:Hex data format like this: 0xal,5e 3f');
  end
  else
  begin
    OcComPortObj.Log('################################################');
    OcComPortObj.Log(APPLICATION_TITLE + VersionNumberStr);
    // OcComPortObj.Log(VERSIONNAME); // 'Version  :2.00'
    OcComPortObj.Log('Home Page :' + WEB_SITE + ' ');
    OcComPortObj.Log('Function  :' + 'ESC、F1、F2、F3');
    OcComPortObj.Log('################################################');
  end;
end;

procedure TSplitViewForm.CloseDevice2(DeviceFullName: String);
var
  OcComPortObj: TOcComPortObj;
  i: Integer;
  s: String;
  Octopusini: TIniFile;
begin
  if OcComPortList = nil then
    exit;
  if DeviceFullName = '' then
    exit;
  i := OcComPortList.IndexOf(DeviceFullName);
  if i < 0 then
    exit;
  OcComPortObj := TOcComPortObj(OcComPortList.Objects[i]);

  try
    if (OcComPortObj <> nil) and (OcComPortObj.Connected) then
    begin
      OcComPortObj.Close;

      if OcComPortObj.LogMemo <> Memo1 then
      begin
        OcComPortObj.ClearLog;
        OcComPortObj.ClearInternalBuff();
        OcComPortObj.LogMemo.Visible := False;
        OcComPortObj.LogMemo.Parent := nil;
      end;

      if (Memo1.Tag = Integer(OcComPortObj)) then
      begin
        Memo1.Tag := 0;
        Memo1.OnKeyDown := Memo1KeyDown;
        Memo1.OnKeyPress := Memo1KeyPress;
        Memo1.ReadOnly := True;
        UpdateUiLaunguage(UILanguage);
      end;

      i := Notebook2.Pages.IndexOf(DeviceFullName);
      if (i > 0) and (OcComPortObj.LogMemo <> Memo1) then
      begin
        Notebook2.Pages.Delete(i);
        TabSet2.Tabs := Notebook2.Pages;
        OcComPortObj.SaveLog(OctopusCfgDir_LogFileName + '_' + OcComPortObj.Port + '.log');
        // 关闭的时候保存一次记录
      end;
      if OcComPortObj.LogMemo = Memo1 then // 最后接触关联
      begin
        OcComPortObj.Log(OcComPortObj.OcComPortObjPara.ComportFullName + ' Closed');
        OcComPortObj.Log(' ');
        OcComPortObj.LogMemo := nil;
      end;
    end;
  except
    OcComPortObj.Log('Can not close  ' + OcComPortObj.OcComPortObjPara.ComportFullName);
  end;

  s := OctopusCfgDir + CONFIGURATION_DIR + OcComPortObj.OcComPortObjPara.ComportFullName + '.ini';

  OcComPortObj.StoreSettings(stIniFile, s);

  try
    Octopusini := TIniFile.Create(s);
    Octopusini.WriteInteger('', 'SendFormat', ComboBox6.ItemIndex);
    Octopusini.WriteInteger('', 'ReceiveFormat', ComboBox7.ItemIndex);
  finally
    Octopusini.Free;
  end;
end;

procedure TSplitViewForm.CloseTheDevice1Click(Sender: TObject);
var
  str: string;
begin
  str := TabSet2.Tabs[TabSet2.TabIndex];
  CloseDevice2(str);
  TabSetChange(TabSet2, 0);
  MultiCOMPort_UI_Update(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
end;

procedure TSplitViewForm.OpenDevice2(DeviceFullName: String);
var
  OcComPortObj: TOcComPortObj;
  Page: TPage;
  Memo: TMemo;
  i: Integer;
begin
  if OcComPortList = nil then
    exit;
  if DeviceFullName = '' then
    exit;

  OcComPortObj := GetDeciceByFullName(DeviceFullName);
  if OcComPortObj = nil then
    exit;
  i := Notebook2.Pages.IndexOf(DeviceFullName);

  if (i < 0) then // 没有显示组件，则创建组件
  begin
    if (Memo1.Tag = 0) then // memo1 没有挂靠
    begin
      OcComPortObj.OcComPortObjInit2('', '', ComboBox1.ItemIndex, ComboBox2.ItemIndex, ComboBox3.ItemIndex, ComboBox4.ItemIndex, ComboBox5.ItemIndex, ComboBox6.ItemIndex, ComboBox7.ItemIndex, Memo1,
        CheckBox3.Checked, CheckBox25.Checked, CheckBox4.Checked, CheckBox5.Checked, True);
      Notebook2.Pages.Strings[0] := OcComPortObj.OcComPortObjPara.ComportFullName;
      TabSet2.Tabs := Notebook2.Pages;
      Memo1.Tag := Integer(OcComPortObj);
    end
    else
    begin
      OcComPortObj.OcComPortObjInit2('', '', ComboBox1.ItemIndex, ComboBox2.ItemIndex, ComboBox3.ItemIndex, ComboBox4.ItemIndex, ComboBox5.ItemIndex, ComboBox6.ItemIndex, ComboBox7.ItemIndex, nil,
        CheckBox3.Checked, CheckBox25.Checked, CheckBox4.Checked, CheckBox5.Checked, True);

      Notebook2.Pages.Insert(Notebook2.Pages.Count - DEFAULT_FIXED_COLS, OcComPortObj.OcComPortObjPara.ComportFullName);
      i := Notebook2.Pages.IndexOf(OcComPortObj.OcComPortObjPara.ComportFullName);
      Page := TPage(self.Notebook2.Pages.Objects[i]);
      Memo := OcComPortObj.LogMemo;
      Memo.Parent := Page;
      Page.Tag := Integer(Memo);
      Memo.Align := alClient;
      Memo.Font := Memo1.Font;
      Memo.Color := Memo1.Color;
      Memo.HideSelection := False;
      Memo.Show;
      Page.DoubleBuffered := True;
      TabSet2.Tabs := Notebook2.Pages;
      OcComPortObj.ClearLog;
      OcComPortObj.ClearInternalBuff();
      ShowStartComments2(OcComPortObj);
    end;
  end;

  case ComboBox8.ItemIndex of
    0:
      OcComPortObj.HexModeFormatCount := 16;
    1:
      OcComPortObj.HexModeFormatCount := 32;
    2:
      OcComPortObj.HexModeFormatCount := 0;
  else
    OcComPortObj.HexModeFormatCount := 0;
  end;

  case Combobox_CodePage.ItemIndex of
    0:
      OcComPortObj.CodePage := 0;
    1:
      OcComPortObj.CodePage := 1;
    2:
      OcComPortObj.CodePage := 2;
    3:
      OcComPortObj.CodePage := 42;
    4:
      OcComPortObj.CodePage := CP_UTF7;
    5:
      OcComPortObj.CodePage := CP_UTF8;
  else
    OcComPortObj.CodePage := 0;
  end;

  OcComPortObj.StringInternalMemo.Parent := self; // 设置大量极限数据的缓冲MEMO
  OcComPortObj.CallBackFun := OcComPortObjCallBack;
  OcComPortObj.LogMemo.PopupMenu := self.PopupMenu1;

  if (OcComPortObj.ReceiveFormat = Ord(Graphic)) and (OcComPortObj.FastLineSeries = nil) then
    OcComPortObj.FastLineSeries := self.CharInitSeries(True);

  try
    OcComPortObj.Open;
  Except
    OcComPortObj.Log('Can not open  ' + OcComPortObj.OcComPortObjPara.ComportFullName);
    exit;
  end;
  if not OcComPortObj.Connected then
  begin
    OcComPortObj.Log('Can not open  ' + OcComPortObj.OcComPortObjPara.ComportFullName);
    exit;
  end;

  OcComPortObj.Log(OcComPortObj.OcComPortObjPara.ComportFullName);

  OcComPortObj.Log('');

  OcComPortObj.SaveLog(OctopusCfgDir_LogFileName + '_' + OcComPortObj.Port + '.log'); // 打开的时候创建日志文件
  i := Notebook2.Pages.IndexOf(DeviceFullName);
  if (i >= 0) then
    TabSet2.TabIndex := i;
  OcComPortObj.LogMemo.ReadOnly := True;
end;

function TSplitViewForm.GetDeciceByFullName(DeviceName: string): TOcComPortObj;
var
  i: Integer;
begin
  Result := nil;
  if DeviceName = '' then
    exit;
  try
    i := OcComPortList.IndexOf(DeviceName);
    if i >= 0 then
      Result := TOcComPortObj(OcComPortList.Objects[i]);
  finally

  end;
end;

function TSplitViewForm.GetDeciceByPort(Port: string): TOcComPortObj;
var
  i: Integer;
  str: String;
begin
  Result := nil;
  if Port = '' then
    exit;
  for i := 0 to OcComPortList.Count - 1 do
  begin
    str := OcComPortList[i];
    if (Pos(Port, str) > 0) then
    begin
      Result := TOcComPortObj(OcComPortList.Objects[i]);
    end;
  end;
end;

procedure TSplitViewForm.UpdateOcComPortObjAtrribute();
var
  OcComPortObj: TOcComPortObj;
begin
  if ComboBoxEx1.Items.Count <= 0 then
    exit;
  OcComPortObj := GetDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if OcComPortObj = nil then
  begin
    exit;
  end;

  // if(CheckBox4.Checked <> OcComPortObj.ShowLineNumber)then
  // begin
  // Button10.OnClick(nil);//显示行号开关改变后，清楚所有日志，重新记录
  // end;
  OcComPortObj.OcComPortObjInit2('', '', ComboBox1.ItemIndex, ComboBox2.ItemIndex, ComboBox3.ItemIndex, ComboBox4.ItemIndex, ComboBox5.ItemIndex, ComboBox6.ItemIndex, ComboBox7.ItemIndex, nil,
    CheckBox3.Checked, CheckBox25.Checked, CheckBox4.Checked, CheckBox5.Checked, True);

  case ComboBox8.ItemIndex of
    0:
      OcComPortObj.HexModeFormatCount := 16;
    1:
      OcComPortObj.HexModeFormatCount := 32;
    2:
      OcComPortObj.HexModeFormatCount := 0;
  else
    OcComPortObj.HexModeFormatCount := 0;
  end;
  OcComPortObj.CompatibleUnicode := CheckBox12.Checked;
end;

// 功能键进入这里
procedure TSplitViewForm.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  CurrentLine: Integer;
  MaskedKeyState: TShiftState;
begin
  if Memo1.Tag <> 0 then
  begin
    exit;
  end;
  CurrentLine := Memo1.CaretPos.Y; // 光标所在的行

  MaskedKeyState := Shift * [ssShift, ssAlt, ssCtrl, ssLeft, ssRight, ssMiddle, ssDouble, ssTouch, ssPen, ssCommand];
  if (Key <> VK_RETURN) and (Key <> VK_PRIOR) and (Key <> VK_NEXT) and (Key <> VK_HOME) and (Key <> VK_END) and (MaskedKeyState = []) then
  begin
    Memo1.SelStart := Length(Memo1.Text);
    Memo1.Perform(WM_VSCROLL, SB_BOTTOM, 0);
  end;

  if Memo1.ReadOnly then
    Memo1.ReadOnly := False;
  if (Key = VK_LEFT) or (Key = 38) OR (Key = 39) OR (Key = 40) then
    Key := 0;

  if (Shift = [ssCtrl]) and (Key = $43) then
  begin
    if (Commandhread <> nil) then
    begin
      Commandhread.Terminate;
      Commandhread.Free;
    end;
  end;
end;

procedure TSplitViewForm.Memo1KeyPress(Sender: TObject; var Key: Char);
var
  str, cmdstr: String;
  i: Integer;
begin
  if Memo1.Tag <> 0 then
  begin
    exit;
  end;

  if (Key = #13) then
  begin
    str := Trim(Memo1.Lines.Strings[Memo1.Lines.Count - 1]);
    i := Pos(LastCMDLineStr, str);
    if i > 0 then
      cmdstr := Trim(Copy(str, Length(LastCMDLineStr) + 1, Length(str)))
    else
      cmdstr := str;
    RunWindosShellCmd(cmdstr, Memo1);
    Key := #0;
    exit;
  end;

  if (Key = #8) then
  begin
    str := Trim(Memo1.Lines.Strings[Memo1.Lines.Count - 1]);
    i := Pos(LastCMDLineStr, str);
    if (Length(LastCMDLineStr) >= Length(str)) and (i > 0) then
      Key := #0;
  end;
  if (Key = #9) and (Commandhread <> nil) then
  begin
    str := Memo1.Lines.Strings[Memo1.Lines.Count - 1];
    if (DirList = nil) then
      SearchFile('./');

    if (CommandIndex >= DirList.Count) then
      CommandIndex := 0;

    i := PosEx(' ', str, Length(LastCMDLineStr));

    if (str[Length(str)] = ' ') then
      str := str + DirList.Strings[CommandIndex]
    else if (i > 0) then
      str := Copy(str, 1, i) + DirList.Strings[CommandIndex]
    else
      str := LastCMDLineStr + DirList.Strings[CommandIndex];

    Memo1.Lines.Strings[Memo1.Lines.Count - 1] := Trim(str);
    INC(CommandIndex);
  end;

end;

procedure TSplitViewForm.MultiCOMPort_UI_Update(DeviceName: string); // 更行当前设备UI
var
  OcComPortObj: TOcComPortObj;
  i: Integer;
begin
  if (ComboBoxEx1.ItemIndex < 0) or (ComboBoxEx1.Text = 'None') then
  begin
    Button2.Caption := GetDefaultLauguageStrByName('OPRATION_OPEN', UILanguage);
    exit;
  end;
  if OcComPortList = nil then
    exit;
  if DeviceName = '' then
    exit;
  i := OcComPortList.IndexOf(DeviceName);
  if i < 0 then
    exit;
  OcComPortObj := TOcComPortObj(OcComPortList.Objects[i]);
  if OcComPortObj = nil then
    exit;

  if OcComPortObj.OcComPortObjPara.BaudRate = 0 then
  begin
    if ComboBox1.Items.IndexOf(IntToStr(OcComPortObj.CustomBaudRate)) < 0 then
    begin
      ComboBox1.Items.BeginUpdate;
      ComboBox1.Items.Add(IntToStr(OcComPortObj.CustomBaudRate));
      ComboBox1.Items.EndUpdate;
    end;
    ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(IntToStr(OcComPortObj.CustomBaudRate));
  end
  else if (OcComPortObj.OcComPortObjPara.BaudRate >= ComboBox1.Items.Count) then
    ComboBox1.ItemIndex := 13
  else
    ComboBox1.ItemIndex := OcComPortObj.OcComPortObjPara.BaudRate;

  ComboBox2.ItemIndex := OcComPortObj.OcComPortObjPara.DataBits;
  ComboBox3.ItemIndex := OcComPortObj.OcComPortObjPara.StopBits;
  ComboBox4.ItemIndex := OcComPortObj.OcComPortObjPara.ParityBits;
  ComboBox5.ItemIndex := OcComPortObj.OcComPortObjPara.FlowControl;
  // ComboBox6.ItemIndex := OcComPortObj.OcComPortObjPara.SendFormat;
  ComboBox7.ItemIndex := OcComPortObj.OcComPortObjPara.ReceiveFormat;

  CheckBox3.Checked := OcComPortObj.OcComPortObjPara.ShowDate;
  CheckBox25.Checked := OcComPortObj.OcComPortObjPara.ShowTime;
  CheckBox4.Checked := OcComPortObj.OcComPortObjPara.ShowLineNumber;
  CheckBox5.Checked := OcComPortObj.OcComPortObjPara.ShowSendedLog;
  // CheckBox9.Checked := OcComPortObj.OcComPortObjPara.HexModeWithString;
  CheckBox12.Checked := OcComPortObj.CompatibleUnicode;

  LabeledEdit1.Text := IntToStr(OcComPortObj.Timeouts.ReadInterval);

  if (OcComPortObj.Connected) then
  begin
    // ComboBox1.Enabled := False;
    ComboBox2.Enabled := False;
    ComboBox3.Enabled := False;
    ComboBox4.Enabled := False;
    ComboBox5.Enabled := False;
    Button2.Caption := GetDefaultLauguageStrByName('OPRATION_CLOSE', UILanguage) + '【' + OcComPortObj.Port + '】';
  end;

  if (not OcComPortObj.Connected) then
  begin
    ComboBox1.Enabled := True;
    ComboBox2.Enabled := True;
    ComboBox3.Enabled := True;
    ComboBox4.Enabled := True;
    ComboBox5.Enabled := True;
    Button2.Caption := GetDefaultLauguageStrByName('OPRATION_OPEN', UILanguage) + '【' + OcComPortObj.Port + '】';
  end;

end;

procedure TSplitViewForm.ShowTrayIcon(TrayIcon1: TTrayIcon);
var
  MyIcon: TIcon;
begin
  { Load the tray icons. }
  TrayIcon1.Icons := TImageList.Create(self);
  MyIcon := TIcon.Create;
  MyIcon.LoadFromFile('icons/earth1.ico');
  TrayIcon1.Icon.Assign(MyIcon);
  TrayIcon1.Icons.AddIcon(MyIcon);

  MyIcon.LoadFromFile('icons/earth2.ico');
  TrayIcon1.Icons.AddIcon(MyIcon);
  MyIcon.LoadFromFile('icons/earth3.ico');
  TrayIcon1.Icons.AddIcon(MyIcon);
  MyIcon.LoadFromFile('icons/earth4.ico');
  TrayIcon1.Icons.AddIcon(MyIcon);

  { Set up a hint message and the animation interval. }
  TrayIcon1.Hint := Application.Title;
  TrayIcon1.AnimateInterval := 200;

  { Set up a hint balloon. }
  TrayIcon1.BalloonTitle := 'Restoring the window.';
  TrayIcon1.BalloonHint := 'Double click the system tray icon to restore the window.';
  TrayIcon1.BalloonFlags := bfInfo;
end;

procedure TSplitViewForm.Splitter1Moved(Sender: TObject);
begin
  // exit;
  Button1.Width := Panel4.Width - Button3.Width - 3;

  Button8.Width := Panel2.Width - Button7.Width - 5;

  Button9.Width := Memo3.Width + 2;
  Button11.Width := Memo3.Width + 2;
  Button25.Width := Button11.Width;
  Button28.Width := Button11.Width;
  Button13.Width := Button11.Width;

  ComboBox9.Width := Memo5.Width - Label7.Width - 25;
  ComboBox10.Width := ComboBox9.Width;
  ComboBox11.Width := ComboBox9.Width;
  ComboBox12.Width := ComboBox9.Width;

  Button16.Width := Button8.Width; // Memo5.Width + 3 - 100;

  ComboBox10.Left := ComboBox9.Left;
  ComboBox11.Left := ComboBox9.Left;
  ComboBox12.Left := ComboBox9.Left;

  Panel15.Width := GroupBox10.Width - 8;
  Button15.Width := Panel15.Width;
  Button21.Width := Panel15.Width;
  Button18.Width := Panel15.Width;
  Button19.Width := Panel15.Width;
  Button20.Width := Panel15.Width;
  Button22.Width := Panel15.Width;
  ButtonColor1.Width := Panel15.Width;
  ButtonColor2.Width := Panel15.Width;

  if Button1.Width > 240 then
    StringGrid1.ColWidths[2] := 240 + (Button1.Width - 240) div 2
  else
    StringGrid1.ColWidths[2] := Button1.Width - 15;
end;

procedure TSplitViewForm.RunWindosShellCmd(str: String; Memo: TMemo);
var
  thid: dword;
  ResultStr, s: String;
  i: Integer;
begin
  i := Pos('cd', str);
  if str = '' then
  begin
    LastCMDLineStr := GetCurrentDir() + '>';
    Memo.Lines.Add(LastCMDLineStr);
    Memo.Text := Trim(Memo.Text);
    Memo.SelStart := Length(Memo.Text);
    exit;
  end;
  if str = 'cd ..' then
  begin
    s := GetCurrentDir() + '\..';
    SetCurrentDir(s);
    LastCMDLineStr := GetCurrentDir() + '>';
    Memo.Lines.Add(LastCMDLineStr);
    Memo.SelStart := Length(Memo.Text);
    Memo.Text := Trim(Memo.Text);
    exit;
  end;

  if str = 'cd -' then
  begin
    SetCurrentDir(OctopusCfgDir); // (ExtractFileDir(Application.Exename));
    LastCMDLineStr := OctopusCfgDir + '>';
    // ExtractFileDir(Application.Exename) + '>';
    Memo.Lines.Add(LastCMDLineStr);
    Memo.SelStart := Length(Memo.Text);
    Memo.Text := Trim(Memo.Text);
    exit;
  end;

  if (i > 0) then
  begin
    s := Trim(Copy(str, 3, Length(str)));
    LastCMDLineStr := GetCurrentDir();
    if DirectoryExists(LastCMDLineStr + '\' + s) then
      SetCurrentDir(LastCMDLineStr + '\' + s)
    else if DirectoryExists(s) then
      SetCurrentDir(s)
    else
      Memo.Lines.Add('无法找到路径： ' + s);

    LastCMDLineStr := GetCurrentDir() + '>';
    Memo.Lines.Add(LastCMDLineStr);
    Memo.SelStart := Length(Memo.Text);
    Memo.Text := Trim(Memo.Text);
    exit;
  end
  else if (DirectoryExists(str)) then
  begin
    SetCurrentDir(str);
    LastCMDLineStr := GetCurrentDir() + '>';
    Memo.Lines.Add(LastCMDLineStr);
    Memo.SelStart := Length(Memo.Text);
    Memo.Text := Trim(Memo.Text);
    exit;
  end;

  try
    if (CmdShellCommadLineStr = '') then
    begin
      ResultStr := 'cmd /C ' + str;
      CmdShellLogMemo := Memo;
      CmdShellCommadLineStr := ResultStr;
      // CreateThread(nil, 0, @RunDosCommand, @CmdShellCommadLineStr, 0, thid);
      Commandhread := nil;
      if Commandhread = nil then
      begin
        Commandhread := TCommandhread.Create(CmdShellCommadLineStr);
        Commandhread.FreeOnTerminate := True;
        Commandhread.Start;
      end;
    end
    else
    begin
      Memo.Lines.Add('你已经有了一个任务正在进行当中。');
      LastCMDLineStr := GetCurrentDir() + '>';
      Memo.Lines.Add(LastCMDLineStr);
      Memo.SelStart := Length(Memo.Text);
      Memo.Text := Trim(Memo.Text);
    end;
  except
  end;
end;

procedure TSplitViewForm.FindDialog1Show(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := GetDeciceByFullName(self.GetCurrentDeviceName);
  if OcComPortObj = nil then
    exit;
  OcComPortObj.LogScrollMode := False;
end;

Initialization

InitializeCriticalSection(Critical);

Finalization

try
  DeleteCriticalSection(Critical);
Except
end;

end.
