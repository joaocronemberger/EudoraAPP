unit daoATDPedidos;

interface

uses
  daoBase, Contnrs, modelATDPedidos, mvcTypes, DBTables;

type
  TDAOATDPedidos = class(TDAOBase)
  private
    function SQLSelectPedidosMigracaoDistribuidor(): String;
    function SQLATDPedido(): String;
    function SQLDeleteByNumPedido: String;
    function SQLAddClientesOcorrencias(const aValidaSeProcessado: Boolean): String;

  public
    procedure DoInsert(const aModel: TModelATDPedidos);
    procedure DoUpdate(const aModel: TModelATDPedidos);
    procedure DoDelete(const aModel: TModelATDPedidos);

    function GetPedidosMigracaoDistribuidor(const aDtaPedido: TDateTime; const aCodCarteira: Integer): TObjectList;
    function GetATDPedido(const aNumPedido: Integer): TModelATDPedidos;
    procedure DeleteByNumPedido(const aNumPedido: Integer);
    function AddClientesOcorrenciaByNumPedido(const aNumPedido: Integer; const aValidaSeProcessado: Boolean): Boolean;
  end;

implementation

uses SysUtils, mvcMiscelania, Variants, StrUtils;

{ TDAOATDPedidos }

procedure TDAOATDPedidos.DoDelete(const aModel: TModelATDPedidos);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOATDPedidos.DoInsert(const aModel: TModelATDPedidos);
begin
  //aModel.NumPedido := Self.GetNextSequence(aModel, 'NumPedido');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOATDPedidos.DoUpdate(const aModel: TModelATDPedidos);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOATDPedidos.SQLSelectPedidosMigracaoDistribuidor: String;
begin
  Result :=
    'select ATD_Pedidos.* '+
    '  from ATD_Pedidos with(nolock) '+
    '  join ATD_Especificacao with(nolock) '+
    '    on ATD_Pedidos.NumPedido = ATD_Especificacao.NumPedido '+
    ' where ATD_Pedidos.TpoOperacao = 3 '+
    '   and ATD_Pedidos.DtaPedido = :pDtaPedido '+
    '   and ATD_Especificacao.CodCarteira = :pCodCarteira '+
    '   and ATD_Pedidos.StaPedido = ''MD'' ';
end;

function TDAOATDPedidos.GetPedidosMigracaoDistribuidor(
  const aDtaPedido: TDateTime; const aCodCarteira: Integer): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 2);
  vListParametros[0].Nome := 'pCodCarteira';
  vListParametros[0].Valor := aCodCarteira;
  vListParametros[1].Nome := 'pDtaPedido';
  vListParametros[1].Valor := FormatDateTime('yyyy-mm-dd',aDtaPedido);

  Result := Self.OpenQueryToList(SQLSelectPedidosMigracaoDistribuidor, vListParametros, TModelATDPedidos);
end;


procedure TDAOATDPedidos.DeleteByNumPedido(const aNumPedido: Integer);
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aNumPedido';
  vListParametros[0].Valor := aNumPedido;

  Self.ExecuteQuery(SQLDeleteByNumPedido, vListParametros);
end;


function TDAOATDPedidos.SQLDeleteByNumPedido: String;
begin
  Result :=
    'delete '+
    '  from ATD_Pedidos '+
    ' where NumPedido = :aNumPedido ';
end;

function TDAOATDPedidos.SQLAddClientesOcorrencias(const aValidaSeProcessado: Boolean): String;
begin
  Result :=
    'declare '+
    '  @NumPedido integer, '+
    '  @SeqEspecificacao integer, '+
    '  @CodCarteira integer, '+
    '  @CodCliente integer, '+
    '  @DtaPedido datetime, '+
    '  @DtaAtual datetime, '+
    '  @ClienteOcorrenciaOut Char(01) '+
    ' '+
    'set @NumPedido = :aNumPedido '+
    'set @DtaAtual = GETDATE() '+
    'set @ClienteOcorrenciaOut = ''N'' '+
    ' '+
    'select @SeqEspecificacao = ATD_Especificacao.SeqEspecificacao, '+
    '       @CodCarteira = ATD_Especificacao.CodCarteira, '+
    '       @DtaPedido = ATD_Especificacao.DtaOperacao,'+
    '       @CodCliente = ATD_Pedidos.CodCliente'+
    '  from ATD_Pedidos with(nolock) '+
    '  join ATD_Especificacao with(nolock) '+
    '    on ATD_Pedidos.NumPedido = ATD_Especificacao.NumPedido'+
    ' where ATD_Pedidos.NumPedido = @NumPedido '+
    ' '+
    'if exists(select * '+
    '            from FDO_EspecificacaoOperacao '+
    '           where SeqEspecificacao = @SeqEspecificacao) '+
    IfThen(not aValidaSeProcessado,' or 1=1 ','') + { Se não ValidaSeProcessado, então força condição dar True com "or 1=1" }
    'begin '+
    '  insert into FDO_ClientesOcorrencia( DtaOcorrencia, CodCarteira, CodCliente, StaProcessado, DtaCota ) '+
    '  values ( @DtaAtual, @CodCarteira, @CodCliente, ''N'', @DtaPedido ) '+
    '  set @ClienteOcorrenciaOut = ''S'' '+
    'end '+
    ' '+
    'select @ClienteOcorrenciaOut as OcorrenciaCriada ';
end;

function TDAOATDPedidos.AddClientesOcorrenciaByNumPedido(
  const aNumPedido: Integer; const aValidaSeProcessado: Boolean): Boolean;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aNumPedido';
  vListParametros[0].Valor := aNumPedido;

  Result := VarToStrDef(Self.OpenQueryReturnField(SQLAddClientesOcorrencias(aValidaSeProcessado), vListParametros, 'OcorrenciaCriada'),'N') = 'S';
end;

function TDAOATDPedidos.GetATDPedido(
  const aNumPedido: Integer): TModelATDPedidos;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aNumPedido';
  vListParametros[0].Valor := aNumPedido;

  Result := TModelATDPedidos( Self.OpenQueryToModel( SQLATDPedido, vListParametros, TModelATDPedidos ) );
end;

function TDAOATDPedidos.SQLATDPedido: String;
begin
  Result :=
    'select * '+
    '  from ATD_Pedidos '+
    ' where NumPedido = :aNumPedido ';
end;

end.


