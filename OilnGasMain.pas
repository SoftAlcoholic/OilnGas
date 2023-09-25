unit OilnGasMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, FMX.TabControl,
  FMX.DateTimeCtrls;

type
  TForm1 = class(TForm)
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
  Form1: TForm1;

implementation

{$R *.fmx}

uses DmONG;

procedure TForm1.BtnFillLevelClick(Sender: TObject);
begin
  OilFormNameLoader;
end;

procedure TForm1.BtnSaveOilClick(Sender: TObject);
begin
  if EdtHiddenOilFillType.text='oil change' then
    ShowMessage('Oil change. Odometer: ' + EdtOdometer.Text + ' cost per qt: ' + EdtCost.Text + ' oil change date: ' + EdtDateOilChange.Text + ' quantity: ' + EdtQtQuantity.Text + 'Qt.')
  else
    ShowMessage('Oil refill. Odometer: ' + EdtOdometer.Text + ' cost per qt: ' + EdtCost.Text + ' oil change date: ' + EdtDateOilChange.Text + ' quantity: ' + EdtQtQuantity.Text + 'Qt.')

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EdtHiddenOilFillType.Text := 'oil change';
  EdtDateOilChange.Text := '';
end;

procedure TForm1.OilFormNameLoader();
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

end.
