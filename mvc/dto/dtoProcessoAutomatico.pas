unit dtoProcessoAutomatico;

interface

uses
  dtoBase;

type
  TDTOProcessoAutomatico = class(TDTOBase)
  private
    FCodFilaProcessamento: Integer;
    FCodCarteira: Integer;
    FDtaProcesso: TDateTime;
    FCota: Double;
    FValPatrimonio: Double;
    FTpoApurarCota: String;
    FStaUsaProcessoAutomatico: Boolean;
    
  published
    property CodFilaProcessamento: Integer read FCodFilaProcessamento write FCodFilaProcessamento;
    property CodCarteira: Integer read FCodCarteira write FCodCarteira;
    property DtaProcesso: TDateTime read FDtaProcesso write FDtaProcesso;
    property Cota: Double read FCota write FCota;
    property ValPatrimonio: Double read FValPatrimonio write FValPatrimonio;
    property TpoApurarCota: String read FTpoApurarCota write FTpoApurarCota;
    property StaUsaProcessoAutomatico: Boolean read FStaUsaProcessoAutomatico write FStaUsaProcessoAutomatico;

  public
    class function CreateByParams(aParam1, aParam2: String): TDTOProcessoAutomatico;

  end;

implementation

uses SysUtils;

{ TDTOProcessoAutomatico }

{ TDTOProcessoAutomatico }

class function TDTOProcessoAutomatico.CreateByParams(aParam1,
  aParam2: String): TDTOProcessoAutomatico;
begin
  Result := inherited Create();

  {Se aParam2 for vazio, então aParam1 é CodFilaProcessamento}
  if (aParam2 = EmptyStr) then
  begin
    Result.CodFilaProcessamento := StrToInt(aParam1);
  end else
  begin
    Result.CodCarteira := StrToInt(aParam1);
    Result.DtaProcesso := StrToDateTime(aParam2);
  end;

end;

end.


