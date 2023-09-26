unit DmONG;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDataModuleONG = class(TDataModule)
    OilTable: TFDQuery;
    Sqlite_demoConnection: TFDConnection;
    FDQuery1: TFDQuery;
  private
    { Private declarations }
  public
    function GetVehicleData: TFDQuery;
    { Public declarations }
  end;

var
  DataModuleONG: TDataModuleONG;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function TDataModuleONG.GetVehicleData: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Sqlite_demoConnection;
  Result.SQL.Text := 'SELECT * FROM Vehicles';
  Result.Open;
end;

end.
