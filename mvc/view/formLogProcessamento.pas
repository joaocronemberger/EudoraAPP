unit formLogProcessamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxTreeView, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  cxGridTableView, cxGridLevel, cxGridCustomTableView, cxGridCardView,
  cxClasses, cxGridCustomView, cxGrid, StdCtrls, dtoLogProcessamento, Contnrs,
  DB, cxDBData, cxGridDBTableView, InstantPresentation, cxMemo,
  cxGridDBCardView, cxTextEdit, controllerLogProcessamento, enumLogProcessamento,
  FMTBcd, SqlExpr, DBXpress, CRSQLConnection, cxBlobEdit;

type
  TfrmLogProcessamento = class(TForm)
    pnlBody: TPanel;
    GridLogProcessamento: TcxGrid;
    GridLevelLogProcesso: TcxGridLevel;
    pnlFooter: TPanel;
    btnOk: TButton;
    expLog: TInstantExposer;
    dsLog: TDataSource;
    GridTableViewLogProcessamento: TcxGridDBTableView;
    gridColumnCarteira: TcxGridDBColumn;
    gridColumnDataProcesso: TcxGridDBColumn;
    gridColumnDtaInicio: TcxGridDBColumn;
    gridColumnDtaFinal: TcxGridDBColumn;
    gridColumnStatus: TcxGridDBColumn;
    GridLevelLogTexto: TcxGridLevel;
    GridTableViewLogTexto: TcxGridDBTableView;
    gridColumnLogTexto: TcxGridDBColumn;
    expLog2: TInstantExposer;
    dsLog2: TDataSource;
    lblLegenda: TLabel;
    spLog2LogProcessamentoText: TStringField;
    spLog2CodLogProcessamento: TIntegerField;
    procedure GridTableViewLogProcessamentoCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure gridColumnCarteiraGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: String);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FListaCarteiras: TObjectList;
    FListaLog: TObjectList;
    FController: TControllerLogProcessamento;
    FSkipSucess: Boolean;

    constructor Create(); reintroduce; overload;
    destructor Destroy(); override;

    procedure DTOToView();
    procedure LoadCarteiras();
    procedure CloneToInternalList(const aList: TObjectList);
  public
    class procedure CallFicha(const aList: TObjectList; const aSkipSucess: Boolean = False);
  end;

var
  frmLogProcessamento: TfrmLogProcessamento;

implementation

uses
  mvcReferenceManipulator, dtoCarteira, Math, assemblerLogProcessamento;

{$R *.dfm}

{ TForm1 }

constructor TfrmLogProcessamento.Create;
begin
  inherited Create(nil);

  FListaLog := TObjectList.Create(True);
  FController := TControllerLogProcessamento.Create;
end;

destructor TfrmLogProcessamento.Destroy;
begin

  if Assigned(FListaLog) then
  begin
    FListaLog.Clear;
    SafeFree(FListaLog);
  end;

  if Assigned(FListaCarteiras) then
  begin
    FListaCarteiras.Clear;
    SafeFree(FListaCarteiras);
  end;

  SafeFree(FController);

  inherited Destroy;
end;

procedure TfrmLogProcessamento.DTOToView();
var
  i: integer;
  vDTO: TDTOLogProcessamento;
begin
  expLog.Close;
  expLog2.Close;

  if FListaLog.Count > 0 then
  begin
    expLog.Subject := FListaLog;
    expLog.Open;
    expLog.RefreshData;

    expLog2.Subject := FListaLog;
    expLog2.Open;
    expLog2.RefreshData;
  end;
end;

class procedure TfrmLogProcessamento.CallFicha(
  const aList: TObjectList; const aSkipSucess: Boolean = False);
begin
  with TfrmLogProcessamento.Create do
  try
    FSkipSucess := aSkipSucess;
    if (aList.Count > 0) then
    begin
      CloneToInternalList(aList);
      LoadCarteiras();
      DTOToView();
      ShowModal;
    end;
  finally
    Free;
  end;
end;

procedure TfrmLogProcessamento.GridTableViewLogProcessamentoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  vValor: String;
begin

  vValor := VarToStrDef(GridTableViewLogProcessamento.ViewData.Records[AViewInfo.GridRecord.Index].Values[gridColumnStatus.Index], 'S');
  ACanvas.Font.Color := clBlack;

  if (vValor = 'S') then
  begin
    ACanvas.Brush.Color := $77E698; { Verde }
  end else
  if (vValor = 'W') then
  begin
    ACanvas.Brush.Color := $90f5ff; { Amarelo }
  end else
  if (vValor = 'E') then
  begin
    ACanvas.Brush.Color := $534FFF; { Vermelho }
  end;

end;

procedure TfrmLogProcessamento.LoadCarteiras;
begin
  if Assigned(FListaCarteiras) then
  begin
    FListaCarteiras.Clear;
    SafeFree(FListaCarteiras);
  end;
  FListaCarteiras := FController.GetListaDeCarteiras();
end;

procedure TfrmLogProcessamento.gridColumnCarteiraGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
var
  i: Integer;
begin
  { Método que exibe o nome da carteira }
  for i := 0 to Pred(FListaCarteiras.Count) do
  begin

    { Escreve "TODOS" quando for 0 }
    if StrToIntDef(AText,0) = 0 then
    begin
      AText := 'TODOS';
      Break;
    end;

    { Escreve "TODOS" quando for 0 }
    if StrToIntDef(AText,0) = TDTOCarteira(FListaCarteiras[i]).CodCarteira then
    begin
      AText := IntToStr(TDTOCarteira(FListaCarteiras[i]).CodCarteira) + ' - ' + TDTOCarteira(FListaCarteiras[i]).NomFantasiaProduto;
      Break;
    end;
  end;
end;

procedure TfrmLogProcessamento.CloneToInternalList(
  const aList: TObjectList);
var
  i, index: Integer;
  vDTO: TDTOLogProcessamento;
  vCarteirasJaAdd: TStringList;
begin
  if Assigned(aList) and (aList.Count > 0) then
  begin

    for i := 0 to Pred(aList.Count) do
    begin
      vDTO := TDTOLogProcessamento.Create;
      TAssemblerLogProcessamento.DTOToDTO(TDTOLogProcessamento(aList[i]), vDTO);
      if (not FSkipSucess) or (vDTO.StaCalculo in [enumLogProcessamento.staCalcWarning, enumLogProcessamento.staCalcError]) then
      begin
        FListaLog.Add(vDTO);
      end;
    end;

    { Se não existir nenhum item diferente de sucesso, então mostra uma
      ocorrencia por carteiras
    }
    if FSkipSucess and (FListaLog.Count = 0) then
    begin
      vCarteirasJaAdd := TStringList.Create;
      try

        for i := 0 to Pred(aList.Count) do
        begin
          vDTO := TDTOLogProcessamento.Create;
          TAssemblerLogProcessamento.DTOToDTO(TDTOLogProcessamento(aList[i]), vDTO);
          if not vCarteirasJaAdd.Find(IntToStr(vDTO.CodCarteira), Index) then
          begin
            vDTO.DtaCalculoCota := 0;
            FListaLog.Add(vDTO);
            vCarteirasJaAdd.Add(IntToStr(vDTO.CodCarteira));
          end;
        end;

      finally
        SafeFree(vCarteirasJaAdd);
      end;
    end;
  end;
end;

procedure TfrmLogProcessamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key in [VK_ESCAPE,VK_RETURN])
    then ModalResult := mrOk;
end;

end.
