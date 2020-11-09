program teste_rafaelmatiateles;

uses
  Vcl.Forms,
  UFormPrincipal in 'telas\UFormPrincipal.pas' {FormPrincipal},
  UDmConexao in 'dm\UDmConexao.pas' {dmConexao: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  UFormConsultaPedidos in 'telas\UFormConsultaPedidos.pas' {FormConsultaPedidos},
  uDAOConexao in 'classes\uDAOConexao.pas',
  uFabricaConexao in 'classes\uFabricaConexao.pas',
  uParametrosConexao in 'classes\uParametrosConexao.pas',
  uMensagens in 'units\uMensagens.pas',
  uRotinasComuns in 'units\uRotinasComuns.pas',
  uPedidos in 'classes\uPedidos.pas',
  uPedidosDAO in 'classes\uPedidosDAO.pas',
  uTipos in 'units\uTipos.pas',
  UManutencaoPadrao in 'telas\standards\UManutencaoPadrao.pas' {cManuPadrao},
  UPequisaPadrao in 'telas\standards\UPequisaPadrao.pas' {pPesqPadrao},
  UFormConsultaClientes in 'telas\UFormConsultaClientes.pas' {FormConsultaClientes},
  UFormPedidos in 'telas\UFormPedidos.pas' {FormPedidos},
  uConstantes in 'units\uConstantes.pas',
  UDmPessoas in 'dm\UDmPessoas.pas' {dmPessoas: TDataModule},
  UDmProdutos in 'dm\UDmProdutos.pas' {dmProdutos: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmPessoas, dmPessoas);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TcManuPadrao, cManuPadrao);
  Application.CreateForm(TpPesqPadrao, pPesqPadrao);
  Application.CreateForm(TdmProdutos, dmProdutos);
  Application.Run;
end.
