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
  Data.Bind.DBScope, FMX.ListView, FMX.ListBox;

type
  TFrmONG = class(TForm)
    TabControlMain: TTabControl;
    TbNewOli: TTabItem;
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
    Tb: TTabItem;
    ListWiewOilChanges: TListView;
    TbVehicle: TTabItem;
    SBtnVehicle: TSpeedButton;
    PnOli: TPanel;
    SBtnCancel: TSpeedButton;
    Panel1: TPanel;
    SBtnNewVehicle: TSpeedButton;
    TbFormVehicle: TTabItem;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    GridPanelLayout3: TGridPanelLayout;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    DateEdit1: TDateEdit;
    Label4: TLabel;
    Edit3: TEdit;
    GridPanelLayout4: TGridPanelLayout;
    Button2: TButton;
    procedure BtnFillLevelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnSaveOilClick(Sender: TObject);
    procedure LbOdometerClick(Sender: TObject);
    procedure SBtnVehicleClick(Sender: TObject);
    procedure SBtnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SBtnNewVehicleClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure OilFormNameLoader;
    function SaveOilChangeData(Distance: Double; ChangeDate: TDate;
      Cost: Double; OilQuantity: Double; FillType: string): Boolean;
    procedure AddNewVehicle;
    procedure SelectExistingVehicle;
  public
    { Public declarations }
  end;

var
  FrmONG: TFrmONG;

implementation

{$R *.fmx}

uses DmONG, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param;

procedure TFrmONG.BtnFillLevelClick(Sender: TObject);
begin
  OilFormNameLoader;
end;

procedure TFrmONG.BtnSaveOilClick(Sender: TObject);
var
  Distance: Double;
  ChangeDate: TDate;
  Cost: Double;
  OilQuantity: Double;
  FillType: string;
begin
  // Retrieve input values from form's controls
  Distance := StrToFloat(EdtOdometer.Text);
  ChangeDate := StrToDate(EdtDateOilChange.Text);
  Cost := StrToFloat(EdtCost.Text);
  OilQuantity := StrToFloat(EdtQtQuantity.Text);
  FillType := EdtHiddenOilFillType.Text;

  // Call the SaveOilChangeData function and check the result
  if SaveOilChangeData(Distance, ChangeDate, Cost, OilQuantity, FillType) then
  begin
    // If the save was successful, display a success message
    if FillType = 'oil change' then
      ShowMessage('Oil change successfully saved. Odometer: ' +
        FloatToStr(Distance) + ', cost per qt: ' + FloatToStr(Cost) +
        ', oil change date: ' + DateToStr(ChangeDate) + ', quantity: ' +
        FloatToStr(OilQuantity) + ' Qt.')
    else
      ShowMessage('Oil refill successfully saved. Odometer: ' +
        FloatToStr(Distance) + ', cost per qt: ' + FloatToStr(Cost) +
        ', oil change date: ' + DateToStr(ChangeDate) + ', quantity: ' +
        FloatToStr(OilQuantity) + ' Qt.');
  end
  else
  begin
    // If there was an error during save, display an error message
    ShowMessage
      ('Error: Failed to save data. Please check your input and try again.');
  end;
end;

procedure TFrmONG.AddNewVehicle;
begin
  (*
    try
    FrmVehiclesadd := TFrmVehiclesadd.Create(Application);
    with FrmVehiclesadd do
    begin

    {$IFDEF ANDROID}
    Show;
    {$ENDIF}
    {$IFDEF MSWINDOWS}
    ShowModal;
    {$ENDIF}
    end;
    finally
    FreeAndNil(FrmVehiclesadd);
    end;

    end
    else
    begin
    // Mmanage existing vehicles
  *)
end;

procedure TFrmONG.SelectExistingVehicle;
begin
  // Handle other item clicks (e.g., selecting an existing vehicle)
  // You can add code here to perform actions for selecting an existing vehicle.
  // Example:
  // SelectedVehicleID := Integer(ComboBoxVehicles.Items.Objects[ComboBoxVehicles.ItemIndex]);
  // LoadDataForSelectedVehicle(SelectedVehicleID);
end;

procedure TFrmONG.SpeedButton1Click(Sender: TObject);
begin
  TbVehicle.IsSelected := true;
  TbVehicle.Visible := true;
  TbFormVehicle.Visible := false;
end;

procedure TFrmONG.FormActivate(Sender: TObject);
begin
  TbNewOli.IsSelected := true;
  TbVehicle.Visible := false;
  TbFormVehicle.Visible := false;
end;

procedure TFrmONG.FormCreate(Sender: TObject);
begin
  EdtHiddenOilFillType.Text := 'oil change';
  EdtDateOilChange.Text := '';
end;

procedure TFrmONG.LbOdometerClick(Sender: TObject);
begin
  AddNewVehicle;
end;

procedure TFrmONG.OilFormNameLoader();
begin
  if BtnFillLevel.Text <> 'Cancel' then
  begin
    BtnFillLevel.Text := 'Cancel';
    BtnSaveOil.Text := 'Register oil level refill';
    EdtHiddenOilFillType.Text := 'oil refill';
    LbOdometer.Text := 'Refill odometer';
    EdtOdometer.Text := '';
    EdtCost.Text := '';
    EdtDateOilChange.Text := '';
    EdtQtQuantity.Text := '';
  end
  else
  begin
    BtnFillLevel.Text := 'Fill oil level';
    BtnSaveOil.Text := 'Register new oil change';
    EdtHiddenOilFillType.Text := 'oil change';
    LbOdometer.Text := 'Last oil change odometer';
    EdtOdometer.Text := '';
    EdtCost.Text := '';
    EdtDateOilChange.Text := '';
    EdtQtQuantity.Text := '';
  end;
end;

function TFrmONG.SaveOilChangeData(Distance: Double; ChangeDate: TDate;
  Cost: Double; OilQuantity: Double; FillType: string): Boolean;
var
  Query: TFDQuery;
  Transaction: TFDTransaction;
begin
  Result := false; // Initialize the result as false by default

  Query := TFDQuery.Create(nil);
  Transaction := TFDTransaction.Create(nil);

  try
    // Use the existing connection and associate it with the transaction
    Query.Connection := DataModuleONG.Sqlite_demoConnection;
    Query.Transaction := Transaction;
    Transaction.Connection := DataModuleONG.Sqlite_demoConnection;

    // Start the transaction
    Transaction.StartTransaction;

    try
      // Prepare the SQL query for insertion
      Query.SQL.Text :=
        'INSERT INTO Oil (distance, date, cost, oil_quantity, fill_type) VALUES (:Distance, :ChangeDate, :Cost, :OilQuantity, :FillType)';
      Query.ParamByName('Distance').AsFloat := Distance;
      Query.ParamByName('ChangeDate').AsDate := ChangeDate;
      Query.ParamByName('Cost').AsFloat := Cost;
      Query.ParamByName('OilQuantity').AsFloat := OilQuantity;
      Query.ParamByName('FillType').AsString := FillType;

      // Execute the query
      Query.ExecSQL;

      // Commit the transaction if everything was successful
      Transaction.Commit;
      Result := true;
    except
      // If there was an error during the transaction, roll it back
      Transaction.Rollback;
      raise; // Rethrow the exception to propagate it to the caller
    end;
  finally
    Query.Free;
    Transaction.Free;
  end;
end;

procedure TFrmONG.SBtnCancelClick(Sender: TObject);
begin
  TbVehicle.Visible := false;
  TbNewOli.Visible := true;
  Tb.Visible := true;

  TbNewOli.IsSelected := true;
end;

procedure TFrmONG.SBtnNewVehicleClick(Sender: TObject);
begin
  TbFormVehicle.IsSelected := true;
  TbFormVehicle.Visible := true;
  TbVehicle.Visible := false;
end;

procedure TFrmONG.SBtnVehicleClick(Sender: TObject);
begin
  TbVehicle.Visible := true;
  TbNewOli.Visible := false;
  Tb.Visible := false;

  TbVehicle.IsSelected := true;
end;

end.
