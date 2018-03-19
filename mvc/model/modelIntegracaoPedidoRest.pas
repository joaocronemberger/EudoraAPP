unit modelIntegracaoPedidoRest;

interface

uses
  modelBase, mvcTypes;

type
  TModelIntegracaoPedidoRest = class(TModelBase)
  private
    FNumPedido: Integer;
    FValCota: Double;
    FValIR: Double;
    FValIOF: Double;
    FValCotizado: Double;
    FStaEnviado: String;
    FDesRetorno: String;

  published
      property NumPedido: Integer read FNumPedido write FNumPedido;
      property ValCota: Double read FValCota write FValCota;
      property ValIR: Double read FValIR write FValIR;
      property ValIOF: Double read FValIOF write FValIOF;
      property ValCotizado: Double read FValCotizado write FValCotizado;
      property StaEnviado: String read FStaEnviado write FStaEnviado;
      property DesRetorno: String read FDesRetorno write FDesRetorno;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelIntegracaoPedidoRest }

function TModelIntegracaoPedidoRest.GetIdentity: String;
begin
  Result := '';
end;

function TModelIntegracaoPedidoRest.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'NumPedido';

end;

function TModelIntegracaoPedidoRest.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'NumPedido';

end;

function TModelIntegracaoPedidoRest.GetTableName: String;
begin
  Result := 'FDO_IntegracaoPedidoRest';
end;

end.


