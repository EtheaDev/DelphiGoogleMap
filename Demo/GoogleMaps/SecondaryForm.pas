unit SecondaryForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Edge, Vcl.GoogleMap, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.Menus;

type
  TFormSecondary = class(TForm)
    PanelHeader: TPanel;
    gbMapAttributes: TGroupBox;
    lbZoom: TLabel;
    Label5: TLabel;
    MapTypeIdComboBox: TComboBox;
    Zoom: TSpinEdit;
    CheckBoxStreeView: TCheckBox;
    CheckBoxBicycling: TCheckBox;
    CheckBoxTraffic: TCheckBox;
    GroupBox1: TGroupBox;
    LabelLongitude: TLabel;
    LabelLatitude: TLabel;
    LabelAddress: TLabel;
    MemoAddress: TMemo;
    ButtonGotoLocation: TButton;
    Longitude: TEdit;
    Latitude: TEdit;
    ButtonGotoAddress: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    StartLat: TEdit;
    StartLng: TEdit;
    DestLat: TEdit;
    DestLng: TEdit;
    cbxTravelMode: TComboBox;
    ButtonRouteLatLng: TButton;
    StartAddressMemo: TMemo;
    DestinationAddressMemo: TMemo;
    ButtonRouteByAddress: TButton;
    EdgeGoogleMapViewer: TEdgeGoogleMapViewer;
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
    procedure ButtonRouteLatLngClick(Sender: TObject);
    procedure cbxTravelModeChange(Sender: TObject);
    procedure ButtonRouteByAddressClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdgeGoogleMapViewerBeforeShowMap(Sender: TObject);
  private
  public
  end;

implementation

uses
  Vcl.Dialogs;

{$R *.dfm}

procedure TFormSecondary.FormCreate(Sender: TObject);
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
end;

procedure TFormSecondary.FormDestroy(Sender: TObject);
begin
  activeoleControl := nil;
end;

procedure TFormSecondary.HideMapButtonClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.HideMap;
end;

procedure TFormSecondary.MapTypeIdComboBoxChange(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapTypeId := TGoogleMapTypeId(MapTypeIdComboBox.ItemIndex);
end;

procedure TFormSecondary.ShowMapButtonClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.GotoAddress(MemoAddress.Lines.Text);
end;

procedure TFormSecondary.ZoomChange(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapZoom := Zoom.Value;
end;

procedure TFormSecondary.ButtonGotoLocationClick(Sender: TObject);
var
  Location: TLatLng;
begin
  Location.Latitude := TEdgeGoogleMapViewer.TextToCoord(Latitude.Text);
  Location.Longitude := TEdgeGoogleMapViewer.TextToCoord(Longitude.Text);
  EdgeGoogleMapViewer.GotoLocation(Location);
end;

procedure TFormSecondary.cbxTravelModeChange(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapRouteModeId := TGoogleRouteModeId(cbxTravelMode.ItemIndex);
end;

procedure TFormSecondary.ButtonRouteByAddressClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapStartAddress := StartAddressMemo.Lines.Text;
  EdgeGoogleMapViewer.MapDestinationAddress := DestinationAddressMemo.Lines.Text;
  EdgeGoogleMapViewer.RouteByAddresses;
end;

procedure TFormSecondary.ButtonRouteLatLngClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapStartLatitude :=  TEdgeGoogleMapViewer.TextToCoord(StartLat.Text);
  EdgeGoogleMapViewer.MapStartLongitude := TEdgeGoogleMapViewer.TextToCoord(StartLng.Text);
  EdgeGoogleMapViewer.MapDestinationLatitude := TEdgeGoogleMapViewer.TextToCoord (DestLat.Text);
  EdgeGoogleMapViewer.MapDestinationLongitude := TEdgeGoogleMapViewer.TextToCoord(DestLng.Text);
  EdgeGoogleMapViewer.MapRouteModeId := TGoogleRouteModeId(cbxTravelMode.ItemIndex);
  EdgeGoogleMapViewer.RouteByLocations;
end;

procedure TFormSecondary.ButtonClearMarkersClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ClearMarkers;
end;

procedure TFormSecondary.ButtonGotoAddressClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.GotoAddress(MemoAddress.Lines.Text);
end;

procedure TFormSecondary.CheckBoxStreeViewClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ShowStreetViewControl(CheckBoxStreeView.Checked);
end;

procedure TFormSecondary.CheckBoxBicyclingClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ShowBicycling(CheckBoxBicycling.Checked);
 end;


procedure TFormSecondary.CheckBoxTrafficClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ShowTraffic(CheckBoxTraffic.Checked);
 end;

procedure TFormSecondary.EdgeGoogleMapViewerBeforeShowMap(Sender: TObject);
var
  LApiKey: string;
begin
  //If you have a Google API Key it's time to setup
  //TEdgeGoogleMapViewer.RegisterGoogleMapsApiKey('AIzaSyBNY0ARa4GdRU4LrOKfk9hpNp96yM3dgHg');

  //The demo requires to input the API Key: it's only for testing!
  if TEdgeGoogleMapViewer.ApiKey = '' then
  begin
    if InputQuery('Activate Google Maps API','Insert Google Maps API Key:', LApiKey) then
       TEdgeGoogleMapViewer.RegisterGoogleMapsApiKey(LApiKey);
  end;
end;

initialization

end.
