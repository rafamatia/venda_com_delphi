unit uRotinasComuns;

interface

uses
  Windows, SysUtils, ComCtrls, Menus, Classes, Controls,
  Forms, Registry, Data.DB, Vcl.Buttons, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Graphics, Vcl.ExtCtrls, System.IniFiles, ClipBRD, System.UITypes;

function funcApenasNumeros(strValor: string): string;

function funRetornaCorCampo(ALeitura, ARequirido: boolean): TColor;

procedure procSetarFoco(const AComponente: TWinControl;
  const ASelecionarTexto: boolean = True);

procedure procSetarCorNoCampo(const AComponente: TWinControl;
  ALeitura, ARequirido: boolean);

function funcRecuperarCaminhoConfiguracoesDoBanco: String;

function funcLerArquivoINI(const AArquivo, ASessao, AChave: string): string;



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
  intAux: integer;
  strRetorno: string;
begin
  strRetorno := EmptyStr;
  for intAux := 1 to Length(strValor) do
  begin
    bytPosicao := pos(strValor[intAux], Numeros);
    if bytPosicao <> 0 then // Se é um caracter numérico
    begin
      strRetorno := strRetorno + strValor[intAux];
    end;
  end;
  Result := strRetorno;
end;

procedure procSetarFoco(const AComponente: TWinControl;
  const ASelecionarTexto: boolean);
begin
  if (AComponente = nil) then
  begin
    exit;
  end;

  try
    if AComponente.CanFocus then
    begin
      AComponente.SetFocus;
    end;

    if (not(ASelecionarTexto)) then
    begin
      exit;
    end;

    if (AComponente is TLabeledEdit) then
    begin
      TLabeledEdit(AComponente).SelectAll;
    end;
  except
    on E: Exception do
    begin
      MensagemErro('Erro ao tentar focar no componente: ' + AComponente.Name);
    end;
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

function funRetornaCorCampo(ALeitura, ARequirido: boolean): TColor;
begin
  Result := COR_WHITE;

  if ((ALeitura) and (ARequirido)) then
    Exit;

  if ALeitura then
  begin
    Result := COR_READONLY;
    Exit;
  end;

  if ARequirido then
  begin
    Result := COR_REQUIRIDO;
  end;
end;

procedure procSetarCorNoCampo(const AComponente: TWinControl;
  ALeitura, ARequirido: boolean);
var
  cCorCampo: TColor;
  boolSomenteLeitura: boolean;
begin
  if (AComponente = nil) then
    exit;

  cCorCampo := funRetornaCorCampo(ALeitura, ARequirido);

  boolSomenteLeitura := False;
  if ((ALeitura) and (not (ARequirido))) then
  begin
    boolSomenteLeitura := True;
  end;

  if (AComponente is TEdit) then
  begin
    TEdit(AComponente).Color := cCorCampo;
    TEdit(AComponente).ReadOnly := boolSomenteLeitura;

    if ALeitura then
    begin
      TEdit(AComponente).Font.Style := TEdit(AComponente).Font.Style
        + [fsBold];
    end;

    Exit;
  end;

  if (AComponente is TLabeledEdit) then
  begin
    TLabeledEdit(AComponente).Color := cCorCampo;
    TLabeledEdit(AComponente).ReadOnly := boolSomenteLeitura;

    if ALeitura then
    begin
      TLabeledEdit(AComponente).Font.Style := TLabeledEdit(AComponente)
        .Font.Style + [fsBold];
    end;

    Exit;
  end;

  if (AComponente is TDBEdit) then
  begin
    TDBEdit(AComponente).Color := cCorCampo;
    TDBEdit(AComponente).ReadOnly := boolSomenteLeitura;

    if ALeitura then
    begin
      TDBEdit(AComponente).Font.Style := TDBEdit(AComponente).Font.Style
        + [fsBold];
    end;

    Exit;
  end;

  if (AComponente is TDBLookupComboBox) then
  begin
    TDBLookupComboBox(AComponente).Color := cCorCampo;
    TDBLookupComboBox(AComponente).ReadOnly := boolSomenteLeitura;

    if ALeitura then
    begin
      TDBLookupComboBox(AComponente).Font.Style :=
        TDBLookupComboBox(AComponente).Font.Style + [fsBold];
    end;
  end;

  if (AComponente is TDBMemo) then
  begin
    TDBMemo(AComponente).Color := cCorCampo;
    TDBMemo(AComponente).ReadOnly := boolSomenteLeitura;

    if ALeitura then
    begin
      TDBMemo(AComponente).Font.Style := TDBMemo(AComponente).Font.Style
        + [fsBold];
    end;

    Exit;
  end;

  if (AComponente is TDBRadioGroup) then
  begin
    TDBRadioGroup(AComponente).Color := cCorCampo;
    TDBRadioGroup(AComponente).ReadOnly := boolSomenteLeitura;

    if ALeitura then
    begin
      TDBRadioGroup(AComponente).Font.Style := TDBRadioGroup(AComponente)
        .Font.Style + [fsBold];
    end;
  end;
end;

procedure procAceitarApenasNumeros(var Key: Char; AHabilitaCopiarColar, AAceitarVirgula: Boolean; ATexto: String);
begin
  // Caso utilize a cópia e for colar, retorna apenas as informações que é só numero (sonum)
  if (AHabilitaCopiarColar) and (Key = ^V) then
  begin
    Clipboard.AsText := funcApenasNumeros(Clipboard.AsText); // Declare no Uses " ClipBRD "
  end;

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

    Exit;
  end;

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

  if (ATexto <> EmptyStr) and (AAceitarVirgula) and (Key = ',') and (pos(',', ATexto) > 0) then
  begin
    Key := #0;
  end;
end;


end.
