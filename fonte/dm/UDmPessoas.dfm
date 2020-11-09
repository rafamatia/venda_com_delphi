object dmPessoas: TdmPessoas
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryClientes: TFDQuery
    Connection = dmConexao.fdcConexao
    SQL.Strings = (
      'select * from clientes')
    Left = 40
    Top = 24
    object qryClientescli_codigo: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'cli_codigo'
      Origin = 'cli_codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryClientescli_nome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'cli_nome'
      Origin = 'cli_nome'
      Required = True
      Size = 60
    end
    object qryClientescli_cidade: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Cidades'
      FieldName = 'cli_cidade'
      Origin = 'cli_cidade'
      Size = 40
    end
    object qryClientescli_uf: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'UF'
      FieldName = 'cli_uf'
      Origin = 'cli_uf'
      FixedChar = True
      Size = 2
    end
  end
  object dsClientes: TDataSource
    AutoEdit = False
    DataSet = qryClientes
    Left = 42
    Top = 76
  end
end
