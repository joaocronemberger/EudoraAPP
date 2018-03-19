object formPrincipal: TformPrincipal
  Left = 448
  Top = 27
  Width = 495
  Height = 636
  BorderWidth = 4
  Caption = 'Tema ORM Generator'
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
  object GroupBox1: TcxGroupBox
    Left = 0
    Top = 0
    Width = 471
    Height = 87
    Align = alTop
    Alignment = alTopLeft
    Caption = ' Selecione a tabela '
    TabOrder = 0
    DesignSize = (
      471
      87)
    object lblTabela: TcxLabel
      Left = 8
      Top = 15
      Width = 40
      Height = 17
      TabOrder = 0
      Caption = 'Tabela'
    end
    object cbbTabelas: TcxLookupComboBox
      Left = 8
      Top = 32
      Width = 452
      Height = 21
      Anchors = [akLeft, akTop, akRight, akBottom]
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'object_id'
      Properties.ListColumns = <
        item
          FieldName = 'name'
        end>
      Properties.ListOptions.GridLines = glNone
      Properties.ListSource = dsTabelas
      Properties.OnEditValueChanged = cbbTabelasPropertiesEditValueChanged
      TabOrder = 1
    end
    object edtNomeTabela: TcxTextEdit
      Left = 104
      Top = 55
      Width = 356
      Height = 21
      TabOrder = 2
    end
    object lblNomeTabela: TcxLabel
      Left = 8
      Top = 57
      Width = 95
      Height = 17
      TabOrder = 3
      Caption = 'Nome da Entidade'
    end
  end
  object gbxGerar: TcxGroupBox
    Left = 0
    Top = 536
    Width = 471
    Height = 54
    Align = alBottom
    Alignment = alTopLeft
    TabOrder = 1
    DesignSize = (
      471
      54)
    object btnGerar: TcxButton
      Left = 9
      Top = 12
      Width = 455
      Height = 35
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Gerar'
      TabOrder = 0
      OnClick = btnGerarClick
    end
  end
  object gridCampos: TcxGrid
    Left = 0
    Top = 87
    Width = 471
    Height = 449
    Align = alClient
    TabOrder = 2
    object gridCamposDBTableView1: TcxGridDBTableView
      DataController.DataSource = dsCampos
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <
        item
          Links = <>
          SummaryItems = <>
        end>
      NavigatorButtons.ConfirmDelete = False
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnHorzSizing = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ShowEditButtons = gsebAlways
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object gridColumnIsPrimary: TcxGridDBColumn
        Caption = 'Is PK?'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.DisplayChecked = '1'
        Properties.DisplayUnchecked = '0'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        MinWidth = 30
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.IncSearch = False
        Options.Grouping = False
        Options.Moving = False
        Width = 30
        DataBinding.FieldName = 'is_primary_key'
      end
      object gridColumnCampo: TcxGridDBColumn
        Caption = 'Campo'
        PropertiesClassName = 'TcxTextEditProperties'
        MinWidth = 200
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.IncSearch = False
        Options.Grouping = False
        Options.Moving = False
        Width = 200
        DataBinding.FieldName = 'name'
      end
      object gridColumnTipoColuna: TcxGridDBColumn
        Caption = 'Tipo'
        MinWidth = 100
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.IncSearch = False
        Options.Grouping = False
        Options.Moving = False
        Width = 100
        DataBinding.FieldName = 'type'
      end
    end
    object gridCamposLevel1: TcxGridLevel
      GridView = gridCamposDBTableView1
    end
  end
  object dsTabelas: TDataSource
    DataSet = qryTabelas
    Left = 169
    Top = 128
  end
  object dsCampos: TDataSource
    DataSet = qryCampos
    Left = 172
    Top = 182
  end
  object conBD: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source=ORMGe' +
      'nerator;'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    AfterConnect = conBDAfterConnect
    Left = 36
    Top = 152
  end
  object qryTabelas: TADOQuery
    Connection = conBD
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select *'
      '  from sys.tables'
      ' order by create_date desc')
    Left = 100
    Top = 128
  end
  object qryCampos: TADOQuery
    Connection = conBD
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'object_id'
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select c.object_id,'
      '       c.name,'
      '       CAST(c.is_identity AS INT) as is_identity,'
      '       c.user_type_id,'
      '       t.name as type,'
      '       CAST(c.is_nullable AS INT) as is_nullable,'
      
        '       coalesce((select 1 from sys.indexes i join sys.index_colu' +
        'mns as ic on i.index_id = ic.index_id AND i.object_id = ic.objec' +
        't_id where i.is_primary_key = 1 and ic.column_id = c.column_id a' +
        'nd ic.object_id = c.object_id ),0) as is_primary_key'
      '  from sys.all_columns c'
      '  join sys.types t '
      '    on t.user_type_id = c.user_type_id'
      ' where c.object_id = :object_id'
      ' order by c.column_id'
      ' ')
    Left = 100
    Top = 180
  end
end
