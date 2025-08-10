unit ocPcDeviceMgt;

interface

uses
  Winapi.windows, System.SysUtils, System.classes, StdCtrls, ComCtrls, Controls,
  Vcl.Dialogs;

const
  GUID_DEVINTERFACE_USB_DEVICE: TGUID = '{A5DCBF10-6530-11D2-901F-00C04FB951ED}';

  DBT_DEVNODES_CHANGED = $0007;

  DBT_DEVICEARRIVAL = $8000; // system detected a new device
  DBT_DEVICEQUERYREMOVE = $8001; // wants to remove, may fail
  DBT_DEVICEQUERYREMOVEFAILED = $8002; // removal aborted
  DBT_DEVICEREMOVEPENDING = $8003; // about to remove, still avail.
  DBT_DEVICEREMOVECOMPLETE = $8004; // device is gone
  DBT_DEVICETYPESPECIFIC = $8005; // type specific event

  DBTF_MEDIA = $0001; // media comings and goings
  DBTF_NET = $0002; // network volume

  DBT_DEVTYP_OEM = $00000000; // oem-defined device type
  DBT_DEVTYP_DEVNODE = $00000001; // devnode number
  DBT_DEVTYP_VOLUME = $00000002; // logical volume
  DBT_DEVTYP_PORT = $00000003; // serial, parallel
  DBT_DEVTYP_NET = $00000004; // network resource

  DBT_DEVTYP_DEVICEINTERFACE = $00000005; // device interface class

  DIF_PROPERTYCHANGE = 18;
  DICS_ENABLE = 1;
  DICS_FLAG_GLOBAL = 1;
  DICS_DISABLE = 2;

  DIGCF_DEFAULT = $00000001;
  DIGCF_PRESENT = $00000002;
  DIGCF_ALLCLASSES = $00000004;
  DIGCF_PROFILE = $00000008;
  DIGCF_DEVICEINTERFACE = $00000010;

  SPDRP_DEVICEDESC = $00000000;
  SPDRP_FRIENDLYNAME = $0000000C;

  LINE_LEN = 256;

  SPDIT_NODRIVER = $00000000;
  SPDIT_CLASSDRIVER = $00000001;
  SPDIT_COMPATDRIVER = $00000002;

type
  THDEVINFO = type NativeUInt;

  DI_FUNCTION = type NativeUInt;

  PDEV_BROADCAST_VOLUME = ^TDEV_BROADCAST_VOLUME;

  TDEV_BROADCAST_VOLUME = packed Record
    dbcv_size: DWORD; // ULONG;
    dbcv_devicetype: DWORD; // ULONG;
    dbcv_reserved: DWORD; // ULONG;
    dbcv_unitmask: DWORD; // ULONG;
    dbcv_flags: WORD; // SHORT;
  end;

  PDEV_BROADCAST_HDR = ^DEV_BROADCAST_HDR;

  DEV_BROADCAST_HDR = Packed Record
    dbch_size: DWORD;
    dbch_devicetype: DWORD;
    dbch_reserved: DWORD;
  End;

  PDEV_BROADCAST_DEVICEINTERFACE = ^DEV_BROADCAST_DEVICEINTERFACE;

  DEV_BROADCAST_DEVICEINTERFACE = Record
    dbcc_size: DWORD;
    dbcc_devicetype: DWORD;
    dbcc_reserved: DWORD;
    dbcc_classguid: TGUID;
    dbcc_name: short;
  End;

  PDEV_BROADCAST_OEM = ^DEV_BROADCAST_OEM;

  DEV_BROADCAST_OEM = Record
    dbco_size: DWORD;
    dbco_devicetype: DWORD;
    dbco_reserved: DWORD;
    dbco_identifier: DWORD;
    dbco_suppfunc: WORD;
  End;

  PDEV_BROADCAST_PORT = ^DEV_BROADCAST_PORT;

  DEV_BROADCAST_PORT = Record
    dbcp_size: DWORD;
    dbcp_devicetype: DWORD;
    dbcp_reserved: DWORD;
    dbcp_name: Array [0 .. 255] Of char;
  End;

  PSP_CLASSINSTALL_HEADER = ^SP_CLASSINSTALL_HEADER;

  SP_CLASSINSTALL_HEADER = record
    cbSize: DWORD;
    InstallFunction: DI_FUNCTION; { (DIF code) }
  end;

  PSP_PROPCHANGE_PARAMS = ^SP_PROPCHANGE_PARAMS;

  SP_PROPCHANGE_PARAMS = record
    ClassInstallHeader: SP_CLASSINSTALL_HEADER;
    StateChange: DWORD;
    Scope: DWORD;
    HwProfile: DWORD;
  end;

  PSP_DEVINFO_DATA = ^SP_DEVINFO_DATA;

  SP_DEVINFO_DATA = record
    cbSize: DWORD;
    ClassGuid: TGUID;
    DevInst: DWORD;
{$IFDEF CPU64BITS}
    Reserved: ULONG64; // for 64 bit;
{$ELSE}
    Reserved: Longint; // for 32 bit;
{$ENDIF}
  end;

  PSP_DRVINFO_DATA = ^SP_DRVINFO_DATA;

  SP_DRVINFO_DATA = record
    cbSize: DWORD;
    DriverType: DWORD;
    Reserved: ULONG;
    Description: array [0 .. LINE_LEN] of char;
    MfgName: array [0 .. LINE_LEN] of char;
    ProviderName: array [0 .. LINE_LEN] of char;
    DriverDate: TFileTime;
    DriverVersion: DWORD;
  end;

  PSP_CLASSIMAGELIST_DATA = ^SP_CLASSIMAGELIST_DATA;

  SP_CLASSIMAGELIST_DATA = record
    cbSize: DWORD;
    ImageList: HWND;
    Reserved: Longint;
  end;

function SetupDiGetClassDevs(const ClassGuid: PGUID; Enumerator: PChar; hwndParent: HWND; Flags: DWORD): THDEVINFO; stdcall;
  external 'Setupapi.dll' name 'SetupDiGetClassDevsA';

function SetupDiEnumDeviceInfo(DeviceInfoSet: THDEVINFO; MemberIndex: DWORD; DeviceInfoData: PSP_DEVINFO_DATA): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiEnumDeviceInfo';

function SetupDiGetDeviceRegistryProperty(DeviceInfoSet: THDEVINFO; DeviceInfoData: PSP_DEVINFO_DATA; Propertys: DWORD; PropertyRegDataType: PWORD;
  PropertyBuffer: PByte; PropertyBufferSize: DWORD; RequiredSize: PDWORD): BOOL; stdcall; external 'Setupapi.dll' name 'SetupDiGetDeviceRegistryPropertyA';

function SetupDiDestroyDeviceInfoList(DeviceInfoSet: THDEVINFO): BOOL; stdcall; external 'Setupapi.dll' name 'SetupDiDestroyDeviceInfoList';

function SetupDiClassNameFromGuid(ClassGuid: PGUID; ClassName: PChar; ClassNameSize: DWORD; RequiredSize: PDWORD): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiClassNameFromGuidA';

function SetupDiGetClassImageList(ClassImageListData: PSP_CLASSIMAGELIST_DATA): BOOL; stdcall; external 'Setupapi.dll' name 'SetupDiGetClassImageList';

function SetupDiDestroyClassImageList(ClassImageListData: PSP_CLASSIMAGELIST_DATA): BOOL; stdcall; external 'Setupapi.dll' name 'SetupDiDestroyClassImageList';

function SetupDiGetClassImageIndex(ClassImageListData: PSP_CLASSIMAGELIST_DATA; ClassGuid: PGUID; ImageIndex: PINT): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiGetClassImageIndex';

function SetupDiEnumDriverInfo(DeviceInfoSet: THDEVINFO; DeviceInfoData: PSP_DEVINFO_DATA; DriverType: DWORD; MemberIndex: DWORD;
  DriverInfoData: SP_DRVINFO_DATA): BOOL; stdcall; external 'Setupapi.dll' name 'SetupDiEnumDriverInfoA';

function SetupDiGetSelectedDriver(DeviceInfoSet: THDEVINFO; DeviceInfoData: PSP_DEVINFO_DATA; DriverInfoData: PSP_DRVINFO_DATA): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiGetSelectedDriverA';

function SetupDiSetClassInstallParams(DeviceInfoSet: THDEVINFO; DeviceInfoData: PSP_DEVINFO_DATA; ClassInstallParams: PSP_CLASSINSTALL_HEADER;
  ClassInstallParamsSize: DWORD): BOOL stdcall; external 'Setupapi.dll' name 'SetupDiSetClassInstallParamsA';
function SetupDiCallClassInstaller(InstallFunction: DI_FUNCTION; DeviceInfoSet: THDEVINFO; DeviceInfoData: PSP_DEVINFO_DATA): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiCallClassInstaller';

procedure GetAllHardDevice(tr: Ttreeview; il1: TImageList);
Procedure GetTheHardDevice(yTypes: string; il1: TImageList; var sDevices: TStringList; var imid: integer)
{ :TStringList };
Function GetDeviceName(DeviceInfoSet: THDEVINFO; DeviceInfoData: PSP_DEVINFO_DATA; var Name: string): Boolean;
Function DeviceClassName(Guid: TGUID): string;

implementation

Function GetLocalHostName(): string;
var
  ComputerName: PChar;
  size: DWORD;
begin
  GetMem(ComputerName, 255);
  size := 255;
  // ��ȡ���������
  if GetComputerName(ComputerName, size) = False then
  begin
    // MessageBox( Handle, '��ȡ���������ʧ�ܡ�' , '����' , MB_OK+MB_ICONERROR);
    FreeMem(ComputerName);
    Exit;
  end;
  result := ComputerName + ' ���ػ���';
  FreeMem(ComputerName);
end;

function ByteToWideString(buff: PByte; len: integer): String;
var
  str: AnsiString;
  buffer: array of byte;
begin
  SetLength(buffer, len);
  SetLength(str, len);
  // Move(buff, buffer, len);
  CopyMemory(buffer, buff, len);
  // Move(buffer, str[1], len);
  CopyMemory(@str[1], buffer, len);
  result := str;
end;

procedure GetDeviceImageIndex(const DeviceInfoData: SP_DEVINFO_DATA; const ImageList: SP_CLASSIMAGELIST_DATA; var ImageIndex: integer);
begin
  if not SetupDiGetClassImageIndex(@ImageList, @DeviceInfoData.ClassGuid, @ImageIndex) then
  begin
    ImageIndex := -1; // ����Ĭ��ͼ��������������Чֵ
    raise Exception.Create('�޷���ȡ�豸ͼ������: ' + SysErrorMessage(GetLastError));
  end;
end;

procedure GetDeviceInfo(HDEVINFO: THDEVINFO; var DeviceInfoData: SP_DEVINFO_DATA; var DeviceName, DeviceType: string);
begin
  if not GetDeviceName(HDEVINFO, @DeviceInfoData, DeviceName) then
    raise Exception.Create('�޷���ȡ�豸����: ' + SysErrorMessage(GetLastError));

  DeviceType := Trim(DeviceClassName(DeviceInfoData.ClassGuid));
end;

procedure GetTheHardDevice2(yTypes: string; il1: TImageList; var sDevices: TStringList; var imid: integer);
var
  ImageList: SP_CLASSIMAGELIST_DATA;
  HDEVINFO: THDEVINFO;
  DeviceInfoData: SP_DEVINFO_DATA;
  i: DWORD;
  Name, Types: string;
  ImageIndex: integer;
begin
  // ��ʼ�� ImageList
  ImageList.cbSize := SizeOf(SP_CLASSIMAGELIST_DATA);
  if not SetupDiGetClassImageList(@ImageList) then
    raise Exception.Create('�޷���ȡ��ͼ���б�: ' + SysErrorMessage(GetLastError));

  il1.Handle := ImageList.ImageList;

  // ��ȡ�豸��Ϣ��
  HDEVINFO := SetupDiGetClassDevs(nil, 0, 0, DIGCF_PRESENT or DIGCF_ALLCLASSES);
  if HDEVINFO = INVALID_HANDLE_VALUE then
    raise Exception.Create('�޷���ȡ�豸��Ϣ�б�: ' + SysErrorMessage(GetLastError));

  try
    // ��ʼ���豸��Ϣ���ݽṹ
    DeviceInfoData.cbSize := SizeOf(SP_DEVINFO_DATA);
    i := 0;

    // ö���豸
    while SetupDiEnumDeviceInfo(HDEVINFO, i, @DeviceInfoData) do
    begin
      try
        // ��ȡ�豸���ƺ�����
        GetDeviceInfo(HDEVINFO, DeviceInfoData, Name, Types);

        // ��ȡͼ������
        GetDeviceImageIndex(DeviceInfoData, ImageList, ImageIndex);

        // �ж��豸����
        if SameText(Types, yTypes) then
        begin
          sDevices.Append(Trim(Name));
          imid := ImageIndex;
        end;
      except
        on E: Exception do
        begin
          ShowMessage('�����豸ʱ����: ' + E.Message);
        end;
      end;

      Inc(i);
    end;

  finally
    // ������Դ
    SetupDiDestroyDeviceInfoList(HDEVINFO);
  end;
end;

Procedure GetTheHardDevice(yTypes: string; il1: TImageList; var sDevices: TStringList; var imid: integer)
{ :TStringList };
var
  ImageList: SP_CLASSIMAGELIST_DATA;
  HDEVINFO: THDEVINFO;
  DeviceInfoData: SP_DEVINFO_DATA;
  // DriverInfoData: SP_DRVINFO_DATA;
  i: DWORD;
  Name, Types, gui: string;
  ImageIndex: integer;
begin
  ImageList.cbSize := SizeOf(SP_CLASSIMAGELIST_DATA);
  // DriverInfoData.cbSize := SizeOf(SP_DRVINFO_DATA);
  SetupDiGetClassImageList(@ImageList);
  il1.Handle := ImageList.ImageList;

  HDEVINFO := SetupDiGetClassDevs(nil, 0, 0, DIGCF_PRESENT or DIGCF_ALLCLASSES);

  if (HDEVINFO = INVALID_HANDLE_VALUE) then
    Exit;

  DeviceInfoData.cbSize := SizeOf(SP_DEVINFO_DATA);
  i := 0;

  try
    while SetupDiEnumDeviceInfo(HDEVINFO, i, @DeviceInfoData) do
    begin
      GetDeviceName(HDEVINFO, @DeviceInfoData, Name);
      SetupDiGetClassImageIndex(@ImageList, @DeviceInfoData.ClassGuid, @ImageIndex);
      gui := GUIDToString(DeviceInfoData.ClassGuid);
      Types := Trim(DeviceClassName(DeviceInfoData.ClassGuid));
      if lowercase(Types) = lowercase(yTypes) then
      begin
        sDevices.Append(Trim(name));
        imid := ImageIndex;
      end;
      Inc(i);
    end;
  except
  end;
  // i := GetLastError();
  // showmessage(inttostr(i));
  SetupDiDestroyDeviceInfoList(HDEVINFO);
end;

Function DeviceClassName(Guid: TGUID): string;
var
  ClassName: PChar;
  ClassNameSzie: integer;
begin
  ClassNameSzie := 0;
  GetMem(ClassName, ClassNameSzie);
  while not SetupDiClassNameFromGuid(@Guid, ClassName, ClassNameSzie, @ClassNameSzie) do
  begin
    if (GetLastError() = ERROR_INSUFFICIENT_BUFFER) then
    begin
      if ClassName <> nil then
        FreeMem(ClassName);
      GetMem(ClassName, ClassNameSzie);
    end
    else
      Break;
  end;
  result := ByteToWideString(PByte(ClassName), ClassNameSzie);
  // StrPas(ClassName);
  if ClassName <> nil then
    FreeMem(ClassName);
end;

Function GetDeviceName(DeviceInfoSet: THDEVINFO; DeviceInfoData: PSP_DEVINFO_DATA; var Name: string): Boolean;
var
  DataT, buffersize: DWORD;
  buffer: PChar;
begin
  buffersize := 256;
  buffer := AllocMem(buffersize);
  result := False;
  if not SetupDiGetDeviceRegistryProperty(DeviceInfoSet, DeviceInfoData, SPDRP_FRIENDLYNAME, @DataT, PByte(buffer), buffersize, @buffersize) then
  begin
    result := SetupDiGetDeviceRegistryProperty(DeviceInfoSet, DeviceInfoData, SPDRP_DEVICEDESC, @DataT, PByte(buffer), buffersize, @buffersize)
  end
  else
    result := True;
  if result then
    Name := ByteToWideString(PByte(buffer), buffersize) // StrPas(buffer)
  else
    Name := 'Unknow';
  FreeMem(buffer);
  Name := Trim(Name);
end;

function ChangeDeviceState(HDEVINFO: THDEVINFO; NewStatus: DWORD; SelectedItem: DWORD): Boolean;
var
  PropChangeParams: SP_PROPCHANGE_PARAMS;
  DeviceInfoData: SP_DEVINFO_DATA;
begin
  result := False;

  DeviceInfoData.cbSize := SizeOf(SP_DEVINFO_DATA);
  if not SetupDiEnumDeviceInfo(HDEVINFO, SelectedItem, @DeviceInfoData) then
    Exit;

  // Set the PropChangeParams structure.
  PropChangeParams.ClassInstallHeader.cbSize := SizeOf(SP_CLASSINSTALL_HEADER);
  PropChangeParams.ClassInstallHeader.InstallFunction := DIF_PROPERTYCHANGE;
  PropChangeParams.Scope := DICS_FLAG_GLOBAL;
  PropChangeParams.StateChange := NewStatus;

  if not SetupDiSetClassInstallParams(HDEVINFO, @DeviceInfoData, PSP_CLASSINSTALL_HEADER(@PropChangeParams), SizeOf(PropChangeParams)) then
    Exit;

  // Call the ClassInstaller and perform the change.
  if not SetupDiCallClassInstaller(DIF_PROPERTYCHANGE, HDEVINFO, @DeviceInfoData) then
    Exit;

  result := True;
end;

function ControlDisk(nStatus: integer; Device_Guid: string): Boolean;
var
  Guid: TGUID;
  GUIDString: string;
  HDEVINFO: THDEVINFO;
  i: DWORD;
  DeviceInfoData: SP_DEVINFO_DATA;
begin
  result := False;
  if (nStatus = -1) then
    Exit;

  ZeroMemory(@Guid, SizeOf(TGUID));

  GUIDString := Trim(Device_Guid);
  Guid := StringToGUID(GUIDString);

  HDEVINFO := SetupDiGetClassDevs(@Guid, nil, HWND(nil), DIGCF_PRESENT);
  if (HDEVINFO = INVALID_HANDLE_VALUE) then
    Exit;

  ZeroMemory(@DeviceInfoData, SizeOf(SP_DEVINFO_DATA));
  DeviceInfoData.cbSize := SizeOf(SP_DEVINFO_DATA);
  i := 0;

  while SetupDiEnumDeviceInfo(HDEVINFO, i, @DeviceInfoData) do
  begin
    if nStatus = 1 then
      result := ChangeDeviceState(HDEVINFO, DICS_ENABLE, i)
    else if nStatus = 2 then
      result := ChangeDeviceState(HDEVINFO, DICS_DISABLE, i);
    Inc(i);
  end;

  SetupDiDestroyDeviceInfoList(HDEVINFO);
end;

procedure GetAllHardDevice(tr: Ttreeview; il1: TImageList);
var
  ImageList: SP_CLASSIMAGELIST_DATA;
  systemn, keyboardn, portsn, fdcn, hdcn, mousen, monitorn, floppydiskn, hidclassn, cdromn, diskdriven, displayn, usbn, median, netn, scsiadaptern, computern,
    legacydrivern, volumen, processorn, intelunifieddisplaydrivern, othersn, rootn: TTreenode;

  HDEVINFO: THDEVINFO;
  DeviceInfoData: SP_DEVINFO_DATA;
  // DriverInfoData: SP_DRVINFO_DATA;
  i: DWORD;
  Name, Types, gui: string;
  // list: TListItem;
  ImageIndex: integer;
  childnode: TTreenode;
  childnode2: TTreenode;

begin
  tr.Items.Clear;
  rootn := tr.Items.Add(nil, GetLocalHostName);
  ImageList.cbSize := SizeOf(SP_CLASSIMAGELIST_DATA);
  // DriverInfoData.cbSize := SizeOf(SP_DRVINFO_DATA);
  SetupDiGetClassImageList(@ImageList);
  il1.Handle := ImageList.ImageList;
  tr.Images := il1;
  HDEVINFO := SetupDiGetClassDevs(nil, 0, 0, DIGCF_PRESENT or DIGCF_ALLCLASSES);
  if (HDEVINFO = INVALID_HANDLE_VALUE) then
    Exit;
  DeviceInfoData.cbSize := SizeOf(SP_DEVINFO_DATA);
  i := 0;
  while SetupDiEnumDeviceInfo(HDEVINFO, i, @DeviceInfoData) do
  begin
    GetDeviceName(HDEVINFO, @DeviceInfoData, Name);

    SetupDiGetClassImageIndex(@ImageList, @DeviceInfoData.ClassGuid, @ImageIndex);

    gui := GUIDToString(DeviceInfoData.ClassGuid);
    Types := DeviceClassName(DeviceInfoData.ClassGuid);

    Types := Trim(lowercase(Types));
    if (lowercase(Types) = 'system') then
    begin
      if systemn = nil then
        systemn := tr.Items.AddChild(rootn, 'ϵͳ�豸');
      systemn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(systemn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'keyboard') then
    begin
      if keyboardn = nil then
        keyboardn := tr.Items.AddChild(rootn, '����');
      keyboardn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(keyboardn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'ports') then
    begin
      if portsn = nil then
        portsn := tr.Items.AddChild(rootn, '�˿� (COM �� LPT)');
      portsn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(portsn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'fdc') then
    begin
      if fdcn = nil then
        fdcn := tr.Items.AddChild(rootn, '���̿�����');
      fdcn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(fdcn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'mouse') then
    begin
      if mousen = nil then
        mousen := tr.Items.AddChild(rootn, '��������ָ���豸');
      mousen.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(mousen, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'monitor') then
    begin
      if monitorn = nil then
        monitorn := tr.Items.AddChild(rootn, '������');
      monitorn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(monitorn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'floppydisk') then
    begin
      if floppydiskn = nil then
        floppydiskn := tr.Items.AddChild(rootn, '����������');
      floppydiskn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(floppydiskn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'hidclass') then
    begin
      if hidclassn = nil then
        hidclassn := tr.Items.AddChild(rootn, 'USB ����ѧ�����豸');
      hidclassn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(hidclassn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'cdrom') then
    begin
      if cdromn = nil then
        cdromn := tr.Items.AddChild(rootn, 'DVD/CD-ROM ������');
      cdromn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(cdromn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'diskdrive') then
    begin
      if diskdriven = nil then
        diskdriven := tr.Items.AddChild(rootn, '����������');
      diskdriven.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(diskdriven, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'display') then
    begin
      if displayn = nil then
        displayn := tr.Items.AddChild(rootn, '��ʾ��');
      displayn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(displayn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'usb') then
    begin
      if usbn = nil then
        usbn := tr.Items.AddChild(rootn, 'USB ͨ�ô������߿�����');
      usbn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(usbn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'media') then
    begin
      if median = nil then
        median := tr.Items.AddChild(rootn, '���� ��Ƶ����Ϸ�ȶ�ý�������');
      median.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(median, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'net') then
    begin
      if netn = nil then
        netn := tr.Items.AddChild(rootn, '�����豸');
      netn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(netn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'scsiadapter') then
    begin
      if scsiadaptern = nil then
        scsiadaptern := tr.Items.AddChild(rootn, 'SCSI ������');
      scsiadaptern.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(scsiadaptern, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'computer') then
    begin
      if computern = nil then
        computern := tr.Items.AddChild(rootn, '�����');
      computern.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(computern, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'legacydriver') then
    begin
      if legacydrivern = nil then
        legacydrivern := tr.Items.AddChild(rootn, 'Legacy Driver Legacy ������');
      legacydrivern.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(legacydrivern, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'volume') then
    begin
      if volumen = nil then
        volumen := tr.Items.AddChild(rootn, 'ͨ�þ�');
      volumen.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(volumen, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'processor') then
    begin
      if processorn = nil then
        processorn := tr.Items.AddChild(rootn, 'CPU ���봦����');
      processorn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(processorn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'intelunifieddisplaydriver') then
    begin
      if intelunifieddisplaydrivern = nil then
        intelunifieddisplaydrivern := tr.Items.AddChild(rootn, 'IntelUnifiedDisplayDriver');
      intelunifieddisplaydrivern.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(intelunifieddisplaydrivern, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else if (lowercase(Types) = 'hdc') then
    begin
      if hdcn = nil then
        hdcn := tr.Items.AddChild(rootn, 'IDE ATA/ATAPI ������');
      hdcn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(hdcn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end
    else
    begin
      if othersn = nil then
        othersn := tr.Items.AddChild(rootn, 'ϵͳ�������豸');
      othersn.ImageIndex := ImageIndex;

      childnode := tr.Items.AddChild(othersn, name);
      childnode.ImageIndex := ImageIndex;
      childnode2 := tr.Items.AddChild(childnode, 'GUID��' + gui);
      childnode2.ImageIndex := ImageIndex;
      // childnode.ImageIndex:=-1;
    end;
    Inc(i);
    // systemn,keyboardn,portsn,fdcn,mousen,monitorn,flappydiskn,hidclassn,
    // cdromn,diskdriven,displayn,usbn,median,netn,scsiadaptern,computern,
    // legacydrivern,volumen,processorn,intelunifielddisplaydrivern,othersn,rootn:TTreenode;
  end;
  SetupDiDestroyDeviceInfoList(HDEVINFO);
end;

end.
