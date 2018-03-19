unit daoCarteira;

interface

uses
  SysUtils, daoBase, Contnrs, modelCarteira, mvcTypes, DBTables;

type
  TDAOCarteira = class(TDAOBase)
  private
    function GetSQLListaCarteira(): String;
    function GetSQLCarteira(): String;
    function GetSQLTodasCarteiras(): String;
    function SQLCarteiraByValue(const aWhere: String = ''): String;
    function SQLProcessamentoCotaByCarteira(): String;
  public

    function GetCarteira(const aCodCarteira: Integer): TModelCarteira;

    function GetListaDeCarteiras(const aDataProcesso: TDateTime): TObjectList;
    function GetListaDeTodasCarteiras(): TObjectList;
    function GetCarteiraByValue(const aValue: String; const aWhere: String = ''): TObjectList;

    function GetValCotaInicialByCarteira(const aCodCarteira: Integer): Double;
    function GetStaFundoFehcadoByCarteira(const aCodCarteira: Integer): Boolean;
    function GetDtaUltProcessamento(const aCodCarteira: Integer): TDateTime;

  end;

implementation

uses mvcMiscelania, Variants;

{ TDAOCarteira }

function TDAOCarteira.GetCarteira(
  const aCodCarteira: Integer): TModelCarteira;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;

  Result := TModelCarteira(Self.OpenQueryToModel(GetSQLCarteira, vListParametros, TModelCarteira));
end;

function TDAOCarteira.GetCarteiraByValue(const aValue: String; const aWhere: String = ''): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aValue';
  vListParametros[0].Valor := '%'+aValue+'%';

  Result := Self.OpenQueryToList(SQLCarteiraByValue(aWhere), vListParametros, TModelCarteira);
end;

function TDAOCarteira.GetDtaUltProcessamento(
  const aCodCarteira: Integer): TDateTime;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aCodCarteira';
  vListParametros[0].Valor := aCodCarteira;

  Result := VarToDateTime(Self.OpenQueryReturnField(SQLProcessamentoCotaByCarteira, vListParametros, 'DtaUltProcessamento'));
end;

function TDAOCarteira.GetListaDeCarteiras(
  const aDataProcesso: TDateTime): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'pDtaCriacao';
  vListParametros[0].Valor := FormatDateTime('yyyy-mm-dd',aDataProcesso);

  Result := Self.OpenQueryToList(GetSQLListaCarteira, vListParametros, TModelCarteira);
end;

function TDAOCarteira.GetListaDeTodasCarteiras: TObjectList;
begin
  Result := Self.OpenQueryToList(GetSQLTodasCarteiras(), TModelCarteira);
end;

function TDAOCarteira.GetSQLCarteira: String;
begin
  Result :=
    'select FDO_Carteira.CodCarteira, '+
    '       FDO_Carteira.ValCotaInicial, '+
    '       FDO_Carteira.StaFdoCondFechado, '+
    '       FDO_Carteira.TpoApurarCota, '+
    '       FDO_Carteira.DtaCriacao, '+
    '       CLI_Produto.NomFantasiaProduto '+
    '  from FDO_Carteira '+
    '  join CLI_Produto '+
    '    on CLI_Produto.CodCliente = FDO_Carteira.CodCarteira '+
    ' where FDO_Carteira.CodCarteira = :CodCarteira ';
end;

function TDAOCarteira.GetSQLListaCarteira: String;
begin
  Result :=
    'select FDO_Carteira.CodCarteira, '+
    '       FDO_Carteira.ValCotaInicial, '+
    '       CLI_Produto.NomFantasiaProduto '+
    '  from FDO_Carteira '+
    '  join CLI_Produto '+
    '    on CLI_Produto.CodCliente = FDO_Carteira.CodCarteira '+
    ' where StaFdoCondFechado = ''S'' '+
    '   and DtaCriacao <= :pDtaCriacao ';
end;

function TDAOCarteira.GetSQLTodasCarteiras: String;
begin
  Result :=
    'select FDO_Carteira.CodCarteira, '+
    '       CLI_Produto.NomFantasiaProduto '+
    '  from FDO_Carteira '+
    '  join CLI_Produto '+
    '    on CLI_Produto.CodCliente = FDO_Carteira.CodCarteira ';
end;

function TDAOCarteira.GetStaFundoFehcadoByCarteira(
  const aCodCarteira: Integer): Boolean;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;

  Result := (VarToStrDef(Self.OpenQueryReturnField(GetSQLCarteira, vListParametros, 'StaFdoCondFechado'),'N') = 'S');
end;

function TDAOCarteira.GetValCotaInicialByCarteira(
  const aCodCarteira: Integer): Double;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;

  Result := StrToFloatDef(VarToStr(Self.OpenQueryReturnField(GetSQLCarteira, vListParametros, 'ValCotaInicial')),0);
end;

function TDAOCarteira.SQLCarteiraByValue(const aWhere: String = ''): String;
var
  vWhere: String;
begin
  vWhere := EmptyStr;
  if (aWhere <> EmptyStr) then
    vWhere := ' AND ' + Trim(aWhere) + ' ';

  Result :=
    'declare @aCod int '+
    ''+
    'select @aCod = FDO_Carteira.CodCarteira '+
    '  from FDO_Carteira with(nolock) '+
    '  join CLI_Produto with(nolock) '+
    '    on CLI_Produto.CodCliente = FDO_Carteira.CodCarteira '+
    ' where FDO_Carteira.CodCarteira = dbo.FN_RetornaSoNumeros(:aValue) '+
    vWhere+
    ''+
    'select FDO_Carteira.CodCarteira, '+
    '       CLI_Produto.NomFantasiaProduto '+
    '  from FDO_Carteira with(nolock) '+
    '  join CLI_Produto with(nolock) '+
    '    on CLI_Produto.CodCliente = FDO_Carteira.CodCarteira '+
    ' where ((( @aCod IS NOT NULL ) AND ( FDO_Carteira.CodCarteira = @aCod )) '+
    '        or (( @aCod IS NULL ) AND ( FDO_Carteira.CodCarteira like :aValue or CLI_Produto.NomFantasiaProduto like :aValue))) '+
    vWhere;
end;

function TDAOCarteira.SQLProcessamentoCotaByCarteira: String;
begin
  Result :=
    'select top 1 * '+
    '  from FDO_ProcessamentoCota '+
    ' where CodCarteira = :aCodCarteira ';
end;

end.


