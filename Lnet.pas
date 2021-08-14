unit Lnet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, IdCustomTCPServer, IdTCPServer, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
    IdTCPClient1: TIdTCPClient;
    IdTCPServer1: TIdTCPServer;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    TreeView1: TTreeView;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    fd1: TMenuItem;
    tt1: TMenuItem;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
const
  Names: array[0..5, 0..1] of string = (
    ('Rubble', 'Barney'),
    ('Michael', 'Johnson'),
    ('Bunny', 'Bugs'),
    ('Silver', 'HiHo'),
    ('Simpson', 'Bart'),
    ('Squirrel', 'Rocky')
    );

var
  I: Integer;
  NewColumn: TListColumn;
  ListItem: TListItem;
  ListView: TListView;
begin
  //ListView := ListView1;//TListView.Create(Self);
  with ListView do
  begin
    //Parent := Self;
    //Align := alClient;
    ViewStyle := vsReport;

    NewColumn := Columns.Add;
    NewColumn.Caption := 'Last';
    NewColumn := Columns.Add;
    NewColumn.Caption := 'First';

    for I := Low(Names) to High(Names) do
    begin
      ListItem := Items.Add;
      ListItem.Caption := Names[I][0];
      ListItem.SubItems.Add(Names[I][1]);
    end;
  end;


end;

end.
