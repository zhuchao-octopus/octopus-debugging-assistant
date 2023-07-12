unit uMainSetting;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,
  System.SysUtils,
  System.Classes,
  System.ImageList,

  Vcl.Graphics,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,

  Vcl.ImgList,
  Vcl.MyPageEdit,
  Vcl.Menus,
  Vcl.Grids,
  Vcl.Mask,

  GlobalFunctions,
  OcComPortObj;

type
  TSettingChangedCallBackFuntion = Procedure(Obj: TObject) of object;

  TSettingPagesDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    Panel6: TPanel;
    Panel11: TPanel;
    Panel23: TPanel;
    Label111: TLabel;
    Label110: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    Edit2: TEdit;
    CheckBox8: TCheckBox;
    CheckBox7: TCheckBox;
    Panel24: TPanel;
    CheckBox2: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox1: TCheckBox;
    Panel17: TPanel;
    Panel3: TPanel;
    Button3: TButton;
    ComboBoxEx1: TComboBoxEx;
    Panel19: TPanel;
    Label105: TLabel;
    Label104: TLabel;
    Label103: TLabel;
    Label102: TLabel;
    Label101: TLabel;
    Label100: TLabel;
    Label106: TLabel;
    ComboBox6: TComboBox;
    ComboBox5: TComboBox;
    ComboBox4: TComboBox;
    ComboBox3: TComboBox;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    ComboBox7: TComboBox;
    Panel20: TPanel;
    CBCodePage: TComboBox;
    CBAlignmentMode: TComboBox;
    Label109: TLabel;
    CBSendCodePage: TComboBox;
    Label108: TLabel;
    Label107: TLabel;
    ImageList1: TImageList;
    Button2: TButton;
    Timer1: TTimer;
    Button5: TButton;
    Button4: TButton;
    ComboBox8: TComboBox;
    Button6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxEx1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure UpDown2Changing(Sender: TObject; var AllowChange: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ComboBox8Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
    procedure WMDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE;
  public
    { Public declarations }
    OcComPortList: TStringList;
    OctopusCfgDir: String;
    OctopusCfgDir_LogFileName: String;
    VersionNumberStr: String;
    WindowsVersion: String;

    AlphaBlendValue: Integer;
    AlphaBlend: Boolean;

    SettingChangedCallBackFuntion: TSettingChangedCallBackFuntion;

    procedure updateSystemDevicesList(DevideName: String = ''; ActionType: Integer = $8000);
    procedure initSystemDevicesList();

    function getCurrentDeviceName(): String;
    function getCurrentDevice(): TOcComPortObj;
    function getDeciceByPort(Port: string): TOcComPortObj;
    function getDeciceByFullName(DeviceName: string): TOcComPortObj;
    function getDeciceByIndex(Index: Integer): TOcComPortObj;
    function getAvailableDevice(): TOcComPortObj;

    function openDevice(OcComPortObj: TOcComPortObj): Boolean; overload;
    function openDevice(DeviceFullName: String): TOcComPortObj; overload;
    function openDevice(DeviceFullName: String; LogMemo: TMyRichEdit): TOcComPortObj; overload;
    function openDeviceRandom(): TOcComPortObj;

    procedure closeDevice(DeviceFullName: String); overload;
    procedure closeDevice(OcComPortObj: TOcComPortObj); overload;

    procedure FalconLoadCfg();
    procedure SaveDeviceSetting(OcComPortObj: TOcComPortObj);
    procedure SaveAllComPortLogData(DoClose: Boolean);
    procedure ApplyCodePageSetting();
    procedure updateOcComPortObjAtrribute(OcComPortObj: TOcComPortObj = nil);

    procedure LoadLaunguageFromFile(Form: TForm; Path: String; Create: Boolean);
    procedure LoadOrCreateLaunguageFromFile(Form: TForm; Create: Boolean);
  end;

var
  SettingPagesDlg: TSettingPagesDlg;

function GetSystemDateTimeStampStr(): string;

implementation

{$R *.dfm}

uses ocPcDeviceMgt, IniFiles, uGlobalFunction, CPort, CPortCtl, uDeviceThread;

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

function FirstDriveFromMask(unitmask: Integer): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to 25 do
  begin
    if Boolean(unitmask and 1) then
      Result := Result + Char(Integer('A') + i);
    unitmask := unitmask shr 1;
  end;
end;

function FalconGetComPort(DriverName: string): string;
// const
// pattern = 'COM +d';
var
  ss: string;
  i1, i2: Integer;
  pStr: PChar;
  // match: TMatch;
begin
  DriverName := Trim(DriverName);
  // match:=TRegEx.Match(str,pattern);
  // if match.Success then
  // ss:=match.Value;

  // pStr := StrRScan(Pchar(str), '(');
  pStr := StrRScan(PChar(DriverName), 'C');
  if (Pos('COM', pStr) > 0) then
  begin
    i1 := 1;
    i2 := Pos(')', pStr);
    if ((i2 - i1) > 1) then
    begin
      ss := Copy(pStr, i1, i2 - i1);
    end;
  end
  else if (Pos('PID', DriverName) > 0) then
    ss := Copy(DriverName, Pos('PID', DriverName), 10)
  else
    ss := '';

  Result := ss;
end;

procedure TSettingPagesDlg.WMDeviceChange(var Msg: TMessage);
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
          DeviceType := 'Media Device ';
        end
        else
        begin
          if Boolean(pVOLUME^.dbcv_flags and DBTF_NET) then
          begin
            DeviceType := 'Network Drive ';
          end
          else
            DeviceType := 'Unknown device type 0x' + IntToHex(pVOLUME^.dbcv_flags, 8) + ' ';
        end;

        DeviceName := FirstDriveFromMask(pVOLUME^.dbcv_unitmask) + ':';

        case GetDriveType(PChar(DeviceName)) of
          DRIVE_UNKNOWN:
            DeviceType := DeviceType + 'Unknown device type ';
          DRIVE_NO_ROOT_DIR:
            DeviceType := DeviceType + 'The root directory does not exist';
          DRIVE_REMOVABLE:
            DeviceType := DeviceType + 'Removable';
          DRIVE_FIXED:
            DeviceType := DeviceType + 'Unremovable';
          DRIVE_REMOTE:
            DeviceType := DeviceType + 'Network';
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
        DeviceType := 'Port device (serial port) ';
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
          // Log0('Device ' + DeviceName + ' attached' + #13#10);
          updateSystemDevicesList(DeviceName, DBT_DEVICEARRIVAL);
        end;
      end;
    DBT_DEVICEREMOVECOMPLETE:
      begin
        if (pPORT <> nil) and (DeviceName <> '') then
        begin
          // Log0('Device ' + DeviceName + ' unattached');
          updateSystemDevicesList(DeviceName, DBT_DEVICEREMOVECOMPLETE);
        end;
      end;

    DBT_DEVICEREMOVEPENDING:
      begin

      end;

  end;
end;

procedure TSettingPagesDlg.FormCreate(Sender: TObject);
var
  ComComboBox: TComComboBox;
  j: TRECEIVE_FORMAT;
  i: Integer;
  CheckDeviceThreak: TCheckDeviceThreak;
begin
  if OcComPortList = nil then
    OcComPortList := TStringList.Create;
  OctopusCfgDir := ExtractFilePath(Application.Exename) + '\';

  SetCurrentDir(OctopusCfgDir);
  OctopusCfgDir_LogFileName := OctopusCfgDir + LOG_DIR + GetSystemDateTimeStampStr();
  if not DirectoryExists(OctopusCfgDir) then
    CreateDir(OctopusCfgDir);
  if not DirectoryExists(OctopusCfgDir + CONFIGURATION_DIR) then
    CreateDir(OctopusCfgDir + CONFIGURATION_DIR);
  if not DirectoryExists(OctopusCfgDir + LOG_DIR) then
    CreateDir(OctopusCfgDir + LOG_DIR);

  updateSystemDevicesList();

  ComComboBox := TComComboBox.Create(self);
  ComComboBox.Parent := self;
  ComComboBox.Visible := false;

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

  ComboBox1.ItemIndex := 13;

  ComComboBox.ComProperty := cpDataBits;
  ComComboBox.Refresh;
  ComboBox2.Items := ComComboBox.Items;
  ComboBox2.ItemIndex := 3; // Ord(OctopusComPort1.DataBits);

  ComComboBox.ComProperty := cpStopBits;
  ComComboBox.Refresh;
  ComboBox3.Items := ComComboBox.Items;
  ComboBox3.ItemIndex := 0; // Ord(OctopusComPort1.StopBits);

  ComComboBox.ComProperty := cpParity;
  ComComboBox.Refresh;
  ComboBox4.Items := ComComboBox.Items;
  ComboBox4.ItemIndex := 0; // Ord(OctopusComPort1.Parity.Bits);

  ComComboBox.ComProperty := cpFlowControl;
  ComComboBox.Refresh;
  ComboBox5.Items := ComComboBox.Items;
  ComboBox5.ItemIndex := 2;

  ComboBox7.Clear;
  // for j := Low(RECEIVE_FORMAT_String) to High(RECEIVE_FORMAT_String) do
  for j := ASCIIFormat to OctopusProtocol do
  begin
    ComboBox7.Items.Add(RECEIVE_FORMAT_String[j]);
  end;

  ComboBox7.ItemIndex := 0;

  VersionNumberStr := GetBuildInfo(Application.Exename);
  WindowsVersion := GetWIndowsVersion();
  ComboBoxEx1Change(self); // 刷新到默认串口设置界面

  try
    CheckDeviceThreak := TCheckDeviceThreak.Create(True);
    CheckDeviceThreak.ApplicationFileName := Application.Exename;
    CheckDeviceThreak.ConfigFileName := OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
    CheckDeviceThreak.Resume;
  finally
  end;

end;

procedure TSettingPagesDlg.FormShow(Sender: TObject);
begin
  SettingPagesDlg.LoadOrCreateLaunguageFromFile(self, True);
end;

procedure TSettingPagesDlg.ComboBoxEx1Change(Sender: TObject);
var
  sDriverName: string;
  i: Integer;
  OcComPortObj: TOcComPortObj;
begin
  if (ComboBoxEx1.Items.Count <= 0) or (ComboBoxEx1.Text = 'None') then
  begin
    exit;
  end;

  if ComboBoxEx1.ItemIndex < 0 then
    ComboBoxEx1.ItemIndex := 0;
  OcComPortObj := getDeciceByFullName(getCurrentDeviceName());
  if OcComPortObj = nil then
    exit;

  sDriverName := Trim(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  sDriverName := FalconGetComPort(sDriverName);

  ComboBox1.ItemIndex := ord(OcComPortObj.BaudRate);
  ComboBox2.ItemIndex := ord(OcComPortObj.DataBits);
  ComboBox3.ItemIndex := ord(OcComPortObj.StopBits);
  ComboBox4.ItemIndex := ord(OcComPortObj.Parity.Bits);
  ComboBox5.ItemIndex := ord(OcComPortObj.FlowControl.FlowControl);
  ComboBox6.ItemIndex := ord(OcComPortObj.SendFormat);
  ComboBox7.ItemIndex := ord(OcComPortObj.ReceiveFormat);

  CBCodePage.ItemIndex := OcComPortObj.CodePage;
  CBSendCodePage.ItemIndex := OcComPortObj.SendCodeFormat;
  CBAlignmentMode.ItemIndex := OcComPortObj.HexModeFormatCount;
end;

procedure TSettingPagesDlg.ComboBox1Change(Sender: TObject);
var
  str: String;
  btl: Integer;
  OcComPortObj: TOcComPortObj;
begin

  if ComboBoxEx1.Items.Count <= 0 then
  begin
    MessageBox(Handle, 'Please specify a device for custom baudrate.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  OcComPortObj := getDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if OcComPortObj = nil then
  begin
    MessageBox(Handle, 'Please specify a device for custom baudrate.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  // 用户输入波特率
  if ComboBox1.ItemIndex = 0 then
  begin
    // str := inputbox(Application.Title, 'Please Input Custom Baudrate:', inttostr(OcComPortObj.CustomBaudRate));
    if InputQuery(Application.Title, 'Please Input Custom Baudrate:', str) then
    begin
      try
        btl := StrToInt(str);
        OcComPortObj.CustomBaudRate := btl;
        if ComboBox1.Items.IndexOf(str) < 0 then
          ComboBox1.Items.Add(str);
        /// OcComPortObj.Log('You have set the custom baudrate to: ' + str);
        ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(str);
      except
        ComboBox1.ItemIndex := 13;
        MessageBox(Handle, 'Wrong baud rate,Please input a integer number. ', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
      end;
    end;
    exit;
  end;

  if (ComboBox1.ItemIndex <= MAX_BAUDRATE_INDEX) then // High(TBaudRate))
  begin // 配置内置波特率  1 .. 15
    OcComPortObj.BaudRate := TBaudRate(ComboBox1.ItemIndex); // 取内置波特率
    // OcComPortObj.BaudRateIndex := ComboBox1.ItemIndex;
  end
  else
  begin // 配置自定义波特率
    OcComPortObj.BaudRate := TBaudRate(0);
    OcComPortObj.CustomBaudRate := StrToInt(ComboBox1.Text);
  end;
end;

procedure TSettingPagesDlg.ComboBox8Change(Sender: TObject);
begin
  case ComboBox8.ItemIndex of
    0:
      LoadLaunguageFromFile(self, OctopusCfgDir + CONFIGURATION_DIR + 'Lang_EN.ini', false);
    1:
      LoadLaunguageFromFile(self, OctopusCfgDir + CONFIGURATION_DIR + 'Lang_CN.ini', false);
  end;
end;

procedure TSettingPagesDlg.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TSettingPagesDlg.Button3Click(Sender: TObject);
begin
  ComboBoxEx1.Clear;
  updateSystemDevicesList();
end;

procedure TSettingPagesDlg.Button5Click(Sender: TObject);
var
  OcComPortObj: TOcComPortObj;
begin
  OcComPortObj := getCurrentDevice();
  if OcComPortObj = nil then
    exit;

  /// if not OcComPortObj.Connected then
  /// exit;
  /// OcComPortObj.StringInternelCache.Lines.SaveToFile('StringInternelCache.log');
  OcComPortObj.ClearLog;
  OcComPortObj.ClearInternalBuff; // 清除内部缓存

  /// IF FileExists(OctopusCfgDir + CONFIGURATION_DIR + 'Lang_CN.ini') then
  /// DeleteFile(OctopusCfgDir + CONFIGURATION_DIR + 'Lang_CN.ini');
  /// IF FileExists(OctopusCfgDir + CONFIGURATION_DIR + 'Lang_EN.ini') then
  /// DeleteFile(OctopusCfgDir + CONFIGURATION_DIR + 'Lang_EN.ini');
end;

procedure TSettingPagesDlg.Button6Click(Sender: TObject);
var
  Image: TBitmap;
begin
  Image := TBitmap.Create;
  self.ComboBoxEx1.Images.GetBitmap(35, Image);
  Image.SaveToFile('comport.ico');
end;

procedure TSettingPagesDlg.Button4Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(OctopusCfgDir), nil, nil, SW_SHOWNORMAL);
end;

procedure TSettingPagesDlg.Button2Click(Sender: TObject);
begin
  updateOcComPortObjAtrribute();
  ApplyCodePageSetting();
  AlphaBlendValue := UpDown1.Position;
  AlphaBlend := CheckBox7.Checked;
  Timer1.Enabled := CheckBox8.Checked;
  SaveDeviceSetting(self.getCurrentDevice);
  /// Close;
end;

procedure TSettingPagesDlg.UpDown2Changing(Sender: TObject; var AllowChange: Boolean);
begin
  Timer1.Interval := UpDown2.Position * 1000;
end;

procedure TSettingPagesDlg.Timer1Timer(Sender: TObject);
begin
  if CheckBox8.Checked then
  begin
    SaveAllComPortLogData(false);
  end;
end;

procedure TSettingPagesDlg.initSystemDevicesList();
begin

end;

procedure TSettingPagesDlg.updateSystemDevicesList(DevideName: String = ''; ActionType: Integer = $8000);
var
  imageId, i: Integer;
  DevideNameList: TStringList;
  OcComPortObj: TOcComPortObj;
  S: String;
  IniFile: TIniFile;
begin
  try
    ImageList1.Clear;
    if OcComPortList = nil then
      OcComPortList := TStringList.Create;

    DevideNameList := TStringList.Create;

    imageId := 0;
    OcComPortObj := nil;

    GetTheHardDevice('ports', ImageList1, DevideNameList, imageId);

    if DevideName <> '' then
      OcComPortObj := getDeciceByPort(DevideName);

    if (OcComPortObj <> nil) and (ActionType = DBT_DEVICEREMOVECOMPLETE) then
    begin
      if OcComPortObj.Connected then
        closeDevice(OcComPortObj);
      if Assigned(SettingChangedCallBackFuntion) then
        SettingChangedCallBackFuntion(OcComPortObj);
    end;

    if DevideNameList.Count = 0 then
    begin
      exit;
    end;

    ComboBoxEx1.ItemsEx.BeginUpdate;
    ComboBoxEx1.Images := ImageList1;
    OcComPortList.BeginUpdate;
    for i := 0 to DevideNameList.Count - 1 do
    begin
      ComboBoxEx1.ItemsEx.AddItem(DevideNameList.Strings[i], imageId, imageId, imageId, -1, nil);
      ComboBoxEx1.ItemsEx.Items[i].ImageIndex := imageId;
      if (OcComPortList.IndexOf(DevideNameList.Strings[i])) < 0 then
      begin
        OcComPortObj := TOcComPortObj.Create(self, DevideNameList.Strings[i]);
        OcComPortList.AddObject(DevideNameList.Strings[i], OcComPortObj);
        // 导入设备配置信息
        S := OctopusCfgDir + CONFIGURATION_DIR + OcComPortObj.ComportFullName + '.ini';
        OcComPortObj.LoadSettings(stIniFile, S); // 保存设备配置到S文件
        try
          IniFile := TIniFile.Create(S);
          OcComPortObj.ReceiveFormat := IniFile.ReadInteger('', 'ReceiveFormat', 0);
          OcComPortObj.SendFormat := IniFile.ReadInteger('', 'SendFormat', 0);
        finally
          IniFile.Free;
        end;
      end;
    end;
    ComboBoxEx1.ItemsEx.EndUpdate;
    OcComPortList.EndUpdate;
  finally
    DevideNameList.Free;
  end;
end;

function TSettingPagesDlg.getDeciceByPort(Port: string): TOcComPortObj;
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

function TSettingPagesDlg.getCurrentDevice(): TOcComPortObj;
begin
  Result := getDeciceByFullName(getCurrentDeviceName());
end;

function TSettingPagesDlg.getCurrentDeviceName(): String;
begin
  Result := '';
  if (ComboBoxEx1.Items.Count > 0) and (ComboBoxEx1.ItemIndex >= 0) then
    Result := ComboBoxEx1.Items[ComboBoxEx1.ItemIndex];
end;

function TSettingPagesDlg.getDeciceByFullName(DeviceName: string): TOcComPortObj;
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

function TSettingPagesDlg.getDeciceByIndex(Index: Integer): TOcComPortObj;
begin
  Result := nil;
  if (Index < 0) or (Index >= OcComPortList.Count) then
    exit;
  try
    Result := TOcComPortObj(OcComPortList.Objects[Index]);
  finally

  end;
end;

function TSettingPagesDlg.getAvailableDevice(): TOcComPortObj;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to OcComPortList.Count - 1 do
  begin
    if (OcComPortList.Objects[i] = nil) then
      continue;
    if not TOcComPortObj(OcComPortList.Objects[i]).Connected and (TOcComPortObj(OcComPortList.Objects[i]).status = 0) then
    begin
      Result := TOcComPortObj(OcComPortList.Objects[i]);
      break;
    end;
  end;
end;

procedure TSettingPagesDlg.closeDevice(DeviceFullName: String);
var
  OcComPortObj: TOcComPortObj;
  i: Integer;
begin
  if OcComPortList = nil then
    exit;
  if DeviceFullName = '' then
    exit;
  i := OcComPortList.IndexOf(DeviceFullName);
  if i < 0 then
    exit;

  OcComPortObj := TOcComPortObj(OcComPortList.Objects[i]);
  if (OcComPortObj <> nil) and (OcComPortObj.Connected) then
  begin
    OcComPortObj.closeDevice();
  end;
end;

procedure TSettingPagesDlg.closeDevice(OcComPortObj: TOcComPortObj);
begin
  if (OcComPortObj <> nil) and (OcComPortObj.Connected) then
  begin
    OcComPortObj.closeDevice();
  end;
end;

function TSettingPagesDlg.openDevice(DeviceFullName: String): TOcComPortObj;
begin
  openDevice(DeviceFullName, nil);
end;

function TSettingPagesDlg.openDevice(DeviceFullName: String; LogMemo: TMyRichEdit): TOcComPortObj;
var
  OcComPortObj: TOcComPortObj;
  i: Integer;
begin
  Result := nil;
  if OcComPortList = nil then
    exit;
  if DeviceFullName = '' then
    exit;

  OcComPortObj := getDeciceByFullName(DeviceFullName);
  if OcComPortObj = nil then
    exit;

  /// updateOcComPortObjAtrribute(OcComPortObj);

  /// OcComPortObj.ClearLog;
  /// OcComPortObj.ClearInternalBuff();

  OcComPortObj.StringInternelCache.Parent := self; // 设置大量极限数据的缓冲MEMO
  OcComPortObj.StringInternelCache.DoubleBuffered := True;

  try
    OcComPortObj.Open;
    Result := OcComPortObj;
  Except
    // OcComPortObj.Log('Can not open  ' + OcComPortObj.OcComPortObjPara.ComportFullName);
    Result := nil;
    // MessageBox(Application.Handle, PChar('Open device ' + DeviceFullName + ' failed, it may be in used.'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  if not OcComPortObj.Connected then
  begin
  end;
end;

function TSettingPagesDlg.openDevice(OcComPortObj: TOcComPortObj): Boolean;
var
  i: Integer;
begin
  Result := false;
  if OcComPortObj = nil then
    exit;
  if OcComPortObj.Connected then
    exit;

  /// OcComPortObj.ClearLog;
  /// OcComPortObj.ClearInternalBuff();

  OcComPortObj.StringInternelCache.Parent := self; // 设置大量极限数据的缓冲MEMO
  OcComPortObj.StringInternelCache.DoubleBuffered := True;

  try
    OcComPortObj.Open;
    /// OcComPortObj.SaveLog(OctopusCfgDir_LogFileName + '_' + OcComPortObj.Port + '.log'); // 打开的时候创建日志文件
    Result := True;
    OcComPortObj.status := 1;
  Except
    // OcComPortObj.Log('Can not open  ' + OcComPortObj.OcComPortObjPara.ComportFullName);
    Result := false;
    OcComPortObj.status := 1;
    // MessageBox(Application.Handle, PChar('Open device ' + DeviceFullName + ' failed, it may be in used.'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  if not OcComPortObj.Connected then
  begin
  end;

end;

function TSettingPagesDlg.openDeviceRandom(): TOcComPortObj;
begin
  Result := getAvailableDevice();
  // Result := openDevice(Result);
end;

procedure TSettingPagesDlg.FalconLoadCfg();
var
  Octopusini: TIniFile;
  S: string;
  i: Integer;

begin
  Octopusini := nil;
  if not DirectoryExists(OctopusCfgDir) then
    exit;
  S := OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
  if (not FileExists(S)) then
    exit;
  try
    Octopusini := TIniFile.Create(S);

  finally
    Octopusini.Free;
  end;
end;

procedure TSettingPagesDlg.SaveAllComPortLogData(DoClose: Boolean);
var
  i: Integer;
  OcComPortObj: TOcComPortObj;
  // Octopusini: TIniFile;
  // S: String;
begin
  // S := OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
  try
    // Octopusini := TIniFile.Create(S);

    for i := 0 to OcComPortList.Count - 1 do
    begin
      OcComPortObj := TOcComPortObj(OcComPortList.Objects[i]);
      if OcComPortObj <> nil then
      begin
        if OcComPortObj.Connected then
        begin
          OcComPortObj.SaveLog(OctopusCfgDir_LogFileName + '_' + OcComPortObj.Port + '.log');
          if (DoClose) then
          begin
            OcComPortObj.Free;
          end;
        end;
      end;
    end;
  finally
    // Octopusini.Free;
  end;
end;

procedure TSettingPagesDlg.SaveDeviceSetting(OcComPortObj: TOcComPortObj);
var
  S: String;
  Octopusini: TIniFile;
begin
  if OcComPortObj = nil then
    exit;
  try
    OcComPortObj.SaveLog(OctopusCfgDir_LogFileName + '_' + OcComPortObj.Port + '.log'); // 打开的时候创建日志文件
    S := OctopusCfgDir + CONFIGURATION_DIR + OcComPortObj.ComportFullName + '.ini';
    OcComPortObj.StoreSettings(stIniFile, S);
    Octopusini := TIniFile.Create(S);
    // Octopusini.WriteInteger('', 'BaudRateIndex', ComboBox1.ItemIndex);
    Octopusini.WriteInteger('', 'SendFormat', ComboBox6.ItemIndex);
    Octopusini.WriteInteger('', 'ReceiveFormat', ComboBox7.ItemIndex);
  finally
    Octopusini.Free;
  end;
end;

procedure TSettingPagesDlg.updateOcComPortObjAtrribute(OcComPortObj: TOcComPortObj = nil);
var
  CodePage: Integer;
begin
  if OcComPortObj = nil then
    OcComPortObj := getDeciceByFullName(getCurrentDeviceName());

  if OcComPortObj = nil then
  begin
    exit;
  end;

  OcComPortObj.OcComPortObjInit2('', '', ComboBox1.ItemIndex, ComboBox2.ItemIndex, ComboBox3.ItemIndex, ComboBox4.ItemIndex, ComboBox5.ItemIndex, ComboBox6.ItemIndex, ComboBox7.ItemIndex, nil,
    CheckBox3.Checked, CheckBox6.Checked, CheckBox4.Checked, CheckBox5.Checked, True);

  case CBAlignmentMode.ItemIndex of
    0:
      OcComPortObj.HexModeFormatCount := 16;
    1:
      OcComPortObj.HexModeFormatCount := 32;
    2:
      OcComPortObj.HexModeFormatCount := 0;
  else
    OcComPortObj.HexModeFormatCount := 0;
  end;

  case CBCodePage.ItemIndex of
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

procedure TSettingPagesDlg.ApplyCodePageSetting();
var
  OcComPortObj: TOcComPortObj;
  CodePage: Integer;
begin

  OcComPortObj := getDeciceByFullName(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  if OcComPortObj = nil then
  begin
    exit;
  end;

  case CBAlignmentMode.ItemIndex of
    0:
      OcComPortObj.HexModeFormatCount := 16;
    1:
      OcComPortObj.HexModeFormatCount := 32;
    2:
      OcComPortObj.HexModeFormatCount := 0;
  else
    OcComPortObj.HexModeFormatCount := 0;
  end;

  case CBCodePage.ItemIndex of
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

  OcComPortObj.SendCodeFormat := CBSendCodePage.ItemIndex;
  OcComPortObj.ShowTime := CheckBox6.Checked;
  OcComPortObj.ShowDate := CheckBox3.Checked;
  OcComPortObj.ShowLineNumber := CheckBox4.Checked;
  OcComPortObj.ShowSendedLog := CheckBox5.Checked;
  OcComPortObj.CodePage := CodePage;
end;

procedure TSettingPagesDlg.LoadOrCreateLaunguageFromFile(Form: TForm; Create: Boolean);
begin
  if Create then
  begin
    LoadLaunguageFromFile(Form, OctopusCfgDir + CONFIGURATION_DIR + 'Lang_EN.ini', Create);
    LoadLaunguageFromFile(Form, OctopusCfgDir + CONFIGURATION_DIR + 'Lang_CN.ini', Create);
    exit;
  end;
  case SettingPagesDlg.ComboBox8.ItemIndex of
    0:
      begin
        LoadLaunguageFromFile(Form, OctopusCfgDir + CONFIGURATION_DIR + 'Lang_EN.ini', Create);
      end;
    1:
      begin
        LoadLaunguageFromFile(Form, OctopusCfgDir + CONFIGURATION_DIR + 'Lang_CN.ini', Create);
      end;
  end;
end;

procedure TSettingPagesDlg.LoadLaunguageFromFile(Form: TForm; Path: String; Create: Boolean);
var
  i: Integer;
  tmpComponent: TComponent;
  IniFiles: TIniFile;
  str: String;
  function getMsgID(str: String): String;
  begin
    Result := 'MESSAGE_' + UpperCase(str);
  end;

begin
  try
    IniFiles := nil;
    if (FileExists(Path)) and (not Create) then
    begin
      IniFiles := TIniFile.Create(Path);
      For i := 0 To Form.ComponentCount - 1 Do
      Begin
        tmpComponent := Form.Components[i];
        if tmpComponent is TButton then
          TButton(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE_TButton', getMsgID(TButton(tmpComponent).Name), TButton(tmpComponent).Caption);

        if tmpComponent is TCheckBox then
          TCheckBox(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE_TCheckBox', getMsgID(TCheckBox(tmpComponent).Name), TCheckBox(tmpComponent).Caption);

        if tmpComponent is TLabel then
          TLabel(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE_TLabel', getMsgID(TLabel(tmpComponent).Name), TLabel(tmpComponent).Caption);

        if tmpComponent is TMenuItem then
          TMenuItem(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE_TMenuItem', getMsgID(TMenuItem(tmpComponent).Name), TMenuItem(tmpComponent).Caption);

        if tmpComponent is TTabSheet then
          TTabSheet(tmpComponent).Caption := IniFiles.ReadString('LANGUAGE_TTabSheet', getMsgID(TTabSheet(tmpComponent).Name), TTabSheet(tmpComponent).Caption);

        if tmpComponent is TStringGrid then
        begin
          TStringGrid(tmpComponent).Cells[0, 0] := IniFiles.ReadString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL0'), TStringGrid(tmpComponent).Cells[0, 0]);
          TStringGrid(tmpComponent).Cells[1, 0] := IniFiles.ReadString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL1'), TStringGrid(tmpComponent).Cells[1, 0]);
          TStringGrid(tmpComponent).Cells[2, 0] := IniFiles.ReadString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL2'), TStringGrid(tmpComponent).Cells[2, 0]);

          TStringGrid(tmpComponent).Cells[4, 0] := IniFiles.ReadString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL4'), TStringGrid(tmpComponent).Cells[4, 0]);
          TStringGrid(tmpComponent).Cells[5, 0] := IniFiles.ReadString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL5'), TStringGrid(tmpComponent).Cells[5, 0]);
          TStringGrid(tmpComponent).Cells[6, 0] := IniFiles.ReadString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL6'), TStringGrid(tmpComponent).Cells[6, 0]);
        end;
      End;
    end
    else if (not FileExists(Path)) and (Create) then
    /// else if (Create) then
    begin
      IniFiles := TIniFile.Create(Path);
      For i := 0 To Form.ComponentCount - 1 Do
      Begin
        tmpComponent := Form.Components[i];
        if tmpComponent is TButton then
          IniFiles.WriteString('LANGUAGE_TButton', getMsgID(TButton(tmpComponent).Name), TButton(tmpComponent).Caption);
        if tmpComponent is TCheckBox then
          IniFiles.WriteString('LANGUAGE_TCheckBox', getMsgID(TCheckBox(tmpComponent).Name), TCheckBox(tmpComponent).Caption);
        if tmpComponent is TLabel then
          IniFiles.WriteString('LANGUAGE_TLabel', getMsgID(TLabel(tmpComponent).Name), TLabel(tmpComponent).Caption);
        if tmpComponent is TMenuItem then
        begin
          if TMenuItem(tmpComponent).Caption <> '-' then
            IniFiles.WriteString('LANGUAGE_TMenuItem', getMsgID(TMenuItem(tmpComponent).Name), TMenuItem(tmpComponent).Caption);
        end;

        if tmpComponent is TTabSheet then
          IniFiles.WriteString('LANGUAGE_TTabSheet', getMsgID(TTabSheet(tmpComponent).Name), TTabSheet(tmpComponent).Caption);

        if tmpComponent is TStringGrid then
        begin
          IniFiles.WriteString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL0'), TStringGrid(tmpComponent).Cells[0, 0]);
          IniFiles.WriteString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL1'), TStringGrid(tmpComponent).Cells[1, 0]);
          IniFiles.WriteString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL2'), TStringGrid(tmpComponent).Cells[2, 0]);

          IniFiles.WriteString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL4'), TStringGrid(tmpComponent).Cells[4, 0]);
          IniFiles.WriteString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL5'), TStringGrid(tmpComponent).Cells[5, 0]);
          IniFiles.WriteString('LANGUAGE_TStringGrid', getMsgID(TStringGrid(tmpComponent).Name + 'COL6'), TStringGrid(tmpComponent).Cells[6, 0]);
        end;

      End;
    end;
  finally
    if IniFiles <> nil then
      IniFiles.Free;
  end;
end;

end.
