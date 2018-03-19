unit daoImposto;

interface

uses
  daoBase, Contnrs, modelImposto, mvcTypes, DBTables;

type
  TDAOImposto = class(TDAOBase)
  private
    function GetSQLProcAliqIR(): String;
  public
    procedure DoInsert(const aModel: TModelImposto);
    procedure DoUpdate(const aModel: TModelImposto);
    procedure DoDelete(const aModel: TModelImposto);

    function GetAliquotaIR(const aCodCarteira: Integer; const aDtaAplicacao, aDtaResgate: TDateTime): Double;
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOImposto }

procedure TDAOImposto.DoDelete(const aModel: TModelImposto);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOImposto.DoInsert(const aModel: TModelImposto);
begin
  //aModel.NumOperacao := Self.GetNextSequence(aModel, 'NumOperacao');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOImposto.DoUpdate(const aModel: TModelImposto);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOImposto.GetAliquotaIR(const aCodCarteira: Integer;
  const aDtaAplicacao, aDtaResgate: TDateTime): Double;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 3);
  vListParametros[0].Nome := 'CodCarteira';
  vListParametros[0].Valor := aCodCarteira;
  vListParametros[1].Nome := 'DtaAplicacao';
  vListParametros[1].Valor := FormatDateTime('yyyy-mm-dd',aDtaAplicacao);
  vListParametros[2].Nome := 'DtaResgate';
  vListParametros[2].Valor := FormatDateTime('yyyy-mm-dd',aDtaResgate);

  Result := Self.OpenQueryReturnField(GetSQLProcAliqIR(), vListParametros, 'Aliquota');
end;

function TDAOImposto.GetSQLProcAliqIR: String;
begin
  Result :=
  'DECLARE @Aliquota real, @Prazo int, @TpoInvestimento int; '+
  'EXEC SPT_FDO_SEL_TPOINVESTIMENTO :CodCarteira, :DtaAplicacao, :DtaResgate, @Prazo output, @Aliquota OutPut, @TpoInvestimento output '+
  'SELECT @Aliquota as Aliquota ';
end;

end.


