unit uRotinasComuns;

interface

uses
  Windows, SysUtils, ComCtrls, Menus, Classes, Controls,
  Forms, Registry, Data.DB, Vcl.Buttons, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Graphics, Vcl.ExtCtrls, System.IniFiles, ClipBRD;

function funcApenasNumeros(strValor: string): string;

// ROTINA QUE SETA O FOCO EM UM CAMPO PASSADO COMO PARAMETRO
procedure procSetarFoco(const AComponente: TWinControl;
  const ASelecionarTexto: boolean = True);

function funcRecuperarCaminhoConfiguracoesDoBanco: String;

function funcLerArquivoINI(const AArquivo, ASessao, AChave: string): string;

// ROTINA QUE SETA O FOCO EM UM CAMPO PASSADO COMO PARAMETRO
procedure procSetarCorNoCampo(const AComponente: TWinControl;
  ALeitura, ARequirido: boolean);

// ROTINA QUE REALIZA A VALIDACAO DO KEYPRESS PARA CAMPOS QUE DEVEM ACEITAR APENAS NUMEROS
// Caso o parâmetro AAceitarVirgula estiver como True
// passar o parâmetro ATexto (texto do campo), para aceitar apenas uma vírgula
procedure procAceitarApenasNumeros(var Key: Char; AHabilitaCopiarColar: Boolean = True; AAceitarVirgula: Boolean = False; ATexto: String = '');

implementation

uses uMensagens, uConstantes;

function funcApenasNumeros(strValor: string): string;
const
  Numeros = '0123456789';

var
  bytPosicao: byte;
  I: integer;
  retorno: string;
begin
  retorno := '';
  for I := 1 to Length(strValor) do
  begin
    bytPosicao := pos(strValor[I], Numeros);
    if bytPosicao <> 0 then // Se é um caracter numérico
      retorno := retorno + strValor[I];
  end;
  Result := retorno;
end;

procedure procSetarFoco(const AComponente: TWinControl;
  const ASelecionarTexto: boolean);
begin
  try
    if (AComponente = nil) then
      exit;

    if AComponente.CanFocus then
      AComponente.SetFocus;

    if (not(ASelecionarTexto)) then
      exit;

    if (AComponente is TLabeledEdit) then
      TLabeledEdit(AComponente).SelectAll;
  except
    on E: Exception do
      MensagemErro('Erro ao tentar focar no componente: ' + AComponente.Name);
  end;
end;

function funcLerArquivoINI(const AArquivo, ASessao, AChave: string): string;
var
  iniArq: TIniFile;
begin
  try
    iniArq := TIniFile.Create(AArquivo);
    result := iniArq.ReadString(ASessao, AChave, EmptyStr);
  finally
    FreeAndNil(iniArq);
  end;
end;

function funcRecuperarCaminhoConfiguracoesDoBanco: String;
begin
  result := ExtractFilePath(Application.ExeName) + 'config.ini';
end;

procedure procSetarCorNoCampo(const AComponente: TWinControl;
  ALeitura, ARequirido: boolean);
var
  cCorCampo: TColor;
  boolSomenteLeitura: boolean;
begin
  try
    if (AComponente = nil) then
      exit;

    boolSomenteLeitura := False;

    if ALeitura and ARequirido then
      cCorCampo := COR_WHITE
    else if ALeitura then
    begin
      cCorCampo := COR_READONLY;
      boolSomenteLeitura := True;
    end
    else if ARequirido then
      cCorCampo := COR_REQUIRIDO;

    if (AComponente is TEdit) then
    begin
      TEdit(AComponente).Color := cCorCampo;
      TEdit(AComponente).ReadOnly := boolSomenteLeitura;

      if ALeitura then
        TEdit(AComponente).Font.Style := TEdit(AComponente).Font.Style
          + [fsBold];
    end
    else if (AComponente is TLabeledEdit) then
    begin
      TLabeledEdit(AComponente).Color := cCorCampo;
      TLabeledEdit(AComponente).ReadOnly := boolSomenteLeitura;

      if ALeitura then
        TLabeledEdit(AComponente).Font.Style := TLabeledEdit(AComponente)
          .Font.Style + [fsBold];
    end
    else if (AComponente is TDBEdit) then
    begin
      TDBEdit(AComponente).Color := cCorCampo;
      TDBEdit(AComponente).ReadOnly := boolSomenteLeitura;

      if ALeitura then
        TDBEdit(AComponente).Font.Style := TDBEdit(AComponente).Font.Style
          + [fsBold];
    end
    else if (AComponente is TDBLookupComboBox) then
    begin
      TDBLookupComboBox(AComponente).Color := cCorCampo;
      TDBLookupComboBox(AComponente).ReadOnly := boolSomenteLeitura;

      if ALeitura then
        TDBLookupComboBox(AComponente).Font.Style :=
          TDBLookupComboBox(AComponente).Font.Style + [fsBold];
    end
    else if (AComponente is TDBMemo) then
    begin
      TDBMemo(AComponente).Color := cCorCampo;
      TDBMemo(AComponente).ReadOnly := boolSomenteLeitura;

      if ALeitura then
        TDBMemo(AComponente).Font.Style := TDBMemo(AComponente).Font.Style
          + [fsBold];
    end
    else if (AComponente is TDBRadioGroup) then
    begin
      TDBRadioGroup(AComponente).Color := cCorCampo;
      TDBRadioGroup(AComponente).ReadOnly := boolSomenteLeitura;

      if ALeitura then
        TDBRadioGroup(AComponente).Font.Style := TDBRadioGroup(AComponente)
          .Font.Style + [fsBold];
    end;

  except
  end;
end;

procedure procAceitarApenasNumeros(var Key: Char; AHabilitaCopiarColar, AAceitarVirgula: Boolean; ATexto: String);
begin
  // Caso utilize a cópia e for colar, retorna apenas as informações que é só numero (sonum)
  if (AHabilitaCopiarColar) and (Key = ^V) then
    Clipboard.AsText := funcApenasNumeros(Clipboard.AsText); // Declare no Uses " ClipBRD "

  // Caso seja necessário habilitar a cópia da informação do campo
  if (AHabilitaCopiarColar) then
  begin
    if AAceitarVirgula then // Caso seja necessário habilitar a Virgula (,)
    begin
      if (not(CharInSet(Key, ['0' .. '9', #8, #13, ',', ^V, ^C]))) then
        Key := #0;
    end
    else
    begin
      if (not(CharInSet(Key, ['0' .. '9', #8, #13, ^V, ^C]))) then
        Key := #0;
    end;
  end
  else
  begin
    if AAceitarVirgula then
    begin
      if (not(CharInSet(Key, ['0' .. '9', #8, #13, ',']))) then
        Key := #0;
    end
    else
    begin
      if (not(CharInSet(Key, ['0' .. '9', #8, #13]))) then
        Key := #0;
    end;
  end;

  if (ATexto <> EmptyStr) and (AAceitarVirgula) and (Key = ',') and (pos(',', ATexto) > 0) then
    Key := #0;
end;


end.
