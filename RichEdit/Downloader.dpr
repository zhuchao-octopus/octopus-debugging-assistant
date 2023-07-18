program Downloader;

uses
  Vcl.Forms,
  uDownloader in 'uDownloader.pas' {DownloaderFrm},
  uDownloadsManager in 'uDownloadsManager.pas',
  DataEngine in '..\..\ZSBWM\POWERENGINE\DataEngine.pas',
  GlabalSession in '..\..\ZSBWM\PUBLIC\GlabalSession.pas',
  GlobalFunctions in '..\..\ZSBWM\PUBLIC\GlobalFunctions.pas',
  GlobalTypeConst in '..\..\ZSBWM\PUBLIC\GlobalTypeConst.pas',
  MessageQueue in '..\..\ZSBWM\PUBLIC\MessageQueue.pas',
  uOctopusFunction in '..\uOctopusFunction.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDownloaderFrm, DownloaderFrm);
  Application.Run;
end.
