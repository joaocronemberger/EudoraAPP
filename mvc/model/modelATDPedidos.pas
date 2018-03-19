unit modelATDPedidos;

interface

uses
  modelBase, mvcTypes;

type
  TModelATDPedidos = class(TModelBase)
  private
    FNumPedido: Integer;
    FCodCliente: Integer;
    FDtaPedido: TDateTime;
    FTpoOperacao: String;
    FValPedido: Double;
    FNomUsuario: String;
    FStaIof: String;
    FNumPedidoInterface: Integer;
    FDtaReembCPMF: TDateTime;
    FDesHistorico: String;
    FTpoOrigem: String;
    FTpoMovtoOrigem: String;
    FStaCobraCPMF: String;
    FNumIntCCCliente: Integer;
    FNumIntCCFundo: Integer;
    FNumIntDOC: Integer;
    FTpoEstoque: String;
    FStaPedido: String;
    FCodFdoIncorporador: Integer;
    FNumResgIncorporacao: Integer;
    FDtaDistribuicao: TDateTime;
    FCodFinalidade: Integer;
    FNumIntTED: Integer;
    FStaEnvioEmail: String;
    FStaExportaSMA: String;
    Fstawebservice: String;
    FNumAplMellon: Integer;
    FCodPropostaPedidosPrev: Integer;
    FStaContribuicao: String;
    FSiglaMovtoPrev: String;
    FStaExportaBTGDtaPedido: String;
    FStaExportaBTGDtaCotizacao: String;
    FcSitPdidoTrnsfIncpc: String;

  published
      property NumPedido: Integer read FNumPedido write FNumPedido;
      property CodCliente: Integer read FCodCliente write FCodCliente;
      property DtaPedido: TDateTime read FDtaPedido write FDtaPedido;
      property TpoOperacao: String read FTpoOperacao write FTpoOperacao;
      property ValPedido: Double read FValPedido write FValPedido;
      property NomUsuario: String read FNomUsuario write FNomUsuario;
      property StaIof: String read FStaIof write FStaIof;
      property NumPedidoInterface: Integer read FNumPedidoInterface write FNumPedidoInterface;
      property DtaReembCPMF: TDateTime read FDtaReembCPMF write FDtaReembCPMF;
      property DesHistorico: String read FDesHistorico write FDesHistorico;
      property TpoOrigem: String read FTpoOrigem write FTpoOrigem;
      property TpoMovtoOrigem: String read FTpoMovtoOrigem write FTpoMovtoOrigem;
      property StaCobraCPMF: String read FStaCobraCPMF write FStaCobraCPMF;
      property NumIntCCCliente: Integer read FNumIntCCCliente write FNumIntCCCliente;
      property NumIntCCFundo: Integer read FNumIntCCFundo write FNumIntCCFundo;
      property NumIntDOC: Integer read FNumIntDOC write FNumIntDOC;
      property TpoEstoque: String read FTpoEstoque write FTpoEstoque;
      property StaPedido: String read FStaPedido write FStaPedido;
      property CodFdoIncorporador: Integer read FCodFdoIncorporador write FCodFdoIncorporador;
      property NumResgIncorporacao: Integer read FNumResgIncorporacao write FNumResgIncorporacao;
      property DtaDistribuicao: TDateTime read FDtaDistribuicao write FDtaDistribuicao;
      property CodFinalidade: Integer read FCodFinalidade write FCodFinalidade;
      property NumIntTED: Integer read FNumIntTED write FNumIntTED;
      property StaEnvioEmail: String read FStaEnvioEmail write FStaEnvioEmail;
      property StaExportaSMA: String read FStaExportaSMA write FStaExportaSMA;
      property stawebservice: String read Fstawebservice write Fstawebservice;
      property NumAplMellon: Integer read FNumAplMellon write FNumAplMellon;
      property CodPropostaPedidosPrev: Integer read FCodPropostaPedidosPrev write FCodPropostaPedidosPrev;
      property StaContribuicao: String read FStaContribuicao write FStaContribuicao;
      property SiglaMovtoPrev: String read FSiglaMovtoPrev write FSiglaMovtoPrev;
      property StaExportaBTGDtaPedido: String read FStaExportaBTGDtaPedido write FStaExportaBTGDtaPedido;
      property StaExportaBTGDtaCotizacao: String read FStaExportaBTGDtaCotizacao write FStaExportaBTGDtaCotizacao;
      property cSitPdidoTrnsfIncpc: String read FcSitPdidoTrnsfIncpc write FcSitPdidoTrnsfIncpc;

  public
    function GetTableName(): String; override;
    function GetPKFields(): TArrayStrings; override;
    function GetFieldsNotNull(): TArrayStrings; override;
    function GetIdentity(): String; override;

  end;

implementation

{ TModelATDPedidos }

function TModelATDPedidos.GetIdentity: String;
begin
  Result := 'NumPedido';
end;

function TModelATDPedidos.GetPKFields: TArrayStrings;
begin
  SetLength(Result,1);
  Result[0] := 'NumPedido';

end;

function TModelATDPedidos.GetFieldsNotNull: TArrayStrings;
begin
  SetLength(Result,7);
  Result[0] := 'NumPedido';
  Result[1] := 'CodCliente';
  Result[2] := 'DtaPedido';
  Result[3] := 'TpoOperacao';
  Result[4] := 'ValPedido';
  Result[5] := 'StaEnvioEmail';
  Result[6] := 'cSitPdidoTrnsfIncpc';

end;

function TModelATDPedidos.GetTableName: String;
begin
  Result := 'ATD_Pedidos';
end;

end.


