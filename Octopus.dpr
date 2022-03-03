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
  ocPcDeviceMgt in 'ocPcDeviceMgt.pas',
  Unit200 in 'Unit200.pas',
  OcDecrypt in 'OcDecrypt.pas',
  UnitCmdShell in 'UnitCmdShell.pas',
  OcFindAnd in 'OcFindAnd.pas' {OcFindAndFrm},
  JvSetupApi in 'HID\JvSetupApi.pas',
  CPort in 'ComPort\CPort.pas',
  CPortSetup in 'ComPort\CPortSetup.pas' {ComSetupFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'OCTOPUS °Ë×¦Óã´®¿ÚÖÕ¶Ë';
  Application.CreateForm(TSplitViewForm, SplitViewForm);
  Application.CreateForm(TOcFindAndFrm, OcFindAndFrm);
  Application.Run;

end.
