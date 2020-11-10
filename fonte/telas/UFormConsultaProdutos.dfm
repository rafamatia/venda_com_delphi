inherited FormConsultaProdutos: TFormConsultaProdutos
  Caption = '0004 - Consulta de Produtos'
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox3: TGroupBox
    Caption = 'Listagem de Produtos'
    inherited gPadrao: TDBGrid
      DataSource = dmProdutos.dsProdutos
      OnDblClick = gPadraoDblClick
    end
  end
  inherited gbCamposConsulta: TGroupBox
    inherited edDados: TEdit
      Top = 38
      OnChange = edDadosChange
      OnKeyDown = edDadosKeyDown
      OnKeyPress = edDadosKeyPress
      ExplicitTop = 38
    end
  end
  inherited Panel1: TPanel
    inherited sbAlterar: TSpeedButton
      ExplicitLeft = 83
    end
  end
  inherited paOpcoesConsulta: TPanel
    inherited gbOpcConsulta: TGroupBox
      ExplicitLeft = 0
      ExplicitTop = 0
    end
    inherited gbStatus: TGroupBox
      Visible = False
      ExplicitLeft = 470
      ExplicitTop = 0
    end
  end
end
