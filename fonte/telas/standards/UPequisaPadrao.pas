unit UPequisaPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TpPesqPadrao = class(TForm)
    GroupBox3: TGroupBox;
    gPadrao: TDBGrid;
    gbCamposConsulta: TGroupBox;
    lbTipoConsulta: TLabel;
    edDados: TEdit;
    Panel1: TPanel;
    sb_Sair: TSpeedButton;
    sbExcluir: TSpeedButton;
    sbAlterar: TSpeedButton;
    sbNovo: TSpeedButton;
    paOpcoesConsulta: TPanel;
    gbOpcConsulta: TGroupBox;
    rbCodigo: TRadioButton;
    rbDescricao: TRadioButton;
    gbStatus: TGroupBox;
    rbAtivo: TRadioButton;
    rbInativo: TRadioButton;
    rbAmbos: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure sb_SairClick(Sender: TObject);
    procedure rbCodigoClick(Sender: TObject);
    procedure rbDescricaoClick(Sender: TObject);
    procedure sbExcluirClick(Sender: TObject);
    procedure sbAlterarClick(Sender: TObject);
    procedure sbNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    b_Excluiu: Boolean;
  public
    { Public declarations }
  end;

var
  pPesqPadrao: TpPesqPadrao;

implementation

{$R *.dfm}

procedure TpPesqPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Close;
end;

procedure TpPesqPadrao.FormCreate(Sender: TObject);
begin
  b_Excluiu := False;
end;

procedure TpPesqPadrao.rbCodigoClick(Sender: TObject);
begin
  lbTipoConsulta.Caption := rbCodigo.Caption;
  edDados.Clear;
  edDados.SetFocus;
end;

procedure TpPesqPadrao.rbDescricaoClick(Sender: TObject);
begin
  lbTipoConsulta.Caption := rbDescricao.Caption;
  edDados.Clear;
  edDados.SetFocus;
end;

procedure TpPesqPadrao.sbAlterarClick(Sender: TObject);
begin
  // rotina de alteração
end;

procedure TpPesqPadrao.sbExcluirClick(Sender: TObject);
begin
  // rotina de exclusão
end;

procedure TpPesqPadrao.sbNovoClick(Sender: TObject);
begin
  // rotina de inserção
end;

procedure TpPesqPadrao.sb_SairClick(Sender: TObject);
begin
  Close;
end;

end.
