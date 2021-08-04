unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, uZasioVClient, IPPeerClient,
  uROChannelAwareComponent, uRORemoteService, uDABin2DataStreamer,
  uDADataStreamer, uDABinAdapter, uROComponent, uDADataTable, uDADataAdapter,
  uDARemoteDataAdapter, uDAScriptingProvider, uDAMemDataTable, Data.DB,
  uDAFields, uRODynamicRequest, uReportCommonClasses, uReportOptionsProcessor,
  Dialogs, uCommonUtils, VReportServiceLibrary_Intf, uROTypes, uDADelta,
  uDAInterfaces;

type
  TdmMain = class(TDataModule)
    rdaComp: TDARemoteDataAdapter;
    BinDataStreamer: TDABinDataStreamer;
    dsComp: TDADataSource;
    tblComp: TDAMemDataTable;
    rdaDept: TDARemoteDataAdapter;
    dsDept: TDADataSource;
    tblDept: TDAMemDataTable;
    rdaUsers: TDARemoteDataAdapter;
    dsUsers: TDADataSource;
    tblUsers: TDAMemDataTable;
    rdaIntFolder: TDARemoteDataAdapter;
    tblMaster: TDAMemDataTable;
    rdaMessages: TDARemoteDataAdapter;
    rdaCitUpdates: TDARemoteDataAdapter;
    rdaReviewCitationsFlag: TDARemoteDataAdapter;
    rdaReviewMessagesFlag: TDARemoteDataAdapter;
    rdaReviewShedulesFlag: TDARemoteDataAdapter;
    rdaReviewInterviewsFlag: TDARemoteDataAdapter;
    rdaResearchCitations: TDARemoteDataAdapter;
    rdaResearchCitationsMemos: TDARemoteDataAdapter;
    rdaResearchCitationsBusacts: TDARemoteDataAdapter;
    rdaResearchCitationsSchedules: TDARemoteDataAdapter;
    rdaInterviews: TDARemoteDataAdapter;
    rdaCitations: TDARemoteDataAdapter;
    rdaDefinedFields: TDARemoteDataAdapter;
    tblSubReport1: TDAMemDataTable;
    tblSubReport2: TDAMemDataTable;
    tblSubReport3: TDAMemDataTable;
    tblSubReport4: TDAMemDataTable;
    tblSubReport5: TDAMemDataTable;
    rdaScheduleShedules: TDARemoteDataAdapter;
    rdaScheduleCitations: TDARemoteDataAdapter;
    rdaScheduleInterviews: TDARemoteDataAdapter;
    rdaScheduleDefinedFields: TDARemoteDataAdapter;
    rdaScheduleCountries: TDARemoteDataAdapter;
    rdaScheduleCitText: TDARemoteDataAdapter;
    rdaChangeRequests: TDARemoteDataAdapter;
    rdaChangeRequestsAuthorizers: TDARemoteDataAdapter;
    rdaChangeRequestsSchedulePending: TDARemoteDataAdapter;
    rdaChangeRequestsCountriesO: TDARemoteDataAdapter;
    tblSubReportCountriesO: TDAMemDataTable;
    rdaChangeRequestsCitationsO: TDARemoteDataAdapter;
    tblSubReportCitationsO: TDAMemDataTable;
    rdaChangeRequestsSchedTitleO: TDARemoteDataAdapter;
    tblSubReportSchedTitleO: TDAMemDataTable;
    rdaChangeRequestsUDFsO: TDARemoteDataAdapter;
    tblSubReportUDFsO: TDAMemDataTable;
    rdaChangeRequestsCountriesP: TDARemoteDataAdapter;
    tblSubReportCountriesP: TDAMemDataTable;
    rdaChangeRequestsSchedTitleP: TDARemoteDataAdapter;
    tblSubReportSchedTitleP: TDAMemDataTable;
    rdaChangeRequestsCitationsP: TDARemoteDataAdapter;
    tblSubReportCitationsP: TDAMemDataTable;
    rdaChangeRequestsUDFsP: TDARemoteDataAdapter;
    tblSubReportUDFsP: TDAMemDataTable;
    rdaChangeRequestsComments: TDARemoteDataAdapter;
    rdaInterview_UDF: TDARemoteDataAdapter;
    rdaSchedule_UDF: TDARemoteDataAdapter;
    rdaScheduleRelatedItems: TDARemoteDataAdapter;
    rdaChangeRequestsRelationsItemsO: TDARemoteDataAdapter;
    tblSubReportRelationsItemsO: TDAMemDataTable;
    rdaChangeRequestsRelationsItemsP: TDARemoteDataAdapter;
    tblSubReportRelationsItemsP: TDAMemDataTable;
    procedure rdaCompBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaDeptBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaUsersBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaResearchCitationsMemosBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaCitationsBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaDefinedFieldsBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaScheduleCitationsBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaScheduleInterviewsBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaScheduleDefinedFieldsBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaScheduleCountriesBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaScheduleCitTextBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

    procedure rdaAfterGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsCountriesOBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsCitationsOBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsUDFsOBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsSchedulePendingBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsAuthorizersBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsCountriesPBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsSchedTitleOBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsSchedTitlePBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsCitationsPBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsUDFsPBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsCommentsBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaScheduleRelatedItemsBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsRelationsItemsOBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
    procedure rdaChangeRequestsRelationsItemsPBeforeGetDataCall(Sender: TObject;
      Request: TRODynamicRequest);
  private
    FOptionsStream: TMemoryStream;
    { Private declarations }
  public
    { Public declarations }
    property OptionsStreamDM: TMemoryStream read FOptionsStream write FOptionsStream;
  end;

var
  dmMain: TdmMain;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  FOptionsStream := TMemoryStream.Create;
end;

procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  if FOptionsStream <> nil then
    FreeAndNil(FOptionsStream);
end;


procedure TdmMain.rdaChangeRequestsAuthorizersBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('CRIndex') <> nil then
      GetDataCall.ParamByName('CRIndex').AsString := tblMaster.FieldByName('CR_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsAuthorizers' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Authorizers', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsCitationsOBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('SchedIndex') <> nil then
      GetDataCall.ParamByName('SchedIndex').AsString :=  tblSubReport1.FieldByName('SP_SHOW_SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsCitationsO' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('OriginalCitations', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsCitationsPBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('SchedIndex') <> nil then
      GetDataCall.ParamByName('SchedIndex').AsString :=  tblSubReport1.FieldByName('SP_PENDING_SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsCitationsP' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('ProposedCitations', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsCommentsBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('CRIndex') <> nil then
      GetDataCall.ParamByName('CRIndex').AsString := tblMaster.FieldByName('CR_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsComments' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('RequestComments', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsCountriesOBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('SchedIndex') <> nil then
      GetDataCall.ParamByName('SchedIndex').AsString := tblSubReport1.FieldByName('SP_SHOW_SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('CRIndex') <> nil then
      GetDataCall.ParamByName('CRIndex').AsString :=  tblSubReport1.FieldByName('SP_CR_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsCountriesO' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('OriginalCountries', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsCountriesPBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('SchedIndex') <> nil then
      GetDataCall.ParamByName('SchedIndex').AsString := tblSubReport1.FieldByName('SP_PENDING_SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('CRIndex') <> nil then
      GetDataCall.ParamByName('CRIndex').AsString :=  tblSubReport1.FieldByName('SP_CR_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsCountriesP' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('ProposedCountries', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsRelationsItemsOBeforeGetDataCall(
  Sender: TObject; Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('RelatedSchedIndexPar') <> nil then
      GetDataCall.ParamByName('RelatedSchedIndexPar').AsString :=  tblSubReport1.FieldByName('SP_SHOW_SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsRelationsItemsO' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('OriginalRelatedItems', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsRelationsItemsPBeforeGetDataCall(
  Sender: TObject; Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('RelatedSchedIndexPar') <> nil then
      GetDataCall.ParamByName('RelatedSchedIndexPar').AsString :=  tblSubReport1.FieldByName('SP_PENDING_SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsRelationsItemsP' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('ProposedRelatedItems', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsSchedTitlePBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('SchedIndex') <> nil then
      GetDataCall.ParamByName('SchedIndex').AsString := tblSubReport1.FieldByName('SP_PENDING_SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsSchedTitleP' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('ProposedSchedule', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsSchedulePendingBeforeGetDataCall(
  Sender: TObject; Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('CRIndex') <> nil then
      GetDataCall.ParamByName('CRIndex').AsString := tblMaster.FieldByName('CR_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsSchedulePending' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('PendingSchedules', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsSchedTitleOBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('SchedIndex') <> nil then
      GetDataCall.ParamByName('SchedIndex').AsString := tblSubReport1.FieldByName('SP_SHOW_SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsSchedTitleO' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('OriginalSchedule', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsUDFsOBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('SchedIndex') <> nil then
      GetDataCall.ParamByName('SchedIndex').AsString :=  tblSubReport1.FieldByName('SP_SHOW_SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsUDFsO' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('OriginalUDFs', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaChangeRequestsUDFsPBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('SchedIndex') <> nil then
      GetDataCall.ParamByName('SchedIndex').AsString :=  tblSubReport1.FieldByName('SP_PENDING_SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequestsUDFsP' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('ProposedUDFs', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaCitationsBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('IntAutoIndex') <> nil then
      GetDataCall.ParamByName('IntAutoIndex').AsString := tblMaster.FieldByName('INT_AUTO_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaCitations' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Citations', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaCompBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('TopCount') <> nil then
      GetDataCall.ParamByName('TopCount').AsInteger := ZasioVClient.TopCount;


    if GetDataCall.Params.FindParam('MasterIndexesStrList') <> nil then
      GetDataCall.ParamByName('MasterIndexesStrList').AsString := ZasioVClient.IndexList;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaComp' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Companies', OptionsStreamDM);

      if TDARemoteDataAdapter(Sender).Name = 'rdaIntFolder' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('InterviewFolders', OptionsStreamDM);
      if TDARemoteDataAdapter(Sender).Name = 'rdaMessages' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Messages', OptionsStreamDM);
      if TDARemoteDataAdapter(Sender).Name = 'rdaCitUpdates' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('CitationsUpdates', OptionsStreamDM);

      if TDARemoteDataAdapter(Sender).Name = 'rdaReviewCitationsFlag' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('ReviewFlags', OptionsStreamDM);
      if TDARemoteDataAdapter(Sender).Name = 'rdaReviewInterviewsFlag' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('ReviewFlags', OptionsStreamDM);
      if TDARemoteDataAdapter(Sender).Name = 'rdaReviewMessagesFlag' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('ReviewFlags', OptionsStreamDM);
      if TDARemoteDataAdapter(Sender).Name = 'rdaReviewShedulesFlag' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('ReviewFlags', OptionsStreamDM);

      if TDARemoteDataAdapter(Sender).Name = 'rdaResearchCitations' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Citations', OptionsStreamDM);

      if TDARemoteDataAdapter(Sender).Name = 'rdaInterviews' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Interviews', OptionsStreamDM);

      if TDARemoteDataAdapter(Sender).Name = 'rdaScheduleShedules' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Schedules', OptionsStreamDM);

      if TDARemoteDataAdapter(Sender).Name = 'rdaChangeRequests' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('ChangeRequests', OptionsStreamDM);
    end;
  end;
end;


procedure TdmMain.rdaDefinedFieldsBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('RecordIndex') <> nil then
      GetDataCall.ParamByName('RecordIndex').AsString :=  tblSubReport2.FieldByName('RECORD_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;
      if TDARemoteDataAdapter(Sender).Name = 'rdaDefinedFields' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('DefinedFields', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaDeptBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('CompId') <> nil then
      GetDataCall.ParamByName('CompId').AsString := tblMaster.FieldByName('COMP_ID').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Departments', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaAfterGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
const
  cCode = 'Server returns error with message text: %s';
var
  resReport: roReportResult;
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if (GetDataCall.Params.FindParam('ResultReport') <> nil) then begin
      resReport := GetDataCall.ParamByName('ResultReport').AsComplexType as roReportResult;
      if (resReport.ResultCode > 0) then
        TCommonUtils.ShowErrorMessage(Format(cCode, [resReport.ResultMsg]));
    end;
  end;
end;

procedure TdmMain.rdaResearchCitationsMemosBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('CitIndex') <> nil then
      GetDataCall.ParamByName('CitIndex').AsString := tblMaster.FieldByName('CIT_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaResearchCitationsMemos' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('CitTextHeading', OptionsStreamDM);
      if TDARemoteDataAdapter(Sender).Name = 'rdaResearchCitationsBusacts' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('CitBusAct', OptionsStreamDM);
      if TDARemoteDataAdapter(Sender).Name = 'rdaResearchCitationsSchedules' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('CitSchedules', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaScheduleCitationsBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('SchedIndex') <> nil then
      GetDataCall.ParamByName('SchedIndex').AsString :=  tblMaster.FieldByName('SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaScheduleCitations' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Citations', OptionsStreamDM);

    end;
  end;
end;

procedure TdmMain.rdaScheduleCitTextBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('CitIndex') <> nil then
      GetDataCall.ParamByName('CitIndex').AsString :=  '';

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
      GetDataCall.ParamByName('SortOrder').AsString := ZasioVClient.SortOrder;
  end;
end;

procedure TdmMain.rdaScheduleCountriesBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('SchedIndex') <> nil then
      GetDataCall.ParamByName('SchedIndex').AsString :=  tblMaster.FieldByName('SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaScheduleCountries' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Countries', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaScheduleDefinedFieldsBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('RecordIndex') <> nil then
      GetDataCall.ParamByName('RecordIndex').AsString :=  tblMaster.FieldByName('SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaScheduleDefinedFields' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('DefinedFields', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaScheduleInterviewsBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('IntSchedIndex') <> nil then
      GetDataCall.ParamByName('IntSchedIndex').AsString :=  tblMaster.FieldByName('SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaScheduleInterviews' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Interviews', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaScheduleRelatedItemsBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('RelatedSchedIndexPar') <> nil then
      GetDataCall.ParamByName('RelatedSchedIndexPar').AsString :=  tblMaster.FieldByName('SCHED_INDEX').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      if TDARemoteDataAdapter(Sender).Name = 'rdaScheduleRelatedItems' then
        GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('RelatedItems', OptionsStreamDM);
    end;
  end;
end;

procedure TdmMain.rdaUsersBeforeGetDataCall(Sender: TObject;
  Request: TRODynamicRequest);
begin
  with TDARemoteDataAdapter(Sender) do
  begin
    if GetDataCall.Params.FindParam('SessionID') <> nil then
      GetDataCall.ParamByName('SessionID').AsString := ZasioVClient.SessionID;

    if GetDataCall.Params.FindParam('CompId') <> nil then
      GetDataCall.ParamByName('CompId').AsString := tblMaster.FieldByName('COMP_ID').AsString;

    if GetDataCall.Params.FindParam('SortOrder') <> nil then
    begin
      if (OptionsStreamDM <> nil) and (OptionsStreamDM.Size = 0) then
      begin
        GetDataCall.ParamByName('SortOrder').AsString := '';
        Exit;
      end;

      GetDataCall.ParamByName('SortOrder').AsString := TReportUtils.PreparePipelineSortOrderStr('Users', OptionsStreamDM);
    end;
  end;
end;

end.
