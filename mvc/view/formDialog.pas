unit formDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxPC, cxControls, StdCtrls, Buttons, ExtCtrls, cxLabel,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, FoldrDlg,
  cxShellDlgs, cxShellBrowserDialog, OleServer, OutlookXP;

type

  TDialogType = ( tdtFolder, tdtFile );

  TfrmDialog = class(TForm)
    pnlFooter: TPanel;
    btnOK: TBitBtn;
    btnSair: TBitBtn;
    pnlBody: TPanel;
    lblSearch: TcxLabel;
    edtSearch: TcxButtonEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtSearchPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FDialogFolder: TFolderDialog;
    FDialogFile: TOpenDialog;

    FType: TDialogType;

    procedure SetCaption(const aCaption: String);
    procedure SetPath(const aPath: String);
    procedure SetFilterFile(const aFilter: String);

    function GetPath(): String;
  public
    { Public declarations }
    class function AbreBuscaFolder(const aCaption: String; var aPath: String): Boolean;
    class function AbreBuscaFile(const aCaption: String; var aPath: String; const aFilter: String = 'Todos|*.*'): Boolean;
  end;

var
  frmDialog: TfrmDialog;

implementation

{$R *.dfm}

{ TfrmDialog }

class function TfrmDialog.AbreBuscaFile(const aCaption: String;
  var aPath: String; const aFilter: String = 'Todos|*.*'): Boolean;
begin
  with TfrmDialog.Create(nil) do
  try
    FType := tdtFile;
    SetCaption(aCaption);
    SetFilterFile(aFilter);
    Result := (ShowModal = mrOk);
  finally
    aPath := GetPath();
    Free;
  end;
end;

class function TfrmDialog.AbreBuscaFolder(const aCaption: String;
  var aPath: String): Boolean;
begin
  with TfrmDialog.Create(nil) do
  try
    FType := tdtFolder;
    SetCaption(aCaption);
    SetPath(aPath);
    Result := (ShowModal = mrOk);
  finally
    aPath := GetPath();
    Free;
  end;
end;

function TfrmDialog.GetPath: String;
begin
  Result := Self.edtSearch.Text;
end;

procedure TfrmDialog.SetCaption(const aCaption: String);
begin
  Self.Caption := aCaption;
end;

procedure TfrmDialog.SetPath(const aPath: String);
begin
  Self.edtSearch.Text := aPath;
end;

procedure TfrmDialog.FormCreate(Sender: TObject);
begin
  FDialogFolder := TFolderDialog.Create(Self);
  FDialogFile := TOpenDialog.Create(Self);
end;

procedure TfrmDialog.FormDestroy(Sender: TObject);
begin
  FDialogFolder.Free;
  FDialogFile.Free;
end;

procedure TfrmDialog.SetFilterFile(const aFilter: String);
begin
  if (FType = tdtFile) and Assigned(FDialogFile) then
  begin
    FDialogFile.Filter := aFilter;
  end;
end;

procedure TfrmDialog.edtSearchPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  case FType of
    tdtFolder: begin
      FDialogFolder.Directory := Self.edtSearch.Text;
      if FDialogFolder.Execute then
        Self.edtSearch.Text := FDialogFolder.Directory;
    end;
    tdtFile: begin
      if FDialogFile.Execute then
        Self.edtSearch.Text := FDialogFile.FileName;
    end;
  end;
end;

procedure TfrmDialog.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F2) then
    Self.edtSearchPropertiesButtonClick(Sender, 0);
end;

procedure TfrmDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    ModalResult := mrCancel;
end;

end.
