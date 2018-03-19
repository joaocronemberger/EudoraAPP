unit dtoProcessamentoCota;

interface

uses
  dtoBase;

type
  TDTOProcessamentoCota = class(TDTOBase)
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

  end;

implementation

{ TDTOProcessamentoCota }

end.


