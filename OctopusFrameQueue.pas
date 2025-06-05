unit OctopusFrameQueue;


interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.SyncObjs;

type
  TOctopusFrameQueue = class
  private
    FList: TList<TArray<Byte>>;
    FLock: TCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Enqueue(const Data: TArray<Byte>);
    function Dequeue(out Data: TArray<Byte>): Boolean;
    function Peek(out Data: TArray<Byte>): Boolean;
    function PeekLast(out Data: TArray<Byte>): Boolean;

    procedure Clear;
    function Count: Integer;
  end;

implementation

{ TOctopusFrameQueue }

constructor TOctopusFrameQueue.Create;
begin
  inherited Create;
  FList := TList<TArray<Byte>>.Create;
  FLock := TCriticalSection.Create;
end;

destructor TOctopusFrameQueue.Destroy;
begin
  FLock.Enter;
  try
    FList.Free;
  finally
    FLock.Leave;
    FLock.Free;
  end;
  inherited;
end;

procedure TOctopusFrameQueue.Enqueue(const Data: TArray<Byte>);
var
  CopyData: TArray<Byte>;
begin
  FLock.Enter;
  try
    SetLength(CopyData, Length(Data));
    Move(Data[0], CopyData[0], Length(Data));
    FList.Add(CopyData);
  finally
    FLock.Leave;
  end;
end;

function TOctopusFrameQueue.Dequeue(out Data: TArray<Byte>): Boolean;
begin
  Result := False;
  FLock.Enter;
  try
    if FList.Count > 0 then
    begin
      Data := FList.First;
      FList.Delete(0);
      Result := True;
    end;
  finally
    FLock.Leave;
  end;
end;

function TOctopusFrameQueue.Peek(out Data: TArray<Byte>): Boolean;
begin
  Result := False;
  FLock.Enter;
  try
    if FList.Count > 0 then
    begin
      Data := FList.First;
      Result := True;
    end;
  finally
    FLock.Leave;
  end;
end;

function TOctopusFrameQueue.PeekLast(out Data: TArray<Byte>): Boolean;
begin
  Result := False;
  FLock.Enter;
  try
    if FList.Count > 0 then
    begin
      Data := FList.Last;
      Result := True;
    end;
  finally
    FLock.Leave;
  end;
end;

procedure TOctopusFrameQueue.Clear;
begin
  FLock.Enter;
  try
    FList.Clear;
  finally
    FLock.Leave;
  end;
end;

function TOctopusFrameQueue.Count: Integer;
begin
  FLock.Enter;
  try
    Result := FList.Count;
  finally
    FLock.Leave;
  end;
end;

end.

