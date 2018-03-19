unit mvcSingletonConexao;

interface

uses
  DBTables, mvcReferenceManipulator, Classes, SqlExpr, InstantDBX, InstantPersistence;

type
  TSingletonConexao = class
  private
    FQuery : TSQLQuery;

    constructor Create;
    destructor Destroy; override;

  public
    function GetMyQuery: TSQLQuery;

    function InTransaction: Boolean;
    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;

    class function GetInstancia(): TSingletonConexao;
  end;

var
  m_Instancia: TSingletonConexao;
const
  cDataBaseName = 'dbTema';

implementation

uses
  Forms, SysUtils, Controls;

{ TSingletonConexao }

procedure TSingletonConexao.CommitTransaction;
begin
  //Session.FindDatabase(cDataBaseName).Commit; -- BDE Connection
  TInstantDBXConnector(InstantDefaultConnector).CommitTransaction;
end;

constructor TSingletonConexao.Create;
begin
  FQuery := TSQLQuery.Create(Application);
  FQuery.SQLConnection := TInstantDBXConnector(InstantDefaultConnector).Connection;
end;
 
destructor TSingletonConexao.Destroy;
begin
  inherited;
end;
 
class function TSingletonConexao.GetInstancia: TSingletonConexao;
begin
  if not Assigned(m_Instancia) then
    m_Instancia := TSingletonConexao.Create();
  Result := m_Instancia;
end;

function TSingletonConexao.GetMyQuery: TSQLQuery;
begin
  Result := FQuery;
end;

function TSingletonConexao.InTransaction: Boolean;
begin
  //Result := Session.FindDatabase(cDataBaseName).InTransaction; -- BDE Connection
  Result := TInstantDBXConnector(InstantDefaultConnector).InTransaction;
end;

procedure TSingletonConexao.RollbackTransaction;
begin
  //Session.FindDatabase(cDataBaseName).Rollback; -- BDE Connection
  TInstantDBXConnector(InstantDefaultConnector).RollbackTransaction;
  FQuery.Close;
end;

procedure TSingletonConexao.StartTransaction;
begin
  //Session.FindDatabase(cDataBaseName).StartTransaction; -- BDE Connection
  TInstantDBXConnector(InstantDefaultConnector).StartTransaction;
end;

initialization

finalization
  SafeFree(m_Instancia);

end.
