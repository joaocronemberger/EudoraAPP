program EudoraAPP;

uses
  Vcl.Forms,
  viewPrincipal in '..\src\view\viewPrincipal.pas' {vwPrincipal},
  dtoCliente in '..\src\dto\dtoCliente.pas',
  dtoVenda in '..\src\dto\dtoVenda.pas',
  dtoProduto in '..\src\dto\dtoProduto.pas',
  browserBase in '..\src\view\browserBase.pas' {bwBase},
  fichaBase in '..\src\view\fichaBase.pas' {frmBase},
  browserProdutos in '..\src\view\browserProdutos.pas',
  JSONConnection in '..\src\connection\JSONConnection.pas',
  AppINI in '..\src\connection\AppINI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TvwPrincipal, vwPrincipal);
  Application.Run;
end.
