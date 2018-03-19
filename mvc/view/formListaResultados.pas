unit formListaResultados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  InstantPresentation, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, Contnrs;

type
  TfrmListaResultados = class(TForm)
    pnlBody: TPanel;
    pnlFooter: TPanel;
    btnSair: TBitBtn;
    btnOK: TBitBtn;
    TableViewListaResultados: TcxGridDBTableView;
    GridLevelListaResultados: TcxGridLevel;
    gridListaResultados: TcxGrid;
    gridColumnCodigo: TcxGridDBColumn;
    gridColumnNome: TcxGridDBColumn;
    expListaResultados: TInstantExposer;
    dsListaResultados: TDataSource;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TableViewListaResultadosDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadGrid(const aColCodigo, aColNome: String);
    procedure LoadLista(const aList: TObjectList);

    function GetSelected(): TObject;

  public
    { Public declarations }
    class function ExibeListaResultados(const aList: TObjectList; const aColCodigo, aColNome: String): TObject;
  end;

var
  frmListaResultados: TfrmListaResultados;

implementation

{$R *.dfm}

{ TForm1 }

class function TfrmListaResultados.ExibeListaResultados(const aList: TObjectList;
  const aColCodigo, aColNome: String): TObject;
begin
  with TfrmListaResultados.Create(nil) do
  try
    LoadGrid(aColCodigo, aColNome);
    LoadLista(aList);
    if (ShowModal = mrOk)
      then Result := GetSelected
      else Result := nil;
  finally
    Free;
  end;
end;

function TfrmListaResultados.GetSelected: TObject;
begin
  Result := expListaResultados.CurrentObject;
end;

procedure TfrmListaResultados.LoadGrid(const aColCodigo, aColNome: String);
begin
  TableViewListaResultados.Columns[gridColumnCodigo.Index].DataBinding.FieldName := aColCodigo;
  TableViewListaResultados.Columns[gridColumnNome.Index].DataBinding.FieldName := aColNome;
end;

procedure TfrmListaResultados.LoadLista(const aList: TObjectList);
begin
  if expListaResultados.Active
    then expListaResultados.Close;
    
  expListaResultados.ObjectClassName := aList.First.ClassName;
  expListaResultados.Subject := aList;

  expListaResultados.Open;

end;

procedure TfrmListaResultados.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ( Key = VK_ESCAPE )
    then ModalResult := mrCancel;
  if ( Key = VK_RETURN )
    then ModalResult := mrOk;
end;

procedure TfrmListaResultados.TableViewListaResultadosDblClick(
  Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
