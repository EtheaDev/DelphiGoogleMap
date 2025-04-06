{ ****************************************************************************** }
{ }
{ Delphi Google Map Viewer Demo }
{ }
{ Copyright (c) 2021-2024 (Ethea S.r.l.) }
{ Author: Carlo Barazzetta }
{ Contributors: }
{ littleearth (https://github.com/littleearth) }
{ chaupero (https://github.com/chaupero) }
{ }
{ https://github.com/EtheaDev/DelphiGoogleMap }
{ }
{ ****************************************************************************** }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{ http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{ }
{ ****************************************************************************** }
unit MainForm;

interface

uses
  WebView2, System.SysUtils, Winapi.ActiveX, Vcl.Forms,
  Vcl.GoogleMap, Vcl.Edge, Data.DB, Datasnap.DBClient, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Controls, System.Classes, Vcl.Mask, Vcl.ComCtrls, Vcl.Buttons;

type
  TformMain = class(TForm)
    PanelHeader: TPanel;
    PopupMenu: TPopupMenu;
    gbMapAttributes: TGroupBox;
    lbZoom: TLabel;
    Zoom: TSpinEdit;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    MemoAddress: TMemo;
    ButtonGotoLocation: TButton;
    Longitude: TEdit;
    LabelLongitude: TLabel;
    LabelAddress: TLabel;
    ButtonGotoAddress: TButton;
    LabelLatitude: TLabel;
    Latitude: TEdit;
    MapTypeIdComboBox: TComboBox;
    cbCenterOnClick: TCheckBox;
    mapControlGroupBox: TGroupBox;
    CheckBoxTraffic: TCheckBox;
    CheckBoxBicycling: TCheckBox;
    CheckBoxStreeView: TCheckBox;
    CheckBoxFullScreen: TCheckBox;
    CheckBoxZoom: TCheckBox;
    CheckBoxMapType: TCheckBox;
    BottomPanel: TPanel;
    ShowPrintUIButton: TButton;
    ShowMapButton: TButton;
    HideMapButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonGotoAddressClick(Sender: TObject);
    procedure ButtonGotoLocationClick(Sender: TObject);
    procedure CheckBoxTrafficClick(Sender: TObject);
    procedure CheckBoxBicyclingClick(Sender: TObject);
    procedure CheckBoxStreeViewClick(Sender: TObject);
    procedure ButtonClearMarkersClick(Sender: TObject);
    procedure ZoomChange(Sender: TObject);
    procedure ShowPrintUIButtonClick(Sender: TObject);
    procedure ShowMapButtonClick(Sender: TObject);
    procedure HideMapButtonClick(Sender: TObject);
    procedure MapTypeIdComboBoxChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdgeGoogleMapViewerBeforeShowMap(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuAddMarkerClick(Sender: TObject);
    procedure CheckBoxFullScreenClick(Sender: TObject);
    procedure CheckBoxZoomClick(Sender: TObject);
    procedure EdgeGoogleMapViewerContainsFullScreenElementChanged(
      Sender: TCustomEdgeBrowser;
      ContainsFullScreenElement: Boolean);
    procedure CheckBoxMapTypeClick(Sender: TObject);
    procedure btnClearCirclesClick(Sender: TObject);
    procedure btnClearPolylinesClick(Sender: TObject);
    procedure btnClearPolygonsClick(Sender: TObject);
    procedure EdgeGoogleMapViewerViewerReadyWait(ASender : TObject; var AWait : boolean);
  private
    EdgeGoogleMapViewer: TEdgeGoogleMapViewer;
    FRighClickLatLng: TLatLng;
    procedure OnMapClick(
      ASender: TObject;
      ALatLng: TLatLng);
    procedure OnMapRightClick(
      ASender: TObject;
      ALatLng: TLatLng);
    procedure OnMapZoom(
      ASender: TObject;
      AZoom: integer);
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

uses
  System.IOUtils, Vcl.Dialogs, System.UITypes;

{$R *.dfm}

function B2S(value: Boolean): string;
begin
  if value then
    Result := 'true'
  else
    Result := 'false';
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  EdgeGoogleMapViewer := TEdgeGoogleMapViewer.Create(Self);
  EdgeGoogleMapViewer.Parent := Self;
  EdgeGoogleMapViewer.Align := alClient;
  EdgeGoogleMapViewer.OnContainsFullScreenElementChanged :=
    EdgeGoogleMapViewerContainsFullScreenElementChanged;
  EdgeGoogleMapViewer.BeforeShowMap := EdgeGoogleMapViewerBeforeShowMap;
  EdgeGoogleMapViewer.OnViewerReadyWait := EdgeGoogleMapViewerViewerReadyWait;

  Zoom.value := EdgeGoogleMapViewer.MapZoom;

  EdgeGoogleMapViewer.MapAddress := 'Via Santa Cecilia 4, Carugate, Milano';
  EdgeGoogleMapViewer.MapLatitude := 25.767314;
  EdgeGoogleMapViewer.MapLongitude := -80.135694;

  // Init checkboxes based on Component Proprerties
  CheckBoxTraffic.Checked := EdgeGoogleMapViewer.MapShowTrafficLayer;
  CheckBoxBicycling.Checked := EdgeGoogleMapViewer.MapShowBicyclingLayer;
  CheckBoxStreeView.Checked := EdgeGoogleMapViewer.MapShowStreetViewControl;
  CheckBoxFullScreen.Checked := EdgeGoogleMapViewer.MapShowFullScreenControl;
  CheckBoxZoom.Checked := EdgeGoogleMapViewer.MapShowZoomControl;
  CheckBoxMapType.Checked := EdgeGoogleMapViewer.MapShowTypeControl;

  MemoAddress.Lines.Text := EdgeGoogleMapViewer.MapAddress;
  Latitude.Text := TEdgeGoogleMapViewer.CoordToText
    (EdgeGoogleMapViewer.MapLatitude);
  Longitude.Text := TEdgeGoogleMapViewer.CoordToText
    (EdgeGoogleMapViewer.MapLongitude);
  MapTypeIdComboBox.ItemIndex := Ord(EdgeGoogleMapViewer.MapTypeId);
  EdgeGoogleMapViewer.OnMapClick := OnMapClick;
  EdgeGoogleMapViewer.OnMapRightClick := OnMapRightClick;
  EdgeGoogleMapViewer.OnMapZoom := OnMapZoom;
end;

procedure TformMain.OnMapClick(
  ASender: TObject;
  ALatLng: TLatLng);
begin
  if cbCenterOnClick.Checked then
  begin
    EdgeGoogleMapViewer.GotoLocation(ALatLng, False)
  end;
end;

procedure TformMain.OnMapRightClick(
  ASender: TObject;
  ALatLng: TLatLng);
begin
  FRighClickLatLng.Latitude := ALatLng.Latitude;
  FRighClickLatLng.Longitude := ALatLng.Longitude;
  PopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TformMain.OnMapZoom(
  ASender: TObject;
  AZoom: integer);
begin
  Zoom.value := AZoom;
end;

procedure TformMain.FormDestroy(Sender: TObject);
begin
  activeoleControl := nil;
end;

procedure TformMain.FormShow(Sender: TObject);
begin
  ButtonGotoAddressClick(Sender);
end;

procedure TformMain.HideMapButtonClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.HideMap;
end;

procedure TformMain.MapTypeIdComboBoxChange(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapTypeId :=
    TGoogleMapTypeId(MapTypeIdComboBox.ItemIndex);
end;

procedure TformMain.mnuAddMarkerClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.PutMarker(FRighClickLatLng,
    'Added from right click menu');
end;

procedure TformMain.ShowPrintUIButtonClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ShowPrintUI;
end;

procedure TformMain.ShowMapButtonClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.GotoAddress(MemoAddress.Lines.Text);
end;

procedure TformMain.ZoomChange(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapZoom := Zoom.value;
end;

procedure TformMain.ButtonGotoLocationClick(Sender: TObject);
var
  Location: TLatLng;
begin
  Location.Latitude := TEdgeGoogleMapViewer.TextToCoord(Latitude.Text);
  Location.Longitude := TEdgeGoogleMapViewer.TextToCoord(Longitude.Text);
  EdgeGoogleMapViewer.GotoLocation(Location);
end;

procedure TformMain.CheckBoxFullScreenClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapShowFullScreenControl := CheckBoxFullScreen.Checked;
end;

procedure TformMain.CheckBoxMapTypeClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapShowTypeControl := CheckBoxMapType.Checked;
end;

procedure TformMain.CheckBoxZoomClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapShowZoomControl := CheckBoxZoom.Checked;
end;

procedure TformMain.btnClearCirclesClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ClearCircles;
end;

procedure TformMain.btnClearPolygonsClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ClearPolygons;
end;

procedure TformMain.btnClearPolylinesClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.ClearPolylines;
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
begin
  if TEdgeGoogleMapViewer.ApiKey = '' then
  begin
    MessageDlg
      ('Error: you must put your Google API Key into TEdgeGoogleMapViewer: change initialization section!',
      TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  end;
end;

procedure TformMain.EdgeGoogleMapViewerContainsFullScreenElementChanged(
  Sender: TCustomEdgeBrowser;
  ContainsFullScreenElement: Boolean);
begin
  PanelHeader.Visible := not ContainsFullScreenElement;
  BottomPanel.Visible := not ContainsFullScreenElement;
end;

procedure TformMain.EdgeGoogleMapViewerViewerReadyWait(ASender: TObject;
  var AWait: boolean);
begin
 AWait := MessageDlg('Edge browser is not ready, continue to wait.',TMsgDlgType.mtCustom,[TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo],0) = mrYes;
end;

initialization

// Setup UserDataFolder for Temp files
TEdgeGoogleMapViewer.RegisterUserDataFolder(System.IOUtils.TPath.GetTempPath +
  ExtractFileName(ParamStr(0)));
// If you have a Google API Key it's time to setup
// TEdgeGoogleMapViewer.RegisterGoogleMapsApiKey('xyz');

{$WARN SYMBOL_PLATFORM OFF}
ReportMemoryLeaksOnShutdown := DebugHook <> 0;

end.
