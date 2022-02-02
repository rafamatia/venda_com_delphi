unit UFormConsultaClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPequisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Param;

type
  TFormConsultaClientes = class(TpPesqPadrao)
    procedure edDadosChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edDadosKeyPress(Sender: TObject; var Key: Char);
    procedure gPadraoDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    boolSomenteConsuta: Boolean;

    procedure procSelect;
  public
    { Public declarations }
    intCliente: Integer;
    strNomeCliente: String;

    class function funcChamaTela(AOwner: TComponent;
      ASomentePesquisa: Boolean = False): Boolean;
  end;

var
  FormConsultaClientes: TFormConsultaClientes;

implementation

{$R *.dfm}

uses uRotinasComuns, uConstantes, UDmPessoas;
{ TFormConsultaClientes }

procedure TFormConsultaClientes.edDadosChange(Sender: TObject);
begin
  inherited;
  if ((Trim(edDados.Text) = EmptyStr) or ((not(rbCodigo.Checked)) and
    (Trim(edDados.Text) <> EmptyStr))) then
    procSelect;
end;

procedure TFormConsultaClientes.edDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    procSelect;
end;

procedure TFormConsultaClientes.edDadosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if rbCodigo.Checked then
    procAceitarApenasNumeros(Key);
end;

procedure TFormConsultaClientes.FormCreate(Sender: TObject);
begin
  inherited;
  intCliente := 0;
  strNomeCliente := 'NENHUM'
end;

procedure TFormConsultaClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      sb_SairClick(Sender);
  end;
end;

procedure TFormConsultaClientes.FormShow(Sender: TObject);
begin
  inherited;
  procSelect;
end;

class function TFormConsultaClientes.funcChamaTela(AOwner: TComponent;
  ASomentePesquisa: Boolean): Boolean;
begin
  FormConsultaClientes.sbNovo.Visible := (not(ASomentePesquisa));
  FormConsultaClientes.sbAlterar.Visible := (not(ASomentePesquisa));
  FormConsultaClientes.sbExcluir.Visible := (not(ASomentePesquisa));
  FormConsultaClientes.boolSomenteConsuta := ASomentePesquisa;
end;

procedure TFormConsultaClientes.gPadraoDblClick(Sender: TObject);
begin
  if dmPessoas.qryClientes.IsEmpty then
    Abort;

  if boolSomenteConsuta then
  begin
    intCliente := dmPessoas.qryClientescli_codigo.AsInteger;
    strNomeCliente := dmPessoas.qryClientescli_nome.AsString;
    Close;
  end;
end;

procedure TFormConsultaClientes.procSelect;
var
  strSQL: String;
begin
  strSQL := C_SQL_CLIENTES;
  { -------------------------------------------------
    FECHA A QRY
    ------------------------------------------------- }
  dmPessoas.qryClientes.Close;
  dmPessoas.qryClientes.SQL.Clear;
  { ------------------------------------------------ }

  { -------------------------------------------------
    MONTA WHERE DAS OPÇÕES DE CONSULTA
    ------------------------------------------------- }

  dmPessoas.qryClientes.SQL.Text := strSQL;

  if edDados.Text <> EmptyStr then
  Begin
    strSQL := strSQL + C_WHERE_SIMPLES;

    if (rbCodigo.Checked) then { CÓDIGO }
    Begin
      strSQL := strSQL + ' A.CLI_CODIGO = :CODIGO ';

      dmPessoas.qryClientes.SQL.Text := strSQL;
      dmPessoas.qryClientes.ParamByName('CODIGO').AsInteger :=
        StrToIntDef(edDados.Text, 0);
    End
    else
    begin
      strSQL := strSQL + ' upper(A.CLI_NOME) LIKE ' +
        QuotedStr('%' + edDados.Text + '%');

      dmPessoas.qryClientes.SQL.Text := strSQL;
    end;
  End;
  { ------------------------------------------------ }

  { ----------------------
    ABRE A QRY
    ---------------------- }
  dmPessoas.qryClientes.Open;
  { --------------------- }
  procSetarFoco(edDados, False);
end;

end.
