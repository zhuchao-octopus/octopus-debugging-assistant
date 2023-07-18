unit uDeviceThread;

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient;

type
  TCheckDeviceThreak = class(TThread)
    ApplicationFileName: String;
    ConfigFileName: String;
  private
    { Private declarations }
    FClient: THTTPClient;
    FName: String;
    FBrand: String;
    FCustomer: String;
    FMAC: String;
    FIP: String;
    FAppVersion: String;
    FFwVersion: String;
    FRegion: String;
    FComments: String;
    procedure RSAPublicEncrypt(str: String);
  public
    procedure SetComments(Const Comments: String);
  protected
    procedure Execute; override;
  end;

const
  publickey =
    'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDoJ+0689QiXNJKQvROY/lOOcrlCzB9xfNipHdD9xaK7sZb1EcKJQJAl5mqyWz4fWgGAEjrqVPSrkGPgqEpCej1J1VNAx3E4Ig40ZQbl5EAgxo0W36+jQkklKjgcAoVvuhWovAZjcPqfmAUljGfQu8PlbZ8fE4AjHIHikQy88Cy2wIDAQAB';

implementation

uses NetInterface, GlobalFunctions, IniFiles;

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

  Synchronize(UpdateCaption);

  and UpdateCaption could look like,

  procedure TCheckDeviceThreak.UpdateCaption;
  begin
  Form1.Caption := 'Updated in a thread';
  end;

  or

  Synchronize(
  procedure
  begin
  Form1.Caption := 'Updated in thread via an anonymous method'
  end
  )
  );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}

{ TCheckDeviceThreak }

procedure TCheckDeviceThreak.RSAPublicEncrypt(str: String);
begin

end;

procedure TCheckDeviceThreak.SetComments(Const Comments: String);
begin
  Self.FComments := Comments;
end;

procedure TCheckDeviceThreak.Execute;
var
  URL, URL2: string;
  LResponse: IHTTPResponse;
  // LFileName: string;
  // LSize: Int64;
  // ss: TStringStream;
  cParam: TStringList;
  // FJson:TJsonObject;
  s: String;
  Octopusini: TIniFile;
  timeStamp, timeStamp2: Int64;
begin
  { Place thread code here }

  try
    Octopusini := TIniFile.Create(ConfigFileName);
    timeStamp := DateTimeToLongWord(Now(), 240); // 一天只登记一次
    timeStamp2 := Octopusini.ReadInt64('', 'TIMESTAMP', 0);
    if (timeStamp = timeStamp2) and (FComments <> '') then
      Exit;

    if FClient = nil then
      FClient := THTTPClient.Create;
    // FClient.OnReceiveData := ReceiveDataEvent;
    FClient.SecureProtocols := [THTTPSecureProtocol.TLS1, THTTPSecureProtocol.TLS11, THTTPSecureProtocol.TLS12];
    cParam := TStringList.Create;
    // cParam.Add('grant_type=client_credentials');
    // cParam.Add('client_id=' + '');
    // cParam.Add('client_secret=' + '');
    FName := '八爪鱼串口调试助手';
    FBrand := 'Octopus';
    FCustomer := GetMyComputerName();
    FMAC := GetNetBIOSAddress();
    FAppVersion := GetBuildInfo(ApplicationFileName);
    FFwVersion := GetWIndowsVersion();

    cParam.Add('name=' + FName);
    cParam.Add('brand=' + FBrand);
    cParam.Add('customer=' + FCustomer);

    cParam.Add('mac=' + FMAC);
    // cParam.Add('ip=' + FIP);

    cParam.Add('appVersion=' + FAppVersion);
    cParam.Add('fwVersion=' + FFwVersion);

    cParam.Add('region=' + FRegion);
    cParam.Add('comments=' + FComments);

    // s := RSATestForm.PublicEncrypt(cParam.ToString);
    // URL2 := 'http://47.106.172.94:8090/zhuchao/octopus/devices/testCheckRSA?str=' + s;
    // LResponse := FClient.Get(URL);

    if (timeStamp = timeStamp2) then
      Exit;
    URL := 'http://47.106.172.94:8090/zhuchao/octopus/devices/testCheck';
    s := FClient.Post(URL, cParam).ContentAsString;
    Octopusini.WriteInt64('', 'TIMESTAMP', timeStamp);
  finally
    if FClient <> nil then
      FClient.Free;
    if cParam <> nil then
      cParam.Free;
    if Octopusini <> nil then
      Octopusini.Free;
    FComments := '';
    Self.Terminate;
  end;

end;

end.
