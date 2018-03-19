unit mvcTypes;

interface
uses
  TypInfo;

type

  { Geral }
  TNomeValor = record
    Nome: string;
    Valor: Variant;
  end;

  TArrayFields = array of TNomeValor;
  TArrayStrings = array of String;

  { DTO }
  TStatusDTO = (sdtoNone, sdtoInsert, sdtoEdit, sdtoDelete);                                                         

  { View }
  TStatusForm = (sformView, sformEdit, sformInsert);                                                         

  { RESTRequest }
  TMethodFDO = (
    mFDORest_Token_GUIDE,
    mFDORest_CotizacaoResgate_GUIDE,
    mFDORest_CotizacaoAplicacao_GUIDE);

implementation

end.


