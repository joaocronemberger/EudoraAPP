unit modelBase;

interface

uses
  Classes, mvcTypes, TypInfo, DBTables, XSBuiltIns, DateUtils, Variants,
  Contnrs, SysUtils, StrUtils, Controls, ExtCtrls, ComObj, Messages, SqlExpr;

type
  {$M+}
  TModelBaseClass = class of TModelBase;
  TModelBase = class(TPersistent)
  private
    FMemento: TArrayFields;
    function PropToStr(const aField: TNomeValor; const aModel: TModelBase): String;
  public
    { Memento Interfaced Methods }
    function Memento_GetTipoAtividade(): Integer; virtual;
    function Memento_GetCaptionField(): TArrayFields;
    procedure Memento_Snapshot();
    procedure Memento_SaveLog(const aCodCli: Integer = 0; const aMsgDescricao: String = '');

    { Abstracts Methods }
    function GetTableName(): String; virtual; abstract;
    function GetPKFields(): TArrayStrings; virtual; abstract;
    function GetFieldsNotNull(): TArrayStrings; virtual; abstract;
    function GetIdentity(): String; virtual; abstract;

    function GetFields(): TArrayFields;
    procedure LoadByQuery(const aQuery: TSQLQuery; const aAlias: String = '');
    procedure SetID(const aQuery: TSQLQuery);

    function GetSQLToInsert(): String; Overload;
    function GetSQLToInsertIfNotExists(): String; Overload;
    function GetSQLToUpdateOrInsert(): String; Overload;
    function GetSQLToUpdate(): String; Overload;
    function GetSQLToDelete(): String; Overload;
    
  end;
  {$M-}

const
  CRLF = #13#10;

implementation

uses Math, mvcMiscelania, InstantDBX, InstantPersistence, TEUTemaObject, TEULogAtividade;

{ TModelBase }

function TModelBase.GetFields(): TArrayFields;
var
  ListProp: TPropList;
  Indice: Integer;
begin
  SetLength(Result,0);
  try
    Indice := 0;
    FillChar(ListProp, High(ListProp), 0);
    GetPropInfos(Self.ClassInfo, @ListProp);

    while Assigned(ListProp[Indice]) do
    begin
      SetLength(Result,Length(Result)+1);
      Result[high(Result)].Nome := ListProp[Indice].Name;
      Result[high(Result)].Valor := GetPropValue(Self, Listprop[Indice].Name);
      Inc(Indice);
    end;
  except
    {Do nothing}
  end;

end;

function TModelBase.GetSQLToDelete: String;
var
  vArray: TArrayFields;
  vKeys: String;
  I: Integer;
begin
  Result := EmptyStr;
  vKeys := EmptyStr;

  if not Assigned(Self) then
    Exit;

  if (Self.GetTableName() = EmptyStr) then
    Exit;

  vArray := Self.GetFields;
  for I := low(vArray) to high(vArray) do
  begin
    if TMisc.StringInArray(vArray[I].Nome, Self.GetPKFields()) then
      vKeys := vKeys +' '+ vArray[I].Nome +' = '+ PropToStr(vArray[I], Self) +' and ';
  end;

  vKeys := Copy(vKeys,1,Length(vKeys)-5);

  Result := ' delete from '+ Self.GetTableName() + CRLF +
            '  where '+ vKeys ;
end;

function TModelBase.GetSQLToInsert: String;
var
  vArray: TArrayFields;
  vFields: String;
  vValues: String;
  I: Integer;
begin
  Result := EmptyStr;
  vFields := EmptyStr;
  vValues := EmptyStr;

  if not Assigned(Self) then
    Exit;

  if (Self.GetTableName() = EmptyStr) then
    Exit;

  vArray := Self.GetFields;
  for I := low(vArray) to high(vArray) do
  begin
    if (vArray[I].Nome <> Self.GetIdentity()) then
    begin
      vFields := vFields + vArray[I].Nome + ', ';
      vValues := vValues + PropToStr(vArray[I], Self) + ', ';
    end;
  end;

  vFields := Copy(vFields,1,Length(vFields)-2);
  vValues := Copy(vValues,1,Length(vValues)-2);

  Result := ' insert into '+ Self.GetTableName() +' ('+ vFields +') '+ CRLF +
            ' values ('+ vValues +')';
end;

function TModelBase.GetSQLToInsertIfNotExists: String;
var
  vArray: TArrayFields;
  vKeys: String;
  I: Integer;
begin
  Result := EmptyStr;
  vKeys := EmptyStr;

  if not Assigned(Self) then
    Exit;

  if (Self.GetTableName() = EmptyStr) then
    Exit;

  vArray := Self.GetFields;
  for I := low(vArray) to high(vArray) do
  begin
    if TMisc.StringInArray(vArray[I].Nome, Self.GetPKFields()) then
      vKeys := vKeys +' '+ vArray[I].Nome +' = '+ PropToStr(vArray[I], Self) +' and ';
  end;

  vKeys := Copy(vKeys,1,Length(vKeys)-5);

  // Se existir chave primária, faz a validação, senão, faz o insert direto....
  if vKeys <> EmptyStr then
  begin
    Result :=
      'if not exists (select 1 ' + CRLF +
      '                 from ' + Self.GetTableName() + CRLF +
      '                where ' + vKeys + ') ' + CRLF +
      'begin ' + CRLF +
      '  '+ Self.GetSQLToInsert + CRLF +
      'end ';
  end
  else
  begin
    Result := Self.GetSQLToInsert;
  end;

end;

function TModelBase.GetSQLToUpdate: String;
var
  vArray: TArrayFields;
  vKeys, vFields: String;
  I: Integer;
begin
  Result := EmptyStr;
  vFields := EmptyStr;
  vKeys := EmptyStr;

  if not Assigned(Self) then
    Exit;

  if (Self.GetTableName() = EmptyStr) then
    Exit;

  vArray := Self.GetFields;
  for I := low(vArray) to high(vArray) do
  begin
    if (vArray[I].Nome <> Self.GetIdentity()) then
      vFields := vFields + vArray[I].Nome +' = '+ PropToStr(vArray[I], Self) +', ';

    if TMisc.StringInArray(vArray[I].Nome, Self.GetPKFields()) then
      vKeys := vKeys +' '+ vArray[I].Nome +' = '+ PropToStr(vArray[I], Self) +' and ';
  end;

  vFields := Copy(vFields,1,Length(vFields)-2);
  vKeys := Copy(vKeys,1,Length(vKeys)-5);

  Result := ' update '+ Self.GetTableName() + CRLF +
            '    set '+ vFields +' '+ CRLF +
            ifThen(vKeys <> EmptyStr, '  where '+ vKeys );
end;

function TModelBase.GetSQLToUpdateOrInsert: String;
var
  vArray: TArrayFields;
  vKeys: String;
  I: Integer;
begin
  Result := EmptyStr;
  vKeys := EmptyStr;

  if not Assigned(Self) then
    Exit;

  if (Self.GetTableName() = EmptyStr) then
    Exit;

  vArray := Self.GetFields;
  for I := low(vArray) to high(vArray) do
  begin
    if TMisc.StringInArray(vArray[I].Nome, Self.GetPKFields()) then
      vKeys := vKeys +' '+ vArray[I].Nome +' = '+ PropToStr(vArray[I], Self) +' and ';
  end;

  vKeys := Copy(vKeys,1,Length(vKeys)-5);

  // Se existir chave primária, faz a validação, senão, faz o insert direto....
  if vKeys <> EmptyStr then
  begin
    Result :=
      'if exists (select 1 ' + CRLF +
      '             from ' + Self.GetTableName() + CRLF +
      '            where ' + vKeys + ') ' + CRLF +
      'begin ' + CRLF +
      '  '+ Self.GetSQLToUpdate + CRLF +
      'end ' + CRLF +
      'else ' + CRLF +
      'begin ' + CRLF +
      '  '+ Self.GetSQLToInsert + CRLF +
      'end ';
  end
  else
  begin
    Result := Self.GetSQLToInsert;
  end;
end;

procedure TModelBase.LoadByQuery(const aQuery: TSQLQuery; const aAlias: String = '');
var
  ListProp: TPropList;
  I: Integer;
  CurrentPropInfo: PPropInfo;
  PropObject: TObject;
  CriouObj: Boolean;
begin
  try
    I := 0;
    FillChar(ListProp, High(ListProp), 0);
    GetPropInfos(Self.ClassInfo, @ListProp);

    while Assigned(ListProp[I]) do
    begin
      if Assigned(aQuery.FindField(aAlias+ListProp[I].Name)) then
      begin
        CurrentPropInfo := GetPropInfo(Self.ClassInfo, ListProp[I].Name);
        if Assigned(CurrentPropInfo) and (SameText(ListProp[I].Name, CurrentPropInfo^.Name)) then
        begin
          if CurrentPropInfo.PropType^.Kind = tkClass then
          begin
            PropObject := GetObjectProp(Self, ListProp[I].Name);
            if PropObject is TXSDateTime then
            begin
              if TXSDateTime(PropObject).AsUTCDateTime < 0 then
                SetPropValue(Self, ListProp[I].Name, 0)
              else
                SetPropValue(Self, ListProp[I].Name, aQuery.FieldByName(aAlias+ListProp[I].Name).AsDateTime);
            end;
          end
          else
          begin
            if not aQuery.FieldByName(aAlias+ListProp[I].Name).IsNull then
              if not (ListProp[I].PropType^.Kind in [tkMethod, tkRecord]) then
                SetPropValue(Self, ListProp[I].Name, aQuery.FieldByName(aAlias+ListProp[I].Name).Value);
          end;
        end;
      end;
      Inc(I);
    end;
  except
    {Do nothing}
  end;
end;

function TModelBase.Memento_GetCaptionField: TArrayFields;
var
  vListParametros: TArrayFields;
begin
  Result := vListParametros;
end;

function TModelBase.Memento_GetTipoAtividade: Integer;
begin
  Result := 0; 
end;

procedure TModelBase.Memento_SaveLog(const aCodCli: Integer;
  const aMsgDescricao: String);
var
  vArrayAntes, vArrayDepois: Array of Variant;
                                                      
  procedure ConvertArrayFieldInArray(aArrayFields: TArrayFields; out aArrayVolta: Array of Variant);
  var
    i: integer;
  begin
    for i := low(aArrayFields) to high(aArrayFields) do
    begin
//      SetLength(aArrayVolta, Length(aArrayVolta)+2);
      aArrayVolta[high(aArrayVolta)-1] := aArrayFields[i].nome;
      aArrayVolta[high(aArrayVolta)] := aArrayFields[i].Valor;
    end;
  end;

begin
  ConvertArrayFieldInArray(Self.FMemento,vArrayAntes);
  ConvertArrayFieldInArray(Self.GetFields(),vArrayDepois);

  RegistrarLogAtividade(
    TInstantDBXConnector(InstantDefaultConnector).Connection,
    'FDO',
    Memento_GetTipoAtividade(),
    P_iSeqUsuario,
    aCodCli,
    vArrayAntes,
    vArrayDepois,
    aMsgDescricao );
end;

procedure TModelBase.Memento_Snapshot;
begin
  Self.FMemento := Self.GetFields;
end;

function TModelBase.PropToStr(const aField: TNomeValor;
  const aModel: TModelBase): String;
var
  IsPropNull: Boolean;
  TypeInfo: PTypeInfo;
  PropType: PPropInfo;
  PropVarValue: Variant;
  IsFieldNotNull: Boolean;
begin
  IsFieldNotNull := TMisc.StringInArray(aField.Nome,Self.GetFieldsNotNull());
  PropType := GetPropInfo(aModel.ClassInfo, aField.Nome);
  TypeInfo := PropType^.PropType^;
  if (TypeInfo = system.TypeInfo(TDate)) or (TypeInfo = system.TypeInfo(TDateTime)) or (TypeInfo = system.TypeInfo(TTime)) then
  begin
    if aField.Valor = 0 then
      Result := 'NULL'
    else
      Result := QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN:SS', VarToDateTime(aField.Valor)))
  end
  else
  case PropType.PropType^.Kind of
    tkInteger,
    tkInt64,
    tkClass: if ((aField.Valor = 0) and not(IsFieldNotNull)) then
               Result := 'NULL'
             else
               Result := VarToStrDef(aField.Valor, '0');
    tkEnumeration: Result := VarToStrDef(aField.Valor, '0');
    tkChar,
    tkString,
    tkWChar,
    tkLString, // Descomentei por conta do mantis 49488
    tkWString: if ((aField.Valor = EmptyStr) and not(IsFieldNotNull)) then
                 Result := 'NULL'
               else
                 Result := QuotedStr(VarToStrDef(aField.Valor, EmptyStr));

    tkFloat: begin
//               if ((aField.Valor = 0) and not(IsFieldNotNull)) then
//                 Result := 'NULL'
//               else
//               begin
                 Result := VarToStrDef(aField.Valor, EmptyStr);
                 Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
//               end;
             end;
    else
      Result := QuotedStr(EmptyStr);
  end;
end;

procedure TModelBase.SetID(const aQuery: TSQLQuery);
var
  ListProp: TPropList;
  I: Integer;
  CurrentPropInfo: PPropInfo;
  PropObject: TObject;
  CriouObj: Boolean;
begin
  if (Self.GetIdentity <> EmptyStr) then
  try
    I := 0;
    FillChar(ListProp, High(ListProp), 0);
    GetPropInfos(Self.ClassInfo, @ListProp);

    while Assigned(ListProp[I]) do
    begin
      if (ListProp[I].Name = Self.GetIdentity) then
      begin
        if Assigned(aQuery.FindField('ID')) then
        begin
          CurrentPropInfo := GetPropInfo(Self.ClassInfo, ListProp[I].Name);
          if Assigned(CurrentPropInfo) and (SameText(ListProp[I].Name, CurrentPropInfo^.Name)) then
          begin
            if CurrentPropInfo.PropType^.Kind = tkClass then
            begin
              PropObject := GetObjectProp(Self, ListProp[I].Name);
              if PropObject is TXSDateTime then
              begin
                if TXSDateTime(PropObject).AsUTCDateTime < 0 then
                  SetPropValue(Self, ListProp[I].Name, 0)
                else
                  SetPropValue(Self, ListProp[I].Name, aQuery.FieldByName('ID').AsDateTime);
              end;
            end
            else
            begin
              if not aQuery.FieldByName('ID').IsNull then
                if not (ListProp[I].PropType^.Kind in [tkMethod, tkRecord]) then
                  SetPropValue(Self, ListProp[I].Name, aQuery.FieldByName('ID').Value);
            end;
          end;
        end;
      end;
      Inc(I);
    end;
  except
    {Do nothing}
  end;
end;

end.


