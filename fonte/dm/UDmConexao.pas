unit UDmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL;

type
  TdmConexao = class(TDataModule)
    fdcConexao: TFDConnection;
    DriverMySQL: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure procConectarBanco;
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uParametrosConexao, uRotinasComuns;

{$R *.dfm}
{ TdmConexao }

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  procConectarBanco;
end;

procedure TdmConexao.procConectarBanco;
var
  OParametroConexao: TParametrosConexao;
  strCaminhoConfiguracoes: String;
begin
  fdcConexao.Connected := False;
  strCaminhoConfiguracoes := funcRecuperarCaminhoConfiguracoesDoBanco;

  try
    if not FileExists(strCaminhoConfiguracoes) then
      raise Exception.Create('Arquivo de Inicialização não Encontrado!' +
        sLineBreak + 'Contate o Suporte.');

    OParametroConexao := TParametrosConexao.Create(strCaminhoConfiguracoes);
    try
      fdcConexao.DriverName := 'MySQL';
      fdcConexao.LoginPrompt := False;
      fdcConexao.Params.Values['Database'] := OParametroConexao.Database;
      fdcConexao.Params.Values['User_Name'] := OParametroConexao.UserName;
      fdcConexao.Params.Values['Password'] := OParametroConexao.Password;
      fdcConexao.Params.Values['Server'] := OParametroConexao.HostName;
      fdcConexao.Params.Values['Port'] := OParametroConexao.Porta;
      fdcConexao.Params.Values['DriverID'] := 'MySQL';

      with fdcConexao.FormatOptions do
      begin
        OwnMapRules := True;
        with MapRules.Add do
        begin
          ScaleMin := -1;
          ScaleMax := -1;
          PrecMin := -1;
          PrecMax := -1;
          SourceDataType := dtDateTime;
          TargetDataType := dtDateTimeStamp;
        end;
      end;

      fdcConexao.Connected := True;
    finally
      if Assigned(OParametroConexao) then
        FreeAndNil(OParametroConexao);
    end;
  except
    on E: Exception do
      raise Exception.Create
        ('Erro ao criar o componente de conexão com o banco de dados!' +
        sLineBreak + sLineBreak + 'Informações Técnicas:' + sLineBreak +
        E.Message);
  end;
end;

end.
