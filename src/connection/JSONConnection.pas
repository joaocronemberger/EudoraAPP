unit JSONConnection;

interface

uses Rest.Json, System.Classes, Vcl.Forms, System.SysUtils, Appini,
  dtoProduto;

type
  TConnections = class
  private
    FListaProduto: TListaProduto;
  public
    property ListaProduto: TListaProduto read FListaProduto write FListaProduto;

    constructor Create();
    destructor Destroy();
  end;

  function Connection: TConnections;

var
  _Connection: TConnections;

implementation

function Connection(): TConnections;
begin
  if not Assigned(_Connection)
    then _Connection := TConnections.Create;
  Result := _Connection;
end;


{ TConnections }

destructor TConnections.Destroy;
begin
  FListaProduto.Free;
end;

{ TConnections }

constructor TConnections.Create;
begin
  FListaProduto := TListaProduto.Create;
  FListaProduto.Load;
end;


end.
