unit modelProcessamentoCota;

interface

uses
  modelBase, mvcTypes;

type
  TModelProcessamentoCota = class(TModelBase)
  private
    FCodCarteira: Integer;
    FDtaUltProcessamento: TDateTime;
    FStaCotaProcessada: String;
    FNomUsuario: String;
    FStaIntegPortal: String;
    FStaProcessando: String;
    FStaUsaProcessoAutomatico: String;

  published
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property DtaUltProcessamento: TDateTime read FDtaUltProcessamento write FDtaUltProcessamento;
      property StaCotaProcessada: String read FStaCotaProcessada write FStaCotaProcessada;
      property NomUsuario: String read FNomUsuario write FNomUsuario;
      property StaIntegPortal: String read FStaIntegPortal write FStaIntegPortal;
      property StaProcessando: String read FStaProcessando write FStaProcessando;
      property StaUsaProcessoAutomatico: String read FStaUsaProcessoAutomatico write FStaUsaProcessoAutomatico;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelProcessamentoCota }

function TModelProcessamentoCota.GetIdentity: String;
begin
  Result := '';
end;

function TModelProcessamentoCota.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'CodCarteira';
  //Result[1] := 'DtaUltProcessamento';

end;

function TModelProcessamentoCota.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,5);
  Result[0] := 'CodCarteira';
  Result[1] := 'DtaUltProcessamento';
  Result[2] := 'StaCotaProcessada';
  Result[3] := 'StaIntegPortal';
  Result[4] := 'StaProcessando';

end;

function TModelProcessamentoCota.GetTableName: String;
begin
  Result := 'FDO_ProcessamentoCota';
end;

end.


