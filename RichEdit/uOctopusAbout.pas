unit uOctopusAbout;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, SysUtils, Vcl.Imaging.pngimage, Vcl.ComCtrls;

type
  TAboutBox = class(TForm)
    OKButton: TButton;
    FreeRes: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    ProgramIcon: TImage;
    PhysMem: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LinkLabel1: TLinkLabel;
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.dfm}

uses uMainSetting;

procedure TAboutBox.FormCreate(Sender: TObject);
var
  MS: TMemoryStatusEx;
begin
  MS.dwLength := SizeOf(TMemoryStatusEx);
  GlobalMemoryStatusEx(MS);
  PhysMem.Caption := FormatFloat('#,###" MB"', MS.ullTotalPhys shr 20);
  FreeRes.Caption := Format('%d %%', [MS.dwMemoryLoad]);
{$IFDEF CPU64BITS}
  Label5.Caption := 'Version Information: ' + SettingPagesDlg.VersionNumberStr + '  (' + SettingPagesDlg.WindowsVersion + ' 64bit )';
{$ELSE}
  Label5.Caption := 'Version Information: ' + SettingPagesDlg.VersionNumberStr + '  (' + SettingPagesDlg.WindowsVersion + ' 32bit )';
{$ENDIF}
end;

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
  Close;
end;

end.
