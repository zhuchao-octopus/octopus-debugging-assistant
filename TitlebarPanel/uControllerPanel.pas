unit uControllerPanel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Tabs, VCLTee.TeCanvas, Vcl.StdCtrls,
  Vcl.Grids, Vcl.ExtCtrls;

type
  TFrmControllerPanel = class(TForm)
    Panel6: TPanel;
    Notebook3: TNotebook;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    Memo2: TMemo;
    Panel8: TPanel;
    Button7: TButton;
    Button8: TButton;
    Button25: TButton;
    Panel13: TPanel;
    Memo3: TMemo;
    Button9: TButton;
    Button11: TButton;
    Button13: TButton;
    Panel12: TPanel;
    StringGrid1: TStringGrid;
    Panel4: TPanel;
    Button1: TButton;
    Button3: TButton;
    Panel10: TPanel;
    Memo5: TMemo;
    Panel16: TPanel;
    Button16: TButton;
    Button27: TButton;
    Button28: TButton;
    Panel18: TPanel;
    Label18: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    ComboBox12: TComboBox;
    ComboBox9: TComboBox;
    ComboBox10: TComboBox;
    ComboBox11: TComboBox;
    Panel9: TPanel;
    GroupBox10: TGroupBox;
    CheckBox10: TCheckBox;
    Button15: TButton;
    Button18: TButton;
    Button19: TButton;
    ButtonColor1: TButtonColor;
    ButtonColor2: TButtonColor;
    CheckBox11: TCheckBox;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Panel15: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    TabSet3: TTabSet;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FCheck, FNoCheck: TBitmap;
    { Private declarations }
    procedure initStringGrid();
  public
    { Public declarations }
  end;

var
  FrmControllerPanel: TFrmControllerPanel;

implementation

{$R *.dfm}

procedure TFrmControllerPanel.FormCreate(Sender: TObject);
begin
  initStringGrid();
end;

procedure TFrmControllerPanel.initStringGrid();
var
  bmp: TBitmap;
  i: Integer;
  GridRect: TGridRect;
begin
  try
    FCheck := TBitmap.Create;
    FNoCheck := TBitmap.Create;
    bmp := TBitmap.Create;
    bmp.Handle := LoadBitmap(0, PChar(OBM_CHECKBOXES));
    bmp.PixelFormat := pf32bit;
    bmp.HandleType := bmDIB;
    bmp.Transparent := True;
    bmp.TransparentColor := clWhite;
    // Bmp.Canvas.Brush.Color := clWhite;
    // Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));

    FNoCheck.PixelFormat := pf32bit;
    FNoCheck.HandleType := bmDIB;
    FNoCheck.Transparent := True;
    FNoCheck.TransparentColor := clWhite;
    with FNoCheck do
    begin
      Width := bmp.Width div 4;
      Height := bmp.Height div 3;
      Canvas.CopyRect(Canvas.cliprect, bmp.Canvas, Canvas.cliprect);
    end;
    with FCheck do
    begin
      Width := bmp.Width div 4;
      Height := bmp.Height div 3;
      Canvas.CopyRect(Canvas.cliprect, bmp.Canvas, Rect(Width, 0, 2 * Width, Height));
    end;
  finally
    DeleteObject(bmp.Handle);
    bmp.Free;
  end;

  StringGrid1.Cells[0, 0] := '字符 ';
  StringGrid1.Cells[1, 0] := '字节 ';
  StringGrid1.Cells[2, 0] := ' X';
  StringGrid1.Cells[3, 0] := '待发送文本内容';
  StringGrid1.Cells[4, 0] := '循环';
  StringGrid1.Cells[5, 0] := '间隔';
  StringGrid1.Cells[6, 0] := '解释说明';
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    StringGrid1.Cells[0, i] := Format('%.02d ', [i]); // '0' + inttostr(i)
    StringGrid1.Cells[1, i] := Format('%.02d ', [i]);
    StringGrid1.Cells[4, i] := '1';
    StringGrid1.Cells[5, i] := '10';
  end;
  with GridRect do
  begin
    Top := 2;
    Left := 2;
    Bottom := 2;
    Right := 2;
  end;
  StringGrid1.Selection := GridRect;
end;

procedure TFrmControllerPanel.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
try
    if ACol = 2 then
    begin
      if not(gdFixed in State) then
        with TStringGrid(Sender).Canvas do
        begin
          Brush.Color := clWindow;
          fillRect(Rect);
          if StringGrid1.Cells[ACol, ARow] = '1' then
            Draw((Rect.Right + Rect.Left - FCheck.Width) div 2 - 2, (Rect.Bottom + Rect.Top - FCheck.Height) div 2, FCheck)
          else
            Draw((Rect.Right + Rect.Left - FCheck.Width) div 2 - 2, (Rect.Bottom + Rect.Top - FCheck.Height) div 2, FNoCheck);
        end;
    end;
  except
  end;
end;

procedure TFrmControllerPanel.StringGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
 if (StringGrid1.Col = 4) or (StringGrid1.Col = 5) then
  begin
    if not(Key in ['0' .. '9', #8]) then
      Key := #0;
  end;
end;

procedure TFrmControllerPanel.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  GridRect: TGridRect;
begin
  if StringGrid1.Row = 0 then
    exit;
  if (StringGrid1.Col = 2) then
  begin
    if StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row] <> '' then
      StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row] := ''
    else
      StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row] := '1';

    with GridRect do
    begin
      Top := StringGrid1.Selection.Top;
      Left := StringGrid1.Selection.Left + 1;
      Bottom := StringGrid1.Selection.Bottom;
      Right := StringGrid1.Selection.Right;
    end;
    StringGrid1.Selection := GridRect;
  end;

end;

procedure TFrmControllerPanel.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  GridRect: TGridRect;
begin
  if StringGrid1.Row = 0 then
    exit;
  if (StringGrid1.Col = 2) then
  begin
    with GridRect do
    begin
      Top := StringGrid1.Selection.Top;
      Left := StringGrid1.Selection.Left + 1;
      Bottom := StringGrid1.Selection.Bottom;
      Right := StringGrid1.Selection.Right;
    end;
    StringGrid1.Selection := GridRect;
  end;

end;

procedure TFrmControllerPanel.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  with StringGrid1 do
  begin
    if ACol in [2] then
      Options := Options - [goEditing]
    else
      Options := Options + [goEditing];
  end;
end;

end.
