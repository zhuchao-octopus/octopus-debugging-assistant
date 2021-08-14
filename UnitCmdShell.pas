unit UnitCmdShell;

interface

uses
  Windows, SysUtils, Classes, Vcl.StdCtrls;

const
  BufferSize = 1024 * 2;

type
  TMyParam = record // 线程的时候传递
    CommadLineStr: String;
    LogMemo: TMemo;
  end;

  PMyParam = ^TMyParam; // Record类型指针

type
  TCallBackFun = Procedure(Msg: String) of object;

  TCommandhread = class(TThread)
  private
  FCallBackFun: TCallBackFun;
  protected
    procedure Execute; override;
  public
   constructor Create(CommadLine: String);
   procedure RunDosCommand(CommadLine: String);
  property CallBackFun: TCallBackFun read FCallBackFun write FCallBackFun;
  end;

  procedure SearchFile(path:String);//细致,path背面要有'\';

var
  DirList:TStringList;
  LastCMDLineStr: String;
  CmdShellCommadLineStr: String;
  CmdShellLogMemo:TMemo;
  CommadLineDestBuffer: array [0 .. BufferSize] of Byte;

implementation

function ByteToWideString(buff: PByte; len: integer): String;
var
  str: AnsiString;
  buffer: array of Byte;

begin
  SetLength(buffer, len);
  SetLength(str, len);
  // Move(buff, buffer, len);
  CopyMemory(buffer, buff, len);
  // Move(buffer, str[1], len);
  CopyMemory(@str[1], buffer, len);
  result := str;
end;

constructor TCommandhread.Create(CommadLine: String); // 数据特殊处理线程后台进行
begin
  inherited Create(true); // 先挂起
  CmdShellCommadLineStr:= CommadLine;
end;

procedure TCommandhread.Execute;
begin
  RunDosCommand(CmdShellCommadLineStr);
end;
// ================================================================
// K8执行DOS并返回结果
procedure TCommandhread.RunDosCommand(CommadLine: String);
var
  hReadPipe: THandle;
  hWritePipe: THandle;
  SI: TStartUpInfo;
  PI: TProcessInformation;
  SA: TSecurityAttributes;
  // SD   :   TSecurityDescriptor;
  BytesRead: DWORD;

  CmdLine: array [0 .. 512] of char;
  AvailBytes, ExitCode, wrResult: DWORD;
  osVer: TOSVERSIONINFO;
  tmpstr: AnsiString;
  ResultCode: integer;
  result: String;
  s: String;
  Count, l: integer;
begin
  osVer.dwOSVersionInfoSize := Sizeof(TOSVERSIONINFO);
  GetVersionEX(osVer);
  //CmdShellLogMemo.Lines.Add(result);
  if (Trim(CommadLine) = '') then
    s := CmdShellCommadLineStr
  else
    s := CommadLine;
  // if trim(s) = '' then ExitThread(4);
  Count := 0;
  l := -1;
  if osVer.dwPlatformId = VER_PLATFORM_WIN32_NT then
  begin
    // InitializeSecurityDescriptor(@SD,   SECURITY_DESCRIPTOR_REVISION);
    // SetSecurityDescriptorDacl(@SD,   True,   nil,   False);
    SA.nLength := Sizeof(SA);
    SA.lpSecurityDescriptor := nil; // @SD;
    SA.bInheritHandle := True;
    CreatePipe(hReadPipe, hWritePipe, @SA, 0);
  end
  else
    CreatePipe(hReadPipe, hWritePipe, nil, BufferSize);
  try
    FillChar(SI, Sizeof(SI), 0);
    SI.cb := Sizeof(TStartUpInfo);
    SI.wShowWindow := SW_HIDE;
    SI.dwFlags := STARTF_USESHOWWINDOW;
    SI.dwFlags := SI.dwFlags or STARTF_USESTDHANDLES;
    SI.hStdOutput := hWritePipe;
    SI.hStdError := hWritePipe;
    StrPCopy(CmdLine, s);
    if CreateProcess(nil, CmdLine, nil, nil, True, REALTIME_PRIORITY_CLASS, nil, nil, SI, PI) then
    begin
      ExitCode := 0;
      while (ExitCode = 0) and (Count < 100) and (not Self.Terminated) do
      begin
        wrResult := WaitForSingleObject(PI.hProcess, 500);
        if PeekNamedPipe(hReadPipe, @CommadLineDestBuffer[0], BufferSize, @AvailBytes, nil, nil) then
        begin
          if AvailBytes > 0 then
          begin
            try
              FillChar(CommadLineDestBuffer, Sizeof(CommadLineDestBuffer), #0);
              ReadFile(hReadPipe, CommadLineDestBuffer[0], AvailBytes, BytesRead, nil);
              tmpstr := ByteToWideString(@CommadLineDestBuffer, BytesRead);
              // tmpstr := Copy(Dest, 0, BytesRead - 1);
              result := tmpstr;
              if Assigned(FCallBackFun) then
                  FCallBackFun(result);
              CmdShellLogMemo.Lines.Add(result);
            Except
            end;
            Count:=0;
          end
          else
          begin
            Count:=Count + 4;
            if Assigned(FCallBackFun) then
                  FCallBackFun(IntToStr(Count) + ' %%% ');
            if (l = -1) then
            begin
              CmdShellLogMemo.Lines.Add(' ');
              l := CmdShellLogMemo.Lines.Count - 1;
            end;
            CmdShellLogMemo.Lines.Strings[l] := ' ' + IntToStr(Count) + ' % ';
          end;
        end;
        if wrResult <> WAIT_TIMEOUT then
          ExitCode := 1;
      end;
      //if Count >=100 then
      //   CmdShellLogMemo.Lines.Add('系统没有响应。');
      GetExitCodeProcess(PI.hProcess, ExitCode);
      CloseHandle(PI.hProcess);
      CloseHandle(PI.hThread);
    end;
  finally
    // ResultCode := GetLastError();
    TerminateProcess(PI.hProcess, 1);
    CloseHandle(hReadPipe);
    CloseHandle(hWritePipe);
    result := Trim(result);
    if (CmdShellLogMemo <> nil) then
    begin
      // CmdShellLogMemo.Lines.Add(result);
      CmdShellLogMemo.Text := Trim(CmdShellLogMemo.Text);
      CmdShellLogMemo.Lines.Add(' ');
      LastCMDLineStr := GetCurrentDir() + '>';
      CmdShellLogMemo.Lines.Add(LastCMDLineStr);
      CmdShellLogMemo.SelStart := Length(CmdShellLogMemo.Text);
      CmdShellLogMemo.Text := Trim(CmdShellLogMemo.Text);
    end;
    // CmdShellLogMemo.Lines.Add(Result);
    SearchFile('./');
    CmdShellCommadLineStr := '';
    CmdShellLogMemo := nil;
    self.Free;
    //ExitThread(4);
  end;
end;

// =================================================================
procedure SearchFile(path:String);//细致,path背面要有'\';
var
    SearchRec:TSearchRec;
    found:integer;
begin
    if DirList=nil then
       DirList:=TStringList.Create;

    found:=FindFirst(path+'*.*',faAnyFile,SearchRec);
    while found=0 do
    begin
      if (SearchRec.Name<>'.')  and (SearchRec.Name<>'..') then
           DirList.Add(SearchRec.Name);
      found:=FindNext(SearchRec);
    end;
    FindClose(SearchRec);
end;


end.
