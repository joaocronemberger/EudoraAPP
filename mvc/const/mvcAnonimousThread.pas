unit mvcAnonimousThread;

interface

uses
  Classes;

type
  TAnonimousProc = Procedure() of Object;

  TAnonimousThread = class(TThread)
  private
    FAnonimousMethod: TAnonimousProc;
    FWithSyncronize: Boolean;
  protected
    procedure Execute; override;
  public
    class procedure InicializeThread(aAnonimousMethod: TAnonimousProc; aWithSyncronize: Boolean = False);
  end;

implementation

{ TAnonimousThread }

procedure TAnonimousThread.Execute;
begin
  if Assigned(FAnonimousMethod) then
  begin
    if FWithSyncronize
      then Synchronize(FAnonimousMethod)
      else FAnonimousMethod;
  end;
end;

class procedure TAnonimousThread.InicializeThread(
  aAnonimousMethod: TAnonimousProc; aWithSyncronize: Boolean);
begin
  with TAnonimousThread.Create(True) do
  begin
    FAnonimousMethod := aAnonimousMethod;
    FWithSyncronize := aWithSyncronize;
    FreeOnTerminate := True;
    Resume;
  end;
end;

end.

