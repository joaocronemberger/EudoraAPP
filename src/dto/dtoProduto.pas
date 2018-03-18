unit dtoProduto;

interface

uses Generics.Collections, Rest.Json, System.Classes, Vcl.Forms, System.SysUtils,
  Appini, DTOLista;

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

      function Clone(): TProduto;
  end;

  TListaProduto = class(TDTOLista)
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
var
  vObj: TProduto;
begin
  with TStringList.Create do
  try
    if FileExists( Self.GetURL + Self.ClassName + '.json' ) then
      LoadFromFile( Self.GetURL + Self.ClassName + '.json' );

    with TJson.JsonToObject<TListaProduto>(Text) do
    try
      for vObj in Lista do
        Self.Lista.Add( vObj.Clone );
    finally
      Free;
    end;

  finally
    Free;
  end;
end;

procedure TListaProduto.Save;
begin
  with TStringList.Create do
  try
    Text := TJson.ObjectToJsonString( Self );
    SaveToFile( Self.GetURL + Self.ClassName + '.json' );
  finally
    Free;
  end;
end;

{ TProduto }

function TProduto.Clone: TProduto;
begin
  Result := TProduto.Create;
  with Result do
  begin
    Nome := Self.FNome;
    ValorCusto := Self.FValorCusto;
    FValorUnitario := Self.FValorUnitario;
  end;
end;

end.

