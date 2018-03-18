unit dtoProduto;

interface

uses Generics.Collections;

type
  TProduto = class
  private
    FNome: String;
    FValorCusto: Currency;
    FValorUnitario: Currency;
    public
      property Nome: String read FNome write FNome;
      property ValorCusto: Currency read FValorCusto write FValorCusto;
      property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
  end;

  TListaProduto = class
  private
    FLista: TObjectList<TProduto>;
  published
    property Lista: TObjectList<TProduto> read FLista write FLista;

    constructor Create;
    destructor Destroy;
  end;

implementation

{ TListaProduto }

constructor TListaProduto.Create;
begin
  FLista := TObjectList<TProduto>.Create(True);
end;

destructor TListaProduto.Destroy;
begin
  FLista.Free;
end;

end.

