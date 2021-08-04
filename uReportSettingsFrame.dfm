object frameReportSettings: TframeReportSettings
  Left = 0
  Top = 0
  Width = 532
  Height = 240
  Color = clWhite
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlGroup: TPanel
    Left = 0
    Top = 0
    Width = 532
    Height = 240
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      532
      240)
    object lblReportName: TLabel
      Left = 6
      Top = 13
      Width = 67
      Height = 13
      Caption = 'Report Name:'
    end
    object lblReportDescription: TLabel
      Left = 6
      Top = 40
      Width = 93
      Height = 13
      Caption = 'Report Description:'
    end
    object edtReportName: TEdit
      Left = 105
      Top = 10
      Width = 267
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object edtReportDescription: TEdit
      Left = 105
      Top = 37
      Width = 267
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
  end
end
