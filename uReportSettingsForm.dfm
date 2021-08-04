object frmReportSettings: TfrmReportSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Properties'
  ClientHeight = 127
  ClientWidth = 380
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
    Top = 87
    Width = 380
    Height = 40
    Align = alBottom
    BevelEdges = [beLeft, beRight, beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      376
      38)
    object btnCancel: TButton
      Left = 294
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
      Left = 213
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
    Width = 380
    Height = 87
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    inline frmReportSettings: TframeReportSettings
      Left = 0
      Top = 0
      Width = 376
      Height = 83
      Align = alClient
      Color = clWhite
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitWidth = 376
      ExplicitHeight = 83
      inherited pnlGroup: TPanel
        Width = 376
        Height = 83
        ExplicitWidth = 376
        ExplicitHeight = 83
        DesignSize = (
          376
          83)
        inherited lblReportDescription: TLabel
          Top = 42
          ExplicitTop = 42
        end
        inherited edtReportName: TEdit
          Top = 13
          Width = 261
          ExplicitTop = 13
          ExplicitWidth = 261
        end
        inherited edtReportDescription: TEdit
          Top = 39
          Width = 261
          ExplicitTop = 39
          ExplicitWidth = 261
        end
      end
    end
  end
  object alReportSettings: TActionList
    Left = 313
    Top = 40
    object actnOk: TAction
      Caption = 'OK'
      OnExecute = actnOkExecute
      OnUpdate = actnOkUpdate
    end
  end
end
