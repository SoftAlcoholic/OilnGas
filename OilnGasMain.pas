unit OilnGasMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, FMX.TabControl,
  FMX.DateTimeCtrls, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, FMX.ListView;

type
  TFrmONG = class(TForm)
    TabControlMain: TTabControl;
    TabItemNewOil: TTabItem;
    GridPanelLayout1: TGridPanelLayout;
    BtnSaveOil: TButton;
    EdtOdometer: TEdit;
    LbOdometer: TLabel;
    LbCost: TLabel;
    EdtCost: TEdit;
    LbDate: TLabel;
    EdtDateOilChange: TDateEdit;
    LbQtQuantity: TLabel;
    EdtQtQuantity: TEdit;
    BtnFillLevel: TButton;
    GridPanelLayout2: TGridPanelLayout;
    EdtHiddenOilFillType: TEdit;
    TabItem1: TTabItem;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure BtnFillLevelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnSaveOilClick(Sender: TObject);

  private
    procedure OilFormNameLoader;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmONG: TFrmONG;

implementation

{$R *.fmx}

uses DmONG, FireDAC.Comp.Client, FireDAC.Stan.Param;

procedure TFrmONG.BtnFillLevelClick(Sender: TObject);
begin
  OilFormNameLoader;
end;

procedure TFrmONG.BtnSaveOilClick(Sender: TObject);
begin
  if EdtHiddenOilFillType.text = 'oil change' then
    ShowMessage('Oil change. Odometer: ' + EdtOdometer.text + ' cost per qt: ' +
      EdtCost.text + ' oil change date: ' + EdtDateOilChange.text +
      ' quantity: ' + EdtQtQuantity.text + 'Qt.')
  else
    ShowMessage('Oil refill. Odometer: ' + EdtOdometer.text + ' cost per qt: ' +
      EdtCost.text + ' oil change date: ' + EdtDateOilChange.text +
      ' quantity: ' + EdtQtQuantity.text + 'Qt.')

end;

procedure TFrmONG.FormCreate(Sender: TObject);
begin
  EdtHiddenOilFillType.text := 'oil change';
  EdtDateOilChange.text := '';
end;

procedure TFrmONG.OilFormNameLoader();
begin
  if BtnFillLevel.text <> 'Cancel' then
  begin
    BtnFillLevel.text := 'Cancel';
    BtnSaveOil.text := 'Register oil level refill';
    EdtHiddenOilFillType.text := 'oil refill';
    LbOdometer.text := 'Refill odometer';
    EdtOdometer.text := '';
    EdtCost.text := '';
    EdtDateOilChange.text := '';
    EdtQtQuantity.text := '';
  end
  else
  begin
    BtnFillLevel.text := 'Fill oil level';
    BtnSaveOil.text := 'Register new oil change';
    EdtHiddenOilFillType.text := 'oil change';
    LbOdometer.text := 'Last oil change odometer';
    EdtOdometer.text := '';
    EdtCost.text := '';
    EdtDateOilChange.text := '';
    EdtQtQuantity.text := '';
  end;
end;

function SaveOilChangeData(Odometer: Integer; CostPerQt: Double;
  ChangeDate: TDateTime; QuartsTotal: Double): Boolean;
var
  Query: TFDQuery;
begin
  Result := False; // Initialize the result as false by default

  Query := TFDQuery.Create(nil);

  try
    // Use the existing connection from your Data Module
    Query.Connection := DataModuleONG.Sqlite_demoConnection;

    // Prepare the SQL query for insertion
    Query.SQL.text :=
      'INSERT INTO CambiosAceite (Odometro, CostoPorQt, Fecha, CuartosTotales) VALUES (:Odometer, :CostPerQt, :ChangeDate, :QuartsTotal)';
    Query.ParamByName('Odometer').AsInteger := Odometer;
    Query.ParamByName('CostPerQt').AsFloat := CostPerQt;
    Query.ParamByName('ChangeDate').AsDateTime := ChangeDate;
    Query.ParamByName('QuartsTotal').AsFloat := QuartsTotal;

    // Execute the query
    Query.ExecSQL;

    // The query was successful
    Result := True;
  finally
    Query.Free;
  end;
end;

end.
