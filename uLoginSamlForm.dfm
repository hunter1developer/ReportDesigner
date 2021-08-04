object frmSamlLogin: TfrmSamlLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 166
  ClientWidth = 372
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
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 372
    Height = 126
    Align = alClient
    BevelEdges = [beLeft, beTop, beRight]
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object NotebookPages: TNotebook
      Left = 0
      Top = 0
      Width = 372
      Height = 126
      Align = alClient
      TabOrder = 0
      object TPage
        Left = 0
        Top = 0
        Caption = 'UserID'
        object Label1: TLabel
          Left = 16
          Top = 16
          Width = 150
          Height = 16
          Caption = 'Enter your user ID to login'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 16
          Top = 59
          Width = 40
          Height = 13
          Caption = 'User ID:'
        end
        object edtUserId: TEdit
          Left = 136
          Top = 56
          Width = 229
          Height = 21
          TabOrder = 0
        end
        object chbRememberMe: TCheckBox
          Left = 16
          Top = 96
          Width = 113
          Height = 17
          Caption = ' Remember me'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'Login'
        object Label2: TLabel
          Left = 16
          Top = 16
          Width = 40
          Height = 13
          Caption = 'User ID:'
        end
        object Label4: TLabel
          Left = 16
          Top = 48
          Width = 252
          Height = 16
          Caption = 'Enter your password to access your account'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 16
          Top = 91
          Width = 50
          Height = 13
          Caption = 'Password:'
        end
        object lblUserId: TLabel
          Left = 62
          Top = 16
          Width = 3
          Height = 13
        end
        object lblChangeUserId: TLabel
          Left = 280
          Top = 16
          Width = 81
          Height = 13
          Caption = 'Change User ID?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblChangeUserIdClick
        end
        object edtPassword: TEdit
          Left = 163
          Top = 88
          Width = 202
          Height = 21
          PasswordChar = '*'
          TabOrder = 0
        end
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 126
    Width = 372
    Height = 40
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      372
      38)
    object btnCancel: TButton
      Left = 290
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnNext: TButton
      Left = 209
      Top = 7
      Width = 75
      Height = 25
      Action = actnNext
      Anchors = [akTop, akRight]
      Default = True
      TabOrder = 0
    end
    object btnLogin: TButton
      Left = 209
      Top = 7
      Width = 75
      Height = 25
      Action = actnLogin
      Anchors = [akTop, akRight]
      Default = True
      TabOrder = 2
    end
  end
  object alLoginForm: TActionList
    Left = 116
    Top = 73
    object actnNext: TAction
      Caption = 'Next'
      OnExecute = actnNextExecute
    end
    object actnLogin: TAction
      Caption = '&Login'
      OnExecute = actnLoginExecute
    end
    object actnChangeUserID: TAction
      Caption = 'Change User ID?'
      OnExecute = actnChangeUserIDExecute
    end
  end
end
