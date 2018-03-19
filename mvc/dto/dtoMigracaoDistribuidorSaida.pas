unit dtoMigracaoDistribuidorSaida;

interface

uses
  dtoBase, Contnrs;

type
  TDTOMigracaoDistribuidorSaida = class(TDTOBase)
  private
    FDtaMigracao: TDateTime;
    FCodCarteira: Integer;
    FListaCliente: TObjectList;

  published
      property DtaMigracao: TDateTime read FDtaMigracao write FDtaMigracao;
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property ListaCliente: TObjectList read FListaCliente write FListaCliente;

  public
    constructor Create();
    destructor Destroy(); Override;
  end;

implementation

uses
  mvcReferenceManipulator;

{ TDTOMigracaoDistribuidorSaida }

constructor TDTOMigracaoDistribuidorSaida.Create;
begin
  inherited Create();
  FListaCliente := TObjectList.Create(True);
end;

destructor TDTOMigracaoDistribuidorSaida.Destroy;
begin
  SafeFree(FListaCliente);
  inherited Destroy();
end;

end.


