unit unitMiscelania;

interface

uses Windows, Messages, SysUtils, Classes, Forms,
  ExtCtrls, Graphics, JPEG,
  EncdDecd,
  cxDBLookupComboBox,
  cxMaskEdit,
  cxLookupDBGrid,
  cxTextEdit,
  cxDropDownEdit,
  cxButtonEdit,
  cxCurrencyEdit,
  cxMemo,
  cxCalendar,
  cxButtons,
  cxCheckBox,
  dximctrl,
  cxImageComboBox,
  cxTimeEdit,
  cxCalc;

Type
  TMisc = class
    class function Encrypt(const S: String): String;
    class function Decrypt(const S: String): String;

    class function GetVersaoSistema(): String;

  end;

var
  CryptStartKey: Word = $2000;
  CryptNum1: Word = $34;
  CryptNum2: Word = $218;

implementation


{ TMisc }

class function TMisc.GetVersaoSistema: String;
var
  VerInfoSize   : DWORD;
  VerInfo       : Pointer;
  VerValueSize  : DWORD;
  VerValue      : PVSFixedFileInfo;
  Dummy         : DWORD;
  V1, V2, V3, V4: Word;
  Prog, ultimo  : string;
begin
  Prog := Application.Exename;
  VerInfoSize := GetFileVersionInfoSize(PChar(Prog), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(Prog), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(VerInfo, VerInfoSize);
  ultimo := Copy('100' + IntToStr(V4), 4, 2);

  result := Copy('100' + IntToStr(V1), 4, 2) + '.' +
    Copy('100' + IntToStr(V2), 4, 2) + '.' +
    Copy('100' + IntToStr(V3), 4, 2) + '.' +
    Copy('100' + IntToStr(V4), 4, 2);
end;

class function TMisc.Encrypt(const S: String): String;
var
  b: Byte;
  i: Integer;
  Key: Word;
begin
  Key := CryptStartKey;
  Result := '';
  for i := 1 to Length(S) do
  begin
    b := Byte(S[i]) xor (Key shr 8);
    Key := (b + Key) * CryptNum1 + CryptNum2;
    Result := Result + IntToHex(b, 2)
  end
end;

class function TMisc.Decrypt(const S: String): String;
var
  b: Byte;
  i: Integer;
  Key: Word;
begin
  b := 0;
  Key := CryptStartKey;
  Result := '';
  for i := 1 to Length(S) div 2 do
  begin
    try
      b := StrToInt('$' + Copy(S, 2 * i - 1, 2));
    except
      on EConvertError do b := 0
    end;
    Result := Result + Char(b xor (Key shr 8));
    Key := (b + Key) * CryptNum1 + CryptNum2;
  end;
end;

end.
