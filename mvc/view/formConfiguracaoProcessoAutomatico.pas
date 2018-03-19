unit formConfiguracaoProcessoAutomatico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TEMODELFORMBASICO, ActnList, XPStyleActnCtrls, ActnMan,
  StdCtrls, Buttons, ExtCtrls, cxControls, cxGroupBox, cxLabel, cxCheckBox,
  cxMemo, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit,
  mvcReferenceManipulator, controllerConfiguracaoProcessoAutomatico,
  dtoConfiguracaoProcessoAutomatico, formFilaProcessamentoAutomatico;

type
  TfrmConfiguracaoProcessoAutomatico = class(TfrmModelFormBasico)
    pnlBottom: TPanel;
    btnOK: TBitBtn;
    btnSair: TBitBtn;
    actConfigProcessoAutomatico: TActionManager;
    actCancelar: TAction;
    actOK: TAction;
    pnlBody: TPanel;
    grpProcessamentoAutomatico: TcxGroupBox;
    edtIntervalo: TcxSpinEdit;
    memoPeriodo: TcxMemo;
    chkUsaProcessamentoAutomatico: TcxCheckBox;
    lblIntervaloProcessamento: TcxLabel;
    lblPeriodoExecucao: TcxLabel;
    btnFilaProcessamento: TBitBtn;
    actFilaProcessamento: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkUsaProcessamentoAutomaticoPropertiesChange(
      Sender: TObject);
    procedure actOKExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actFilaProcessamentoExecute(Sender: TObject);
  private
    { Private declarations }
    FController: TControllerConfiguracaoProcessoAutomatico;
    FDTO: TDTOConfiguracaoProcessoAutomatico;
    FServicoAtivado: Boolean;

    procedure InitFicha();
    procedure LoadConfiguracao();
    procedure HabilitarComponentes();

    procedure DTOToFicha();
    procedure FichaToDTO();

    function DoGravar(): Boolean;
    function DoCancelar(): Boolean;
  public
    { Public declarations }
    class procedure CallFicha();
  end;

implementation

uses
  mvcTypes, FDUConstantes;

{$R *.dfm}

{ TfrmConfiguracaoProcessoAutomatico }

class procedure TfrmConfiguracaoProcessoAutomatico.CallFicha;
begin
  with TfrmConfiguracaoProcessoAutomatico.Create(nil) do
  try
    InitFicha();
    ShowModal;
  finally
    Free;
  end;
end;

function TfrmConfiguracaoProcessoAutomatico.DoCancelar: Boolean;
begin
  Result := True;
end;

function TfrmConfiguracaoProcessoAutomatico.DoGravar: Boolean;
begin
  Result := True;

  FDTO.Memento_Snapshot; //Salva status anterior

  FichaToDTO;
  FController.Save(FDTO);

  FDTO.Memento_SaveLog(FDUConstantes.LogConfigProcessAutomatico, 'Gravação das configurações de processo automático');
end;

procedure TfrmConfiguracaoProcessoAutomatico.DTOToFicha;
begin
  if (Assigned(FDTO)) then
  begin
    chkUsaProcessamentoAutomatico.Checked := FDTO.StaProcessoAutomatico;
    edtIntervalo.Value := FDTO.IntervaloProcessamento;
    memoPeriodo.Lines.Text := FDTO.PeriodoExecucao;
    FServicoAtivado := FDTO.StaServicoAtivado;
  end
  else
  begin
    FServicoAtivado := False;
  end;
end;

procedure TfrmConfiguracaoProcessoAutomatico.FichaToDTO;
begin

  if not(Assigned(FDTO)) then
  begin
    FDTO := TDTOConfiguracaoProcessoAutomatico.Create;
    FDTO.Status := sdtoInsert;
  end else
    FDTO.Status := sdtoEdit;

  FDTO.StaProcessoAutomatico := chkUsaProcessamentoAutomatico.Checked;
  FDTO.IntervaloProcessamento := edtIntervalo.Value;
  FDTO.PeriodoExecucao := memoPeriodo.Lines.Text;
  FDTO.StaServicoAtivado := FServicoAtivado;

end;

procedure TfrmConfiguracaoProcessoAutomatico.HabilitarComponentes;
var
  vHabilitar: Boolean;
begin
  vHabilitar := chkUsaProcessamentoAutomatico.Checked;

  edtIntervalo.Enabled := vHabilitar;
  memoPeriodo.Enabled := vHabilitar;

end;

procedure TfrmConfiguracaoProcessoAutomatico.InitFicha;
begin
  Self.LoadConfiguracao();
  Self.HabilitarComponentes();
  Self.DTOToFicha()
end;

procedure TfrmConfiguracaoProcessoAutomatico.LoadConfiguracao;
begin
  FDTO := FController.GetConfiguracaoProcessoAutomatico;
end;

procedure TfrmConfiguracaoProcessoAutomatico.FormCreate(Sender: TObject);
begin
  inherited;
  FController := TControllerConfiguracaoProcessoAutomatico.Create;
end;

procedure TfrmConfiguracaoProcessoAutomatico.FormDestroy(Sender: TObject);
begin
  inherited;
  SafeFree(FController);
  SafeFree(FDTO);
end;

procedure TfrmConfiguracaoProcessoAutomatico.chkUsaProcessamentoAutomaticoPropertiesChange(
  Sender: TObject);
begin
  inherited;
  Self.HabilitarComponentes();
end;

procedure TfrmConfiguracaoProcessoAutomatico.actOKExecute(Sender: TObject);
begin
  inherited;
  if DoGravar() then
    ModalResult := mrOk
end;

procedure TfrmConfiguracaoProcessoAutomatico.actCancelarExecute(
  Sender: TObject);
begin
  inherited;
  if DoCancelar() then
    ModalResult := mrCancel;
end;

procedure TfrmConfiguracaoProcessoAutomatico.actFilaProcessamentoExecute(
  Sender: TObject);
begin
  inherited;
  TfrmFilaProcessamentoAutomatico.CallFicha;
end;

end.
