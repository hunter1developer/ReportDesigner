object LoginPage: TLoginPage
  Left = 393
  Top = 250
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Versatile Authentication Service '
  ClientHeight = 332
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 332
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object WebBrowser1: TWebBrowser
      Left = 0
      Top = 0
      Width = 585
      Height = 332
      Align = alClient
      TabOrder = 0
      OnDocumentComplete = WebBrowser1DocumentComplete
      ExplicitLeft = 192
      ExplicitTop = 104
      ExplicitWidth = 300
      ExplicitHeight = 150
      ControlData = {
        4C000000763C0000502200000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 88
    Top = 64
  end
end
