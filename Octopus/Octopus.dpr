program Octopus;

uses
  Forms,
  uOctopusAbout in 'uOctopusAbout.pas' {AboutBox},
  uOctopusMain in 'uOctopusMain.pas' {MainOctopusDebuggingDevelopmentForm},
  Vcl.Themes,
  Vcl.Styles,
  uMainSetting in 'uMainSetting.pas' {SettingPagesDlg},
  CPort in '..\ComPort\CPort.pas',
  CPortSetup in '..\ComPort\CPortSetup.pas' {ComSetupFrm},
  CPortCtl in '..\ComPort\CPortCtl.pas',
  CPortEsc in '..\ComPort\CPortEsc.pas',
  CPortTrmSet in '..\ComPort\CPortTrmSet.pas' {ComTrmSetForm},
  OcComPortObj in 'OcComPortObj.pas',
  uCommand in 'uCommand.pas' {CommandFrm},
  uDownloader in 'uDownloader.pas' {DownloaderFrm},
  uScreenMain in '..\..\octopus-zsbwm\SCREEN\uScreenMain.pas' {ScreenMainFrm},
  Screenshot in '..\..\octopus-zsbwm\SCREEN\Screenshot.pas' {ScreenshotFrm},
  uMergeBin in 'uMergeBin.pas' {MergeBinFrm},
  RSAUnit in '..\..\octopus-zsbwm\RSAOSSL\RSAUnit.pas',
  RSAOpenSSL in '..\..\octopus-zsbwm\RSAOSSL\RSAOpenSSL.pas',
  RSATestUnit in '..\..\octopus-zsbwm\RSAOSSL\RSATestUnit.pas' {RSATestForm},
  uEncryptionDecryption in '..\..\octopus-zsbwm\RSAOSSL\uEncryptionDecryption.pas' {DecryptEncryptFrm},
  uCRC in '..\..\octopus-zsbwm\CRC\uCRC.pas' {CRCFRM};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Octopus serial port debugging and development assistant';
  Application.CreateForm(TMainOctopusDebuggingDevelopmentForm, MainOctopusDebuggingDevelopmentForm);
  Application.CreateForm(TCommandFrm, CommandFrm);
  Application.CreateForm(TDownloaderFrm, DownloaderFrm);
  Application.CreateForm(TScreenMainFrm, ScreenMainFrm);
  Application.CreateForm(TScreenshotFrm, ScreenshotFrm);
  Application.CreateForm(TMergeBinFrm, MergeBinFrm);
  Application.CreateForm(TRSATestForm, RSATestForm);
  Application.CreateForm(TDecryptEncryptFrm, DecryptEncryptFrm);
  Application.CreateForm(TCRCFRM, CRCFRM);
  Application.Run;
end.
