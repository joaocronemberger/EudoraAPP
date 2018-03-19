unit daoProcessamento;

interface

uses
  SysUtils,
  StrUtils,
  Classes,
  Contnrs,
  DBTables,
  daoBase,
  mvcTypes;

type
  TDAOProcessamento = class(TDAOBase)
  private
    { Methods para Processamento Diário }

    { Methods para Processamento por Período }

    { Methods para Processamento por Cotista }
    function SQLCotistasWithStaDesmarcaCotaByList(const aCodClienteIn: String): String;
    function SQLUpdateCotistasWithDesmarcaCota(const aCodClienteIn: String): String;
  public
    { Methods para Processamento Diário }

    { Methods para Processamento por Período }

    { Methods para Processamento por Cotista }
    function GetCotistasWithStaDesmarcaCota(const aCodClienteIn: String): TStringList;
    procedure UpdateCotistasWithDesmarcaCota(const aValue: Boolean; const aCodClienteIn: String);
  end;

implementation

uses mvcMiscelania, Variants, DateUtils, DB, Math;

{ TDAOProcessamento }

function TDAOProcessamento.GetCotistasWithStaDesmarcaCota(
  const aCodClienteIn: String): TStringList;
begin
  Result := TStringList.Create;
  with OpenQuery(SQLCotistasWithStaDesmarcaCotaByList(aCodClienteIn)) do
  begin
    First;
    while not Eof do
    begin
      Result.Add( FieldByName('CodCliente').AsString );
      Next;
    end;
  end;
end;

function TDAOProcessamento.SQLCotistasWithStaDesmarcaCotaByList(const aCodClienteIn: String): String;
begin
  Result :=
    'select CodCliente '+
    '  from FDO_Cotista '+
    ' where CodCliente in ('+ aCodClienteIn +') '+
    '   and StaDesmarcaCota = ''S'' ';
end;

function TDAOProcessamento.SQLUpdateCotistasWithDesmarcaCota(
  const aCodClienteIn: String): String;
begin
  Result :=
    'update FDO_Cotista '+
    '   set StaDesmarcaCota  = :aStaDesmarcaCota'+
    ' where CodCliente in ('+ aCodClienteIn +') ';
end;

procedure TDAOProcessamento.UpdateCotistasWithDesmarcaCota(
  const aValue: Boolean; const aCodClienteIn: String);
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aStaDesmarcaCota';
  vListParametros[0].Valor := IfThen(aValue,'S','N');

  ExecuteQuery(SQLUpdateCotistasWithDesmarcaCota(aCodClienteIn), vListParametros);
end;

end.


