unit AppINI;

interface

uses IniFiles, Vcl.Forms, System.SysUtils;

type
  TAppINI = class
  public
    class function GetValue(const aSessao: String; const aPropriedade: String; const aDefault : String = ''): String;
    class procedure SetValue(const aSessao: String; const aPropriedade: String; aValue: String);
  end;

implementation

{ TAppINI }

class function TAppINI.GetValue(const aSessao, aPropriedade,
  aDefault: String): String;
begin
  with TIniFile.Create( ExtractFilePath(Application.ExeName) + '\app.ini' ) do
  try
    Result := ReadString(aSessao, aPropriedade, aDefault);
  finally
    Free;
  end;
end;

class procedure TAppINI.SetValue(const aSessao, aPropriedade: String; aValue: String);
begin
  with TIniFile.Create( ExtractFilePath(Application.ExeName) + '\app.ini' ) do
  try
    WriteString(aSessao, aPropriedade, aValue);
  finally
    Free;
  end;

end;

end.

