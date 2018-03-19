program TemaORMGenerator;

uses
  Forms,
  unitMiscelania in 'unitMiscelania.pas',
  unitPrincipal in 'unitPrincipal.pas' {formPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.Run;
end.
