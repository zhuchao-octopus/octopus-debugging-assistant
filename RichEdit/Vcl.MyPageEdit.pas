unit Vcl.MyPageEdit;

interface

uses
  System.SysUtils, System.StrUtils, Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, Vcl.ClipBrd,
  Vcl.ToolWin, Vcl.ActnList, System.Actions, System.ImageList, Vcl.ImgList, Vcl.StdActns, Vcl.ExtActns,
  Vcl.Tabs, VCLTee.TeCanvas, Vcl.Grids, Vcl.WinXCtrls, Vcl.TabNotBk, Vcl.Themes, SHDocVw;

type
  TMyRichEdit = class(TRichEdit);

  TMyPageEdit = class(TPageControl)
  private
    FRichEditList: TList;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreatePage(PageName: String; PageType: Integer = 0);
    procedure DeletePage(PageName: String); overload;
    procedure DeletePageComponent(Index: Integer); overload;

    procedure Log(Msg: String; Index: Integer);
    procedure Clear(Index: Integer);
    procedure FreeAll();

    function GetEdit(Index: Integer): TMyRichEdit; overload;
    function GetEdit(PageName: String): TMyRichEdit; overload;
    function GetWebBrowser(Index: Integer): TWebBrowser; overload;
    function GetWebBrowser(PageName: String): TWebBrowser; overload;

    function GetPageName(Index: Integer): String;
    function GetActivePageName(): String;
    function GetPageByName(PageName: String): TTabSheet;
    function GetPageIndex(PageName: String): Integer;
  published
  end;

implementation

constructor TMyPageEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRichEditList := TList.Create;
end;

function TMyPageEdit.GetPageIndex(PageName: String): Integer;
var
  TabSheet: TTabSheet;
begin
  Result := -1;
  TabSheet := GetPageByName(PageName);
  if TabSheet <> nil then
  begin
    Result := TabSheet.PageIndex;
  end;
end;

function TMyPageEdit.GetPageByName(PageName: String): TTabSheet;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to self.PageCount - 1 do
  begin
    if self.Pages[i].Caption = PageName then
    begin
      Result := self.Pages[i];
      break;
    end;
  end;
end;

procedure TMyPageEdit.CreatePage(PageName: String; PageType: Integer);
var
  NewTab: TTabSheet;
  NewRichEdit: TMyRichEdit;
  WebBrowser: TWebBrowser;
  // f: TFont;
begin
  if FRichEditList = nil then
    FRichEditList := TList.Create;
  if PageType = 0 then
  begin
    if GetPageByName(PageName) = nil then
    begin
      NewTab := TTabSheet.Create(self);
      NewTab.PageControl := self;
      NewTab.Caption := PageName;

      NewRichEdit := TMyRichEdit.Create(NewTab);
      NewRichEdit.Parent := NewTab;
      NewRichEdit.Align := alClient;
      NewRichEdit.BorderStyle := bsNone;
      NewRichEdit.ScrollBars := ssBoth;
      NewRichEdit.DoubleBuffered := true;
      NewRichEdit.FDoubleBuffered := true;
      NewRichEdit.FDoubleBufferedSaved := true;
      NewRichEdit.ParentDoubleBuffered := true;

      NewRichEdit.WantReturns := false;
      NewRichEdit.HideSelection := false;
      NewRichEdit.EnableURLs := true;
      FRichEditList.Add(NewRichEdit);

      /// f := TFont.Create;
      /// f.Charset := TFontCharset(DEFAULT_CHARSET);
      /// f.Color := clWindowText;
      /// f.Name := 'Segoe UI';
      /// f.Size := 10;
      NewRichEdit.ParentFont := false;
      NewRichEdit.Font.Charset := TFontCharset(DEFAULT_CHARSET);
      NewRichEdit.Font.Name := '新宋体';
      NewRichEdit.Font.Size := 14;
    end;
  end;

  if PageType = 1 then
  begin
    if GetPageByName(PageName) = nil then
    begin
      NewTab := TTabSheet.Create(self);
      NewTab.PageControl := self;
      NewTab.Caption := PageName;

      WebBrowser := TWebBrowser.Create(NewTab);
      WebBrowser.SetParentComponent(NewTab);
      WebBrowser.Align := alClient;
      WebBrowser.silent := true; // 屏蔽脚本错误
      FRichEditList.Add(WebBrowser);
    end;
  end;

end;

procedure TMyPageEdit.DeletePage(PageName: String);
var
  // i: Integer;
  NewTab: TTabSheet;
begin
  NewTab := GetPageByName(PageName);
  if NewTab <> nil then
  begin
    DeletePageComponent(NewTab.PageIndex);
    NewTab.Free;
    NewTab := nil;
  end;
end;

procedure TMyPageEdit.DeletePageComponent(Index: Integer);
var
  NewRichEdit: TRichEdit;
begin
  if FRichEditList = nil then
    Exit;
  if Index >= FRichEditList.Count then
    Exit;
  if Index < 0 then
    Exit;

  NewRichEdit := FRichEditList.Items[Index];
  FRichEditList.Delete(Index);
  NewRichEdit.Free;

end;

function TMyPageEdit.GetEdit(Index: Integer): TMyRichEdit;
var
  tmpComponent: TComponent;
begin
  Result := nil;
  if FRichEditList = nil then
    Exit;
  if Index >= FRichEditList.Count then
    Exit;
  if Index < 0 then
    Exit;
  tmpComponent := FRichEditList.Items[Index];
  if tmpComponent is TMyRichEdit then
    Result := TMyRichEdit(tmpComponent);
end;

function TMyPageEdit.GetEdit(PageName: String): TMyRichEdit;
var
  NewTab: TTabSheet;
begin
  Result := nil;
  NewTab := GetPageByName(PageName);
  if NewTab <> nil then
  begin
    Result := GetEdit(NewTab.PageIndex);
  end;
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

function TMyPageEdit.GetPageName(Index: Integer): String;
begin
  Result := 'Null';
  if ((Index < 0) or (Index >= self.PageCount)) then
    Exit;

  Result := self.Pages[Index].Caption;
end;

function TMyPageEdit.GetActivePageName(): String;
begin
  Result := self.ActivePage.Caption;
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

function TMyPageEdit.GetWebBrowser(Index: Integer): TWebBrowser;
var
  tmpComponent: TComponent;
begin
  Result := nil;
  if FRichEditList = nil then
    Exit;
  if Index >= FRichEditList.Count then
    Exit;
  if Index < 0 then
    Exit;
  tmpComponent := FRichEditList.Items[Index];
  if tmpComponent is TWebBrowser then
    Result := TWebBrowser(tmpComponent);
end;

function TMyPageEdit.GetWebBrowser(PageName: String): TWebBrowser;
var
  NewTab: TTabSheet;
begin
  Result := nil;
  NewTab := GetPageByName(PageName);
  if NewTab <> nil then
  begin
    Result := GetWebBrowser(NewTab.PageIndex);
  end;
end;

procedure TMyPageEdit.FreeAll();
var
  i: Integer;
begin
  for i := 0 to self.FRichEditList.Count - 1 do
  begin
  end;
  FRichEditList.Clear;
end;

end.
