object frmSortOrder: TfrmSortOrder
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Sort Order'
  ClientHeight = 308
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtonPlace: TPanel
    Left = 0
    Top = 268
    Width = 473
    Height = 40
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      473
      38)
    object btnOK: TcxButton
      Left = 310
      Top = 6
      Width = 75
      Height = 25
      Action = actOk
      Anchors = [akRight, akBottom]
      Default = True
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'DarkSide'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 391
      Top = 6
      Width = 75
      Height = 25
      Action = actCancel
      Anchors = [akRight, akBottom]
      Cancel = True
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'DarkSide'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlSortOrder: TPanel
    Left = 0
    Top = 0
    Width = 473
    Height = 268
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      473
      268)
    object lblPipelines: TLabel
      Left = 8
      Top = 10
      Width = 109
      Height = 13
      Caption = 'Master / Detail Pipeline'
    end
    object lblAvailableFields: TLabel
      Left = 8
      Top = 55
      Width = 86
      Height = 13
      Caption = 'Available Columns'
    end
    object lblSelectedFields: TLabel
      Left = 240
      Top = 55
      Width = 84
      Height = 13
      Caption = 'Selected Columns'
    end
    object cmbPipelines: TcxComboBox
      Left = 6
      Top = 25
      Properties.DropDownListStyle = lsFixedList
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Black'
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Black'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Black'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Black'
      TabOrder = 0
      Width = 177
    end
    object btnFieldIncludeToSortOrder: TcxButton
      Left = 189
      Top = 88
      Width = 43
      Height = 41
      Action = aFieldIncludeToSortOrder
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'Black'
      OptionsImage.Images = dmRCGraphics.Icons32
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btnFieldExcludeFromSortOrder: TcxButton
      Left = 189
      Top = 135
      Width = 43
      Height = 41
      Action = aFieldExcludeFromSortOrder
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'Black'
      OptionsImage.Images = dmRCGraphics.Icons32
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object chbDescendingOrder: TcxCheckBox
      Left = 238
      Top = 25
      Caption = ' Descending Order'
      TabOrder = 3
    end
    object btnFieldUpInSortOrder: TcxButton
      Left = 421
      Top = 88
      Width = 43
      Height = 41
      Action = aFieldUpInSortOrder
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'Black'
      OptionsImage.Images = dmRCGraphics.Icons32
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object btnFieldDownInSortOrder: TcxButton
      Left = 421
      Top = 135
      Width = 43
      Height = 41
      Action = aFieldDownInSortOrder
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = 'Black'
      OptionsImage.Images = dmRCGraphics.Icons32
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    object tvSelectedFields: TcxTreeView
      Left = 238
      Top = 72
      Width = 177
      Height = 190
      Anchors = [akLeft, akTop, akBottom]
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Black'
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Black'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Black'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Black'
      TabOrder = 6
      HideSelection = False
      ReadOnly = True
      ShowRoot = False
    end
    object tvAvailableFields: TcxTreeView
      Left = 6
      Top = 72
      Width = 177
      Height = 190
      Anchors = [akLeft, akTop, akBottom]
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Black'
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Black'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Black'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Black'
      TabOrder = 7
      HideSelection = False
      ReadOnly = True
      ShowRoot = False
    end
  end
  object alReports: TActionList
    Images = dmRCGraphics.Icons32
    Left = 88
    Top = 120
    object aGenerate: TAction
      Caption = '&Generate'
      ShortCut = 32839
    end
    object aDesign: TAction
      Caption = 'Des&ign'
      ShortCut = 32841
    end
    object aRename: TAction
      Caption = 'Rename'
    end
    object aDelete: TAction
      Caption = 'Delete'
    end
    object aFieldIncludeToSortOrder: TAction
      Hint = 'Include column to the sort order'
      ImageIndex = 25
      OnExecute = aFieldIncludeToSortOrderExecute
      OnUpdate = aFieldIncludeToSortOrderUpdate
    end
    object aFieldExcludeFromSortOrder: TAction
      Hint = 'Exclude column from the sort order'
      ImageIndex = 26
      OnExecute = aFieldExcludeFromSortOrderExecute
      OnUpdate = aFieldExcludeFromSortOrderUpdate
    end
    object aFieldUpInSortOrder: TAction
      Hint = 'Move up in the sort order'
      ImageIndex = 2
      OnExecute = aFieldUpInSortOrderExecute
      OnUpdate = aFieldUpInSortOrderUpdate
    end
    object aFieldDownInSortOrder: TAction
      Hint = 'Move down in the sort order'
      ImageIndex = 1
      OnExecute = aFieldDownInSortOrderExecute
      OnUpdate = aFieldDownInSortOrderUpdate
    end
    object actOk: TAction
      Caption = 'OK'
      OnExecute = actOkExecute
    end
    object actCancel: TAction
      Caption = 'Cancel'
      OnExecute = actCancelExecute
    end
  end
end
