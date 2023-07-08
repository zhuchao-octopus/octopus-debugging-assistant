program richeditdemo;

uses
  Forms,
  uOctopusAbout in 'uOctopusAbout.pas' {AboutBox},
  uOctopusMain in 'uOctopusMain.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  Vcl.Tabs in 'Vcl.Tabs.pas',
  uSetting in 'uSetting.pas' {SettingPagesDlg},
  CPort in '..\ComPort\CPort.pas',
  CPortSetup in '..\ComPort\CPortSetup.pas' {ComSetupFrm},
  CPortCtl in '..\ComPort\CPortCtl.pas',
  CPortEsc in '..\ComPort\CPortEsc.pas',
  CPortTrmSet in '..\ComPort\CPortTrmSet.pas' {ComTrmSetForm},
  OcProtocol in '..\OcProtocol.pas',
  OcPcDeviceMgt in '..\OcPcDeviceMgt.pas',
  uGlobalFunction in '..\uGlobalFunction.pas',
  OcComPortObj in 'OcComPortObj.pas';

{$R richedit.RES}

begin
  Application.Initialize;
  Application.Title := 'Rich Edit Control Demo';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
