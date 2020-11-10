inherited FormConsultaClientes: TFormConsultaClientes
  Caption = '0003 - Consulta de Clientes'
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox3: TGroupBox
    Caption = 'Listagem de Clientes'
    inherited gPadrao: TDBGrid
      DataSource = dmPessoas.dsClientes
      OnDblClick = gPadraoDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'cli_codigo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cli_nome'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cli_cidade'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cli_uf'
          Width = 64
          Visible = True
        end>
    end
  end
  inherited gbCamposConsulta: TGroupBox
    inherited edDados: TEdit
      Top = 39
      OnChange = edDadosChange
      OnKeyDown = edDadosKeyDown
      OnKeyPress = edDadosKeyPress
      ExplicitTop = 39
    end
  end
  inherited Panel1: TPanel
    inherited sb_Sair: TSpeedButton
      ExplicitLeft = 582
      ExplicitTop = 6
    end
  end
  inherited paOpcoesConsulta: TPanel
    inherited gbOpcConsulta: TGroupBox
      ExplicitLeft = 0
      ExplicitTop = 0
      inherited rbDescricao: TRadioButton
        Caption = 'Nome'
      end
    end
    inherited gbStatus: TGroupBox
      Visible = False
      ExplicitLeft = 470
      ExplicitTop = 0
    end
  end
end
