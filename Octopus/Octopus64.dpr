program Octopus64;

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
  uDownloadsManager in 'uDownloadsManager.pas',
  uDownloader in 'uDownloader.pas' {DownloaderFrm},
  uPageSetup in 'uPageSetup.pas' {PageSetupFrm},
  uMergeBin in 'uMergeBin.pas' {MergeBinFrm},
  uCRC in '..\..\octopus-zsbwm\CRC\uCRC.pas' {CRCFRM},
  uEncryptionDecryption in '..\..\octopus-zsbwm\RSAOSSL\uEncryptionDecryption.pas' {DecryptEncryptFrm},
  uSMTP in '..\..\octopus-zsbwm\SMTP\uSMTP.pas' {SubmitProblemFrm},
  uScreenMain in '..\..\octopus-zsbwm\SCREEN\uScreenMain.pas' {ScreenMainFrm};

{$R *.res}

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('Emerald Light Slate');
  Application.Title := 'Octopus Serial Port Development & Debugging Assistant';
  Application.CreateForm(TMainOctopusDebuggingDevelopmentForm, MainOctopusDebuggingDevelopmentForm);
  Application.CreateForm(TCommandFrm, CommandFrm);
  Application.CreateForm(TDownloaderFrm, DownloaderFrm);
  Application.CreateForm(TPageSetupFrm, PageSetupFrm);
  Application.CreateForm(TMergeBinFrm, MergeBinFrm);
  Application.CreateForm(TMergeBinFrm, MergeBinFrm);
  Application.CreateForm(TCRCFRM, CRCFRM);
  Application.CreateForm(TDecryptEncryptFrm, DecryptEncryptFrm);
  Application.CreateForm(TSubmitProblemFrm, SubmitProblemFrm);
  Application.CreateForm(TScreenMainFrm, ScreenMainFrm);
  Application.Run;

end.
