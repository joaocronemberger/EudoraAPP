program EudoraAPP;

uses
  Vcl.Forms,
  viewPrincipal in '..\view\viewPrincipal.pas' {vwPrincipal},
  dtoCliente in '..\dto\dtoCliente.pas',
  dtoVenda in '..\dto\dtoVenda.pas',
  dtoProduto in '..\dto\dtoProduto.pas',
  browserBase in '..\view\browserBase.pas' {bwBase},
  fichaBase in '..\view\fichaBase.pas' {frmBase},
  browserProdutos in '..\view\browserProdutos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TvwPrincipal, vwPrincipal);
  Application.Run;
end.