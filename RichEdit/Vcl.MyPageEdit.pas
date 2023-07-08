unit Vcl.MyPageEdit;

interface

uses
  System.SysUtils, System.StrUtils, Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, Vcl.ClipBrd,
  Vcl.ToolWin, Vcl.ActnList, System.Actions, System.ImageList, Vcl.ImgList, Vcl.StdActns, Vcl.ExtActns,
  Vcl.Tabs, VCLTee.TeCanvas, Vcl.Grids, Vcl.WinXCtrls, Vcl.TabNotBk, Vcl.Themes;

type
  TMyRichEdit = class(TRichEdit);

  TMyPageEdit = class(TPageControl)
  private
    FRichEditList: TList;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreatePage(PageName: String);
    procedure DeletePage(PageName: String); overload;
    procedure DeletePage(Index: Integer); overload;

    procedure Log(Msg: String; Index: Integer);
    procedure Clear(Index: Integer);

    function GetEdit(Index: Integer): TMyRichEdit;

  published
  end;

implementation

constructor TMyPageEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRichEditList := TList.Create;
end;

procedure TMyPageEdit.CreatePage(PageName: String);
var
  NewTab: TTabSheet;
  NewRichEdit: TMyRichEdit;
begin
  NewTab := TTabSheet.Create(self);
  NewTab.PageControl := self;
  NewTab.Caption := PageName;

  NewRichEdit := TMyRichEdit.Create(NewTab);
  NewRichEdit.Parent := NewTab;
  NewRichEdit.Align := alClient;
  FRichEditList.Add(NewRichEdit);
end;

procedure TMyPageEdit.DeletePage(PageName: String);
begin

end;

procedure TMyPageEdit.DeletePage(Index: Integer);
var
  NewRichEdit: TRichEdit;
begin
  if Index >= FRichEditList.Count then
    Exit;
  if Index < 0 then
    Exit;

  NewRichEdit := FRichEditList.Items[Index];
  FRichEditList.Delete(Index);
  NewRichEdit.Free;
end;

function TMyPageEdit.GetEdit(Index: Integer): TMyRichEdit;
begin
  Result := nil;
  if Index >= FRichEditList.Count then
    Exit;
  if Index < 0 then
    Exit;

  Result := FRichEditList.Items[Index];
end;

procedure TMyPageEdit.Log(Msg: String; Index: Integer);
var
  NewRichEdit: TMyRichEdit;
begin
  NewRichEdit := GetEdit(Index);
  if NewRichEdit <> nil then
  begin
    NewRichEdit.Lines.Append(Msg);
  end;
end;

procedure TMyPageEdit.Clear(Index: Integer);
var
  NewRichEdit: TMyRichEdit;
begin
  NewRichEdit := GetEdit(Index);
  if NewRichEdit <> nil then
  begin
    NewRichEdit.Clear;
  end;


end;

end.
