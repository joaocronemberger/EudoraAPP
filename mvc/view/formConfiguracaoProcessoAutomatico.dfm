inherited frmConfiguracaoProcessoAutomatico: TfrmConfiguracaoProcessoAutomatico
  Left = 502
  Top = 227
  Caption = 'Configura'#231#227'o do Processo Autom'#225'tico'
  ClientHeight = 256
  ClientWidth = 330
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 220
    Width = 330
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      330
      36)
    object btnOK: TBitBtn
      Left = 150
      Top = 4
      Width = 84
      Height = 28
      Action = actOK
      Anchors = [akTop, akRight, akBottom]
      Caption = 'OK'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnSair: TBitBtn
      Left = 242
      Top = 4
      Width = 84
      Height = 28
      Action = actCancelar
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Cancelar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Glyph.Data = {
        9A050000424D9A0500000000000036000000280000001E0000000F0000000100
        1800000000006405000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FF5F675F5F675F5F675F5F675F5F675F5F675F5F675F5F675F5F67
        5F5F675FFF00FFFF00FFFF00FFFF00FFFF00FFB1B1B1B1B1B1B1B1B1B1B1B1B1
        B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1FF00FF0000FF00FFFF00FFFF00FFAF
        7F6FFFDFCFFFDFCFFFDFBFFFD7BFFFD7BFFFD7BFFFCFAFFFCFAFEFBF9F5F675F
        FF00FFFF00FFFF00FFFF00FFD1D1D1F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
        F3F3F3F3F3F3F3F3F3F3B1B1B1FF00FF0000FF00FFFF00FF5F675F00009FFFE7
        CFFFDFCFFFDFBFFFDFBFFFD7BFFFD7BFFFD7AFFFCFAF0000FF5F675FFF00FFFF
        00FFFF00FFB1B1B18D8D8DF3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
        F3F3F3A7A7A7B1B1B1FF00FF0000FF00FFAF7F6F3030CF0000FF00009FFFE7CF
        FFDFCFFFDFBFFFDFBFFFD7BFFFD7BFFFD7AFEFBFAF5F675FFF00FFFF00FFD1D1
        D1B4B4B4A7A7A78D8D8DF3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3
        F3F3B1B1B1FF00FF0000FF00FFBF876F3030CF309FFF0000FF00009FFFDFCFFF
        DFCFFFDFCFFFDFBFFFD7BF0000FFEFBFAF5F675FFF00FFFF00FFD7D7D7B4B4B4
        DEDEDEA7A7A78D8D8DF3F3F3F3F3F3F3F3F3F3F3F3F3F3F3A7A7A7F3F3F3B1B1
        B1FF00FF0000FF00FFBF8F7FFFE7CF0000CF0000FF00009FFFE7CFFFE7CFFFE7
        CFFFDFCF0000FFFFDFBFEFC7AF5F675FFF00FFFF00FFDDDDDDF3F3F39A9A9AA7
        A7A78D8D8DF3F3F3F3F3F3F3F3F3F3F3F3A7A7A7F3F3F3F3F3F3B1B1B1FF00FF
        0000FF00FFCF977FFFE7DFDFA77F0000CF0000FF00009FFFE7DFFFE7CF0000FF
        00009FFFDFBFEFC7AF5F675FFF00FFFF00FFE4E4E4F3F3F3EDEDED9A9A9AA7A7
        A78D8D8DF3F3F3F3F3F3A7A7A78D8D8DF3F3F3F3F3F3B1B1B1FF00FF0000FF00
        FFCF9F7FFFEFDFDFA77FFFEFEF0000CF0000FF00009F0000FF00009FFFE7CFFF
        DFCFEFCFBF5F675FFF00FFFF00FFE6E6E6F3F3F3EDEDEDF3F3F39A9A9AA7A7A7
        8D8D8DA7A7A78D8D8DF3F3F3F3F3F3F3F3F3B1B1B1FF00FF0000FF00FFDFA77F
        FFEFDFDFA77FFFF7EFFFEFEF0000CF0000FF00009FFFE7DFFFE7CFFFE7CFEFCF
        BF5F675FFF00FFFF00FFEDEDEDF3F3F3EDEDEDF3F3F3F3F3F39A9A9AA7A7A78D
        8D8DF3F3F3F3F3F3F3F3F3F3F3F3B1B1B1FF00FF0000FF00FFDFA77FFFEFEFDF
        A77FFFF7EF0000CF0000FF00009F0000CF00009FFFD7CFEFAFAFAF877F5F675F
        FF00FFFF00FFEDEDEDF3F3F3EDEDEDF3F3F39A9A9AA7A7A78D8D8D9A9A9A8D8D
        8DF3F3F3F3F3F3D7D7D7B1B1B1FF00FF0000FF00FFDFA77FFFF7EF0000CF0000
        FF0000FF00009FFFF7EFFFEFEF0000CF00009FDF8F3F5F675FFF00FFFF00FFFF
        00FFEDEDEDF3F3F39A9A9AA7A7A7A7A7A78D8D8DF3F3F3F3F3F39A9A9A8D8D8D
        D5D5D5B1B1B1FF00FFFF00FF0000FF00FFDFA77F0000CF309FFF0000FF00009F
        FFF7EFFFF7EFFFF7EFFFEFEF0000CF00009FFF00FFFF00FFFF00FFFF00FFEDED
        ED9A9A9ADEDEDEA7A7A78D8D8DF3F3F3F3F3F3F3F3F3F3F3F39A9A9A8D8D8DFF
        00FFFF00FFFF00FF0000FF00FFDFA77F60609F0000CF60609FDFA77FDFA77FDF
        A77FDFA78FCF9F7F5F675FFF00FF0000CFFF00FFFF00FFFF00FFEDEDEDC1C1C1
        9A9A9AC1C1C1EDEDEDEDEDEDEDEDEDF1F1F1E6E6E6B1B1B1FF00FF9A9A9AFF00
        FFFF00FF0000FF00FFDFA77FFFFFFFFFFFFFFFF7EFFFF7EFFFF7EFFFEFEFEFAF
        6F5F675FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFEDEDEDF3F3F3F3F3F3F3
        F3F3F3F3F3F3F3F3F3F3F3EFEFEFB1B1B1FF00FFFF00FFFF00FFFF00FFFF00FF
        0000FF00FFDFA77FDFA77FDFA77FDFA77FDFA77FDFA78FCF9F7F5F675FFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFEDEDEDEDEDEDEDEDEDEDEDEDEDED
        EDF1F1F1E6E6E6B1B1B1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000}
      NumGlyphs = 2
    end
    object btnFilaProcessamento: TBitBtn
      Left = 4
      Top = 4
      Width = 121
      Height = 28
      Action = actFilaProcessamento
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Fila Processamento'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF30B0DF6F909FD0A090C0908FC0908FC0908FC0
        908FC0908FC0908FC0908FC0908FC0908FC0908F606060FF00FFFF00FF8FA0FF
        30B0DF7F8FA0FFDFC0FFDFC0FFDFC0FFDFBFFFD0BFFFD0B0FFD0B0FFD0B0FFD0
        B0FFD0BF606060FF00FFFF00FFFF00FF8FA0FF3FAFDF708FA0FFE0D0FFE0CFFF
        E0CFFFDFC0FFDFC0FFDFC0FFDFC0FFDFC0FFD0BF606060FF00FFFF00FFFF00FF
        FF00FF8FA0FF4FB0DFA0AFA0D0A0A0D0A0A0D0A08FD0A0A0FFDFCFFFDFC0FFDF
        C0FFD0BF606060FF00FFFF00FFFF00FFFF00FFE0CFBFD0A0DFCFA080F0E0AFFF
        FFD0FFFFE0E0EFC0D0A0A0FFDFCFFFDFC0FFD0BF606060FF00FFFF00FFFF00FF
        FF00FFE0CFBFD09F8FEFDFA0FFF0BFFFFFDFFFFFFFFFFFFFD0EF90D09F8FFFE0
        CFFFD0BF606060FF00FFFF00FFFF00FFFF00FFEFD0BFD09F8FF0F0B0FFE0B0FF
        FFD0FFFFE0FFFFE0DFEF90D09F8FFFE0CFFFD0BF606060FF00FFFF00FFFF00FF
        FF00FFEFD0BFD09F8FEFEFB0FFF0DFFFF0BFFFF0BFFFFFCFD0EF80D09F8FFFE0
        CFFFD0BF606060FF00FFFF00FFFF00FFFF00FFF0DFC0FFF0EFCFCF90F0EFDFFF
        FFD0FFEFBFEFDF9FD0AF90E0903FDF8F30D08030606060FF00FFFF00FFFF00FF
        FF00FFFFE0CFFFFFF0FFF0EFD09F8FD09F8FD09F8FD09F8FFFBF60FFAF30FFA0
        20CF8F50606060FF00FFFF00FFFF00FFFF00FFFFE0CFFFFFF0FFF0F0FFF0EFFF
        F0EFFFF0E0EFC0AFFFCF80FFB050D09F6F606060FF00FFFF00FFFF00FFFF00FF
        FF00FFFFE0CFFFFFF0FFFFF0FFF0F0FFF0EFFFF0E0EFD0AFFFDF90CF9F706060
        60FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFFE0D0F0F0F0EFF0F0EFEFEFEF
        EFEFE0E0E0EFD0B0CFAF8F606060FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFFD0AFEFCFB0EFCFAFEFC0AFE0C0AFDFBFA0E0C0AFAF9F90FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
  end
  object pnlBody: TPanel
    Left = 0
    Top = 0
    Width = 330
    Height = 220
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object grpProcessamentoAutomatico: TcxGroupBox
      Left = 4
      Top = 0
      Width = 322
      Height = 220
      Align = alCustom
      Alignment = alTopLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = ' Processamento autom'#225'tico '
      TabOrder = 0
      DesignSize = (
        322
        220)
      object edtIntervalo: TcxSpinEdit
        Left = 5
        Top = 57
        Width = 174
        Height = 21
        Hint = 'Intervalo (em minutos) de execu'#231#227'o do processo autom'#225'tico'
        ParentShowHint = False
        Properties.MaxValue = 60.000000000000000000
        Properties.MinValue = 1.000000000000000000
        ShowHint = True
        TabOrder = 2
        Value = 1
      end
      object memoPeriodo: TcxMemo
        Left = 5
        Top = 99
        Width = 312
        Height = 116
        Hint = 
          'Janelas de execu'#231#227'o por per'#237'odos (Separados por ";") Ex: '#39'09:00/' +
          '12:00;13:00/17:00'#39
        Anchors = [akLeft, akTop, akRight, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object chkUsaProcessamentoAutomatico: TcxCheckBox
        Left = 5
        Top = 15
        Width = 174
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.OnChange = chkUsaProcessamentoAutomaticoPropertiesChange
        Properties.Caption = 'Usa processamento autom'#225'tico'
        TabOrder = 0
      end
      object lblIntervaloProcessamento: TcxLabel
        Left = 5
        Top = 40
        Width = 170
        Height = 17
        TabOrder = 1
        Caption = 'Intervalo de processamento (Min)'
      end
      object lblPeriodoExecucao: TcxLabel
        Left = 5
        Top = 82
        Width = 204
        Height = 17
        TabOrder = 3
        Caption = 'Janelas de execu'#231#227'o (Separados por ";")'
      end
    end
  end
  object actConfigProcessoAutomatico: TActionManager
    Left = 100
    Top = 112
    StyleName = 'XP Style'
    object actCancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = actCancelarExecute
    end
    object actOK: TAction
      Caption = 'OK'
      OnExecute = actOKExecute
    end
    object actFilaProcessamento: TAction
      Caption = 'Fila Processamento'
      OnExecute = actFilaProcessamentoExecute
    end
  end
end