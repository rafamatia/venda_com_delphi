object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 129
  object fdcConexao: TFDConnection
    Params.Strings = (
      'Database=dbwktechnoloygy'
      'User_Name=root'
      'Password=SENHA1'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 48
    Top = 80
  end
  object DriverMySQL: TFDPhysMySQLDriverLink
    DriverID = 'MySQL'
    VendorLib = 'C:\teste_rafaelmatiateles\exe\libmysql.dll'
    Left = 48
    Top = 24
  end
end
