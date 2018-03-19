unit daoConfiguracaoProcessoAutomatico;

interface

uses
  daoBase, Contnrs, modelConfiguracaoProcessoAutomatico, mvcTypes, DBTables;

type
  TDAOConfiguracaoProcessoAutomatico = class(TDAOBase)
  private
    function GetSQLConfiguracao(): String;
  public
    procedure DoInsert(const aModel: TModelConfiguracaoProcessoAutomatico);
    procedure DoUpdate(const aModel: TModelConfiguracaoProcessoAutomatico);
    procedure DoDelete(const aModel: TModelConfiguracaoProcessoAutomatico);

    function GetConfiguracaoProcessoAutomatico(): TModelConfiguracaoProcessoAutomatico;
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOConfiguracaoProcessoAutomatico }

procedure TDAOConfiguracaoProcessoAutomatico.DoDelete(const aModel: TModelConfiguracaoProcessoAutomatico);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOConfiguracaoProcessoAutomatico.DoInsert(const aModel: TModelConfiguracaoProcessoAutomatico);
begin
  //aModel. := Self.GetNextSequence(aModel, '');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOConfiguracaoProcessoAutomatico.DoUpdate(const aModel: TModelConfiguracaoProcessoAutomatico);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOConfiguracaoProcessoAutomatico.GetConfiguracaoProcessoAutomatico: TModelConfiguracaoProcessoAutomatico;
begin
  Result := TModelConfiguracaoProcessoAutomatico(Self.OpenQueryToModel(GetSQLConfiguracao, TModelConfiguracaoProcessoAutomatico));
end;

function TDAOConfiguracaoProcessoAutomatico.GetSQLConfiguracao: String;
begin
  Result :=
    'select * '+
    '  from FDO_ConfiguracaoProcessoAutomatico ';
end;

end.


