object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 165
  ClientWidth = 349
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 125
    Width = 349
    Height = 40
    Align = alBottom
    BevelEdges = [beLeft, beRight, beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 100
    DesignSize = (
      345
      38)
    object btnCancel: TButton
      Left = 263
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOk: TButton
      Left = 182
      Top = 6
      Width = 75
      Height = 25
      Action = actnSave
      Anchors = [akTop, akRight]
      Default = True
      TabOrder = 1
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 349
    Height = 125
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    ExplicitHeight = 100
    DesignSize = (
      345
      121)
    object lblServerAddress: TLabel
      Left = 8
      Top = 12
      Width = 78
      Height = 13
      Caption = 'Server Address:'
    end
    object lblServerPort: TLabel
      Left = 8
      Top = 39
      Width = 59
      Height = 13
      Caption = 'Server Port:'
    end
    object spnServerPort: TcxSpinEdit
      Left = 263
      Top = 36
      Anchors = [akTop, akRight]
      TabOrder = 0
      Width = 75
    end
    object edtServerAddress: TcxTextEdit
      Left = 100
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Width = 238
    end
    object btnTestConnection: TButton
      Left = 182
      Top = 63
      Width = 156
      Height = 25
      Action = actnTestConnection
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
    object chbSamlAuth: TCheckBox
      Left = 8
      Top = 88
      Width = 168
      Height = 17
      Caption = 'SAML Authentication'
      TabOrder = 3
    end
  end
  object alSettings: TActionList
    Left = 96
    Top = 40
    object actnSave: TAction
      Caption = 'Ok'
      OnExecute = actnSaveExecute
    end
    object actnTestConnection: TAction
      Caption = 'Test connection'
      OnExecute = actnTestConnectionExecute
    end
  end
end
