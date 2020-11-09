unit UDmProdutos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmProdutos = class(TDataModule)
    qryProdutos: TFDQuery;
    dsProdutos: TDataSource;
    qryProdutospro_codigo: TFDAutoIncField;
    qryProdutospro_descricao: TStringField;
    qryProdutospro_preco_venda: TBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmProdutos: TdmProdutos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UDmConexao;

{$R *.dfm}

end.
