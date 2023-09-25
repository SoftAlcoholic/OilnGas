program OilnGas;

uses
  System.StartUpCopy,
  FMX.Forms,
  OilnGasMain in 'OilnGasMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
