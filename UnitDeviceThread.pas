unit UnitDeviceThread;

interface

uses
  System.Classes, System.Net.HttpClient;

type
  TCheckDeviceThreak = class(TThread)
  ApplicationFileName:String;
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

  protected
    procedure Execute; override;
  end;

implementation
 uses NetInterface,GlobalFunctions;

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

procedure TCheckDeviceThreak.Execute;
var
  URL: string;
  // LResponse: IHTTPResponse;
  // LFileName: string;
  // LSize: Int64;
  // ss: TStringStream;
  cParam: TStringList;
  // FJson:TJsonObject;
  s: String;
begin
  { Place thread code here }

  try
    if FClient = nil then
      FClient := THTTPClient.Create;
    // FClient.OnReceiveData := ReceiveDataEvent;
    FClient.SecureProtocols := [THTTPSecureProtocol.TLS1, THTTPSecureProtocol.TLS11, THTTPSecureProtocol.TLS12];
    cParam := TStringList.Create;
    // cParam.Add('grant_type=client_credentials');
    // cParam.Add('client_id=' + '');
    // cParam.Add('client_secret=' + '');
    FName:='°Ë×¦Óã´®¿Úµ÷ÊÔÖúÊÖ';
    FBrand:='Octopus';
    FCustomer:=GetMyComputerName();
    FMAC:=GetNetBIOSAddress();
    FAppVersion:= GetBuildInfo(ApplicationFileName);
    FFwVersion:=  GetWIndowsVersion();

    cParam.Add('name=' + FName);
    cParam.Add('brand=' + FBrand);
    cParam.Add('customer=' + FCustomer);

    cParam.Add('mac=' + FMAC);
    //cParam.Add('ip=' + FIP);

    cParam.Add('appVersion=' + FAppVersion);
    cParam.Add('fwVersion=' + FFwVersion);

    cParam.Add('region=' + FRegion);
    cParam.Add('comments=' + FComments);

    URL := 'http://47.106.172.94:8090/zhuchao/octopus/devices/testCheck';
    s := FClient.Post(URL, cParam).ContentAsString;
  finally
    FClient.Free;
  end;

end;

end.
