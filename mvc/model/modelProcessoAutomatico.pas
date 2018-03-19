unit modelProcessoAutomatico;

interface

uses
  modelBase;

type
  TModelProcessoAutomatico = class(TModelBase)
  private
    FCodCarteira: Integer;
    FDtaProcesso: TDateTime;
    FCota: Double;
    FValPatrimonio: Double;
  published
    property CodCarteira: Integer read FCodCarteira write FCodCarteira;
    property DtaProcesso: TDateTime read FDtaProcesso write FDtaProcesso;
    property Cota: Double read FCota write FCota;
    property ValPatrimonio: Double read FValPatrimonio write FValPatrimonio;
  end;

implementation

{ TModelProcessoAutomatico }

end.


