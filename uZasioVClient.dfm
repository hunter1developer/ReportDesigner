object ZasioVClient: TZasioVClient
  OldCreateOrder = False
  Height = 375
  Width = 318
  object RemoteService: TRORemoteService
    ServiceName = 'ReportService'
    Channel = HTTPChannel
    Message = BinMessage
    Left = 40
    Top = 64
  end
  object BinMessage: TROBinMessage
    Envelopes = <
      item
        Envelope = EncryptionEnvelope
      end>
    Left = 40
    Top = 120
  end
  object HTTPChannel: TROIndyHTTPChannel
    UserAgent = 'RemObjects SDK'
    DispatchOptions = []
    ServerLocators = <>
    TargetUrl = 'http://127.0.0.1:24471/bin'
    IndyClient.AllowCookies = True
    IndyClient.ProxyParams.BasicAuthentication = False
    IndyClient.ProxyParams.ProxyPort = 0
    IndyClient.Request.Connection = 'keep-alive'
    IndyClient.Request.ContentLength = -1
    IndyClient.Request.ContentRangeEnd = -1
    IndyClient.Request.ContentRangeStart = -1
    IndyClient.Request.ContentRangeInstanceLength = -1
    IndyClient.Request.ContentType = 'application/binary'
    IndyClient.Request.Accept = 'text/html, */*'
    IndyClient.Request.AcceptEncoding = 'identity'
    IndyClient.Request.BasicAuthentication = False
    IndyClient.Request.Host = '127.0.0.1:24471'
    IndyClient.Request.UserAgent = 'RemObjects SDK'
    IndyClient.Request.Ranges.Units = 'bytes'
    IndyClient.Request.Ranges = <>
    IndyClient.HTTPOptions = [hoForceEncodeParams]
    Left = 40
    Top = 16
  end
  object EncryptionEnvelope: TROAESEncryptionEnvelope
    EnvelopeMarker = 'AES'
    Password = '{4E8F8EAF-EEA6-4678-90C4-70F7DF1321EB}'
    Left = 40
    Top = 174
  end
end
