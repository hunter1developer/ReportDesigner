object frameReportPrepSettings: TframeReportPrepSettings
  Left = 0
  Top = 0
  Width = 526
  Height = 240
  Color = clWhite
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlGroup: TPanel
    Left = 0
    Top = 0
    Width = 526
    Height = 240
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      526
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
    object rbTopCount: TRadioButton
      Left = 6
      Top = 78
      Width = 113
      Height = 17
      Caption = 'Number of rows:'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object rbWithoutData: TRadioButton
      Left = 6
      Top = 101
      Width = 171
      Height = 17
      Caption = 'Only column list, without data'
      TabOrder = 3
    end
    object rbSelectedIndexes: TRadioButton
      Left = 6
      Top = 124
      Width = 59
      Height = 17
      Caption = 'Where'
      TabOrder = 4
    end
    object edtIndexes: TEdit
      Left = 71
      Top = 124
      Width = 295
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      OnEnter = edtIndexesEnter
    end
    object edtReportName: TEdit
      Left = 79
      Top = 10
      Width = 287
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object edtReportDescription: TEdit
      Left = 105
      Top = 37
      Width = 261
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object edtTopCount: TEdit
      Left = 105
      Top = 74
      Width = 88
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      NumbersOnly = True
      TabOrder = 6
      OnEnter = edtTopCountEnter
    end
  end
end
