unit uSortOrderForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxBarBuiltInMenu, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, Vcl.ComCtrls, cxContainer,
  cxEdit, Vcl.Menus, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, cxCheckBox,
  Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxTreeView,
  cxPC, uGraphicsDataModule, uReportOptionsProcessor, uCustomReportDM,
  uOrganizationReportDM, uIntFolderReportDM, uMessageReportDM, uCitUpdatesReportDM,
  uReviewFlagReportDM, uResearchReportDM, uInterviewReportDM, uScheduleReportDM,
  uROTypes, uChangeRequestsReportDM;

type
  TfrmSortOrder = class(TForm)
    alReports: TActionList;
    aGenerate: TAction;
    aDesign: TAction;
    aRename: TAction;
    aDelete: TAction;
    aFieldIncludeToSortOrder: TAction;
    aFieldExcludeFromSortOrder: TAction;
    aFieldUpInSortOrder: TAction;
    aFieldDownInSortOrder: TAction;
    pnlButtonPlace: TPanel;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    pnlSortOrder: TPanel;
    lblPipelines: TLabel;
    cmbPipelines: TcxComboBox;
    lblAvailableFields: TLabel;
    btnFieldIncludeToSortOrder: TcxButton;
    btnFieldExcludeFromSortOrder: TcxButton;
    chbDescendingOrder: TcxCheckBox;
    lblSelectedFields: TLabel;
    btnFieldUpInSortOrder: TcxButton;
    btnFieldDownInSortOrder: TcxButton;
    tvSelectedFields: TcxTreeView;
    tvAvailableFields: TcxTreeView;
    actOk: TAction;
    actCancel: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure aFieldUpInSortOrderExecute(Sender: TObject);
    procedure aFieldUpInSortOrderUpdate(Sender: TObject);
    procedure aFieldDownInSortOrderUpdate(Sender: TObject);
    procedure aFieldDownInSortOrderExecute(Sender: TObject);
    procedure aFieldIncludeToSortOrderExecute(Sender: TObject);
    procedure aFieldExcludeFromSortOrderExecute(Sender: TObject);
    procedure aFieldIncludeToSortOrderUpdate(Sender: TObject);
    procedure aFieldExcludeFromSortOrderUpdate(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  private
    { Private declarations }
    fReportOptionsProcessor: TReportOptionsProcessor;
    fRfId: string;
    aDMReport: TdmCustomReport;
    FTemplateStream: TMemoryStream;

    function  CanFieldIncludeToSortOrder: boolean;
    function  CanFieldExcludeFromSortOrder: boolean;
    function  CanFieldUpInSortOrder: boolean;
    function  CanFieldDownInSortOrder: boolean;
  public
    { Public declarations }
    function  SaveReportOptions: boolean;
    procedure FillReportPipelineData(AName, AAlias: String; FieldNameList, FieldAliasList, FieldTypesList: TStringList);
    procedure FillSortOrderData;

    procedure SortOgranization;
    procedure SortIntFolders;
    procedure SortMessages;
    procedure SortCitUpdates;
    procedure SortReviewCitationsFlag;
    procedure SortReviewInterviewsFlag;
    procedure SortReviewMessagesFlag;
    procedure SortReviewShedulesFlag;
    procedure SortResearch;
    procedure SortInterview;
    procedure SortSchedule;
    procedure SortChangeRequests;

    property ReportOptionsProcessor: TReportOptionsProcessor read fReportOptionsProcessor write fReportOptionsProcessor;
    property RfId: string read fRfId write fRfId;
    property TemplateStream: TMemoryStream read FTemplateStream write FTemplateStream;
    property DMReport: TdmCustomReport read aDMReport;
  end;

var
  frmSortOrder: TfrmSortOrder;

implementation

{$R *.dfm}

uses
  uMainForm,
  uZasioVClient,
  uReportCommonClasses,
  uCommonUtils;

procedure TfrmSortOrder.actCancelExecute(Sender: TObject);
begin
//
end;

procedure TfrmSortOrder.actOkExecute(Sender: TObject);
begin
  try
    if not ZasioVClient.CheckSessionID then begin
      frmMain.TimerShow.Enabled := true;
      Exit;
    end;
  except
    frmMain.TimerShow.Enabled := true;
    Exit;
  end;
//
  SaveReportOptions;
end;

procedure TfrmSortOrder.aFieldDownInSortOrderExecute(Sender: TObject);
begin
  ReportOptionsProcessor.DownFieldInSortOrderStream;
end;

procedure TfrmSortOrder.aFieldDownInSortOrderUpdate(Sender: TObject);
begin
  TAction(sender).Enabled := CanFieldDownInSortOrder;
end;

procedure TfrmSortOrder.aFieldExcludeFromSortOrderExecute(Sender: TObject);
begin
  ReportOptionsProcessor.ExcludeFieldFromSortOrderStream;
end;

procedure TfrmSortOrder.aFieldExcludeFromSortOrderUpdate(Sender: TObject);
begin
  TAction(sender).Enabled := CanFieldExcludeFromSortOrder;
end;

procedure TfrmSortOrder.aFieldIncludeToSortOrderExecute(Sender: TObject);
begin
  ReportOptionsProcessor.IncludeFieldToSortOrderStream;
end;

procedure TfrmSortOrder.aFieldIncludeToSortOrderUpdate(Sender: TObject);
begin
  TAction(sender).Enabled := CanFieldIncludeToSortOrder;
end;

procedure TfrmSortOrder.aFieldUpInSortOrderExecute(Sender: TObject);
begin
  ReportOptionsProcessor.UpFieldInSortOrderStream;
end;

procedure TfrmSortOrder.aFieldUpInSortOrderUpdate(Sender: TObject);
begin
  TAction(sender).Enabled := CanFieldUpInSortOrder;
end;

function TfrmSortOrder.CanFieldDownInSortOrder: boolean;
begin
  Result := (tvSelectedFields.Selected <> nil) and (tvSelectedFields.Items.Count > 1) and
            (tvSelectedFields.Selected.Index < tvSelectedFields.Items.Count - 1);
end;

function TfrmSortOrder.CanFieldExcludeFromSortOrder: boolean;
begin
  Result := (tvSelectedFields.Selected <> nil);
end;

function TfrmSortOrder.CanFieldIncludeToSortOrder: boolean;
begin
  Result := (tvAvailableFields.Selected <> nil);
end;

function TfrmSortOrder.CanFieldUpInSortOrder: boolean;
begin
  Result := (tvSelectedFields.Selected <> nil) and (tvSelectedFields.Items.Count > 1) and
            (tvSelectedFields.Selected.Index > 0);
end;

procedure TfrmSortOrder.FillReportPipelineData(AName, AAlias: String;
  FieldNameList, FieldAliasList, FieldTypesList: TStringList);
var
  i: Integer;
begin
  if (AName <> '') and (AAlias <> '') then
    with ReportOptionsProcessor.ReportPipelines.Add do begin
      Name  := AName;
      Alias := AAlias;

      if (FieldNameList <> nil) and (FieldAliasList <> nil) and (FieldTypesList <> nil) and
         (FieldNameList.Count = FieldAliasList.Count) and (FieldNameList.Count = FieldtypesList.Count) then
        for i := 0 to FieldNameList.Count - 1 do
          if FieldTypesList[i] <> '' then
            FieldList.AddItem(FieldNameList[i], FieldAliasList[i], FieldTypesList[i]);
    end;
end;


procedure TfrmSortOrder.FillSortOrderData;
begin
  aDMReport := nil;
  ReportOptionsProcessor.ReportPipelines.ClearData;
  FillReportPipelineData('', '', nil, nil, nil);
  if RfId = 'ORGANIZATION' then SortOgranization
  else
  if RfId = 'INT_FOLDERS' then SortIntFolders
  else
  if RfId = 'MESSAGES' then SortMessages
  else
  if RfId = 'CIT_UPDATES' then SortCitUpdates
  else
  if RfId = 'RF_CIT' then SortReviewCitationsFlag
  else
  if RfId = 'RF_INT' then SortReviewInterviewsFlag
  else
  if RfId = 'RF_MSG' then SortReviewMessagesFlag
  else
  if RfId = 'RF_SCHED' then SortReviewShedulesFlag
  else
  if RfId = 'RESEARCH' then SortResearch
  else
  if RfId = 'INTERVIEWS' then SortInterview
  else
  if RfId = 'SCHEDULES' then SortSchedule
  else
  if RfId = 'CHANGE_REQUESTS' then SortChangeRequests
  else
  begin
    TCommonUtils.ShowInfoMessage('The template for this form is absent.');
    Exit;
  end;

  ReportOptionsProcessor.FillSortOrderVC;
  ReportOptionsProcessor.FillFieldsVCStream;
end;

procedure TfrmSortOrder.FormCreate(Sender: TObject);
begin
  fReportOptionsProcessor := TReportOptionsProcessor.Create(cmbPipelines,
         tvAvailableFields, tvSelectedFields, chbDescendingOrder);

  FTemplateStream := TMemoryStream.Create;
  FTemplateStream.Position := 0;
end;

procedure TfrmSortOrder.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fReportOptionsProcessor);

  if aDMReport <> nil then
    FreeAndNil(aDMReport);


  if FTemplateStream <> nil then
    FreeAndNil(FTemplateStream);
end;

procedure TfrmSortOrder.SortChangeRequests;
var
  str1, str2, str3, str4, str5, str6: string;
begin
  try
    aDMReport := TdmChangeRequestsReport.Create(Self);
    with TdmChangeRequestsReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str1 := TReportUtils.PreparePipelineSortOrderStr(ppChangeRequests.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppChangeRequests.UserName, 'ChangeRequests', FieldNamesCRsSP, FieldAliasCRsSP, FieldTypesCRsSP);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str2 := TReportUtils.PreparePipelineSortOrderStr(ppSchedPending.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppSchedPending.UserName, 'PendingSchedules', FieldNamesSchedPending, FieldAliasSchedPending, FieldTypesSchedPending);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str3 := TReportUtils.PreparePipelineSortOrderStr(ppAuthorizers.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppAuthorizers.UserName, 'Authorizers', FieldNamesAuthorizers, FieldAliasAuthorizers, FieldTypesAuthorizers);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str3 := TReportUtils.PreparePipelineSortOrderStr(ppRequestComments.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppAuthorizers.UserName, 'RequestComments', FieldNamesComments, FieldAliasComments, FieldTypesComments);


//SchedTitle
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str4 := TReportUtils.PreparePipelineSortOrderStr(ppSchedTitleO.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppSchedTitleO.UserName, 'OriginalSchedule', FieldNamesSchedTitleCRs, FieldAliasSchedTitleCRs, FieldTypesSchedTitleCRs);
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str5 := TReportUtils.PreparePipelineSortOrderStr(ppSchedTitleP.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppSchedTitleP.UserName, 'ProposedSchedule', FieldNamesSchedTitleCRs, FieldAliasSchedTitleCRs, FieldTypesSchedTitleCRs);

//Countries
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str4 := TReportUtils.PreparePipelineSortOrderStr(ppCountriesO.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppCountriesO.UserName, 'OriginalCountries', FieldNamesCountriesSub, FieldAliasCountriesSub, FieldTypesCountriesSub);
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str5 := TReportUtils.PreparePipelineSortOrderStr(ppCountriesP.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppCountriesP.UserName, 'ProposedCountries', FieldNamesCountriesSub, FieldAliasCountriesSub, FieldTypesCountriesSub);
//Citations
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str4 := TReportUtils.PreparePipelineSortOrderStr(ppCitationsO.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppCitationsO.UserName, 'OriginalCitations', FieldNamesCitationsSub, FieldAliasCitationsSub, FieldTypesCitationsSub);
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str5 := TReportUtils.PreparePipelineSortOrderStr(ppCitationsP.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppCitationsP.UserName, 'ProposedCitations', FieldNamesCitationsSub, FieldAliasCitationsSub, FieldTypesCitationsSub);
//UDFs
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str4 := TReportUtils.PreparePipelineSortOrderStr(ppUDFsO.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppUDFsO.UserName, 'OriginalUDFs', FieldNamesUDFs, FieldAliasUDFs, FieldTypesUDFs);
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str5 := TReportUtils.PreparePipelineSortOrderStr(ppUDFsP.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppUDFsP.UserName, 'ProposedUDFs', FieldNamesUDFs, FieldAliasUDFs, FieldTypesUDFs);
//Relation Items
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str4 := TReportUtils.PreparePipelineSortOrderStr(ppRelatedItemsO.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppRelatedItemsO.UserName, 'OriginalRelatedItems', FieldNamesRelatedItems, FieldAliasRelatedItems, FieldTypesRelatedItems);
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str5 := TReportUtils.PreparePipelineSortOrderStr(ppRelatedItemsP.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ppRelatedItemsP.UserName, 'ProposedRelatedItems', FieldNamesRelatedItems, FieldAliasRelatedItems, FieldTypesRelatedItems);
    end;
  finally
  end;

end;

procedure TfrmSortOrder.SortCitUpdates;
begin
  try
    aDMReport := TdmCitUpdatesReport.Create(Self);
    with TdmCitUpdatesReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        TReportUtils.PreparePipelineSortOrderStr(CitationsUpdates.UserName, ReportOptionsProcessor.ReportOptionsStream);

      FillReportPipelineData(CitationsUpdates.UserName, 'CitationsUpdates', FieldNamesCitUpdates, FieldAliasCitUpdates, FieldTypesCitUpdates);
    end;

  finally
  end;
end;

procedure TfrmSortOrder.SortInterview;
var
  str1, str2, str3: string;
begin
  try
    aDMReport := TdmInterviewReport.Create(Self);
    with TdmInterviewReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str1 := TReportUtils.PreparePipelineSortOrderStr(Interviews.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Interviews.UserName, 'Interviews', FieldNamesInterviews, FieldAliasInterviews, FieldTypesInterviews);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str2 := TReportUtils.PreparePipelineSortOrderStr(Citations.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Citations.UserName, 'Citations', FieldNamesCitations, FieldAliasCitations, FieldTypesCitations);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str3 := TReportUtils.PreparePipelineSortOrderStr(DefinedFields.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(DefinedFields.UserName, 'DefinedFields', FieldNamesUDFs, FieldAliasUDFs, FieldTypesUDFs);
    end;
  finally
  end;
end;

procedure TfrmSortOrder.SortSchedule;
var
  str1, str2, str3, str4, str5, str6: string;
begin
  try
    aDMReport := TdmScheduleReport.Create(Self);
    with TdmScheduleReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str1 := TReportUtils.PreparePipelineSortOrderStr(Schedules.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Schedules.UserName, 'Schedules', FieldNamesSchedules, FieldAliasSchedules, FieldTypesSchedules);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str2 := TReportUtils.PreparePipelineSortOrderStr(Citations.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Citations.UserName, 'Citations', FieldNamesCitations, FieldAliasCitations, FieldTypesCitations);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str3 := TReportUtils.PreparePipelineSortOrderStr(Interviews.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Interviews.UserName, 'Interviews', FieldNamesInterviews, FieldAliasInterviews, FieldTypesInterviews);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str4 := TReportUtils.PreparePipelineSortOrderStr(DefinedFields.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(DefinedFields.UserName, 'DefinedFields', FieldNamesUDFs, FieldAliasUDFs, FieldTypesUDFs);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str5 := TReportUtils.PreparePipelineSortOrderStr(Countries.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Countries.UserName, 'Countries', FieldNamesCountries, FieldAliasCountries, FieldTypesCountries);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str6 := TReportUtils.PreparePipelineSortOrderStr(RelatedItems.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(RelatedItems.UserName, 'RelatedItems', FieldNamesRelatedItems, FieldAliasRelatedItems, FieldTypesRelatedItems);
    end;
  finally
  end;

end;

procedure TfrmSortOrder.SortIntFolders;
begin
  try
    aDMReport := TdmIntFolderReport.Create(Self);
    with TdmIntFolderReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        TReportUtils.PreparePipelineSortOrderStr(IntFolders.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(IntFolders.UserName, 'InterviewFolders', FieldNamesIntFolders, FieldAliasIntFolders, FieldTypesIntFolders);
    end;

  finally
  end;
end;

procedure TfrmSortOrder.SortMessages;
begin
  try
    aDMReport := TdmMessageReport.Create(Self);
    with TdmMessageReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        TReportUtils.PreparePipelineSortOrderStr(Messages.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Messages.UserName, 'Messages', FieldNamesMessages, FieldAliasMessages, FieldTypesMessages);
    end;
  finally
  end;
end;

procedure TfrmSortOrder.SortOgranization;
var
  str1, str2, str3: string;
begin
  try
    aDMReport := TdmOrganizationReport.Create(Self);
    with TdmOrganizationReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str1 := TReportUtils.PreparePipelineSortOrderStr(Companies.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Companies.UserName, 'Companies', FieldNamesCompanies, FieldAliasCompanies, FieldTypesCompanies);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str2 := TReportUtils.PreparePipelineSortOrderStr(Departments.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Departments.UserName, 'Departments', FieldNamesDepts, FieldAliasDepts, FieldTypesDepts);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str3 := TReportUtils.PreparePipelineSortOrderStr(Users.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Users.UserName, 'Users', FieldNamesUsers, FieldAliasUsers, FieldTypesUsers);
    end;
  finally
  end;
end;


procedure TfrmSortOrder.SortResearch;
var
  str1, str2, str3, str4: string;
begin
  try
    aDMReport := TdmResearchReport.Create(Self);
    with TdmResearchReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str1 := TReportUtils.PreparePipelineSortOrderStr(Citations.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(Citations.UserName, 'Citations', FieldNamesCitations, FieldAliasCitations, FieldTypesCitations);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str2 := TReportUtils.PreparePipelineSortOrderStr(CitTextHeading.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(CitTextHeading.UserName, 'CitTextHeading', FieldNamesCitText, FieldAliasCitText, FieldTypesCitText);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str3 := TReportUtils.PreparePipelineSortOrderStr(CitBusAct.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(CitBusAct.UserName, 'CitBusAct', FieldNamesCitBusAct, FieldAliasCitBusAct, FieldTypesCitBusAct);

      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        str4 := TReportUtils.PreparePipelineSortOrderStr(CitSchedules.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(CitSchedules.UserName, 'CitSchedules', FieldNamesSchedules, FieldAliasSchedules, FieldTypesSchedules);
    end;
  finally
  end;
end;

procedure TfrmSortOrder.SortReviewCitationsFlag;
begin
  try
    aDMReport := TdmReviewFlagReport.CreateWithType(Self, 0);
    with TdmReviewFlagReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        TReportUtils.PreparePipelineSortOrderStr(ReviewFlags.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ReviewFlags.UserName, 'ReviewFlags', FieldNamesRFs, FieldAliasRFs, FieldTypesRFs);
    end;
  finally
  end;
end;

procedure TfrmSortOrder.SortReviewInterviewsFlag;
begin
  try
    aDMReport := TdmReviewFlagReport.CreateWithType(Self, 2);
    with TdmReviewFlagReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        TReportUtils.PreparePipelineSortOrderStr(ReviewFlags.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ReviewFlags.UserName, 'ReviewFlags', FieldNamesRFs, FieldAliasRFs, FieldTypesRFs);
    end;
  finally
  end;
end;

procedure TfrmSortOrder.SortReviewMessagesFlag;
begin
  try
    aDMReport := TdmReviewFlagReport.CreateWithType(Self, 3);
    with TdmReviewFlagReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        TReportUtils.PreparePipelineSortOrderStr(ReviewFlags.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ReviewFlags.UserName, 'ReviewFlags', FieldNamesRFs, FieldAliasRFs, FieldTypesRFs);
    end;
  finally
  end;
end;

procedure TfrmSortOrder.SortReviewShedulesFlag;
begin
  try
    aDMReport := TdmReviewFlagReport.CreateWithType(Self, 1);
    with TdmReviewFlagReport(aDMReport) do
    begin
      if TReportOptionsProcessor.ReportOptionsStream.Size <> 0  then
        TReportUtils.PreparePipelineSortOrderStr(ReviewFlags.UserName, ReportOptionsProcessor.ReportOptionsStream);
      FillReportPipelineData(ReviewFlags.UserName, 'ReviewFlags', FieldNamesRFs, FieldAliasRFs, FieldTypesRFs);
    end;
  finally
  end;
end;


function TfrmSortOrder.SaveReportOptions: boolean;
var
  tempTemplateBin: Binary;
  tempOptionsBin: Binary;
begin
  tempTemplateBin := nil;
  tempOptionsBin := nil;
  try
    tempTemplateBin := Binary.Create();
    tempOptionsBin := Binary.Create();
    with aDMReport do
    begin
      TemplateStream.Position := 0;

      if TemplateStream <> nil then
        tempTemplateBin.CopyFrom(TemplateStream, TemplateStream.Size);

      if TReportOptionsProcessor.ReportOptionsStream <> nil then
      begin
        TReportOptionsProcessor.ReportOptionsStream.Position := 0;
        tempOptionsBin.CopyFrom(TReportOptionsProcessor.ReportOptionsStream, TReportOptionsProcessor.ReportOptionsStream.Size);
      end;

        tempTemplateBin.Position := 0;
        tempOptionsBin.Position := 0;
        Result := ZasioVClient.UpdateReportTemplateData(
                                                      ZasioVClient.RfId,
                                                      ZasioVClient.RepName,
                                                      ZasioVClient.RepDesc,
                                                      ZasioVClient.RepAutoIndex,
                                                      ZasioVClient.RepUserIndex,
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
