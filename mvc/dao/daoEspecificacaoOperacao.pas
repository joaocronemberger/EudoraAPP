unit daoEspecificacaoOperacao;

interface

uses
  daoBase, Contnrs, modelEspecificacaoOperacao, mvcTypes, DBTables;

type
  TDAOEspecificacaoOperacao = class(TDAOBase)
  private
  public
    procedure DoInsert(const aModel: TModelEspecificacaoOperacao);
    procedure DoUpdate(const aModel: TModelEspecificacaoOperacao);
    procedure DoDelete(const aModel: TModelEspecificacaoOperacao);
  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOEspecificacaoOperacao }

procedure TDAOEspecificacaoOperacao.DoDelete(const aModel: TModelEspecificacaoOperacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOEspecificacaoOperacao.DoInsert(const aModel: TModelEspecificacaoOperacao);
begin
  //aModel.NumOperacao := Self.GetNextSequence(aModel, 'NumOperacao');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOEspecificacaoOperacao.DoUpdate(const aModel: TModelEspecificacaoOperacao);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

end.


