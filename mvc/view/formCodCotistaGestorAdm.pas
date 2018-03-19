unit formCodCotistaGestorAdm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TEMODELFORMBASICO, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxDBLookupComboBox,
  cxButtonEdit, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, StdCtrls,
  Buttons, ExtCtrls, InstantPresentation, Contnrs,
  controllerCodCotistaGestor, DTOCodCotistaGestor, cxTextEdit, cxSpinEdit;

type
  TfrmCodCotistaGestorAdm = class(TfrmModelFormBasico)
    pnlTop: TPanel;
    pnlBotton: TPanel;
    btnOK: TBitBtn;
    btnCancelar: TBitBtn;
    pnlSeparador: TPanel;
    pnlBody: TPanel;
    gridCodigoExterno: TcxGrid;
    TableViewCodigoExterno: TcxGridDBTableView;
    gridColumnCodGestor: TcxGridDBColumn;
    gridColumnCodAdministrador: TcxGridDBColumn;
    gridColumnCodigo: TcxGridDBColumn;
    gridColumnOpcoes: TcxGridDBColumn;
    GridLevelCodigoExterno: TcxGridLevel;
    pnlTopBody: TPanel;
    btnAdd: TBitBtn;
    expCodCotistaGestorAdm: TInstantExposer;
    dsCodCotistaGestorAdm: TDataSource;
    expGestor: TInstantExposer;
    dsGestor: TDataSource;
    expAdm: TInstantExposer;
    dsAdm: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure gridColumnOpcoesPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure gridColumnCodigoPropertiesEditValueChanged(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure gridColumnCodigoPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    FController: TControllerCodCotistaGestor;
    FCodCotista: Integer;
    FNomeCotista: String;

    FListaCodCotistaGestorAdm: TObjectList;
    FListaCodCotistaGestorAdmDeletados: TObjectList;
    FListaGestor: TObjectList;
    FListaAdministrador: TObjectList;


    procedure InitFicha();

    function FichaToList(): TObjectList;

    function DoSalvar(): Boolean;
    procedure DoDelete();

  public
    class procedure CallFicha( const aCodCotista: Integer; const aNomeCotista: String );
  end;

const
  cTitulo = '   Cotista:  %s';

implementation

uses
  mvcReferenceManipulator, mvcTypes, assemblerCodCotistaGestor, dtoBase, mvcMiscelania;

{$R *.dfm}

{ TfrmModelFormBasico1 }

class procedure TfrmCodCotistaGestorAdm.CallFicha(const aCodCotista: Integer; const aNomeCotista: String);
begin
  with TfrmCodCotistaGestorAdm.Create( nil ) do
  try
    FCodCotista := aCodCotista;
    FNomeCotista := aNomeCotista;

    InitFicha();

    ShowModal;//if (  = mrOk )
      //then DoSalvar();
      
  finally
    Free;
  end;
end;

function TfrmCodCotistaGestorAdm.DoSalvar: Boolean;
var
  vList: TObjectList;

  function ValidaFicha(): Boolean;
  var
    vStrLstComparador: TStringList;
    vStrLstErro: TStringList;
    vStrJuncao: String;
    i: Integer;
  begin
    Result := False;

    vStrLstComparador := TStringList.Create;
    vStrLstErro := TStringList.Create;
    try

      for i := 0 to Pred(FListaCodCotistaGestorAdm.Count) do
      begin
        with TDTOCodCotistaGestor( FListaCodCotistaGestorAdm[i] ) do
        begin
          if Status in [sdtoEdit, sdtoInsert] then
          begin

            // Valida gestor...
            if (CodGestor = 0)
              then vStrLstErro.Add(Format('Linha %d - Código do Gestor não pode estar vazio!',[i+1]));

            // Valida gestor...
            if (CodAdministrador = 0)
              then vStrLstErro.Add(Format('Linha %d - Código do Administrador não pode estar vazio!',[i+1]));

            // Valida código...
            if (CodCotistaGestor = 0)
              then vStrLstErro.Add(Format('Linha %d - Código externo não pode estar vazio!',[i+1]));

          end;

          if (CodGestor <> 0) and (CodAdministrador <> 0) then
          begin
            vStrJuncao := IntToStr(CodGestor) + IntToStr(CodAdministrador);
            if vStrLstComparador.IndexOf(vStrJuncao) = -1
              then vStrLstComparador.Add(vStrJuncao)
              else vStrLstErro.Add(Format('Linha %d - Combinação do Gestor + Administrador já existe!',[i+1]));
          end;

        end;
      end;

      if vStrLstErro.Count > 0
        then TMisc.SendMsg( vStrLstErro.Text )
        else Result := True;

    finally
      SafeFree( vStrLstComparador );
      SafeFree( vStrLstErro );
    end;

  end;

begin
  vList := Self.FichaToList();
  try
    Result := ValidaFicha();
    if Result
      then FController.Save( FCodCotista, vList );
  finally
    SafeFree( vList );
  end;
end;

procedure TfrmCodCotistaGestorAdm.InitFicha;
begin
  Self.pnlTop.Caption := Format(cTitulo,[UpperCase(Trim(FNomeCotista))]);

  FListaCodCotistaGestorAdm := FController.GetListaCodigoByCotista( FCodCotista );
  expCodCotistaGestorAdm.Subject := FListaCodCotistaGestorAdm;
  expCodCotistaGestorAdm.Open;

  FListaGestor := FController.GetListaGestor();
  expGestor.Subject := FListaGestor;
  expGestor.Open;

  FListaAdministrador := FController.GetListaAdministrador();
  expAdm.Subject := FListaAdministrador;
  expAdm.Open;

end;

procedure TfrmCodCotistaGestorAdm.FormCreate(Sender: TObject);
begin
  inherited;
  FController := TControllerCodCotistaGestor.Create();
  FListaCodCotistaGestorAdmDeletados := TObjectList.Create( True );
end;

procedure TfrmCodCotistaGestorAdm.FormDestroy(Sender: TObject);
begin
  expCodCotistaGestorAdm.Close;
  expGestor.Close;
  expAdm.Close;

  SafeFree( FController );

  SafeFree( FListaCodCotistaGestorAdm );
  SafeFree( FListaCodCotistaGestorAdmDeletados );
  SafeFree( FListaGestor );
  SafeFree( FListaAdministrador );

  inherited;
end;

procedure TfrmCodCotistaGestorAdm.btnAddClick(Sender: TObject);
begin
  inherited;
  expCodCotistaGestorAdm.AddObject(
    TDTOCodCotistaGestor.Create( sdtoInsert )
  );
end;

procedure TfrmCodCotistaGestorAdm.gridColumnOpcoesPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  case AButtonIndex of
    0: DoDelete(); //Botão deletar...
  end;
end;

procedure TfrmCodCotistaGestorAdm.DoDelete;
var
  vDTO: TDTOCodCotistaGestor;
begin
  with TDTOCodCotistaGestor(expCodCotistaGestorAdm.CurrentObject) do
  begin
    if Status in [sdtoNone, sdtoEdit]
      then FListaCodCotistaGestorAdmDeletados.Add( GetClone( sdtoDelete ) );
  end;

  expCodCotistaGestorAdm.DeleteObject(
    expCodCotistaGestorAdm.IndexOfObject(
      expCodCotistaGestorAdm.CurrentObject
    )
  );

end;

function TfrmCodCotistaGestorAdm.FichaToList: TObjectList;
var
  i: Integer;
begin
  Result := TObjectList.Create( True );

  // Adiciona todos editados/adicionados
  for i := 0 to Pred(FListaCodCotistaGestorAdm.Count) do
    Result.Add( TDTOCodCotistaGestor(FListaCodCotistaGestorAdm[i]).GetClone );

  // Adiciona todos deletados
  for i := 0 to Pred(FListaCodCotistaGestorAdmDeletados.Count) do
    Result.Add( TDTOCodCotistaGestor(FListaCodCotistaGestorAdmDeletados[i]).GetClone );
    
end;

procedure TfrmCodCotistaGestorAdm.gridColumnCodigoPropertiesEditValueChanged(
  Sender: TObject);
var
  vDTO: TDTOCodCotistaGestor;
begin
  inherited;
  vDTO := TDTOCodCotistaGestor(expCodCotistaGestorAdm.CurrentObject);
  if vDTO.Status in [sdtoNone]
    then vDTO.Status := sdtoEdit;
end;

procedure TfrmCodCotistaGestorAdm.btnOKClick(Sender: TObject);
begin
  inherited;
  if DoSalvar
    then ModalResult := mrOk;
end;

procedure TfrmCodCotistaGestorAdm.gridColumnCodigoPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  Error := False;
  try
    DisplayValue := IntToStr(StrToInt(VarToStr(DisplayValue)));
  except
    DisplayValue := TcxSpinEditProperties(gridColumnCodigo.Properties).MaxValue;
  end;
end;

end.
