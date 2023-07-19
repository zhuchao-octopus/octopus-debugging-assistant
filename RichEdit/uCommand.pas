unit uCommand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  OcComPortObj;

type
  TCommandFrm = class(TForm)
    ComboBox1: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  var
    OcComPortObj: TOcComPortObj;
  end;

var
  CommandFrm: TCommandFrm;

implementation

{$R *.dfm}

procedure TCommandFrm.ComboBox1KeyPress(Sender: TObject; var Key: Char);
var
  Command: String;
begin
  if Key = #13 then
  begin
    if (OcComPortObj <> nil) and (OcComPortObj.Connected) then
    begin
      Command := Trim(ComboBox1.Text);
      OcComPortObj.FalconComSendData_Terminal(Command,0);
      if ComboBox1.Items.IndexOf(Command) < 0 then
      begin
        ComboBox1.Items.Add(Command);
      end;
      ComboBox1.Text := '';
    end;
  end;

end;

procedure TCommandFrm.FormShow(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, 0);
end;

end.
