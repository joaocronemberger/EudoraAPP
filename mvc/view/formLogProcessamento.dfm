object frmLogProcessamento: TfrmLogProcessamento
  Left = 233
  Top = 152
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = 'Log do processamento'
  ClientHeight = 409
  ClientWidth = 908
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBody: TPanel
    Left = 0
    Top = 0
    Width = 908
    Height = 378
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GridLogProcessamento: TcxGrid
      Left = 0
      Top = 0
      Width = 908
      Height = 378
      Align = alClient
      TabOrder = 0
      object GridTableViewLogProcessamento: TcxGridDBTableView
        DataController.DataSource = dsLog
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Position = spFooter
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = GridTableViewLogProcessamentoCustomDrawCell
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
        object gridColumnCarteira: TcxGridDBColumn
          Caption = 'Carteira'
          OnGetDisplayText = gridColumnCarteiraGetDisplayText
          MinWidth = 271
          SortOrder = soAscending
          Width = 271
          DataBinding.FieldName = 'CodCarteira'
        end
        object gridColumnDataProcesso: TcxGridDBColumn
          Caption = 'Data Processada'
          MinWidth = 159
          Width = 159
          DataBinding.FieldName = 'DtaCalculoCota'
        end
        object gridColumnDtaInicio: TcxGridDBColumn
          Caption = 'In'#237'cio'
          MinWidth = 160
          Width = 160
          DataBinding.FieldName = 'DtaHoraProcessamentoInicio'
        end
        object gridColumnDtaFinal: TcxGridDBColumn
          Caption = 'Final'
          MinWidth = 159
          Width = 159
          DataBinding.FieldName = 'DtaHoraProcessamentoFim'
        end
        object gridColumnStatus: TcxGridDBColumn
          Caption = 'Status'
          Visible = False
          MinWidth = 64
          DataBinding.FieldName = 'StaCalculoText'
        end
      end
      object GridTableViewLogTexto: TcxGridDBTableView
        DataController.DataSource = dsLog2
        DataController.DetailKeyFieldNames = 'CodLogProcessamento'
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'CodLogProcessamento'
        DataController.MasterKeyFieldNames = 'CodLogProcessamento'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.DataRowSizing = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ScrollBars = ssNone
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.ExpandButtonsForEmptyDetails = False
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        object gridColumnLogTexto: TcxGridDBColumn
          PropertiesClassName = 'TcxMemoProperties'
          Properties.MaxLength = 0
          Options.Sorting = False
          DataBinding.FieldName = 'LogProcessamentoText'
        end
      end
      object GridLevelLogProcesso: TcxGridLevel
        GridView = GridTableViewLogProcessamento
        object GridLevelLogTexto: TcxGridLevel
          GridView = GridTableViewLogTexto
        end
      end
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 378
    Width = 908
    Height = 31
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      908
      31)
    object lblLegenda: TLabel
      Left = 0
      Top = 0
      Width = 119
      Height = 31
      Align = alLeft
      Caption = '[A] - Mensagem de Alerta'#13#10'[E] - Mensagem de Erro'
      Layout = tlBottom
    end
    object btnOk: TButton
      Left = 833
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object expLog: TInstantExposer
    ReadOnly = True
    Mode = amContent
    ObjectClassName = 'TDTOLogProcessamento'
    Left = 320
    Top = 60
  end
  object dsLog: TDataSource
    DataSet = expLog
    Left = 364
    Top = 59
  end
  object expLog2: TInstantExposer
    ReadOnly = True
    Mode = amContent
    ObjectClassName = 'TDTOLogProcessamento'
    Left = 320
    Top = 116
    object spLog2LogProcessamentoText: TStringField
      FieldName = 'LogProcessamentoText'
      Size = 9999
    end
    object spLog2CodLogProcessamento: TIntegerField
      FieldName = 'CodLogProcessamento'
    end
  end
  object dsLog2: TDataSource
    DataSet = expLog2
    Left = 364
    Top = 116
  end
end
