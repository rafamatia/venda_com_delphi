unit uPedidos;

interface

uses
  System.Generics.Collections, System.SysUtils;

Type

  TPedido = class
  private
    FPedNumero: Integer;
    FPedDataEmissao: TDateTime;
    FPedFKCliente: Integer;
    FNomeCliente: String;
    FPedVlrTotal: Double;
    FPedStatus: String;
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property PedNumero: Integer read FPedNumero write FPedNumero;
    property PedDataEmissao: TDateTime read FPedDataEmissao
      write FPedDataEmissao;
    property PedFKCliente: Integer read FPedFKCliente write FPedFKCliente;
    property NomeCliente: String read FNomeCliente write FNomeCliente;
    property PedVlrTotal: Double read FPedVlrTotal write FPedVlrTotal;
    property PedStatus: String read FPedStatus write FPedStatus;

    constructor Create;
    destructor Destroy; override;

  published
    { published declarations }
  end;

implementation

{ TPedido }

uses uTipos;

constructor TPedido.Create;
begin
  inherited;
  FPedNumero := 0;
  FPedDataEmissao := Now;
  FPedFKCliente := 0;
  FNomeCliente := 'NENHUM';
  FPedVlrTotal := 0;
  FPedStatus := TStatusPedidoFlag[tspAberto];
end;

destructor TPedido.Destroy;
begin

  inherited;
end;

end.
