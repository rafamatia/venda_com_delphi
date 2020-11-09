unit UManutencaoPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TcManuPadrao = class(TForm)
    gbCampos: TGroupBox;
    Panel1: TPanel;
    sbCancelar: TSpeedButton;
    sbGravar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    B_GRAVOU: Boolean;
  end;

var
  cManuPadrao: TcManuPadrao;

implementation

{$R *.dfm}

procedure TcManuPadrao.FormCreate(Sender: TObject);
begin
  B_GRAVOU := False;
end;

procedure TcManuPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F5:
      sbGravarClick(Sender);
    VK_F7:
      sbCancelarClick(Sender);
  end;
end;

procedure TcManuPadrao.sbCancelarClick(Sender: TObject);
begin
  B_GRAVOU := False;
  Close;
end;

procedure TcManuPadrao.sbGravarClick(Sender: TObject);
begin
  //
end;

end.
