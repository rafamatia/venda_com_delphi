unit uFabricaConexao;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.Async,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Option,
  FireDAC.VCLUI.Wait,
  FireDAC.UI.Intf,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  FireDAC.DApt,
  System.Classes,
  Data.DB;

type
  TFabricaConexao = class
  private
    class var FDConnection: TFDConnection;
  public
    class function obterConexao: TFDConnection;
  end;

implementation

{ TFabricaConexao }

uses uParametrosConexao, System.SysUtils, Vcl.Forms,
  Vcl.Dialogs, uRotinasComuns, uMensagens;

class function TFabricaConexao.obterConexao: TFDConnection;
var
  OParametroConexao: TParametrosConexao;
  strCaminhoConfiguracoes: String;
begin
  strCaminhoConfiguracoes := funcRecuperarCaminhoConfiguracoesDoBanco;

  try
    if not FileExists(strCaminhoConfiguracoes) then
      raise Exception.Create('Arquivo de Inicialização não Encontrado!' +
        sLineBreak + 'Contate o Suporte.');

    OParametroConexao := TParametrosConexao.Create(strCaminhoConfiguracoes);
    try
      FDConnection := TFDConnection.Create(nil);
      FDConnection.DriverName := 'MySQL';
      FDConnection.LoginPrompt := false;
      FDConnection.Params.Values['Database'] := OParametroConexao.Database;
      FDConnection.Params.Values['User_Name'] := OParametroConexao.UserName;
      FDConnection.Params.Values['Password'] := OParametroConexao.Password;
      FDConnection.Params.Values['Server'] := OParametroConexao.HostName;
      FDConnection.Params.Values['Port'] := OParametroConexao.Porta;
      FDConnection.Params.Values['DriverID'] := 'MySQL';

      with FDConnection.FormatOptions do
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

      FDConnection.Connected := True;
      Result := FDConnection;
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
