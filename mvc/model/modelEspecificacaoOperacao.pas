unit modelEspecificacaoOperacao;

interface

uses
  modelBase, mvcTypes;

type
  TModelEspecificacaoOperacao = class(TModelBase)
  private
    FNumOperacao: Integer;
    FSeqEspecificacao: Integer;

  published
      property NumOperacao: Integer read FNumOperacao write FNumOperacao;
      property SeqEspecificacao: Integer read FSeqEspecificacao write FSeqEspecificacao;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelEspecificacaoOperacao }

function TModelEspecificacaoOperacao.GetIdentity: String;
begin
  Result := '';
end;

function TModelEspecificacaoOperacao.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'NumOperacao';

end;

function TModelEspecificacaoOperacao.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'NumOperacao';

end;

function TModelEspecificacaoOperacao.GetTableName: String;
begin
  Result := 'FDO_EspecificacaoOperacao';
end;

end.


