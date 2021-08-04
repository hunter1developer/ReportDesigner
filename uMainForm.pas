unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.ComCtrls, Vcl.ExtCtrls, uROTypes, uDABin2DataStreamer, uDADataStreamer,
  uROComponent, uDAScriptingProvider, uDADataTable, uDAMemDataTable,
  uDADataAdapter, uDARemoteDataAdapter, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxMaskEdit,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, cxDBTL, cxTLData, Data.DB, uDAFields,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSplitter, Vcl.ToolWin, Vcl.ImgList,
  uCustomReportDM, Vcl.Grids, Vcl.DBGrids, uReportOptionsProcessor, Vcl.XPMan,
  Vcl.StdCtrls, hh_funcs, ShellApi, TlHelp32,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges,
  uRODynamicRequest, uDADelta, System.ImageList, cxImageList, uReportPrepSettingsForm;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Login1: TMenuItem;
    Settings1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    alMainMenu: TActionList;
    actLogin: TAction;
    actSettings: TAction;
    actExit: TAction;
    actAbout: TAction;
    StatusBar: TStatusBar;
    TimerShow: TTimer;
    DAMemDataTableForms: TDAMemDataTable;
    DADataSourceForms: TDADataSource;
    cxTreeListReportsForm: TcxDBTreeList;
    cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn;
    cxGridReportsDBTableView1: TcxGridDBTableView;
    cxGridReportsLevel1: TcxGridLevel;
    cxGridReports: TcxGrid;
    RepNameColumn: TcxGridDBColumn;
    RepDescColumn: TcxGridDBColumn;
    pnlReportTypes: TPanel;
    cxSplitter1: TcxSplitter;
    pnlReports: TPanel;
    ToolBarReports: TToolBar;
    DAMemDataTableReports: TDAMemDataTable;
    DADataSourceReports: TDADataSource;
    btnNewReport: TToolButton;
    btnDesignReport: TToolButton;
    btnDeleteReport: TToolButton;
    ToolButton4: TToolButton;
    btnImport: TToolButton;
    btnExport: TToolButton;
    alToolBalReports: TActionList;
    actImport: TAction;
    actExport: TAction;
    ImportOpenDialog: TOpenDialog;
    ExportSaveDialog: TSaveDialog;
    actNewReport: TAction;
    actDesignReport: TAction;
    actDeleteReport: TAction;
    cxImageList: TcxImageList;
    btnSortOrder: TToolButton;
    actSortOrderReport: TAction;
    cxImageList1: TcxImageList;
    XPManifest1: TXPManifest;
    pnlTop: TPanel;
    lblReportTypes: TLabel;
    N2: TMenuItem;
    Help2: TMenuItem;
    actHelp: TAction;
    PopupMenu: TPopupMenu;
    itemProperties: TMenuItem;
    alPopupMenu: TActionList;
    actProperties: TAction;
    TimerRefreshSession: TTimer;
    actReportDesignerManual: TAction;
    ReportDesignerManual1: TMenuItem;
    GetApp1: TMenuItem;
    actLoginSaml: TAction;
    btnDuplicate: TToolButton;
    aDuplicate: TAction;
    procedure actLoginExecute(Sender: TObject);
    procedure actSettingsExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure TimerShowTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actExportExecute(Sender: TObject);
    procedure actImportExecute(Sender: TObject);
    procedure actNewReportExecute(Sender: TObject);
    procedure actDesignReportExecute(Sender: TObject);
    procedure actDeleteReportExecute(Sender: TObject);
    procedure actSortOrderReportExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actPropertiesExecute(Sender: TObject);
    procedure actPropertiesUpdate(Sender: TObject);
    procedure actDesignReportUpdate(Sender: TObject);
    procedure actDeleteReportUpdate(Sender: TObject);
    procedure actSortOrderReportUpdate(Sender: TObject);
    procedure actExportUpdate(Sender: TObject);
    procedure actImportUpdate(Sender: TObject);
    procedure actNewReportUpdate(Sender: TObject);
    procedure cxTreeListReportsFormFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode,
      AFocusedNode: TcxTreeListNode);
    procedure TimerRefreshSessionTimer(Sender: TObject);
    procedure actReportDesignerManualExecute(Sender: TObject);
    procedure GetApp1Click(Sender: TObject);
    procedure actLoginSamlExecute(Sender: TObject);
    procedure aDuplicateExecute(Sender: TObject);
  private
    FOptionsProcessor: TReportOptionsProcessor;
    fHtmlHelp : THookHelpSystem;
    FPdfFile:string;

    procedure ViewReports(const aRfId: String);
    function ConvertFileToBinary(const aFileName: String): Binary;

    procedure ImportFile(const aFileName, aRepName, aDesc: String);
    procedure ExportFile(const aFileName: String);

    function HasRightForDesign: Boolean;
    procedure RefreshReportsList;
    function GetVersion: string;

    procedure OpenPdf(const AFileName: string);
    function IsSamlAuthentication: boolean;

  protected
    procedure DesignReport(aRfId: string; ADesignRepType: TDesignReportType; aReportName: string = ''; aReportDesc: string = '');
  public
    procedure PrepareDataAfterLogin;
    property OptionsProcessor: TReportOptionsProcessor read FOptionsProcessor;
    property Version: string read GetVersion;
  end;

var
  frmMain: TfrmMain;
const
  constReportDesignerManual: string = 'Report Designer Manual.pdf';

implementation

uses
  uZasioVClient,
  uSettingsForm,
  uLoginForm,
  uLoginSamlForm,
  uAboutForm,
  uSortOrderForm,
  uReportSettingsForm,
  uCommonUtils,
  uDataModule,
  uExeUpdater,
  uConstants;

{$R *.dfm}

procedure TfrmMain.actAboutExecute(Sender: TObject);
begin
  with TfrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmMain.actDeleteReportExecute(Sender: TObject);
var
  RecNo: Integer;
begin
  try
    if not ZasioVClient.CheckSessionID then begin
      TimerShow.Enabled := true;
      Exit;
    end;
  except
    TimerShow.Enabled := true;
    Exit;
  end;

  RecNo := 0;
  if not DAMemDataTableReports.IsEmpty then
  begin
    RecNo := DAMemDataTableReports.Dataset.RecNo - 1;
    if (TCommonUtils.ShowConfirmMessage('Do you want to delete ' + DAMemDataTableReports.FieldByName('RepName').AsString + ' ?',
                          [mbYes, mbNo]) = mrYes) then
    begin
      if not ZasioVClient.RemoveReport(DAMemDataTableReports.FieldByName('RepAutoIndex').AsInteger) then
        TCommonUtils.ShowErrorMessage('Cannot delete report.');
      RefreshReportsList;
      Dec(RecNo);
      if RecNo >= 0 then
        DAMemDataTableReports.Dataset.MoveBy(RecNo);
    end;
  end;
end;

procedure TfrmMain.actDeleteReportUpdate(Sender: TObject);
begin
  actDeleteReport.Enabled := DAMemDataTableReports.Active and not DAMemDataTableReports.IsEmpty and HasRightForDesign;
end;

procedure TfrmMain.actNewReportExecute(Sender: TObject);
var
  RecNo: Integer;
begin
  try
    if not ZasioVClient.CheckSessionID then begin
      TimerShow.Enabled := true;
      Exit;
    end;
  except
    TimerShow.Enabled := true;
    Exit;
  end;

  RecNo := -1;
  if not DAMemDataTableForms.IsEmpty then
  begin
    RecNo := DAMemDataTableReports.Dataset.RecNo - 1;
    DesignReport(DAMemDataTableForms.FieldByName('RfId').AsString, drtNew);
    ViewReports(DAMemDataTableForms.FieldByName('RfId').AsString);

    if not DAMemDataTableReports.Dataset.Locate('RepName', ZasioVClient.RepName, [loCaseInsensitive]) then
      DAMemDataTableReports.Dataset.MoveBy(RecNo);
  end;
end;

procedure TfrmMain.actNewReportUpdate(Sender: TObject);
begin
  actNewReport.Enabled := DAMemDataTableReports.Active and HasRightForDesign;
end;

procedure TfrmMain.actPropertiesExecute(Sender: TObject);
var
  sRepName: string;
  sRepDesc: string;
  Bookmark: TBookmark;
  TemplateStream, OptionsStream: Binary;
  RecNo: Integer;
begin
  RecNo := -1;
  sRepName := EmptyStr;
  sRepDesc := EmptyStr;
  TemplateStream := Binary.Create;
  OptionsStream := Binary.Create;
  try
    if not DAMemDataTableForms.IsEmpty then
    begin
      ZasioVClient.RfId := DAMemDataTableForms.FieldByName('RfId').AsString;
      ZasioVClient.RepAutoIndex := DAMemDataTableReports.FieldByName('RepAutoIndex').AsInteger;
      ZasioVClient.RepName := DAMemDataTableReports.FieldByName('RepName').AsString;
      ZasioVClient.RepDesc := DAMemDataTableReports.FieldByName('RepDesc').AsString;
      ZasioVClient.RepUserIndex := DAMemDataTableReports.FieldByName('RepUserIndex').AsInteger;

      DAMemDataTableReports.FieldByName('RepTemplateData').SaveToStream(TemplateStream);
      DAMemDataTableReports.FieldByName('RepOptionsData').SaveToStream(OptionsStream);

      sRepName := DAMemDataTableReports.FieldByName('RepName').AsString;
      sRepDesc := DAMemDataTableReports.FieldByName('RepDesc').AsString;
      if GetReportWhereData(sRepName, sRepDesc) then
      begin
        RecNo := DAMemDataTableReports.Dataset.RecNo - 1;
        try
          if not ZasioVClient.UpdateReportTemplateData(
                                            ZasioVClient.RfId,
                                            sRepName,
                                            sRepDesc,
                                            ZasioVClient.RepAutoIndex,
                                            ZasioVClient.RepUserIndex,
                                            TemplateStream,
                                            OptionsStream) then
            TCommonUtils.ShowErrorMessage('Cannot update report template');

          ViewReports(DAMemDataTableForms.FieldByName('RfId').AsString);

          if RecNo >= 0 then
            DAMemDataTableReports.Dataset.MoveBy(RecNo);
        finally
        end;
      end;
    end;
  finally
    FreeAndNil(TemplateStream);
    FreeAndNil(OptionsStream);
  end;
end;

procedure TfrmMain.actPropertiesUpdate(Sender: TObject);
begin
  actProperties.Enabled := DAMemDataTableReports.Active and not DAMemDataTableReports.IsEmpty and HasRightForDesign;
end;

procedure TfrmMain.actReportDesignerManualExecute(Sender: TObject);
var
  MB_Str: string;
begin
  if FileExists(FPdfFile) then
    OpenPdf(FPdfFile)
  else
  begin
    MB_Str := Format('No ''%s'' file found.', [constReportDesignerManual]);
    TCommonUtils.ShowWarningMessage(MB_Str);
  end;
end;

procedure TfrmMain.actDesignReportExecute(Sender: TObject);
var
  RecNo: Integer;
begin
  try
    if not ZasioVClient.CheckSessionID then begin
      TimerShow.Enabled := true;
      Exit;
    end;
  except
    TimerShow.Enabled := true;
    Exit;
  end;

  RecNo := -1;
  if not DAMemDataTableReports.IsEmpty then
  begin
    RecNo := DAMemDataTableReports.Dataset.RecNo - 1;
    try
      DesignReport(DAMemDataTableForms.FieldByName('RfId').AsString,
                   drtDesign,
                   DAMemDataTableReports.FieldByName('RepName').AsString,
                   DAMemDataTableReports.FieldByName('RepDesc').AsString);
      ViewReports(DAMemDataTableForms.FieldByName('RfId').AsString);

    if RecNo >= 0 then
      DAMemDataTableReports.Dataset.MoveBy(RecNo);
    finally
    end;
  end;

end;


procedure TfrmMain.actDesignReportUpdate(Sender: TObject);
begin
  actDesignReport.Enabled := DAMemDataTableReports.Active and not DAMemDataTableReports.IsEmpty and HasRightForDesign;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actExportExecute(Sender: TObject);
begin
  try
    if not ZasioVClient.CheckSessionID then begin
      TimerShow.Enabled := true;
      Exit;
    end;
  except
    TimerShow.Enabled := true;
    Exit;
  end;

  if DAMemDataTableReports.IsEmpty then
    Exit;

  ExportSaveDialog.FileName := DAMemDataTableReports.FieldByName('RepName').AsString;
  if Length(ExportSaveDialog.FileName) = 0 then
    Exit;

  if ExportSaveDialog.Execute then
  begin
    ExportFile(ExportSaveDialog.FileName);
  end;
end;

procedure TfrmMain.actExportUpdate(Sender: TObject);
begin
  actExport.Enabled := DAMemDataTableReports.Active and not DAMemDataTableReports.IsEmpty;
end;

procedure TfrmMain.actHelpExecute(Sender: TObject);
var
  MB_Str: string;
begin
  if Assigned(fHtmlHelp) then
    FHtmlHelp.HelpTopic('')
  else
  begin
    MB_Str := 'No Versatile Cloud Report Manager help file found.';
    TCommonUtils.ShowWarningMessage(MB_Str);
  end;
end;

procedure TfrmMain.actImportExecute(Sender: TObject);
var
  sDesc: string;
  sFileName: string;
  iRecNo: integer;
begin
  try
    if not ZasioVClient.CheckSessionID then begin
      TimerShow.Enabled := true;
      Exit;
    end;
  except
    TimerShow.Enabled := true;
    Exit;
  end;

  if ImportOpenDialog.Execute then
  begin
    sFileName := EmptyStr;
    if not GetReportWhereData(ChangeFileExt(ImportOpenDialog.FileName, ''), sFileName, sDesc) then
      Exit;

    iRecNo := DAMemDataTableReports.RecNo;
    ImportFile(ImportOpenDialog.FileName, sFileName, sDesc);
    RefreshReportsList;
    if iRecNo > 0 then
      DAMemDataTableReports.RecNo := iRecNo;
  end;
end;

procedure TfrmMain.actImportUpdate(Sender: TObject);
begin
  actImport.Enabled := DAMemDataTableReports.Active and HasRightForDesign;
end;

procedure TfrmMain.actLoginExecute(Sender: TObject);
var
  fBinaryDataSet: Binary;
  tempDataStreamer: TDABin2DataStreamer;
  tmpUserId: string;
begin
  if IsSamlAuthentication then
  begin
    tmpUserId := ZasioVClient.GetSAMLUserID;
    if (tmpUserId <> EmptyStr) and (ZasioVClient.LoginSSO(tmpUserId)) then
      PrepareDataAfterLogin
    else
    begin
      TCommonUtils.ShowWarningMessage('SAML Authentication FAILURE!');
      Exit;
    end;
  end
  else
  begin
    if ShowLoginDialog then
      PrepareDataAfterLogin;
  end;
end;

//new Login for Saml Authentication with new form
procedure TfrmMain.actLoginSamlExecute(Sender: TObject);
var
  tempDataStreamer: TDABin2DataStreamer;
  tmpUserId: string;
begin
  if ShowLoginSamlDialog then
    PrepareDataAfterLogin;
end;

procedure TfrmMain.actSettingsExecute(Sender: TObject);
begin
  ShowSettingsDialog;
end;

procedure TfrmMain.actSortOrderReportExecute(Sender: TObject);
var
  iRecNo: integer;
begin
  try
    if not ZasioVClient.CheckSessionID then begin
      TimerShow.Enabled := true;
      Exit;
    end;
  except
    TimerShow.Enabled := true;
    Exit;
  end;

  if not DAMemDataTableReports.IsEmpty then
  begin
    with TfrmSortOrder.Create(nil) do
    try
      ZasioVClient.RfId := DAMemDataTableForms.FieldByName('RfId').AsString;
      ZasioVClient.RepAutoIndex := DAMemDataTableReports.FieldByName('RepAutoIndex').AsInteger;
      ZasioVClient.RepName := DAMemDataTableReports.FieldByName('RepName').AsString;
      ZasioVClient.RepDesc := DAMemDataTableReports.FieldByName('RepDesc').AsString;
      ZasioVClient.RepUserIndex := DAMemDataTableReports.FieldByName('RepUserIndex').AsInteger;
      RfId := ZasioVClient.RfId;

      TemplateStream.Position := 0;
      TReportOptionsProcessor.ReportOptionsStream.Position := 0;
      DAMemDataTableReports.FieldByName('RepTemplateData').SaveToStream(TemplateStream);
      DAMemDataTableReports.FieldByName('RepOptionsData').SaveToStream(TReportOptionsProcessor.ReportOptionsStream);

      iRecNo := DAMemDataTableReports.RecNo;

      FillSortOrderData;

      if DMReport <> nil then
        ShowModal;

      ViewReports(DAMemDataTableForms.FieldByName('RfId').AsString);
      DAMemDataTableReports.RecNo := iRecNo;

    finally
      Free;
    end;
  end;
end;


procedure TfrmMain.actSortOrderReportUpdate(Sender: TObject);
begin
  actSortOrderReport.Enabled := DAMemDataTableReports.Active and not DAMemDataTableReports.IsEmpty and HasRightForDesign;
end;

procedure TfrmMain.aDuplicateExecute(Sender: TObject);
const
  cDuplicate = '%s - Duplicate';
var
  tmpDuplicate: String;
  RecNo: Integer;
begin
  try
    if not ZasioVClient.CheckSessionID then begin
      TimerShow.Enabled := true;
      Exit;
    end;
  except
    TimerShow.Enabled := true;
    Exit;
  end;

  RecNo := -1;
  if not DAMemDataTableForms.IsEmpty then
  begin
    RecNo := DAMemDataTableReports.Dataset.RecNo - 1;
    tmpDuplicate := Format(cDuplicate, [DAMemDataTableReports.FieldByName('RepName').AsString]);
    DesignReport(DAMemDataTableForms.FieldByName('RfId').AsString,
                 drtDuplicate,
                 tmpDuplicate,
                 DAMemDataTableReports.FieldByName('RepDesc').AsString);
    ViewReports(DAMemDataTableForms.FieldByName('RfId').AsString);

    if RecNo >= 0 then
      DAMemDataTableReports.Dataset.MoveBy(RecNo);
  end;
end;

function TfrmMain.ConvertFileToBinary(const aFileName: String): Binary;
var
  FileStream: TFileStream;
begin
  try
    try
      FileStream := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
      Result := Binary.Create();
      Result.CopyFrom(FileStream, FileStream.Size);
    except
      Result := nil;
    end;
  finally
    FreeAndNil(FileStream);
  end;
end;

procedure TfrmMain.cxTreeListReportsFormFocusedNodeChanged(Sender: TcxCustomTreeList;
  APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  RefreshReportsList;
end;

procedure TfrmMain.DesignReport(aRfId: string; ADesignRepType: TDesignReportType; aReportName: string = ''; aReportDesc: string = '');
var
  TopCount: integer;
  WhereIndexes: string;
  TemplateStream, OptionsStream: TMemoryStream;
  procedure SaveToStreamReport;
  begin
    DAMemDataTableReports.FieldByName('RepTemplateData').SaveToStream(TemplateStream);
    DAMemDataTableReports.FieldByName('RepOptionsData').SaveToStream(OptionsStream);

    dmMain.OptionsStreamDM.Clear;
    dmMain.OptionsStreamDM.Position := 0;
    DAMemDataTableReports.FieldByName('RepOptionsData').SaveToStream(dmMain.OptionsStreamDM);
  end;
begin
  WhereIndexes := EmptyStr;
  TemplateStream := nil;
  OptionsStream := nil;

  try
    TemplateStream := TMemoryStream.Create;
    OptionsStream := TMemoryStream.Create;

    ZasioVClient.RfId := DAMemDataTableForms.FieldByName('RfId').AsString;

    if ADesignRepType = drtDesign then
    begin
      ZasioVClient.RepName := DAMemDataTableReports.FieldByName('RepName').AsString;
      ZasioVClient.RepDesc := DAMemDataTableReports.FieldByName('RepDesc').AsString;
      ZasioVClient.RepAutoIndex := DAMemDataTableReports.FieldByName('RepAutoIndex').AsInteger;
      ZasioVClient.RepUserIndex := DAMemDataTableReports.FieldByName('RepUserIndex').AsInteger;
      SaveToStreamReport;
      GetReportPrepWhereData(aReportName, aReportDesc, TopCount, WhereIndexes, TemplateStream, OptionsStream, aRfId, drtDesign)
    end
    else
    if ADesignRepType = drtNew then
    begin
      ZasioVClient.RepName := EmptyStr;
      ZasioVClient.RepDesc := EmptyStr;
      GetReportPrepWhereData(ZasioVClient.RepName, ZasioVClient.RepDesc, TopCount, WhereIndexes, TemplateStream, OptionsStream, aRfId, drtNew);
    end
    else
    if ADesignRepType = drtDuplicate then
    begin
      ZasioVClient.RepName := EmptyStr;
      ZasioVClient.RepDesc := EmptyStr;
      SaveToStreamReport;
      GetReportPrepWhereData(aReportName, aReportDesc, TopCount, WhereIndexes, TemplateStream, OptionsStream, aRfId, drtDuplicate)
    end;
  finally
    FreeAndNil(TemplateStream);
    FreeAndNil(OptionsStream);
  end;
end;

procedure TfrmMain.ExportFile(const aFileName: String);
var
  sRptFile: string;
begin
  DAMemDataTableReports.FieldByName('RepTemplateData').SaveToFile(aFileName);
  if not DAMemDataTableReports.FieldByName('RepOptionsData').IsNull then
  begin
    sRptFile := ChangeFileExt(aFileName, '.rpt');
    DAMemDataTableReports.FieldByName('RepOptionsData').SaveToFile(sRptFile);
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    if ZasioVClient.SessionID <> '' then
      ZasioVClient.LogOut;
  except

  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
const
  constRetChmFile : string = 'VCloudReportManager.chm';
var
  ChmFile: string;
begin
  ChmFile := EmptyStr;
  FHtmlHelp := nil;
  ChmFile := ExtractFilePath(Application.ExeName) + constRetChmFile;
  if FileExists(ChmFile) then
    FHtmlHelp := THookHelpSystem.Create(ChmFile, '', htHHAPI);

  FPdfFile := ExtractFilePath(Application.ExeName) + constReportDesignerManual;

  ZasioVClient.bSamlAuthentication := false;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  ToolBarReports.Enabled := false;
  TimerShow.Enabled := True;
end;

procedure TfrmMain.GetApp1Click(Sender: TObject);
const
  Prefix  = 'New';
var
  appBinary: Binary;
  Stream: TFileStream;
  SelfUpdater: TExeUpdate;
  SelfName: string;
  SelfPath: string;
  downloadedFile: string;
begin
  try
    if ZasioVClient.GetNewInstallationSelf(appBinary) then
    begin
      try
        SelfName := ExtractFileName(Application.ExeName);
        SelfPath := ExtractFilePath(Application.ExeName);
        downloadedFile := SelfPath + PathDelim + Prefix + SelfName;
        Stream := TFileStream.Create(downloadedFile, fmCreate);
        Stream.Position := 0;
        Stream.CopyFrom(appBinary, appBinary.Size);
        SelfUpdater := TExeUpdate.Create(Application.ExeName, GetCurrentProcessId, Prefix);
      finally
        Stream.Free;
        SelfUpdater.Free;
      end;
    end;
  except

  end;
end;

function TfrmMain.GetVersion: string;
begin
  Result := TCommonUtils.GetFileVersionStr(Application.ExeName);
end;

function TfrmMain.HasRightForDesign: Boolean;
var
  fActionCode, fCode: Integer;
  rfID: String;
begin
  Result := ZasioVClient.SessionFunctionality.IsAdmin;
  if not DAMemDataTableForms.Active then Exit;

  if not Result then begin
    rfID := DAMemDataTableForms.FieldByName('RfId').AsString;
    if rfID = 'RESEARCH' then
      fCode := 711200
    else
    if rfID = 'SCHEDULES' then
      fCode := 721200
    else
    if rfID = 'INTERVIEWS' then
      fCode := 731200
    else
    if rfID = 'CHANGE_REQUESTS' then
      fCode := 741200
    else
    if rfID = 'MESSAGES' then
      fCode := 751200
    else
    if rfID = 'ORGANIZATION' then
      fCode := 111200
    else
    if rfID = 'INT_FOLDERS' then
      fCode := 193600
    else
    if rfID = 'RF_CIT' then
      fCode := 710600
    else
    if rfID = 'RF_SCHED' then
      fCode := 720600
    else
    if rfID = 'RF_INT' then
      fCode := 730600
    else
    if rfID = 'RF_MSG' then
      fCode := 750600
    else
      fCode := 0;

    if (rfID = 'RESEARCH') or (rfID = 'RF_CIT') then
      fActionCode := 710000
    else
    if (rfID = 'SCHEDULES') or (rfID = 'RF_SCHED') then
      fActionCode := 720000
    else
    if (rfID = 'INTERVIEWS') or (rfID = 'RF_INT') then
      fActionCode := 730000
    else
    if (rfID = 'CHANGE_REQUESTS') then
      fActionCode := 740000
    else
    if (rfID = 'MESSAGES') or (rfID = 'RF_MSG') then
      fActionCode := 750000
    else
    if (rfID = 'ORGANIZATION') then
      fActionCode := 110000
    else
    if (rfID = 'INT_FOLDERS') then
      fActionCode := 193000
    else
      fActionCode := 0;

    Result := ZasioVClient.AllowedSecFunction[fActionCode] and ZasioVClient.AllowedSecFunction[fCode];
  end;
end;

procedure TfrmMain.ImportFile(const aFileName, aRepName, aDesc: String);
var
  binRtmFile: Binary;
  binRptFile: Binary;
  sRptFile: string;
  bResult : boolean;
  sMessage: String;
begin
  binRtmFile := nil;
  binRptFile := nil;

  if not ZasioVClient.CheckSessionID then begin
    TimerShow.Enabled := true;
    Exit;
  end;

  try
    binRtmFile := ConvertFileToBinary(aFileName);
    sRptFile := ChangeFileExt(aFileName, '.rpt');
    if FileExists(sRptFile) then
      binRptFile := ConvertFileToBinary(sRptFile)
    else
      binRptFile := Binary.Create();


    ZasioVClient.RfId := DAMemDataTableForms.FieldByName('RfId').AsString;
    ZasioVClient.RepAutoIndex := DAMemDataTableReports.FieldByName('RepAutoIndex').AsInteger;
    ZasioVClient.RepName := DAMemDataTableReports.FieldByName('RepName').AsString;
    ZasioVClient.RepDesc := DAMemDataTableReports.FieldByName('RepDesc').AsString;
    ZasioVClient.RepUserIndex := DAMemDataTableReports.FieldByName('RepUserIndex').AsInteger;

    if not (DAMemDataTableReports.Locate('RepName', aRepName, [])) then
    begin
      bResult := ZasioVClient.InsertReport(
                                DAMemDataTableForms.FieldByName('RfId').AsString,
                                aRepName,
                                aDesc,
                                binRtmFile,
                                binRptFile);
      sMessage := 'Cannot insert report';
    end
    else
    begin
      bResult := ZasioVClient.UpdateReportTemplateData(
                                                   ZasioVClient.RfId,
                                                    ZasioVClient.RepName,
                                                    aDesc,
                                                    ZasioVClient.RepAutoIndex,
                                                    ZasioVClient.RepUserIndex,
                                                    binRtmFile,
                                                    binRptFile);
      sMessage := 'Cannot update report';
    end;

    if not bResult then
      TCommonUtils.ShowErrorMessage(sMessage);

  finally
    binRtmFile.Free;
    binRptFile.Free;
  end;
end;

function TfrmMain.IsSamlAuthentication: boolean;
var
  tmpFileName: string;
begin
  tmpFileName := ExtractFilePath(Application.ExeName) + 'zSaml.dll';
  Result := FileExists(tmpFileName);
end;

procedure TfrmMain.OpenPdf(const AFileName: string);
begin
  ShellExecute(0, 'open', PChar(AFileName), nil, nil, SW_NORMAL);
end;

procedure TfrmMain.PrepareDataAfterLogin;
var
  fBinaryDataSet: Binary;
  tempDataStreamer: TDABin2DataStreamer;
begin
  ToolBarReports.Enabled := true;
  fBinaryDataSet := nil;
  if ZasioVClient.GetReportFromListData(fBinaryDataSet) then
  begin
    tempDataStreamer := TDABin2DataStreamer.Create(nil);
    try
      tempDataStreamer.Initialize(fBinaryDataSet, aiRead);
      try
        tempDataStreamer.ReadDataset('ViewREPORT_FORMS', DAMemDataTableForms, True);

        if cxTreeListReportsForm.Count > 0 then
          cxTreeListReportsForm.Items[0].Selected := true;

        if DAMemDataTableForms.RecordCount > 0 then
          ViewReports(DAMemDataTableForms.FieldByName('RfId').AsString);
      finally
        tempDataStreamer.Finalize;
      end;
    finally
      tempDataStreamer.Free;
      FreeAndNil(fBinaryDataSet);
    end;
  end;
end;

procedure TfrmMain.RefreshReportsList;
begin
  if not DAMemDataTableForms.IsEmpty then
  begin
    if (DAMemDataTableForms.FieldByName('RfId').AsString = 'REVIEW_FLAGS') then
      ToolBarReports.Enabled := false
    else
      ToolBarReports.Enabled := true;

    ViewReports(DAMemDataTableForms.FieldByName('RfId').AsString);
  end;
end;

procedure TfrmMain.TimerRefreshSessionTimer(Sender: TObject);
var
  bSession: boolean;
begin
  bSession := false;
  try
    if ZasioVClient.CheckSessionID then
      bSession := ZasioVClient.RefreshSession;
  except

  end;
end;


procedure TfrmMain.TimerShowTimer(Sender: TObject);
var
  res: Boolean;
  tmpUserId: string;
begin
(*
  TimerShow.Enabled := False;
  res := True;
  if not ZasioVClient.TestConnection then
     res := ShowSettingsDialog;

  if ZasioVClient.GetVersion <> Version then begin
    TCommonUtils.ShowWarningMessage('Report Manager version is not compatible. Please download and install the latest report manager version to continue.');
    Application.Terminate();
  end;

  if res and ZasioVClient.TestConnection then
    actLogin.Execute;
*)
  TimerShow.Enabled := False;
  res := True;
  if not ZasioVClient.TestConnection then
     res := ShowSettingsDialog;

  ZasioVClient.CheckDownloadInstallVersion(Version);

  if res and ZasioVClient.TestConnection then
   actLoginSaml.Execute; //actLogin.Execute;
end;


procedure TfrmMain.ViewReports(const aRfId: String);
var
  fBinaryDataSet: Binary;
  tempDataStreamer: TDABin2DataStreamer;
  OldCursor: TCursor;
begin
  fBinaryDataSet := nil;

  try
    if not ZasioVClient.CheckSessionID then begin
      TimerShow.Enabled := true;
      Exit;
    end;
  except
    TimerShow.Enabled := true;
    Exit;
  end;

  if ZasioVClient.GetReport(aRfId, fBinaryDataSet) then
  begin
    OldCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      tempDataStreamer := TDABin2DataStreamer.Create(nil);
      try
        tempDataStreamer.Initialize(fBinaryDataSet, aiRead);
        try
          tempDataStreamer.ReadDataset('ViewREPORTS', DAMemDataTableReports, True);
        finally
          tempDataStreamer.Finalize;
        end;
      finally
        tempDataStreamer.Free;
        FreeAndNil(fBinaryDataSet);
      end;
    finally
      Screen.Cursor := OldCursor;
    end;
  end
  else
    TimerShow.Enabled := true;
end;

end.
