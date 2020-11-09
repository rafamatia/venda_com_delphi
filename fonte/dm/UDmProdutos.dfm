object dmProdutos: TdmProdutos
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryProdutos: TFDQuery
    Connection = dmConexao.fdcConexao
    SQL.Strings = (
      'select * from produtos')
    Left = 56
    Top = 24
    object qryProdutospro_codigo: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'pro_codigo'
      Origin = 'pro_codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryProdutospro_descricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'pro_descricao'
      Origin = 'pro_descricao'
      Required = True
      Size = 60
    end
    object qryProdutospro_preco_venda: TBCDField
      DisplayLabel = 'Pre'#231'o de Venda'
      FieldName = 'pro_preco_venda'
      Origin = 'pro_preco_venda'
      Required = True
      Precision = 12
      Size = 2
    end
  end
  object dsProdutos: TDataSource
    AutoEdit = False
    DataSet = qryProdutos
    Left = 56
    Top = 80
  end
end
