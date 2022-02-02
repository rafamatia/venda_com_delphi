unit uPedidosDAO;

interface

uses Data.DB, uDAOConexao, System.SysUtils, FireDAC.Stan.Param, System.Classes,
  uPedidos, uTipos, System.StrUtils;

type
  TPedidoDAO = class(TDAOConexao)
  private
    function funcRetornaWhereStatusPedidos(AStatusPedido: TStatusPedido): String;
    function funcRetornaWherePedido(ATipoConsultaPedido: TTipoConsultaPedido;
      AValorConsulta: String; ADataInicial: TDateTime; ADataFinal: TDateTime): String;
    function funcRetornaWhere: String;
  public
    procedure procCarragarPedidos(AStatusPedido: TStatusPedido; ATipoConsultaPedido: TTipoConsultaPedido;
      AValorConsulta: String; ADataInicial: TDateTime; ADataFinal: TDateTime);
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
    begin
      raise Exception.Create('Erro ao atualizar o status do pedido!' +
        sLineBreak + sLineBreak + 'Informações Técnicas:' + sLineBreak +
        E.Message);
    end;
  end;
end;

function TPedidoDAO.funcRetornaWhere: String;
begin

end;

function TPedidoDAO.funcRetornaWhereStatusPedidos(AStatusPedido: TStatusPedido): String;
begin
  Result := EmptyStr;

  if (AStatusPedido = tspTodos) then
    Exit;

  Result := C_WHERE_SIMPLES + ' a.ped_status = ' +QuotedStr(TStatusPedidoFlag[AStatusPedido]);
end;

function TPedidoDAO.funcRetornaWherePedido(ATipoConsultaPedido: TTipoConsultaPedido; AValorConsulta: String; ADataInicial,
  ADataFinal: TDateTime): String;
begin
  Result := EmptyStr;

  if ((ATipoConsultaPedido = tcpDataEmissao) and (ADataInicial < 0) and (ADataFinal < 0)) then
    Exit;

  if ((ATipoConsultaPedido <> tcpDataEmissao) and (AValorConsulta = EmptyStr)) then
    Exit;

  case ATipoConsultaPedido of
    tcpNrPedido:
    begin
      Result := ' A.ped_numero = ' + AValorConsulta;
    end;

    tcpDataEmissao:
    begin
      Result := ' (a.ped_dataemissao between ' +
        QuotedStr(FormatDateTime('YYYY-MM-DD', ADataInicial)) + ' and ' +
        QuotedStr(FormatDateTime('YYYY-MM-DD', ADataFinal)) + ')';
    end;

    tcpCodCliente:
    begin
      Result :=' A.ped_fkcliente = ' + AValorConsulta;
    end;

    tcpNomeCliente:
    begin
      Result := ' upper(b.CLI_NOME) LIKE ' + QuotedStr('%' + AValorConsulta + '%');
    end;
  end;
end;

procedure TPedidoDAO.procCarragarPedidos(AStatusPedido: TStatusPedido; ATipoConsultaPedido: TTipoConsultaPedido;
  AValorConsulta: String; ADataInicial: TDateTime; ADataFinal: TDateTime);
var
  strWhereStatus: String;
  strWherePedido: String;
  strWhere: String;
begin
  strWhereStatus := funcRetornaWhereStatusPedidos(AStatusPedido);
  strWherePedido := funcRetornaWherePedido(ATipoConsultaPedido, AValorConsulta, ADataInicial, ADataFinal);

  if (strWhereStatus <> EmptyStr) then
  begin
    strWhere := C_WHERE_SIMPLES + strWhereStatus;
  end;

  if (strWherePedido <> EmptyStr) then
  begin
    strWhere := IfThen((strWhere <> EmptyStr), (' and ' + strWherePedido), (C_WHERE_SIMPLES + strWherePedido));
  end;

  Qry.Close;
  Qry.SQL.Clear;
  try
    Qry.SQL.Text := C_SQL_PEDIDOS + strWhere;
    Qry.Open;

  if (Qry.FieldByName('ped_vlrtotal') is TBCDField) then
    (Qry.FieldByName('ped_vlrtotal') as TBCDField).DisplayFormat := C_MASCARA_VALOR;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao carregar os pedidos!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
    end;
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
    begin
      Exit;
    end;

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
    begin
      Exit;
    end;

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
    begin
      raise Exception.Create('Erro ao carregar o pedido!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
    end;
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
    begin
      raise Exception.Create('Erro ao excluir o pedido!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
    end;
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
      begin
        Qry.SQL.Text :=
          'insert into itens_pedido (itp_fkpedido,itp_fkproduto,itp_quantidade,itp_vlrunitario,itp_vlrtotal) '
          + ' values(:itp_fkpedido, :itp_fkproduto, :itp_quantidade, :itp_vlrunitario, :itp_vlrtotal)'
      end
      else
      begin
        Qry.SQL.Text := ' update itens_pedido set ' +
          ' itp_fkproduto = :itp_fkproduto, ' +
          ' itp_quantidade = :itp_quantidade, ' +
          ' itp_vlrunitario = :itp_vlrunitario, ' +
          ' itp_vlrtotal = :itp_vlrtotal ' +
          ' where itp_fkpedido = :itp_fkpedido ';
      end;

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
    begin
      raise Exception.Create('Erro ao carregar os pedidos!' + sLineBreak +
        sLineBreak + 'Informações Técnicas:' + sLineBreak + E.Message);
    end;
  end;
end;

end.
