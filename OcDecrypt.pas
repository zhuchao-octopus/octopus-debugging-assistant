unit OcDecrypt;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Actions,
  IdHashMessageDigest,
  ComObj,
  StrUtils,
  Octopus_CRC;

function EncryptInt(d: Integer): string;
function DecryptInt(ks: string): Integer;

implementation

// Encrypt integer to str
function EncryptInt(d: Integer): string;
var
  i: Integer;
  cd: array [0 .. 7] of byte;
begin
  cd[1] := Random(256);
  cd[4] := Random(cd[1]);
  cd[6] := Random(cd[1] + cd[4]);
  cd[2] := (((d div $10000) mod $100) + cd[1]) xor cd[4];
  cd[3] := (((d div $100) mod $100) - cd[2]) xor (cd[1] - cd[4]);
  cd[5] := ((d mod $100) - cd[6]) xor (cd[1] + cd[3]);
  cd[7] := ((d div $1000000) mod $100) + cd[1] + cd[5];
  cd[0] := ((cd[1] xor cd[2]) xor cd[3]) + (cd[4] or cd[5]) + (cd[6] and cd[7]);
  Result := '';
  for i := 0 to 7 do
    Result := Result + IntToHex(cd[i], 2);
end;

function DecryptInt(ks: string): Integer;
var
  i: Integer;
  cd: array [0 .. 7] of byte;
  s: string;
begin
  for i := 0 to 7 do
  begin
    s := '$' + ks[i + i + 1] + ks[i + i + 2];
    cd[i] := StrToInt(s);
  end;

  if cd[0] <> byte(((cd[1] xor cd[2]) xor cd[3]) + (cd[4] or cd[5]) +
    (cd[6] and cd[7])) then
  begin
    Result := 0;
    Exit;
  end;
  cd[7] := cd[7] - cd[1] - cd[5];
  cd[5] := (cd[5] xor (cd[1] + cd[3])) + cd[6];
  cd[3] := (cd[3] xor (cd[1] - cd[4])) + cd[2];
  cd[2] := (cd[2] xor cd[4]) - cd[1];
  Result := cd[7] * $1000000 + cd[2] * $10000 + cd[3] * $100 + cd[5];

end;

end.
