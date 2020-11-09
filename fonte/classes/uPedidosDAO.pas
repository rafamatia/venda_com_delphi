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
  end;

implementation

{ TPedidosDAO }

uses uConstantes, uMensagens;

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

    MensagemAviso('Status do Pedido Atualizado com sucesso!');
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

    MensagemAviso('Pedido excluído com sucesso!');
  except
    on E: Exception do
      raise Exception.Create('Erro ao excluir o pedido!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
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
