unit daoLogProcessamento;

interface

uses
  daoBase, Contnrs, modelLogProcessamento, mvcTypes, DBTables;

type
  TDAOLogProcessamento = class(TDAOBase)
  private

    function GetSQLLogs(): String;
  public
    procedure DoInsert(const aModel: TModelLogProcessamento);
    procedure DoUpdate(const aModel: TModelLogProcessamento);
    procedure DoDelete(const aModel: TModelLogProcessamento);

    function GetLogsByCarteiraDataCalculo(const aCodCarteira: Integer; const aDtaCalculo: TDateTime): TObjectList;
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOLogProcessamento }

procedure TDAOLogProcessamento.DoDelete(const aModel: TModelLogProcessamento);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOLogProcessamento.DoInsert(const aModel: TModelLogProcessamento);
begin
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOLogProcessamento.DoUpdate(const aModel: TModelLogProcessamento);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOLogProcessamento.GetLogsByCarteiraDataCalculo(
  const aCodCarteira: Integer; const aDtaCalculo: TDateTime): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 2);
  vListParametros[0].Nome := 'DtaCalculo';
  vListParametros[0].Valor := FormatDateTime('yyyy-mm-dd',aDtaCalculo);
  vListParametros[1].Nome := 'CodCarteira';
  vListParametros[1].Valor := aCodCarteira;

  Result := Self.OpenQueryToList(GetSQLLogs, vListParametros, TModelLogProcessamento);
end;

function TDAOLogProcessamento.GetSQLLogs: String;
begin
  Result :=
    'select * '+
    '  from FDO_LogProcessamento with(nolock) '+
    ' where FDO_LogProcessamento.CodCarteira = :CodCarteira '+
    '   and CAST(FDO_LogProcessamento.DtaHoraProcessamentoInicio AS DATE) = :DtaCalculo ';
end;

end.


