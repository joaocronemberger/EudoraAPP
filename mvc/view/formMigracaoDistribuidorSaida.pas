unit formMigracaoDistribuidorSaida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TEMODELFORMBASICO, cxLookAndFeelPainters, ActnList, XPStyleActnCtrls,
  ActnMan, cxCurrencyEdit, cxButtons, cxDropDownEdit, cxLabel, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxCalendar, cxControls, cxGroupBox, StdCtrls,
  Buttons, ExtCtrls, mvcTypes, cxRadioGroup, Contnrs, controllerMigracaoDistribuidorSaida,
  dtoMigracaoDistribuidorSaida, dtoCarteira,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxCheckBox, ImgList, InstantPresentation, cxTreeView, dtoCliente, Menus;

type
  TfrmMigracaoDistribuidorSaida = class(TfrmModelFormBasico)
    pnlForm: TPanel;
    pnlBottom: TPanel;
    btnOK: TBitBtn;
    btnSair: TBitBtn;
    pnlBody: TPanel;
    grpFiltro: TcxGroupBox;
    edtData: TcxDateEdit;
    lblData: TcxLabel;
    cbbCarteiras: TcxComboBox;
    lblCarteira: TcxLabel;
    btnAplicar: TcxButton;
    actMigracaoDistribuidorSaida: TActionManager;
    actAplicar: TAction;
    actCancelar: TAction;
    actSair: TAction;
    actOK: TAction;
    actExcluir: TAction;
    GridLevelClientes: TcxGridLevel;
    gridClientes: TcxGrid;
    pnlOpcoes: TPanel;
    actExportar: TAction;
    actImportar: TAction;
    ilImageLst: TImageList;
    expCostistas: TInstantExposer;
    dsCotistas: TDataSource;
    TableViewClientes: TcxGridDBTableView;
    gridColumnCodCliente: TcxGridDBColumn;
    gridColumnCheck: TcxGridDBColumn;
    gridColumnNomCliente: TcxGridDBColumn;
    gridColumnStatus: TcxGridDBColumn;
    grpClientes: TcxGroupBox;
    edtLocalizarCliente: TcxTextEdit;
    btnImportar: TcxButton;
    btnExportar: TcxButton;
    actExportarMovto: TAction;
    actExportarPosicao: TAction;
    btnExporta: TcxButton;
    act1: TAction;
    pmExportar: TPopupMenu;
    mniExportarMovto: TMenuItem;
    mniExportarPosicao: TMenuItem;
    procedure actAplicarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbbCarteirasPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure actOKExecute(Sender: TObject);
    procedure actExportarExecute(Sender: TObject);
    procedure actImportarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtLocalizarClienteKeyPress(Sender: TObject; var Key: Char);
  private
    FStatusForm: TStatusForm;
    FController : TControllerMigracaoDistribuidorSaida;
    FListaCarteiras: TObjectList;

    FDTOCarteira: TDTOCarteira;
    FDTO: TDTOMigracaoDistribuidorSaida;
    FListaCotistas: TObjectList;

    procedure SetStatusForm(const Value: TStatusForm);
    property StatusForm: TStatusForm read FStatusForm write SetStatusForm;

    function GetCotistasStr(): String;
    function ExisteAlteracao(): Boolean;

    procedure HabilitarComponentes();
    procedure InitFicha();

    procedure LoadListaCarteiras();
    procedure MarcaClienteNaLista(aCliente: String); overload;
    procedure MarcaClienteNaLista(aCliente: TDTOCliente); overload;

    procedure ImportaByPath(const aPath: String);
    procedure ExportaToPath(const aPath: String);

    procedure DTOToFicha();
    procedure FichaToDTO();

    function DoAplicar(): Boolean;
    function DoCancelar(): Boolean;
    function DoSalvar(): Boolean;
    function DoExcluir(): Boolean;
  end;

var
  frmMigracaoDistribuidorSaida: TfrmMigracaoDistribuidorSaida;

implementation

uses
  mvcMiscelania, DateUtils, mvcReferenceManipulator, formDialog, assemblerCliente,
  FDUConstantes, FDLib01;

{$R *.dfm}

procedure TfrmMigracaoDistribuidorSaida.actAplicarExecute(Sender: TObject);
begin
  inherited;
  if DoAplicar() then
  begin
    Self.StatusForm := sformEdit;
    Self.btnAplicar.Action := actCancelar;
  end;
end;

procedure TfrmMigracaoDistribuidorSaida.actCancelarExecute(Sender: TObject);
begin
  inherited;
  if DoCancelar() then
  begin
    Self.StatusForm := sformView;
    Self.btnAplicar.Action := actAplicar;
  end;
end;

procedure TfrmMigracaoDistribuidorSaida.HabilitarComponentes();
var
  vHabilitar: Boolean;
begin
  vHabilitar := Self.StatusForm in [sformEdit, sformInsert];

  // Desabilita se editando/inserindo...
  Self.edtData.Enabled := not vHabilitar;
  Self.cbbCarteiras.Enabled := not vHabilitar;

  // Habilita se editando/inserindo...
  Self.edtLocalizarCliente.Enabled := vHabilitar;
  Self.gridClientes.Enabled := vHabilitar;
  Self.btnOK.Enabled := vHabilitar;

end;

procedure TfrmMigracaoDistribuidorSaida.actSairExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMigracaoDistribuidorSaida.FormShow(Sender: TObject);
begin
  inherited;
  FController.SetNomeUsuario(sNomUsuario);
  InitFicha();
end;

procedure TfrmMigracaoDistribuidorSaida.InitFicha;
begin
  Self.StatusForm := sformView;
  Self.edtData.Date := Trunc(Date);
  Self.LoadListaCarteiras();
end;

function TfrmMigracaoDistribuidorSaida.DoAplicar: Boolean;

  function Valida: boolean;
  begin
    Result := False;

    // Validar Data...
    if (Self.edtData.Date = 0) then
    begin
      TMisc.SendMsg('Informe a data.');
      Exit;
    end;

    // Validar Data útil...
    if not TMisc.DateTimeIsUtil( Self.edtData.Date ) then
    begin
      TMisc.SendMsg('Data da migração não é um dia útil.');
      Exit;
    end;

    // Validar Carteira...
    if not Assigned(FDTOCarteira) then
    begin
      TMisc.SendMsg('Informe a carteira.');
      Exit;
    end;

    Result := True;
  end;

begin
  Result := False;
  Screen.Cursor := crSQLWait;
  try
    try
      if Valida() then
      begin

        if Assigned(FListaCotistas) then
          SafeFree(FListaCotistas);
        FListaCotistas := FController.GetCotistasComSaldoByCarteira( edtData.Date, FDTOCarteira.CodCarteira );

        if Assigned(FDTO) then
          SafeFree(FDTO);
        FDTO := FController.GetMigracaoDistribuidorGravada( edtData.Date, FDTOCarteira.CodCarteira );

        Self.DTOToFicha();
        Result := (Assigned(FListaCotistas) and (FListaCotistas.Count > 0));
        
      end;
    except
      on e: exception do
      begin
        TMisc.SendMsg(Format('Ocorreu um erro ao aplicar a migração de distribuidor: %s',[e.Message]));
        Result := False;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TfrmMigracaoDistribuidorSaida.DoCancelar: Boolean;
begin
  Result := False;
  try
    expCostistas.Close;
    Result := True;
  except
    on e: exception do
    begin
      TMisc.SendMsg(Format('Ocorreu um erro ao cancelar o filtro da migração de distribuidor: %s',[e.Message]));
      Result := False;
    end;
  end;
end;

procedure TfrmMigracaoDistribuidorSaida.SetStatusForm(const Value: TStatusForm);
begin
  FStatusForm := Value;
  Self.HabilitarComponentes();
end;

procedure TfrmMigracaoDistribuidorSaida.FormCreate(Sender: TObject);
begin
  inherited;
  FController := TControllerMigracaoDistribuidorSaida.Create();
end;

procedure TfrmMigracaoDistribuidorSaida.FormDestroy(Sender: TObject);
begin
  inherited;
  FListaCarteiras.Free;
  FController.Free;
end;

procedure TfrmMigracaoDistribuidorSaida.LoadListaCarteiras;
var
  vObj: TDTOCarteira;
  i: Integer;
begin
  FDTOCarteira := nil;
  if Assigned(FListaCarteiras) then
  begin
    FListaCarteiras.Clear;
    FreeAndNil(FListaCarteiras);
  end;
  FListaCarteiras := FController.GetListaDeCarteiras();

  Self.cbbCarteiras.Properties.BeginUpdate;
  try
    Self.cbbCarteiras.Properties.Items.Clear;
    for i := 0 to FListaCarteiras.Count -1 do
    begin
      vObj := TDTOCarteira(FListaCarteiras[i]);
      Self.cbbCarteiras.Properties.Items.AddObject(IntToStr(vObj.CodCarteira) +' - '+ vObj.NomFantasiaProduto, vObj);
    end;
  finally
    Self.cbbCarteiras.Properties.EndUpdate();
  end;
end;

procedure TfrmMigracaoDistribuidorSaida.cbbCarteirasPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  i: Integer;
  vEncontrou: Boolean;
begin
  inherited;

  { Marlon Souza -
    Essa ComboBox tem a inteligência de buscar pelo Código ou pela Descrição, e
    pra que isso funcione, foi necessário programar o método abaixo para localizar
    a carteira que contenha os dados que o usuário digitou, e se não encontrar,
    limpa a Combo que no botão aplicar terá uma validação }

  vEncontrou := False;

  for i := 0 to Self.cbbCarteiras.Properties.Items.Count -1 do
  begin
    if (Pos(LowerCase(DisplayValue),LowerCase(Self.cbbCarteiras.Properties.Items[i])) > 0) then
    begin
      DisplayValue := Self.cbbCarteiras.Properties.Items[i];
      FDTOCarteira := TDTOCarteira(Self.cbbCarteiras.Properties.Items.Objects[i]);
      vEncontrou := True;
      Break;
    end;
  end;

  if not vEncontrou then
  begin
    DisplayValue := EmptyStr;
    FDTOCarteira := nil;
  end;

end;

procedure TfrmMigracaoDistribuidorSaida.DTOToFicha;
var
  vObj: TDTOCliente;
  i: Integer;
begin
  if (Assigned(FListaCotistas) and (FListaCotistas.Count > 0)) or
     (Assigned(FDTO) and Assigned(FDTO.ListaCliente) and (FDTO.ListaCliente.Count > 0)) then
  begin
    // Marcar clientes que já tiveram na lista
    for i := 0 to Pred(FDTO.ListaCliente.Count) do
      Self.MarcaClienteNaLista( TDTOCliente(FDTO.ListaCliente[i]) );

    expCostistas.Subject := FListaCotistas;
    expCostistas.Open;

  end else
  begin
    TMisc.SendMsg('Nenhum costista com saldo foi encontrado para a carteira e data selecionada.');
  end;
end;

procedure TfrmMigracaoDistribuidorSaida.FichaToDTO;
var
  vObj: TDTOCliente;
begin
  if Assigned(FDTO) then
  begin
    FDTO.DtaMigracao := edtData.Date;
    FDTO.CodCarteira := FDTOCarteira.CodCarteira;

    FDTO.ListaCliente.Clear;
    TAssemblerCliente.ListDTOToListDTO(FListaCotistas, FDTO.ListaCliente);

  end;
end;

procedure TfrmMigracaoDistribuidorSaida.actOKExecute(Sender: TObject);
begin
  inherited;
  if DoSalvar() then
    actCancelar.Execute;
end;

function TfrmMigracaoDistribuidorSaida.DoExcluir: Boolean;
begin
  Result := False;
  if TMisc.SendConfirm('Confirma a exclusão dessa migração?') then
  try
    FController.Delete(FDTO);
    Result := True;
  except
    on e: exception do
    begin
      TMisc.SendMsg(Format('Ocorreu um erro ao excluir da migração de distribuidor: %s',[e.Message]));
      Result := False;
    end;
  end;
end;

function TfrmMigracaoDistribuidorSaida.DoSalvar: Boolean;

var
  vLogOcorrencias,
  vLogAlertas: TStringList;

  function Valida: boolean;
  begin
    Result := False;

    //Add validações...
    
    Result := True;
  end;

begin

  Result := False;
  try
    try
      vLogOcorrencias := TStringList.Create;
      vLogAlertas := TStringList.Create;

      Self.FichaToDTO;
      if Valida() then
      begin
        FController.Save(FDTO, vLogOcorrencias, vLogAlertas);

        if vLogAlertas.Count > 0
          then TMisc.SendMsg(vLogAlertas.Text);

        if ExisteAlteracao()
          then FDTO.Memento_SaveLog(LogMigracaoDistribuidor, Format('Migração de distribuidor (saída) gravado com a(s) seguinte(s) alteração(ões): '+#13+'%s',[GetCotistasStr()]), FDTO.CodCarteira);
      end;

      if vLogOcorrencias.Count > 0
        then TMisc.SendMsg( 'Migração(ões) gravada(s) com sucesso!' + #13 + vLogOcorrencias.Text )
        else TMisc.SendMsg( 'Migração(ões) gravada(s) com sucesso!' );

      Result := True;
    finally
      SafeFree( vLogOcorrencias );
      SafeFree( vLogAlertas );
    end;
  except
    on e: exception do
    begin
      TMisc.SendMsg(Format('Ocorreu um erro ao gravar a migração de distribuidor: %s',[e.Message]));
      Result := False;
    end;
  end;
end;

procedure TfrmMigracaoDistribuidorSaida.actExportarExecute(
  Sender: TObject);
var
  aPath: String;
begin
  inherited;

  if not (Self.StatusForm in [sformEdit, sformInsert]) then
  begin
    TMisc.SendMsg('Tela não está habilitada para fazer exportação.');
    Exit;
  end;

  if (TfrmDialog.AbreBuscaFolder('Exportar clientes selecionados', aPath)) then
  begin
    if (aPath = EmptyStr) then
    begin
      TMisc.SendMsg('Selecione um diretório.');
      Exit;
    end;

    Self.ExportaToPath(aPath);
  end;

end;

procedure TfrmMigracaoDistribuidorSaida.actImportarExecute(
  Sender: TObject);
var
  aPath: String;
begin
  inherited;

  if not (Self.StatusForm in [sformEdit, sformInsert]) then
  begin
    TMisc.SendMsg('Tela não está habilitada para fazer importação.');
    Exit;
  end;

  if (TfrmDialog.AbreBuscaFile('Importar clientes selecionados', aPath, 'Arquivo txt|*.txt')) then
  begin
    if (aPath = EmptyStr) then
    begin
      TMisc.SendMsg('Selecione um arquivo.');
      Exit;
    end;

    Self.ImportaByPath(aPath);
  end;

end;

procedure TfrmMigracaoDistribuidorSaida.ExportaToPath(const aPath: String);
var
  vObj: TDTOCliente;
  i: Integer;
  vStrLst: TStringList;

const
  cFileName = 'MigDist_ClientesSelecionados.txt';
begin

  vStrLst := TStringList.Create();
  try
    for i := 0 to pred(expCostistas.RecordCount) do
    begin
      vObj := TDTOCliente(expCostistas.Objects[i]);
      if vObj.Check then
        vStrLst.Add(IntToStr(vObj.CodCliente));
    end;

    if (vStrLst.Count > 0) then
    begin
      vStrLst.SaveToFile(TMisc.PathComBarra(aPath)+cFileName);
      TMisc.SendMsg('Exportação concluída.');
    end
    else
      TMisc.SendMsg('Nenhum cliente selecionado.');

  finally
    SafeFree(vStrLst);
  end;

end;

procedure TfrmMigracaoDistribuidorSaida.ImportaByPath(const aPath: String);
var
  i: Integer;
  vStrLst: TStringList;
begin

  if not FileExists(aPath) then
  begin
    TMisc.SendMsg('Arquivo selecionado não existe.');
    Exit;
  end;

  vStrLst := TStringList.Create();
  try
    vStrLst.LoadFromFile(aPath);

    for i := 0 to pred(vStrLst.Count) do
      Self.MarcaClienteNaLista(vStrLst[i]);

    TMisc.SendMsg('Importação concluída.');

  finally
    SafeFree(vStrLst);
  end;

end;

procedure TfrmMigracaoDistribuidorSaida.MarcaClienteNaLista(
  aCliente: String);
var
  vObj: TDTOCliente;
  i: Integer;
begin
  for i := 0 to pred( FListaCotistas.Count ) do
  begin
    vObj := TDTOCliente( FListaCotistas[i] );
    if (aCliente = IntToStr(vObj.CodCliente)) or (aCliente = vObj.NomCliente) then
    begin
      vObj.Check := True;
      if expCostistas.Active
        then expCostistas.Refresh;
      Break;
    end;
  end;
end;

procedure TfrmMigracaoDistribuidorSaida.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  inherited;
end;

procedure TfrmMigracaoDistribuidorSaida.edtLocalizarClienteKeyPress(
  Sender: TObject; var Key: Char);
begin
  if (edtLocalizarCliente.Text <> EmptyStr)and (Key = #13) then
  begin
    Self.MarcaClienteNaLista(edtLocalizarCliente.Text);
    Perform(WM_NEXTDLGCTL,-1,0);
  end;
end;

procedure TfrmMigracaoDistribuidorSaida.MarcaClienteNaLista(
  aCliente: TDTOCliente);
var
  vObj: TDTOCliente;
  i: Integer;
  vAchou: Boolean;
begin
  vAchou := False;
  for i := 0 to Pred( FListaCotistas.Count ) do
  begin
    vObj := TDTOCliente( FListaCotistas[i] );
    if (aCliente.CodCliente = vObj.CodCliente) then
    begin
      vObj.Check := True;
      vObj.Status := sdtoEdit;
      vAchou := True;
      if expCostistas.Active
        then expCostistas.Refresh;
      Break;
    end;
  end;

  // Add na lista se não achou.
  if not vAchou then
  begin
    vObj := TDTOCliente.Create;
    TAssemblerCliente.DTOToDTO(aCliente, vObj);
    vObj.Check := True;
    vObj.Status := sdtoEdit;
    FListaCotistas.Add(vObj);
  end;

end;

function TfrmMigracaoDistribuidorSaida.GetCotistasStr: String;
var
  i: Integer;
  vCliente: TDTOCliente;
begin
  Result := EmptyStr;
  for i := 0 to Pred(FDTO.ListaCliente.Count) do
  begin
    vCliente := TDTOCliente(FDTO.ListaCliente[i]);

    case vCliente.Status of
      sdtoInsert: Result := Result + Format('Migração do cliente %s gravada.',[Trim(vCliente.NomCliente)]) + #13;
      sdtoDelete: Result := Result + Format('Migração do cliente %s removida.',[Trim(vCliente.NomCliente)]) + #13;
    end;
  end;
end;

function TfrmMigracaoDistribuidorSaida.ExisteAlteracao: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Pred(FDTO.ListaCliente.Count) do
  begin
    if TDTOCliente(FDTO.ListaCliente[i]).Status <> sdtoNone then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

end.


