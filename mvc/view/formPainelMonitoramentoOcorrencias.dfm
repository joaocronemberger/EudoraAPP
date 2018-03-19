inherited frmPainelMonitoramentoOcorrencias: TfrmPainelMonitoramentoOcorrencias
  Left = 282
  Top = 192
  BorderIcons = [biSystemMenu]
  BorderWidth = 5
  Caption = 'Ocorr'#234'ncias - %s'
  ClientHeight = 418
  ClientWidth = 901
  PixelsPerInch = 96
  TextHeight = 13
  object splOcorrencias: TSplitter
    Left = 0
    Top = 283
    Width = 901
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ResizeStyle = rsLine
  end
  object pnlBody: TPanel
    Left = 0
    Top = 0
    Width = 901
    Height = 283
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object cxgrdOcorrencias: TcxGrid
      Left = 0
      Top = 0
      Width = 901
      Height = 283
      Align = alClient
      TabOrder = 0
      object GridTableViewOcorrencias: TcxGridDBTableView
        DataController.DataSource = dsOcorrencias
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object gridColumnDataHoraInicio: TcxGridDBColumn
          Caption = 'In'#237'cio do processamento'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DateButtons = []
          Properties.ImmediatePost = True
          MinWidth = 64
          DataBinding.FieldName = 'DtaHoraProcessamentoInicio'
        end
        object gridColumnDataHoraTermino: TcxGridDBColumn
          Caption = 'Final do processamento'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DateButtons = []
          Properties.ImmediatePost = True
          MinWidth = 64
          DataBinding.FieldName = 'DtaHoraProcessamentoFim'
        end
        object gridColumnSituacao: TcxGridDBColumn
          Caption = 'Status'
          MinWidth = 64
          DataBinding.FieldName = 'StaCalculoText'
        end
        object gridColumnUsuarios: TcxGridDBColumn
          Caption = 'Usu'#225'rio'
          MinWidth = 64
        end
      end
      object GridLevelOcorrencias: TcxGridLevel
        GridView = GridTableViewOcorrencias
      end
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 288
    Width = 901
    Height = 130
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object memoOcorrencia: TcxDBMemo
      Left = 0
      Top = 0
      Width = 901
      Height = 130
      Align = alClient
      DataBinding.DataField = 'LogProcessamentoText'
      DataBinding.DataSource = dsOcorrencias
      TabOrder = 0
    end
  end
  object expOcorrencias: TInstantExposer
    ObjectClassName = 'TDTOLogProcessamento'
    Left = 76
    Top = 96
  end
  object dsOcorrencias: TDataSource
    DataSet = expOcorrencias
    Left = 168
    Top = 72
  end
end
