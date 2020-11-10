unit uPedidos;

interface

uses
  System.Generics.Collections, System.SysUtils, uItemPedido;

Type

  TPedido = class
  private
    FPedNumero: Integer;
    FPedDataEmissao: TDateTime;
    FPedFKCliente: Integer;
    FNomeCliente: String;
    FPedVlrTotal: Double;
    FPedStatus: String;
    FListaItensPedido: TObjectList<TItemPedido>;
  public
    { public declarations }
    property PedNumero: Integer read FPedNumero write FPedNumero;
    property PedDataEmissao: TDateTime read FPedDataEmissao
      write FPedDataEmissao;
    property PedFKCliente: Integer read FPedFKCliente write FPedFKCliente;
    property NomeCliente: String read FNomeCliente write FNomeCliente;
    property PedVlrTotal: Double read FPedVlrTotal write FPedVlrTotal;
    property PedStatus: String read FPedStatus write FPedStatus;
    property ListaItensPedido: TObjectList<TItemPedido> read FListaItensPedido
      write FListaItensPedido;

    constructor Create;
    destructor Destroy; override;

    procedure AdicionarItemAoPedido(AID, APedido, AProduto: Integer;
      ADescProduto: String; AQtd, AVlrUnitario, AVlrTotal: Double);

    procedure procCalcularTotalPedido;
  published
    { published declarations }
  end;

implementation

{ TPedido }

uses uTipos;

procedure TPedido.AdicionarItemAoPedido(AID, APedido, AProduto: Integer;
  ADescProduto: String; AQtd, AVlrUnitario, AVlrTotal: Double);
begin
  FListaItensPedido.Add(TItemPedido.Create(AID, APedido, AProduto, ADescProduto,
    AQtd, AVlrUnitario, AVlrTotal));
  procCalcularTotalPedido;
end;

constructor TPedido.Create;
begin
  inherited;
  FPedNumero := 0;
  FPedDataEmissao := Now;
  FPedFKCliente := 0;
  FNomeCliente := 'NENHUM';
  FPedVlrTotal := 0;
  FPedStatus := TStatusPedidoFlag[tspAberto];
  FListaItensPedido := TObjectList<TItemPedido>.Create;
end;

destructor TPedido.Destroy;
begin

  inherited;
end;

procedure TPedido.procCalcularTotalPedido;
var
  ItemPedido: TItemPedido;
begin
  Self.FPedVlrTotal := 0;
  for ItemPedido in Self.FListaItensPedido do
    Self.FPedVlrTotal := Self.FPedVlrTotal + ItemPedido.ItpVlrTotal;
end;

end.
