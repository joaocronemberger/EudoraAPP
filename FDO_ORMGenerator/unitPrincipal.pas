unit unitPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DB, Buttons,
  Mask, StdCtrls, DBCtrls, Grids, DBGrids, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxLabel, cxGroupBox, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, Menus, cxButtons, cxMaskEdit, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxDropDownEdit, cxDBEdit, cxTextEdit, cxSpinEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCheckBox,
  cxCheckComboBox, cxRadioGroup, Provider, DBClient,
  DBTables, DBXpress, SqlExpr, CRSQLConnection, FMTBcd, InstantPresentation,
  ADODB;

type
  TformPrincipal = class(TForm)
    GroupBox1: TcxGroupBox;
    lblTabela: TcxLabel;
    gbxGerar: TcxGroupBox;
    cbbTabelas: TcxLookupComboBox;
    gridCampos: TcxGrid;
    gridCamposDBTableView1: TcxGridDBTableView;
    gridColumnCampo: TcxGridDBColumn;
    gridColumnTipoColuna: TcxGridDBColumn;
    gridCamposLevel1: TcxGridLevel;
    dsTabelas: TDataSource;
    dsCampos: TDataSource;
    btnGerar: TcxButton;
    edtNomeTabela: TcxTextEdit;
    lblNomeTabela: TcxLabel;
    gridColumnIsPrimary: TcxGridDBColumn;
    conBD: TADOConnection;
    qryTabelas: TADOQuery;
    qryCampos: TADOQuery;
    procedure btnGerarClick(Sender: TObject);
    procedure conBDAfterConnect(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbTabelasPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    FStrLstAssembler : TStringList;
    FStrLstController : TStringList;
    FStrLstDAO : TStringList;
    FStrLstDTO : TStringList;
    FStrLstModel : TStringList;

    COUNTPKFIELD: Integer;
    COUNTFIELDNOTNULL: Integer;

    procedure Substituir(var aStrLst: TStringList; aDe, aPara: String);

    function TABLENAME(): String;
    function FULLTABLENAME(): String;
    function PKFIELD(): String;
    function LOOPPRIVATEFILEDS(): String;
    function LOOPPROPERTIES(): String;
    function LOOPDTOTOMODEL(): String;
    function LOOPMODELTODTO(): String;

    function LOOPPKFIELD(): String;
    function LOOPFIELDNOTNULL(): String;
    function IDENTITYFIELD(): String;

    procedure SubstituiTags(aStrLst: TStringList);

    procedure CriarUnitAssembler();
    procedure CriarUnitController();
    procedure CriarUnitDAO();
    procedure CriarUnitDTO();
    procedure CriarUnitModel();
    procedure CriarInclude();

    function GetTipoDadoDelphi(const a_TipoBaseDados: integer): string;
  public
    { Public declarations }
    procedure DoGerar;
  end;

var
  formPrincipal: TformPrincipal;

implementation

uses
  unitMiscelania;

{$R *.dfm}

function TformPrincipal.GetTipoDadoDelphi(const a_TipoBaseDados: integer): string;
begin
  case a_TipoBaseDados of
    56, 127: Result := 'Integer';
    0: Result := 'Boolean';
    35, 175, 173, 167, 231, 239: Result := 'String';
    40: Result := 'TDateTime';
    59, 60, 62, 106, 108: Result := 'Double';
    48, 52: Result := 'SmallInt';
    41: Result := 'TTime';
    42, 43, 61: Result := 'TDateTime';
    36: Result := 'TGUID';
  end;
end;

procedure TformPrincipal.btnGerarClick(Sender: TObject);
begin
  DoGerar;
end;

procedure TformPrincipal.CriarUnitController();
var
  t_Unit: TStringList;
begin
  FStrLstController := TStringList.Create;
  Try
    FStrLstController.LoadFromFile('.\ORMGenerator\Modelos\controller.pas');
    Self.SubstituiTags(FStrLstController);
    FStrLstController.SaveToFile('.\ORMGenerator\Output\controller\controller'+ edtNomeTabela.Text +'.pas');
  Finally
    FStrLstController.Free;
  End;
end;

procedure TformPrincipal.CriarUnitDAO();
var
  t_Unit: TStringList;
begin
  FStrLstDAO := TStringList.Create;
  Try
    FStrLstDAO.LoadFromFile('.\ORMGenerator\Modelos\DAO.pas');
    Self.SubstituiTags(FStrLstDAO);
    FStrLstDAO.SaveToFile('.\ORMGenerator\Output\dao\dao'+ edtNomeTabela.Text +'.pas');
  Finally
    FStrLstDAO.Free;
  End;
end;

procedure TformPrincipal.CriarUnitDTO();
var
  t_Unit: TStringList;
  t_Contador: Integer;
begin
  FStrLstDTO := TStringList.Create;
  Try
    FStrLstDTO.LoadFromFile('.\ORMGenerator\Modelos\DTO.pas');
    Self.SubstituiTags(FStrLstDTO);
    FStrLstDTO.SaveToFile('.\ORMGenerator\Output\dto\dto'+ edtNomeTabela.Text +'.pas');
  Finally
    FStrLstDTO.Free;
  End;
end;

procedure TformPrincipal.conBDAfterConnect(Sender: TObject);
begin
  qryTabelas.Close;
  qryTabelas.Open;
end;

procedure TformPrincipal.FormShow(Sender: TObject);
begin
  conBD.Open;
end;

procedure TformPrincipal.cbbTabelasPropertiesEditValueChanged(
  Sender: TObject);
var
  SavCursor: TCursor;
begin
  SavCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;

    Self.edtNomeTabela.Text := cbbTabelas.Text;
    Self.edtNomeTabela.Text := StringReplace(Self.edtNomeTabela.Text, 'FDO_', '', [rfReplaceAll, rfIgnoreCase]);
    Self.edtNomeTabela.Text := StringReplace(Self.edtNomeTabela.Text, '_', '', [rfReplaceAll, rfIgnoreCase]);
    Self.edtNomeTabela.Text := StringReplace(Self.edtNomeTabela.Text, ' ', '', [rfReplaceAll, rfIgnoreCase]);

    Self.qryCampos.Close;
    Self.qryCampos.Parameters.ParamByName('object_id').Value := cbbTabelas.EditValue;
    Self.qryCampos.Open;
  finally
    Screen.Cursor := SavCursor;
  end;
end;

procedure TformPrincipal.CriarUnitAssembler;
begin
  FStrLstAssembler := TStringList.Create;
  Try
    FStrLstAssembler.LoadFromFile('.\ORMGenerator\Modelos\assembler.pas');
    Self.SubstituiTags(FStrLstAssembler);
    FStrLstAssembler.SaveToFile('.\ORMGenerator\Output\assembler\assembler'+ edtNomeTabela.Text +'.pas');
  Finally
    FStrLstAssembler.Free;
  End;
end;

procedure TformPrincipal.CriarUnitModel;
begin
  FStrLstModel := TStringList.Create;
  Try
    FStrLstModel.LoadFromFile('.\ORMGenerator\Modelos\Model.pas');
    Self.SubstituiTags(FStrLstModel);
    FStrLstModel.SaveToFile('.\ORMGenerator\Output\model\model'+ edtNomeTabela.Text +'.pas');
  Finally
    FStrLstModel.Free;
  End;
end;

procedure TformPrincipal.DoGerar;
begin

  if (cbbTabelas.Text = EmptyStr) then
  begin
    ShowMessage('Informe a tabela.');
    Exit;
  end;

  try
    Self.CriarUnitAssembler();
    Self.CriarUnitController();
    Self.CriarUnitDAO();
    Self.CriarUnitDTO();
    Self.CriarUnitModel();
    Self.CriarInclude();

    ShowMessage('Units criadas com sucesso.')
  except
    on E: Exception do
      ShowMessage('Erro ao criar units: ' + E.Message);
  end;
end;

function TformPrincipal.FULLTABLENAME: String;
begin
  Result := cbbTabelas.Text;
end;

function TformPrincipal.LOOPDTOTOMODEL: String;
begin
  Result := EmptyStr;
  with qryCampos do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      Result := Result + '    aModel.' + FieldByName('name').AsString + ' := aDTO.'+ FieldByName('name').AsString + ';' + #13#10;
      Next;
    end;
  finally
    EnableControls;
  end;
end;

function TformPrincipal.LOOPMODELTODTO: String;
begin
  Result := EmptyStr;
  with qryCampos do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      Result := Result + '    aDTO.' + FieldByName('name').AsString + ' := aModel.'+ FieldByName('name').AsString + ';' + #13#10;
      Next;
    end;
  finally
    EnableControls;
  end;
end;

function TformPrincipal.LOOPPRIVATEFILEDS: String;
begin
  Result := EmptyStr;
  with qryCampos do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      Result := Result + '    F' + FieldByName('name').AsString + ': '+ GetTipoDadoDelphi(FieldByName('user_type_id').AsInteger) + ';' + #13#10;
      Next;
    end;
  finally
    EnableControls;
  end;
end;

function TformPrincipal.LOOPPROPERTIES: String;
begin
  Result := EmptyStr;
  with qryCampos do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      Result := Result + '      property ' + FieldByName('name').AsString + ': '+ GetTipoDadoDelphi(FieldByName('user_type_id').AsInteger) + ' read F' + FieldByName('name').AsString + ' write F' + FieldByName('name').AsString + ';' + #13#10;
      Next;
    end;
  finally
    EnableControls;
  end;
end;

function TformPrincipal.PKFIELD: String;
begin
  Result := EmptyStr;
  with qryCampos do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      if FieldByName('is_primary_key').AsInteger = 1 then
      begin
        Result := FieldByName('name').AsString;
        exit;
      end;
      Next;
    end;
  finally
    EnableControls;
  end;
end;

procedure TformPrincipal.SubstituiTags(aStrLst: TStringList);
begin
  Substituir(aStrLst,'[PKFIELD]',PKFIELD());
  Substituir(aStrLst,'[TABLENAME]',TABLENAME());
  Substituir(aStrLst,'[FULLTABLENAME]',FULLTABLENAME());
  Substituir(aStrLst,'[LOOPPRIVATEFILEDS]',LOOPPRIVATEFILEDS());
  Substituir(aStrLst,'[LOOPPROPERTIES]',LOOPPROPERTIES());
  Substituir(aStrLst,'[LOOPDTOTOMODEL]',LOOPDTOTOMODEL());
  Substituir(aStrLst,'[LOOPMODELTODTO]',LOOPMODELTODTO());
  Substituir(aStrLst,'[LOOPPKFIELD]',LOOPPKFIELD());
  Substituir(aStrLst,'[IDENTITYFIELD]',IDENTITYFIELD());
  Substituir(aStrLst,'[COUNTPKFIELD]',IntToStr(COUNTPKFIELD));
  Substituir(aStrLst,'[LOOPFIELDNOTNULL]',LOOPFIELDNOTNULL());
  Substituir(aStrLst,'[COUNTFIELDNOTNULL]',IntToStr(COUNTFIELDNOTNULL));
end;

function TformPrincipal.TABLENAME: String;
begin
  Result := edtNomeTabela.Text;
end;

procedure TformPrincipal.Substituir(var aStrLst: TStringList; aDe, aPara: String);
begin
 aStrLst.Text := StringReplace(aStrLst.Text, aDe, aPara, [rfReplaceAll, rfIgnoreCase]);
end;

function TformPrincipal.IDENTITYFIELD: String;
begin
  Result := EmptyStr;
  with qryCampos do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      if FieldByName('is_identity').AsInteger = 1 then
      begin
        Result := FieldByName('name').AsString;
        Break;
      end;
      Next;
    end;
  finally
    EnableControls;
  end;
end;

function TformPrincipal.LOOPPKFIELD: String;
begin
  Result := EmptyStr;
  COUNTPKFIELD := 0;
  with qryCampos do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      if FieldByName('is_primary_key').AsInteger = 1 then
      begin
        Result := Result + '  Result[' +IntToStr(COUNTPKFIELD)+ '] := '''+FieldByName('name').AsString+''';' + #13#10;
        Inc(COUNTPKFIELD);
      end;
      Next;
    end;
  finally
    EnableControls;
  end;
end;

function TformPrincipal.LOOPFIELDNOTNULL: String;
begin
  Result := EmptyStr;
  COUNTFIELDNOTNULL := 0;
  with qryCampos do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      if FieldByName('is_nullable').AsInteger = 0 then
      begin
        Result := Result + '  Result[' +IntToStr(COUNTFIELDNOTNULL)+ '] := '''+FieldByName('name').AsString+''';' + #13#10;
        Inc(COUNTFIELDNOTNULL);
      end;
      Next;
    end;
  finally
    EnableControls;
  end;
end;

procedure TformPrincipal.CriarInclude;
begin
  FStrLstModel := TStringList.Create;
  Try
    FStrLstModel.LoadFromFile('.\ORMGenerator\Modelos\include.txt');
    Self.SubstituiTags(FStrLstModel);
    FStrLstModel.SaveToFile('.\ORMGenerator\Output\include_'+ edtNomeTabela.Text +'.txt');
  Finally
    FStrLstModel.Free;
  End;

end;

end.
