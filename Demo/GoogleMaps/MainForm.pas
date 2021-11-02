unit MainForm;

interface

uses
  WebView2, System.SysUtils, Winapi.ActiveX, Vcl.Forms,
  Vcl.GoogleMap, Vcl.Edge, Data.DB, Datasnap.DBClient, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Controls, System.Classes;

type
  TformMain = class(TForm)
    PanelHeader: TPanel;
    ButtonClearMarkers: TButton;
    ShowMapButton: TButton;
    PopupMenu: TPopupMenu;
    HideMapButton: TButton;
    EdgeGoogleMapViewer: TEdgeGoogleMapViewer;
    cdsCustomers: TClientDataSet;
    cdsCustomersCustNo: TFloatField;
    cdsCustomersCompany: TStringField;
    cdsCustomersAddr1: TStringField;
    cdsCustomersAddr2: TStringField;
    cdsCustomersCity: TStringField;
    cdsCustomersState: TStringField;
    cdsCustomersZip: TStringField;
    cdsCustomersCountry: TStringField;
    cdsCustomersPhone: TStringField;
    cdsCustomersFAX: TStringField;
    cdsCustomersTaxRate: TFloatField;
    cdsCustomersContact: TStringField;
    cdsCustomersLastInvoiceDate: TDateTimeField;
    DBGrid: TDBGrid;
    dsCustomers: TDataSource;
    gbMapAttributes: TGroupBox;
    MapTypeIdComboBox: TComboBox;
    lbZoom: TLabel;
    Zoom: TSpinEdit;
    CheckBoxStreeView: TCheckBox;
    CheckBoxBicycling: TCheckBox;
    CheckBoxTraffic: TCheckBox;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    MemoAddress: TMemo;
    ButtonGotoLocation: TButton;
    Longitude: TEdit;
    Latitude: TEdit;
    LabelLongitude: TLabel;
    LabelLatitude: TLabel;
    LabelAddress: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    StartLat: TEdit;
    StartLng: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    DestLat: TEdit;
    DestLng: TEdit;
    cbxTravelMode: TComboBox;
    ButtonRouteLatLng: TButton;
    ButtonGotoAddress: TButton;
    StartAddressMemo: TMemo;
    Label6: TLabel;
    DestinationAddressMemo: TMemo;
    ButtonRouteByAddress: TButton;
    Label8: TLabel;
    DBNavigator: TDBNavigator;
    FileEdit: TLabeledEdit;
    LoadTableButton: TButton;
    Splitter1: TSplitter;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonGotoAddressClick(Sender: TObject);
    procedure ButtonGotoLocationClick(Sender: TObject);
    procedure CheckBoxTrafficClick(Sender: TObject);
    procedure CheckBoxBicyclingClick(Sender: TObject);
    procedure CheckBoxStreeViewClick(Sender: TObject);
    procedure ButtonClearMarkersClick(Sender: TObject);
    procedure ZoomChange(Sender: TObject);
    procedure ShowMapButtonClick(Sender: TObject);
    procedure HideMapButtonClick(Sender: TObject);
    procedure MapTypeIdComboBoxChange(Sender: TObject);
    procedure cdsCustomersAfterScroll(DataSet: TDataSet);
    procedure ButtonRouteLatLngClick(Sender: TObject);
    procedure cbxTravelModeChange(Sender: TObject);
    procedure ButtonRouteByAddressClick(Sender: TObject);
    procedure LoadTableButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdgeGoogleMapViewerBeforeShowMap(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

uses
  Vcl.Dialogs, SecondaryForm;

{$R *.dfm}

function B2S(value: boolean): string;
begin
  if value then
    Result := 'true'
  else
    Result := 'false';
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  Zoom.Value := EdgeGoogleMapViewer.MapZoom;
  CheckBoxTraffic.Checked := EdgeGoogleMapViewer.MapShowTrafficLayer;
  CheckBoxBicycling.Checked := EdgeGoogleMapViewer.MapShowBicyclingLayer;
  CheckBoxStreeView.Checked := EdgeGoogleMapViewer.MapShowStreetViewControl;
  MemoAddress.Lines.Text := EdgeGoogleMapViewer.MapAddress;
  Latitude.Text := TEdgeGoogleMapViewer.CoordToText(EdgeGoogleMapViewer.MapLatitude);
  Longitude.Text := TEdgeGoogleMapViewer.CoordToText(EdgeGoogleMapViewer.MapLongitude);
  MapTypeIdComboBox.ItemIndex := Ord(EdgeGoogleMapViewer.MapTypeId);
  StartLat.Text := TEdgeGoogleMapViewer.CoordToText(37.7699298);
  StartLng.Text := TEdgeGoogleMapViewer.CoordToText(-122.4469157);
  DestLat.Text := TEdgeGoogleMapViewer.CoordToText(37.7683909618184);
  DestLng.Text := TEdgeGoogleMapViewer.CoordToText(-122.51089453697205);
  StartAddressMemo.Lines.Text := 'Via Santa Cecilia 4, 20061 Carugate, Milano';
  DestinationAddressMemo.Lines.Text := 'Via San Francesco 5, 20061 Carugate, Milano';
  FileEdit.Text := ExtractFilePath(Application.ExeName)+'..\..\Data\customer.xml';
end;

procedure TformMain.FormDestroy(Sender: TObject);
begin
  activeoleControl := nil;
end;

procedure TformMain.HideMapButtonClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.HideMap;
end;

procedure TformMain.LoadTableButtonClick(Sender: TObject);
begin
  cdsCustomers.LoadFromFile(FileEdit.Text);
end;

procedure TformMain.MapTypeIdComboBoxChange(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapTypeId := TGoogleMapTypeId(MapTypeIdComboBox.ItemIndex);
end;

procedure TformMain.ShowMapButtonClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.GotoAddress(MemoAddress.Lines.Text);
end;

procedure TformMain.ZoomChange(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapZoom := Zoom.Value;
end;

procedure TformMain.ButtonGotoLocationClick(Sender: TObject);
var
  Location: TLatLng;
begin
  Location.Latitude := TEdgeGoogleMapViewer.TextToCoord(Latitude.Text);
  Location.Longitude := TEdgeGoogleMapViewer.TextToCoord(Longitude.Text);
  EdgeGoogleMapViewer.GotoLocation(Location);
end;

procedure TformMain.cbxTravelModeChange(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapRouteModeId := TGoogleRouteModeId(cbxTravelMode.ItemIndex);
end;

procedure TformMain.cdsCustomersAfterScroll(DataSet: TDataSet);
var
  Address: string;
begin
  //Build Address from dataset
  if (cdsCustomersState.Value <> '') then
    Address := cdsCustomersAddr1.AsString+' '+cdsCustomersAddr2.AsString+', '+
      cdsCustomersCity.AsString+', '+cdsCustomersState.AsString+', '+cdsCustomersCountry.AsString
  else
    Address := cdsCustomersAddr1.AsString+' '+cdsCustomersAddr2.AsString+', '+
      cdsCustomersCity.AsString+', '+cdsCustomersCountry.AsString;

  MemoAddress.Lines.Text := Address;
  if EdgeGoogleMapViewer.MapVisible then
    EdgeGoogleMapViewer.GotoAddress(Address);
end;

procedure TformMain.ButtonRouteByAddressClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapStartAddress := StartAddressMemo.Lines.Text;
  EdgeGoogleMapViewer.MapDestinationAddress := DestinationAddressMemo.Lines.Text;
  EdgeGoogleMapViewer.RouteByAddresses;
end;

procedure TformMain.ButtonRouteLatLngClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapStartLatitude :=  TEdgeGoogleMapViewer.TextToCoord(StartLat.Text);
  EdgeGoogleMapViewer.MapStartLongitude := TEdgeGoogleMapViewer.TextToCoord(StartLng.Text);
  EdgeGoogleMapViewer.MapDestinationLatitude := TEdgeGoogleMapViewer.TextToCoord (DestLat.Text);
  EdgeGoogleMapViewer.MapDestinationLongitude := TEdgeGoogleMapViewer.TextToCoord(DestLng.Text);
  EdgeGoogleMapViewer.MapRouteModeId := TGoogleRouteModeId(cbxTravelMode.ItemIndex);
  EdgeGoogleMapViewer.RouteByLocations;
end;

procedure TformMain.Button1Click(Sender: TObject);
var
  LFormSecondary: TFormSecondary;
begin
  Application.CreateForm(TFormSecondary, LFormSecondary);
end;

procedure TformMain.ButtonClearMarkersClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ClearMarkers;
end;

procedure TformMain.ButtonGotoAddressClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.GotoAddress(MemoAddress.Lines.Text);
end;

procedure TformMain.CheckBoxStreeViewClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ShowStreetViewControl(CheckBoxStreeView.Checked);
end;

procedure TformMain.CheckBoxBicyclingClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ShowBicycling(CheckBoxBicycling.Checked);
 end;


procedure TformMain.CheckBoxTrafficClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ShowTraffic(CheckBoxTraffic.Checked);
 end;

procedure TformMain.EdgeGoogleMapViewerBeforeShowMap(Sender: TObject);
var
  LApiKey: string;
begin
  //The demo requires to input the API Key: it's only for testing!
  if TEdgeGoogleMapViewer.ApiKey = '' then
  begin
    if InputQuery('Activate Google Maps API','Insert Google Maps API Key:', LApiKey) then
       TEdgeGoogleMapViewer.RegisterGoogleMapsApiKey(LApiKey);
  end;
end;

initialization
  //Setup UserDataFolder for Temp files
  TEdgeGoogleMapViewer.RegisterUserDataFolder(ExtractFilePath(ParamStr(0))+'..\..\CacheTempFolder\');
  //If you have a Google API Key it's time to setup
  //TEdgeGoogleMapViewer.RegisterGoogleMapsApiKey('xyz');

  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

end.
