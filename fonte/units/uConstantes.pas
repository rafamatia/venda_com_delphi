unit uConstantes;

interface

uses
  Windows, SysUtils, ComCtrls, Menus, Classes,
  Forms, Registry, Data.DB, Vcl.Buttons, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Graphics;

const
  COR_READONLY: TColor = cl3DLight;
  COR_WHITE: TColor = clWhite;
  COR_REQUIRIDO: TColor = clSkyBlue;
  C_MASCARA_VALOR: String = '###,###,##0.00';

  C_WHERE_SIMPLES = ' WHERE ';

  { ===================
    INICIO CLIENTES
    =================== }
  C_SQL_CLIENTES = ' select a.* from clientes a ';
  { ===================
    FIM CLIENTES
    =================== }

  { ===================
    INICIO PRODUTOS
    =================== }
  C_SQL_PRODUTOS = ' select a.* from produtos a ';
  { ===================
    FIM PRODUTOS
    =================== }

  { ===================
    INICIO PEDIDOS
    =================== }
  C_SQL_PEDIDOS = ' select a.*, b.cli_nome from pedidos a ' +
    ' inner join clientes b on b.cli_codigo = a.ped_fkcliente ';
  { ===================
    FIM PEDIDOS
    =================== }

implementation

end.
