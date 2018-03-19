inherited frmPainelMonitoramento: TfrmPainelMonitoramento
  Left = 83
  Top = 38
  BorderIcons = [biSystemMenu, biMaximize]
  BorderWidth = 5
  Caption = 'Painel de Monitoramento'
  ClientHeight = 489
  ClientWidth = 1117
  Constraints.MinHeight = 537
  Constraints.MinWidth = 1143
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Visible = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBody: TPanel
    Left = 0
    Top = 51
    Width = 1117
    Height = 438
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object cxgrdPainel: TcxGrid
      Left = 0
      Top = 6
      Width = 1117
      Height = 432
      Align = alClient
      PopupMenu = pmPainel
      TabOrder = 0
      object GridTableViewPainel: TcxGridDBTableView
        DataController.DataSource = dsPainel
        DataController.Filter.OnChanged = GridTableViewPainelDataControllerFilterChanged
        DataController.Filter.OnGetValueList = GridTableViewPainelDataControllerFilterGetValueList
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object gridColumnProcessoAutomaticoAtivo: TcxGridDBColumn
          Caption = 'Auto?'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayUnchecked = 'False'
          Properties.ReadOnly = False
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          Properties.OnEditValueChanged = gridColumnProcessoAutomaticoAtivoPropertiesEditValueChanged
          MinWidth = 50
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 50
          DataBinding.FieldName = 'Ativo'
        end
        object gridColumnFundo: TcxGridDBColumn
          MinWidth = 190
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.Moving = False
          Width = 190
          DataBinding.FieldName = 'Fundo'
        end
        object gridColumnProcessoDiario: TcxGridDBColumn
          Caption = 'Status Processo Di'#225'rio'
          MinWidth = 120
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.Moving = False
          Width = 120
          DataBinding.FieldName = 'Status'
        end
        object gridColumnPedidosPendentes: TcxGridDBColumn
          Caption = 'Qtd. Pedidos Pendentes'
          MinWidth = 120
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.Moving = False
          Width = 120
          DataBinding.FieldName = 'QuantidadePedido'
        end
        object gridColumnDtaUltimoProcessamento: TcxGridDBColumn
          Caption = 'Dta. '#218'ltimo Processo'
          PropertiesClassName = 'TcxDateEditProperties'
          MinWidth = 100
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.Moving = False
          Width = 100
          DataBinding.FieldName = 'UltimoProcessamento'
        end
        object gridColumnTipoFundo: TcxGridDBColumn
          Caption = 'Tipo de fundo'
          MinWidth = 120
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.Moving = False
          Width = 120
          DataBinding.FieldName = 'TipoCota'
        end
        object gridColumnButtonLogs: TcxGridDBColumn
          Caption = 'Ocorr'#234'ncias'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
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
              Kind = bkGlyph
              Width = 62
            end>
          Properties.OnButtonClick = gridColumnButtonLogsPropertiesButtonClick
          MinWidth = 65
          Options.Filtering = False
          Options.ShowEditButtons = isebAlways
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 65
        end
      end
      object GridLevelPainel: TcxGridLevel
        GridView = GridTableViewPainel
      end
    end
    object pnlSplinter: TPanel
      Left = 0
      Top = 0
      Width = 1117
      Height = 6
      Cursor = crHandPoint
      Align = alTop
      BevelOuter = bvNone
      Caption = #183#183#183#183#183
      TabOrder = 1
      OnClick = pnlSplinterClick
    end
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1117
    Height = 51
    Align = alTop
    BevelOuter = bvNone
    Constraints.MaxHeight = 51
    Constraints.MinHeight = 51
    TabOrder = 1
    object edtData: TcxDateEdit
      Left = 217
      Top = 30
      Width = 125
      Height = 21
      Properties.ImmediatePost = True
      TabOrder = 2
    end
    object lblDataReferencia: TcxLabel
      Left = 217
      Top = 13
      Width = 86
      Height = 17
      TabOrder = 1
      Caption = 'Data Refer'#234'ncia'
    end
    object grpAutoRefresh: TcxGroupBox
      Left = 1015
      Top = 0
      Width = 102
      Height = 51
      Align = alRight
      Alignment = alTopLeft
      TabOrder = 4
      object edtRefresh: TcxSpinEdit
        Left = 9
        Top = 21
        Width = 55
        Height = 21
        Properties.ImmediatePost = True
        Properties.MaxValue = 3600.000000000000000000
        Properties.MinValue = 1.000000000000000000
        Properties.OnChange = edtRefreshPropertiesChange
        TabOrder = 0
        Value = 1
      end
      object chkAutoRefresh: TcxCheckBox
        Left = 3
        Top = -4
        Width = 93
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.OnChange = chkAutoRefreshPropertiesChange
        Properties.Caption = 'Auto Refresh?'
        TabOrder = 1
      end
      object lblRefrash: TcxLabel
        Left = 65
        Top = 23
        Width = 26
        Height = 17
        TabOrder = 2
        Caption = 'Seg'
      end
    end
    object btnAplicar: TcxButton
      Left = 346
      Top = 25
      Width = 75
      Height = 25
      Action = actAplicar
      TabOrder = 3
    end
    object grpServicoProcessamento: TcxGroupBox
      Left = 0
      Top = 0
      Width = 213
      Height = 51
      Align = alLeft
      Alignment = alTopLeft
      Caption = ' Servi'#231'o de processamento autom'#225'tico '
      TabOrder = 0
      object shpLEDStatusServico: TShape
        Left = 112
        Top = 31
        Width = 12
        Height = 12
        Brush.Color = clRed
        Pen.Color = clBtnShadow
        Shape = stCircle
      end
      object shpLEDStatusConfiguracao: TShape
        Left = 9
        Top = 31
        Width = 12
        Height = 12
        Brush.Color = clLime
        Pen.Color = clBtnShadow
        Shape = stCircle
      end
      object shpLinha: TShape
        Left = 106
        Top = 16
        Width = 1
        Height = 24
      end
      object lblConfigProcessoAutomatico: TcxLabel
        Left = 9
        Top = 14
        Width = 72
        Height = 17
        TabOrder = 0
        Caption = 'Configura'#231#227'o'
      end
      object lblServicoProcAutomatico: TcxLabel
        Left = 112
        Top = 14
        Width = 93
        Height = 17
        TabOrder = 1
        Caption = 'Estado do servi'#231'o'
      end
      object lblStatusConfiguracao: TcxLabel
        Left = 21
        Top = 29
        Width = 72
        Height = 17
        AutoSize = False
        TabOrder = 2
        Caption = 'Ligado'
      end
      object lblStatusServico: TcxLabel
        Left = 124
        Top = 29
        Width = 73
        Height = 17
        AutoSize = False
        TabOrder = 3
        Caption = 'Inativo'
      end
    end
  end
  object tmrRefresh: TTimer
    Enabled = False
    OnTimer = tmrRefreshTimer
    Left = 544
    Top = 4
  end
  object actlstPainel: TActionList
    Left = 444
    Top = 4
    object actAplicar: TAction
      Category = 'Filtro'
      Caption = 'Aplicar'
      OnExecute = actAplicarExecute
    end
    object actAtivarTodos: TAction
      Category = 'Ativacao'
      Caption = 'Ativar todos'
      OnExecute = actAtivarTodosExecute
    end
    object actDesativarTodos: TAction
      Category = 'Ativacao'
      Caption = 'Desativar todos'
      OnExecute = actDesativarTodosExecute
    end
    object actInverterTodos: TAction
      Category = 'Ativacao'
      Caption = 'Inverter ativa'#231#245'es'
      OnExecute = actInverterTodosExecute
    end
  end
  object dsPainel: TDataSource
    DataSet = cdsPainel
    Left = 63
    Top = 87
  end
  object cdsPainel: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 87
  end
  object pmPainel: TPopupMenu
    MenuAnimation = [maTopToBottom]
    Left = 484
    Top = 247
    object mniAtivarTodos: TMenuItem
      Action = actAtivarTodos
    end
    object mniDesativarTodos: TMenuItem
      Action = actDesativarTodos
    end
    object mniInverterTodos: TMenuItem
      Action = actInverterTodos
    end
  end
end
