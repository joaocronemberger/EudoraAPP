inherited frmFilaProcessamentoAutomatico: TfrmFilaProcessamentoAutomatico
  Left = 328
  Top = 206
  BorderWidth = 3
  Caption = 'Fila de Processo autom'#225'tico'
  ClientHeight = 311
  ClientWidth = 723
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 280
    Width = 723
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      723
      31)
    object btnOK: TBitBtn
      Left = 639
      Top = 3
      Width = 84
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = actOKExecute
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
  end
  object pnlBody: TPanel
    Left = 0
    Top = 31
    Width = 723
    Height = 249
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object cxgrdFilaProcesso: TcxGrid
      Left = 0
      Top = 0
      Width = 723
      Height = 249
      Align = alClient
      PopupMenu = pmFila
      TabOrder = 0
      object GridTableViewFilaProcesso: TcxGridDBTableView
        DataController.DataSource = dsFilaProcesso
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object gridColumnID: TcxGridDBColumn
          Caption = '#ID'
          Width = 25
          DataBinding.FieldName = 'CodFilaProcessoAutomatico'
        end
        object gridColumnCarteira: TcxGridDBColumn
          Caption = 'Carteira'
          PropertiesClassName = 'TcxLabelProperties'
          OnGetDisplayText = gridColumnCarteiraGetDisplayText
          Width = 100
          DataBinding.FieldName = 'CodCarteira'
        end
        object gridColumnProtocolo: TcxGridDBColumn
          Caption = 'Cod. Protocolo'
          PropertiesClassName = 'TcxLabelProperties'
          Width = 60
          DataBinding.FieldName = 'CodProtocoloOrdem'
        end
        object gridColumnDtaOrdem: TcxGridDBColumn
          Caption = 'Data/hora de inclus'#227'o'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DateButtons = []
          Width = 70
          DataBinding.FieldName = 'DtaOrdemProcessamento'
        end
        object gridColumnDtaProcessamentoCota: TcxGridDBColumn
          Caption = 'Data processo'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DateButtons = []
          Width = 60
          DataBinding.FieldName = 'DtaCotaProcessamento'
        end
        object gridColumnSituacao: TcxGridDBColumn
          Caption = 'Situa'#231#227'o'
          PropertiesClassName = 'TcxLabelProperties'
          Width = 60
          DataBinding.FieldName = 'StaSolicitacaoText'
        end
      end
      object GridLevelFilaProcesso: TcxGridLevel
        GridView = GridTableViewFilaProcesso
      end
    end
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 723
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object btnAplicar: TcxButton
      Left = 148
      Top = 2
      Width = 75
      Height = 25
      Action = actAplicar
      TabOrder = 0
    end
    object edtData: TcxDateEdit
      Left = 33
      Top = 4
      Width = 112
      Height = 21
      Properties.ImmediatePost = True
      TabOrder = 1
    end
    object lblDta: TcxLabel
      Left = 0
      Top = 6
      Width = 35
      Height = 17
      TabOrder = 2
      Caption = 'Data:'
    end
  end
  object actFilaProcessoAutomatico: TActionManager
    Left = 60
    Top = 116
    StyleName = 'XP Style'
    object actOK: TAction
      Caption = 'OK'
      ShortCut = 27
      OnExecute = actOKExecute
    end
    object actAplicar: TAction
      Caption = 'Aplicar'
      ShortCut = 13
      OnExecute = actAplicarExecute
    end
    object actReprocessar: TAction
      Caption = 'Reprocessar'
      OnExecute = actReprocessarExecute
    end
  end
  object expFilaProcesso: TInstantExposer
    ReadOnly = True
    Mode = amContent
    ObjectClassName = 'TDTOFilaProcessoAutomatico'
    Left = 60
    Top = 52
  end
  object dsFilaProcesso: TDataSource
    DataSet = expFilaProcesso
    Left = 142
    Top = 52
  end
  object pmFila: TPopupMenu
    MenuAnimation = [maTopToBottom]
    Left = 208
    Top = 123
    object mniReprocessar: TMenuItem
      Action = actReprocessar
    end
  end
end
