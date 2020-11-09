unit uParametrosConexao;

interface

type
  TParametrosConexao = class
  private
    FDatabase: string;
    FHostName: string;
    FUserName: string;
    FPassword: string;
    FPorta: string;
    FArquivoConfiguracao: string;
    procedure procCarregarParametros;
  public
    constructor Create(ACaminhoArquivoConfiguracao: string);
    property Database: string read FDatabase write FDatabase;
    property HostName: string read FHostName write FHostName;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
    property Porta: string read FPorta write FPorta;
    property ArquivoConfiguracao: string read FArquivoConfiguracao
      write FArquivoConfiguracao;
  end;

implementation

uses
  uRotinasComuns, StrUtils, SysUtils;

{ TParametrosConexao }

procedure TParametrosConexao.procCarregarParametros;
begin
  Database := funcLerArquivoINI(ArquivoConfiguracao, 'ACESSOAOBANCO',
    'DATABASE');
  HostName := funcLerArquivoINI(ArquivoConfiguracao, 'ACESSOAOBANCO',
    'HOSTNAME');
  UserName := funcLerArquivoINI(ArquivoConfiguracao, 'ACESSOAOBANCO',
    'USER_NAME');
  Password := funcLerArquivoINI(ArquivoConfiguracao, 'ACESSOAOBANCO',
    'PASSWORD');
  Porta := funcLerArquivoINI(ArquivoConfiguracao, 'PORTA', 'DATABASE');
end;

constructor TParametrosConexao.Create(ACaminhoArquivoConfiguracao: string);
begin
  FArquivoConfiguracao := ACaminhoArquivoConfiguracao;
  procCarregarParametros;
  inherited Create;
end;

end.
