unit uPedidosDAO;

interface

uses uDAOConexao, System.SysUtils, FireDAC.Stan.Param, System.Classes,
  uPedidos;

type
  TPedidoDAO = class(TDAOConexao)
  private
  public
    procedure procCarragarPedidos(AWhere: string = '');
    procedure recuperaProximoIDDoPedido(APedido: TPedido);
    procedure procCarregarDadosDoPedido(APedido: TPedido);
    procedure procExcluirPedido(ANrPedido: Integer);
    procedure procAtualizarStatusPedido(APedido: TPedido);
    function funcGravarPedido(APedido: TPedido): Boolean;
    function funcAtualizarPedido(APedido: TPedido): Boolean;
  end;

implementation

{ TPedidosDAO }

uses uConstantes, uMensagens, uItemPedido;

procedure TPedidoDAO.procAtualizarStatusPedido(APedido: TPedido);
begin
  Qry.Close;
  Qry.SQL.Clear;
  try
    Qry.SQL.Text :=
      ' update pedidos set ped_status = :ped_status where ped_numero = :ped_numero ';
    Qry.ParamByName('ped_numero').AsInteger := APedido.PedNumero;
    Qry.ParamByName('ped_status').AsString := APedido.PedStatus;
    Qry.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao atualizar o status do pedido!' +
        sLineBreak + sLineBreak + 'Informações Técnicas:' + sLineBreak +
        E.Message);
  end;
end;

procedure TPedidoDAO.procCarragarPedidos(AWhere: string);
begin
  Qry.Close;
  Qry.SQL.Clear;
  try
    Qry.SQL.Text := C_SQL_PEDIDOS + AWhere;
    Qry.Open;
  except
    on E: Exception do
      raise Exception.Create('Erro ao carregar os pedidos!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
  end;
end;

procedure TPedidoDAO.procCarregarDadosDoPedido(APedido: TPedido);
begin
  Qry.Close;
  Qry.SQL.Clear;
  try
    Qry.SQL.Text := C_SQL_PEDIDOS + C_WHERE_SIMPLES +
      'a.ped_numero = :nrpedido';
    Qry.ParamByName('nrpedido').AsInteger := APedido.PedNumero;
    Qry.Open;

    if Qry.IsEmpty then
      Exit;

    APedido.PedNumero := Qry.FieldByName('ped_numero').AsInteger;
    APedido.PedDataEmissao := Qry.FieldByName('ped_dataemissao').AsDateTime;
    APedido.PedFKCliente := Qry.FieldByName('ped_fkcliente').AsInteger;
    APedido.NomeCliente := Qry.FieldByName('cli_nome').AsString;
    APedido.PedVlrTotal := Qry.FieldByName('ped_vlrtotal').AsFloat;
    APedido.PedStatus := Qry.FieldByName('ped_status').AsString;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Text := C_SQL_ITENSPEDIDO + C_WHERE_SIMPLES +
      'a.itp_fkpedido = :nrpedido';
    Qry.ParamByName('nrpedido').AsInteger := APedido.PedNumero;
    Qry.Open;

    if Qry.IsEmpty then
      Exit;

    Qry.First;
    while (not(Qry.Eof)) do
    begin
      APedido.AdicionarItemAoPedido(Qry.FieldByName('itp_id').AsInteger,
        Qry.FieldByName('itp_fkpedido').AsInteger,
        Qry.FieldByName('itp_fkproduto').AsInteger,
        Qry.FieldByName('pro_descricao').AsString,
        Qry.FieldByName('itp_quantidade').AsFloat,
        Qry.FieldByName('itp_vlrunitario').AsFloat,
        Qry.FieldByName('itp_vlrtotal').AsFloat);
      Qry.Next;
    end;

  except
    on E: Exception do
      raise Exception.Create('Erro ao carregar o pedido!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
  end;
end;

procedure TPedidoDAO.procExcluirPedido(ANrPedido: Integer);
begin
  Qry.Close;
  Qry.SQL.Clear;
  try
    Qry.SQL.Text := ' delete from pedidos where ped_numero = :nrpedido ';
    Qry.ParamByName('nrpedido').AsInteger := ANrPedido;
    Qry.ExecSQL;

    MensagemInformacao('Pedido excluído com sucesso!');
  except
    on E: Exception do
      raise Exception.Create('Erro ao excluir o pedido!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
  end;
end;

function TPedidoDAO.funcAtualizarPedido(APedido: TPedido): Boolean;
var
  ItemPedido: TItemPedido;
begin
  Result := True;
  Qry.Close;
  Qry.SQL.Clear;
  try
    Qry.SQL.Text := ' update pedidos set ' + ' ped_fkcliente = :ped_fkcliente, '
      + ' ped_vlrtotal = :ped_vlrtotal,' + ' ped_status = ''A'' ' +
      ' where ped_numero = :ped_numero ';
    Qry.ParamByName('ped_numero').AsInteger := APedido.PedNumero;
    Qry.ParamByName('ped_fkcliente').AsInteger := APedido.PedFKCliente;
    Qry.ParamByName('ped_vlrtotal').AsFloat := APedido.PedVlrTotal;
    Qry.ExecSQL;

    for ItemPedido in APedido.ListaItensPedido do
    begin
      Qry.Close;
      Qry.SQL.Clear;

      if ItemPedido.ItpID = 0 then
        Qry.SQL.Text :=
          'insert into itens_pedido (itp_fkpedido,itp_fkproduto,itp_quantidade,itp_vlrunitario,itp_vlrtotal) '
          + ' values(:itp_fkpedido, :itp_fkproduto, :itp_quantidade, :itp_vlrunitario, :itp_vlrtotal)'
      else
        Qry.SQL.Text := ' update itens_pedido set ' +
          ' itp_fkproduto = :itp_fkproduto, ' +
          ' itp_quantidade = :itp_quantidade, ' +
          ' itp_vlrunitario = :itp_vlrunitario, ' +
          ' itp_vlrtotal = :itp_vlrtotal ' +
          ' where itp_fkpedido = :itp_fkpedido ';

      Qry.ParamByName('itp_fkpedido').AsInteger := APedido.PedNumero;
      Qry.ParamByName('itp_fkproduto').AsInteger := ItemPedido.ItpFKProduto;
      Qry.ParamByName('itp_quantidade').AsFloat := ItemPedido.ItpQuantidade;
      Qry.ParamByName('itp_vlrunitario').AsFloat := ItemPedido.ItpVlrUnitario;
      Qry.ParamByName('itp_vlrtotal').AsFloat := ItemPedido.ItpVlrTotal;
      Qry.ExecSQL;
    end;

  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create('Erro ao alterar o pedido!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
    end;
  end;
end;

function TPedidoDAO.funcGravarPedido(APedido: TPedido): Boolean;
var
  ItemPedido: TItemPedido;
begin
  Result := True;
  Qry.Close;
  Qry.SQL.Clear;
  try
    Qry.SQL.Text := ' INSERT INTO pedidos(ped_fkcliente,ped_vlrtotal) ' +
      'VALUES (:ped_fkcliente,:ped_vlrtotal);';
    Qry.ParamByName('ped_fkcliente').AsInteger := APedido.PedFKCliente;
    Qry.ParamByName('ped_vlrtotal').AsFloat := APedido.PedVlrTotal;
    Qry.ExecSQL;

    Qry.Close;
    Qry.SQL.Clear;
    for ItemPedido in APedido.ListaItensPedido do
    begin
      Qry.SQL.Text :=
        'insert into itens_pedido (itp_fkpedido,itp_fkproduto,itp_quantidade,itp_vlrunitario,itp_vlrtotal) '
        + ' values(:itp_fkpedido, :itp_fkproduto, :itp_quantidade, :itp_vlrunitario, :itp_vlrtotal)';
      Qry.ParamByName('itp_fkpedido').AsInteger := APedido.PedNumero;
      Qry.ParamByName('itp_fkproduto').AsInteger := ItemPedido.ItpFKProduto;
      Qry.ParamByName('itp_quantidade').AsFloat := ItemPedido.ItpQuantidade;
      Qry.ParamByName('itp_vlrunitario').AsFloat := ItemPedido.ItpVlrUnitario;
      Qry.ParamByName('itp_vlrtotal').AsFloat := ItemPedido.ItpVlrTotal;
      Qry.ExecSQL;
    end;

  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create('Erro ao gravar o pedido!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
    end;
  end;
end;

procedure TPedidoDAO.recuperaProximoIDDoPedido(APedido: TPedido);
begin
  APedido.PedNumero := 0;
  Qry.Close;
  Qry.SQL.Clear;
  try
    Qry.SQL.Text := 'select auto_increment from information_schema.tables ' +
      ' where table_name = ' + QuotedStr('pedidos') + ' and table_schema = ' +
      QuotedStr('dbwktechnoloygy');
    Qry.Open;

    APedido.PedNumero := Qry.FieldByName('auto_increment').AsInteger;
  except
    on E: Exception do
      raise Exception.Create('Erro ao carregar os pedidos!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
  end;
end;

end.
