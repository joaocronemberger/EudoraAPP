unit dtoVenda;

interface

uses Generics.Collections, dtoCliente;

type
  TVenda = class
  private
    FCliente: TCliente;
    public
      property Cliente: TCliente read FCliente write FCliente;
  end;

  TListaVenda = class
  private
    FLista: TObjectList<TVenda>;
  published
    property Lista: TObjectList<TVenda> read FLista write FLista;

    constructor Create;
    destructor Destroy;
  end;

implementation

{ TListaVenda }

constructor TListaVenda.Create;
begin
  FLista := TObjectList<TVenda>.Create(True);
end;

destructor TListaVenda.Destroy;
begin
  FLista.Free;
end;

end.

