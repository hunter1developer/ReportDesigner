unit uZasioVClient;

interface

uses
  System.SysUtils, System.Classes, Vcl.AppEvnts, uROClient, uROBaseHTTPClient,
  uROIndyHTTPChannel, uDADataStreamer, uDABinAdapter, uROBinMessage,
  uRORemoteService, uClientSettings, (*CoreVLibrary_Intf,*)VReportServiceLibrary_Intf,
  uROTypes,
  uROEventRepository, uDAMemDataTable, uDAInterfaces, uDADataTable, uROBaseConnection,
  uROTransportChannel, uROMessage, uROComponent, uROChannelAwareComponent,
  uROAESEncryptionEnvelope, uROClasses, IdStack, Dialogs, Vcl.ExtCtrls,
  TlHelp32, Winapi.Windows, Vcl.Forms, Vcl.Controls, System.TypInfo,
  uROClientIntf, uROAsync, uROServerLocator, Variants, Registry;

type
  TTypeConnect = (tcTest, tcWork);
  TLabelReportSettings = record
    LabelStock: String;
    PageHeight: Integer;
    PageHorGap: Integer;
    PageLabelHeight: Integer;
    PageLabelWidth: Integer;
    PageLabelsHigh: Integer;
    PageLabelsWide: Integer;
    PageLeftMargin: Integer;
    PageTopMargin: Integer;
    PageVerGap: Integer;
    PageWidth: Integer;
  public
  end;

  TZasioVClient = class(TDataModule)
    RemoteService: TRORemoteService;
    BinMessage: TROBinMessage;
    HTTPChannel: TROIndyHTTPChannel;
    EncryptionEnvelope: TROAESEncryptionEnvelope;
  private
    FSettings: TClientSettings;
    FSessionFunctionality: roReportSessionFunctionalityRecord;
    FTypeConnect: TTypeConnect;
    FTestServerAddress: string;
    FTestServerPort: integer;
    function Get_IReportService: IReportService;
    procedure CheckAuthError(AErrorCode: Integer);
    function IsAllowedSecFunction(AFunctionCode: Integer): Boolean;
    function IsCompanySigningCertificate(const AFileName: string): boolean;
    function GetUserCloudId: string;
    procedure SetUserCloudId(const Value: string);
  public
    var SessionID: string;
    var RfId: string;
    var RepName: string;
    var RepDesc: string;
    var RepAutoIndex: integer;
    var RepUserIndex: integer;
    var bSamlAuthentication: boolean;

    var TopCount: integer;
    var IndexList: string;
    var SortOrder: string;

    function GetVersion: string;
    function LogIn(const UserID: string; const UserPsw: string): Boolean;
    function LoginSSO(const UserID: string): boolean;
    function CheckSamlAuthentication(const UserCloudId: string): boolean;
    function GetSamlIdpName(const UserCloudId: string): string;
    function CheckCloudUserId(const CloudUserId: string): boolean;
    function GetSAMLUserID: Variant; overload;
    function GetSAMLUserID(const IdpName: string): Variant; overload;
    procedure LogOut;
    function RefreshSession: boolean;
    function CheckSessionID(): boolean;
    function GetReportFromListData(out ABinaryDataSet: Binary): boolean;
    function GetReport(const aRfId: string; out ABinaryDataSet: Binary): boolean;
    function GetNewInstallationSelf(out AAppBinary: Binary): boolean;
    function GetNewInstallationSelfVersion(out AVersion: string): boolean;
    function InsertReport(const aRfId, aName, aDesc: string; const aRtmFile: Binary; const aRptFile: Binary): boolean;
    function RemoveReport(const aAutoIndex: integer): boolean;
    function UpdateReportTemplateData(const aRfId, aName, aDesc: string;
                                      const aAutoIndex, aUserIndex: integer;
                                      const aTemplate, aOptions: Binary): boolean;

    function TestConnection: Boolean;overload;
    function TestConnection(AServerAddress: String; AServerPort: Integer): Boolean;overload;
    procedure PrepareServerAddress; overload;
    procedure PrepareServerAddress(AServerAddress: String; AServerPort: Integer); overload;

    procedure CheckDownloadInstallVersion(const AAppSelfVersion: string);
    function GetWinTempFolder: string;
    function GetTempFile: string;
    function GetCustomVersionArray(const AVersion: string; const ALength: array of integer; const ASeparator: string = ''): string;
    function GetItemVersion(const AVersion: string; const AIndex: integer): string;
    procedure DownloadInstaller(const ATempFolder: string; const AFileNameInstaller: string);
    procedure RunInstaller(const ATempFolder: string; const AFileNameInstaller: string);
    procedure SetTestServerAddress(AServerAddress: String; AServerPort: Integer);

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Settings: TClientSettings read FSettings;
    property SessionFunctionality: roReportSessionFunctionalityRecord read FSessionFunctionality;
    property AllowedSecFunction[AFunctionCode: Integer]: Boolean read IsAllowedSecFunction;
    property TypeConnect: TTypeConnect read FTypeConnect write FTypeConnect;
    property TestServerAddress: string read FTestServerAddress;
    property TestServerPort: integer read FTestServerPort;
    property UserCloudIdRegistry: string read GetUserCloudId write SetUserCloudId;
  end;

function ZasioVClient: TZasioVClient;

{$WRITEABLECONST ON}
const
  __ZasioVClient: TZasioVClient = nil;
{$WRITEABLECONST OFF}
  cRegistryPath = '\SOFTWARE\ZasioVCloudReportManager\SamlData';


implementation

uses
  uLoginForm,
  uCommonUtils,
  uExeUpdater,
  uCodeSigned;

function ZasioVClient: TZasioVClient;
begin
  if __ZasioVClient = nil then
     __ZasioVClient := TZasioVClient.Create(nil);
  Result := __ZasioVClient;
end;

{$R *.dfm}

{ TZasioVClient }

procedure TZasioVClient.CheckAuthError(AErrorCode: Integer);
begin
  if (AErrorCode >= 10021) and (AErrorCode <= 10024) then
    ShowLoginDialog;
end;

function TZasioVClient.CheckSamlAuthentication(
  const UserCloudId: string): boolean;
begin
  Result := Get_IReportService.CheckSamlAuthentication(UserCloudId);
end;

function TZasioVClient.GetSamlIdpName(const UserCloudId: string): string;
begin
  Result := Get_IReportService.GetSamlIdpName(UserCloudId);
end;

function TZasioVClient.CheckSessionID(): boolean;
begin
  Result := Get_IReportService.CheckSessionID(SessionID);
end;

function TZasioVClient.CheckCloudUserId(const CloudUserId: string): boolean;
begin
  Result := Get_IReportService.CheckCloudUserId(CloudUserId);
end;

procedure TZasioVClient.CheckDownloadInstallVersion(const AAppSelfVersion: string);
const
  VerArr: array[0..1] of integer = (0, 1);
  errConvert = 'Error convert string(%s) into integer(%s).';
var
  res: Boolean;
  SelfAppVersionCustom: string;
  ServiceReportVersionCustom: string;
  InstallationVersionCustom: string;
  InstallationVersionFull: string;
  errCode: integer;
  ServiceReportVersionCustomInt: Integer;
  InstallationVersionCustomInt: integer;
  SelfAppVersionCustomInt: integer;
  WinTempFolder: string;
  TempInstallerFileName: string;
begin
  errCode := 0;
  SelfAppVersionCustom := EmptyStr;
  ServiceReportVersionCustom := EmptyStr;
  InstallationVersionCustom := EmptyStr;
  InstallationVersionFull := EmptyStr;
  ServiceReportVersionCustomInt := 0;
  InstallationVersionCustomInt := 0;
  SelfAppVersionCustomInt := 0;
  WinTempFolder := GetWinTempFolder;
  TempInstallerFileName := StringReplace(ExtractFileName(GetTempFile), '.tmp', '.exe', [rfReplaceAll]);

  SelfAppVersionCustom := GetCustomVersionArray(AAppSelfVersion, VerArr);
  ServiceReportVersionCustom := GetCustomVersionArray(ZasioVClient.GetVersion, VerArr);

  Val(ServiceReportVersionCustom, ServiceReportVersionCustomInt, errCode);
  if errCode <> 0 then
    raise Exception.Create(Format(errConvert, ['ServiceReportVersionCustom', 'ServiceReportVersionCustomInt']));

  if (SelfAppVersionCustom <> ServiceReportVersionCustom) then begin
    if (not ZasioVClient.GetNewInstallationSelfVersion(InstallationVersionFull)) then begin
      TCommonUtils.ShowWarningMessage('Report Manager version is not compatible.  Unable to check the version of the report service due to incorrect name or missing file.  Please contact Zasio Support for assistance.');
      Application.Terminate;
      Exit;
    end;

    InstallationVersionCustom := GetCustomVersionArray(InstallationVersionFull, VerArr);
    Val(InstallationVersionCustom, InstallationVersionCustomInt, errCode);
    if errCode <> 0 then
      raise Exception.Create(Format(errConvert, ['InstallationVersionCustom', 'InstallationVersionCustomInt']));


    Val(SelfAppVersionCustom, SelfAppVersionCustomInt, errCode);
    if errCode <> 0 then
      raise Exception.Create(Format(errConvert, ['ServiceReportVersionCustom', 'ServiceReportVersionCustomInt']));

    if (InstallationVersionCustomInt > SelfAppVersionCustomInt) and
       (InstallationVersionCustomInt = ServiceReportVersionCustomInt) then
    begin
      if (TCommonUtils.ShowConfirmMessage('This version of Report Manager is not compatible with the Versatile Retention version currently in use. There is a compatible version on the server. Do you want to download a compatible version of Report Manager?',[mbYes, mbNo], mbYes) = mrYes) then
      begin
        DownloadInstaller(WinTempFolder, TempInstallerFileName);
        if not IsCompanySigningCertificate(WinTempFolder + TempInstallerFileName) then
        begin
          DeleteFile(PWideChar(WinTempFolder + TempInstallerFileName));
          TCommonUtils.ShowWarningMessage('Report Manager could not verify the source of the download. Please contact Zasio Support for assistance.');
          Application.Terminate;
          Exit;
        end;
        RunInstaller(WinTempFolder, TempInstallerFileName);
      end
      else
      begin
        Application.Terminate;
        Exit;
      end;
    end
    else
    if (InstallationVersionCustomInt > SelfAppVersionCustomInt) then
    begin
      TCommonUtils.ShowWarningMessage('Report Manager version is not compatible and the new version cannot be downloaded.  Report Manager version is higher than the installation file.');
      Application.Terminate();
      Exit;
    end
    else
    begin
      TCommonUtils.ShowWarningMessage('Report Manager version is not compatible and the new version is not appropriate for download.  Please contact Zasio Support for assistance.');
      Application.Terminate();
      Exit;
    end;
  end;
end;

constructor TZasioVClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSettings := TClientSettings.Create;
  FSessionFunctionality := roReportSessionFunctionalityRecord.Create;
  FTypeConnect := tcWork;
end;

destructor TZasioVClient.Destroy;
begin
  FreeAndNil(FSessionFunctionality);
  FreeAndNil(FSettings);
  inherited;
end;

procedure TZasioVClient.DownloadInstaller(const ATempFolder,
  AFileNameInstaller: string);
var
  appBinary: Binary;
  Stream: TFileStream;
  downloadedFile: string;
begin
  try
    if ZasioVClient.GetNewInstallationSelf(appBinary) then
    begin
      try
        downloadedFile := ATempFolder + AFileNameInstaller;
        Stream := TFileStream.Create(downloadedFile, fmCreate);
        Stream.Position := 0;
        Stream.CopyFrom(appBinary, appBinary.Size);
      finally
        Stream.Free;
      end;
    end;
  except

  end;
end;

procedure TZasioVClient.RunInstaller(const ATempFolder,
  AFileNameInstaller: string);
var
  SelfUpdater: TExeUpdate;
  downloadedFile: string;
begin
  try
    downloadedFile := ATempFolder + AFileNameInstaller;
    if FileExists(downloadedFile) then
    begin
      try
        SelfUpdater := TExeUpdate.Create(downloadedFile, GetCurrentProcessId);
      finally
        SelfUpdater.Free;
      end;
    end;
  except

  end;
end;

function TZasioVClient.GetReportFromListData(out ABinaryDataSet: Binary): boolean;
var
  fBinaryDataSet: Binary;
  repResult: roReportResult;
begin
  repResult := Get_IReportService.GetReportFromListData(SessionID, fBinaryDataSet);
  try
    if repResult.ResultCode = 0 then
      ABinaryDataSet := fBinaryDataSet;

    Result := repResult.ResultCode = 0;
  finally
    FreeAndNil(repResult);
  end;
end;

function TZasioVClient.GetTempFile: string;
var
  pPath, pFile: PChar;
begin
  pPath := AllocMem(256);
  GetTempPath(255, pPath);
  pFile := AllocMem(MAX_PATH);
  GetTempFileName(pPath, 'Z', 0, pFile);
  Result := string(pFile);
  FreeMem(pPath);
  FreeMem(pFile);
end;

function TZasioVClient.GetUserCloudId: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
  try
    Reg.RootKey := HKEY_CURRENT_USER;//HKEY_LOCAL_MACHINE;
    Reg.OpenKey(cRegistryPath, true);
    Result := Reg.ReadString('UserId');
  finally
    Reg.Free;
  end;
end;

procedure TZasioVClient.SetUserCloudId(const Value: string);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
  try
    Reg.RootKey := HKEY_CURRENT_USER;//HKEY_LOCAL_MACHINE;
    Reg.OpenKey(cRegistryPath, true);
    Reg.WriteString('UserId', Value);
  finally
    Reg.Free;
  end;
end;

function TZasioVClient.GetCustomVersionArray(const AVersion: string;
  const ALength: array of integer; const ASeparator: string): string;
var
  i: integer;
begin
  try
    Result := EmptyStr;
    for i := Low(Alength) to High(ALength) do
    begin
      Result := Result + GetItemVersion(AVersion, ALength[i]);
      if  (i <> Length(ALength)-1) then
        Result := Result + ASeparator;
    end;
  finally

  end;
end;

function TZasioVClient.GetItemVersion(const AVersion: string;
  const AIndex: integer): string;
var
  VerList: TStringList;
  i: integer;
  VersionOut: string;
begin
  try
    VersionOut := EmptyStr;
    VerList := TstringList.Create;
    VerList.StrictDelimiter := true;
    VerList.Delimiter := '.';
    VerList.DelimitedText := AVersion;
    if (AIndex  > (VerList.Count-1)) then
      raise Exception.Create('Index in the version out of the array');

    Result := VerList[AIndex];
  finally
    VerList.Free;
  end;
end;

function TZasioVClient.GetNewInstallationSelf(out AAppBinary: Binary): boolean;
var
  fBinary: Binary;
  repResult: roReportResult;
begin
  Result := False;
  repResult := Get_IReportService.GetNewInstallationVCloudReportManager(fBinary);
  if Assigned(repResult) then
  try
    if repResult.ResultCode = 0 then
      AAppBinary := fBinary;

    Result := repResult.ResultCode = 0;
  finally
    FreeAndNil(repResult);
  end;
end;

function TZasioVClient.GetNewInstallationSelfVersion(
  out AVersion: string): boolean;
var
  repResult: roReportResult;
  Version: string;
begin
  Result := False;
  repResult := Get_IReportService.GetNewInstallationVCloudReportManagerVersion(Version);
  if Assigned(repResult) then
  try
    if repResult.ResultCode = 0 then
      AVersion := Version;

    Result := repResult.ResultCode = 0;
  finally
    FreeAndNil(repResult);
  end;
end;

function TZasioVClient.GetReport(const aRfId: string; out ABinaryDataSet: Binary): boolean;
var
  fBinaryDataSet: Binary;
  repResult: roReportResult;
begin
  Result := False;
  repResult := Get_IReportService.GetReport(SessionID, aRfId, fBinaryDataSet);
  if Assigned(repResult) then
  try
    if repResult.ResultCode = 0 then
      ABinaryDataSet := fBinaryDataSet;

    Result := repResult.ResultCode = 0;
  finally
    FreeAndNil(repResult);
  end;
end;

function TZasioVClient.Get_IReportService: IReportService;
begin
  PrepareServerAddress;
  Result := (RemoteService as IReportService);
end;

function TZasioVClient.InsertReport(const aRfId, aName,
  aDesc: string; const aRtmFile, aRptFile: Binary): boolean;
var
  repResult: roReportResult;
  repRec: roReportRec;
begin
  try
    repRec := roReportRec.Create;
    repRec.RepRfId := aRfId;
    repRec.RepName := aName;
    repRec.RepDesc := aDesc;
    if (aRtmFile <> nil) then
      repRec.RepTemplateData.Assign(aRtmFile);
    if (aRptFile <> nil) then
      repRec.RepOptionsData.Assign(aRptFile);

    repResult := Get_IReportService.SaveReport(SessionID, repRec);

    Result := repResult.ResultCode = 0;
  finally
    FreeAndNil(repResult);
    FreeAndNil(repRec);
  end;
end;

function TZasioVClient.IsAllowedSecFunction(AFunctionCode: Integer): Boolean;
var
  i: Integer;
begin
  Result := SessionFunctionality.IsAdmin;
  if not Result then
    for i := 0 to SessionFunctionality.FunctionList.Count - 1 do
      if AFunctionCode = SessionFunctionality.FunctionList[i] then begin
        Result := True;
        Break;
      end;
end;

function TZasioVClient.IsCompanySigningCertificate(
  const AFileName: string): boolean;
const
  constComanyName = 'Zasio Enterprises, Inc.';
var
  codeSigned: TCodeSigned;
  codeCompanySignedCert: TCompanySignedCertificate;
begin
  Result := false;
  try
    codeSigned := TCodeSigned.Create(AFileName);
    if codeSigned.CodeSigned then
    begin
      codeCompanySignedCert := TCompanySignedCertificate.Create(AFileName, constComanyName);
      Result := codeCompanySignedCert.CompanySigningCertificate;
    end;
  finally
   if codeSigned.CodeSigned then
      codeCompanySignedCert.Free;
    codeSigned.Free;
  end;
end;

function TZasioVClient.UpdateReportTemplateData(const aRfId, aName, aDesc: string;
                                      const aAutoIndex, aUserIndex: integer;
                                      const aTemplate, aOptions: Binary): boolean;
var
  repResult: roReportResult;
  repRec: roReportRec;
begin
  try
    repRec := roReportRec.Create;

    repRec.RepAutoIndex := aAutoIndex;
    repRec.RepUserIndex := aUserIndex;
    repRec.RepRfId := aRfId;
    repRec.RepName := aName;
    repRec.RepDesc := aDesc;
    repRec.RepTemplateData.Assign(aTemplate);
    repRec.RepOptionsData.Assign(aOptions);

    repResult := Get_IReportService.SaveReport(SessionID, repRec);

    Result := repResult.ResultCode = 0;
  finally
    FreeAndNil(repResult);
    FreeAndNil(repRec);
  end;
end;

function TZasioVClient.GetVersion: string;
begin
  try
    Result := Get_IReportService.GetVersion;
  except
    on E: Exception do begin
      TCommonUtils.ShowWarningMessage('Server is unavailable.'#13#10'Application raised error: '+E.Message);
      raise;
    end;
  end;
end;

function TZasioVClient.GetWinTempFolder: string;
var
  TempPathBuffer: PChar;
begin
  GetMem(tempPathBuffer, MAX_PATH);
  try
    GetTempPath(MAX_PATH, tempPathBuffer);
    Result := IncludeTrailingPathDelimiter(StrPas(tempPathBuffer));
    ForceDirectories(Result);
  finally
    FreeMem(tempPathBuffer);
  end;
end;

function TZasioVClient.LogIn(const UserID, UserPsw: string): Boolean;
var
  fLogin: roReportLoginResult;
begin
  Result := False;
  fLogin := Get_IReportService.Login(UserID, UserPsw);
  try
    if fLogin.ResultCode = 0 then
    begin
      SessionID := fLogin.SessionID;
      SessionFunctionality.Assign(fLogin.ReportSessionFunctionality);
      Result := True;
    end
    else
      TCommonUtils.ShowErrorMessage(fLogin.ResultMsg);
  finally
    FreeAndNil(fLogin);
  end;
end;



function TZasioVClient.LoginSSO(const UserID: string): boolean;
var
  fLogin: roReportLoginResult;
begin
  Result := False;
  fLogin := Get_IReportService.LoginSSO(UserID);
  try
    if fLogin.ResultCode = 0 then
    begin
      SessionID := fLogin.SessionID;
      SessionFunctionality.Assign(fLogin.ReportSessionFunctionality);
      Result := True;
    end
    else
      TCommonUtils.ShowErrorMessage(fLogin.ResultMsg);
  finally
    FreeAndNil(fLogin);
  end;
end;


function TZasioVClient.GetSAMLUserID: Variant;
  type
    TSamlLoginResult = (samlLoginOk, samlLoginDenied, samlLoginClosedWindow);
    TzSamlLogin = function (const OwnerWnd: HWND; const UserName: PChar): TSamlLoginResult; stdcall;
  const
    BufferSize = 255;
  var
    FileName:string;
    hDll: THandle;
    zSamlLogin: TzSamlLogin;
    lpUserName: PChar;
    Res: TsamlLoginResult;
  begin
    Result   := Null;
    FileName := ExtractFilePath(Application.ExeName) + 'zSaml.dll';
    if FileExists(FileName) then
    begin
      Result := '';
      hDll   := LoadLibrary(PChar(FileName));
      if hDll <> 0 then
      try
        @zSamlLogin := GetProcAddress(hDll, 'Login');
        if @zSamlLogin <> nil then
        begin
          GetMem(lpUserName,  BufferSize);
          try
            Res := zSamlLogin(Application.Handle, lpUserName);
            if (Res = samlLoginOk) then
              begin
                Result := StrPas (lpUserName);
              end;
          finally
            FreeMem(lpUserName);
          end;
        end;
      finally
        FreeLibrary(hDll);
      end;
    end;
end;

function TZasioVClient.GetSAMLUserID(const IdpName: string): Variant;
  const
    BufferSize = 255;
  type
    TSamlLoginResult = (samlLoginOk, samlLoginDenied, samlLoginClosedWindow);
    TzSamlLoginIdp = function (const OwnerWnd: HWND; const IdpName: PChar; UserId: PChar): TSamlLoginResult; stdcall;
  var
    FileName:string;
    hDll: THandle;
    zSamlLogin: TzSamlLoginIdp;
    lpIdpName: PChar;
    lpUserId: PChar;
    Res: TsamlLoginResult;
  begin
    Result   := Null;
    FileName := ExtractFilePath(Application.ExeName) + 'zSaml.dll';
    if FileExists(FileName) then
    begin
      Result := '';
      hDll   := LoadLibrary(PChar(FileName));
      if hDll <> 0 then
      try
        @zSamlLogin := GetProcAddress(hDll, 'LoginIdp');
        if @zSamlLogin <> nil then
        begin
         GetMem(lpUserId,  BufferSize);
         ZeroMemory(lpUserId, BufferSize);
          try
            lpIdpName := PChar(IdpName);
            Res := zSamlLogin(Application.Handle, lpIdpName, lpUserId);
            if (Res = samlLoginOk) then
              begin
                Result := StrPas(lpUserId);
              end;
          finally
            FreeMem(lpUserId);
          end;
        end;
      finally
        FreeLibrary(hDll);
      end;
    end;
end;

procedure TZasioVClient.LogOut;
var
  fLogout: roReportResult;
begin
  try
    try
      fLogout := Get_IReportService.LogOut(SessionID);
    finally
      FreeAndNil(fLogout);
    end;
  except
    //silent
  end;
end;

procedure TZasioVClient.PrepareServerAddress(AServerAddress: String;
  AServerPort: Integer);
var
  tempAddress: String;
begin
  if Copy(AServerAddress, 1, 4) = 'http' then
    tempAddress := AServerAddress
  else
    tempAddress := 'http://' + AServerAddress;

  if AServerPort > 0 then
    HTTPChannel.TargetURL := Format('%s:%d/bin',[tempAddress, AServerPort])
  else
    HTTPChannel.TargetURL := tempAddress;
end;

function TZasioVClient.RefreshSession: boolean;
var
  repResult: roReportResult;
begin
  try
    repResult := Get_IReportService.RefreshSession(SessionID);
    Result := repResult.ResultCode = 0;
  finally
    FreeAndNil(repResult);
  end;

end;

function TZasioVClient.RemoveReport(const aAutoIndex: Integer): boolean;
var
  repResult: roReportResult;
  repRec: roReportRec;
begin
  try
    repRec := roReportRec.Create;
    repRec.RepAutoIndex := aAutoIndex;

    repResult := Get_IReportService.DeleteReport(SessionID, repRec);

    Result := repResult.ResultCode = 0;
  finally
    FreeAndNil(repResult);
    FreeAndNil(repRec);
  end;
end;

procedure TZasioVClient.SetTestServerAddress(AServerAddress: String;
  AServerPort: Integer);
begin
  FTestServerAddress := AServerAddress;
  FTestServerPort := AServerPort;
end;


function TZasioVClient.TestConnection(AServerAddress: String; AServerPort: Integer): Boolean;
begin
  Result := False;
  PrepareServerAddress(AServerAddress, AServerPort);
  try
    if ((RemoteService as IReportService).Echo('TEST') = 'TEST') then
      Result := true;
  except
    on E: Exception do begin
      TCommonUtils.ShowWarningMessage('Server is unavailable.'#13#10'Application raised error: '+E.Message);
    end;
  end;
end;

procedure TZasioVClient.PrepareServerAddress;
begin
  case FTypeConnect of
    tcTest: PrepareServerAddress(FTestServerAddress, FTestServerPort);
    tcWork: PrepareServerAddress(Settings.ServerAddress,Settings.ServerPort);
  end;

end;

function TZasioVClient.TestConnection: Boolean;
begin
  Result := TestConnection(Settings.ServerAddress, Settings.ServerPort);
end;

initialization
finalization
  if Assigned(__ZasioVClient) then
    FreeAndNil(__ZasioVClient);

end.
