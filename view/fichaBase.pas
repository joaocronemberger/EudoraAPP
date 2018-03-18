unit fichaBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, System.Actions,
  Vcl.ActnList, Vcl.ActnMan, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.PlatformDefaultStyleActnCtrls;

type
  TfrmBase = class(TForm)
    pnlBottonButons: TPanel;
    pnlBtnBrowsing: TPanel;
    Button1: TButton;
    Button4: TButton;
    act: TActionManager;
    actExit: TAction;
    actGravar: TAction;
    actCancelar: TAction;
    actInserir: TAction;
    actEditar: TAction;
    actExcluir: TAction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
