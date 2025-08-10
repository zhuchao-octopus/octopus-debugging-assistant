unit OctopusComPort;

interface

uses
  SysUtils, Classes,CPortCtl;

Type
  TOctopusComPort = class(TComPort)
  private

  protected
  end;

procedure Register;

implementation

constructor TOctopusComPort.Create;
begin
  inherited;
end;

destructor TOctopusComPort.Destroy;
begin
  inherited;
end;

procedure TOctopusComPort.SetMyProperty(const Value: String);
begin
  FMyProperty := Value;
end;

procedure Register;
begin
  RegisterComponents('PageName', [TOctopusComPort]);
end;

end.
