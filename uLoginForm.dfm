object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 110
  ClientWidth = 365
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 70
    Width = 365
    Height = 40
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      365
      38)
    object btnCancel: TButton
      Left = 283
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnLogin: TButton
      Left = 202
      Top = 7
      Width = 75
      Height = 25
      Action = actnLogin
      Anchors = [akTop, akRight]
      Default = True
      TabOrder = 0
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 365
    Height = 70
    Align = alClient
    BevelEdges = [beLeft, beTop, beRight]
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      365
      70)
    object lblUserId: TLabel
      Left = 8
      Top = 14
      Width = 40
      Height = 13
      Caption = 'User ID:'
    end
    object lblPassword: TLabel
      Left = 8
      Top = 40
      Width = 50
      Height = 13
      Caption = 'Password:'
    end
    object edtUserId: TEdit
      Left = 135
      Top = 10
      Width = 223
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
    object edtPassword: TEdit
      Left = 135
      Top = 37
      Width = 223
      Height = 21
      Anchors = [akTop, akRight]
      PasswordChar = '*'
      TabOrder = 1
    end
  end
  object alLoginForm: TActionList
    Left = 116
    Top = 73
    object actnLogin: TAction
      Caption = '&Login'
      OnExecute = actnLoginExecute
    end
  end
end
