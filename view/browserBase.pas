unit browserBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList, Vcl.ImgList, Vcl.ActnMan, Vcl.PlatformDefaultStyleActnCtrls,
  cxClasses, dxBar;

type
  TbwBase = class(TForm)
    actBrowser: TActionManager;
    actExit: TAction;
    actGravar: TAction;
    actCancelar: TAction;
    actInserir: TAction;
    actEditar: TAction;
    actExcluir: TAction;
    menuBrowser: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
