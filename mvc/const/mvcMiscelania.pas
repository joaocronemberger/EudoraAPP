unit mvcMiscelania;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, ExtCtrls, Graphics, JPEG, EncdDecd,
  cxDBLookupComboBox, cxMaskEdit, cxLookupDBGrid, cxTextEdit, cxDropDownEdit,
  cxButtonEdit, cxCurrencyEdit, cxMemo, cxCalendar, cxButtons, cxCheckBox, dximctrl,
  cxImageComboBox, cxTimeEdit, cxCalc, Contnrs, mvcTypes, Dialogs, Controls, StdCtrls,
  Math, Shellapi, filectrl, TELib01;

type
  TMilisecondsCount = class
    private
      FMilisecondInicio: Cardinal;
      function ConvertMiliseconds(aMiliseconds: Cardinal): String;
    public
      class function Start(): TMilisecondsCount;
      function Finish(): String;
  end;

  TMisc = class
    class procedure CloneArrayFields(const aArrayOrigem: TArrayFields; var aArrayDestino: TArrayFields);
    class function StringInArray(const aValue: String; const aArray: TArrayStrings): Boolean;
    class function PathComBarra(const aPath: String): String;
    class function GetFolderTempLocal(aCreateTable: Boolean = False): String;
    class function DeleteFolder(FolderName: String; LeaveFolder: Boolean): Boolean;

    {Validates}
    class function DateTimeIsValid(const aDate: TDateTime; aAllowNull: Boolean = False): Boolean; overload;
    class function DateTimeIsValid(const aDate: String; aAllowNull: Boolean = False): Boolean; overload;
    class function DateTimeIsUtil(const aDate: TDateTime): Boolean;

    { Message methods }
    class procedure SendMsg(const aMsg: WideString); overload;
    class procedure SendErro(const aMsg: WideString); overload;
    class function SendConfirm(const aMsg: WideString): Boolean; overload;
    class function SendConfirm(const aMsg: WideString; const aButtons: TMsgDlgButtons; aCaptions: Array of String): Integer; overload;
    class function SendConfirmToken(): Boolean;

  private
    class function TemaMessage(const Title, Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; Captions: Array of String): Integer;


  end;

implementation

uses
  DateUtils, mvcFDOPassToken;


{ TMisc }

class procedure TMisc.CloneArrayFields(const aArrayOrigem: TArrayFields; var aArrayDestino: TArrayFields);
var
  i: Integer;
begin
  SetLength(aArrayDestino,Length(aArrayOrigem));
  for i := low(aArrayOrigem) to high(aArrayOrigem) do
  begin
    aArrayDestino[i].Nome := aArrayOrigem[i].Nome;
    aArrayDestino[i].Valor := aArrayOrigem[i].Valor;
  end;
end;

class function TMisc.SendConfirm(const aMsg: WideString): Boolean;
begin
  Result := SendConfirm(aMsg, [mbYes,mbNo], ['&Sim','&Não']) = mrYes;
end;

class function TMisc.StringInArray(const aValue: String;
  const aArray: TArrayStrings): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := low(aArray) to high(aArray) do
    Result := Result or (aValue = aArray[i]);
end;

class function TMisc.SendConfirm(const aMsg: WideString;
  const aButtons: TMsgDlgButtons; aCaptions: Array of String): Integer;
begin
  // Declarar "Controls" para ter acesso aos ModalResultValues
  Result := TemaMessage('Confirmação', aMsg, mtConfirmation, aButtons, aCaptions);
end;

class procedure TMisc.SendMsg(const aMsg: WideString);
begin
  TemaMessage('Atenção', aMsg, mtInformation, [mbOK], ['&OK']);
end;

class function TMisc.TemaMessage(const Title: String; const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; Captions: Array of String): Integer;
var
  i: Integer;
  Dlgbutton: Tbutton;
  Captionindex: Integer;
begin
  with CreateMessageDialog(Msg, DlgType, Buttons) do
  try
    Caption := Title;
    HelpContext := 0;
    HelpFile := '';
    Position := poScreenCenter;
    Captionindex := 0;
    for i := 0 to ComponentCount - 1 Do
    begin
      if (Components[i] is TButton) then
      Begin
        Dlgbutton := TButton(Components[i]);
        if Captionindex <= High(Captions) then
          Dlgbutton.Caption := Captions[Captionindex];
        inc(Captionindex);
      end;
    end;

    Result := ShowModal;
  finally
     Free;
  end;
end;

class function TMisc.DateTimeIsValid(const aDate: TDateTime; aAllowNull: Boolean = False): Boolean;
var
  vDay, vMonth, vYear: Word;
  vDataMinima: TDateTime;
begin
  if aAllowNull
    then vDataMinima := 0
    else vDataMinima := 1;

  DecodeDate(aDate, vYear, vMonth, vDay);
  Result :=
    IsValidDate(vYear, vMonth, vDay) and
    (aDate >= vDataMinima);
end;

class function TMisc.DateTimeIsValid(const aDate: String;
  aAllowNull: Boolean): Boolean;
var
  vDay, vMonth, vYear: Word;
  vData, vDataMinima: TDateTime;
begin
  if aAllowNull
    then vDataMinima := 0
    else vDataMinima := 1;

//  if (Trim(aDate) = '\  \') then
//  begin
//    Result := False;
//    Exit;
//  end;

  vDay := StrToIntDef(Copy(aDate,1,2),0);
  vMonth := StrToIntDef(Copy(aDate,4,2),0);
  vYear := StrToIntDef(Copy(aDate,7,4),0);

  if not TryEncodeDate(vYear, vMonth, vDay, vData)
    then Result := False
    else Result := IsValidDate(vYear, vMonth, vDay) and
                   (vData >= vDataMinima);
end;

class function TMisc.PathComBarra(const aPath: String): String;
begin
  Result := Trim(aPath);
  if Result <> EmptyStr then
  begin
    if ( Copy(Result, Length(Result), 1) <> '\' ) then
      Result := Result + '\';
  end;
end;

class procedure TMisc.SendErro(const aMsg: WideString);
begin
  TemaMessage('Atenção', aMsg, mtError, [mbOK], ['&OK']);
end;

class function TMisc.GetFolderTempLocal(aCreateTable: Boolean = False): String;
var
  TempDir: Array[0..144] of Char;

  function DeleteFolder(FolderName: String): Boolean;
  var
    i: integer;
    vFile: TSearchRec;
  begin
    I := FindFirst(FolderName+'*.*', faAnyFile, vFile);
    while I = 0 do
    begin
      DeleteFile(FolderName + vFile.Name);
      I := FindNext(vFile);
    end;
  end;

begin
  GetTempPath(144, TempDir);
  Result := PathComBarra(StrPas(TempDir)) + 'TemaFDO\';

  { Deleta ou cria diretório para não ter erro de "Directory is busy" }
  if DirectoryExists(Result)
    then DeleteFolder(Result)
    else CreateDir(Result);

  if aCreateTable then
  begin
    Result := PathComBarra(Result) + IntToStr(GetTickCount);
    CreateDir(Result);
  end;
  
end;

class function TMisc.SendConfirmToken: Boolean;
var
  vResult, vToken : String;
begin
  vResult := InputBox('Informe o token', 'Atenção: Esta funcionalidade só pode ser executada com o acompanhamento do suporte Tema.'+#13#13+'Por favor entre em contato e solicite o token de acesso:', '');
  vToken := TFDOPassToken.GetToken;
  Result := SameText(vResult, vToken);
end;

class function TMisc.DeleteFolder(FolderName: String;
  LeaveFolder: Boolean): Boolean;
var
  r: TshFileOpStruct;

begin
  Result := False;

  if not DirectoryExists(FolderName) then
    Exit;

  FolderName := PathComBarra(FolderName);
  
  if LeaveFolder then
    FolderName := FolderName + '*.*'
  else if FolderName[Length(FolderName)] = '\\'
         then Delete(FolderName,Length(FolderName), 1);

  FillChar(r, SizeOf(r), 0);
  r.wFunc := FO_DELETE;
  r.pFrom := PChar(FolderName);
  r.fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION;
  Result := ((ShFileOperation(r) = 0) and (not r.fAnyOperationsAborted));

end;

class function TMisc.DateTimeIsUtil(const aDate: TDateTime): Boolean;
begin
  Result := TELib01.TE_DiaUtilGenerico(aDate);
end;

{ TMilisecondsCount }

function TMilisecondsCount.ConvertMiliseconds(
  aMiliseconds: Cardinal): String;
var
  Second, Minute, Hour: Byte;
  Sobra: Extended;
begin
  Sobra := aMiliseconds / 1000;
  aMiliseconds := Floor(Frac(Sobra) * 1000);
  Sobra := Int(Sobra) / 60;
  Second := Floor(Frac(Sobra) * 60);
  Sobra := Int(Sobra) / 60;
  Minute := Floor(Frac(Sobra) * 60);
  Hour := Floor(Int(Sobra));

  Result := Format('%d:%d:%d:%d', [Hour, Minute, Second, aMiliseconds]);
end;

function TMilisecondsCount.Finish: String;
begin
  Result := Self.ConvertMiliseconds(GetTickCount - Self.FMilisecondInicio);
  Self.Destroy;
end;

class function TMilisecondsCount.Start: TMilisecondsCount;
begin
  Result := TMilisecondsCount.Create;
  Result.FMilisecondInicio := GetTickCount;
end;

end.


