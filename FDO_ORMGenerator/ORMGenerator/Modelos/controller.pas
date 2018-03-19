unit controller[TABLENAME];

interface

uses
  Contnrs, 
  mvcReferenceManipulator, 
  dao[TABLENAME],  
  dto[TABLENAME], 
  assembler[TABLENAME], 
  model[TABLENAME];

type
  TController[TABLENAME] = class
  private
    FDAO: TDAO[TABLENAME];
  public
    constructor Create;
    destructor Destroy;

    procedure Save(const aDTO: TDTO[TABLENAME]);
    procedure Delete(const aDTO: TDTO[TABLENAME]);
  end;

implementation

uses
  mvcTypes;

{ TController[TABLENAME] }

constructor TController[TABLENAME].Create;
begin
  FDAO := TDAO[TABLENAME].Create;
end;

procedure TController[TABLENAME].Delete(const aDTO: TDTO[TABLENAME]);
var
  vModel: TModel[TABLENAME];
begin
  vModel := TModel[TABLENAME].Create;
  try
    TAssembler[TABLENAME].DTOToModel(aDTO, vModel);
    FDAO.DoDelete(vModel)
  finally
    SafeFree(vModel);
  end;
end;

destructor TController[TABLENAME].Destroy;
begin
  SafeFree(FDAO);
end;

procedure TController[TABLENAME].Save(const aDTO: TDTO[TABLENAME]);
var
  vModel: TModel[TABLENAME];
begin
  vModel := TModel[TABLENAME].Create;
  try
    TAssembler[TABLENAME].DTOToModel(aDTO, vModel);

    case aDTO.Status of
      sdtoInsert: FDAO.DoInsert(vModel);
      sdtoEdit: FDAO.DoUpdate(vModel);
      sdtoDelete: FDAO.DoDelete(vModel);
    end;
      
  finally
    SafeFree(vModel);
  end;
end;

end.


