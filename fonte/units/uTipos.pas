unit uTipos;

interface

uses SysUtils, Variants;

type
  TStatusPedido = (tspAberto, tspCancelado, tspEmDigitacao);

const

  // TStatusPedido
  TStatusPedidoDesc: Array [TStatusPedido] of String = ('ABERTO', 'CANCELADO', 'EM DIGITAÇÃO');
  TStatusPedidoFlag: Array [TStatusPedido] of String = ('A', 'C', 'D');


implementation

end.
