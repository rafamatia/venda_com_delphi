unit uDAOConexao;

interface

uses FireDAC.Comp.Client, System.SysUtils;

type
  TDAOConexao = class
  protected
    Conexao: TFDConnection;
  public
    Qry: TFDQuery;
    Constructor Create;
    Destructor Destroy; override;
  end;

implementation

uses uFabricaConexao;

{ TDAOConexao }

constructor TDAOConexao.Create;
begin
  Conexao := TFabricaConexao.obterConexao;
  Qry := TFDQuery.Create(nil);
  Qry.Connection := Conexao;
end;

destructor TDAOConexao.Destroy;
begin
  if Assigned(Qry) then
    FreeAndNil(Qry);

  if Assigned(Conexao) then
  begin
    Conexao.Connected := False;
    FreeAndNil(Conexao);
  end;
  inherited;
end;

end.
