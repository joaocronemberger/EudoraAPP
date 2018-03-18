unit dtoLista;

interface

uses System.Classes, Vcl.Forms, System.SysUtils, AppIni;

type
  TDTOLista = class
  protected
    class function GetURL(): String;
  end;

implementation

{ TList }

class function TDTOLista.GetURL: String;
begin
  Result := TAppINI.GetValue('Database','Folder', ExtractFilePath(Application.ExeName) + '\' );
end;

end.
