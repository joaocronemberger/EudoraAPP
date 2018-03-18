object frmBase: TfrmBase
  Left = 0
  Top = 0
  Caption = 'frmBase'
  ClientHeight = 603
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottonButons: TPanel
    Left = 0
    Top = 547
    Width = 835
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = -277
    ExplicitTop = 243
    ExplicitWidth = 1129
    object pnlBtnBrowsing: TPanel
      Left = 0
      Top = 0
      Width = 260
      Height = 56
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Button1: TButton
        Left = 0
        Top = 0
        Width = 70
        Height = 56
        Align = alLeft
        Caption = 'Gravar'
        ImageAlignment = iaTop
        ImageIndex = 0
        ImageMargins.Top = 5
        TabOrder = 0
      end
      object Button4: TButton
        Left = 70
        Top = 0
        Width = 70
        Height = 56
        Align = alLeft
        Caption = 'Cancelar'
        ImageAlignment = iaTop
        ImageIndex = 4
        ImageMargins.Top = 5
        TabOrder = 1
      end
    end
  end
  object act: TActionManager
    ActionBars = <
      item
      end
      item
      end>
    Left = 368
    Top = 127
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
end
