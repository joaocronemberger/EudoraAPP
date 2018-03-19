unit formPainelMonitoramentoOcorrencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TEMODELFORMBASICO, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxSplitter,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, cxContainer, cxTextEdit,
  cxMemo, cxCalendar, cxDBEdit, InstantPresentation, Contnrs;

type
  TfrmPainelMonitoramentoOcorrencias = class(TfrmModelFormBasico)
    pnlBody: TPanel;
    pnlFooter: TPanel;
    GridTableViewOcorrencias: TcxGridDBTableView;
    GridLevelOcorrencias: TcxGridLevel;
    cxgrdOcorrencias: TcxGrid;
    gridColumnDataHoraInicio: TcxGridDBColumn;
    gridColumnDataHoraTermino: TcxGridDBColumn;
    gridColumnSituacao: TcxGridDBColumn;
    gridColumnUsuarios: TcxGridDBColumn;
    splOcorrencias: TSplitter;
    expOcorrencias: TInstantExposer;
    dsOcorrencias: TDataSource;
    memoOcorrencia: TcxDBMemo;
  private
    { Private declarations }
    FLista: TObjectList;

    procedure Load();

    procedure Init(const aCodCarteira: Integer);
  public
    { Public declarations }
    class procedure CallFicha(const aCodCarteira: Integer);
  end;

implementation

{$R *.dfm}

{ TfrmModelFormBasico1 }

class procedure TfrmPainelMonitoramentoOcorrencias.CallFicha(
  const aCodCarteira: Integer);
begin
  with TfrmPainelMonitoramentoOcorrencias.Create(nil) do
  try
    Init(aCodCarteira);
    ShowModal;
  finally
    Free;
  end;

end;

procedure TfrmPainelMonitoramentoOcorrencias.Init(
  const aCodCarteira: Integer);
begin
  Self.Caption := Format(Self.Caption,[IntToStr(aCodCarteira)]);
end;

end.
