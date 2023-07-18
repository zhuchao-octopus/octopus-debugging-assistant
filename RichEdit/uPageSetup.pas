unit uPageSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,

  Vcl.MyPageEdit;

type
  TPageSetupFrm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    Button1: TButton;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure UpDown2Changing(Sender: TObject; var AllowChange: Boolean);
    procedure UpDown3Changing(Sender: TObject; var AllowChange: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CMyRichEdit: TMyRichEdit;
  end;

var
  PageSetupFrm: TPageSetupFrm;

implementation

{$R *.dfm}

procedure TPageSetupFrm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TPageSetupFrm.FormShow(Sender: TObject);
begin
  if CMyRichEdit <> nil then
  begin
    UpDown1.Position := CMyRichEdit.Paragraph.FirstIndent;
    UpDown2.Position := CMyRichEdit.Paragraph.LeftIndent;
    UpDown3.Position := CMyRichEdit.Paragraph.LeftIndent;
  end;
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, 0);
end;

procedure TPageSetupFrm.UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  if CMyRichEdit <> nil then
  begin
    if Self.CheckBox1.Checked then
      CMyRichEdit.SelectAll;
    /// else
    /// CMyRichEdit.SetSel(-1, -1);

    CMyRichEdit.Paragraph.FirstIndent := UpDown1.Position;
  end;
end;

procedure TPageSetupFrm.UpDown2Changing(Sender: TObject; var AllowChange: Boolean);
begin
  if CMyRichEdit <> nil then
  begin
    CMyRichEdit.Paragraph.LeftIndent := UpDown2.Position;
  end;
end;

procedure TPageSetupFrm.UpDown3Changing(Sender: TObject; var AllowChange: Boolean);
begin
  if CMyRichEdit <> nil then
  begin
    CMyRichEdit.Paragraph.RightIndent := UpDown3.Position;
  end;
end;

end.
