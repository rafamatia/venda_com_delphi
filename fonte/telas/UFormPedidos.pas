unit UFormPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutencaoPadrao, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, uPedidos,
  uPedidosDAO, uTipos, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormPedidos = class(TcManuPadrao)
    pnlItensPedido: TPanel;
    pnlDadosPedido: TPanel;
    gbItensPedido: TGroupBox;
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
    DBGrid1: TDBGrid;
    fdmtItens: TFDMemTable;
    dsItens: TDataSource;
    fdmtItensitp_fkproduto: TIntegerField;
    fdmtItenspro_descricao: TStringField;
    fdmtItensitp_quantidade: TFloatField;
    fdmtItensitp_vlrunitario: TFloatField;
    fdmtItensitp_vlrtotal: TFloatField;
    fdmtItensindex: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure btnIncClick(Sender: TObject);
    procedure btnConsultarClientesClick(Sender: TObject);
    procedure edtClientesExit(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure btnConsultarProdutosClick(Sender: TObject);
    procedure btnExcClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbGravarClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
  private
    { Private declarations }
    OPedido: TPedido;
    OPedidoDAO: TPedidoDAO;

    procedure procInicializarCamposProduto;
    procedure procValidarPedido;
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
  UDmProdutos, UFormConsultaProdutos, uItemPedido, uMensagens;

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

procedure TFormPedidos.btnConsultarProdutosClick(Sender: TObject);
begin
  FormConsultaProdutos := TFormConsultaProdutos.Create(Self);
  try
    FormConsultaProdutos.funcChamaTela(Self, True);
    FormConsultaProdutos.ShowModal;
  finally
    edtCodProduto.Text := IntToStr(FormConsultaProdutos.intProduto);
    edtDescProduto.Text := FormConsultaProdutos.strDescricaoProduto;
    edtVlrUnitario.Text := FormatFloat(C_MASCARA_VALOR,
      FormConsultaProdutos.dblVlrUnitario);
    edtQuantidadeExit(Sender);
  end;
end;

procedure TFormPedidos.btnExcClick(Sender: TObject);
var
  ItemPedido: TItemPedido;
begin
  if (not(Pergunta('Deseja realmente excluir o item?' + sLineBreak + 'PRODUTO: '
    + fdmtItensitp_fkproduto.AsString + ' - ' + fdmtItenspro_descricao.AsString
    + sLineBreak))) then
    Abort;

  for ItemPedido in OPedido.ListaItensPedido do
  begin
    if (OPedido.ListaItensPedido.IndexOf(ItemPedido) = fdmtItensindex.AsInteger)
    then
    begin
      OPedido.ListaItensPedido.Remove(ItemPedido);
      fdmtItens.Delete;
      Break;
    end;
  end;

  if (not(fdmtItens.Active)) then
    fdmtItens.Active;
  fdmtItens.EmptyDataSet;

  for ItemPedido in OPedido.ListaItensPedido do
  begin
    fdmtItens.Append;
    fdmtItensitp_fkproduto.AsInteger := ItemPedido.ItpFKProduto;
    fdmtItenspro_descricao.AsString := ItemPedido.DescProduto;
    fdmtItensitp_quantidade.AsFloat := ItemPedido.ItpQuantidade;
    fdmtItensitp_vlrunitario.AsFloat := ItemPedido.ItpVlrUnitario;
    fdmtItensitp_vlrtotal.AsFloat := ItemPedido.ItpVlrTotal;
    fdmtItensindex.AsInteger := OPedido.ListaItensPedido.IndexOf(ItemPedido);
    fdmtItens.Post;
  end;

  fdmtItens.First;

  OPedido.procCalcularTotalPedido;
  edtVlrTotalPedido.Text := FormatFloat(C_MASCARA_VALOR, OPedido.PedVlrTotal);
end;

procedure TFormPedidos.btnIncClick(Sender: TObject);
var
  ItemPedido: TItemPedido;
begin
  if StrToIntDef(edtCodProduto.Text, 0) = 0 then
  begin
    MensagemAviso('É necessário informar o produto.');
    procSetarFoco(edtCodProduto, False);
    Abort;
  end;

  if StrToFloatDef(StringReplace(edtSubTotalItem.Text, '.', '', [rfReplaceAll]),
    0) = 0 then
  begin
    MensagemAviso('É necessário informar o valor ao produto.');
    procSetarFoco(edtQuantidade, False);
    Abort;
  end;

  if btnExc.Enabled then
  begin
    OPedido.PedFKCliente := StrToIntDef(edtClientes.Text, 0);
    OPedido.NomeCliente := edtNomeDoCliente.Text;
    OPedido.AdicionarItemAoPedido(0, OPedido.PedNumero,
      StrToIntDef(edtCodProduto.Text, 0), edtDescProduto.Text,
      StrToFloatDef(StringReplace(edtQuantidade.Text, '.', '', [rfReplaceAll]),
      0), StrToFloatDef(StringReplace(edtVlrUnitario.Text, '.', '',
      [rfReplaceAll]), 0), StrToFloatDef(StringReplace(edtSubTotalItem.Text,
      '.', '', [rfReplaceAll]), 0));

    // Percorre a lista de objetos, inserindo o valor da propriedade "Nome" do ClientDataSet
    if (not(fdmtItens.Active)) then
      fdmtItens.Active;
    fdmtItens.EmptyDataSet;

    for ItemPedido in OPedido.ListaItensPedido do
    begin
      fdmtItens.Append;
      fdmtItensitp_fkproduto.AsInteger := ItemPedido.ItpFKProduto;
      fdmtItenspro_descricao.AsString := ItemPedido.DescProduto;
      fdmtItensitp_quantidade.AsFloat := ItemPedido.ItpQuantidade;
      fdmtItensitp_vlrunitario.AsFloat := ItemPedido.ItpVlrUnitario;
      fdmtItensitp_vlrtotal.AsFloat := ItemPedido.ItpVlrTotal;
      fdmtItensindex.AsInteger := OPedido.ListaItensPedido.IndexOf(ItemPedido);
      fdmtItens.Post;
    end;

    fdmtItens.First;
  end
  else
  begin
    OPedido.ListaItensPedido.Items[fdmtItensindex.AsInteger].ItpFKProduto :=
      StrToIntDef(edtCodProduto.Text, 0);
    OPedido.ListaItensPedido.Items[fdmtItensindex.AsInteger].DescProduto :=
      edtDescProduto.Text;
    OPedido.ListaItensPedido.Items[fdmtItensindex.AsInteger].ItpQuantidade :=
      StrToFloatDef(StringReplace(edtQuantidade.Text, '.', '',
      [rfReplaceAll]), 0);
    OPedido.ListaItensPedido.Items[fdmtItensindex.AsInteger].ItpVlrUnitario :=
      StrToFloatDef(StringReplace(edtVlrUnitario.Text, '.', '',
      [rfReplaceAll]), 0);
    OPedido.ListaItensPedido.Items[fdmtItensindex.AsInteger].ItpVlrTotal :=
      StrToFloatDef(StringReplace(edtSubTotalItem.Text, '.', '',
      [rfReplaceAll]), 0);

    fdmtItens.Edit;
    fdmtItensitp_fkproduto.AsInteger := OPedido.ListaItensPedido.Items
      [fdmtItensindex.AsInteger].ItpFKProduto;
    fdmtItenspro_descricao.AsString := OPedido.ListaItensPedido.Items
      [fdmtItensindex.AsInteger].DescProduto;
    fdmtItensitp_quantidade.AsFloat := OPedido.ListaItensPedido.Items
      [fdmtItensindex.AsInteger].ItpQuantidade;
    fdmtItensitp_vlrunitario.AsFloat := OPedido.ListaItensPedido.Items
      [fdmtItensindex.AsInteger].ItpVlrUnitario;
    fdmtItensitp_vlrtotal.AsFloat := OPedido.ListaItensPedido.Items
      [fdmtItensindex.AsInteger].ItpVlrTotal;
    fdmtItens.Post;

    OPedido.procCalcularTotalPedido;
  end;

  btnExc.Enabled := True;
  DBGrid1.Enabled := True;
  Application.ProcessMessages;

  edtVlrTotalPedido.Text := FormatFloat(C_MASCARA_VALOR, OPedido.PedVlrTotal);

  procInicializarCamposProduto;

  procSetarFoco(edtCodProduto, False);
end;

procedure TFormPedidos.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (not(fdmtItens.Active)) then
    Exit;

  if (fdmtItens.RecordCount < 1) then
    Exit;

  case Key of
    VK_RETURN:
      begin
        procInicializarCamposProduto;
        edtCodProduto.Text := fdmtItensitp_fkproduto.AsString;
        edtDescProduto.Text := fdmtItenspro_descricao.AsString;
        edtSubTotalItem.Text := FormatFloat(C_MASCARA_VALOR,
          fdmtItensitp_vlrtotal.AsFloat);
        edtQuantidade.Text := FormatFloat(C_MASCARA_VALOR,
          fdmtItensitp_quantidade.AsFloat);
        edtVlrUnitario.Text := FormatFloat(C_MASCARA_VALOR,
          fdmtItensitp_vlrunitario.AsFloat);
        btnExc.Enabled := False;
        DBGrid1.Enabled := False;
        Application.ProcessMessages;
      end;

    VK_DELETE:
      btnExcClick(Sender);
  end;
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
var
  ItemPedido: TItemPedido;
begin
  inherited;
  procInicializarCamposProduto;

  fdmtItens.Active := False;
  fdmtItens.CreateDataSet;
  fdmtItens.Active := True;
  fdmtItens.EmptyDataSet;

  OPedido := TPedido.Create;
  OPedidoDAO := TPedidoDAO.Create;

  if (tspStatus = tspAberto) then
    OPedidoDAO.recuperaProximoIDDoPedido(OPedido)
  else
  begin
    OPedido.PedNumero := intNrPedido;
    OPedidoDAO.procCarregarDadosDoPedido(OPedido);
    if (OPedido.ListaItensPedido.Count > 0) then
    begin
      if (not(fdmtItens.Active)) then
        fdmtItens.Active;
      fdmtItens.EmptyDataSet;

      for ItemPedido in OPedido.ListaItensPedido do
      begin
        fdmtItens.Append;
        fdmtItensitp_fkproduto.AsInteger := ItemPedido.ItpFKProduto;
        fdmtItenspro_descricao.AsString := ItemPedido.DescProduto;
        fdmtItensitp_quantidade.AsFloat := ItemPedido.ItpQuantidade;
        fdmtItensitp_vlrunitario.AsFloat := ItemPedido.ItpVlrUnitario;
        fdmtItensitp_vlrtotal.AsFloat := ItemPedido.ItpVlrTotal;
        fdmtItensindex.AsInteger := OPedido.ListaItensPedido.IndexOf
          (ItemPedido);
        fdmtItens.Post;
      end;

      fdmtItens.First;
    end;
  end;

  edtCodigo.Text := IntToStr(OPedido.PedNumero);
  edtDtEmissao.Text := FormatDateTime('DD/MM/YYYY', OPedido.PedDataEmissao);
  edtClientes.Text := IntToStr(OPedido.PedFKCliente);
  edtNomeDoCliente.Text := OPedido.NomeCliente;

  if ((OPedido.PedStatus = TStatusPedidoFlag[tspAberto]) or
    (OPedido.PedStatus = TStatusPedidoFlag[tspEmDigitacao])) then
  begin
    edtStatusPedido.Color := clGreen;
    edtStatusPedido.Text := TStatusPedidoDesc[tspAberto];
  end
  else if (OPedido.PedStatus = TStatusPedidoFlag[tspCancelado]) then
  begin
    edtStatusPedido.Color := clRED;
    edtStatusPedido.Text := TStatusPedidoDesc[tspCancelado];
  end;

  // CAMPOS BLOQUEADOS
  procSetarCorNoCampo(edtCodigo, True, False);
  procSetarCorNoCampo(edtDtEmissao, True, False);
  procSetarCorNoCampo(edtNomeDoCliente, True, False);
  procSetarCorNoCampo(edtDescProduto, True, False);
  procSetarCorNoCampo(edtSubTotalItem, True, False);
  procSetarCorNoCampo(edtVlrTotalPedido, True, False);

  procSetarFoco(edtClientes, False);

  edtVlrTotalPedido.Text := FormatFloat(C_MASCARA_VALOR, OPedido.PedVlrTotal);
end;

procedure TFormPedidos.procInicializarCamposProduto;
begin
  edtCodProduto.Text := '0';
  edtDescProduto.Text := 'NENHUM';
  edtSubTotalItem.Text := FormatFloat(C_MASCARA_VALOR, 0);
  edtQuantidade.Text := FormatFloat(C_MASCARA_VALOR, 1);
  edtVlrUnitario.Text := FormatFloat(C_MASCARA_VALOR, 0);
end;

procedure TFormPedidos.procValidarPedido;
begin
  OPedido.PedFKCliente := StrToIntDef(edtClientes.Text, 0);
  OPedido.NomeCliente := edtNomeDoCliente.Text;

  if OPedido.PedFKCliente = 0 then
  begin
    MensagemAviso('É necessário informar um cliente para o pedido.');
    procSetarFoco(edtClientes, False);
    Abort;
  end;

  if OPedido.ListaItensPedido.Count < 1 then
  begin
    MensagemAviso('É necessário informar o(s) produto(s) para o pedido.');
    procSetarFoco(edtCodProduto, False);
    Abort;
  end;
end;

procedure TFormPedidos.sbCancelarClick(Sender: TObject);
begin
  if ((tspStatus = tspEmDigitacao) and (sbGravar.Enabled)) then
  begin
    if (not(Pergunta('Deseja realmente cancelar as alterações realizadas?')))
    then
      Abort;

    OPedido.PedStatus := TStatusPedidoFlag[tspAberto];
    OPedidoDAO.procAtualizarStatusPedido(OPedido);
  end;

  inherited;
end;

procedure TFormPedidos.sbGravarClick(Sender: TObject);
begin
  inherited;
  procValidarPedido;

  if (tspStatus = tspAberto) then
  begin
    if OPedidoDAO.funcGravarPedido(OPedido) then
    begin
      MensagemInformacao('Pedido realizado com sucesso!');
      Close;
    end;
  end
  else if (tspStatus = tspEmDigitacao) then
  begin
    if OPedidoDAO.funcAtualizarPedido(OPedido) then
    begin
      MensagemInformacao('Pedido alterado com sucesso!');
      Close;
    end;
  end;
end;

end.
