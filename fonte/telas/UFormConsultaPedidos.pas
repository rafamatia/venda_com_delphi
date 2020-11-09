unit UFormConsultaPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, uPedidosDAO, uTipos, Vcl.WinXPickers;

type
  TFormConsultaPedidos = class(TForm)
    gbCamposConsulta: TGroupBox;
    GroupBox3: TGroupBox;
    gPedidos: TDBGrid;
    Panel1: TPanel;
    sb_Sair: TSpeedButton;
    sbExcluir: TSpeedButton;
    sbAlterar: TSpeedButton;
    sbNovo: TSpeedButton;
    paOpcoesConsulta: TPanel;
    gbOpcConsulta: TGroupBox;
    rbNumPedido: TRadioButton;
    rbCodCliente: TRadioButton;
    pnlEspaco1: TPanel;
    pnlEspaco2: TPanel;
    pnlEspaco3: TPanel;
    pnlStatusCancelado: TPanel;
    shpStatusCancelado: TShape;
    pnlStatusEmDigitacao: TPanel;
    shpStatusEmDigitacao: TShape;
    pnlStatusAberto: TPanel;
    shpStatusAberto: TShape;
    sbCancelar: TSpeedButton;
    rdgStatus: TRadioGroup;
    rbNomeCliente: TRadioButton;
    rbDataEmissao: TRadioButton;
    pnlConsulta: TPanel;
    edDados: TEdit;
    lbTipoConsulta: TLabel;
    pnlConsultaPeriodo: TPanel;
    dtFinal: TDatePicker;
    Label1: TLabel;
    dtInicial: TDatePicker;
    Label2: TLabel;
    procedure sb_SairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gPedidosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure rbNumPedidoClick(Sender: TObject);
    procedure rbDataEmissaoClick(Sender: TObject);
    procedure rbCodClienteClick(Sender: TObject);
    procedure rbNomeClienteClick(Sender: TObject);
    procedure sbNovoClick(Sender: TObject);
    procedure sbAlterarClick(Sender: TObject);
    procedure sbExcluirClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure dtInicialChange(Sender: TObject);
    procedure dtFinalChange(Sender: TObject);
    procedure edDadosKeyPress(Sender: TObject; var Key: Char);
    procedure edDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    OPedidosDAO: TPedidoDAO;
    dsPedidos: TDataSource;

    procedure procSelect;

  public
    { Public declarations }
  end;

var
  FormConsultaPedidos: TFormConsultaPedidos;

implementation

{$R *.dfm}

uses uRotinasComuns, uConstantes, UFormPedidos, uMensagens, uPedidos;

procedure TFormConsultaPedidos.dtFinalChange(Sender: TObject);
begin
  procSelect;
end;

procedure TFormConsultaPedidos.dtInicialChange(Sender: TObject);
begin
  procSelect;
end;

procedure TFormConsultaPedidos.edDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    procSelect;
end;

procedure TFormConsultaPedidos.edDadosKeyPress(Sender: TObject; var Key: Char);
begin
  if ((rbNumPedido.Checked) or (rbCodCliente.Checked)) then
    procAceitarApenasNumeros(Key);
end;

procedure TFormConsultaPedidos.FormShow(Sender: TObject);
begin
  if (OPedidosDAO = nil) then
    OPedidosDAO := TPedidoDAO.Create;

  if (dsPedidos = nil) then
    dsPedidos := TDataSource.Create(self);

  dsPedidos.DataSet := OPedidosDAO.Qry;

  gPedidos.DataSource := dsPedidos;

  rbNumPedidoClick(Sender);
end;

procedure TFormConsultaPedidos.gPedidosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Column.FieldName <> 'ped_status') then
    Exit;

  if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag
    [tspAberto]) then
  begin
    gPedidos.Canvas.Font.Color := shpStatusAberto.Brush.Color;
    gPedidos.Canvas.Brush.Color := shpStatusAberto.Brush.Color;
  end
  else if (OPedidosDAO.Qry.FieldByName('ped_status')
    .AsString = TStatusPedidoFlag[tspCancelado]) then
  begin
    gPedidos.Canvas.Font.Color := shpStatusCancelado.Brush.Color;
    gPedidos.Canvas.Brush.Color := shpStatusCancelado.Brush.Color;
  end
  else if (OPedidosDAO.Qry.FieldByName('ped_status')
    .AsString = TStatusPedidoFlag[tspEmDigitacao]) then
  begin
    gPedidos.Canvas.Font.Color := shpStatusEmDigitacao.Brush.Color;
    gPedidos.Canvas.Brush.Color := shpStatusEmDigitacao.Brush.Color;
  end;
  gPedidos.DefaultDrawDataCell(Rect, gPedidos.Columns[DataCol].field, State);
end;

procedure TFormConsultaPedidos.procSelect;
var
  strWhere: String;
begin
  if (OPedidosDAO = nil) then
    Abort;

  strWhere := EmptyStr;

  { -------------------------------------------------
    MONTA WHERE DAS OPÇÕES DE CONSULTA
    ------------------------------------------------- }
  case rdgStatus.ItemIndex of
    0:
      strWhere := C_WHERE_SIMPLES + ' a.ped_status = ' +
        QuotedStr(TStatusPedidoFlag[tspAberto]);
    1:
      strWhere := C_WHERE_SIMPLES + ' a.ped_status = ' +
        QuotedStr(TStatusPedidoFlag[tspCancelado]);
    2:
      strWhere := C_WHERE_SIMPLES + ' a.ped_status = ' +
        QuotedStr(TStatusPedidoFlag[tspEmDigitacao]);
  end;

  if edDados.Text <> EmptyStr then
  Begin
    if (rbNumPedido.Checked) then { NUMERO PEDIDO }
    Begin
      if (strWhere = EmptyStr) then
        strWhere := C_WHERE_SIMPLES + ' A.ped_numero = ' + edDados.Text
      else
        strWhere := strWhere + ' and A.ped_numero = ' + edDados.Text;
    End
    else if (rbCodCliente.Checked) then { CÓD. DO CLIENTE }
    begin
      if (strWhere = EmptyStr) then
        strWhere := C_WHERE_SIMPLES + ' A.ped_fkcliente = ' + edDados.Text
      else
        strWhere := strWhere + ' and A.ped_fkcliente = ' + edDados.Text;
    end
    else if (rbNomeCliente.Checked) then { NOME DO CLIENTE }
    begin
      if (strWhere = EmptyStr) then
        strWhere := C_WHERE_SIMPLES + ' upper(b.CLI_NOME) LIKE ' +
          QuotedStr('%' + edDados.Text + '%')
      else
        strWhere := strWhere + ' and upper(b.CLI_NOME) LIKE ' +
          QuotedStr('%' + edDados.Text + '%');
    end
    else
    begin
      if (strWhere = EmptyStr) then
        strWhere := C_WHERE_SIMPLES + '   (a.ped_dataemissao between ' +
          QuotedStr(FormatDateTime('YYYY-MM-DD', dtInicial.Date)) + ' and ' +
          QuotedStr(FormatDateTime('YYYY-MM-DD', dtFinal.Date)) + ')'
      else
        strWhere := strWhere + ' and ' + '   (a.ped_dataemissao between ' +
          QuotedStr(FormatDateTime('YYYY-MM-DD', dtInicial.Date)) + ' and ' +
          QuotedStr(FormatDateTime('YYYY-MM-DD', dtFinal.Date)) + ')';

    end;
  End;

  OPedidosDAO.procCarragarPedidos(strWhere);
  procSetarFoco(edDados, False);

  if (OPedidosDAO.Qry.FieldByName('ped_vlrtotal') is TBCDField) then
    (OPedidosDAO.Qry.FieldByName('ped_vlrtotal') as TBCDField).DisplayFormat :=
      C_MASCARA_VALOR;
end;

procedure TFormConsultaPedidos.rbNomeClienteClick(Sender: TObject);
begin
  pnlConsultaPeriodo.SendToBack;
  pnlConsulta.BringToFront;
  pnlConsultaPeriodo.Visible := False;
  pnlConsulta.Visible := True;
  lbTipoConsulta.Caption := rbNomeCliente.Caption;
  edDados.Clear;
  edDados.SetFocus;
  procSelect;
end;

procedure TFormConsultaPedidos.rbDataEmissaoClick(Sender: TObject);
begin
  pnlConsulta.SendToBack;
  pnlConsultaPeriodo.BringToFront;
  pnlConsulta.Visible := False;
  pnlConsultaPeriodo.Visible := True;
  dtInicial.Date := Date;
  dtFinal.Date := Date;
  procSelect;
end;

procedure TFormConsultaPedidos.rbNumPedidoClick(Sender: TObject);
begin
  pnlConsultaPeriodo.SendToBack;
  pnlConsulta.BringToFront;
  pnlConsultaPeriodo.Visible := False;
  pnlConsulta.Visible := True;
  lbTipoConsulta.Caption := rbNumPedido.Caption;
  edDados.Clear;
  edDados.SetFocus;
  procSelect;
end;

procedure TFormConsultaPedidos.rbCodClienteClick(Sender: TObject);
begin
  pnlConsultaPeriodo.SendToBack;
  pnlConsulta.BringToFront;
  pnlConsultaPeriodo.Visible := False;
  pnlConsulta.Visible := True;
  lbTipoConsulta.Caption := rbCodCliente.Caption;
  edDados.Clear;
  edDados.SetFocus;
  procSelect;
end;

procedure TFormConsultaPedidos.sbAlterarClick(Sender: TObject);
begin
  if (OPedidosDAO = nil) then
    Abort;

  if OPedidosDAO.Qry.IsEmpty then
  begin
    MensagemAviso('Atenção, nenhum pedido foi selecionado!' + sLineBreak +
      'Selecione um pedido para alteração e tente novamente!');
    Abort;
  end;

  if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag
    [tspCancelado]) then
    MensagemAviso('Atenção, pedidos cancelados não podem ser alterados!' +
      sLineBreak + 'O pedido será aberto apenas para visualização!')
  else if (OPedidosDAO.Qry.FieldByName('ped_status')
    .AsString = TStatusPedidoFlag[tspEmDigitacao]) then
  begin
    MensagemAviso('Atenção, o pedido já está sendo alterado!' + sLineBreak +
      'Selecione outro pedido e tente novamente!');
    Abort;
  end;

  FormPedidos := TFormPedidos.Create(self);
  try
    FormPedidos.tspStatus := tspEmDigitacao;
    FormPedidos.intNrPedido := OPedidosDAO.Qry.FieldByName('ped_numero')
      .AsInteger;
    FormPedidos.ShowModal;
  finally
    FreeAndNil(FormPedidos);
  end;
end;

procedure TFormConsultaPedidos.sbExcluirClick(Sender: TObject);
var
  OPedidosDAOAux: TPedidoDAO;
begin
  if (OPedidosDAO = nil) then
    Abort;

  if OPedidosDAO.Qry.IsEmpty then
  begin
    MensagemAviso('Atenção, nenhum pedido foi selecionado!' + sLineBreak +
      'Selecione um pedido e tente novamente!');
    Abort;
  end;

  if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag
    [tspCancelado]) then
  begin
    MensagemAviso('Atenção, pedidos cancelados não podem ser excluídos!' +
      sLineBreak +
      'Selecione um pedido com status "Aberto" e tente novamente!');
    Abort;
  end
  else if (OPedidosDAO.Qry.FieldByName('ped_status')
    .AsString = TStatusPedidoFlag[tspEmDigitacao]) then
  begin
    MensagemAviso('Atenção, pedidos em alteração não podem ser excluídos!' +
      sLineBreak +
      'Selecione um pedido com status "Aberto" e tente novamente!');
    Abort;
  end;

  OPedidosDAOAux := TPedidoDAO.Create;
  try
    OPedidosDAOAux.procExcluirPedido(OPedidosDAO.Qry.FieldByName('ped_numero')
      .AsInteger);
    OPedidosDAO.procCarragarPedidos();
  finally
    FreeAndNil(OPedidosDAOAux);
  end;
end;

procedure TFormConsultaPedidos.sbNovoClick(Sender: TObject);
begin
  FormPedidos := TFormPedidos.Create(self);
  try
    FormPedidos.tspStatus := tspAberto;
    FormPedidos.ShowModal;
  finally
    FreeAndNil(FormPedidos);
  end;
end;

procedure TFormConsultaPedidos.sb_SairClick(Sender: TObject);
begin
  if (OPedidosDAO <> nil) then
    FreeAndNil(OPedidosDAO);
  Close;
end;

procedure TFormConsultaPedidos.sbCancelarClick(Sender: TObject);
var
  OPedidosDAOAux: TPedidoDAO;
  OPedido: TPedido;
begin
  if (OPedidosDAO = nil) then
    Abort;

  if OPedidosDAO.Qry.IsEmpty then
  begin
    MensagemAviso('Atenção, nenhum pedido foi selecionado!' + sLineBreak +
      'Selecione um pedido e tente novamente!');
    Abort;
  end;

  if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag
    [tspCancelado]) then
  begin
    MensagemAviso('Atenção, pedidos já cancelados!' + sLineBreak +
      'Selecione um pedido com o status "Aberto" e tente novamente!');
    Abort;
  end
  else if (OPedidosDAO.Qry.FieldByName('ped_status')
    .AsString = TStatusPedidoFlag[tspEmDigitacao]) then
  begin
    MensagemAviso('Atenção, o pedido está sendo alterado!' + sLineBreak +
      'Selecione um pedido com o status "Aberto" e tente novamente!');
    Abort;
  end;

  OPedidosDAOAux := TPedidoDAO.Create;
  OPedido := TPedido.Create;
  try
    OPedido.PedNumero := OPedidosDAO.Qry.FieldByName('ped_numero').AsInteger;
    OPedido.PedStatus := TStatusPedidoFlag[tspCancelado];
    OPedidosDAOAux.procAtualizarStatusPedido(OPedido);
    OPedidosDAO.procCarragarPedidos();
  finally
    FreeAndNil(OPedidosDAOAux);
    FreeAndNil(OPedido);
  end;
end;

end.
