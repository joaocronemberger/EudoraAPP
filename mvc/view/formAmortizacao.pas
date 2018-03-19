unit formAmortizacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TEMODELFORMBASICO, cxLookAndFeelPainters, ActnList, XPStyleActnCtrls,
  ActnMan, cxCurrencyEdit, cxButtons, cxDropDownEdit, cxLabel, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxCalendar, cxControls, cxGroupBox, StdCtrls,
  Buttons, ExtCtrls, mvcTypes, cxRadioGroup, Contnrs, controllerAmortizacao,
  dtoAmortizacao, dtoCarteira, enumAmortizacao;

type
  TfrmAmortizacao = class(TfrmModelFormBasico)
    pnlForm: TPanel;
    pnlBottom: TPanel;
    btnOK: TBitBtn;
    btnExcluir: TBitBtn;
    btnSair: TBitBtn;
    pnlBody: TPanel;
    grpFiltro: TcxGroupBox;
    edtData: TcxDateEdit;
    lblData: TcxLabel;
    cbbCarteiras: TcxComboBox;
    lblCarteira: TcxLabel;
    btnAplicar: TcxButton;
    edtValor: TcxCurrencyEdit;
    lblValor: TcxLabel;
    actAmortizacao: TActionManager;
    actAplicar: TAction;
    actCancelar: TAction;
    actSair: TAction;
    actOK: TAction;
    actExcluir: TAction;
    grpTipoAmortizacao: TcxRadioGroup;
    grpCota: TcxGroupBox;
    lblTipoCota: TcxLabel;
    cbbTpoCota: TcxComboBox;
    lblCotaAmortizacao: TcxLabel;
    edtValCotaAmortizacao: TcxCurrencyEdit;
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
    procedure edtDataPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure actExcluirExecute(Sender: TObject);
    procedure cbbTpoCotaChange(Sender: TObject);
    procedure grpTipoAmortizacaoChange(Sender: TObject);
    procedure edtCotaAmortizacaoChanged(
      Sender: TObject);
  private
    FStatusForm: TStatusForm;
    FController : TControllerAmortizacao;
    FListaCarteiras: TObjectList;
    FValCotaDia,
    FValCotaDigitada: Double;

    FDTOCarteira: TDTOCarteira;
    FDTO: TDTOAmortizacao;

    procedure SetStatusForm(const Value: TStatusForm);
    property StatusForm: TStatusForm read FStatusForm write SetStatusForm;

    procedure HabilitarComponentes();
    procedure InitFicha();
    procedure SetDefaults();

    procedure AtualizarCota(const aValCota: Double);

    procedure LoadListaCarteiras();
    procedure LoadComboTipoCota();
    procedure LoadCotaDia();

    procedure DTOToFicha();
    procedure FichaToDTO();

    function DoAplicar(): Boolean;
    function DoCancelar(): Boolean;
    function DoSalvar(): Boolean;
    function DoExcluir(): Boolean;
  end;

var
  frmAmortizacao: TfrmAmortizacao;

implementation

uses
  mvcMiscelania, DateUtils, mvcReferenceManipulator, FDUConstantes;

{$R *.dfm}

procedure TfrmAmortizacao.actAplicarExecute(Sender: TObject);
begin
  inherited;
  if DoAplicar() then
  begin
    Self.StatusForm := sformEdit;
    Self.btnAplicar.Action := actCancelar;
  end;
end;

procedure TfrmAmortizacao.actCancelarExecute(Sender: TObject);
begin
  inherited;
  if DoCancelar() then
  begin
    Self.StatusForm := sformView;
    Self.btnAplicar.Action := actAplicar;
  end;
end;

procedure TfrmAmortizacao.HabilitarComponentes();
var
  vHabilitar: Boolean;
begin
  vHabilitar := Self.StatusForm in [sformEdit, sformInsert];

  // Desabilita se editando/inserindo...
  Self.edtData.Enabled := not vHabilitar;
  Self.cbbCarteiras.Enabled := not vHabilitar;
  
  // Habilita se editando/inserindo...
  Self.edtValor.Enabled := vHabilitar;
  Self.grpTipoAmortizacao.Enabled := vHabilitar;
  Self.btnOK.Enabled := vHabilitar;
  Self.btnExcluir.Enabled := vHabilitar;
  Self.cbbTpoCota.Enabled := Self.cbbTpoCota.Enabled and vHabilitar;
  Self.edtValCotaAmortizacao.Enabled := Self.edtValCotaAmortizacao.Enabled and vHabilitar;
end;

procedure TfrmAmortizacao.actSairExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAmortizacao.FormShow(Sender: TObject);
begin
  inherited;
  InitFicha();
end;

procedure TfrmAmortizacao.InitFicha;
begin
  Self.StatusForm := sformView;
  Self.edtData.Date := Trunc(Date);
  Self.LoadListaCarteiras();
  Self.LoadComboTipoCota();
end;

procedure TfrmAmortizacao.SetDefaults;
begin
  Self.grpTipoAmortizacao.ItemIndex := 2; // 2 = Ambos (Principal + Rendimento)
  Self.edtValor.Value := 0;
  Self.edtValCotaAmortizacao.Value := 0;
  Self.cbbTpoCota.ItemIndex := 0;
end;

function TfrmAmortizacao.DoAplicar: Boolean;

  function Valida: boolean;
  begin
    Result := False;

    // Validar Data...
    if (Self.edtData.Date = 0) then
    begin
      TMisc.SendMsg('Informe a data.');
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

  procedure CallChanges();
  begin
    Self.grpTipoAmortizacaoChange(nil);
    Self.cbbTpoCotaChange(nil);
  end;

begin
  Result := False;
  try
    if Valida() then
    begin
      Self.SetDefaults();
      if Assigned(FDTO) then
        SafeFree(FDTO);
      FDTO := FController.GetAmortizacaoByDataCarteira( edtData.Date, FDTOCarteira.CodCarteira);
      FDTO.Memento_Snapshot;
      Self.LoadCotaDia;
      Self.DTOToFicha();
      CallChanges();
      Result := True;
    end;
  except
    Raise;
  end;
end;

function TfrmAmortizacao.DoCancelar: Boolean;
begin
  Result := False;
  try
    Self.SetDefaults();
    Result := True;
  except
  end;
end;

procedure TfrmAmortizacao.SetStatusForm(const Value: TStatusForm);
begin
  FStatusForm := Value;
  Self.HabilitarComponentes();
end;

procedure TfrmAmortizacao.FormCreate(Sender: TObject);
begin
  inherited;
  FController := TControllerAmortizacao.Create;
end;

procedure TfrmAmortizacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FListaCarteiras.Free;
  FController.Free;
end;

procedure TfrmAmortizacao.LoadListaCarteiras;
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
  FListaCarteiras := FController.GetListaDeCarteiras(edtData.Date);

  Self.cbbCarteiras.Properties.Items.Clear;
  for i := 0 to FListaCarteiras.Count -1 do
  begin
    vObj := TDTOCarteira(FListaCarteiras[i]);
    Self.cbbCarteiras.Properties.Items.AddObject(IntToStr(vObj.CodCarteira) +' - '+ vObj.NomFantasiaProduto, vObj);
  end;
end;

procedure TfrmAmortizacao.cbbCarteirasPropertiesValidate(Sender: TObject;
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

procedure TfrmAmortizacao.DTOToFicha;
begin
  if (Assigned(FDTO)) and (FDTO.CodAmortizacao > 0) then
  begin
    grpTipoAmortizacao.ItemIndex := FDTO.TpoAmortizacao;
    edtValor.Value := FDTO.ValAmortizacao;
    cbbTpoCota.ItemIndex := Integer(FDTO.TpoCotaAmortizacao);
    edtValCotaAmortizacao.Value := FDTO.ValCotaAmortizacao;
  end;
end;

procedure TfrmAmortizacao.FichaToDTO;
begin
  if Assigned(FDTO) then
  begin
    FDTO.DtaAmortizacao := edtData.Date;
    FDTO.CodCarteira := FDTOCarteira.CodCarteira;
    FDTO.TpoAmortizacao := grpTipoAmortizacao.ItemIndex;
    FDTO.ValAmortizacao := edtValor.Value;
    FDTO.TpoCotaAmortizacao := TTpoCotaAmortizacao(cbbTpoCota.ItemIndex);
    FDTO.ValCotaAmortizacao := edtValCotaAmortizacao.Value;

    { Insere ou Edita }
    if FDTO.CodAmortizacao = 0
      then FDTO.Status := sdtoInsert
      else FDTO.Status := sdtoEdit;
  end;
end;

procedure TfrmAmortizacao.actOKExecute(Sender: TObject);
begin
  inherited;
  if DoSalvar() then
    actCancelar.Execute;
end;

procedure TfrmAmortizacao.edtDataPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  vDate: TDateTime;
begin
  inherited;
  vDate := StrToDate(DisplayValue);
  Error := not (TMisc.DateTimeIsValid(vDate));
  if Error then
  begin
    TMisc.SendMsg('Informe uma data válida.');
  end else
  begin
    Self.edtData.Date := StrToDate(DisplayValue);
    Self.LoadListaCarteiras();
    Self.cbbCarteiras.Text := EmptyStr;
  end;
end;

function TfrmAmortizacao.DoExcluir: Boolean;
begin
  Result := False;
  if TMisc.SendConfirm('Confirma a exclusão dessa amortização?') then
  try
    FController.Delete(FDTO);
    FDTO.Memento_SaveLog(FDUConstantes.LogAmortizacao, 'Exclusão de amortização', FDTO.CodCarteira);
    Result := True;
  except
    Result := False;
  end;
end;

function TfrmAmortizacao.DoSalvar: Boolean;

  function Valida: boolean;
  begin
    Result := False;

    //Add validações...
    
    Result := True;
  end;
  
begin
  Result := False;
  try
    Self.FichaToDTO;
    if Valida() then
      FController.Save(FDTO);
    FDTO.Memento_SaveLog(FDUConstantes.LogAmortizacao, 'Gravação de amortização', FDTO.CodCarteira);
    Result := True;
  except
    on e: exception do
    begin
      TMisc.SendMsg(Format('Ocorreu um erro ao gravar a Amortização: %s',[e.Message]));
      Result := False;
    end;
  end;
end;

procedure TfrmAmortizacao.actExcluirExecute(Sender: TObject);
begin
  inherited;
  if DoExcluir() then
    actCancelar.Execute;
end;

procedure TfrmAmortizacao.LoadComboTipoCota;
var
  I: TTpoCotaAmortizacao;
begin
  cbbTpoCota.Properties.Items.Clear;
  for i := Low(TTpoCotaAmortizacao) to High(TTpoCotaAmortizacao) do
    cbbTpoCota.Properties.Items.Add(DescricaoTpoCotaAmortizacao[i]);
end;

procedure TfrmAmortizacao.cbbTpoCotaChange(Sender: TObject);
begin
  inherited;
  edtValCotaAmortizacao.Enabled :=
    (cbbTpoCota.Enabled) and
    (cbbTpoCota.ItemIndex = Integer(tcaInformada));
end;

procedure TfrmAmortizacao.grpTipoAmortizacaoChange(
  Sender: TObject);
begin
  inherited;
  cbbTpoCota.Enabled := (grpTipoAmortizacao.ItemIndex <> 1); //Somente Rendimento

  if (cbbTpoCota.Enabled)
    then Self.AtualizarCota(FValCotaDigitada)
    else Self.AtualizarCota(FValCotaDia);

  cbbTpoCotaChange(Sender);
end;

procedure TfrmAmortizacao.LoadCotaDia;
begin
  FValCotaDia := FController.GetCotaDia(edtData.Date, FDTOCarteira.CodCarteira);
end;

procedure TfrmAmortizacao.AtualizarCota(const aValCota: Double);
begin
  edtValCotaAmortizacao.Properties.OnEditValueChanged := nil;
  edtValCotaAmortizacao.Value := aValCota;
  edtValCotaAmortizacao.Properties.OnEditValueChanged := edtCotaAmortizacaoChanged
end;

procedure TfrmAmortizacao.edtCotaAmortizacaoChanged(
  Sender: TObject);
begin
  inherited;
  FValCotaDigitada := edtValCotaAmortizacao.Value;
end;

end.


