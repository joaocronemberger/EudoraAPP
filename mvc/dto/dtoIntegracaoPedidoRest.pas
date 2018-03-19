unit dtoIntegracaoPedidoRest;

interface

uses
  dtoBase;

type
  TDTOIntegracaoPedidoRest = class(TDTOBase)
  private
    FNumPedido: Integer;
    FValCota: Double;
    FValIR: Double;
    FValIOF: Double;
    FValCotizado: Double;
    FStaEnviado: String;
    FDesRetorno: String;

  published
      property NumPedido: Integer read FNumPedido write FNumPedido;
      property ValCota: Double read FValCota write FValCota;
      property ValIR: Double read FValIR write FValIR;
      property ValIOF: Double read FValIOF write FValIOF;
      property ValCotizado: Double read FValCotizado write FValCotizado;
      property StaEnviado: String read FStaEnviado write FStaEnviado;
      property DesRetorno: String read FDesRetorno write FDesRetorno;

  end;

implementation

{ TDTOIntegracaoPedidoRest }

end.


