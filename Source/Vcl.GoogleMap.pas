{******************************************************************************}
{                                                                              }
{       Delphi Google Map Viewer                                               }
{                                                                              }
{       Copyright (c) 2021 (Ethea S.r.l.)                                      }
{       Author: Carlo Barazzetta                                               }
{       Contributors:                                                          }
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
unit Vcl.GoogleMap;

interface

uses
  //RTL
  System.SysUtils
  , System.Variants
  , System.Classes
  //VCL
  , Vcl.Menus
  , Vcl.Edge
  , WebView2
  , Vcl.Forms
  , WinApi.Windows
  , Vcl.Controls
  , Vcl.StdCtrls
  ;

const
  DEFAULT_ZOOM_FACTOR = 15;

Type
  EGoogleMapError = Exception;

  TGoogleMapTypeId = (mtROADMAP,   //displays the default road map view. This is the default map type.
                      mtSATELLITE, //displays Google Earth satellite images
                      mtHYBRID,    //displays a mixture of normal and satellite views
                      mtTERRAIN);  //displays a physical map based on terrain information.

  TGoogleRouteModeId = (rmDRIVING,
                        rmWALKING,
                        rmBICYCLING,
                        rmTRANSIT);

Const
  ABOUT_BLANK_PAGE = 'about:blank';
  AGoogleMapTypeId : Array[TGoogleMapTypeId] of string =
    ('ROADMAP',
     'SATELLITE',
     'HYBRID',
     'TERRAIN');

  AGoogleRouteModeId : Array[TGoogleRouteModeId] of string =
    ('DRIVING',
     'WALKING',
     'BICYCLING',
     'TRANSIT');

Type
  TLatLng = record
    Latitude: double;
    Longitude: double;
    Description: string;
  end;

  { TEdgeGoogleMapViewer }
  TEdgeGoogleMapViewer = class(TEdgeBrowser)
  strict private
    class var FApiKey: string;
  private
    MapIsBusy: boolean;
    FAddress: string;
    FOverviewMapControl: boolean;
    FTypeControl: boolean;
    FTraffic: boolean;
    FZoom: integer;
    FBicycling: boolean;
    FScaleControl: boolean;
    FZoomControl: boolean;
    FMapTypeId: TGoogleMapTypeId;
    FMapRouteModeId: TGoogleRouteModeId;
    FPanControl: boolean;
    FStreetViewControl: boolean;
    FMapVisible: boolean;
    FMapCenter: TLatLng;
    FMapStart: TLatLng;
    FMapDestination: TLatLng;
    FDestinationAddress: string;
    FStartAddress: string;
    FOnNavigationCompleted: TNavigationCompletedEvent;
    FOnCreateWebViewCompleted: TWebViewStatusEvent;
    FBeforeShowMap: TNotifyEvent;
    FAfterHideMap: TNotifyEvent;
    function ClearAddressText(const Address: string): string;
    procedure SetAddress(const Value: string);
    procedure SetBicycling(const Value: boolean);
    procedure SetMapTypeId(const Value: TGoogleMapTypeId);
    procedure SetOverviewMapControl(const Value: boolean);
    procedure SetPanControl(const Value: boolean);
    procedure SetScaleControl(const Value: boolean);
    procedure SetStreetViewControl(const Value: boolean);
    procedure SetTraffic(const Value: boolean);
    procedure SetTypeControl(const Value: boolean);
    procedure SetZoom(const Value: integer);
    procedure SetZoomControl(const Value: boolean);
    function B2S(value: boolean): string;
    function EmptyLatLng: TLatLng;
    procedure SetVisible(const Value: boolean);
    function GetVisible: boolean;
    procedure InitMap;
    procedure NavigateToURL(const URL: string);
    procedure CustomDocumentComplete(Sender: TCustomEdgeBrowser;
      IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
    procedure CustomWebViewCreateComplete(Sender: TCustomEdgeBrowser; AResult: HResult);
    procedure SetMapCenter(Latitude, Longitude: double; const Description: string);
    procedure SetMapLatitude(const Value: double);
    procedure SetMapLongitude(const Value: double);
    procedure SetMapStartLatitude(const Value: double);
    procedure SetMapStartLongitude(const Value: double);
    procedure SetMapDestinationLatitude(const Value: double);
    procedure SetMapDestinationLongitude(const Value: double);
    procedure AssignMapLatLng(var Coords: TLatLng; Latitude, Longitude: double;
      const Description: string);
    procedure SetMapRouteModeId(const Value: TGoogleRouteModeId);
    procedure CalcRoute(Origin, Destination: TLatLng; RouteMode: TGoogleRouteModeId);
    procedure RoutebyAddress(StartAddress, DestinationAddress: string; RouteMode: TGoogleRouteModeId);
    procedure SetDestinationAddress(const Value: string);
    procedure SetStartAddress(const Value: string);
    procedure SetMapLocationDesc(const Value: string);
    procedure CheckVisibleMap;
  protected
    procedure Loaded; override;
    procedure ShowMap(AMapCenter: TLatLng; const AAddress: string = ''); overload;
  public
    class function TextToCoord(const Value: String): Extended;
    class function CoordToText(const Coord: double): string;
    class procedure RegisterGoogleMapsApiKey(const AApiKey: string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowMap(const AAddress: string) overload;
    procedure HideMap;
    //Goto Method automatically show Map
    procedure GotoLocation(LatLng: TLatLng);
    procedure GotoAddress(const Address: string);
    procedure RouteByLocations;
    procedure RouteByAddresses;
    procedure ShowStreetViewControl(Show: boolean);
    procedure ShowBicycling(Show: boolean);
    procedure ShowTraffic(Show: boolean);
    procedure ClearMarkers;
  published
    property MapShowPanControl: boolean read FPanControl write SetPanControl default true;
    property MapShowZoomControl: boolean read FZoomControl write SetZoomControl default true;
    property MapShowTypeControl: boolean read FTypeControl write SetTypeControl default true;
    property MapShowScaleControl: boolean read FScaleControl write SetScaleControl default true;
    property MapShowStreetViewControl: boolean read FStreetViewControl write SetStreetViewControl default false;
    property MapShowoverviewMapControl: boolean read FOverviewMapControl write SetOverviewMapControl default true;
    property MapAddress: string read FAddress write SetAddress;
    property MapLatitude: double read FMapCenter.Latitude write SetMapLatitude;
    property MapLongitude: double read FMapCenter.Longitude write SetMapLongitude;
    property MapLocationDesc: string read FMapCenter.Description write SetMapLocationDesc;
    property MapStartAddress: string read FStartAddress write SetStartAddress;
    property MapDestinationAddress: string read FDestinationAddress write SetDestinationAddress;
    property MapStartLatitude: double read FMapStart.Latitude write SetMapStartLatitude;
    property MapStartLongitude: double read FMapStart.Longitude write SetMapStartLongitude;
    property MapDestinationLatitude: double read FMapDestination.Latitude write SetMapDestinationLatitude;
    property MapDestinationLongitude: double read FMapDestination.Longitude write SetMapDestinationLongitude;
    property MapZoom: integer read FZoom write SetZoom default DEFAULT_ZOOM_FACTOR;
    property MapTypeId: TGoogleMapTypeId read FMapTypeId write SetMapTypeId default mtROADMAP;
    property MapRouteModeId: TGoogleRouteModeId read FMapRouteModeId write SetMapRouteModeId default rmDRIVING;
    property MapShowTrafficLayer: boolean read FTraffic write SetTraffic default false;
    property MapShowBicyclingLayer: boolean read FBicycling write SetBicycling default false;
    property MapVisible: boolean read GetVisible write SetVisible default false;
    property BeforeShowMap: TNotifyEvent read FBeforeShowMap write FBeforeShowMap;
    property AfterHideMap: TNotifyEvent read FAfterHideMap write FAfterHideMap;
  end;

procedure Register;

implementation

uses
  System.StrUtils
  , System.IOUtils
  ;

{ TEdgeGoogleMapViewer }

class procedure TEdgeGoogleMapViewer.RegisterGoogleMapsApiKey(const AApiKey: string);
begin
  FApiKey := AApiKey;
end;

procedure TEdgeGoogleMapViewer.CustomDocumentComplete(Sender: TCustomEdgeBrowser;
  IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
begin
  MapIsBusy := False;
  if Assigned(FOnNavigationCompleted) then
    FOnNavigationCompleted(Sender, IsSuccess, WebErrorStatus);
end;

procedure TEdgeGoogleMapViewer.CustomWebViewCreateComplete(
  Sender: TCustomEdgeBrowser; AResult: HResult);
begin
  if not self.WebViewCreated then
    raise EGoogleMapError.Create('Error: cannot initilize Google Map Viewer! Check if webview2loader.dll is present');
  if Assigned(FOnCreateWebViewCompleted) then
    FOnCreateWebViewCompleted(Sender, AResult);    
end;

destructor TEdgeGoogleMapViewer.Destroy;
begin
  inherited;
end;

function TEdgeGoogleMapViewer.EmptyLatLng: TLatLng;
begin
  Result.Latitude := 0;
  Result.Longitude := 0;
end;

class function TEdgeGoogleMapViewer.TextToCoord(const Value: String): Extended;
var
  LFormatSettinga: TFormatSettings;
begin
  LFormatSettinga.DecimalSeparator := '.';
  Result := StrToFloat(Value, LFormatSettinga);
end;

class function TEdgeGoogleMapViewer.CoordToText(const Coord: double): string;
begin
  //Format Coordinates to String
  Result := FloatToStrF(Coord, ffFixed, 8, 6);
  Result := StringReplace(Result, ',','.',[]);
end;

function TEdgeGoogleMapViewer.B2S(value: boolean): string;
begin
  if value then
    Result := 'true'
  else
    Result := 'false';
end;

constructor TEdgeGoogleMapViewer.Create(AOwner: TComponent);
begin
  inherited;
  if WebViewCreated then
    DefaultScriptDialogsEnabled := False;
  FMapVisible := false;
  FPanControl := true;
  FZoomControl := true;
  FTypeControl := true;
  FScaleControl := true;
  FOverviewMapControl := true;
  FZoom := DEFAULT_ZOOM_FACTOR;
  FOnNavigationCompleted := OnNavigationCompleted;
  FOnCreateWebViewCompleted := OnCreateWebViewCompleted;

  if not (csDesigning in ComponentState) then
  begin
    OnNavigationCompleted := CustomDocumentComplete;
    OnCreateWebViewCompleted := CustomWebViewCreateComplete;
  end;
end;

function TEdgeGoogleMapViewer.GetVisible: boolean;
begin
  Result := FMapVisible;
end;

function TEdgeGoogleMapViewer.ClearAddressText(const Address: string): string;
begin
  Result := StringReplace(StringReplace(Trim(Address), #13, ' ', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
end;

procedure TEdgeGoogleMapViewer.ClearMarkers;
begin
  ExecuteScript('ClearMarkers()');
end;

procedure TEdgeGoogleMapViewer.ShowMap(AMapCenter: TLatLng; const AAddress: string = '');
const
  HTMLStr: String =
  '<html> '+sLineBreak+
  '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'+sLineBreak+
  '<head> '+sLineBreak+
  '<meta name="viewport" content="initial-scale=1.0, user-scalable=yes" /> '+sLineBreak+
  '<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=%s"></script> '+sLineBreak+
  '<script type="text/javascript"> '+sLineBreak+
  ''+sLineBreak+
  ''+sLineBreak+
  '  var geocoder; '+sLineBreak+
  '  var directionsDisplay; '+sLineBreak+
  '  var directionsService = new google.maps.DirectionsService(); '+sLineBreak+
  '  var map;  '+sLineBreak+
  '  var trafficLayer;'+sLineBreak+
  '  var bikeLayer;'+sLineBreak+
  '  var markersArray = [];'+sLineBreak+
  ''+sLineBreak+
  ''+sLineBreak+
  '  function initialize() { '+sLineBreak+
  '    geocoder = new google.maps.Geocoder();'+sLineBreak+
  '    directionsDisplay = new google.maps.DirectionsRenderer({suppressMarkers: true});'+sLineBreak+
  '    var latlng = new google.maps.LatLng(%s,%s); '+sLineBreak+
  '    var myOptions = { '+sLineBreak+
  '      zoom: %d, '+sLineBreak+
  '      center: latlng, '+sLineBreak+
  '      panControl: %s, '+sLineBreak+
  '      zoomControl: %s, '+sLineBreak+
  '      mapTypeControl: %s, '+sLineBreak+
  '      scaleControl: %s, '+sLineBreak+
  '      streetViewControl: %s, '+sLineBreak+
  '      overviewMapControl: %s, '+sLineBreak+
  '      mapTypeId: google.maps.MapTypeId.%s '+sLineBreak+
  '    }; '+sLineBreak+
  '    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions); '+sLineBreak+
  '    codeAddress(%s);'+sLineBreak+
  '    PutMarker(latlng.lat(), latlng.lng(), %s);'+sLineBreak+
  '    trafficLayer = new google.maps.TrafficLayer();'+sLineBreak+
  '    Traffic(%s);'+sLineBreak+
  '    bikeLayer = new google.maps.BicyclingLayer();'+sLineBreak+
  '    Bicycling(%s);'+sLineBreak+
  '  } '+sLineBreak+
  ''+sLineBreak+
  ''+sLineBreak+
  '  function codeAddress(address) { '+sLineBreak+
  '    if (geocoder) {'+sLineBreak+
  '      geocoder.geocode( { ''address'': address}, function(results, status) { '+sLineBreak+
  '        if (status == google.maps.GeocoderStatus.OK) {'+sLineBreak+
  '          directionsDisplay.setMap(null);'+sLineBreak+
  '          map.setCenter(results[0].geometry.location);'+sLineBreak+
  '          PutMarker(results[0].geometry.location.lat(), results[0].geometry.location.lng(), address);'+sLineBreak+
  '        }'+sLineBreak+
  '      });'+sLineBreak+
  '    }'+sLineBreak+
  '  }'+sLineBreak+
  ''+sLineBreak+
  ''+sLineBreak+
  '  function GotoLatLng(Lat, Lng, Description) { '+sLineBreak+
  '   var latlng = new google.maps.LatLng(Lat,Lng);'+sLineBreak+
  '   directionsDisplay.setMap(null);'+sLineBreak+
  '   map.setCenter(latlng);'+sLineBreak+
  '   PutMarker(Lat, Lng, Description);'+sLineBreak+
  '  }'+sLineBreak+
  ''+sLineBreak+
  ''+sLineBreak+
  'function ClearMarkers() {  '+sLineBreak+
  '  if (markersArray) {        '+sLineBreak+
  '    for (i in markersArray) {  '+sLineBreak+
  '      markersArray[i].setMap(null); '+sLineBreak+
  '    } '+sLineBreak+
  '  } '+sLineBreak+
  '}  '+sLineBreak+
  ''+sLineBreak+
  '  function PutMarker(Lat, Lng, Msg) { '+sLineBreak+
  '   var latlng = new google.maps.LatLng(Lat,Lng);'+sLineBreak+
  '   var marker = new google.maps.Marker({'+sLineBreak+
  '      position: latlng, '+sLineBreak+
  '      map: map,'+sLineBreak+
  '      title: Msg'+sLineBreak+
  '  });'+sLineBreak+
  ' markersArray.push(marker); '+sLineBreak+
  '  }'+sLineBreak+
  ''+sLineBreak+
  '  function Traffic(On)   { if (On) {trafficLayer.setMap(map);} else {trafficLayer.setMap(null);}; }'+sLineBreak+
  ''+sLineBreak+
  '  function Bicycling(On) { if (On) {bikeLayer.setMap(map);} else {bikeLayer.setMap(null);}; }'+sLineBreak+
  ''+sLineBreak+
  '  function StreetViewControl(On) { map.set("streetViewControl", On); }'+sLineBreak+
  ''+sLineBreak+
  '  function SetZoom(zoom) { map.setZoom(zoom); }'+sLineBreak+

  ''+sLineBreak+
  '  function routeByAddress(startAddress, destinationAddress, travelMode) {'+sLineBreak+
  '    var originLat;'+sLineBreak+
  '    var originLng;'+sLineBreak+
  '    var destinationLat;'+sLineBreak+
  '    var destinationLng;'+sLineBreak+
  '    if (geocoder)'+sLineBreak+
  '    { geocoder.geocode( { ''address'': startAddress}, function(results, status) { '+sLineBreak+
  '        if (status == google.maps.GeocoderStatus.OK) {'+sLineBreak+
  '          originLat = results[0].geometry.location.lat();'+sLineBreak+
  '          originLng = results[0].geometry.location.lng();'+sLineBreak+
  '          geocoder.geocode( { ''address'': destinationAddress}, function(results, status) { '+sLineBreak+
  '            if (status == google.maps.GeocoderStatus.OK) {'+sLineBreak+
  '              destinationLat = results[0].geometry.location.lat();'+sLineBreak+
  '              destinationLng = results[0].geometry.location.lng();'+sLineBreak+
  '              calcRoute(originLat, originLng, destinationLat, destinationLng, travelMode, startAddress, destinationAddress);'+sLineBreak+
  '            }'+sLineBreak+
  '          });'+sLineBreak+
  '        }'+sLineBreak+
  '      });'+sLineBreak+
  '    }'+sLineBreak+
  '  }'+sLineBreak+
  ''+sLineBreak+

  ''+sLineBreak+
  '  function calcRoute(originLat, originLng, destinationLat, destinationLng, travelMode, originDesc, destinationDesc) {'+sLineBreak+
  '   var origin_route = new google.maps.LatLng(originLat,originLng);'+sLineBreak+
  '   var destination_route = new google.maps.LatLng(destinationLat,destinationLng);'+sLineBreak+
  '   var request = {'+sLineBreak+
  '       origin: origin_route,'+sLineBreak+
  '       destination: destination_route,'+sLineBreak+
  '       travelMode: google.maps.TravelMode[travelMode]'+sLineBreak+
  '   };'+sLineBreak+
  '   directionsDisplay.setMap(map);'+sLineBreak+
  '   directionsService.route(request, function(response, status) {'+sLineBreak+
  '    if (status == google.maps.DirectionsStatus.OK) {'+sLineBreak+
  '      directionsDisplay.setDirections(response);'+sLineBreak+
  '    }'+sLineBreak+
  '   });'+sLineBreak+
  '   PutMarker(originLat, originLng, originDesc);'+sLineBreak+
  '   PutMarker(destinationLat, destinationLng, destinationDesc);'+sLineBreak+
  '  }'+sLineBreak+
  ''+sLineBreak+

  '</script> '+sLineBreak+
  '</head> '+sLineBreak+
  '<body onload="initialize()"> '+sLineBreak+
  '  <div id="map_canvas" style="width:100%%; height:100%%"></div> '+sLineBreak+
  '</body> '+sLineBreak+
  '</html> ';

var
  HTMLString  : String;
  LAddress, MyAddress, LFileName: string;
  MyCenter: TLatLng;
begin
  if csDesigning in ComponentState then Exit;

  if Assigned(FBeforeShowMap) then
    FBeforeShowMap(Self);

  MyAddress := FAddress;
  MyCenter := FMapCenter;

  //If ask to go to an address then reset the coordinates
  if AAddress <> '' then
  begin
    MyAddress := AAddress;
    MyCenter.Description := '';
    MyCenter.Latitude := 0;
    MyCenter.Longitude := 0;
  end;

  //If ask to go to a location then reset the address
  if (AMapCenter.Latitude <> 0) or (AMapCenter.Longitude <> 0) then
  begin
    MyAddress := '';
    MyCenter.Latitude := AMapCenter.Latitude;
    MyCenter.Longitude := AMapCenter.Longitude;
    MyCenter.Description := AMapCenter.Description;
  end;

  LAddress := ClearAddressText(MyAddress);
  LAddress := StringReplace(LAddress,'''',' ',[rfReplaceAll]);
  HTMLString := Format(HTMLStr,
    [
      FApiKey,
      CoordToText(MyCenter.Latitude), //Latitudine
      CoordToText(MyCenter.Longitude), //Longitudine
      MapZoom, //Zoom
      B2S(FPanControl),
      B2S(FZoomControl),
      B2S(FTypeControl),
      B2S(FScaleControl),
      B2S(FStreetViewControl),
      B2S(FOverviewMapControl),
      AGoogleMapTypeId[FMapTypeId],
      QuotedStr(LAddress),
      QuotedStr(MyCenter.Description),
      B2S(FTraffic), //Traffic
      B2S(FBicycling) //Bicycling
    ]);
  LFileName := TPath.GetTempFileName+'.html';
  TFile.AppendAllText(LFileName, HTMLString, TEncoding.UTF8);
  LFileName := StringReplace(LFileName, '\', '/', [rfReplaceAll]);
  MapIsBusy := True;
  NavigateToURL('file:///'+LFileName);
  FMapVisible := True;
end;

procedure TEdgeGoogleMapViewer.SetAddress(const Value: string);
begin
  FAddress := Value;
  if MapVisible then
    GotoAddress(Value);
end;

procedure TEdgeGoogleMapViewer.SetBicycling(const Value: boolean);
begin
  FBicycling := Value;
  if MapVisible then
    ShowBicycling(Value);
end;

procedure TEdgeGoogleMapViewer.SetDestinationAddress(const Value: string);
begin
  FDestinationAddress := Value;
end;

procedure TEdgeGoogleMapViewer.AssignMapLatLng(var Coords: TLatLng; Latitude, Longitude: double;
  const Description: string);
begin
  if (Latitude > 90) or (Latitude < -90) then
    raise EGoogleMapError.CreateFmt('Latitute must be from %d to %d',[-90, 90]);
  if (Longitude > 180) or (Longitude < -180) then
    raise EGoogleMapError.CreateFmt('Longitude must be from %d to %d',[-180, 180]);
  Coords.Latitude := Latitude;
  Coords.Longitude := Longitude;
  Coords.Description := Description;
end;

procedure TEdgeGoogleMapViewer.SetMapCenter(Latitude, Longitude: double;
  const Description: string);
begin
  AssignMapLatLng(FMapCenter, Latitude, Longitude, Description);
  if ((Latitude <> 0) or (Longitude <> 0)) and (MapVisible) then
    GotoLocation(FMapCenter);
end;

procedure TEdgeGoogleMapViewer.SetMapLatitude(const Value: double);
begin
  SetMapCenter(Value, FMapCenter.Longitude, FMapCenter.Description);
end;

procedure TEdgeGoogleMapViewer.SetMapLocationDesc(const Value: string);
begin
  SetMapCenter(FMapCenter.Latitude, FMapCenter.Longitude, Value);
end;

procedure TEdgeGoogleMapViewer.SetMapLongitude(const Value: double);
begin
  SetMapCenter(FMapCenter.Latitude, Value, FMapCenter.Description);
end;

procedure TEdgeGoogleMapViewer.SetMapStartLatitude(const Value: double);
begin
  AssignMapLatLng(FMapStart, Value, FMapStart.Longitude, FMapStart.Description);
end;

procedure TEdgeGoogleMapViewer.SetMapStartLongitude(const Value: double);
begin
  AssignMapLatLng(FMapStart, FMapStart.Latitude, Value, FMapStart.Description);
end;

procedure TEdgeGoogleMapViewer.SetMapDestinationLatitude(const Value: double);
begin
  AssignMapLatLng(FMapDestination, Value, FMapDestination.Longitude, FMapDestination.Description);
end;

procedure TEdgeGoogleMapViewer.SetMapDestinationLongitude(const Value: double);
begin
  AssignMapLatLng(FMapDestination, FMapDestination.Latitude, Value, FMapDestination.Description);
end;

procedure TEdgeGoogleMapViewer.SetMapTypeId(const Value: TGoogleMapTypeId);
var
  ScriptCommand: String;
begin
  FMapTypeId := Value;
  ScriptCommand := Format('map.setMapTypeId(google.maps.MapTypeId.%s);',[AGoogleMapTypeId[FMapTypeId]]);
  ExecuteScript(ScriptCommand);
end;

procedure TEdgeGoogleMapViewer.HideMap;
begin
  InitMap;
  FMapVisible := False;

  if Assigned(FAfterHideMap) then
    FAfterHideMap(Self);
end;

procedure TEdgeGoogleMapViewer.InitMap;
begin
  if csDesigning in ComponentState then
    Exit;
  Self.Navigate(ABOUT_BLANK_PAGE);
end;

procedure TEdgeGoogleMapViewer.Loaded;
begin
  inherited;
  InitMap;
  SetVisible(MapVisible);
end;

procedure StringToStreamBOM(const S: string; const Stm: TStream;
  const Encoding: TEncoding);
var
  Bytes: TBytes;
  Preamble: TBytes;
begin
  Assert(Assigned(Encoding));
  Bytes := Encoding.GetBytes(S);
  Preamble := Encoding.GetPreamble;
  if Length(Preamble) > 0 then
    Stm.WriteBuffer(Preamble[0], Length(Preamble));
  Stm.WriteBuffer(Bytes[0], Length(Bytes));
end;

procedure TEdgeGoogleMapViewer.NavigateToURL(const URL: string);
begin
  Navigate(URL);
end;

procedure TEdgeGoogleMapViewer.RoutebyAddress(StartAddress,
  DestinationAddress: string; RouteMode: TGoogleRouteModeId);
var
  ScriptCommand: String;
begin
  if not MapVisible then
  begin
    ShowMap(EmptyLatLng);
    while MapIsBusy do
      Sleep(10);
  end;
  ScriptCommand := Format('routeByAddress(%s, %s, %s)',[
    QuotedStr(ClearAddressText(StartAddress)),
    QuotedStr(ClearAddressText(DestinationAddress)),
    QuotedStr(AGoogleRouteModeId[RouteMode])
    ]);
  ExecuteScript(ScriptCommand);
end;

procedure TEdgeGoogleMapViewer.SetVisible(const Value: boolean);
begin
  if not (csDesigning in ComponentState) then
  begin
    if Value then
      ShowMap(EmptyLatLng)
    else
      HideMap;
  end
  else
    FMapVisible := Value;
end;

procedure TEdgeGoogleMapViewer.SetOverviewMapControl(const Value: boolean);
begin
  FOverviewMapControl := Value;
  if MapVisible then
    ShowMap(EmptyLatLng);
end;

procedure TEdgeGoogleMapViewer.SetPanControl(const Value: boolean);
begin
  FPanControl := Value;
  if MapVisible then
    ShowMap(EmptyLatLng);
end;

procedure TEdgeGoogleMapViewer.SetMapRouteModeId(const Value: TGoogleRouteModeId);
begin
  FMapRouteModeId := Value;
  //SetMapRouting(FMapStart, FMapDestination, FMapRouteModeId);
end;

procedure TEdgeGoogleMapViewer.SetScaleControl(const Value: boolean);
begin
  FScaleControl := Value;
  if MapVisible then
    ShowMap(EmptyLatLng);
end;

procedure TEdgeGoogleMapViewer.SetStartAddress(const Value: string);
begin
  FStartAddress := Value;
end;

procedure TEdgeGoogleMapViewer.SetStreetViewControl(const Value: boolean);
begin
  FStreetViewControl := Value;
  if MapVisible then
    ShowStreetViewControl(Value);
end;

procedure TEdgeGoogleMapViewer.SetTraffic(const Value: boolean);
begin
  FTraffic := Value;
  if MapVisible then
    ShowTraffic(Value);
end;

procedure TEdgeGoogleMapViewer.SetTypeControl(const Value: boolean);
begin
  FTypeControl := Value;
  if MapVisible then
    ShowMap(EmptyLatLng);
end;

procedure TEdgeGoogleMapViewer.SetZoom(const Value: integer);
begin
  FZoom := Value;
  ExecuteScript(Format('SetZoom(%d)',[Value]));
end;

procedure TEdgeGoogleMapViewer.SetZoomControl(const Value: boolean);
begin
  FZoomControl := Value;
end;

procedure TEdgeGoogleMapViewer.GotoLocation(LatLng: TLatLng);
var
  ScriptCommand: String;
begin
  //Se le coordinate non hanno descrizione diventano le coordinate stesse
  if LatLng.Description = '' then
    LatLng.Description := Format('[%s]:[%s]',
      [CoordToText(LatLng.Latitude),CoordToText(LatLng.Longitude)]);
  if (LatLng.Latitude=0) and (LatLng.Longitude=0) then
    HideMap
  else if not MapVisible then
    ShowMap(LatLng)
  else
  begin
    ScriptCommand := Format('GotoLatLng(%s,%s,%s)',[
      CoordToText(LatLng.Latitude),
      CoordToText(LatLng.Longitude),
      QuotedStr(LatLng.Description)
      ]);
    ExecuteScript(ScriptCommand);
  end;
end;

procedure TEdgeGoogleMapViewer.CalcRoute(Origin, Destination: TLatLng;
  RouteMode: TGoogleRouteModeId);
var
  ScriptCommand: String;
begin
  if not MapVisible then
  begin
    ShowMap(EmptyLatLng);
    while MapIsBusy do
      Sleep(10);
  end;
  ScriptCommand := Format('calcRoute(%s, %s, %s, %s, %s)',[
    CoordToText(Origin.Latitude),
    CoordToText(Origin.Longitude),
    CoordToText(Destination.Latitude),
    CoordToText(Destination.Longitude),
    QuotedStr(AGoogleRouteModeId[RouteMode])
    ]);
  ExecuteScript(ScriptCommand);
end;

procedure TEdgeGoogleMapViewer.CheckVisibleMap;
begin
  if not MapVisible then
    raise EGoogleMapError.Create('Cannot Route to invisible Map!');
end;

procedure TEdgeGoogleMapViewer.GotoAddress(const Address: string);
var
  ScriptCommand: String;
begin
  FAddress := Address;
  if FAddress = '' then
    HideMap
  else if not MapVisible then
    ShowMap(FAddress)
  else
  begin
    ScriptCommand := Format('codeAddress(%s)',[QuotedStr(ClearAddressText(Address))]);
    ExecuteScript(ScriptCommand);
  end;
end;

procedure TEdgeGoogleMapViewer.ShowStreetViewControl(Show: boolean);
begin
  FStreetViewControl := Show;
  ExecuteScript(Format('StreetViewControl(%s)',[B2S(FStreetViewControl)]));
end;

procedure TEdgeGoogleMapViewer.ShowBicycling(Show: boolean);
begin
  FBicycling := Show;
  ExecuteScript(Format('Bicycling(%s)',[B2S(FBicycling)]));
end;

procedure TEdgeGoogleMapViewer.ShowMap(const AAddress: string);
begin
  ShowMap(EmptyLatLng, AAddress);
end;

procedure TEdgeGoogleMapViewer.RouteByAddresses;
begin
  CheckVisibleMap;
  if (FStartAddress <> '') and (FDestinationAddress <> '') then
    RouteByAddress(FStartAddress, FDestinationAddress, FMapRouteModeId);
end;

procedure TEdgeGoogleMapViewer.RouteByLocations;
begin
  CheckVisibleMap;
  if (FMapStart.Latitude <> 0) and (FMapStart.Longitude <> 0) and
     (FMapDestination.Latitude <> 0) or (FMapDestination.Longitude <> 0) then
    CalcRoute(FMapStart, FMapDestination, FMapRouteModeId);
end;

procedure TEdgeGoogleMapViewer.ShowTraffic(Show: boolean);
begin
  FTraffic := Show;
  ExecuteScript(Format('Traffic(%s)',[B2S(FTraffic)]));
end;

procedure Register;
begin
  RegisterComponents('ISControls', [TEdgeGoogleMapViewer]);
end;

end.
