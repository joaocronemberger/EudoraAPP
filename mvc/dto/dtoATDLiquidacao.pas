unit dtoATDLiquidacao;

interface

uses
  dtoBase;

type
  TDTOATDLiquidacao = class(TDTOBase)
  private
    FSeqLiquidacao: Integer;
    FCodCarteira: Integer;
    FCodCliente: Integer;
    FCodBeneficiario: Integer;
    FNumPedido: Integer;
    FTpoLiquidacao: String;
    FDtaLiquidacao: TDateTime;
    FValLiquidacao: Double;
    FNomUsuario: String;
    FTxtObservacao: String;
    FStaExpDoc: String;
    FValReembCPMF: Double;
    FCodBeneficiario2: Integer;
    FNomBenefExt2: String;
    FCPFCGCBenefExt2: String;

  published
      property SeqLiquidacao: Integer read FSeqLiquidacao write FSeqLiquidacao;
      property CodCarteira: Integer read FCodCarteira write FCodCarteira;
      property CodCliente: Integer read FCodCliente write FCodCliente;
      property CodBeneficiario: Integer read FCodBeneficiario write FCodBeneficiario;
      property NumPedido: Integer read FNumPedido write FNumPedido;
      property TpoLiquidacao: String read FTpoLiquidacao write FTpoLiquidacao;
      property DtaLiquidacao: TDateTime read FDtaLiquidacao write FDtaLiquidacao;
      property ValLiquidacao: Double read FValLiquidacao write FValLiquidacao;
      property NomUsuario: String read FNomUsuario write FNomUsuario;
      property TxtObservacao: String read FTxtObservacao write FTxtObservacao;
      property StaExpDoc: String read FStaExpDoc write FStaExpDoc;
      property ValReembCPMF: Double read FValReembCPMF write FValReembCPMF;
      property CodBeneficiario2: Integer read FCodBeneficiario2 write FCodBeneficiario2;
      property NomBenefExt2: String read FNomBenefExt2 write FNomBenefExt2;
      property CPFCGCBenefExt2: String read FCPFCGCBenefExt2 write FCPFCGCBenefExt2;

  end;

implementation

{ TDTOATDLiquidacao }

end.


