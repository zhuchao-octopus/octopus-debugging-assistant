program BZYSP;

uses
  Forms,
  uOctopusAbout in 'uOctopusAbout.pas' {AboutBox},
  uOctopusMain in 'uOctopusMain.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  Vcl.Tabs in 'Vcl.Tabs.pas',
  uMainSetting in 'uMainSetting.pas' {SettingPagesDlg},
  CPort in '..\ComPort\CPort.pas',
  CPortSetup in '..\ComPort\CPortSetup.pas' {ComSetupFrm},
  CPortCtl in '..\ComPort\CPortCtl.pas',
  CPortEsc in '..\ComPort\CPortEsc.pas',
  CPortTrmSet in '..\ComPort\CPortTrmSet.pas' {ComTrmSetForm},
  OcProtocol in '..\OcProtocol.pas',
  OcPcDeviceMgt in '..\OcPcDeviceMgt.pas',
  uGlobalFunction in '..\uGlobalFunction.pas',
  OcComPortObj in 'OcComPortObj.pas',
  Vcl.MyPageEdit in 'Vcl.MyPageEdit.pas',
  uDeviceThread in '..\uDeviceThread.pas',
  Mail4Delphi.Intf in '..\..\ZSBWM\SMTP\Mail4Delphi.Intf.pas',
  Mail4Delphi in '..\..\ZSBWM\SMTP\Mail4Delphi.pas',
  uSetting in '..\..\ZSBWM\SMTP\uSetting.pas' {ConfigurationFrm},
  Screenshot in '..\..\ZSBWM\SCREEN\Screenshot.pas' {ScreenshotFrm},
  uCutSetting in '..\..\ZSBWM\SCREEN\uCutSetting.pas' {CutSettingForm},
  uScreenMain in '..\..\ZSBWM\SCREEN\uScreenMain.pas' {ScreenMainFrm},
  libeay32 in '..\..\ZSBWM\RSAOSSL\libeay32.pas',
  MainFormUnit in '..\..\ZSBWM\RSAOSSL\MainFormUnit.pas' {DecryptEncryptFrm},
  RSAOpenSSL in '..\..\ZSBWM\RSAOSSL\RSAOpenSSL.pas',
  RSATestUnit in '..\..\ZSBWM\RSAOSSL\RSATestUnit.pas' {RSATestForm},
  RSAUnit in '..\..\ZSBWM\RSAOSSL\RSAUnit.pas',
  GlobalFunctions in '..\..\ZSBWM\PUBLIC\GlobalFunctions.pas',
  NetHttpInterface in '..\..\ZSBWM\PUBLIC\NetHttpInterface.pas',
  uSMTP in '..\..\ZSBWM\SMTP\uSMTP.pas' {SubmitProblemFrm},
  uCRC in '..\..\ZSBWM\CRC\uCRC.pas' {CRCFRM},
  uClass_CNN in '..\..\ZSBWM\ANN\CNN\Common\uClass_CNN.pas',
  uClass_Imaging in '..\..\ZSBWM\ANN\CNN\Common\uClass_Imaging.pas',
  uClasses_Types in '..\..\ZSBWM\ANN\CNN\Common\uClasses_Types.pas',
  uFunctions in '..\..\ZSBWM\ANN\CNN\Common\uFunctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Octopus serial port debugging and development assistant';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TConfigurationFrm, ConfigurationFrm);
  Application.CreateForm(TScreenshotFrm, ScreenshotFrm);
  Application.CreateForm(TCutSettingForm, CutSettingForm);
  Application.CreateForm(TScreenMainFrm, ScreenMainFrm);
  Application.CreateForm(TDecryptEncryptFrm, DecryptEncryptFrm);
  Application.CreateForm(TRSATestForm, RSATestForm);
  Application.CreateForm(TSubmitProblemFrm, SubmitProblemFrm);
  Application.CreateForm(TCRCFRM, CRCFRM);
  Application.Run;
end.
