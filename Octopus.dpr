// ---------------------------------------------------------------------------

// This software is Copyright (c) 2015 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

// ---------------------------------------------------------------------------

program Octopus;

uses
  Vcl.Forms,
  uSplitView in 'uSplitView.pas' {SplitViewForm},
  Vcl.Themes,
  Vcl.Styles,
  OcComPortObj in 'OcComPortObj.pas',
  CPortCtl in 'ComPort\CPortCtl.pas',
  CPortEsc in 'ComPort\CPortEsc.pas',
  CPortTrmSet in 'ComPort\CPortTrmSet.pas',
  OcProtocol in 'OcProtocol.pas',
  DBT in 'HID\DBT.pas',
  HID in 'HID\HID.pas',
  HidToken in 'HID\HidToken.pas',
  HidUsage in 'HID\HidUsage.pas',
  JVCLVer in 'HID\JVCLVer.pas',
  JvComponentBase in 'HID\JvComponentBase.pas',
  JvConsts in 'HID\JvConsts.pas',
  JvHidControllerClass in 'HID\JvHidControllerClass.pas',
  JvResources in 'HID\JvResources.pas',
  JvTypes in 'HID\JvTypes.pas',
  ModuleLoader in 'HID\ModuleLoader.pas',
  WinConvTypes in 'HID\WinConvTypes.pas',
  uGlobalFunction in 'uGlobalFunction.pas',
  OcDecrypt in 'OcDecrypt.pas',
  uCmdShell in 'uCmdShell.pas',
  OcFindAnd in 'OcFindAnd.pas' {OcFindAndFrm},
  JvSetupApi in 'HID\JvSetupApi.pas',
  CPort in 'ComPort\CPort.pas',
  CPortSetup in 'ComPort\CPortSetup.pas' {ComSetupFrm},
  uDeviceThread in 'uDeviceThread.pas',
  OcPcDeviceMgt in 'OcPcDeviceMgt.pas',
  Vcl.Tabs in 'Vcl.Tabs.pas',
  Mail4Delphi.Intf in '..\ZSBWM\SMTP\Mail4Delphi.Intf.pas',
  Mail4Delphi in '..\ZSBWM\SMTP\Mail4Delphi.pas',
  uSetting in '..\ZSBWM\SMTP\uSetting.pas' {ConfigurationFrm},
  uSMTP in '..\ZSBWM\SMTP\uSMTP.pas' {SubmitProblemFrm},
  NetHttpInterface in '..\ZSBWM\PUBLIC\NetHttpInterface.pas',
  GlobalFunctions in '..\ZSBWM\PUBLIC\GlobalFunctions.pas',
  Screenshot in '..\ZSBWM\SCREEN\Screenshot.pas' {ScreenshotFrm},
  uScreenMain in '..\ZSBWM\SCREEN\uScreenMain.pas' {ScreenMainFrm},
  uClass_CNN in '..\ZSBWM\ANN\CNN\Common\uClass_CNN.pas',
  uClass_Imaging in '..\ZSBWM\ANN\CNN\Common\uClass_Imaging.pas',
  uClasses_Types in '..\ZSBWM\ANN\CNN\Common\uClasses_Types.pas',
  uFunctions in '..\ZSBWM\ANN\CNN\Common\uFunctions.pas',
  uCutSetting in '..\ZSBWM\SCREEN\uCutSetting.pas' {CutSettingForm},
  MainFormUnit in '..\ZSBWM\RSAOSSL\MainFormUnit.pas' {DecryptEncryptFrm},
  libeay32 in '..\ZSBWM\RSAOSSL\libeay32.pas',
  RSAOpenSSL in '..\ZSBWM\RSAOSSL\RSAOpenSSL.pas',
  RSATestUnit in '..\ZSBWM\RSAOSSL\RSATestUnit.pas' {RSATestForm},
  RSAUnit in '..\ZSBWM\RSAOSSL\RSAUnit.pas',
  uCRC in '..\ZSBWM\CRC\uCRC.pas' {CRCFRM};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'OCTOPUS °Ë×¦Óã´®¿ÚÖÕ¶Ë';
  Application.CreateForm(TSplitViewForm, SplitViewForm);
  Application.CreateForm(TOcFindAndFrm, OcFindAndFrm);
  Application.CreateForm(TConfigurationFrm, ConfigurationFrm);
  Application.CreateForm(TSubmitProblemFrm, SubmitProblemFrm);
  Application.CreateForm(TScreenshotFrm, ScreenshotFrm);
  Application.CreateForm(TScreenMainFrm, ScreenMainFrm);
  Application.CreateForm(TCutSettingForm, CutSettingForm);
  Application.CreateForm(TDecryptEncryptFrm, DecryptEncryptFrm);
  Application.CreateForm(TRSATestForm, RSATestForm);
  Application.CreateForm(TCRCFRM, CRCFRM);
  Application.Run;

end.
