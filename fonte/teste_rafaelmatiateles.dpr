program teste_rafaelmatiateles;

uses
  Vcl.Forms,
  UFormPrincipal in 'telas\UFormPrincipal.pas' {FormPrincipal},
  UDmConexao in 'dm\UDmConexao.pas' {dmConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;
end.
