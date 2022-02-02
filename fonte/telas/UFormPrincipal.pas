unit UFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TFormPrincipal = class(TForm)
    mmMenuPrincipal: TMainMenu;
    mniConsultarPedidos: TMenuItem;
    mniNovoPedido: TMenuItem;
    mniSairdoSistema: TMenuItem;
    stbMenuPrincipal: TStatusBar;
    tmDataHoraAtual: TTimer;
    imgFundoMenuPrincipal: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mniSairdoSistemaClick(Sender: TObject);
    procedure tmDataHoraAtualTimer(Sender: TObject);
    procedure mniConsultarPedidosClick(Sender: TObject);
    procedure mniNovoPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses UFormConsultaPedidos, UFormPedidos, uTipos;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFormPrincipal.mniConsultarPedidosClick(Sender: TObject);
begin
  FormConsultaPedidos := TFormConsultaPedidos.Create(Self);
  try
    FormConsultaPedidos.ShowModal;
  finally
    FreeAndNil(FormConsultaPedidos);
  end;
end;

procedure TFormPrincipal.mniNovoPedidoClick(Sender: TObject);
begin
  FormPedidos := TFormPedidos.Create(self);
  try
    FormPedidos.tspStatus := tspAberto;
    FormPedidos.ShowModal;
  finally
    FreeAndNil(FormPedidos);
  end;
end;

procedure TFormPrincipal.mniSairdoSistemaClick(Sender: TObject);
begin
  Close;
end;

procedure TFormPrincipal.tmDataHoraAtualTimer(Sender: TObject);
begin
  stbMenuPrincipal.Panels[0].Text := 'Data e Hora: ' + DateTimeToStr(now);
end;

end.
