inherited frmCodCotistaGestorAdm: TfrmCodCotistaGestorAdm
  Left = 288
  Top = 156
  BorderWidth = 5
  Caption = 'C'#243'digo Externo por Gestor / Administrador'
  ClientHeight = 335
  ClientWidth = 641
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 641
    Height = 29
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    Caption = '   Cotista:  NOME DO CLIENTE TESTE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object pnlBotton: TPanel
    Left = 0
    Top = 300
    Width = 641
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      641
      35)
    object btnOK: TBitBtn
      Left = 468
      Top = 6
      Width = 84
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnOKClick
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
    object btnCancelar: TBitBtn
      Left = 556
      Top = 6
      Width = 84
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFF140EAE
        1711B8100BA1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF100B
        A11711B8140EAEFFFFFF1F1AB52522E92723F11F1BD1130EA6FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF130EA61F1BD12723F12522E91F1AB53D3AC84648F6
        2425F12A2BF32121D4140FADFFFFFFFFFFFFFFFFFFFFFFFF140FAD2121D42A2B
        F32425F14648F63D3AC8221CB66262E1444BF3262DEF2C33F22326D71812B3FF
        FFFFFFFFFF1812B32326D72C33F2262DEF474DF46262E1221CB6FFFFFF241DBB
        6566E34853F32934EF2F3BF2262BD91A13BA1A13BA262BD92F3BF22834EF4752
        F35F61DF241DBAFFFFFFFFFFFFFFFFFF2621C2656AE54756F32C3DF03041F12B
        36E42B36E43041F12D3DF04A59F35D5FE02119BFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF2721C66267E64356F23044F03448F23448F23044EF4255F26166E5221A
        C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2C23CC4551E9354DF136
        4CEF364CEF354DF04251EA2B23CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF1D14CE3240E63C54F23850F0384FF03B54F23445E91D15CEFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F17D4313EE43E58F13953F045
        5EF2455FF23A53F03E57F0303AE31F15D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        2018D93542E7425FF33D59F1556EF3737FF2737EF2566EF33D59F1425EF3313A
        E41F16D9FFFFFFFFFFFFFFFFFF2018DE3744E94663F2405DF15C77F36E76EF30
        28DF2E25DF7078F05D77F4405DF14562F2333DE82117DDFFFFFF221BE23947EC
        4A69F34462F25F7AF3686EF0271FE2FFFFFFFFFFFF2C23E2717AF1607BF44362
        F24A69F33846EB2019E24144EC5372F44464F26481F46E76F2271EE6FFFFFFFF
        FFFFFFFFFFFFFFFF2D25E7747CF26480F44564F25270F33D41EB4441ED7B8FF5
        7A94F6737BF32D24EAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2D24EA737C
        F37A93F67A8FF64441EDFFFFFF4845F05A59F22D24EDFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF2D24ED5959F24844F0FFFFFF}
    end
  end
  object pnlSeparador: TPanel
    Left = 0
    Top = 29
    Width = 641
    Height = 5
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaptionText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object pnlBody: TPanel
    Left = 0
    Top = 34
    Width = 641
    Height = 266
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object gridCodigoExterno: TcxGrid
      Left = 0
      Top = 33
      Width = 641
      Height = 233
      Align = alClient
      TabOrder = 0
      object TableViewCodigoExterno: TcxGridDBTableView
        DataController.DataSource = dsCodCotistaGestorAdm
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        NavigatorButtons.First.Visible = False
        NavigatorButtons.PriorPage.Visible = False
        NavigatorButtons.Prior.Visible = False
        NavigatorButtons.Next.Visible = False
        NavigatorButtons.NextPage.Visible = False
        NavigatorButtons.Last.Visible = False
        NavigatorButtons.Delete.Visible = False
        NavigatorButtons.Edit.Visible = False
        NavigatorButtons.Post.Visible = False
        NavigatorButtons.Cancel.Visible = False
        NavigatorButtons.Refresh.Visible = False
        NavigatorButtons.SaveBookmark.Visible = False
        NavigatorButtons.GotoBookmark.Visible = False
        NavigatorButtons.Filter.Visible = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ShowEditButtons = gsebAlways
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object gridColumnCodGestor: TcxGridDBColumn
          Caption = 'Gestor'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.ImmediatePost = True
          Properties.KeyFieldNames = 'CodCliente'
          Properties.ListColumns = <
            item
              FieldName = 'NomCliente'
            end>
          Properties.ListSource = dsGestor
          Options.Moving = False
          Options.Sorting = False
          DataBinding.FieldName = 'CodGestor'
        end
        object gridColumnCodAdministrador: TcxGridDBColumn
          Caption = 'Administrador'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.ImmediatePost = True
          Properties.KeyFieldNames = 'CodCliente'
          Properties.ListColumns = <
            item
              FieldName = 'NomCliente'
            end>
          Properties.ListSource = dsAdm
          Options.Moving = False
          Options.Sorting = False
          DataBinding.FieldName = 'CodAdministrador'
        end
        object gridColumnCodigo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.ImmediatePost = True
          Properties.MaxValue = 2147483647.000000000000000000
          Properties.UseCtrlIncrement = True
          Properties.OnEditValueChanged = gridColumnCodigoPropertiesEditValueChanged
          Properties.OnValidate = gridColumnCodigoPropertiesValidate
          Options.ShowEditButtons = isebNever
          Options.Moving = False
          Options.Sorting = False
          DataBinding.FieldName = 'CodCotistaGestor'
        end
        object gridColumnOpcoes: TcxGridDBColumn
          Caption = '#'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                1800000000000003000000000000000000000000000000000000FFFFFF5253FF
                0F11FD0F11FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEF
                FD3B3BED8383EAFFFFFF4E47FF252DFF2A49FF1D31FE8684FCFCFBFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFF3C3CE90C0EFA9E9EEFFFFFFF211AFF314CFF
                2E53FF2746FF131FFCBDBBFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C5F50C0B
                F90808E4CDCDF7FFFFFF6F6DFF495FFF3156FF2441FF1D36FF4646F6FFFFFFFF
                FFFFFFFFFFFFFFFFC3C1F21611EA0E0BFB7A7AEBFDFDFFFFFFFFC7C7FF3538FE
                4D6CFF203DFF1F3AFF131FFEC6C5F9FFFFFFFFFFFFC8C6F30F0AE40E07FF0A06
                F0B1B0EEFFFFFFFFFFFFFFFFFFC7C6FF4951FF405EFF1832FF1A2EFF191AEDCB
                C9F3CBC9F31611E40C07FF0E07FF332ED7E5E4F6FFFFFFFFFFFFFFFFFFFFFFFF
                A1A0FF4553FF314CFF1629FF141EFF0A07DD0D08E00F0AFF100AFF0702E38F8D
                E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E6FF4643FC4B5CFE283EFF1521FF11
                15FD1111FF130FFF0D08F87674E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFAF9FF5554F94652FD202CFF181CFF1615FF110FFD1A15DED3D2F6FFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3FF6566FB2A37FD242FFF19
                1EFF1615FF110EF3C0BFF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                A8AAFF626BFF667CFF5D71FF545FFF6268FF5A5BFF302CFF4641EFA4A1EDFFFF
                FFFFFFFFFFFFFFFFFFFFD5D3FF979FFF7189FF718BFF687DFF6578FF7883FF76
                73F68481F88986FF635DFF4C45F2A6A4EDFFFFFFFFFFFFFFFFFF8F9AFF829EFF
                7C97FF7289FF7389FF8996FE7A78F8DAD8FCDBDAFC7A76F18F8BFC7C76FF5B59
                F7A2A1F2DCDBF7FFFFFF8F9AFF92B0FF849EFF8CA1FF939DFE746FF9D9D7FDFF
                FFFFFFFFFFDEDDFBAFADF48B86F19693FE888BFB7077EEDDDEF9BFBEFFA4AEFF
                A3AEFF9194FE716AF9D7D5FDFFFFFFFFFFFFFFFFFFFFFFFFF5F5FEDCDCF89E9C
                EB8685EB959BF07F85E8D6D4FFB9B8FFA09FFF8C88FEDBD9FDFEFEFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E5FAA3A0EB8A89E07E82E6}
              Kind = bkGlyph
              Width = 21
            end>
          Properties.OnButtonClick = gridColumnOpcoesPropertiesButtonClick
          MinWidth = 24
          Options.HorzSizing = False
          Options.Moving = False
          Options.Sorting = False
          Width = 24
        end
      end
      object GridLevelCodigoExterno: TcxGridLevel
        GridView = TableViewCodigoExterno
      end
    end
    object pnlTopBody: TPanel
      Left = 0
      Top = 0
      Width = 641
      Height = 33
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveCaptionText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object btnAdd: TBitBtn
        Left = 0
        Top = 0
        Width = 81
        Height = 28
        Caption = 'Adicionar'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnAddClick
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFBBE4C270CF8527B7471EBA401EBA4027B74770CF85BBE4C2FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFDFA4FB96219C1401FCE4C24DC5827
          DD5C27DD5C24DC581FCE4C19C1404FB962FAFDFAFFFFFFFFFFFFFFFFFFFBFDFB
          21A93A1ED04E22D55521D35503B82C00A71200A71203B82C21D35522D5551ED0
          4E21A93AFBFDFBFFFFFFFFFFFF4EB15B1ECE4D21D3541FCC4D0FCC4500AD13FF
          FFFFFFFFFF00AD130FCC451FCC4D21D3541ECE4D4EB15BFFFFFFBDDEBE17BA3F
          21DA5A1ECC5120D0530DC74200BE25FFFFFFFFFFFF00BE250DC74220D0531ECC
          5121DA5A17BA3FBDDEBE6ABC7417D15120D45F0BCC4A04CA4300C13300BC22FF
          FFFFFFFFFF00BD2700C23B10CA4B0ECC4C20D45F17D1516ABC7430A03F33E67A
          00B62D00AD1300AD1300AD1300AD13FFFFFFFFFFFF00AD1300BD2700BD2300AD
          1300B62D33E67A30A14130A34381FCC300AF21FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00AF2181FCC430A14223953785FDCC
          2AC262FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF2AC26285FDCC23953533933D7BFAC33CD07D71C7801EBF5921C05B0ABA4DFF
          FFFFFFFFFF10BC5122C05C1EBF5971C7803CD07D7BFAC333933D67AB668AE5B9
          65EAB050DF9756DF9C41DB8D22C05CFFFFFFFFFFFF22C05C49DC9356DF9C50DF
          9765EAB08AE5B967AB66B9D4B94EB068AFFFEA5EE0A156E19F45DE9766D589FF
          FFFFFFFFFF23C05B50E09E56E19F5EE0A1AFFFEA4EB068B9D4B9FFFFFF458945
          7BDCA8B6FFEF76E5B551DFA366D589FFFFFFFFFFFF24BF5956E2A876E5B5B6FF
          EF7BDCA8458945FFFFFFFFFFFFFAFDFA1572156DD6A3B7FFF5AAF7E370E0B022
          C05C22C05C74E2B3ABF7E4B7FFF56DD6A3157215FAFDFAFFFFFFFFFFFFFFFFFF
          F9FCF945864538A75E7FE1B8A9FFECB9FFFBB9FFFBA9FFEC7FE1B838A75E4586
          45F9FCF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7CEB767A567247D3328
          8738288738247D3367A567B7CEB7FFFFFFFFFFFFFFFFFFFFFFFF}
      end
    end
  end
  object expCodCotistaGestorAdm: TInstantExposer
    Mode = amContent
    ObjectClassName = 'TDTOCodCotistaGestor'
    Left = 56
    Top = 100
  end
  object dsCodCotistaGestorAdm: TDataSource
    DataSet = expCodCotistaGestorAdm
    Left = 57
    Top = 148
  end
  object expGestor: TInstantExposer
    Mode = amContent
    ObjectClassName = 'TDTOCliente'
    Left = 196
    Top = 100
  end
  object dsGestor: TDataSource
    DataSet = expGestor
    Left = 197
    Top = 148
  end
  object expAdm: TInstantExposer
    Mode = amContent
    ObjectClassName = 'TDTOCliente'
    Left = 248
    Top = 100
  end
  object dsAdm: TDataSource
    DataSet = expAdm
    Left = 249
    Top = 148
  end
end
