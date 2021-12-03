unit MainForm;

interface

uses
  WebView2, System.SysUtils, Winapi.ActiveX, Vcl.Forms,
  Vcl.GoogleMap, Vcl.Edge, Data.DB, Datasnap.DBClient, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Controls, System.Classes, Vcl.Mask, Vcl.ComCtrls;

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
    LabelLongitude: TLabel;
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
    LoadTableButton: TButton;
    Splitter1: TSplitter;
    CheckBoxDirectionPanel: TCheckBox;
    GroupBox3: TGroupBox;
    Button1: TButton;
    Panel1: TPanel;
    FileEdit: TEdit;
    Label7: TLabel;
    LabelLatitude: TLabel;
    Latitude: TEdit;
    PageControlMarker: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GridPanel1: TGridPanel;
    GridPanel2: TGridPanel;
    Panel2: TPanel;
    Label9: TLabel;
    editMarkerLat: TEdit;
    Panel3: TPanel;
    Label10: TLabel;
    editMarkerLng: TEdit;
    Panel5: TPanel;
    Label11: TLabel;
    editMarkerDescription: TEdit;
    Panel6: TPanel;
    Label12: TLabel;
    editMarkerLabel: TEdit;
    TabSheet3: TTabSheet;
    Panel7: TPanel;
    Label13: TLabel;
    MapTypeIdComboBox: TComboBox;
    comboMarkerAnimation: TComboBox;
    btnAddMarker: TButton;
    TabSheet4: TTabSheet;
    cbMarkerCustom: TCheckBox;
    memoMarkerCustomJSON: TMemo;
    Label14: TLabel;
    memoMarkerInformation: TMemo;
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
    procedure CheckBoxDirectionPanelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddMarkerClick(Sender: TObject);
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
  CheckBoxDirectionPanel.Checked := EdgeGoogleMapViewer.MapShowDirectionsPanel;
  MemoAddress.Lines.Text := EdgeGoogleMapViewer.MapAddress;
  Latitude.Text := TEdgeGoogleMapViewer.CoordToText(EdgeGoogleMapViewer.MapLatitude);
  Longitude.Text := TEdgeGoogleMapViewer.CoordToText(EdgeGoogleMapViewer.MapLongitude);
  editMarkerLat.Text := TEdgeGoogleMapViewer.CoordToText(-31.9523);
  editMarkerLng.Text  := TEdgeGoogleMapViewer.CoordToText(115.8613);
  editMarkerDescription.Text := 'Perth, Western Australia';
  editMarkerLabel.Text := 'Here';
  comboMarkerAnimation.ItemIndex := 0;
  memoMarkerCustomJSON.Lines.Text := EdgeGoogleMapViewer.DefaultCustomMarkerJSON;
  MapTypeIdComboBox.ItemIndex := Ord(EdgeGoogleMapViewer.MapTypeId);
  StartLat.Text := TEdgeGoogleMapViewer.CoordToText(37.7699298);
  StartLng.Text := TEdgeGoogleMapViewer.CoordToText(-122.4469157);
  DestLat.Text := TEdgeGoogleMapViewer.CoordToText(37.7683909618184);
  DestLng.Text := TEdgeGoogleMapViewer.CoordToText(-122.51089453697205);
  StartAddressMemo.Lines.Text := 'Via Santa Cecilia 4, 20061 Carugate, Milano';
  DestinationAddressMemo.Lines.Text := 'Via San Francesco 5, 20061 Carugate, Milano';
  FileEdit.Text := ExtractFilePath(Application.ExeName)+'..\..\Data\customer.xml';
  PageControlMarker.ActivePageIndex := 0;
end;

procedure TformMain.FormDestroy(Sender: TObject);
begin
  activeoleControl := nil;
end;

procedure TformMain.FormShow(Sender: TObject);
begin
  ShowMapButtonClick(Sender);
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
  EdgeGoogleMapViewer.MapShowDirectionsPanel := CheckBoxDirectionPanel.Checked;
  EdgeGoogleMapViewer.MapStartAddress := StartAddressMemo.Lines.Text;
  EdgeGoogleMapViewer.MapDestinationAddress := DestinationAddressMemo.Lines.Text;
  EdgeGoogleMapViewer.RouteByAddresses;
end;

procedure TformMain.ButtonRouteLatLngClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapShowDirectionsPanel := CheckBoxDirectionPanel.Checked;
  EdgeGoogleMapViewer.MapStartLatitude :=  TEdgeGoogleMapViewer.TextToCoord(StartLat.Text);
  EdgeGoogleMapViewer.MapStartLongitude := TEdgeGoogleMapViewer.TextToCoord(StartLng.Text);
  EdgeGoogleMapViewer.MapDestinationLatitude := TEdgeGoogleMapViewer.TextToCoord (DestLat.Text);
  EdgeGoogleMapViewer.MapDestinationLongitude := TEdgeGoogleMapViewer.TextToCoord(DestLng.Text);
  EdgeGoogleMapViewer.MapRouteModeId := TGoogleRouteModeId(cbxTravelMode.ItemIndex);
  EdgeGoogleMapViewer.RouteByLocations;
end;

procedure TformMain.btnAddMarkerClick(Sender: TObject);
var
  LLatLng : TLatLng;
  LCustomJSON : string;
  LAnimation : TGoogleMarkerAnimationId;
begin
  LLatLng.Latitude := TEdgeGoogleMapViewer.TextToCoord (editMarkerLat.Text);
  LLatLng.Longitude := TEdgeGoogleMapViewer.TextToCoord (editMarkerLng.Text);
  LAnimation := TGoogleMarkerAnimationId(comboMarkerAnimation.ItemIndex);
  LCustomJSON := '';
  if cbMarkerCustom.Checked then
    begin
      LCustomJSON := memoMarkerCustomJSON.Lines.Text;
    end;
  EdgeGoogleMapViewer.PutMarker(LLatLng,editMarkerDescription.Text, LAnimation ,editMarkerLabel.Text, memoMarkerInformation.Lines.Text, LCustomJSON);
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


procedure TformMain.CheckBoxDirectionPanelClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ShowDirectionsPanel(CheckBoxDirectionPanel.Checked);
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
