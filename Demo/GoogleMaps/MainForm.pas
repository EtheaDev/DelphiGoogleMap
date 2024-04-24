{******************************************************************************}
{                                                                              }
{       Delphi Google Map Viewer Demo                                          }
{                                                                              }
{       Copyright (c) 2021-2024 (Ethea S.r.l.)                                 }
{       Author: Carlo Barazzetta                                               }
{       Contributors:                                                          }
{         littleearth (https://github.com/littleearth)                         }
{         chaupero (https://github.com/chaupero)                               }
{                                                                              }
{       https://github.com/EtheaDev/DelphiGoogleMap                            }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Licensed under the Apache License, Version 2.0 (the "License");             }
{  you may not use this file except in compliance with the License.            }
{  You may obtain a copy of the License at                                     }
{                                                                              }
{      http://www.apache.org/licenses/LICENSE-2.0                              }
{                                                                              }
{  Unless required by applicable law or agreed to in writing, software         }
{  distributed under the License is distributed on an "AS IS" BASIS,           }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    }
{  See the License for the specific language governing permissions and         }
{  limitations under the License.                                              }
{                                                                              }
{******************************************************************************}
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
    ShowPrintUIButton: TButton;
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
    Button1: TButton;
    Panel1: TPanel;
    FileEdit: TEdit;
    Label7: TLabel;
    LabelLatitude: TLabel;
    Latitude: TEdit;
    PageControlMarker: TPageControl;
    LatLongMarkerTabSheet: TTabSheet;
    TabSheetLabelAnimation: TTabSheet;
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
    TabSheetInformation: TTabSheet;
    Panel7: TPanel;
    Label13: TLabel;
    MapTypeIdComboBox: TComboBox;
    comboMarkerAnimation: TComboBox;
    btnAddMarker: TButton;
    TabSheetCustom: TTabSheet;
    cbMarkerCustom: TCheckBox;
    memoMarkerCustomJSON: TMemo;
    Label14: TLabel;
    memoMarkerInformation: TMemo;
    cbCenterOnClick: TCheckBox;
    mnuAddMarker: TMenuItem;
    mapControlGroupBox: TGroupBox;
    CheckBoxTraffic: TCheckBox;
    CheckBoxBicycling: TCheckBox;
    CheckBoxStreeView: TCheckBox;
    CheckBoxFullScreen: TCheckBox;
    CheckBoxZoom: TCheckBox;
    BottomPanel: TPanel;
    CheckBoxMapType: TCheckBox;
    PageControlCircle: TPageControl;
    TabSheet1: TTabSheet;
    GridPanel3: TGridPanel;
    GridPanel4: TGridPanel;
    Panel4: TPanel;
    Label15: TLabel;
    eCircleLat: TEdit;
    Panel8: TPanel;
    Label16: TLabel;
    eCircleLng: TEdit;
    Panel9: TPanel;
    TabSheet2: TTabSheet;
    Panel10: TPanel;
    TabSheet3: TTabSheet;
    Label20: TLabel;
    Label21: TLabel;
    eCircleRadius: TEdit;
    chkCircleEditable: TCheckBox;
    chkCircleDraggable: TCheckBox;
    chkCicleClickable: TCheckBox;
    chkCircleVisible: TCheckBox;
    eCircleInfo: TMemo;
    TabSheet4: TTabSheet;
    Label17: TLabel;
    eCircleStrokeColor: TEdit;
    Label18: TLabel;
    eCircleStrokeOpacity: TEdit;
    Label19: TLabel;
    eCircleStrokeWeight: TEdit;
    Label22: TLabel;
    eCircleFillColor: TEdit;
    eCircleFillOpacity: TEdit;
    Label23: TLabel;
    PCDrawing: TPageControl;
    TabMarkers: TTabSheet;
    TabCircles: TTabSheet;
    TabPolylines: TTabSheet;
    PageControlPolyline: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Panel14: TPanel;
    chkPolylineEditable: TCheckBox;
    chkPolylineGeodesic: TCheckBox;
    chkPolylineClickable: TCheckBox;
    chkPolylineVisible: TCheckBox;
    TabSheet7: TTabSheet;
    Label27: TLabel;
    Label29: TLabel;
    ePolylineStrokeColor: TEdit;
    ePolylineStrokeOpacity: TEdit;
    ePolylineStrokeWeight: TEdit;
    TabSheet8: TTabSheet;
    Label32: TLabel;
    ePolylineInfo: TMemo;
    ePolylinePath: TMemo;
    Label28: TLabel;
    chkPolylineFitBounds: TCheckBox;
    GroupBoxDrawing: TGroupBox;
    Polygons: TTabSheet;
    PageControlPolygon: TPageControl;
    TabSheet9: TTabSheet;
    ePolygonPath: TMemo;
    TabSheet10: TTabSheet;
    Panel11: TPanel;
    chkPolygonEditable: TCheckBox;
    chkPolygonClickable: TCheckBox;
    chkPolygonVisible: TCheckBox;
    chkPolygonFitBounds: TCheckBox;
    TabSheet11: TTabSheet;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    ePolygonStrokeColor: TEdit;
    ePolygonStrokeOpacity: TEdit;
    ePolygonStrokeWeight: TEdit;
    TabSheet12: TTabSheet;
    Label30: TLabel;
    ePolygonInfo: TMemo;
    Label31: TLabel;
    ePolygonFillColor: TEdit;
    Label33: TLabel;
    ePolygonFillOpacity: TEdit;
    Panel12: TPanel;
    ButtonClearMarkers: TButton;
    chMarkerShowHide: TCheckBox;
    Panel13: TPanel;
    chCirclesShowHide: TCheckBox;
    btnAddCircle: TButton;
    Panel15: TPanel;
    chPolylinesShowHide: TCheckBox;
    Panel16: TPanel;
    chPolygonsShowHide: TCheckBox;
    btnClearCircles: TButton;
    btnAddPolyline: TButton;
    btnClearPolylines: TButton;
    btnAddPolygon: TButton;
    btnClearPolygons: TButton;
    TabSheet13: TTabSheet;
    GroupBox3: TGroupBox;
    Label34: TLabel;
    eGeometryFromLat: TEdit;
    Label35: TLabel;
    eGeometryFromLng: TEdit;
    Label36: TLabel;
    eGeometryToLat: TEdit;
    Label37: TLabel;
    eGeometryToLng: TEdit;
    btnGeometryComputeDistanceBetween: TButton;
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
    procedure mnuAddMarkerClick(Sender: TObject);
    procedure CheckBoxFullScreenClick(Sender: TObject);
    procedure CheckBoxZoomClick(Sender: TObject);
    procedure EdgeGoogleMapViewerContainsFullScreenElementChanged(
      Sender: TCustomEdgeBrowser; ContainsFullScreenElement: Boolean);
    procedure CheckBoxMapTypeClick(Sender: TObject);
    procedure btnAddCircleClick(Sender: TObject);
    procedure btnClearCirclesClick(Sender: TObject);
    procedure btnClearPolylinesClick(Sender: TObject);
    procedure btnAddPolylineClick(Sender: TObject);
    procedure btnClearPolygonsClick(Sender: TObject);
    procedure btnAddPolygonClick(Sender: TObject);
    procedure chMarkerShowHideClick(Sender: TObject);
    procedure chCirclesShowHideClick(Sender: TObject);
    procedure chPolylinesShowHideClick(Sender: TObject);
    procedure chPolygonsShowHideClick(Sender: TObject);
    procedure btnGeometryComputeDistanceBetweenClick(Sender: TObject);
  private
    FRighClickLatLng : TLatLng;
    procedure OnMapClick(ASender: TObject; ALatLng : TLatLng);
    procedure OnMapRightClick(ASender: TObject; ALatLng : TLatLng);
    procedure OnMapZoom(ASender: TObject; AZoom : integer);
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

uses
  System.IOUtils, Vcl.Dialogs, SecondaryForm;

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

  //Init checkboxes based on Component Proprerties
  CheckBoxTraffic.Checked := EdgeGoogleMapViewer.MapShowTrafficLayer;
  CheckBoxBicycling.Checked := EdgeGoogleMapViewer.MapShowBicyclingLayer;
  CheckBoxStreeView.Checked := EdgeGoogleMapViewer.MapShowStreetViewControl;
  CheckBoxDirectionPanel.Checked := EdgeGoogleMapViewer.MapShowDirectionsPanel;
  CheckBoxFullScreen.Checked := EdgeGoogleMapViewer.MapShowFullScreenControl;
  CheckBoxZoom.Checked := EdgeGoogleMapViewer.MapShowZoomControl;
  CheckBoxMapType.Checked := EdgeGoogleMapViewer.MapShowTypeControl;

  MemoAddress.Lines.Text := EdgeGoogleMapViewer.MapAddress;
  Latitude.Text := TEdgeGoogleMapViewer.CoordToText(EdgeGoogleMapViewer.MapLatitude);
  Longitude.Text := TEdgeGoogleMapViewer.CoordToText(EdgeGoogleMapViewer.MapLongitude);
  editMarkerLat.Text := TEdgeGoogleMapViewer.CoordToText(-31.9523);
  editMarkerLng.Text  := TEdgeGoogleMapViewer.CoordToText(115.8613);
  editMarkerDescription.Text := 'Perth, Western Australia';
  editMarkerLabel.Text := 'Here';
  eCircleLat.Text := TEdgeGoogleMapViewer.CoordToText(-31.9523);
  eCircleLng.Text  := TEdgeGoogleMapViewer.CoordToText(115.8613);
  eCircleRadius.text:='23';
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
  EdgeGoogleMapViewer.OnMapClick := OnMapClick;
  EdgeGoogleMapViewer.OnMapRightClick := OnMapRightClick;
  EdgeGoogleMapViewer.OnMapZoom := OnMapZoom;
end;

procedure TformMain.OnMapClick(ASender : TObject;  ALatLng : TLatLng);
begin
  if cbCenterOnClick.Checked then
  begin
    EdgeGoogleMapViewer.GotoLocation(ALatLng, False)
  end;
end;

procedure TformMain.OnMapRightClick(ASender : TObject; ALatLng : TLatLng);
begin
  FRighClickLatLng.Latitude := ALatLng.Latitude;
  FRighClickLatLng.Longitude := ALatLng.Longitude;
  PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TformMain.OnMapZoom(ASender: TObject; AZoom: integer);
begin
  Zoom.Value := AZoom;
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

procedure TformMain.LoadTableButtonClick(Sender: TObject);
begin
  cdsCustomers.LoadFromFile(FileEdit.Text);
end;

procedure TformMain.MapTypeIdComboBoxChange(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapTypeId := TGoogleMapTypeId(MapTypeIdComboBox.ItemIndex);
end;

procedure TformMain.mnuAddMarkerClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.PutMarker(FRighClickLatLng,'Added from right click menu');
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

procedure TformMain.CheckBoxFullScreenClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapShowFullScreenControl :=
    CheckBoxFullScreen.Checked;
end;

procedure TformMain.CheckBoxMapTypeClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapShowTypeControl :=
    CheckBoxMapType.Checked;
end;

procedure TformMain.CheckBoxZoomClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.MapShowZoomControl :=
    CheckBoxZoom.Checked;
end;

procedure TformMain.chMarkerShowHideClick(Sender: TObject);
begin
    if chMarkerShowHide.Checked then
        EdgeGoogleMapViewer.ShowMarkers
    else
        EdgeGoogleMapViewer.HideMarkers;
end;

procedure TformMain.chPolygonsShowHideClick(Sender: TObject);
begin
    if chPolygonsShowHide.Checked then
        EdgeGoogleMapViewer.ShowPolygons
    else
        EdgeGoogleMapViewer.HidePolygons;
end;

procedure TformMain.chPolylinesShowHideClick(Sender: TObject);
begin
    if chPolylinesShowHide.Checked then
        EdgeGoogleMapViewer.ShowPolylines
    else
        EdgeGoogleMapViewer.HidePolylines;
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


procedure TformMain.btnAddCircleClick(Sender: TObject);
var
  LLatLng : TLatLng;
begin
  LLatLng.Latitude := TEdgeGoogleMapViewer.TextToCoord(eCircleLat.Text);
  LLatLng.Longitude := TEdgeGoogleMapViewer.TextToCoord(eCircleLng.Text);
  EdgeGoogleMapViewer.GotoLocation(LLatLng, false);
  EdgeGoogleMapViewer.PutCircle(
                            LLatLng,
                            TEdgeGoogleMapViewer.TextToCoord(eCircleRadius.text),
                            chkCircleEditable.Checked,
                            chkCircleDraggable.Checked,
                            chkCircleVisible.Checked,
                            chkCicleClickable.Checked,
                            eCircleStrokeColor.Text,
                            TEdgeGoogleMapViewer.TextToCoord(eCircleStrokeOpacity.text),
                            strtoint(eCircleStrokeWeight.text),
                            eCircleFillColor.Text,
                            TEdgeGoogleMapViewer.TextToCoord(eCircleFillOpacity.text),
                            eCircleInfo.Text);
end;


procedure TformMain.btnAddMarkerClick(Sender: TObject);
var
  LLatLng : TLatLng;
  LCustomJSON : string;
  LAnimation : TGoogleMarkerAnimationId;
begin
  LLatLng.Latitude := TEdgeGoogleMapViewer.TextToCoord(editMarkerLat.Text);
  LLatLng.Longitude := TEdgeGoogleMapViewer.TextToCoord(editMarkerLng.Text);
  LAnimation := TGoogleMarkerAnimationId(comboMarkerAnimation.ItemIndex);
  LCustomJSON := '';
  if cbMarkerCustom.Checked then
    begin
      LCustomJSON := memoMarkerCustomJSON.Lines.Text;
    end;
  EdgeGoogleMapViewer.GotoLocation(LLatLng);
  EdgeGoogleMapViewer.PutMarker(LLatLng,editMarkerDescription.Text, LAnimation ,editMarkerLabel.Text, memoMarkerInformation.Lines.Text, LCustomJSON);
end;

procedure TformMain.btnAddPolygonClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.PutPolygon(
                      ePolygonPath.lines.Text,
                      chkPolygonEditable.Checked,
                      chkPolygonVisible.Checked,
                      chkPolygonClickable.Checked,
                      chkPolygonFitBounds.Checked,
                      ePolygonStrokeColor.Text,
                      strtofloat(ePolygonStrokeOpacity.text),
                      strtoint(ePolygonStrokeWeight.text),
                      ePolygonFillColor.Text,
                      strtofloat(ePolygonFillOpacity.text),
                      ePolygonInfo.Text);
end;
procedure TformMain.btnAddPolylineClick(Sender: TObject);
begin
  EdgeGoogleMapViewer.PutPolyline(
                      ePolylinePath.lines.Text,
                      chkPolylineGeodesic.Checked,
                      chkPolylineEditable.Checked,
                      chkPolylineVisible.Checked,
                      chkPolylineClickable.Checked,
                      chkPolylineFitBounds.Checked,
                      ePolylineStrokeColor.Text,
                      strtofloat(ePolylineStrokeOpacity.text),
                      strtoint(ePolylineStrokeWeight.text),
                      ePolylineInfo.Text);
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

procedure TformMain.btnGeometryComputeDistanceBetweenClick(Sender: TObject);
var
  FromLatLng, ToLatLng : TLatLng;
  Distance:Double;
begin
  FromLatLng.Latitude := TEdgeGoogleMapViewer.TextToCoord(eGeometryFromLat.Text);
  FromLatLng.Longitude := TEdgeGoogleMapViewer.TextToCoord(eGeometryFromLng.Text);
  ToLatLng.Latitude := TEdgeGoogleMapViewer.TextToCoord(eGeometryToLat.Text);
  ToLatLng.Longitude := TEdgeGoogleMapViewer.TextToCoord(eGeometryToLng.Text);

  Distance := EdgeGoogleMapViewer.ComputeDistanceBetween(FromLatLng,ToLatLng);
  ShowMessageFmt('Distance %8.2f mts',[Distance]);
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

procedure TformMain.chCirclesShowHideClick(Sender: TObject);
begin
    if chCirclesShowHide.Checked then
        EdgeGoogleMapViewer.ShowCircles
    else
        EdgeGoogleMapViewer.HideCircles;
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
begin
  if TEdgeGoogleMapViewer.ApiKey = '' then
    raise Exception.Create('Error: you must put your Google API Key into TEdgeGoogleMapViewer: change initialization section!');
end;

procedure TformMain.EdgeGoogleMapViewerContainsFullScreenElementChanged(
  Sender: TCustomEdgeBrowser; ContainsFullScreenElement: Boolean);
begin
  PanelHeader.Visible := not ContainsFullScreenElement;
  BottomPanel.Visible := not ContainsFullScreenElement;
  DBGrid.Visible := not ContainsFullScreenElement;
  DBGrid.Top := BottomPanel.Top -1;
end;

initialization
  //Setup UserDataFolder for Temp files
  TEdgeGoogleMapViewer.RegisterUserDataFolder(System.IOUtils.TPath.GetTempPath+ExtractFileName(ParamStr(0)));
  //If you have a Google API Key it's time to setup
  //TEdgeGoogleMapViewer.RegisterGoogleMapsApiKey('xyz');

  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

end.
