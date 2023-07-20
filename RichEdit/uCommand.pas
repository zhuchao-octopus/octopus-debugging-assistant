unit uCommand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  OcComPortObj;

type
  TCommandFrm = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FCmdBuf: array [0 .. 1] of Byte;
  public
    { Public declarations }
  var
    OcComPortObj: TOcComPortObj;
  end;

var
  CommandFrm: TCommandFrm;

implementation

{$R *.dfm}

procedure TCommandFrm.FormShow(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, 0);
end;

procedure TCommandFrm.ComboBox1KeyPress(Sender: TObject; var Key: Char);
var
  Command: String;
begin
  if Key = #13 then // 0x0D CR (carriage return) 回车键
  begin

    if (OcComPortObj <> nil) and (OcComPortObj.Connected) then
    begin
      /// Control+VK_C
      FCmdBuf[0] := $03; // 0x03 ETX (end of text) 正文结束

      Command := Trim(ComboBox1.Text);

      if Command = 'Control+C' then
        OcComPortObj.FalconComSendBuffer(FCmdBuf, 1)
      else
        OcComPortObj.FalconComSendData_Terminal(Command, 0);

      if ComboBox1.Items.IndexOf(Command) < 0 then
        ComboBox1.Items.Add(Command);

      if Sender <> nil then
        ComboBox1.Text := '';

    end
    else if (OcComPortObj <> nil) then
    begin
      OcComPortObj.DebugLog('Open a device ...');
    end;

  end;

end;

procedure TCommandFrm.Button1Click(Sender: TObject);
var
  Key: Char;
begin
  Key := #13;
  ComboBox1KeyPress(nil, Key);
end;

procedure TCommandFrm.Button2Click(Sender: TObject);
var
  buffer: array [0 .. 255] of Byte;
  Command: String;
  bLength: Integer;
  BytesWritten: Cardinal;
begin

  if (not OcComPortObj.Connected) then
  begin
    /// Log0('No device is found,please open a device.');
    /// MessageBox(Application.Handle, 'No device is found,please open a device.', PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;

  Command := Trim(ComboBox1.Text);
  OcComPortObj.FalconComSendData_MultiTimes(Command, 1);

  if ComboBox1.Items.IndexOf(Command) < 0 then
    ComboBox1.Items.Add(Command);
end;

end.
