object bwBase: TbwBase
  Left = 0
  Top = 0
  Caption = 'bwBase'
  ClientHeight = 596
  ClientWidth = 1129
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object actBrowser: TActionManager
    ActionBars = <
      item
      end
      item
      end>
    Left = 320
    Top = 368
    StyleName = 'Platform Default'
    object actExit: TAction
      Caption = 'Sair'
    end
    object actGravar: TAction
      Caption = 'Gravar'
    end
    object actCancelar: TAction
      Caption = 'Cancelar'
      ImageIndex = 4
    end
    object actInserir: TAction
      Caption = 'Inserir'
    end
    object actEditar: TAction
      Caption = 'Editar'
    end
    object actExcluir: TAction
      Caption = 'Excluir'
    end
  end
  object menuBrowser: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 552
    Top = 344
    DockControlHeights = (
      0
      0
      0
      26)
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsBottom
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsBottom
      FloatLeft = 1153
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      IsMainMenu = True
      ItemLinks = <>
      MultiLine = True
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRecentItems = False
      Visible = True
      WholeRow = True
    end
  end
end
