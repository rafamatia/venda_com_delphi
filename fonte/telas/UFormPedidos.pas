unit UFormPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutencaoPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, uPedidos,
  uPedidosDAO, uTipos;

type
  TFormPedidos = class(TcManuPadrao)
    pnlItensPedido: TPanel;
    pnlDadosPedido: TPanel;
    gbItensPedido: TGroupBox;
    gItensPedido: TDBGrid;
    edtNomeDoCliente: TEdit;
    edtDtEmissao: TLabeledEdit;
    edtStatusPedido: TLabeledEdit;
    Label1: TLabel;
    edtClientes: TEdit;
    btnConsultarClientes: TBitBtn;
    Label2: TLabel;
    edtCodProduto: TEdit;
    btnConsultarProdutos: TBitBtn;
    edtDescProduto: TEdit;
    edtQuantidade: TLabeledEdit;
    edtVlrUnitario: TLabeledEdit;
    edtSubTotalItem: TLabeledEdit;
    btnInc: TBitBtn;
    btnExc: TBitBtn;
    edtCodigo: TLabeledEdit;
    edtVlrTotalPedido: TEdit;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure btnIncClick(Sender: TObject);
    procedure btnConsultarClientesClick(Sender: TObject);
    procedure edtClientesExit(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
  private
    { Private declarations }
    OPedido: TPedido;
    OPedidoDAO: TPedidoDAO;

    procedure procInicializarCamposProduto;
  public
    { Public declarations }
    tspStatus: TStatusPedido;
    intNrPedido: Integer;
  end;

var
  FormPedidos: TFormPedidos;

implementation

{$R *.dfm}

uses uRotinasComuns, uConstantes, UFormConsultaClientes, UDmPessoas,
  UDmProdutos;

procedure TFormPedidos.btnConsultarClientesClick(Sender: TObject);
begin
  FormConsultaClientes := TFormConsultaClientes.Create(Self);
  try
    FormConsultaClientes.funcChamaTela(Self, True);
    FormConsultaClientes.ShowModal;
  finally
    edtClientes.Text := IntToStr(FormConsultaClientes.intCliente);
    edtNomeDoCliente.Text := FormConsultaClientes.strNomeCliente;
    FreeAndNil(FormConsultaClientes);
  end;
end;

procedure TFormPedidos.btnIncClick(Sender: TObject);
begin
  inherited;
  procInicializarCamposProduto;
end;

procedure TFormPedidos.edtClientesExit(Sender: TObject);
begin
  dmPessoas.qryClientes.Close;
  dmPessoas.qryClientes.SQL.Clear;
  dmPessoas.qryClientes.SQL.Text := C_SQL_CLIENTES + C_WHERE_SIMPLES +
    ' a.cli_codigo = :cli_codigo ';
  dmPessoas.qryClientes.ParamByName('cli_codigo').AsInteger :=
    StrToIntDef(edtClientes.Text, 0);
  dmPessoas.qryClientes.Open;
  if dmPessoas.qryClientes.IsEmpty then
  begin
    edtClientes.Text := '0';
    edtNomeDoCliente.Text := 'NENHUM';
  end
  else
  begin
    edtClientes.Text := dmPessoas.qryClientescli_codigo.AsString;
    edtNomeDoCliente.Text := dmPessoas.qryClientescli_nome.AsString;
  end;
end;

procedure TFormPedidos.edtCodProdutoExit(Sender: TObject);
begin
  dmProdutos.qryProdutos.Close;
  dmProdutos.qryProdutos.SQL.Clear;
  dmProdutos.qryProdutos.SQL.Text := C_SQL_PRODUTOS + C_WHERE_SIMPLES +
    ' a.pro_codigo = :pro_codigo ';
  dmProdutos.qryProdutos.ParamByName('pro_codigo').AsInteger :=
    StrToIntDef(edtCodProduto.Text, 0);
  dmProdutos.qryProdutos.Open;
  if dmProdutos.qryProdutos.IsEmpty then
    procInicializarCamposProduto
  else
  begin
    edtCodProduto.Text := dmProdutos.qryProdutospro_codigo.AsString;
    edtDescProduto.Text := dmProdutos.qryProdutospro_descricao.AsString;
    edtVlrUnitario.Text := FormatFloat(C_MASCARA_VALOR,
      dmProdutos.qryProdutospro_preco_venda.AsFloat);
    edtQuantidadeExit(Sender);
  end;
end;

procedure TFormPedidos.edtQuantidadeExit(Sender: TObject);
var
  dblQuantidade, dblVlrUnitario, dblVlrTotal: Double;
begin
  inherited;
  dblQuantidade := StrToFloatDef(StringReplace(edtQuantidade.Text, '.', '',
    [rfReplaceAll]), 0);
  dblVlrUnitario := StrToFloatDef(StringReplace(edtVlrUnitario.Text, '.', '',
    [rfReplaceAll]), 0);
  dblVlrTotal := (dblQuantidade * dblVlrUnitario);
  edtSubTotalItem.Text := FormatFloat(C_MASCARA_VALOR, dblVlrTotal);
  edtQuantidade.Text := FormatFloat(C_MASCARA_VALOR, dblQuantidade);
  edtVlrUnitario.Text := FormatFloat(C_MASCARA_VALOR, dblVlrUnitario);
end;

procedure TFormPedidos.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in ['0' .. '9', '.', ',', #8, #13]) then
    Key := #0;
  if Key = FormatSettings.DecimalSeparator then
    if pos(Key, TEdit(Sender).Text) <> 0 then
      Key := #0;
end;

procedure TFormPedidos.FormShow(Sender: TObject);
begin
  inherited;
  procInicializarCamposProduto;

  edtVlrTotalPedido.Text := FormatFloat(C_MASCARA_VALOR, 0);

  OPedido := TPedido.Create;
  OPedidoDAO := TPedidoDAO.Create;

  if (tspStatus = tspAberto) then
    OPedidoDAO.recuperaProximoIDDoPedido(OPedido)
  else
  begin
    OPedido.PedNumero := intNrPedido;
    OPedidoDAO.procCarregarDadosDoPedido(OPedido);
  end;

  edtCodigo.Text := IntToStr(OPedido.PedNumero);
  edtDtEmissao.Text := FormatDateTime('DD/MM/YYYY', OPedido.PedDataEmissao);
  edtClientes.Text := IntToStr(OPedido.PedFKCliente);
  edtNomeDoCliente.Text := OPedido.NomeCliente;

  if (OPedido.PedStatus = TStatusPedidoFlag[tspAberto]) then
  begin
    edtStatusPedido.Color := clGreen;
    edtStatusPedido.Text := TStatusPedidoDesc[tspAberto];
  end
  else if (OPedido.PedStatus = TStatusPedidoFlag[tspCancelado]) then
  begin
    edtStatusPedido.Color := clRED;
    edtStatusPedido.Text := TStatusPedidoDesc[tspCancelado];
  end
  else if (OPedido.PedStatus = TStatusPedidoFlag[tspEmDigitacao]) then
  begin
    edtStatusPedido.Color := clSilver;
    edtStatusPedido.Text := TStatusPedidoDesc[tspEmDigitacao];
  end;

  // CAMPOS BLOQUEADOS
  procSetarCorNoCampo(edtCodigo, True, False);
  procSetarCorNoCampo(edtDtEmissao, True, False);
  procSetarCorNoCampo(edtNomeDoCliente, True, False);
  procSetarCorNoCampo(edtDescProduto, True, False);
  procSetarCorNoCampo(edtSubTotalItem, True, False);
  procSetarCorNoCampo(edtVlrTotalPedido, True, False);

  procSetarFoco(edtClientes, False);
end;

procedure TFormPedidos.procInicializarCamposProduto;
begin
  edtCodProduto.Text := '0';
  edtDescProduto.Text := 'NENHUM';
  edtSubTotalItem.Text := FormatFloat(C_MASCARA_VALOR, 0);
  edtQuantidade.Text := FormatFloat(C_MASCARA_VALOR, 1);
  edtVlrUnitario.Text := FormatFloat(C_MASCARA_VALOR, 0);
end;

end.
