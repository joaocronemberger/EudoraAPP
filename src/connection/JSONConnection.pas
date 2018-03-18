unit JSONConnection;

interface

uses Rest.Json, System.Classes, Vcl.Forms, System.SysUtils, Appini;

type
  TConnections = class
  public
    class function GetURL(): String;
  end;

implementation

{ TConnections }

class function TConnections.GetURL: String;
begin
  Result := TAppINI.GetValue('Database','Folder', ExtractFilePath(Application.ExeName) + '\' );
end;

end.
