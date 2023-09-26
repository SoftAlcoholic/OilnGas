program OilnGas;

uses
  System.StartUpCopy,
  FMX.Forms,
  OilnGasMain in 'OilnGasMain.pas' {FrmONG},
  DmONG in 'DmONG.pas' {DataModuleONG: TDataModule},
  FrmAddvehicles in 'FrmAddvehicles.pas' {FrmAddVehicle: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmONG, FrmONG);
  Application.CreateForm(TDataModuleONG, DataModuleONG);
  Application.Run;
end.
