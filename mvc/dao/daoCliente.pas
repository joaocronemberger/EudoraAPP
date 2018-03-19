unit daoCliente;

interface

uses
  daoBase, Contnrs, modelCliente, mvcTypes, DBTables;

type
  TDAOCliente = class(TDAOBase)
  private
    function GetSQLListaCotistasComSaldoByCarteira(): String;
    function SQLSelectClientesMigracaoDistribuidor(): String;
    function SQLCotistaByValue(const aWhere: String = ''): String;

    function SQLAdministradorByValue(const aWhere: String = ''): String;
    function SQLSelectAllAdministradores(): String;

    function SQLGestorByValue(const aWhere: String = ''): String;
    function SQLSelectAllGestores(): String;
  public
    procedure DoInsert(const aModel: TModelCliente);
    procedure DoUpdate(const aModel: TModelCliente);
    procedure DoDelete(const aModel: TModelCliente);

    function GetCotistasComSaldoByCarteira(const aDataProcesso: TDateTime; const aCodCarteira: Integer): TObjectList;
    function GetClientesMigracaoDistribuidor(const aDtaPedido: TDateTime; const aCodCarteira: Integer): TObjectList;

    function GetCotistaByValue(const aValue: String; const aWhere: String = ''): TObjectList;
    function GetAdministradorByValue(const aValue: String; const aWhere: String = ''): TObjectList;
    function GetGestorByValue(const aValue: String; const aWhere: String = ''): TObjectList;

    function GetAllAdministradores(): TObjectList;
    function GetAllGestores(): TObjectList;


  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOCliente }

procedure TDAOCliente.DoDelete(const aModel: TModelCliente);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOCliente.DoInsert(const aModel: TModelCliente);
begin
  //aModel.CodCliente := Self.GetNextSequence(aModel, 'CodCliente');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOCliente.DoUpdate(const aModel: TModelCliente);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOCliente.GetCotistasComSaldoByCarteira(
  const aDataProcesso: TDateTime;
  const aCodCarteira: Integer): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 2);
  vListParametros[0].Nome := 'pDataProcesso';
  vListParametros[0].Valor := FormatDateTime('yyyy-mm-dd',aDataProcesso);
  vListParametros[1].Nome := 'pCodCarteira';
  vListParametros[1].Valor := aCodCarteira;

  Result := Self.OpenQueryToList(GetSQLListaCotistasComSaldoByCarteira, vListParametros, TModelCliente);
end;

function TDAOCliente.GetClientesMigracaoDistribuidor(
  const aDtaPedido: TDateTime; const aCodCarteira: Integer): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 2);
  vListParametros[0].Nome := 'pCodCarteira';
  vListParametros[0].Valor := aCodCarteira;
  vListParametros[1].Nome := 'pDtaPedido';
  vListParametros[1].Valor := FormatDateTime('yyyy-mm-dd',aDtaPedido);

  Result := Self.OpenQueryToList(SQLSelectClientesMigracaoDistribuidor, vListParametros, TModelCliente);

end;

function TDAOCliente.GetSQLListaCotistasComSaldoByCarteira: String;
begin
  Result :=
    'exec SPT_FDO_SEL_RetornaSaldoEmCotas :pCodCarteira, null, :pDataProcesso';
end;

function TDAOCliente.SQLSelectClientesMigracaoDistribuidor: String;
begin
  Result :=
    'select CLI_Geral.CodCliente, CLI_Geral.NomCliente, CLI_Geral.NomCompCliente '+
    '  from CLI_Geral with(nolock) '+
    '  join ATD_Pedidos with(nolock) '+
    '    on ATD_Pedidos.CodCliente = CLI_Geral.CodCliente '+
    '  join ATD_Especificacao with(nolock) '+
    '    on ATD_Pedidos.NumPedido = ATD_Especificacao.NumPedido '+
    ' where ATD_Pedidos.TpoOperacao = 3 '+
    '   and ATD_Pedidos.DtaPedido = :pDtaPedido '+
    '   and ATD_Especificacao.CodCarteira = :pCodCarteira '+
    '   and ATD_Pedidos.StaPedido = ''MD'' ';
end;

function TDAOCliente.SQLAdministradorByValue(const aWhere: String = ''): String;
var
  vWhere: String;
begin
  vWhere := EmptyStr;
  if (aWhere <> EmptyStr) then
    vWhere := ' AND ' + Trim(aWhere) + ' ';

  Result :=
    'declare @aCod int '+
    ''+
    'select @aCod = CLI_Geral.CodCliente '+
    '  from FDO_Administrador with(nolock) '+
    '  join CLI_Geral with(nolock) '+
    '    on (FDO_Administrador.CodAdministrador = CLI_Geral.codcliente) '+
    ' where CLI_Geral.CodCliente = dbo.FN_RetornaSoNumeros(:aValue) '+
    vWhere+
    ''+
    'select CLI_Geral.CodCliente, '+
    '       CLI_Geral.NomCliente '+
    '  from FDO_Administrador with(nolock) '+
    '  join CLI_Geral with(nolock) '+
    '    on (FDO_Administrador.CodAdministrador = CLI_Geral.codcliente) '+
    ' where ((( @aCod IS NOT NULL ) AND ( CLI_Geral.CodCliente = @aCod )) '+
    '        or (( @aCod IS NULL ) AND ( CLI_Geral.CodCliente like :aValue or CLI_Geral.NomCliente like :aValue))) '+
    vWhere;
end;

function TDAOCliente.SQLCotistaByValue(const aWhere: String = ''): String;
var
  vWhere: String;
begin
  vWhere := EmptyStr;
  if (aWhere <> EmptyStr) then
    vWhere := ' AND ' + Trim(aWhere) + ' ';

  Result :=
    'declare @aCod int '+
    ''+
    'select @aCod = CLI_Geral.CodCliente '+
    '  from FDO_Cotista with(nolock) '+
    '  join CLI_Geral with(nolock) '+
    '    on (FDO_Cotista.codcliente = CLI_Geral.codcliente) '+
    ' where CLI_Geral.CodCliente = dbo.FN_RetornaSoNumeros(:aValue) '+
    vWhere+
    ''+
    'select CLI_Geral.CodCliente, '+
    '       CLI_Geral.NomCliente '+
    '  from FDO_Cotista with(nolock) '+
    '  join CLI_Geral with(nolock) '+
    '    on (FDO_Cotista.codcliente = CLI_Geral.codcliente) '+
    ' where ((( @aCod IS NOT NULL ) AND ( CLI_Geral.CodCliente = @aCod )) '+
    '        or (( @aCod IS NULL ) AND ( CLI_Geral.CodCliente like :aValue or CLI_Geral.NomCliente like :aValue))) '+
    vWhere;
end;

function TDAOCliente.SQLGestorByValue(const aWhere: String = ''): String;
var
  vWhere: String;
begin
  vWhere := EmptyStr;
  if (aWhere <> EmptyStr) then
    vWhere := ' AND ' + Trim(aWhere) + ' ';

  Result :=
    'declare @aCod int '+
    ''+
    'select @aCod = CLI_Geral.CodCliente '+
    '  from FDO_Gestor with(nolock) '+
    '  join CLI_Geral with(nolock) '+
    '    on (FDO_Gestor.CodGestor = CLI_Geral.codcliente) '+
    ' where CLI_Geral.CodCliente = dbo.FN_RetornaSoNumeros(:aValue) '+
    vWhere+
    ''+
    'select CLI_Geral.CodCliente, '+
    '       CLI_Geral.NomCliente '+
    '  from FDO_Gestor with(nolock) '+
    '  join CLI_Geral with(nolock) '+
    '    on (FDO_Gestor.CodGestor = CLI_Geral.codcliente) '+
    ' where ((( @aCod IS NOT NULL ) AND ( CLI_Geral.CodCliente = @aCod )) '+
    '        or (( @aCod IS NULL ) AND ( CLI_Geral.CodCliente like :aValue or CLI_Geral.NomCliente like :aValue))) '+
    vWhere;
end;

function TDAOCliente.GetAdministradorByValue(const aValue: String; const aWhere: String = ''): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aValue';
  vListParametros[0].Valor := '%'+aValue+'%';

  Result := Self.OpenQueryToList(SQLAdministradorByValue(aWhere), vListParametros, TModelCliente);
end;

function TDAOCliente.GetCotistaByValue(const aValue: String; const aWhere: String = ''): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aValue';
  vListParametros[0].Valor := '%'+aValue+'%';

  Result := Self.OpenQueryToList(SQLCotistaByValue(aWhere), vListParametros, TModelCliente);
end;

function TDAOCliente.GetGestorByValue(const aValue: String; const aWhere: String = ''): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aValue';
  vListParametros[0].Valor := '%'+aValue+'%';

  Result := Self.OpenQueryToList(SQLGestorByValue(aWhere), vListParametros, TModelCliente);
end;

function TDAOCliente.SQLSelectAllAdministradores: String;
begin
  Result :=
    'select CLI_Geral.CodCliente, CLI_Geral.NomCliente, CLI_Geral.NomCompCliente  '+
    '  from FDO_Administrador with(nolock) '+
    '  join CLI_Geral with(nolock) '+
    '    on (FDO_Administrador.CodAdministrador = CLI_Geral.codcliente) ';
end;

function TDAOCliente.SQLSelectAllGestores: String;
begin
  Result :=
    'select CLI_Geral.CodCliente, CLI_Geral.NomCliente, CLI_Geral.NomCompCliente  '+
    '  from FDO_Gestor with(nolock) '+
    '  join CLI_Geral with(nolock) '+
    '    on (FDO_Gestor.CodGestor = CLI_Geral.codcliente) ';
end;

function TDAOCliente.GetAllAdministradores: TObjectList;
begin
  Result := Self.OpenQueryToList(SQLSelectAllAdministradores, TModelCliente);
end;

function TDAOCliente.GetAllGestores: TObjectList;
begin
  Result := Self.OpenQueryToList(SQLSelectAllGestores, TModelCliente);
end;

end.


