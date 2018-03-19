unit dtoLogProcessamento;

interface

uses
  dtoBase, Classes, enumLogProcessamento;

type
  TDTOLogProcessamento = class(TDTOBase)
  private
    FCodCarteira: Integer;
    FDtaCalculoCota: TDateTime;
    FDtaHoraProcessamentoInicio: TDateTime;
    FDtaHoraProcessamentoFim: TDateTime;
    FLogProcessamento: TStringList;
    FStaCalculo: TStaCalculoProcessamento;
    FSeqUsuario: Integer;
    FCodLogProcessamento: Integer;
    
    function GetLogProcessamentoText: String;
    function GetStaCalculo: String;
    
  published
    property CodCarteira: Integer read FCodCarteira write FCodCarteira;
    property DtaCalculoCota: TDateTime read FDtaCalculoCota write FDtaCalculoCota;
    property DtaHoraProcessamentoInicio: TDateTime read FDtaHoraProcessamentoInicio write FDtaHoraProcessamentoInicio;
    property DtaHoraProcessamentoFim: TDateTime read FDtaHoraProcessamentoFim write FDtaHoraProcessamentoFim;
    property LogProcessamento: TStringList read FLogProcessamento write FLogProcessamento;
    property StaCalculo: TStaCalculoProcessamento read FStaCalculo write FStaCalculo;
    property SeqUsuario: Integer read FSeqUsuario write FSeqUsuario;
    property CodLogProcessamento: Integer read FCodLogProcessamento write FCodLogProcessamento;

    property LogProcessamentoText: String read GetLogProcessamentoText;
    property StaCalculoText: String read GetStaCalculo;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

uses
  mvcReferenceManipulator;

{ TDTOLogProcessamento }

constructor TDTOLogProcessamento.Create;
begin
  inherited Create;

  FLogProcessamento := TStringList.Create;
end;

destructor TDTOLogProcessamento.Destroy;
begin
  SafeFree(FLogProcessamento);

  inherited;
end;

function TDTOLogProcessamento.GetLogProcessamentoText: String;
begin
  Result := FLogProcessamento.Text;
end;

function TDTOLogProcessamento.GetStaCalculo: String;
begin
  Result := StaCalculoProcessamento[FStaCalculo];
end;

initialization
  Registerclass(TDTOLogProcessamento);
  
end.


