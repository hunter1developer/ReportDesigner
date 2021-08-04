unit uReportPrepSettingsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls,
  uReportPrepSettingsFrame, System.Actions, uCustomReportDM, uROTypes,
  uOrganizationReportDM, uIntFolderReportDM, uMessageReportDM, uCitUpdatesReportDM,
  uReviewFlagReportDM, uResearchReportDM, uInterviewReportDM, uScheduleReportDM,
  uChangeRequestsReportDM, uReportOptionsProcessor;


type
  TDesignReportType = (drtNone, drtNew, drtDesign, drtDuplicate);

  TfrmReportPrepSettings = class(TForm)
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    alReportSettings: TActionList;
    actnOk: TAction;
    frmReportPrepSettings: TframeReportPrepSettings;
    pnlMain: TPanel;
    procedure actnOkExecute(Sender: TObject);
    procedure actnOkUpdate(Sender: TObject);
  private
    FReportName: String;
    FReportDesc: string;
    FOptionsStream: TMemoryStream;
    FTemplateStream: TMemoryStream;
    FRfId: string;

    aDMReport: TdmCustomReport;
    FChangeDesc: boolean;
    FChangeName: boolean;
    FDesignReportType: TDesignReportType;

    function SaveReportTemplate: boolean;
    procedure ppDesignerCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure DesignOgranization;
    procedure DesignIntFolders;
    procedure DesignMessages;
    procedure DesignCitUpdates;

    procedure DesignReviewFlag(aReviewFlagItemType: integer);
    procedure DesignReviewCitationsFlag;
    procedure DesignReviewInterviewsFlag;
    procedure DesignReviewMessagesFlag;
    procedure DesignReviewShedulesFlag;

    procedure DesignResearch;
    procedure DesignInterview;
    procedure DesignSchedule;

    procedure DesignChangeRequests;
  public
    { Public declarations }
    procedure DesignReport;

    property ReportName: string read FReportName write FReportName;
    property ReportDesc: string read FReportDesc write FReportDesc;

    property RfId: string read FRfId write FRfId;
    property TemplateStream: TMemoryStream read FTemplateStream write FTEmplateStream;
    property OptionsStream: TMemoryStream read FOptionsStream write FOptionsStream;
    property bChangeDesc: boolean read FChangeDesc write FChangeDesc;
    property bChangeName: boolean read FChangeName write FChangeName;
    property DesignReportType: TDesignReportType read FDesignReportType write FDesignReportType;
  end;

  function GetReportPrepWhereData(var AReportName: String;  var AReportDesc: string; var ATopCount: integer; var AWhereIndexes: String; ATemplate, AOptions: TMemoryStream; ARfId: string; ADesignReportType: TDesignReportType): Boolean;

var
  frmReportSettings: TfrmReportPrepSettings;

implementation

uses
  uCommonUtils,
  uMainForm,
  uDataModule,
  uZasioVClient,
  uConstants;

{$R *.dfm}

function GetReportPrepWhereData(var AReportName: String; var AReportDesc: string; var ATopCount: integer; var AWhereIndexes: String; ATemplate, AOptions: TMemoryStream; ARfId: string; ADesignReportType: TDesignReportType): Boolean;
begin
  with TfrmReportPrepSettings.Create(nil) do
  try
    bChangeName := false;
    bChangeDesc := false;
    ATopCount := 0;

    FReportName := AReportName;
    FReportDesc := AReportDesc;
    frmReportPrepSettings.edtReportName.Text := FReportName;
    frmReportPrepSettings.edtReportDescription.Text := FReportDesc;
    Result := (ShowModal = mrOk);
    if Result then
    begin
      AReportName := frmReportPrepSettings.edtReportName.Text;
      AReportDesc := frmReportPrepSettings.edtReportDescription.Text;

      if frmReportPrepSettings.rbTopCount.Checked then
        ATopCount := StrToInt(frmReportPrepSettings.edtTopCount.Text)
      else
      if frmReportPrepSettings.rbWithoutData.Checked then
        AWhereIndexes := '-1'
      else
      if frmReportPrepSettings.rbSelectedIndexes.Checked then
        AWhereIndexes := frmReportPrepSettings.edtIndexes.Text;

      FDesignReportType := ADesignReportType;
      TemplateStream := ATemplate;
      OptionsStream := AOptions;
      ZasioVClient.TopCount := ATopCount;
      ZasioVClient.IndexList := AWhereIndexes;
      ZasioVClient.RepName := AReportName;
      ZasioVClient.RepDesc := AReportDesc;
      RfId := ARfId;

      if (FReportName <> AReportName) then
        bChangeName := true;

      if (FReportDesc <> AReportDesc) then
        bChangeDesc := true;

      DesignReport;
    end;
  finally
    Free;
  end;
end;

procedure TfrmReportPrepSettings.actnOkExecute(Sender: TObject);
begin
  if frmReportPrepSettings.rbSelectedIndexes.Checked and
     (Trim(frmReportprepSettings.edtIndexes.Text) = EmptyStr) then
  begin
    TCommonUtils.ShowWarningMessage('Fill indexes field!');
    Exit;
  end;
  ModalResult := mrOk;
end;

procedure TfrmReportPrepSettings.actnOkUpdate(Sender: TObject);
begin
  btnOk.Enabled := Length(frmReportPrepSettings.edtReportName.Text) > 0;
end;

procedure TfrmReportPrepSettings.DesignChangeRequests;
begin
  aDMReport := nil;
  try
    aDMReport := TdmChangeRequestsReport.Create(Self);
    aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaChangeRequests;
    dmMain.tblMaster := aDMReport.tblReport;
    dmMain.tblSubReport1 := aDMReport.tblSubReport1;
    dmMain.tblSubReport2 := aDMReport.tblSubReport2;
    dmMain.tblSubReport3 := aDMReport.tblSubReport3;

    //SchedTitle
    dmMain.tblSubReportSchedTitleO := TdmChangeRequestsReport(aDMReport).tblSchedTitleO;
    dmMain.tblSubReportSchedTitleP := TdmChangeRequestsReport(aDmReport).tblSchedTitleP;

    //Countries
    dmMain.tblSubReportCountriesO := TdmChangeRequestsReport(aDMReport).tblCountriesO;
    dmMain.tblSubReportCountriesP := TdmChangeRequestsReport(aDMReport).tblCountriesP;

    //Citations
    dmMain.tblSubReportCitationsO := TdmChangeRequestsReport(aDMReport).tblCitationsO;
    dmMain.tblSubReportCitationsP := TdmChangeRequestsReport(aDMReport).tblCitationsP;

    //UDFs
    dmMain.tblSubReportUDFsO := TdmChangeRequestsReport(aDMReport).tblUDFsO;
    dmMain.tblSubReportUDFsP := TdmChangeRequestsReport(aDMReport).tblUDFsP;

    //Related Items
    dmMain.tblSubReportRelationsItemsO := TdmChangeRequestsReport(aDMReport).tblRelatedItemsO;
    dmMain.tblSubReportRelationsItemsP := TdmChangeRequestsReport(aDMReport).tblRelatedItemsP;



    aDMReport.tblSubReport1.RemoteDataAdapter := dmMain.rdaChangeRequestsSchedulePending;
    aDMReport.tblSubReport2.RemoteDataAdapter := dmMain.rdaChangeRequestsAuthorizers;
    aDMReport.tblSubReport3.RemoteDataAdapter := dmMain.rdaChangeRequestsComments;

    //SchedTitle
    TdmChangeRequestsReport(aDMReport).tblSchedTitleO.RemoteDataAdapter := dmMain.rdaChangeRequestsSchedTitleO;
    TdmChangeRequestsReport(aDMReport).tblSchedTitleP.RemoteDataAdapter := dmMain.rdaChangeRequestsSchedTitleP;

    //Countries
    TdmChangeRequestsReport(aDMReport).tblCountriesO.RemoteDataAdapter := dmMain.rdaChangeRequestsCountriesO;
    TdmChangeRequestsReport(aDMReport).tblCountriesP.RemoteDataAdapter := dmMain.rdaChangeRequestsCountriesP;

    //Citations
    TdmChangeRequestsReport(aDMReport).tblCitationsO.RemoteDataAdapter := dmMain.rdaChangeRequestsCitationsO;
    TdmChangeRequestsReport(aDMReport).tblCitationsP.RemoteDataAdapter := dmMain.rdaChangeRequestsCitationsP;

    //UDFs
    TdmChangeRequestsReport(aDMReport).tblUDFsO.RemoteDataAdapter := dmMain.rdaChangeRequestsUDFsO;
    TdmChangeRequestsReport(aDMReport).tblUDFsP.RemoteDataAdapter := dmMain.rdaChangeRequestsUDFsP;

    //Related Items
    TdmChangeRequestsReport(aDMReport).tblRelatedItemsO.RemoteDataAdapter := dmMain.rdaChangeRequestsRelationsItemsO;
    TdmChangeRequestsReport(aDMReport).tblRelatedItemsP.RemoteDataAdapter := dmMain.rdaChangeRequestsRelationsItemsP;
  finally

  end;
end;

procedure TfrmReportPrepSettings.DesignCitUpdates;
begin
  aDMReport := nil;
  try
    aDMReport := TdmCitUpdatesReport.Create(Self);
    aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaCitUpdates;
  finally
  end;
end;

procedure TfrmReportPrepSettings.DesignInterview;
begin
  aDMReport := nil;
  try
    aDMReport := TdmInterviewReport.Create(Self);
    aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaInterviews;
    dmMain.tblMaster := aDMReport.tblReport;
    dmMain.tblSubReport2 := aDMReport.tblSubReport2;
    TdmInterviewReport(aDMReport).tblIntUDF.RemoteDataAdapter := dmMain.rdaInterview_UDF;

    aDMReport.tblSubReport1.RemoteDataAdapter := dmMain.rdaCitations;
    aDMReport.tblSubReport2.RemoteDataAdapter := dmMain.rdaDefinedFields;
  finally
  end;
end;

procedure TfrmReportPrepSettings.DesignIntFolders;
begin
  aDMReport := nil;
  try
    aDMReport := TdmIntFolderReport.Create(Self);
    aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaIntFolder;
  finally
  end;
end;

procedure TfrmReportPrepSettings.DesignMessages;
begin
  aDMReport := nil;
  try
    aDMReport := TdmMessageReport.Create(Self);
    aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaMessages;
  finally
  end;
end;

procedure TfrmReportPrepSettings.DesignOgranization;
begin
  aDMReport := nil;
  try
    aDMReport := TdmOrganizationReport.Create(Self);
    aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaComp;
    dmMain.tblMaster := aDMReport.tblReport;

    aDMReport.tblSubReport1.RemoteDataAdapter := dmMain.rdaDept;
    aDMReport.tblSubReport2.RemoteDataAdapter := dmMain.rdaUsers;
  finally
  end;
end;

procedure TfrmReportPrepSettings.DesignReviewFlag(aReviewFlagItemType: integer);
begin
  aDMReport := nil;
  try
    aDMReport := TdmReviewFlagReport.CreateWithType(Self, aReviewFlagItemType);
    case aReviewFlagItemType of
      0:  aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaReviewCitationsFlag;
      1:  aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaReviewShedulesFlag;
      2:  aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaReviewInterviewsFlag;
      3:  aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaReviewMessagesFlag;
    end;
  finally
  end;
end;

procedure TfrmReportPrepSettings.DesignReviewCitationsFlag;
begin
  DesignReviewFlag(0);
end;

procedure TfrmReportPrepSettings.DesignReviewInterviewsFlag;
begin
  DesignReviewFlag(2);
end;

procedure TfrmReportPrepSettings.DesignReviewMessagesFlag;
begin
  DesignReviewFlag(3);
end;

procedure TfrmReportPrepSettings.DesignReviewShedulesFlag;
begin
  DesignReviewFlag(1);
end;

procedure TfrmReportPrepSettings.DesignSchedule;
begin
  aDMReport := nil;
  try
    aDMReport := TdmScheduleReport.Create(Self);
    aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaScheduleShedules;
    dmMain.tblMaster := aDMReport.tblReport;
    TdmScheduleReport(aDMReport).tblSchedUDF.RemoteDataAdapter := dmMain.rdaSchedule_UDF;

    aDMReport.tblSubReport1.RemoteDataAdapter := dmMain.rdaScheduleCitations;
    aDMReport.tblSubReport2.RemoteDataAdapter := dmMain.rdaScheduleInterviews;
    aDMReport.tblSubReport3.RemoteDataAdapter := dmMain.rdaScheduleDefinedFields;
    aDMReport.tblSubReport4.RemoteDataAdapter := dmMain.rdaScheduleCountries;
    aDMReport.tblSubReport5.RemoteDataAdapter := dmMain.rdaScheduleCitText;
    aDMReport.tblSubReport6.RemoteDataAdapter := dmMain.rdaScheduleRelatedItems;
  finally
  end;
end;

procedure TfrmReportPrepSettings.DesignResearch;
begin
  aDMReport := nil;
  try
    aDMReport := TdmResearchReport.Create(Self);
    aDMReport.tblReport.RemoteDataAdapter := dmMain.rdaResearchCitations;
    dmMain.tblMaster := aDMReport.tblReport;

    dmMain.tblSubReport1 := aDMReport.tblSubReport1;

    aDMReport.tblSubReport1.RemoteDataAdapter := dmMain.rdaResearchCitationsMemos;
    aDMReport.tblSubReport2.RemoteDataAdapter := dmMain.rdaResearchCitationsBusacts;
    aDMReport.tblSubReport3.RemoteDataAdapter := dmMain.rdaResearchCitationsSchedules;
  finally
  end;
end;

procedure TfrmReportPrepSettings.DesignReport;
var
  bDesign: Boolean;
begin
  aDMReport := nil;

  try
    if not ZasioVClient.CheckSessionID then begin
      frmMain.TimerShow.Enabled := true;
      Exit;
    end;
  except
    frmMain.TimerShow.Enabled := true;
    Exit;
  end;

  if RfId = 'ORGANIZATION' then DesignOgranization
  else
  if RfId = 'INT_FOLDERS' then DesignIntFolders
  else
  if RfId = 'MESSAGES' then DesignMessages
  else
  if RfId = 'CIT_UPDATES' then DesignCitUpdates
  else
  if RfId = 'RF_CIT' then DesignReviewCitationsFlag
  else
  if RfId = 'RF_INT' then DesignReviewInterviewsFlag
  else
  if RfId = 'RF_MSG' then DesignReviewMessagesFlag
  else
  if RfId = 'RF_SCHED' then DesignReviewShedulesFlag
  else
  if RfId = 'RESEARCH' then DesignResearch
  else
  if RfId = 'INTERVIEWS' then DesignInterview
  else
  if RfId = 'SCHEDULES' then DesignSchedule
  else
  if RfId = 'CHANGE_REQUESTS' then DesignChangeRequests
  else
  begin
    TCommonUtils.ShowInfoMessage('The template for this form is absent.');
    Exit;
  end;

  if Assigned(aDMReport) then
    try
      aDMReport.ppDesigner.OnCloseQuery := ppDesignerCloseQuery;
      TemplateStream.Position := 0;
      try
        bDesign := (DesignReportType = drtDesign) or (DesignReportType = drtDuplicate);
        aDMReport.DesignReport(TemplateStream, bDesign);
      except
      end;
    finally
      FreeAndNil(aDMReport);
    end
  else
    ;
end;


procedure TfrmReportPrepSettings.ppDesignerCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  iRes: integer;
  sMessage: string;
begin
  if (DesignReportType = drtDuplicate) then
    iRes := TCommonUtils.ShowConfirmMessage(cTemplateDuplicate, [mbYes, mbNo, mbCancel])
  else if (DesignReportType = drtDesign) and (aDMReport.ppDesigner.Report.Modified) then
    iRes := TCommonUtils.ShowConfirmMessage(cTemplateSave, [mbYes, mbNo, mbCancel])
  else if (DesignReportType = drtNew) then
    iRes := TCommonUtils.ShowConfirmMessage(cTemplateNew, [mbYes, mbNo, mbCancel])
  else if bChangeName then
    iRes := TCommonUtils.ShowConfirmMessage(cReportRenamed, [mbYes, mbNo, mbCancel])
  else if bChangeDesc then
    iRes := TCommonUtils.ShowConfirmMessage(cReportDescRenamed, [mbYes, mbNo, mbCancel]);


  case iRes of
    mrYes: begin
        CanClose := SaveReportTemplate;
        aDMReport.ppDesigner.Report.Modified := CanClose;
    end;
    mrCancel:
      CanClose := false;
   else
    CanClose := true;
  end;
end;

function TfrmReportPrepSettings.SaveReportTemplate: boolean;
var
  tempTemplateBin: Binary;
  tempOptionsBin: Binary;
  bDesign: Boolean;
begin
  tempTemplateBin := nil;
  tempOptionsBin := nil;
  try
    tempTemplateBin := Binary.Create();
    tempOptionsBin := Binary.Create();
    with aDMReport do
    begin
      TemplateStream.Clear;
      TemplateStream.Position := 0;
      ppReport.Template.SaveToStream(TemplateStream);
      TemplateStream.Position := 0;
      tempTemplateBin.CopyFrom(TemplateStream, TemplateStream.Size);

      if OptionsStream <> nil then
      begin
        OptionsStream.Position := 0;
        tempOptionsBin.CopyFrom(OptionsStream, OptionsStream.Size);
      end;

      bDesign := DesignReportType = drtDesign;
      if bDesign then
        Result := ZasioVClient.UpdateReportTemplateData(
                                                      ZasioVClient.RfId,
                                                      ZasioVClient.RepName,
                                                      ZasioVClient.RepDesc,
                                                      ZasioVClient.RepAutoIndex,
                                                      ZasioVClient.RepUserIndex,
                                                      tempTemplateBin,
                                                      tempOptionsBin)
      else
        Result := ZasioVClient.InsertReport(
                                            ZasioVClient.RfId,
                                            ZasioVClient.RepName,
                                            ZasioVClient.RepDesc,
                                            tempTemplateBin,
                                            tempOptionsBin);
    end;
  finally
    if tempTemplateBin <> nil then
      tempTemplateBin.Free;

    if tempOptionsBin <> nil then
      tempOptionsBin.Free;
  end;
end;

end.
