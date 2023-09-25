object DataModuleONG: TDataModuleONG
  Height = 480
  Width = 640
  object Sqlite_demoConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=SQLite_Demo')
    Connected = True
    LoginPrompt = False
    Left = 21
    Top = 23
  end
end
