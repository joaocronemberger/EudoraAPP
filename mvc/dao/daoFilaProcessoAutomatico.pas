unit daoFilaProcessoAutomatico;

interface

uses
  daoBase, Contnrs, modelFilaProcessoAutomatico, mvcTypes, DBTables;

type
  TDAOFilaProcessoAutomatico = class(TDAOBase)
  private
    function GetSQLFila(): String;
    function GetSQLFilaByData(): String;
    function GetSQLAddNewInList(): String;
  public
    procedure DoInsert(const aModel: TModelFilaProcessoAutomatico);
    procedure DoUpdate(const aModel: TModelFilaProcessoAutomatico);
    procedure DoDelete(const aModel: TModelFilaProcessoAutomatico);

    function GetFila(const aID: Integer): TModelFilaProcessoAutomatico;
    function GetFilaProcessoByData(const aData: TDateTime): TObjectList;

    procedure AddNewInList(const aCodCarteira: Integer; const aDtaProcesso: TDateTime);

  end;

implementation

uses SysUtils, mvcMiscelania;

{ TDAOFilaProcessoAutomatico }

procedure TDAOFilaProcessoAutomatico.AddNewInList(
  const aCodCarteira: Integer; const aDtaProcesso: TDateTime);
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 2);
  vListParametros[0].Nome := 'aCodCarteira';
  vListParametros[0].Valor := aCodCarteira;
  vListParametros[1].Nome := 'aDtaProcesso';
  vListParametros[1].Valor := FormatDateTime('YYYY-MM-DD', aDtaProcesso);

  Self.ExecuteQuery( GetSQLAddNewInList(), vListParametros);
end;

procedure TDAOFilaProcessoAutomatico.DoDelete(const aModel: TModelFilaProcessoAutomatico);
begin
  Self.ExecuteQuery( aModel.GetSQLToDelete() );
end;

procedure TDAOFilaProcessoAutomatico.DoInsert(const aModel: TModelFilaProcessoAutomatico);
begin
  //aModel.CodFilaProcessoAutomatico := Self.GetNextSequence(aModel, 'CodFilaProcessoAutomatico');
  Self.ExecuteQuery( aModel.GetSQLToInsert() );
  Self.SetIdentity( aModel );
end;

procedure TDAOFilaProcessoAutomatico.DoUpdate(const aModel: TModelFilaProcessoAutomatico);
begin
  Self.ExecuteQuery( aModel.GetSQLToUpdate() );
end;

function TDAOFilaProcessoAutomatico.GetFila(
  const aID: Integer): TModelFilaProcessoAutomatico;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'aCodFilaProcessoAutomatico';
  vListParametros[0].Valor := aID;

  Result := TModelFilaProcessoAutomatico(Self.OpenQueryToModel(GetSQLFila, vListParametros, TModelFilaProcessoAutomatico));
end;

function TDAOFilaProcessoAutomatico.GetFilaProcessoByData(
  const aData: TDateTime): TObjectList;
var
  vListParametros: TArrayFields;
begin
  SetLength(vListParametros, 1);
  vListParametros[0].Nome := 'pDtaOrdem';
  vListParametros[0].Valor := FormatDateTime('yyyy-mm-dd',aData);

  Result := Self.OpenQueryToList(GetSQLFilaByData, vListParametros, TModelFilaProcessoAutomatico);
end;

function TDAOFilaProcessoAutomatico.GetSQLAddNewInList: String;
begin
  Result :=
    'DECLARE @ERROINTERFACE INT, @NUMPROTOCOLO INT; '+
    'SELECT @NUMPROTOCOLO = MAX(CodProtocoloOrdem) + 1 FROM FDO_FilaProcessoAutomatico '+
    'EXEC SPT_FDO_GRV_FilaProcessamentoAutomatico :aCodCarteira, @NUMPROTOCOLO, :aDtaProcesso, @ERROINTERFACE OUTPUT; '+
    'SELECT * '+
    '  FROM FDO_ERROINTERFACE '+
    ' WHERE CODERRO = @ERROINTERFACE ';
end;

function TDAOFilaProcessoAutomatico.GetSQLFila: String;
begin
  Result :=
    'select * '+
    '  from FDO_FilaProcessoAutomatico '+
    ' where CodFilaProcessoAutomatico = :aCodFilaProcessoAutomatico';
end;

function TDAOFilaProcessoAutomatico.GetSQLFilaByData: String;
begin
  Result :=
    'declare @pDtaOrdem datetime; '+
    ''+
    'set @pDtaOrdem = :pDtaOrdem; '+
    ''+
    'select CodFilaProcessoAutomatico, '+
    '       CodCarteira, '+
    '       CodProtocoloOrdem, '+
    '       DtaOrdemProcessamento, '+
    '       DtaCotaProcessamento, '+
    '       StaSolicitacao, '+
    '       CodLogProcessamento '+
    '  from FDO_FilaProcessoAutomatico '+
    ' where cast(DtaOrdemProcessamento as date) = @pDtaOrdem '+
    ' union all '+
    'select CodFilaProcessoAutomatico, '+
    '       CodCarteira, '+
    '       CodProtocoloOrdem, '+
    '       DtaOrdemProcessamento, '+
    '       DtaCotaProcessamento, '+
    '       StaSolicitacao, '+
    '       CodLogProcessamento '+
    '  from FDO_FilaProcessoAutomatico_Historico '+
    ' where cast(DtaOrdemProcessamento as date) = @pDtaOrdem ';
end;

end.


