object DataModuleONG: TDataModuleONG
  Height = 480
  Width = 640
  object OilTable: TFDQuery
    Connection = Sqlite_demoConnection
    SQL.Strings = (
      'SELECT * FROM Oil')
    Left = 12
    Top = 62
  end
  object Sqlite_demoConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Usuario 1\Documents\Embarcadero\Studio\Project' +
        's\OilnGas\ongdb.s3db'
      'DriverID=SQLite')
    FetchOptions.AssignedValues = [evAutoClose]
    FetchOptions.AutoClose = False
    Connected = True
    LoginPrompt = False
    Left = 9
    Top = 10
  end
end
