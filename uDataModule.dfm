object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 825
  Width = 1140
  object rdaComp: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportCompData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 128
    Top = 16
  end
  object BinDataStreamer: TDABinDataStreamer
    Left = 48
    Top = 352
  end
  object dsComp: TDADataSource
    DataSet = tblComp.Dataset
    DataTable = tblComp
    Left = 72
    Top = 16
  end
  object tblComp: TDAMemDataTable
    Fields = <>
    LogicalName = 'COMPANY_PRINT'
    Params = <>
    RemoteDataAdapter = rdaComp
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 16
    Top = 16
  end
  object rdaDept: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetSubReportDeptData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CompId'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaDeptBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaDeptBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 128
    Top = 72
  end
  object dsDept: TDADataSource
    DataSet = tblDept.Dataset
    DataTable = tblDept
    Left = 72
    Top = 72
  end
  object tblDept: TDAMemDataTable
    Fields = <>
    LogicalName = 'DEPTS_PRINT'
    MasterSource = dsComp
    Params = <>
    RemoteDataAdapter = rdaDept
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 16
    Top = 72
  end
  object rdaUsers: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetSubReportUserData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CompId'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaUsersBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaUsersBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 128
    Top = 128
  end
  object dsUsers: TDADataSource
    DataSet = tblUsers.Dataset
    DataTable = tblUsers
    Left = 72
    Top = 128
  end
  object tblUsers: TDAMemDataTable
    Fields = <>
    LogicalName = 'USERS_PRINT'
    MasterSource = dsComp
    Params = <>
    RemoteDataAdapter = rdaUsers
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 16
    Top = 128
  end
  object rdaIntFolder: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportIntFolderData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 280
    Top = 16
  end
  object tblMaster: TDAMemDataTable
    Fields = <>
    LogicalName = 'INTF_PRINT'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 152
    Top = 264
  end
  object rdaMessages: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportMessagesData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 280
    Top = 80
  end
  object rdaCitUpdates: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportCitUpdatesData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 280
    Top = 144
  end
  object rdaReviewCitationsFlag: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportReviewCitationsFlagData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 416
    Top = 16
  end
  object rdaReviewInterviewsFlag: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportReviewInterviewsFlagData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 416
    Top = 72
  end
  object rdaReviewMessagesFlag: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportReviewMessagesFlagData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 416
    Top = 128
  end
  object rdaReviewShedulesFlag: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportReviewShedulesFlagData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 416
    Top = 184
  end
  object rdaResearchCitations: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportResearchCitationsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 584
    Top = 16
  end
  object rdaResearchCitationsMemos: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportResearchCitationsMemosData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CitIndex'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaResearchCitationsMemosBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaResearchCitationsMemosBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 584
    Top = 72
  end
  object rdaResearchCitationsBusacts: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportResearchCitationsBusactsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CitIndex'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaResearchCitationsMemosBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaResearchCitationsMemosBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 584
    Top = 128
  end
  object rdaResearchCitationsSchedules: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportResearchCitationsSchedulesData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CitIndex'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaResearchCitationsMemosBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaResearchCitationsMemosBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 584
    Top = 184
  end
  object rdaInterviews: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportInterviewsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 736
    Top = 16
  end
  object rdaCitations: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportCitationsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'IntAutoIndex'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCitationsBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCitationsBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 736
    Top = 72
  end
  object rdaDefinedFields: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportDefinedFieldsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'RecordIndex'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaDefinedFieldsBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaDefinedFieldsBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 736
    Top = 128
  end
  object tblSubReport1: TDAMemDataTable
    Fields = <>
    LogicalName = 'INTF_PRINT'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 240
    Top = 264
  end
  object tblSubReport2: TDAMemDataTable
    Fields = <>
    LogicalName = 'INTF_PRINT'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 336
    Top = 264
  end
  object tblSubReport3: TDAMemDataTable
    Fields = <>
    LogicalName = 'INTF_PRINT'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 448
    Top = 264
  end
  object tblSubReport4: TDAMemDataTable
    Fields = <>
    LogicalName = 'INTF_PRINT'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 560
    Top = 264
  end
  object tblSubReport5: TDAMemDataTable
    Fields = <>
    LogicalName = 'INTF_PRINT'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 664
    Top = 264
  end
  object rdaScheduleShedules: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportScheduleSchedulesData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 1032
    Top = 16
  end
  object rdaScheduleCitations: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportScheduleCitationData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SchedIndex'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaScheduleCitationsBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaScheduleCitationsBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 1032
    Top = 72
  end
  object rdaScheduleInterviews: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportScheduleInterviewsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'IntSchedIndex'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaScheduleInterviewsBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaScheduleInterviewsBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 1032
    Top = 128
  end
  object rdaScheduleDefinedFields: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportScheduleDefinesFieldsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'RecordIndex'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaScheduleDefinedFieldsBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaScheduleDefinedFieldsBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 1032
    Top = 184
  end
  object rdaScheduleCountries: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportScheduleCountriesData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SchedIndex'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaScheduleCountriesBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaScheduleCountriesBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 1032
    Top = 248
  end
  object rdaScheduleCitText: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportScheduleCitTextData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CitIndex'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaScheduleCitTextBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaScheduleCitTextBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 1032
    Top = 304
  end
  object rdaChangeRequests: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'TopCount'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'MasterIndexesStrList'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 184
    Top = 360
  end
  object rdaChangeRequestsAuthorizers: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsAuthorizersData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CRIndex'
        DataType = rtInteger
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsAuthorizersBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsAuthorizersBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 528
    Top = 360
  end
  object rdaChangeRequestsSchedulePending: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsSchedulePendingData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CRIndex'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsSchedulePendingBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsSchedulePendingBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 344
    Top = 360
  end
  object rdaChangeRequestsCountriesO: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsScheduleCountriesData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CRIndex'
        DataType = rtInteger
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SchedIndex'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsCountriesOBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsCountriesOBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 352
    Top = 440
  end
  object tblSubReportCountriesO: TDAMemDataTable
    Fields = <>
    LogicalName = 'Table'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 352
    Top = 496
  end
  object rdaChangeRequestsCitationsO: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsScheduleCitationsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SchedIndex'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsCitationsOBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsCitationsOBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 536
    Top = 440
  end
  object tblSubReportCitationsO: TDAMemDataTable
    Fields = <>
    LogicalName = 'Table'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 536
    Top = 496
  end
  object rdaChangeRequestsSchedTitleO: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsScheduleData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SchedIndex'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsSchedTitleOBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsSchedTitleOBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 176
    Top = 440
  end
  object tblSubReportSchedTitleO: TDAMemDataTable
    Fields = <>
    LogicalName = 'Table'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 176
    Top = 496
  end
  object rdaChangeRequestsUDFsO: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsUDFsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'SchedIndex'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsUDFsOBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsUDFsOBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 704
    Top = 440
  end
  object tblSubReportUDFsO: TDAMemDataTable
    Fields = <>
    LogicalName = 'Table'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 704
    Top = 496
  end
  object rdaChangeRequestsCountriesP: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsScheduleCountriesData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CRIndex'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'SchedIndex'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsCountriesPBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsCountriesPBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 344
    Top = 592
  end
  object tblSubReportCountriesP: TDAMemDataTable
    Fields = <>
    LogicalName = 'Table'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 344
    Top = 648
  end
  object rdaChangeRequestsSchedTitleP: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsScheduleData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SchedIndex'
        DataType = rtInteger
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
        Value = Null
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsSchedTitlePBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsSchedTitlePBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 176
    Top = 600
  end
  object tblSubReportSchedTitleP: TDAMemDataTable
    Fields = <>
    LogicalName = 'Table'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 176
    Top = 648
  end
  object rdaChangeRequestsCitationsP: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsScheduleCitationsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SchedIndex'
        DataType = rtInteger
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
        Value = Null
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsCitationsPBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsCitationsPBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 528
    Top = 592
  end
  object tblSubReportCitationsP: TDAMemDataTable
    Fields = <>
    LogicalName = 'Table'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 528
    Top = 648
  end
  object rdaChangeRequestsUDFsP: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsUDFsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SchedIndex'
        DataType = rtInteger
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
        Value = Null
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsUDFsPBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsUDFsPBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 704
    Top = 584
  end
  object tblSubReportUDFsP: TDAMemDataTable
    Fields = <>
    LogicalName = 'Table'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 704
    Top = 648
  end
  object rdaChangeRequestsComments: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsRequestComments'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'CRIndex'
        DataType = rtInteger
        Flag = fIn
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsCommentsBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsCommentsBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 700
    Top = 360
  end
  object rdaInterview_UDF: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportInterviewUDFsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 1064
    Top = 504
  end
  object rdaSchedule_UDF: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportScheduleUDFsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
        Value = Null
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaCompBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaCompBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 1064
    Top = 564
  end
  object rdaScheduleRelatedItems: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportScheduleRelatedItemsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'RelatedSchedIndexPar'
        DataType = rtWidestring
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaScheduleRelatedItemsBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaScheduleRelatedItemsBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 1032
    Top = 376
  end
  object rdaChangeRequestsRelationsItemsO: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsRelatedItemsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'RelatedSchedIndexPar'
        DataType = rtWidestring
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsRelationsItemsOBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsRelationsItemsOBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 872
    Top = 440
  end
  object tblSubReportRelationsItemsO: TDAMemDataTable
    Fields = <>
    LogicalName = 'Table'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 872
    Top = 496
  end
  object rdaChangeRequestsRelationsItemsP: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.RemoteService = ZasioVClient.RemoteService
    GetDataCall.MethodName = 'RDA_GetReportChangeRequestsRelatedItemsData'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SessionID'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'RelatedSchedIndexPar'
        DataType = rtWidestring
        Flag = fIn
        Value = Null
      end
      item
        Name = 'SortOrder'
        DataType = rtWidestring
        Flag = fIn
      end
      item
        Name = 'ResultReport'
        DataType = rtUserDefined
        Flag = fOut
        TypeName = 'roReportResult'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = ZasioVClient.RemoteService
    GetScriptsCall.RemoteService = ZasioVClient.RemoteService
    RemoteService = ZasioVClient.RemoteService
    DataStreamer = BinDataStreamer
    OnBeforeGetDataCall = rdaChangeRequestsRelationsItemsPBeforeGetDataCall
    OnAfterGetDataCall = rdaAfterGetDataCall
    BeforeGetDataCall = rdaChangeRequestsRelationsItemsPBeforeGetDataCall
    AfterGetDataCall = rdaAfterGetDataCall
    Left = 880
    Top = 584
  end
  object tblSubReportRelationsItemsP: TDAMemDataTable
    Fields = <>
    LogicalName = 'Table'
    Params = <>
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
    IndexDefs = <>
    Left = 880
    Top = 648
  end
end
