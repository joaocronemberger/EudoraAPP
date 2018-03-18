unit viewPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Rest.Json, Generics.Collections,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.ActnMan, Vcl.ToolWin,
  Vcl.ActnCtrls, Vcl.ExtCtrls, Vcl.PlatformDefaultStyleActnCtrls,
  System.ImageList, cxGraphics, cxClasses, dxBar, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxRibbonSkins, dxRibbonCustomizationForm, dxRibbon,
  IniFiles, cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu,
  cxInplaceContainer;

type
  TvwPrincipal = class(TForm)
    actPrincipal: TActionManager;
    actProduto: TAction;
    actCliente: TAction;
    actVenda: TAction;
    imgPrincipal: TcxImageList;
    RibbonTabPrincipal: TdxRibbonTab;
    Ribbon: TdxRibbon;
    BarPrincipal: TdxBarManager;
    BarPrincipalBar1: TdxBar;
    BarPrincipalBar2: TdxBar;
    dxBarLargeButton1: TdxBarLargeButton;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    RibbonTabFinanceiro: TdxRibbonTab;
    RibbonTabFerramentas: TdxRibbonTab;
    BarPrincipalBar3: TdxBar;
    BarPrincipalBar4: TdxBar;
    actSorteador: TAction;
    dxBarLargeButton4: TdxBarLargeButton;
    actFaturamento: TAction;
    dxBarLargeButton5: TdxBarLargeButton;
    cxTreeList1: TcxTreeList;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaCorPrincipal();
  public
    { Public declarations }
    procedure Init();
  end;

var
  vwPrincipal: TvwPrincipal;

implementation

{$R *.dfm}

uses AppINI;

{ TvwPrincipal }

procedure TvwPrincipal.CarregaCorPrincipal;
var
  vStrCor: String;
begin

  vStrCor := TAppINI.GetValue('Sistema', 'Cor', 'B');
  case vStrCor[1] of
    'B': Self.Ribbon.ColorSchemeAccent := rcsaBlue;
    'Y': Self.Ribbon.ColorSchemeAccent := rcsaYellow;
    'G': Self.Ribbon.ColorSchemeAccent := rcsaGreen;
    'O': Self.Ribbon.ColorSchemeAccent := rcsaOrange;
    'P': Self.Ribbon.ColorSchemeAccent := rcsaPurple;
  end;

  TAppINI.SetValue('Sistema', 'Cor', vStrCor[1]);

end;

procedure TvwPrincipal.FormShow(Sender: TObject);
begin
  Self.Init();
end;

procedure TvwPrincipal.Init;
begin

  // Ativa a primeira aba...
  RibbonTabPrincipal.Active := True;

  // Carrga a cor do sistema...
  Self.CarregaCorPrincipal();
end;

end.
