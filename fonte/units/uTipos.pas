unit uTipos;

interface

uses SysUtils, Variants;

type
  TStatusPedido = (tspAberto, tspCancelado, tspEmDigitacao, tspTodos);
  TTipoConsultaPedido = (tcpNrPedido, tcpDataEmissao, tcpCodCliente, tcpNomeCliente);

const

  // TStatusPedido
  TStatusPedidoDesc: Array [TStatusPedido] of String = ('ABERTO', 'CANCELADO', 'EM DIGITAÇÃO', 'TODOS');
  TStatusPedidoFlag: Array [TStatusPedido] of String = ('A', 'C', 'D', 'TODOS');


implementation

end.
