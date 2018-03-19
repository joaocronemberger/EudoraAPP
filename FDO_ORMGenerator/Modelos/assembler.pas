unit assembler[TABLENAME];

interface

uses
  dto[TABLENAME], model[TABLENAME], Contnrs;

type
  TAssembler[TABLENAME] = class
    public
      { Assembler Object }
      class procedure DTOToModel(const aDTO: TDTO[TABLENAME]; var aModel: TModel[TABLENAME]);
      class procedure ModelToDTO(const aModel: TModel[TABLENAME]; var aDTO: TDTO[TABLENAME]);
      { Assembler List Object }
      class procedure ListModelToListDTO(const aListModel: TObjectList; var aListDTO: TObjectList);
  end;

implementation

{ TAssembler[TABLENAME] }

class procedure TAssembler[TABLENAME].DTOToModel(
  const aDTO: TDTO[TABLENAME]; var aModel: TModel[TABLENAME]);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
[LOOPDTOTOMODEL]
  end;
end;

class procedure TAssembler[TABLENAME].ModelToDTO(
  const aModel: TModel[TABLENAME]; var aDTO: TDTO[TABLENAME]);
begin
  if (Assigned(aModel)) and (Assigned(aDTO)) then
  begin
[LOOPMODELTODTO]
  end;
end;

class procedure TAssembler[TABLENAME].ListModelToListDTO(
  const aListModel: TObjectList; var aListDTO: TObjectList);
var
  vDTO: TDTO[TABLENAME];
  vModel: TModel[TABLENAME];
  i: Integer;
begin
  if (Assigned(aListModel)) and (Assigned(aListDTO)) then
  begin
    for i := 0 to aListModel.Count -1 do
    begin
      vModel := TModel[TABLENAME](aListModel[i]);
      vDTO := TDTO[TABLENAME].Create;
      ModelToDTO(vModel,vDTO);
      aListDTO.Add(vDTO);
    end;
  end;
end;

end.


