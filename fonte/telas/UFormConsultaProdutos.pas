unit UFormConsultaProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPequisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Param;

type
  TFormConsultaProdutos = class(TpPesqPadrao)
    procedure gPadraoDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDadosChange(Sender: TObject);
    procedure edDadosKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    boolSomenteConsuta: Boolean;

    procedure procSelect;
  public
    { Public declarations }
    intProduto: Integer;
    strDescricaoProduto: String;
    dblVlrUnitario: Double;

    class function funcChamaTela(AOwner: TComponent;
      ASomentePesquisa: Boolean = False): Boolean;
  end;

var
  FormConsultaProdutos: TFormConsultaProdutos;

implementation

{$R *.dfm}

uses UDmProdutos, uRotinasComuns, uConstantes;
{ TFormConsultaProdutos }

procedure TFormConsultaProdutos.edDadosChange(Sender: TObject);
begin
  inherited;
  if ((Trim(edDados.Text) = EmptyStr) or ((not(rbCodigo.Checked)) and
    (Trim(edDados.Text) <> EmptyStr))) then
    procSelect;
end;

procedure TFormConsultaProdutos.edDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    procSelect;
end;

procedure TFormConsultaProdutos.edDadosKeyPress(Sender: TObject; var Key: Char);
begin
  if rbCodigo.Checked then
    procAceitarApenasNumeros(Key);
end;

procedure TFormConsultaProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  intProduto := 0;
  strDescricaoProduto := 'NENHUM';
  dblVlrUnitario := 0;
end;

procedure TFormConsultaProdutos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_ESCAPE:
      sb_SairClick(Sender);
  end;
end;

procedure TFormConsultaProdutos.FormShow(Sender: TObject);
begin
  inherited;
  procSelect;
end;

class function TFormConsultaProdutos.funcChamaTela(AOwner: TComponent;
  ASomentePesquisa: Boolean): Boolean;
begin
  FormConsultaProdutos.sbNovo.Visible := (not(ASomentePesquisa));
  FormConsultaProdutos.sbAlterar.Visible := (not(ASomentePesquisa));
  FormConsultaProdutos.sbExcluir.Visible := (not(ASomentePesquisa));
  FormConsultaProdutos.boolSomenteConsuta := ASomentePesquisa;
end;

procedure TFormConsultaProdutos.gPadraoDblClick(Sender: TObject);
begin
  if dmProdutos.qryProdutos.IsEmpty then
    Abort;

  if boolSomenteConsuta then
  begin
    intProduto := dmProdutos.qryProdutospro_codigo.AsInteger;
    strDescricaoProduto := dmProdutos.qryProdutospro_descricao.AsString;
    dblVlrUnitario := dmProdutos.qryProdutospro_preco_venda.AsFloat;
    Close;
  end;
end;

procedure TFormConsultaProdutos.procSelect;
var
  strSQL: String;
begin
  strSQL := C_SQL_PRODUTOS;
  { -------------------------------------------------
    FECHA A QRY
    ------------------------------------------------- }
  dmProdutos.qryProdutos.Close;
  dmProdutos.qryProdutos.SQL.Clear;
  { ------------------------------------------------ }

  { -------------------------------------------------
    MONTA WHERE DAS OPÇÕES DE CONSULTA
    ------------------------------------------------- }

  dmProdutos.qryProdutos.SQL.Text := strSQL;

  if edDados.Text <> EmptyStr then
  Begin
    strSQL := strSQL + C_WHERE_SIMPLES;

    if (rbCodigo.Checked) then { CÓDIGO }
    Begin
      strSQL := strSQL + ' A.pro_codigo = :CODIGO ';

      dmProdutos.qryProdutos.SQL.Text := strSQL;
      dmProdutos.qryProdutos.ParamByName('CODIGO').AsInteger :=
        StrToIntDef(edDados.Text, 0);
    End
    else
    begin
      strSQL := strSQL + ' upper(A.pro_descricao) LIKE ' +
        QuotedStr('%' + edDados.Text + '%');

      dmProdutos.qryProdutos.SQL.Text := strSQL;
    end;
  End;
  { ------------------------------------------------ }

  { ----------------------
    ABRE A QRY
    ---------------------- }
  dmProdutos.qryProdutos.Open;
  { --------------------- }
  procSetarFoco(edDados, False);
end;

end.
