unit Search;

interface

uses WinProcs,  SysUtils, StdCtrls, Dialogs, StrUtils;

const
  WordDelimiters: set of Char = [#0..#255] - ['a'..'z', 'A'..'Z', '1'..'9', '0'];

function SearchMemo(Memo: TMemo; const SearchString: string; Options: TFindOptions): Boolean;
//function SearchBuf(Buf: PChar; BufLen: Integer; SelStart, SelLength: Integer; SearchString: string; Options: TFindOptions): PChar;


//var

implementation

{
function SearchMemo(Memo: TCustomEdit; const SearchString: string;Options: TFindOptions): Boolean;
var
  Buffer, P: PChar;
  Size: Word;
begin
  Result := False;
  if (Length(SearchString) = 0) then Exit;
  Size := Memo.GetTextLen;
  if (Size = 0) then Exit;
  Buffer := StrAlloc(Size + 1);
  try
    Memo.GetTextBuf(Buffer, Size + 1);
    P := SearchBuf(Buffer, Size, Memo.SelStart, Memo.SelLength, SearchString, Options);
    if P <> nil then
    begin
      Memo.SelStart := P - Buffer;
      Memo.SelLength := Length(SearchString);
      Result := True;
    end;
  finally
    StrDispose(Buffer);
  end;
end;}
//TStringSeachOption = (soDown, soMatchCase, soWholeWord);
function SearchMemo(Memo: TMemo; const SearchString: string; Options: TFindOptions): Boolean;
var
  Size: Word;
  //StringSearchOptions:TStringSearchOptions;
  Buffer, P: PChar;
begin
  Result := False;
  if Length(SearchString) = 0 then
    Exit;

  Size := Memo.GetTextLen;
  //Size := Length(Memo.Text);
  if (Size = 0) then
    Exit;

  Buffer := SysUtils.StrAlloc(Size + 1);
  try
    Memo.GetTextBuf(Buffer, Size + 1);

    if frDown in Options then
      P := SearchBuf(Buffer, Size, Memo.SelStart, Memo.SelLength,SearchString, [soDown])
    else
      P := SearchBuf(Buffer, Size, Memo.SelStart, Memo.SelLength,SearchString, []);

    if (frMatchCase in Options) then
      P := SearchBuf(Buffer, Size, Memo.SelStart, Memo.SelLength, SearchString,[soMatchCase]);

    if (frWholeWord in Options) then
      P := SearchBuf(Buffer, Size, Memo.SelStart, Memo.SelLength, SearchString,[soWholeWord]);


    //P := SearchBuf(Buffer, Size, Memo.SelStart, Memo.SelLength, SearchString,StringSearchOptions);
    if P <> nil then
    begin
      Memo.SelStart := P - Buffer;
      Memo.SelLength := Length(SearchString);
      Result := True;
    end;

  finally
    SysUtils.StrDispose(Buffer);
  end;
end;




end.

