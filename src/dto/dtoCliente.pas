unit dtoCliente;

interface

uses Generics.Collections;

type
  TCliente = class
  private
    FNome: String;
    FTelefone: String;
    FFacebook: String;
    public
      property Nome: String read FNome write FNome;
      property Telefone: String read FTelefone write FTelefone;
      property Facebook: String read FFacebook write FFacebook;
  end;

  TListaCliente = class
  private
    FLista: TObjectList<TCliente>;
  published
    property Lista: TObjectList<TCliente> read FLista write FLista;

    constructor Create;
    destructor Destroy;
  end;

implementation

{ TListaCliente }

constructor TListaCliente.Create;
begin
  FLista := TObjectList<TCliente>.Create(True);
end;

destructor TListaCliente.Destroy;
begin
  FLista.Free;
end;

end.
