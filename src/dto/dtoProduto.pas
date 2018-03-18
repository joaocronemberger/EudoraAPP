unit dtoProduto;

interface

uses Generics.Collections, Rest.Json, System.Classes, Vcl.Forms, System.SysUtils,
  Appini, JSONConnection;

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
  public
    procedure Save();
    procedure Load();

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

procedure TListaProduto.Load;
begin
  with TStringList.Create do
  try
    if FileExists( TConnections.GetURL + Self.ClassName ) then
      LoadFromFile( TConnections.GetURL + Self.ClassName );

    Self := TJson.JsonToObject< TListaProduto >( Text );
  finally
    Free;
  end;end;

procedure TListaProduto.Save;
begin
  with TStringList.Create do
  try
    Text := TJson.ObjectToJsonString( Self );
    SaveToFile( TConnections.GetURL + Self.ClassName );
  finally
    Free;
  end;
end;

end.

