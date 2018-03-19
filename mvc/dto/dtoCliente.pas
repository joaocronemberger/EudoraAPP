unit dtoCliente;

interface

uses
  Classes, dtoBase;

type
  TDTOCliente = class(TDTOBase)
  private
    FCodCliente: Integer;
    FNomCliente: String;
    FNomCompCliente: String;

    FCheck: Boolean;

  published
      property CodCliente: Integer read FCodCliente write FCodCliente;
      property NomCliente: String read FNomCliente write FNomCliente;
      property NomCompCliente: String read FNomCompCliente write FNomCompCliente;

      property Check: Boolean read FCheck write FCheck;

  end;

implementation

{ TDTOCliente }

initialization
  Registerclass(TDTOCliente);

end.


