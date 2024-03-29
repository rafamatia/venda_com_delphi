unit UFormConsultaPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.UITypes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, uPedidosDAO, uTipos, Vcl.WinXPickers;

type
  TFormConsultaPedidos = class(TForm)
    gbCamposConsulta: TGroupBox;
    GroupBox3: TGroupBox;
    gPedidos: TDBGrid;
    pnlBotoes: TPanel;
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
    procedure gPedidosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
    procedure edDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdgStatusClick(Sender: TObject);
  private
    { Private declarations }
    OPedidosDAO: TPedidoDAO;
    dsPedidos: TDataSource;

    function funcRetornaTipoConsultaPedido: TTipoConsultaPedido;
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

procedure TFormConsultaPedidos.edDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFormConsultaPedidos.gPedidosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Column.FieldName <> 'ped_status') then
    Exit;

  if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag[tspAberto]) then
  begin
    gPedidos.Canvas.Font.Color := shpStatusAberto.Brush.Color;
    gPedidos.Canvas.Brush.Color := shpStatusAberto.Brush.Color;
  end
  else if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag[tspCancelado]) then
  begin
    gPedidos.Canvas.Font.Color := shpStatusCancelado.Brush.Color;
    gPedidos.Canvas.Brush.Color := shpStatusCancelado.Brush.Color;
  end
  else if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag[tspEmDigitacao]) then
  begin
    gPedidos.Canvas.Font.Color := shpStatusEmDigitacao.Brush.Color;
    gPedidos.Canvas.Brush.Color := shpStatusEmDigitacao.Brush.Color;
  end;
  gPedidos.DefaultDrawDataCell(Rect, gPedidos.Columns[DataCol].field, State);
end;

function TFormConsultaPedidos.funcRetornaTipoConsultaPedido: TTipoConsultaPedido;
begin
  if rbNumPedido.Checked then
  begin
    Result := tcpNrPedido;
    Exit;
  end;

  if rbDataEmissao.Checked then
  begin
    Result := tcpDataEmissao;
    Exit;
  end;

  if rbCodCliente.Checked then
  begin
    Result := tcpCodCliente;
    Exit;
  end;

  Result := tcpNomeCliente;
end;

procedure TFormConsultaPedidos.procSelect;
var
  strWhere: String;
begin
  if (OPedidosDAO = nil) then
    Abort;

  strWhere := EmptyStr;

  OPedidosDAO.procCarragarPedidos(TStatusPedido(rdgStatus.ItemIndex), funcRetornaTipoConsultaPedido, edDados.Text, dtInicial.Date, dtFinal.Date);

  procSetarFoco(edDados, False);
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
  pnlBotoes.BringToFront;
  pnlConsultaPeriodo.SendToBack;
  pnlConsulta.BringToFront;
  pnlConsultaPeriodo.Visible := False;
  pnlConsulta.Visible := True;
  lbTipoConsulta.Caption := rbNumPedido.Caption;
  edDados.Clear;
  edDados.SetFocus;

  procSelect;
end;

procedure TFormConsultaPedidos.rdgStatusClick(Sender: TObject);
begin
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
var
  OPedidosDAOAux: TPedidoDAO;
  OPedido: TPedido;
begin
  if (OPedidosDAO = nil) then
    Abort;

  if OPedidosDAO.Qry.IsEmpty then
  begin
    MensagemAviso('Aten��o, nenhum pedido foi selecionado!' + sLineBreak + 'Selecione um pedido para altera��o e tente novamente!');
    Abort;
  end;

  if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag[tspCancelado]) then
    MensagemAviso('Aten��o, pedidos cancelados n�o podem ser alterados!' + sLineBreak + 'O pedido ser� aberto apenas para visualiza��o!')
  else if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag[tspEmDigitacao]) then
  begin
    MensagemAviso('Aten��o, o pedido j� est� sendo alterado!' + sLineBreak + 'Selecione outro pedido e tente novamente!');
    Abort;
  end;

  FormPedidos := TFormPedidos.Create(self);
  try
    FormPedidos.tspStatus := tspEmDigitacao;
    if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag[tspCancelado]) then
    begin
      FormPedidos.sbGravar.Enabled := False;
      FormPedidos.pnlItensPedido.Enabled := False;
      FormPedidos.pnlDadosPedido.Enabled := False;
    end
    else
    begin
      OPedidosDAOAux := TPedidoDAO.Create;
      OPedido := TPedido.Create;
      try
        OPedido.PedNumero := OPedidosDAO.Qry.FieldByName('ped_numero').AsInteger;
        OPedido.PedStatus := TStatusPedidoFlag[tspEmDigitacao];
        OPedidosDAOAux.procAtualizarStatusPedido(OPedido);
      finally
        FreeAndNil(OPedidosDAOAux);
        FreeAndNil(OPedido);
      end;
    end;
    FormPedidos.intNrPedido := OPedidosDAO.Qry.FieldByName('ped_numero').AsInteger;
    FormPedidos.ShowModal;
  finally
    FreeAndNil(FormPedidos);
    procSelect;
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
    MensagemAviso('Aten��o, nenhum pedido foi selecionado!' + sLineBreak + 'Selecione um pedido e tente novamente!');
    Abort;
  end;

  if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag[tspCancelado]) then
  begin
    MensagemAviso('Aten��o, pedidos cancelados n�o podem ser exclu�dos!' + sLineBreak + 'Selecione um pedido com status "Aberto" e tente novamente!');
    Abort;
  end
  else if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag[tspEmDigitacao]) then
  begin
    MensagemAviso('Aten��o, pedidos em altera��o n�o podem ser exclu�dos!' + sLineBreak + 'Selecione um pedido com status "Aberto" e tente novamente!');
    Abort;
  end;

  OPedidosDAOAux := TPedidoDAO.Create;
  try
    OPedidosDAOAux.procExcluirPedido(OPedidosDAO.Qry.FieldByName('ped_numero').AsInteger);
  finally
    FreeAndNil(OPedidosDAOAux);
    procSelect;
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
    procSelect;
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
    MensagemAviso('Aten��o, nenhum pedido foi selecionado!' + sLineBreak + 'Selecione um pedido e tente novamente!');
    Abort;
  end;

  if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag[tspCancelado]) then
  begin
    MensagemAviso('Aten��o, pedidos j� cancelados!' + sLineBreak + 'Selecione um pedido com o status "Aberto" e tente novamente!');
    Abort;
  end
  else if (OPedidosDAO.Qry.FieldByName('ped_status').AsString = TStatusPedidoFlag[tspEmDigitacao]) then
  begin
    MensagemAviso('Aten��o, o pedido est� sendo alterado!' + sLineBreak + 'Selecione um pedido com o status "Aberto" e tente novamente!');
    Abort;
  end;

  OPedidosDAOAux := TPedidoDAO.Create;
  OPedido := TPedido.Create;
  try
    OPedido.PedNumero := OPedidosDAO.Qry.FieldByName('ped_numero').AsInteger;
    OPedido.PedStatus := TStatusPedidoFlag[tspCancelado];
    OPedidosDAOAux.procAtualizarStatusPedido(OPedido);
    MensagemInformacao('Pedido cancelado com sucesso!');
  finally
    FreeAndNil(OPedidosDAOAux);
    FreeAndNil(OPedido);
    procSelect
  end;
end;

end.
