unit daoProcessoAutomatico;

interface

uses
  daoBase, Contnrs, modelProcessoAutomatico, mvcTypes, DBTables;

type
  TDAOProcessoAutomatico = class(TDAOBase)
  private
    function GetSQLUsaProcessoAutomatico: String;
  public
    function GetUsaProcessoAutomatico(const aCodCarteira: Integer): String;
  end;

implementation

uses SysUtils, mvcMiscelania, Variants;

{ TDAOProcessoAutomatico }

function TDAOProcessoAutomatico.GetSQLUsaProcessoAutomatico: String;
begin
  Result :=
    'select COALESCE(StaUsaProcessoAutomatico,''S'') as StaUsaProcessoAutomatico '+
    '  from FDO_ProcessamentoCota '+
    ' where CodCarteira = :aCodCarteira'
end;

function TDAOProcessoAutomatico.GetUsaProcessoAutomatico(const aCodCarteira: Integer): String;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aCodCarteira';
  vListParametros[0].Valor := aCodCarteira;

  Result := VarToStrDef(OpenQueryReturnField( GetSQLUsaProcessoAutomatico, vListParametros, 'StaUsaProcessoAutomatico'), 'N');
end;

end.


