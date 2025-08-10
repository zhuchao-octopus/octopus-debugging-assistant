unit uDownloadsManager;

interface

uses
  Windows,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.ImageList,
  System.Threading;

const
  DOWNLOAD_OBJECT_MSG_POST = 0;
  DOWNLOAD_OBJECT_MSG_GET = 1;
  DOWNLOAD_OBJECT_MSG_DOWNLOADING = 2;

  DOWNLOAD_OBJECT_MSG_DOWNLOADING_FINISHIED = 99;
  DOWNLOAD_OBJECT_MSG_ALLDOWNLOADING_FINISHIED = 100;
  DOWNLOAD_OBJECT_MSG_ERROR = 101;

  DOWNLOADING_FILENAME_SUFFIX = '.downloading';

type
  TDownloadThreadDataEvent = procedure(const Sender: TObject; MsgType: Integer; ThreadNo, ASpeed: Integer; AContentLength: Int64; AReadCount: Int64; var Abort: Boolean) of object;

  TDownloadObject = class
  private
    FTag: String;
    FClient: THTTPClient;
    FNetMethedType: Integer;

    FURL, FFileName: String;
    FResultContent: String;
    FStartPoint, FEndPoint: Int64;
    FThreadNo: Integer;
    FTimeStart: Cardinal;
    FMaxSize: Int64;
    FFinished: Boolean;
    FOnThreadData: TDownloadThreadDataEvent;
  protected

  public
    Constructor Create(const URL, FileName: string; ThreadNo: Integer; StartPoint, EndPoint: Int64); Overload;
    Constructor Create(const URL: String); Overload;
    Destructor Destroy;

    procedure Download();
    procedure StartDownload(const URL: String = ''; ToFile: String = '');
    procedure DownloadReceiveDataEvent(const Sender: TObject; AContentLength, AReadCount: Int64; var Abort: Boolean);

    procedure Post();
    procedure StartPost();

    property OnThreadData: TDownloadThreadDataEvent write FOnThreadData;
    property URL: String read FURL;
    property Finished: Boolean read FFinished;
    property ResultContent: String read FResultContent;
    property MaxSize: Int64 read FMaxSize;
    property FilePathName: String read FFileName;

    property Tag: String read FTag write FTag;
  end;

  TDownloadObjects = class
  private
  protected
  public
    FFromURL: string;
    FToPathFileName: string;
    FNumThreads: Integer;
    DownloadObjects: TStringList; // 需要处理的对象集合
    [volatile]
    FAllowFormClose: Boolean;
    [volatile]
    FClosingForm: Boolean;
    FGlobalSpeed: Single;
    FOnThreadData: TDownloadThreadDataEvent;

    Constructor Create();
    Destructor Destroy;
    procedure ObjectReceiveDataEvent(const Sender: TObject; MsgType: Integer; ThreadNo: Integer; ASpeed: Integer; AContentLength, AReadCount: Int64; var Abort: Boolean);
    procedure StartDownload(); overload;
    procedure StartDownload(FromURL: string; ToLFileName: string); overload;
    function GetLocalFilePathName(FromURL: string; ToLFileName: string): String;
    property OnThreadData: TDownloadThreadDataEvent write FOnThreadData;
  end;

  TDownloadObjectsManager = class
  private
  protected
  public
    function IsNetworkAvailable: Boolean;

  end;

var
  DownloadObjectsManager: TDownloadObjectsManager;

function GetFileNameFromURL(URL: string): string;

implementation

uses DataEngine;

function GetFileNameFromURL(URL: string): string;
var
  Strings: TStrings;
begin
  // 从url取得文件名
  Strings := TStringList.Create;
  try
    Strings.Delimiter := '/';
    Strings.DelimitedText := URL;
    if Strings.Count > 0 then
      Result := Trim(Strings[Strings.Count - 1]);
  finally
    Strings.Free;
  end;
end;

/// ///////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////////
Constructor TDownloadObject.Create(const URL: String);
begin
  FClient := THTTPClient.Create;
  FTag := '';
  FURL := URL;
  FFileName := '';
  FThreadNo := 0;
  FStartPoint := 0;
  FEndPoint := 0;
  FFinished := false;
  FClient.OnReceiveData := DownloadReceiveDataEvent;
end;

Constructor TDownloadObject.Create(const URL, FileName: string; ThreadNo: Integer; StartPoint, EndPoint: Int64);
begin
  FClient := THTTPClient.Create;
  FTag := '';
  FURL := URL;
  FFileName := FileName;
  FThreadNo := ThreadNo;
  FStartPoint := StartPoint;
  FEndPoint := EndPoint;
  FFinished := false;
  FClient.OnReceiveData := DownloadReceiveDataEvent;
end;

Destructor TDownloadObject.Destroy;
begin
  try
    FClient.OnReceiveData := nil;
    FClient.Free;
    OnThreadData := nil;

    if FTag <> '' then
      DataEngineManager.Remove2(FTag);
  finally
  end;
end;

procedure TDownloadObject.DownloadReceiveDataEvent(const Sender: TObject; AContentLength, AReadCount: Int64; var Abort: Boolean);
var
  LTime: Cardinal;
  LSpeed: Integer;
begin
  if Assigned(FOnThreadData) and (Self.FNetMethedType = DOWNLOAD_OBJECT_MSG_DOWNLOADING) then
  begin
    LTime := GetTickCount - FTimeStart;
    if AReadCount = 0 then
      LSpeed := 0
    else
      LSpeed := (AReadCount * 1000) div LTime;

    FOnThreadData(Self, FNetMethedType, FThreadNo, LSpeed, AContentLength, AReadCount, Abort);
  end;
end;

procedure TDownloadObject.Download();
var
  LResponse: IHTTPResponse;
  LStream: TFileStream;
  LCancel: Boolean;
  LCanDownload: Boolean;
  LDownloadTempFileName: String;
Label ENDENDEND;
begin
  LCanDownload := true;
  LDownloadTempFileName := Self.FFileName;
  if (FEndPoint <= 0) or (FMaxSize <= 0) then // 单个下载
  begin
    try
      LCanDownload := FClient.CheckDownloadResume(FURL);
      if LCanDownload then
      begin
        LResponse := FClient.Head(FURL); // Get space for the file that is going to be dowloaded
        FStartPoint := 0;
        FEndPoint := LResponse.ContentLength; // Get space for the file that is going to be dowloaded
        FMaxSize := FEndPoint;
      end;
    finally
    end;
    LDownloadTempFileName := Self.FFileName + DOWNLOADING_FILENAME_SUFFIX;
    if not FileExists(LDownloadTempFileName) then
    begin // 单个下载
      try
        LStream := TFileStream.Create(LDownloadTempFileName, fmCreate);
        LStream.Size := FMaxSize;
      finally
        LStream.Free;
      end;
    end;
  end;

  /// ///////////////////////////////////////////////////////////////////////////
  /// /////////////////////////////////////////////////////////////////////////
  try
    if LCanDownload then
    begin
      LStream := TFileStream.Create(LDownloadTempFileName, fmOpenWrite or fmShareDenyNone);
      FTimeStart := GetTickCount();
      LStream.Seek(FStartPoint, TSeekOrigin.soBeginning);
      LResponse := FClient.GetRange(FURL, FStartPoint, FEndPoint, LStream);

      if (FMaxSize = FEndPoint) and (FStartPoint = 0) then // 单个下载，完成后恢复文件名称
      /// 下载整个文件，最大尺寸就是文件的大小
      begin
        RenameFile(LDownloadTempFileName, FFileName);
        /// DeleteFile()
      end; // 否则属于分段下载
    end;
  finally
    LStream.Free;
    FFinished := true;
    if Assigned(FOnThreadData) then
    begin
      FOnThreadData(Self, DOWNLOAD_OBJECT_MSG_DOWNLOADING_FINISHIED, FThreadNo, 0, FMaxSize, FMaxSize, LCancel);
    end;

    Self.Destroy;
  end;

ENDENDEND:
end;

procedure TDownloadObject.StartDownload(const URL: String = ''; ToFile: String = '');
var
  tofn: String;
  dfn: String;
begin
  if URL <> '' then
  begin
    Self.FURL := URL;
  end;
  if ToFile <> '' then
  begin
    dfn := ExtractFileName(URL);
    dfn := StringReplace(dfn, '/', '', [rfReplaceAll, rfIgnoreCase]);
    if DirectoryExists(ToFile) then
      Self.FFileName := ToFile + '\' + dfn
    else
      Self.FFileName := ToFile;
  end;

  Self.FNetMethedType := DOWNLOAD_OBJECT_MSG_DOWNLOADING;
  if FTag <> '' then
  begin
    if not DataEngineManager.Exist2(FTag, nil) then
      DataEngineManager.DoAction(FTag, Download);
  end
  else
  begin
    DataEngineManager.DoAction(Download);
  end;
end;

procedure TDownloadObject.Post();
var
  cParam: TStringList;
  s: String;

  FName: String;
  FBrand: String;
  FCustomer: String;
  FMAC: String;
  /// FIP: String;
  /// FAppVersion: String;
  /// FFwVersion: String;
  /// FRegion: String;
  /// FComments: String;
  LCancel: Boolean;
begin
  { Place thread code here }
  try
    FClient.SecureProtocols := [THTTPSecureProtocol.TLS1, THTTPSecureProtocol.TLS11, THTTPSecureProtocol.TLS12];
    cParam := TStringList.Create;
    FName := '八爪鱼串口调试助手';
    FBrand := 'Octopus';
    FCustomer := 'Octopus';
    FMAC := 'Octopus';
    // FAppVersion := 'Octopus';
    // FFwVersion :='Octopus';

    cParam.Add('name=' + FName);
    cParam.Add('brand=' + FBrand);
    cParam.Add('customer=' + FCustomer);
    cParam.Add('mac=' + FMAC);
    /// cParam.Add('ip=' + FIP);

    /// cParam.Add('appVersion=' + FAppVersion);
    /// cParam.Add('fwVersion=' + FFwVersion);

    /// cParam.Add('region=' + FRegion);
    /// cParam.Add('comments=' + FComments);

    /// s := RSATestForm.PublicEncrypt(cParam.ToString);
    /// URL2 := 'http://47.106.172.94:8090/zhuchao/octopus/devices/testCheckRSA?str=' + s;
    /// LResponse := FClient.Get(URL);

    /// URL := 'http://47.106.172.94:8090/zhuchao/octopus/devices/getDeviceInfor';
    Self.FNetMethedType := DOWNLOAD_OBJECT_MSG_POST;
    Self.FResultContent := FClient.Post(FURL, cParam).ContentAsString;
    FFinished := true;
    if Assigned(FOnThreadData) then
    begin
      FOnThreadData(Self, FNetMethedType, 0, 0, 0, 0, LCancel);
    end;

  finally
    if cParam <> nil then
      cParam.Free;

    Self.Destroy;
  end;

end;

procedure TDownloadObject.StartPost();
begin
  if FTag <> '' then
  begin
    if not DataEngineManager.Exist2(FTag, nil) then
      DataEngineManager.DoAction(FTag, Post);
  end
  else
  begin
    DataEngineManager.DoAction(Post);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////
///
Constructor TDownloadObjects.Create();
begin
  DownloadObjects := TStringList.Create;
  FNumThreads := 5;
  FAllowFormClose := false;
  FClosingForm := false;
  FToPathFileName := '';
end;

Destructor TDownloadObjects.Destroy;
begin
  DownloadObjects.Clear;

  DownloadObjects.Free;
end;

procedure TDownloadObjects.ObjectReceiveDataEvent(const Sender: TObject; MsgType: Integer; ThreadNo: Integer; ASpeed: Integer; AContentLength, AReadCount: Int64; var Abort: Boolean);
var
  LCancel: Boolean;
begin
  LCancel := Abort or FClosingForm;
  if not LCancel then
  begin
    if Assigned(FOnThreadData) then
    /// 传递实践
    begin
      FOnThreadData(Sender, MsgType, ThreadNo, ASpeed, AContentLength, AReadCount, Abort);
    end;
  end;
  Abort := LCancel;
end;

function TDownloadObjects.GetLocalFilePathName(FromURL: string; ToLFileName: string): String;
var
  LDownLoadFileName: String;
begin
  LDownLoadFileName := GetFileNameFromURL(FromURL);
  if LDownLoadFileName = '' then
  LDownLoadFileName := ExtractFileName(FromURL);

  LDownLoadFileName := StringReplace(LDownLoadFileName, '/', '', [rfReplaceAll, rfIgnoreCase]);

  if DirectoryExists(ToLFileName) then
    ToLFileName := ToLFileName + '\' + LDownLoadFileName
  else
    ToLFileName := ToLFileName;

  Self.FFromURL := FromURL;
  Self.FToPathFileName := ToLFileName;
  Result := Self.FToPathFileName;
end;

procedure TDownloadObjects.StartDownload(FromURL: string; ToLFileName: string);
begin
  if Self.FToPathFileName = '' then
    GetLocalFilePathName(FromURL, ToLFileName);
  if not DataEngineManager.Exist2(Self.FFromURL, nil) then
    DataEngineManager.DoAction(Self.FFromURL, StartDownload);
end;

procedure TDownloadObjects.StartDownload();
var
  LClient: THTTPClient;
  LResponse: IHTTPResponse;
  StFile: TFileStream;
  LStart, LEnd, LSize, LFragSize: Int64;
  I: Integer;
  LFinished, LCancel: Boolean;
  LStartTime, LEndTime: Cardinal;
  DownloadObject: TDownloadObject;
  LTagPrefix: String;
  LDownloadTempFileName: String;
begin
  LClient := THTTPClient.Create;
  LDownloadTempFileName := Self.FToPathFileName + DOWNLOADING_FILENAME_SUFFIX;
  try
    if LClient.CheckDownloadResume(Self.FFromURL) then
    begin
      LResponse := LClient.Head(Self.FFromURL);
      // Get space for the file that is going to be dowloaded
      LSize := LResponse.ContentLength;

      DeleteFile(Self.FToPathFileName);

      StFile := TFileStream.Create(LDownloadTempFileName, fmCreate);
      try
        StFile.Size := LSize;
      finally
        StFile.Free;
      end;

      // Split the file in four blocks
      LFragSize := LSize div FNumThreads;
      LStart := 0;
      LEnd := LStart + LFragSize;
      DownloadObjects.Clear;
      LTagPrefix := ExtractFileName(Self.FToPathFileName);
      for I := 0 to FNumThreads - 1 do
      begin
        DownloadObject := TDownloadObject.Create(Self.FFromURL, LDownloadTempFileName, I, LStart, LEnd);
        DownloadObject.OnThreadData := ObjectReceiveDataEvent;
        DownloadObject.FTag := LTagPrefix + '_' + IntToStr(I);
        DownloadObject.FMaxSize := LSize;
        DownloadObjects.AddObject(DownloadObject.FTag, DownloadObject);
        // Adjust the ProgressBar Max Value
        if LEnd >= LSize then
        begin
          /// DownloadObject.FMaxSize := LFragSize - (LEnd - LSize);
          LEnd := LSize;
        end;
        /// else
        /// begin
        /// DownloadObject.FMaxSize := LFragSize;
        /// end;
        LStart := LStart + LFragSize;
        LEnd := LStart + LFragSize;
      end;

      // Start the download process
      LStartTime := TThread.GetTickCount;
      for I := 0 to FNumThreads - 1 do
      begin
        DownloadObject := TDownloadObject(DownloadObjects.Objects[I]);
        DownloadObject.StartDownload();
      end;

      // Wait until all threads finish
      LFinished := false;
      while not LFinished and not FClosingForm do
      begin
        LFinished := true;
        for I := 0 to FNumThreads - 1 do
        begin
          DownloadObject := TDownloadObject(DownloadObjects.Objects[I]);
          LFinished := LFinished and DownloadObject.Finished;
        end;
      end;

      LEndTime := TThread.GetTickCount - LStartTime + 1;
      FGlobalSpeed := ((LSize * 1000) div LEndTime) div 1024;
      /// Cleanup Threads
      /// for I := 0 to FNumThreads - 1 do
      /// begin
      /// DownloadObject := TDownloadObject(DownloadObjects.Objects[I]);
      /// DownloadObject.Destroy;
      /// DownloadObject.Free;
      /// end;
      DownloadObjects.Clear;

      RenameFile(LDownloadTempFileName, Self.FToPathFileName);

      if Assigned(FOnThreadData) and (not FClosingForm) then
      begin
        FOnThreadData(Self, DOWNLOAD_OBJECT_MSG_ALLDOWNLOADING_FINISHIED, 0, 0, 0, 0, LCancel);
      end;

    end
    else
    begin
      if Assigned(FOnThreadData) then
      begin
        FOnThreadData(Self, DOWNLOAD_OBJECT_MSG_ERROR, 0, 0, 0, 0, LCancel);
      end;

    end;
  finally
    LClient.Free;
    FAllowFormClose := true;
    DataEngineManager.Remove2(Self.FFromURL);
  end;

end;

/// /////////////////////////////////////////////////////////////////////////////
///
function TDownloadObjectsManager.IsNetworkAvailable: Boolean;
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
begin
  HttpClient := THTTPClient.Create;
  Result := false;
  try
    try
      Response := HttpClient.Get('http://www.baidu.com');
      // Handle the response here, e.g., check the StatusCode and Content of the response
      if Response.StatusCode = 200 then
      begin
        // Successful response
        // Do something with Response.ContentAsString
        Result := true;
      end
      else if (Response.StatusCode >= 500) and (Response.StatusCode < 600) then
      begin
        // Handle server errors (status codes in the 500 range)
        /// Result:=False;
      end
      else
      begin
        // Handle other status codes
      end;
    except
      on E: Exception do
      begin
        // Handle exceptions, e.g., network disconnection, unexpected errors, etc.
      end;
    end;
  finally
    HttpClient.Free;
  end;
end;

initialization

DownloadObjectsManager := TDownloadObjectsManager.Create;

finalization

DownloadObjectsManager.Free;

end.
