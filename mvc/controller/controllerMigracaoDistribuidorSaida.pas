unit controllerMigracaoDistribuidorSaida;

interface

uses
  Contnrs, SysUtils, Classes,
  mvcReferenceManipulator,
  dtoMigracaoDistribuidorSaida,
  daoATDPedidos, daoATDEspecificacao, daoATDLiquidacao, daoCarteira, daoCliente,
  modelATDPedidos, modelATDEspecificacao, modelATDLiquidacao,
  assemblerATDPedidos, assemblerCarteira, assemblerCliente,
  dtoCarteira, dtoCliente;

type
  TControllerMigracaoDistribuidorSaida = class
  private
    FNomUsuario: String;

    FDAOPedidos: TDAOATDPedidos;
    FDAOEspecificacao: TDAOATDEspecificacao;
    FDAOLiquidacao: TDAOATDLiquidacao;
    FDAOCarteira: TDAOCarteira;
    FDAOCliente: TDAOCliente;

    function PreparaATDPedidos(aDtaPedido: TDateTime; aCodCliente: Integer): TModelATDPedidos;
    procedure PreparaATDPedidosAfterSave(var aPedido: TModelATDPedidos);
    function PreparaATDEspecificacao(aCodCarteira: Integer; aPedido : TModelATDPedidos): TModelATDEspecificacao;
    function PreparaATDLiquidacao(aEspecificacao: TModelATDEspecificacao): TModelATDLiquidacao;

  public
    constructor Create();
    destructor Destroy;

    function GetListaDeCarteiras(): TObjectList;
    function GetCotistasComSaldoByCarteira(const aDataProcesso: TDateTime; const aCodCarteira: Integer): TObjectList;
    function GetMigracaoDistribuidorGravada(const aDataProcesso: TDateTime; const aCodCarteira: Integer): TDTOMigracaoDistribuidorSaida;

    function CanSave(const aDTO: TDTOMigracaoDistribuidorSaida; const aCliente: TDTOCliente; out aListAlerta: TStringList): Boolean;
    procedure Save(const aDTO: TDTOMigracaoDistribuidorSaida; out aListOcorrencias: TStringList; out aListAlerta: TStringList);
    procedure Delete(const aDTO: TDTOMigracaoDistribuidorSaida);

    procedure SetNomeUsuario(const aNomUsuario: String);
  end;

implementation

uses
  mvcTypes, FDLib01;

{ TControllerMigracaoDistribuidorSaida }

constructor TControllerMigracaoDistribuidorSaida.Create();
begin
  FDAOPedidos := TDAOATDPedidos.Create;
  FDAOEspecificacao := TDAOATDEspecificacao.Create;
  FDAOLiquidacao := TDAOATDLiquidacao.Create;
  FDAOCarteira := TDAOCarteira.Create;
  FDAOCliente := TDAOCliente.Create;
end;

procedure TControllerMigracaoDistribuidorSaida.Delete(const aDTO: TDTOMigracaoDistribuidorSaida);
begin
end;

destructor TControllerMigracaoDistribuidorSaida.Destroy;
begin
  SafeFree(FDAOPedidos);
  SafeFree(FDAOEspecificacao);
  SafeFree(FDAOLiquidacao);
  SafeFree(FDAOCarteira);
  SafeFree(FDAOCliente);
end;

function TControllerMigracaoDistribuidorSaida.GetCotistasComSaldoByCarteira(
  const aDataProcesso: TDateTime;
  const aCodCarteira: Integer): TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCliente.GetCotistasComSaldoByCarteira(aDataProcesso, aCodCarteira);
  try

    Result := TObjectList.Create(True);
    TAssemblerCliente.ListModelToListDTO(vListModel, Result);
    
  finally
    SafeFree( vListModel );
  end;
end;

function TControllerMigracaoDistribuidorSaida.GetListaDeCarteiras: TObjectList;
var
  vListModel: TObjectList;
begin
  vListModel := FDAOCarteira.GetListaDeTodasCarteiras;
  try

    Result := TObjectList.Create(True);
    TAssemblerCarteira.ListModelToListDTO(vListModel, Result);
    
  finally
    SafeFree( vListModel );
  end;

end;

function TControllerMigracaoDistribuidorSaida.GetMigracaoDistribuidorGravada(
  const aDataProcesso: TDateTime;
  const aCodCarteira: Integer): TDTOMigracaoDistribuidorSaida;
var
  vListModel: TObjectList;
  vDTOCliente: TDTOCliente;
  i: Integer;
begin
  Result := TDTOMigracaoDistribuidorSaida.Create;
  Result.DtaMigracao := aDataProcesso;
  Result.CodCarteira := aCodCarteira;

  vListModel := FDAOCliente.GetClientesMigracaoDistribuidor(aDataProcesso, aCodCarteira);
  try
    TAssemblerCliente.ListModelToListDTO(vListModel, Result.ListaCliente);
  finally
    vListModel.Free;
  end;
  
end;

function TControllerMigracaoDistribuidorSaida.PreparaATDEspecificacao(
  aCodCarteira: Integer; aPedido : TModelATDPedidos): TModelATDEspecificacao;
begin
  Result := TModelATDEspecificacao.Create;
  Result.NumPedido := aPedido.NumPedido;
  Result.CodCarteira := aCodCarteira;
  Result.DtaOperacao := aPedido.DtaPedido;
  Result.DtaCotizacao := aPedido.DtaPedido;
  Result.DtaLiquidacao := aPedido.DtaPedido;
  Result.TpoOperacao := aPedido.TpoOperacao;
  Result.ValOperacao := aPedido.ValPedido;
  Result.StaOperacaoPenalty := 'N';
  Result.TpoCotizacao := 'N';
end;

function TControllerMigracaoDistribuidorSaida.PreparaATDLiquidacao(
  aEspecificacao: TModelATDEspecificacao): TModelATDLiquidacao;
begin
  Result := TModelATDLiquidacao.Create;
  Result.NumPedido := aEspecificacao.NumPedido;
  Result.CodCarteira := aEspecificacao.CodCarteira;
  Result.NumPedido := aEspecificacao.NumPedido;
  Result.TpoLiquidacao := '1'; //Dinheiro
  Result.DtaLiquidacao := aEspecificacao.DtaLiquidacao;
  Result.ValLiquidacao := aEspecificacao.ValOperacao;
  Result.NomUsuario := FNomUsuario;
end;

function TControllerMigracaoDistribuidorSaida.PreparaATDPedidos(
  aDtaPedido: TDateTime; aCodCliente: Integer): TModelATDPedidos;
begin
  Result := TModelATDPedidos.Create;
  Result.CodCliente := aCodCliente;
  Result.DtaPedido := aDtaPedido;
  Result.TpoOperacao := '3'; //Resgate total
  Result.ValPedido := 0.00;
  Result.StaEnvioEmail := 'N';
  Result.cSitPdidoTrnsfIncpc := 'N';
  Result.StaPedido := 'MD'; // Migração de Distribuidor
  Result.TpoEstoque := '1';
  Result.StaExportaSMA := 'EXP';
end;

procedure TControllerMigracaoDistribuidorSaida.Save(
  const aDTO: TDTOMigracaoDistribuidorSaida;
  out aListOcorrencias: TStringList;
  out aListAlerta: TStringList);
var
  vPedido: TModelATDPedidos;
  vEspecificacao: TModelATDEspecificacao;
  vLiquidacao: TModelATDLiquidacao;

  vListPedidos: TObjectList;

  vCliente: TDTOCliente;
  i: Integer;
  vDtaUltimoProcessamento: TDateTime;
  vCriouOcorrencia: Boolean;

  procedure SalvaLog(const aDTOCliente: TDTOCliente);
  begin
    if aListOcorrencias.Count = 0 then
    begin
      aListOcorrencias.Add( 'Para concluir o processo realize o processamento por cotista com ocorrência para os clientes abaixo:' );
      aListOcorrencias.Add( '' );
    end;
    
    aListOcorrencias.Add( Format('%d - %s',[aDTOCliente.CodCliente, Trim(aDTOCliente.NomCliente)]) );
  end;

  procedure DeletaPedidoByCliente(const aDTOCliente: TDTOCliente);
  var
    j, NumPedido: Integer;
  begin
    for j := 0 to Pred(vListPedidos.Count) do
    begin
      vCriouOcorrencia := False;
      if ( aDTOCliente.CodCliente = TModelATDPedidos(vListPedidos[j]).CodCliente ) then
      begin
        NumPedido := TModelATDPedidos(vListPedidos[j]).NumPedido;

        vCriouOcorrencia := FDAOPedidos.AddClientesOcorrenciaByNumPedido( NumPedido, True );
        FDAOEspecificacao.DeleteByNumPedido( NumPedido );
        FDAOLiquidacao.DeleteByNumPedido( NumPedido );
        FDAOPedidos.DeleteByNumPedido( NumPedido );

        if vCriouOcorrencia
          then SalvaLog( aDTOCliente );

        Break;
      end;
    end;
  end;

begin
  FDAOPedidos.StartTransaction;
  try

    vDtaUltimoProcessamento := FDAOCarteira.GetDtaUltProcessamento( aDTO.CodCarteira );
    vListPedidos := FDAOPedidos.GetPedidosMigracaoDistribuidor( aDTO.DtaMigracao, aDTO.CodCarteira );

    aListAlerta.Clear;
    
    for i := 0 to Pred(aDTO.ListaCliente.Count) do
    begin
      vCliente := TDTOCliente(aDTO.ListaCliente[i]);

      if (vCliente.Status = sdtoNone) then
      begin
        if (vCliente.Check)
          then vCliente.Status := sdtoInsert;
      end else
      if (vCliente.Status = sdtoEdit) then
      begin
        if vCliente.Check
          then vCliente.Status := sdtoNone
          else vCliente.Status := sdtoDelete;
      end;

      case vCliente.Status of
        sdtoInsert :
          begin
            if CanSave( aDTO, vCliente, aListAlerta ) then
            try

              { Insert na ATD_Pedidos }
              vPedido := Self.PreparaATDPedidos( aDTO.DtaMigracao, vCliente.CodCliente );
              FDAOPedidos.DoInsert(vPedido);

              { Update na ATD_Pedidos }
              PreparaATDPedidosAfterSave(vPedido);
              FDAOPedidos.DoUpdate(vPedido);

              { Insert na ATD_Especificacao }
              vEspecificacao := Self.PreparaATDEspecificacao( aDTO.CodCarteira, vPedido );
              FDAOEspecificacao.DoInsert(vEspecificacao);

              { Insert na ATD_Liquidacao }
              vLiquidacao := Self.PreparaATDLiquidacao( vEspecificacao );
              FDAOLiquidacao.DoInsert(vLiquidacao);

              { Se data da migração for MENOR OU IGUAL que a DtaUltimoprocessamento da carteira, Cria ocorrencia (força insert) }
              if (aDTO.DtaMigracao <= vDtaUltimoProcessamento) then
              begin
                vCriouOcorrencia := FDAOPedidos.AddClientesOcorrenciaByNumPedido( vPedido.NumPedido, False );
                if vCriouOcorrencia
                  then SalvaLog( vCliente );
              end;

            finally
              SafeFree(vPedido);
              SafeFree(vEspecificacao);
              SafeFree(vLiquidacao);
            end;

          end;
        sdtoDelete :
          begin
            { Se data da migração for MENOR que a DtaUltimoprocessamento da carteira,  }
            DeletaPedidoByCliente(vCliente);
          end;
      end;

    end;
    
    FDAOPedidos.CommitTransaction;
    SafeFree(vListPedidos);

  except
    on e: exception do
    begin
      FDAOPedidos.RollbackTransaction;
      Raise;
    end;
  end;
end;

procedure TControllerMigracaoDistribuidorSaida.SetNomeUsuario(
  const aNomUsuario: String);
begin
  FNomUsuario := aNomUsuario;
end;

procedure TControllerMigracaoDistribuidorSaida.PreparaATDPedidosAfterSave(
  var aPedido: TModelATDPedidos);
begin
  aPedido.NumIntCCCliente := aPedido.NumPedido;
  aPedido.NumIntCCFundo := aPedido.NumPedido;
  aPedido.NumIntDOC := aPedido.NumPedido;
  aPedido.NumIntTED := aPedido.NumPedido;
end;

function TControllerMigracaoDistribuidorSaida.CanSave(
  const aDTO: TDTOMigracaoDistribuidorSaida;
  const aCliente: TDTOCliente;
  out aListAlerta: TStringList): Boolean;
var
  vBloqueioFDO: Integer;
begin

  Result := False;

  if FDLib01.CotistaBloqueadoOperacao(aCliente.CodCliente, 'R') then
  begin
    aListAlerta.Add(Format('Cotista %s bloqueado para a solicitação de resgates. Essa migração não será gravada.',[Trim(aCliente.NomCliente)]));
    Exit;
  end;

  vBloqueioFDO := FDLib01.CotistaBloqueadoPorFundo(aDTO.CodCarteira, aCliente.CodCliente);
  if vBloqueioFDO in ([2,3]) then
  begin
    aListAlerta.Add(Format('Cotista %s bloqueado para a solicitação de resgates. Essa migração não será gravada.',[Trim(aCliente.NomCliente)]));
    Exit;
  end;

  if FDLib01.CotistaBloqueado(aDTO.CodCarteira, aCliente.CodCliente, aDTO.DtaMigracao) then
  begin
    aListAlerta.Add(Format('Cotista %s possui bloqueio de Cotas. Essa migração não será gravada.',[Trim(aCliente.NomCliente)]));
    Exit;
  end;

  Result := True;

end;

end.
