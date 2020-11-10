unit uItemPedido;

interface

Type

  TItemPedido = class
  private
    FItpID: Integer;
    FItpFKPedido: Integer;
    FItpFKProduto: Integer;
    FDescProduto: String;
    FItpQuantidade: Double;
    FItpVlrUnitario: Double;
    FItpVlrTotal: Double;
  public
    { public declarations }
    property ItpID: Integer read FItpID write FItpID;
    property ItpFKPedido: Integer read FItpFKPedido write FItpFKPedido;
    property ItpFKProduto: Integer read FItpFKProduto write FItpFKProduto;
    property DescProduto: string read FDescProduto write FDescProduto;
    property ItpQuantidade: Double read FItpQuantidade write FItpQuantidade;
    property ItpVlrUnitario: Double read FItpVlrUnitario write FItpVlrUnitario;
    property ItpVlrTotal: Double read FItpVlrTotal write FItpVlrTotal;

    constructor create(AID, APedido, AProduto: Integer; ADescProduto: String;
      AQtd, AVlrUnitario, AVlrTotal: Double);
  end;

implementation

{ TItemPedido }

constructor TItemPedido.create(AID, APedido, AProduto: Integer;
  ADescProduto: String; AQtd, AVlrUnitario, AVlrTotal: Double);
begin
  Self.FItpID := AID;
  Self.FItpFKPedido := APedido;
  Self.FItpFKProduto := AProduto;
  Self.FDescProduto := ADescProduto;
  Self.FItpQuantidade := AQtd;
  Self.FItpVlrUnitario := AVlrUnitario;
  Self.FItpVlrTotal := AVlrTotal;
end;

end.
