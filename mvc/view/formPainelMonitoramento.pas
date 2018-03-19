unit formPainelMonitoramento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TEMODELFORMBASICO, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCheckBox,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, ExtCtrls, cxButtonEdit,
  FMTBcd, DBXpress, ImgList, SqlExpr, cxGroupBox, cxLabel, cxSplitter,
  cxDropDownEdit, cxCalendar, cxContainer, cxTextEdit, cxMaskEdit,
  cxSpinEdit, cxLookAndFeelPainters, ActnList, StdCtrls, cxButtons,
  controllerPainelMonitoramento, DBTables, DBClient, Provider,
  dtoConfiguracaoProcessoAutomatico, controllerConfiguracaoProcessoAutomatico,
  cxMemo, Contnrs, Menus, cxCurrencyEdit;

type
  TTipoAlterarFlag = (tafTrue, tafFalse, tafInverse);

  TfrmPainelMonitoramento = class(TfrmModelFormBasico)
    pnlBody: TPanel;
    pnlHeader: TPanel;
    GridTableViewPainel: TcxGridDBTableView;
    GridLevelPainel: TcxGridLevel;
    cxgrdPainel: TcxGrid;
    gridColumnProcessoAutomaticoAtivo: TcxGridDBColumn;
    gridColumnFundo: TcxGridDBColumn;
    gridColumnProcessoDiario: TcxGridDBColumn;
    gridColumnPedidosPendentes: TcxGridDBColumn;
    gridColumnDtaUltimoProcessamento: TcxGridDBColumn;
    gridColumnTipoFundo: TcxGridDBColumn;
    gridColumnButtonLogs: TcxGridDBColumn;
    tmrRefresh: TTimer;
    edtData: TcxDateEdit;
    lblDataReferencia: TcxLabel;
    grpAutoRefresh: TcxGroupBox;
    edtRefresh: TcxSpinEdit;
    btnAplicar: TcxButton;
    actlstPainel: TActionList;
    actAplicar: TAction;
    grpServicoProcessamento: TcxGroupBox;
    lblConfigProcessoAutomatico: TcxLabel;
    lblServicoProcAutomatico: TcxLabel;
    shpLEDStatusServico: TShape;
    shpLEDStatusConfiguracao: TShape;
    shpLinha: TShape;
    lblStatusConfiguracao: TcxLabel;
    lblStatusServico: TcxLabel;
    pnlSplinter: TPanel;
    dsPainel: TDataSource;
    cdsPainel: TClientDataSet;
    chkAutoRefresh: TcxCheckBox;
    lblRefrash: TcxLabel;
    pmPainel: TPopupMenu;
    mniAtivarTodos: TMenuItem;
    actAtivarTodos: TAction;
    actDesativarTodos: TAction;
    actInverterTodos: TAction;
    mniDesativarTodos: TMenuItem;
    mniInverterTodos: TMenuItem;
    procedure gridColumnButtonLogsPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure chkAutoRefreshPropertiesChange(Sender: TObject);
    procedure pnlSplinterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actAplicarExecute(Sender: TObject);
    procedure edtRefreshPropertiesChange(Sender: TObject);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure GridTableViewPainelDataControllerFilterChanged(
      Sender: TObject);
    procedure GridTableViewPainelDataControllerFilterGetValueList(
      Sender: TcxFilterCriteria; AItemIndex: Integer;
      AValueList: TcxDataFilterValueList);
    procedure gridColumnProcessoAutomaticoAtivoPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actAtivarTodosExecute(Sender: TObject);
    procedure actDesativarTodosExecute(Sender: TObject);
    procedure actInverterTodosExecute(Sender: TObject);
  private
    { Private declarations }
    FController: TControllerPainelMonitoramento;
    FControllerConfiguracao: TControllerConfiguracaoProcessoAutomatico;
    FDTOConfig: TDTOConfiguracaoProcessoAutomatico;
    FData: TDateTime;
    FBookmark: TBookmark;

    procedure HabilitarAutoRefresh();

    procedure SaveBookmark;
    procedure GotoBookmark;

    procedure AlterarTodos(const aTipoAlterar: TTipoAlterarFlag);

    procedure SetLedON(aLed: TShape);
    procedure SetLedOFF(aLed: TShape);

    procedure Load();
    procedure Draw();

    procedure DoAplicar(const aAtualizaData: Boolean = False);

    procedure Init();
  public
    { Public declarations }
    class procedure CallFicha();
  end;

var
  frmPainelMonitoramento: TfrmPainelMonitoramento;

implementation

uses
  mvcReferenceManipulator, mvcMiscelania, Math, FDLib01, formLogProcessamento;

{$R *.dfm}

procedure TfrmPainelMonitoramento.gridColumnButtonLogsPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  vLista: TObjectList;
begin
  inherited;
  tmrRefresh.Enabled := False;
  try
    vLista := FController.GetLogsByCarteiraDataCalculo(cdsPainel.FieldByName('CodCarteira').AsInteger, FData);
    if vLista.Count > 0
      then TfrmLogProcessamento.CallFicha(vLista)
      else TMisc.SendMsg('Não foi encontrado nenhuma ocorrência para essa carteira.');
  finally
    SafeFree(vLista);
    HabilitarAutoRefresh;
  end;
end;

procedure TfrmPainelMonitoramento.SetLedOFF(aLed: TShape);
begin
  aLed.Brush.Color := clRed;
  if (shpLEDStatusConfiguracao.Name = aLed.Name)
    then lblStatusConfiguracao.Caption := 'Desligado'
    else lblStatusServico.Caption := 'Inativo';
end;

procedure TfrmPainelMonitoramento.SetLedON(aLed: TShape);
begin
  aLed.Brush.Color := clLime;
  if (shpLEDStatusConfiguracao.Name = aLed.Name)
    then lblStatusConfiguracao.Caption := 'Ligado'
    else lblStatusServico.Caption := 'Ativo';
end;

procedure TfrmPainelMonitoramento.chkAutoRefreshPropertiesChange(
  Sender: TObject);
begin
  inherited;
  Self.HabilitarAutoRefresh();
end;

procedure TfrmPainelMonitoramento.HabilitarAutoRefresh;
var
  vAutoRefresh: Boolean;
begin
  vAutoRefresh := Self.chkAutoRefresh.Checked;

  edtRefresh.Enabled := vAutoRefresh;
  tmrRefresh.Enabled := vAutoRefresh;
end;

class procedure TfrmPainelMonitoramento.CallFicha();
begin
  with TfrmPainelMonitoramento.Create(nil) do
  try
    Init();
    Show;
  finally
  end;
end;

procedure TfrmPainelMonitoramento.Init;
begin
  Self.Load();
  Self.Draw();
end;

procedure TfrmPainelMonitoramento.Draw;
begin
  Self.SetLedOFF(shpLEDStatusConfiguracao);
  Self.SetLedOFF(shpLEDStatusServico);

  if Assigned(FDTOConfig) then
  begin
    if FDTOConfig.StaProcessoAutomatico
      then Self.SetLedON(shpLEDStatusConfiguracao);
    if FDTOConfig.StaServicoAtivado
      then Self.SetLedON(shpLEDStatusServico);

  end;

  gridColumnProcessoAutomaticoAtivo.Visible := (Assigned(FDTOConfig) and FDTOConfig.StaProcessoAutomatico);

  Self.HabilitarAutoRefresh();
end;

procedure TfrmPainelMonitoramento.Load;
begin
  edtData.Date := Trunc(Now);

  if Assigned(FDTOConfig)
    then SafeFree(FDTOConfig);
  FDTOConfig := FControllerConfiguracao.GetConfiguracaoProcessoAutomatico;

  DoAplicar(True);
end;

procedure TfrmPainelMonitoramento.pnlSplinterClick(Sender: TObject);
begin
  inherited;
  pnlHeader.Visible := not pnlHeader.Visible;
//  if pnlHeader.Visible
//    then pnlSplinter.Caption := '.·.'
//    else pnlSplinter.Caption := '·.·';
end;

procedure TfrmPainelMonitoramento.FormCreate(Sender: TObject);
begin
  inherited;
  FController := TControllerPainelMonitoramento.Create;
  FControllerConfiguracao := TControllerConfiguracaoProcessoAutomatico.Create;
end;

procedure TfrmPainelMonitoramento.FormDestroy(Sender: TObject);
begin
  inherited;
  SafeFree(FController);
  SafeFree(FControllerConfiguracao);
end;

procedure TfrmPainelMonitoramento.DoAplicar(const aAtualizaData: Boolean = False);
begin
  if aAtualizaData
    then FData := Trunc(edtData.Date);

  FController.GetPainelMonitoramento(FData, cdsPainel);
end;

procedure TfrmPainelMonitoramento.actAplicarExecute(Sender: TObject);
begin
  inherited;
  DoAplicar(True);
end;

procedure TfrmPainelMonitoramento.edtRefreshPropertiesChange(
  Sender: TObject);
begin
  inherited;
  tmrRefresh.Interval := (1000 * edtRefresh.Value);
end;

procedure TfrmPainelMonitoramento.tmrRefreshTimer(Sender: TObject);
begin
  inherited;
  SaveBookmark;
  DoAplicar;
  GotoBookmark;
end;

procedure TfrmPainelMonitoramento.GridTableViewPainelDataControllerFilterChanged(
  Sender: TObject);
begin
  inherited;
  Self.HabilitarAutoRefresh();
end;

procedure TfrmPainelMonitoramento.GridTableViewPainelDataControllerFilterGetValueList(
  Sender: TcxFilterCriteria; AItemIndex: Integer;
  AValueList: TcxDataFilterValueList);
begin
  inherited;
  tmrRefresh.Enabled := False;
end;

procedure TfrmPainelMonitoramento.gridColumnProcessoAutomaticoAtivoPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  FController.UpdateStaUsaProcessoAutomatico(
    cdsPainel.FieldByName('CodCarteira').AsInteger,
    TcxCheckBox(Sender).Checked);
end;

procedure TfrmPainelMonitoramento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmPainelMonitoramento.GotoBookmark;
begin
  if Assigned(FBookmark) and cdsPainel.BookmarkValid(FBookmark)
    then cdsPainel.GotoBookmark(FBookmark);
end;

procedure TfrmPainelMonitoramento.SaveBookmark;
begin
  FBookmark := cdsPainel.GetBookmark;
end;

procedure TfrmPainelMonitoramento.AlterarTodos(
  const aTipoAlterar: TTipoAlterarFlag);
var
  vNewValue: Boolean;
begin
  Screen.Cursor := crSQLWait;
  GridTableViewPainel.BeginUpdate;
  SaveBookmark;
  try
    cdsPainel.First;
    while (not cdsPainel.Eof) do
    begin
      case aTipoAlterar of
        tafTrue: vNewValue := True;
        tafFalse: vNewValue := False;
        tafInverse: vNewValue := not SNToBool(cdsPainel.FieldByName('Ativo').AsString);
      end;

      if SNToBool(cdsPainel.FieldByName('Ativo').AsString) <> vNewValue then
        FController.UpdateStaUsaProcessoAutomatico(cdsPainel.FieldByName('CodCarteira').AsInteger, vNewValue);

      cdsPainel.Next;
    end;
  finally
    DoAplicar();
    GotoBookmark;
    GridTableViewPainel.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPainelMonitoramento.actAtivarTodosExecute(Sender: TObject);
begin
  inherited;
  AlterarTodos(tafTrue);
end;

procedure TfrmPainelMonitoramento.actDesativarTodosExecute(
  Sender: TObject);
begin
  inherited;
  AlterarTodos(tafFalse);
end;

procedure TfrmPainelMonitoramento.actInverterTodosExecute(Sender: TObject);
begin
  inherited;
  AlterarTodos(tafInverse);
end;

end.
