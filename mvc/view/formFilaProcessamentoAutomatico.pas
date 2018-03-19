unit formFilaProcessamentoAutomatico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TEMODELFORMBASICO, ActnList, XPStyleActnCtrls, ActnMan, Contnrs,
  StdCtrls, Buttons, ExtCtrls, cxControls, cxGroupBox, cxLabel, cxCheckBox,
  cxMemo, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit,
  mvcReferenceManipulator, controllerFilaProcessoAutomatico,
  dtoFilaProcessoAutomatico, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, InstantPresentation, cxLookAndFeelPainters,
  cxButtons, cxDropDownEdit, cxCalendar, dtoCarteira, Menus;

type
  TfrmFilaProcessamentoAutomatico = class(TfrmModelFormBasico)
    pnlBottom: TPanel;
    btnOK: TBitBtn;
    pnlBody: TPanel;
    actFilaProcessoAutomatico: TActionManager;
    actOK: TAction;
    GridTableViewFilaProcesso: TcxGridDBTableView;
    GridLevelFilaProcesso: TcxGridLevel;
    cxgrdFilaProcesso: TcxGrid;
    gridColumnCarteira: TcxGridDBColumn;
    gridColumnProtocolo: TcxGridDBColumn;
    gridColumnDtaOrdem: TcxGridDBColumn;
    gridColumnDtaProcessamentoCota: TcxGridDBColumn;
    gridColumnSituacao: TcxGridDBColumn;
    expFilaProcesso: TInstantExposer;
    pnlHeader: TPanel;
    btnAplicar: TcxButton;
    actAplicar: TAction;
    edtData: TcxDateEdit;
    lblDta: TcxLabel;
    dsFilaProcesso: TDataSource;
    gridColumnID: TcxGridDBColumn;
    pmFila: TPopupMenu;
    mniReprocessar: TMenuItem;
    actReprocessar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actOKExecute(Sender: TObject);
    procedure actAplicarExecute(Sender: TObject);
    procedure gridColumnCarteiraGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: String);
    procedure actReprocessarExecute(Sender: TObject);
  private
    { Private declarations }
    FController: TControllerFilaProcessoAutomatico;
    FLista: TObjectList;
    FListaCarteiras: TObjectList;

    procedure InitFicha();
    procedure LoadConfiguracao();
    procedure LoadCarteiras();

    procedure DTOToFicha();

  public
    { Public declarations }
    class procedure CallFicha();
  end;

implementation

uses
  mvcTypes, enumFilaProcessoAutomatico;

{$R *.dfm}

{ TfrmFilaProcessamentoAutomatico }

class procedure TfrmFilaProcessamentoAutomatico.CallFicha;
begin
  with TfrmFilaProcessamentoAutomatico.Create(nil) do
  try
    InitFicha();
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmFilaProcessamentoAutomatico.InitFicha;
begin
  edtData.Date := Trunc(Now());
  Self.LoadCarteiras();
  Self.LoadConfiguracao();
end;

procedure TfrmFilaProcessamentoAutomatico.LoadConfiguracao;
begin
  SafeFree(FLista);
  FLista := FController.GetFilaProcessoByData( edtData.Date );
  DTOToFicha;
end;

procedure TfrmFilaProcessamentoAutomatico.FormCreate(Sender: TObject);
begin
  inherited;
  FController := TControllerFilaProcessoAutomatico.Create;
end;

procedure TfrmFilaProcessamentoAutomatico.FormDestroy(Sender: TObject);
begin
  inherited;
  SafeFree(FController);
end;

procedure TfrmFilaProcessamentoAutomatico.actOKExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk
end;

procedure TfrmFilaProcessamentoAutomatico.actAplicarExecute(
  Sender: TObject);
begin
  inherited;
  LoadConfiguracao;
end;

procedure TfrmFilaProcessamentoAutomatico.DTOToFicha;
begin
  GridTableViewFilaProcesso.BeginUpdate;
  try
    with expFilaProcesso do
    begin
      Close;
      Subject := FLista;
      Open;
    end;
  finally
    GridTableViewFilaProcesso.EndUpdate;
  end;
end;

procedure TfrmFilaProcessamentoAutomatico.LoadCarteiras;
begin
  SafeFree(FListaCarteiras);
  FListaCarteiras := FController.GetCarteiras();
end;

procedure TfrmFilaProcessamentoAutomatico.gridColumnCarteiraGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);

var
  vDTO: TDTOCarteira;

  function LocateInList(var aCodCarteira: String): TDTOCarteira;
  var
    i: Integer;
    vCodCarteira: Integer;
  begin
    Result := Nil;

    vCodCarteira := StrToIntDef(aCodCarteira, 0);
    for i := 0 to Pred(FListaCarteiras.Count) do
    begin
      if TDTOCarteira(FListaCarteiras.Items[i]).CodCarteira = vCodCarteira then
      begin
        Result := TDTOCarteira(FListaCarteiras.Items[i]);
        Break;
      end;
    end;
  end;

begin
  inherited;
  vDTO := LocateInList(AText);
  if Assigned(vDTO)
    then AText := Format('%d - %s',[vDTO.CodCarteira, vDTO.NomFantasiaProduto]);
end;

procedure TfrmFilaProcessamentoAutomatico.actReprocessarExecute(
  Sender: TObject);
var
  vObj: TDTOFilaProcessoAutomatico;
begin
  inherited;
  vObj := TDTOFilaProcessoAutomatico(expFilaProcesso.CurrentObject);
  FController.AddInFila(vObj.CodCarteira, vObj.DtaCotaProcessamento);
  LoadConfiguracao;
end;

end.
