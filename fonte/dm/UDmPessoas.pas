unit UDmPessoas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmPessoas = class(TDataModule)
    qryClientes: TFDQuery;
    dsClientes: TDataSource;
    qryClientescli_codigo: TFDAutoIncField;
    qryClientescli_nome: TStringField;
    qryClientescli_cidade: TStringField;
    qryClientescli_uf: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPessoas: TdmPessoas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UDmConexao;

{$R *.dfm}

end.
