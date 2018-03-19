unit mvcReferenceManipulator;

interface

uses
  Classes, SysUtils;

//type

function SafeFree(var AObject): TObject;

implementation

function SafeFree(var AObject): TObject;

  function IsValidReference(AObject: TObject): Boolean;
  const
    MagicAddress = 1633780;
  begin
    try
      Result := Assigned(AObject) and
                (AObject.InstanceSize > 0) and
                (AObject.InstanceSize <> MagicAddress) and
                (AObject.ClassType <> nil) and
                (AObject.ClassName <> EmptyStr);
    except
      Result := False;
    end;
  end;

begin
  Result := nil;
  try
    if IsvalidReference(TObject(AObject)) then
      FreeAndNil(TObject(AObject))
    else
      TObject(AObject) := nil;
  except
    TObject(AObject) := nil;
  end;
end;

end.





