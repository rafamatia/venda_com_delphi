inherited FormPedidos: TFormPedidos
  Caption = '0002 - Pedidos'
  ClientHeight = 585
  ClientWidth = 1107
  ShowHint = True
  OnShow = FormShow
  ExplicitWidth = 1123
  ExplicitHeight = 624
  PixelsPerInch = 96
  TextHeight = 13
  inherited gbCampos: TGroupBox
    Width = 1107
    Height = 546
    ExplicitTop = 0
    ExplicitWidth = 1107
    ExplicitHeight = 546
    object pnlItensPedido: TPanel
      Left = 2
      Top = 113
      Width = 1103
      Height = 88
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 11
        Top = 5
        Width = 38
        Height = 13
        Caption = 'Produto'
      end
      object edtCodProduto: TEdit
        Left = 11
        Top = 20
        Width = 94
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
        OnExit = edtCodProdutoExit
      end
      object btnConsultarProdutos: TBitBtn
        Left = 105
        Top = 20
        Width = 27
        Height = 21
        Hint = 'Abrir Consulta de Produtos'
        Glyph.Data = {
          42060000424D360A000000000000360800002800000010000000100000000100
          1000030000000002000000000000000000000001000000000000007C0000E003
          00001F0000005A6B7300AD7B73004A637B00EFBD8400B58C8C00A5948C00C694
          8C00B59C8C00BD9C8C00F7BD8C00BD949400C6949400CE949400C69C9400CEAD
          9400F7CE9400C6A59C00CEA59C00D6A59C00C6AD9C00CEAD9C00D6AD9C00F7CE
          9C00F7D69C004A7BA500CEADA500D6B5A500DEBDA500F7D6A500DEBDAD00DEC6
          AD00E7C6AD00FFDEAD00FFE7AD00CEB5B500F7DEB500F7E7B500FFE7B500FFEF
          B500D6BDBD00DED6BD00E7DEBD00FFE7BD006B9CC600EFDEC600FFEFC600FFF7
          C600F7E7CE00FFF7CE00F7EFD600F7F7D600FFF7D600FFFFD6002184DE00F7F7
          DE00FFFFDE001884E700188CE700FFFFE700188CEF00218CEF00B5D6EF00F7F7
          EF00FFF7EF00FFFFEF00FFFFF700FF00FF004AB5FF0052B5FF0052BDFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF001F7C893D574A1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C6D622372E951584A1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7CC97ECA7E2476E951584A1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7CCA7ECA7E0372E951584A1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7CCA7EC97E2372E951574A1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7CCA7EC97E046EAB391F7CF539984EDA52994E1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7CEA7E5677544676469E67FF6BFF6BFF6B7C5F
          B9521F7C1F7C1F7C1F7C1F7C1F7C1F7CD95ADA52BF63FF6BFF6BFF6BFF6FFF77
          DE7736461F7C1F7C1F7C1F7C1F7C1F7C58467E5B5E53DF67FF6BFF6FFF77FF7B
          FF7F5B5F1F7C1F7C1F7C1F7C1F7C1F7CFB529F573E4BDF67FF6FFF73FF7BFF7B
          FF77BE6B784A1F7C1F7C1F7C1F7C1F7C1C577F57FD429E5BFF6BFF6FFF73FF73
          FF6FDE6BB84E1F7C1F7C1F7C1F7C1F7CFB569F5BFD423E4BBF63FF6FFF6FFF6F
          FF6FBE6B984E1F7C1F7C1F7C1F7C1F7C784ABF63BF635E533E4F9E5BDF67DF6B
          FF6B7C5F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1B57FF7FDF773E4BFD423E4F9F5B
          DF6377461F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFA5EBE6BBF639F579F5B7E5B
          B94E1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CB94AB94EFB52FB521F7C
          1F7C1F7C1F7C}
        TabOrder = 1
      end
      object edtDescProduto: TEdit
        Left = 136
        Top = 20
        Width = 451
        Height = 21
        TabStop = False
        TabOrder = 2
        Text = 'NENHUM'
        StyleElements = [seFont, seBorder]
      end
      object edtQuantidade: TLabeledEdit
        Left = 7
        Top = 61
        Width = 121
        Height = 21
        EditLabel.Width = 56
        EditLabel.Height = 13
        EditLabel.Caption = 'Quantidade'
        TabOrder = 3
        OnExit = edtQuantidadeExit
        OnKeyPress = edtQuantidadeKeyPress
      end
      object edtVlrUnitario: TLabeledEdit
        Left = 136
        Top = 61
        Width = 121
        Height = 21
        EditLabel.Width = 56
        EditLabel.Height = 13
        EditLabel.Caption = 'Vlr. Unit'#225'rio'
        TabOrder = 4
        OnExit = edtQuantidadeExit
        OnKeyPress = edtQuantidadeKeyPress
      end
      object edtSubTotalItem: TLabeledEdit
        Left = 263
        Top = 61
        Width = 121
        Height = 21
        TabStop = False
        EditLabel.Width = 82
        EditLabel.Height = 13
        EditLabel.Caption = 'SubTotal do Item'
        TabOrder = 5
        StyleElements = [seFont, seBorder]
        OnKeyPress = edtQuantidadeKeyPress
      end
      object btnInc: TBitBtn
        Left = 390
        Top = 56
        Width = 28
        Height = 26
        Hint = 'Incluir Item'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFE9EECCCCDA8BC0D06EC0D06ECCDA8CE9EECCFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBF0D3A3BC2B9DB71DA1BA27A2
          BB2AA2BB2AA1BA279DB71DA3BB2CECF1D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D9E4A998B412A4BD2EA6BE32A6BE32A6BE32A6BE32A6BE32A6BE32A4BD2E98B4
          12DAE4AAFFFFFFFFFFFFFFFFFFEBF1D298B412A5BD31A6BE32A6BE32A6BE32A6
          BE32A6BE32A6BE32A6BE32A6BE32A5BD3198B412ECF1D3FFFFFFFFFFFFA3BC2B
          A4BD2EA6BE32A6BE32A5BD319DB81F9FB924A6BE32A6BE32A6BE32A6BE32A6BE
          32A4BD2EA3BB2CFFFFFFE8EECB9DB71DA6BE32A6BE32A5BD3199B414F6F8EADB
          E4AC9DB71EA6BE32A6BE32A6BE32A6BE32A6BE329DB71DE9EFCCCDDA8BA1BA27
          A6BE32A5BD3098B413DDE6B1FFFFFFFFFFFFADC343A2BB29A6BE32A6BE32A6BE
          32A6BE32A1BA27CDDB8CBFD06DA2BB2BA5BD30A2BB29EAEFCDFFFFFFBACD62F0
          F4DEFFFFFFA3BB2AA2BB2AA6BE32A6BE32A6BE32A2BB2AC0D06EBFD06DA2BB2B
          A3BC2CB8CB5BFFFFFFB9CC5F9DB71E9DB81FFFFFFFFFFFFFA6BE319EB821A5BD
          31A6BE32A2BB2AC0D06ECCDA8BA1BA27A6BE32A3BC2C9CB61BA2BB2AA6BE32A4
          BC2DA0BA27FEFEFCFFFFFFD0DD94A2BB2AA5BD31A1BA27CDDB8CE8EECB9DB71D
          A6BE32A6BE32A6BE32A6BE32A6BE32A6BE32A4BC2E9CB71CDAE4ABFFFFFFBACC
          60A3BC2C9DB71DE9EFCCFFFFFFA3BC2BA4BD2EA6BE32A6BE32A6BE32A6BE32A6
          BE32A6BE32A5BD309FB9239BB61AA3BC2CA4BD2EA3BC2BFFFFFFFFFFFFEBF0D2
          98B413A5BD31A6BE32A6BE32A6BE32A6BE32A6BE32A6BE32A6BE32A6BE32A5BD
          3198B412EBF1D2FFFFFFFFFFFFFFFFFFD9E4A998B413A4BD2EA6BE32A6BE32A6
          BE32A6BE32A6BE32A6BE32A4BD2E98B412D9E4A9FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFEBF0D2A3BB2B9DB71DA1BA27A2BB2BA2BB2BA1BA279DB71DA3BC2BEBF1
          D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8EECBCCDA8BBF
          D06DBFD06DCDDA8BE8EECBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        TabOrder = 6
        OnClick = btnIncClick
      end
      object btnExc: TBitBtn
        Left = 424
        Top = 56
        Width = 28
        Height = 26
        Hint = 'Excluir Item'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD7D3F7A59CED8D82E88D82E9A59CEDD7D3F7FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCD9F85949DF4F3DDC5646DE59
          48DE5948DE5646DE4F3DDC5A49DFDCD9F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          BCB5F24634DB5C4CDF5F4FE05F4FE05F4FE05F4FE05F4FE05F4FE05C4CDF4634
          DBBCB6F2FFFFFFFFFFFFFFFFFFDCD8F84634DB5E4EDF5B4BDF5140DD5D4DDF5F
          4FE05F4FE05D4DDF5140DD5B4BDF5E4EDF4633DBDCD9F8FFFFFFFFFFFF5A49DF
          5C4CDF5B4BDF7668E4E8E6FA5140DD5D4DDF5D4DDF5140DDE8E6FA7567E45B4B
          DF5C4CDF5A49DFFFFFFFD7D3F74F3DDC5F4FE05C4CDF6555E1FFFFFFE7E5FA48
          36DB4835DBE9E6FAFFFFFF6454E15C4CDF5F4FE04F3DDCD7D3F7A49BED5646DE
          5F4FE05F4FE05847DE6F62E3FFFFFFBDB7F2BFB9F2FFFFFF6F61E35847DE5F4F
          E05F4FE05646DEA59CED8D82E95949DE5F4FE05F4FE05F4FE05342DD8376E7FF
          FFFFFFFFFF8376E75342DD5F4FE05F4FE05F4FE05948DE8D82E98D82E95949DE
          5F4FE05F4FE05F4FE05342DD8376E7FFFFFFFFFFFF8377E75342DD5F4FE05F4F
          E05F4FE05948DE8D82E9A49BED5646DE5F4FE05F4FE05847DE7062E3FFFFFFBE
          B7F2BEB7F2FFFFFF6F62E35847DE5F4FE05F4FE05646DEA59CEDD6D2F74F3DDC
          5F4FE05C4CDF6556E1FFFFFFE7E5FA4836DB4836DBE7E5FAFFFFFF6555E15C4C
          DF5F4FE04F3DDCD7D3F7FFFFFF5948DF5C4CDF5B4BDF7568E4E8E5FA513FDD5D
          4DDF5D4DDF5140DDE8E6FA7668E45B4BDF5C4CDF5949DFFFFFFFFFFFFFDCD8F8
          4634DB5E4EDF5B4BDF5140DD5D4DDF5F4FE05F4FE05D4DDF5140DD5B4BDF5E4E
          DF4634DBDCD9F8FFFFFFFFFFFFFFFFFFBCB5F24634DB5C4CDF5F4FE05F4FE05F
          4FE05F4FE05F4FE05F4FE05C4CDF4634DBBCB5F2FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFDCD8F85948DE4F3DDC5646DE5948DE5948DE5646DE4F3DDC5949DFDCD9
          F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D2F7A49BED8D
          82E88D82E8A49BEDD7D3F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        TabOrder = 7
        TabStop = False
      end
    end
    object pnlDadosPedido: TPanel
      Left = 2
      Top = 15
      Width = 1103
      Height = 98
      Align = alTop
      BevelInner = bvLowered
      BevelKind = bkTile
      BevelOuter = bvSpace
      TabOrder = 0
      object Label1: TLabel
        Left = 9
        Top = 49
        Width = 33
        Height = 13
        Caption = 'Cliente'
      end
      object edtNomeDoCliente: TEdit
        Left = 134
        Top = 64
        Width = 451
        Height = 21
        TabStop = False
        TabOrder = 5
        Text = 'NENHUM'
        StyleElements = [seFont, seBorder]
      end
      object edtDtEmissao: TLabeledEdit
        Left = 134
        Top = 23
        Width = 121
        Height = 21
        EditLabel.Width = 79
        EditLabel.Height = 13
        EditLabel.Caption = 'Data de Emiss'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        StyleElements = [seFont, seBorder]
      end
      object edtStatusPedido: TLabeledEdit
        Left = 261
        Top = 23
        Width = 121
        Height = 21
        EditLabel.Width = 31
        EditLabel.Height = 13
        EditLabel.Caption = 'Status'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        StyleElements = [seFont, seBorder]
      end
      object edtClientes: TEdit
        Left = 9
        Top = 64
        Width = 94
        Height = 21
        TabOrder = 3
        OnExit = edtClientesExit
      end
      object btnConsultarClientes: TBitBtn
        Left = 103
        Top = 65
        Width = 27
        Height = 21
        Hint = 'Abrir Consulta de Clientes'
        Glyph.Data = {
          42060000424D360A000000000000360800002800000010000000100000000100
          1000030000000002000000000000000000000001000000000000007C0000E003
          00001F0000005A6B7300AD7B73004A637B00EFBD8400B58C8C00A5948C00C694
          8C00B59C8C00BD9C8C00F7BD8C00BD949400C6949400CE949400C69C9400CEAD
          9400F7CE9400C6A59C00CEA59C00D6A59C00C6AD9C00CEAD9C00D6AD9C00F7CE
          9C00F7D69C004A7BA500CEADA500D6B5A500DEBDA500F7D6A500DEBDAD00DEC6
          AD00E7C6AD00FFDEAD00FFE7AD00CEB5B500F7DEB500F7E7B500FFE7B500FFEF
          B500D6BDBD00DED6BD00E7DEBD00FFE7BD006B9CC600EFDEC600FFEFC600FFF7
          C600F7E7CE00FFF7CE00F7EFD600F7F7D600FFF7D600FFFFD6002184DE00F7F7
          DE00FFFFDE001884E700188CE700FFFFE700188CEF00218CEF00B5D6EF00F7F7
          EF00FFF7EF00FFFFEF00FFFFF700FF00FF004AB5FF0052B5FF0052BDFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF001F7C893D574A1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C6D622372E951584A1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7CC97ECA7E2476E951584A1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7CCA7ECA7E0372E951584A1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7CCA7EC97E2372E951574A1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7CCA7EC97E046EAB391F7CF539984EDA52994E1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7CEA7E5677544676469E67FF6BFF6BFF6B7C5F
          B9521F7C1F7C1F7C1F7C1F7C1F7C1F7CD95ADA52BF63FF6BFF6BFF6BFF6FFF77
          DE7736461F7C1F7C1F7C1F7C1F7C1F7C58467E5B5E53DF67FF6BFF6FFF77FF7B
          FF7F5B5F1F7C1F7C1F7C1F7C1F7C1F7CFB529F573E4BDF67FF6FFF73FF7BFF7B
          FF77BE6B784A1F7C1F7C1F7C1F7C1F7C1C577F57FD429E5BFF6BFF6FFF73FF73
          FF6FDE6BB84E1F7C1F7C1F7C1F7C1F7CFB569F5BFD423E4BBF63FF6FFF6FFF6F
          FF6FBE6B984E1F7C1F7C1F7C1F7C1F7C784ABF63BF635E533E4F9E5BDF67DF6B
          FF6B7C5F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1B57FF7FDF773E4BFD423E4F9F5B
          DF6377461F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFA5EBE6BBF639F579F5B7E5B
          B94E1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CB94AB94EFB52FB521F7C
          1F7C1F7C1F7C}
        TabOrder = 4
        OnClick = btnConsultarClientesClick
      end
      object edtCodigo: TLabeledEdit
        Left = 9
        Top = 23
        Width = 121
        Height = 21
        EditLabel.Width = 87
        EditLabel.Height = 13
        EditLabel.BiDiMode = bdLeftToRight
        EditLabel.Caption = 'N'#250'mero do Pedido'
        EditLabel.ParentBiDiMode = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        StyleElements = [seFont, seBorder]
      end
    end
    object gbItensPedido: TGroupBox
      Left = 2
      Top = 201
      Width = 1103
      Height = 343
      Align = alClient
      Caption = 'Itens do Pedido'
      TabOrder = 2
      object gItensPedido: TDBGrid
        Left = 2
        Top = 15
        Width = 1099
        Height = 326
        Align = alClient
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  inherited Panel1: TPanel
    Top = 546
    Width = 1107
    Height = 39
    ExplicitTop = 546
    ExplicitWidth = 1107
    ExplicitHeight = 39
    inherited sbCancelar: TSpeedButton
      Height = 37
      ExplicitHeight = 37
    end
    inherited sbGravar: TSpeedButton
      Height = 37
      ExplicitLeft = -5
      ExplicitHeight = 37
    end
    object Label3: TLabel
      Left = 829
      Top = 10
      Width = 82
      Height = 19
      Caption = 'TOTAL R$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtVlrTotalPedido: TEdit
      Left = 918
      Top = 2
      Width = 179
      Height = 33
      TabStop = False
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      StyleElements = [seFont, seBorder]
    end
  end
end
