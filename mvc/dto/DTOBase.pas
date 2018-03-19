unit dtoBase;

interface

uses
  mvcTypes, Classes;

type

  TDTOBase = class(TPersistent)
  private
    FStatus: TStatusDTO;
    FSnapshot: Array of Variant;
  protected
    function getStatus: TStatusDTO;
    procedure setStatus(const Value: TStatusDTO);
    
    function Memento_GetNowSnapshot(): Variant; virtual;
  public
    property Status: TStatusDTO read getStatus write setStatus;

    constructor Create( aStatus: TStatusDTO ); overload;

    procedure Memento_Snapshot();
    procedure Memento_SaveLog(const aCodTipoAtividade: Integer; const aMsgDescricao: String = ''; const aCodCli: Integer = 0);
  end;

implementation

uses InstantDBX, InstantPersistence, TEUTemaObject, TEULogAtividade, Variants, VarUtils;

{ TDTOBase }

constructor TDTOBase.Create(aStatus: TStatusDTO);
begin
  inherited Create();
  FStatus := aStatus;
end;

function TDTOBase.getStatus: TStatusDTO;
begin
  Result := FStatus;
end;

function TDTOBase.Memento_GetNowSnapshot: Variant;
begin
  Result := Null;

  { Exemplo de log:

    VarArrayOf([
      'Descrição', Valor,
      'Teste', 1,
    ]);
  }
  
end;

procedure TDTOBase.Memento_SaveLog(
  const aCodTipoAtividade: Integer;
  const aMsgDescricao: String;
  const aCodCli: Integer);
var
  vArrayDepois: Array of Variant;
begin

  if not VarIsNull(Self.Memento_GetNowSnapshot()) then
    vArrayDepois := Self.Memento_GetNowSnapshot();

  case Self.FStatus of
    sdtoInsert : SetLength(FSnapshot,0);
    sdtoDelete : SetLength(vArrayDepois,0);
  end;

  TEULogAtividade.RegistrarLogAtividade(
    TInstantDBXConnector(InstantDefaultConnector).Connection,
    'FDO',
    aCodTipoAtividade,
    P_iSeqUsuario,
    aCodCli,
    FSnapshot,
    vArrayDepois,
    aMsgDescricao );
    
end;

procedure TDTOBase.Memento_Snapshot;
begin
  if not VarIsNull(Self.Memento_GetNowSnapshot()) then
    FSnapshot := Self.Memento_GetNowSnapshot();
end;

procedure TDTOBase.setStatus(const Value: TStatusDTO);
begin
  FStatus := Value;
end;

end.


