unit uMensagens;

interface

uses
  {RotinasBanco,} System.SysUtils, Vcl.Dialogs, Vcl.Forms, Winapi.Windows;

procedure MensagemErro(const AMensagem: string; const ACaption: string = 'Erro');
procedure MensagemAviso(const AMensagem: string; const ACaption: string = 'Aviso');
procedure MensagemInformacao(const AMensagem: string; const ACaption: string = 'Informação');
function Pergunta(const AMensagem: string; const ACaption: string = 'Confirmação';  ABotaoPadrao: integer = MB_DEFBUTTON2): Boolean;

implementation

procedure MensagemErro(const AMensagem: string; const ACaption: string);
begin
  Application.MessageBox(@AMensagem[1], @ACaption[1], MB_OK + MB_ICONERROR);
end;

procedure MensagemAviso(const AMensagem: string; const ACaption: string);
begin
  Application.MessageBox(@AMensagem[1], @ACaption[1], MB_OK + MB_ICONWARNING);
end;

procedure MensagemInformacao(const AMensagem: string; const ACaption: string);
begin
  Application.MessageBox(@AMensagem[1], @ACaption[1], MB_OK + MB_ICONINFORMATION);
end;

function Pergunta(const AMensagem: string; const ACaption: string;
  ABotaoPadrao: integer): Boolean;
begin
  result := (Application.MessageBox(@AMensagem[1], @ACaption[1], MB_ICONQUESTION + MB_YESNO + ABotaoPadrao) = IDYES);
end;

end.
