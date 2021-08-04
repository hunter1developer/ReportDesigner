object frmReportPrepSettings: TfrmReportPrepSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Report Settings'
  ClientHeight = 199
  ClientWidth = 425
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 159
    Width = 425
    Height = 40
    Align = alBottom
    BevelEdges = [beLeft, beRight, beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      421
      38)
    object btnCancel: TButton
      Left = 340
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOk: TButton
      Left = 259
      Top = 7
      Width = 75
      Height = 25
      Action = actnOk
      Anchors = [akTop, akRight]
      Default = True
      TabOrder = 1
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 159
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    inline frmReportPrepSettings: TframeReportPrepSettings
      Left = 0
      Top = 0
      Width = 421
      Height = 155
      Align = alClient
      Color = clWhite
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitWidth = 421
      ExplicitHeight = 155
      inherited pnlGroup: TPanel
        Width = 421
        Height = 155
        ExplicitWidth = 421
        ExplicitHeight = 155
        inherited lblReportDescription: TLabel
          Top = 43
          ExplicitTop = 43
        end
        inherited rbTopCount: TRadioButton
          Top = 72
          Width = 112
          Checked = False
          TabStop = False
          ExplicitTop = 72
          ExplicitWidth = 112
        end
        inherited rbWithoutData: TRadioButton
          Top = 95
          Width = 170
          Checked = True
          TabStop = True
          ExplicitTop = 95
          ExplicitWidth = 170
        end
        inherited rbSelectedIndexes: TRadioButton
          Top = 118
          Width = 93
          Caption = 'Index List'
          ExplicitTop = 118
          ExplicitWidth = 93
        end
        inherited edtIndexes: TEdit
          Left = 105
          Top = 118
          Width = 310
          ExplicitLeft = 105
          ExplicitTop = 118
          ExplicitWidth = 310
        end
        inherited edtReportName: TEdit
          Left = 105
          Top = 13
          Width = 310
          ExplicitLeft = 105
          ExplicitTop = 13
          ExplicitWidth = 310
        end
        inherited edtReportDescription: TEdit
          Top = 40
          Width = 310
          ExplicitTop = 40
          ExplicitWidth = 310
        end
        inherited edtTopCount: TEdit
          Top = 70
          Width = 56
          Text = '50'
          ExplicitTop = 70
          ExplicitWidth = 56
        end
      end
    end
  end
  object alReportSettings: TActionList
    Left = 337
    Top = 8
    object actnOk: TAction
      Caption = 'OK'
      OnExecute = actnOkExecute
      OnUpdate = actnOkUpdate
    end
  end
end
