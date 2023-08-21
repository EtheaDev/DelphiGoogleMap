{******************************************************************************}
{                                                                              }
{       Delphi Google Map Viewer                                               }
{                                                                              }
{       Copyright (c) 2021-2023 (Ethea S.r.l.)                                 }
{       Author: Carlo Barazzetta                                               }
{       Contributors:                                                          }
{         littleearth (https://github.com/littleearth)                         }
{         tbegsr (https://github.com/tbegsr)                                   }
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
  DelphiGoogleMapViewerVersion = '1.5.0';

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

  TGoogleMarkerAnimationId = (maNONE,
                        maBOUNCE,
                        maDROP);

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

  AGoogleMarkerAnimationId : Array[TGoogleMarkerAnimationId] of string =
    ('null',
     'BOUNCE',
     'DROP');

Type
  TLatLng = record
    Latitude: double;
    Longitude: double;
    Description: string;
  end;

  TEdgeGoogleMapViewHTMLBody = procedure(ASender : TObject; var AHTML : string) of object;
  TEdgeGoogleMapViewJavascript = procedure(ASender : TObject; var AJavascript : string) of object;
  TEdgeGoogleMapViewMapClick = procedure(ASender : TObject;  ALatLng : TLatLng) of object;
  TEdgeGoogleMapViewZoomChanged = procedure(ASender : TObject;  AZoom : integer) of object;

  { TEdgeGoogleMapViewer }
  TEdgeGoogleMapViewer = class(TCustomEdgeBrowser)
  strict private
    class var FApiKey: string;
    class var FUserDataFolder: string;
  private
    MapIsBusy: boolean;
    FAddress: string;
    FOverviewMapControl: boolean;
    FTypeControl: boolean;
    FFullScreenControl: boolean;
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
    FBeforeInitMap: TNotifyEvent;
    FOnGetHTMLBody: TEdgeGoogleMapViewHTMLBody;
    FMapShowDirectionsPanel : boolean;
    FOnGetJavascript: TEdgeGoogleMapViewJavascript;
    FOnWebUnhandledMessageReceived: TWebMessageReceivedEvent;
    FOnMapClick: TEdgeGoogleMapViewMapClick;
    FOnMapRightClick: TEdgeGoogleMapViewMapClick;
    FOnMapZoom: TEdgeGoogleMapViewZoomChanged;
    function ClearAddressText(const Address: string): string;
    procedure SetAddress(const Value: string);
    procedure SetBicycling(const Value: boolean);
    procedure SetMapTypeId(const Value: TGoogleMapTypeId);
    procedure SetOverviewMapControl(const Value: boolean);
    procedure SetPanControl(const Value: boolean);
    procedure SetScaleControl(const Value: boolean);
    procedure SetFullScreenControl(const Value: boolean);
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
    procedure SetOnGetHTMLBody(const Value: TEdgeGoogleMapViewHTMLBody);
    procedure SetMapShowDirectionsPanel(const Value: boolean);
    procedure SetOnGetJavascript(const Value: TEdgeGoogleMapViewJavascript);
    procedure SetOnWebUnhandledMessageReceived(
      const Value: TWebMessageReceivedEvent);
    procedure SetOnMapClick(const Value: TEdgeGoogleMapViewMapClick);
    procedure SetOnMapRightClick(const Value: TEdgeGoogleMapViewMapClick);
    procedure SetOnMapZoom(const Value: TEdgeGoogleMapViewZoomChanged);
  protected
    procedure Loaded; override;
    procedure ShowMap(AMapCenter: TLatLng; const AAddress: string = ''); overload;
    function GetHTMLHeader: string; virtual;
    function GetHTMLStyle : string; virtual;
    function GetHTMLScript: string; virtual;
    function GetHTMLBody : string; virtual;
    function GetJSInitialize: string; virtual;
    function GetJSVariables: string; virtual;
    function GetJSCodeAddress: string;virtual;
    function GetJSGotoLatLng: string; virtual;
    function GetJSClearMakers: string; virtual;
    function GetJSPutMarker: string; virtual;
    function GetJSPutCustomMarker: string; virtual;
    function GetJSMapOptions: string; virtual;
    function GetJSMapShowDirectionsPanel: string;
    function GetJSRouteAddress: string;
    function GetJSCalcRoute: string;
    function StripCRLF(AValue: string; AReplaceWith: string = ' '): string;
    procedure CustomWebMessageReceived(ASender: TCustomEdgeBrowser; Args: TWebMessageReceivedEventArgs); virtual;
    function HandleWebMessageEvent(AEvent: string): boolean;
  public
    class function TextToCoord(const Value: String): Extended;
    class function CoordToText(const Coord: double): string;
    class procedure RegisterGoogleMapsApiKey(const AApiKey: string);
    class procedure RegisterUserDataFolder(const ATempFolder: string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowPrintUI;
    function DefaultCustomMarkerJSON: string;
    procedure ShowMap(const AAddress: string) overload;
    procedure HideMap;
    function JSONEncodeString(const AText: string): string;
    //Goto Method automatically show Map
    procedure GotoLocation(LatLng: TLatLng; AAddMarker : boolean = true);
    procedure GotoAddress(const Address: string);
    procedure RouteByLocations;
    procedure RouteByAddresses;
    procedure ShowStreetViewControl(Show: boolean);
    procedure ShowBicycling(Show: boolean);
    procedure ShowTraffic(Show: boolean);
    procedure ShowDirectionsPanel(const Value: boolean);
    procedure ShowZoomControl(Show: boolean);
    procedure ShowMapTypeControl(Show: boolean);
    procedure ShowFullScreenControl(Show: boolean);
    procedure PutMarker(LatLng: TLatLng; ADescription : string; AAnimation : TGoogleMarkerAnimationId = maNONE;
      ALabel : string = ''; AInfoWindowContent : string = ''; ACustomMarkerJSON : string = '');
    procedure ClearMarkers;
    class property ApiKey: string read FApiKey;
  published
    property Align;
    property Anchors;
    property TabOrder;
    property TabStop;
    property OnEnter;
    property OnExit;
    property OnCapturePreviewCompleted;
    property OnContainsFullScreenElementChanged;
    property OnContentLoading;
    property OnCreateWebViewCompleted;
    property OnDevToolsProtocolEventReceived;
    property OnDocumentTitleChanged;
    property OnExecuteScript;
    property OnFrameNavigationStarting;
    property OnFrameNavigationCompleted;
    property OnHistoryChanged;
    property OnNavigationStarting;
    property OnNavigationCompleted;
    property OnNewWindowRequested;
    property OnPermissionRequested;
    property OnProcessFailed;
    property OnScriptDialogOpening;
    property OnSourceChanged;
    // property OnWebMessageReceived;
    property OnWebResourceRequested;
    property OnWindowCloseRequested;
    property OnZoomFactorChanged;
    // Custom properties
    property MapShowPanControl: boolean read FPanControl write SetPanControl default true;
    property MapShowZoomControl: boolean read FZoomControl write SetZoomControl default true;
    property MapShowTypeControl: boolean read FTypeControl write SetTypeControl default true;
    property MapShowScaleControl: boolean read FScaleControl write SetScaleControl default true;
    property MapShowFullScreenControl: boolean read FFullScreenControl write SetFullScreenControl default true;
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
    property MapShowDirectionsPanel : boolean read FMapShowDirectionsPanel write SetMapShowDirectionsPanel default false;
    property MapZoom: integer read FZoom write SetZoom default DEFAULT_ZOOM_FACTOR;
    property MapTypeId: TGoogleMapTypeId read FMapTypeId write SetMapTypeId default mtROADMAP;
    property MapRouteModeId: TGoogleRouteModeId read FMapRouteModeId write SetMapRouteModeId default rmDRIVING;
    property MapShowTrafficLayer: boolean read FTraffic write SetTraffic default false;
    property MapShowBicyclingLayer: boolean read FBicycling write SetBicycling default false;
    property MapVisible: boolean read GetVisible write SetVisible default false;
    property BeforeInitMap: TNotifyEvent read FBeforeInitMap write FBeforeInitMap;
    property BeforeShowMap: TNotifyEvent read FBeforeShowMap write FBeforeShowMap;
    property AfterHideMap: TNotifyEvent read FAfterHideMap write FAfterHideMap;
    property OnGetHTMLBody : TEdgeGoogleMapViewHTMLBody read FOnGetHTMLBody write SetOnGetHTMLBody;
    property OnGetJavascript : TEdgeGoogleMapViewJavascript read FOnGetJavascript write SetOnGetJavascript;
    property OnWebUnhandledMessageReceived : TWebMessageReceivedEvent read FOnWebUnhandledMessageReceived write SetOnWebUnhandledMessageReceived;
    property OnMapClick : TEdgeGoogleMapViewMapClick read FOnMapClick write SetOnMapClick;
    property OnMapRightClick : TEdgeGoogleMapViewMapClick read FOnMapRightClick write SetOnMapRightClick;
    property OnMapZoom : TEdgeGoogleMapViewZoomChanged read FOnMapZoom write SetOnMapZoom;
  end;

implementation

uses
  System.StrUtils
  , System.IOUtils
  , REST.Json
  , SyStem.JSON
  ;

{ TEdgeGoogleMapViewer }

class procedure TEdgeGoogleMapViewer.RegisterUserDataFolder(const ATempFolder: string);
begin
  FUserDataFolder := ATempFolder;
end;

class procedure TEdgeGoogleMapViewer.RegisterGoogleMapsApiKey(const AApiKey: string);
begin
  FApiKey := AApiKey;
end;

procedure TEdgeGoogleMapViewer.CustomDocumentComplete(Sender: TCustomEdgeBrowser;
  IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
begin
  //MapIsBusy := False;
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

function TEdgeGoogleMapViewer.HandleWebMessageEvent(AEvent : string) : boolean;
var
  LEventValue : TJSONObject;
  LEvent : string;
  LLatLng : TLatLng;
begin
  Result := False;
  LEventValue := nil;
  try
    LEventValue := TJSONObject.ParseJSONValue(AEvent) as TJSONObject;
    LEvent := LEventValue.GetValue('event').GetValue<string>;
    if SameText(LEvent,'click') then
      begin
       if Assigned(FOnMapClick) then
        begin
          LLatLng.Latitude := LEventValue.GetValue('lat').GetValue<double>;
          LLatLng.Longitude := LEventValue.GetValue('lng').GetValue<double>;

          FOnMapClick(Self,LLatLng);
        end;
      end;
     if SameText(LEvent,'rightclick') then
      begin
       if Assigned(FOnMapRightClick) then
        begin
          LLatLng.Latitude := LEventValue.GetValue('lat').GetValue<double>;
          LLatLng.Longitude := LEventValue.GetValue('lng').GetValue<double>;
          FOnMapRightClick(Self,LLatLng);
        end;
      end;
       if SameText(LEvent,'zoom_changed') then
      begin
        FZoom := LEventValue.GetValue('zoom').GetValue<integer>;
        if Assigned(FOnMapZoom) then
          begin
            FOnMapZoom(Self,FZoom);
          end;
      end;
  except

  end;
  if Assigned(LEventValue) then
    LEventValue.Free;
end;

procedure TEdgeGoogleMapViewer.CustomWebMessageReceived(ASender: TCustomEdgeBrowser;
  Args: TWebMessageReceivedEventArgs);
var
  LSource: PWideChar;
  LwebMessageAsString: PWideChar;
  LHandled : boolean;
begin

  Args.ArgsInterface.Get_Source(LSource);
  Args.ArgsInterface.TryGetWebMessageAsString(LwebMessageAsString);

  LHandled := HandleWebMessageEvent(LwebMessageAsString);

  if not LHandled then
    begin
      if Assigned(FOnWebUnhandledMessageReceived) then
        FOnWebUnhandledMessageReceived(ASender,Args);
    end;
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
  Self.UserDataFolder := FUserDataFolder;
  if WebViewCreated then
    DefaultScriptDialogsEnabled := False;
  FMapVisible := false;
  FPanControl := true;
  FZoomControl := true;
  FTypeControl := true;
  FScaleControl := true;
  FFullScreenControl := true;
  FOverviewMapControl := true;
  FMapShowDirectionsPanel := false;
  FZoom := DEFAULT_ZOOM_FACTOR;
  FOnNavigationCompleted := OnNavigationCompleted;
  FOnCreateWebViewCompleted := OnCreateWebViewCompleted;

  if not (csDesigning in ComponentState) then
  begin
    OnNavigationCompleted := CustomDocumentComplete;
    OnCreateWebViewCompleted := CustomWebViewCreateComplete;
    OnWebMessageReceived := CustomWebMessageReceived;
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

function TEdgeGoogleMapViewer.GetHTMLHEader : string;
begin
    Result := '<html> '+sLineBreak+
  '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'+sLineBreak+
  '<head> '+sLineBreak+
  '<meta name="viewport" content="initial-scale=1.0, user-scalable=yes" /> '+sLineBreak+
  '<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=%s"></script> '+sLineBreak;
end;

function TEdgeGoogleMapViewer.GetHTMLBody: string;
var
  LBody : string;
begin
 LBody :=
  '<div id="container">'+sLineBreak+
  '    <div id="map_canvas"></div>'+sLineBreak +
  '    <div id="directions_canvas"></div>'+sLineBreak+
  '</div>';
  if Assigned(FOnGetHTMLBody) then
    FOnGetHTMLBody(Self,LBody);

  LBody := StringReplace(LBody,'%','%%',[rfReplaceAll]);

  Result :=
  '</head> '+sLineBreak +
  '<body onload="initialize()"> '+ sLineBreak +
  LBody + sLineBreak +
  '</body> '+sLineBreak +
  '</html>';
end;

function TEdgeGoogleMapViewer.GetJSVariables : string;
begin
    Result :=  '  var geocoder; '+sLineBreak+
  '  var directionsDisplay; '+sLineBreak+
  '  var directionsService = new google.maps.DirectionsService(); '+sLineBreak+
  '  var infoWindow = new google.maps.InfoWindow();'+sLineBreak+
  '  var map;  '+sLineBreak+
  '  var trafficLayer;'+sLineBreak+
  '  var bikeLayer;'+sLineBreak+
  '  var markersArray = [];';
end;

function TEdgeGoogleMapViewer.GetJSInitialize : string;
begin
   Result := '  function initialize() { '+sLineBreak+
  '    geocoder = new google.maps.Geocoder();'+sLineBreak+
  '    directionsDisplay = new google.maps.DirectionsRenderer();'+sLineBreak+
  '    var latlng = new google.maps.LatLng(%s,%s); '+sLineBreak+
  '    var myOptions = { '+sLineBreak+
  '      zoom: %d, '+sLineBreak+
  '      center: latlng, '+sLineBreak+
  '      panControl: %s, '+sLineBreak+
  '      zoomControl: %s, '+sLineBreak+
  '      mapTypeControl: %s, '+sLineBreak+
  '      fullscreenControl: %s, '+sLineBreak+
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
  '    map.addListener("click", (mapsMouseEvent) => {'+sLineBreak+
  '      window.chrome.webview.postMessage(JSON.stringify({"event" : "click",'+sLineBreak+
  '      "lat" : mapsMouseEvent.latLng.lat().toFixed(4),'+sLineBreak+
  '      "lng" : mapsMouseEvent.latLng.lng().toFixed(4) } , null, 2));'+sLineBreak+
  '    });'+sLineBreak+
  '    map.addListener("rightclick", (mapsMouseEvent) => {'+sLineBreak+
  '      window.chrome.webview.postMessage(JSON.stringify({"event" : "rightclick",'+sLineBreak+
  '      "lat" : mapsMouseEvent.latLng.lat().toFixed(4),'+sLineBreak+
  '      "lng" : mapsMouseEvent.latLng.lng().toFixed(4) } , null, 2));'+sLineBreak+
  '    });'+sLineBreak+
  '    map.addListener("zoom_changed", (mapsMouseEvent) => {'+sLineBreak+
  '      window.chrome.webview.postMessage(JSON.stringify({"event" : "zoom_changed",'+sLineBreak+
  '      "zoom" :  map.getZoom()} , null, 2));'+sLineBreak+
  '    });'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSCodeAddress : string;
begin
   Result := '  function codeAddress(address) { '+sLineBreak+
  '    if (geocoder) {'+sLineBreak+
  '      geocoder.geocode( { ''address'': address}, function(results, status) { '+sLineBreak+
  '        if (status == google.maps.GeocoderStatus.OK) {'+sLineBreak+
  '          SetMapShowDirectionsPanel(false,true);'+sLineBreak+
  '          map.setCenter(results[0].geometry.location);'+sLineBreak+
  '          PutMarker(results[0].geometry.location.lat(), results[0].geometry.location.lng(), address);'+sLineBreak+
  '        }'+sLineBreak+
  '      });'+sLineBreak+
  '    }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSGotoLatLng : string;
begin
   Result := '  function GotoLatLng(Lat, Lng, Description, AddMarker) { '+sLineBreak+
  '   var latlng = new google.maps.LatLng(Lat,Lng);'+sLineBreak+
  '   SetMapShowDirectionsPanel(false, true);'+sLineBreak+
  '   map.setCenter(latlng);'+sLineBreak+
  '   if (AddMarker) { PutMarker(Lat, Lng, Description) };'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSClearMakers : string;
begin
   Result :=   'function ClearMarkers() {  '+sLineBreak+
  '  if (markersArray) {        '+sLineBreak+
  '    for (i in markersArray) {  '+sLineBreak+
  '      markersArray[i].setMap(null); '+sLineBreak+
  '    } '+sLineBreak+
  '  } '+sLineBreak+
  '}  '
end;

function TEdgeGoogleMapViewer.GetJSPutMarker : string;
begin
  Result :=
  '  function PutMarker(Lat, Lng, Msg, Animation, Label, Info) { '+sLineBreak+
  '   var latlng = new google.maps.LatLng(Lat,Lng);'+sLineBreak+
  '   var marker = new google.maps.Marker({'+sLineBreak+
  '      position: latlng, '+sLineBreak+
  '      map: map,'+sLineBreak+
  '      title: Msg,'+sLineBreak+
  '      label: Label,'+sLineBreak+
  '      animation: Animation,'+sLineBreak+
  '   });'+sLineBreak+
  '   markersArray.push(marker); '+sLineBreak+
  '   if (Info) { ' +sLineBreak+
  '   marker.addListener("click", () => {'+sLineBreak+
  '    infoWindow.open(marker.getMap(), marker);'+sLineBreak+
  '    infoWindow.setContent(Info);'+sLineBreak+
  '    });'+sLineBreak+
  '   }'+sLineBreak+
  '}';
end;

function TEdgeGoogleMapViewer.GetJSPutCustomMarker : string;
begin

  Result := Result +
  '  function PutCustomMarker(Lat, Lng, Msg, Label, Info, CustomMarker) { '+sLineBreak+
  '   var latlng = new google.maps.LatLng(Lat,Lng);'+sLineBreak+
  '   var marker = new google.maps.Marker({'+sLineBreak+
  '      position: latlng, '+sLineBreak+
  '      map: map,'+sLineBreak+
  '      title: Msg,'+sLineBreak+
  '      label: Label,'+sLineBreak+
  '      icon: CustomMarker,'+sLineBreak+
  '   });'+sLineBreak+
  '   markersArray.push(marker); '+sLineBreak+
  '   if (Info) { ' +sLineBreak+
  '   marker.addListener("click", () => {'+sLineBreak+
  '    infoWindow.open(marker.getMap(), marker);'+sLineBreak+
  '    infoWindow.setContent(Info);'+sLineBreak+
  '    });'+sLineBreak+
  '   }'+sLineBreak+
  '}';
end;

function TEdgeGoogleMapViewer.GetJSMapOptions : string;
begin
  Result :=   '  function Traffic(On)   { if (On) {trafficLayer.setMap(map);} else {trafficLayer.setMap(null);}; }'+sLineBreak+
  ''+sLineBreak+
  '  function Bicycling(On) { if (On) {bikeLayer.setMap(map);} else {bikeLayer.setMap(null);}; }'+sLineBreak+
  ''+sLineBreak+
  '  function StreetViewControl(On) { map.set("streetViewControl", On); }'+sLineBreak+
  ''+sLineBreak+
  '  function zoomControl(On) { map.set("zoomControl", On); }'+sLineBreak+
  ''+sLineBreak+
  '  function mapTypeControl(On) { map.set("mapTypeControl", On); }'+sLineBreak+
  ''+sLineBreak+
  '  function fullscreenControl(On) { map.set("fullscreenControl", On); }'+sLineBreak+
  ''+sLineBreak+
  '  function SetZoom(zoom) { map.setZoom(zoom); }';
end;

function TEdgeGoogleMapViewer.GetJSMapShowDirectionsPanel : string;
begin
  Result := Result +
  '  function SetMapShowDirectionsPanel(On, clearMap) { if (On) {' +sLineBreak+
  '    directionsDisplay.setPanel(document.getElementById("directions_canvas"));  '+sLineBreak+
  '  } else {'+sLineBreak+
  '    if (clearMap) { directionsDisplay.setMap(null); }'+sLineBreak+
  '    directionsDisplay.setPanel(null);' + sLineBreak+
  '  }'+sLineBreak+
  '  }'+sLineBreak;
end;

function TEdgeGoogleMapViewer.GetJSRouteAddress : string;
begin
  Result := '  function routeByAddress(startAddress, destinationAddress, travelMode, showDirections) {'+sLineBreak+
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
  '              calcRoute(originLat, originLng, destinationLat, destinationLng, travelMode, startAddress, destinationAddress,showDirections);'+sLineBreak+
  '            }'+sLineBreak+
  '          });'+sLineBreak+
  '        }'+sLineBreak+
  '      });'+sLineBreak+
  '    }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSCalcRoute : string;
begin
  REsult :=   '  function calcRoute(originLat, originLng, destinationLat, destinationLng, travelMode, originDesc, destinationDesc, showDirections) {'+sLineBreak+
  '   var origin_route = new google.maps.LatLng(originLat,originLng);'+sLineBreak+
  '   var destination_route = new google.maps.LatLng(destinationLat,destinationLng);'+sLineBreak+
  '   var request = {'+sLineBreak+
  '       origin: origin_route,'+sLineBreak+
  '       destination: destination_route,'+sLineBreak+
  '       travelMode: google.maps.TravelMode[travelMode]'+sLineBreak+
  '   };'+sLineBreak+
  '   directionsService.route(request, function(response, status) {'+sLineBreak+
  '    if (status == google.maps.DirectionsStatus.OK) {'+sLineBreak+
  '      SetMapShowDirectionsPanel(showDirections);'+sLineBreak+
  '      directionsDisplay.setMap(map);'+sLineBreak+
  '      directionsDisplay.setDirections(response);'+sLineBreak+
  '    }'+sLineBreak+
  '   });'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetHTMLStyle: string;
var
  LStyle  :string;
begin
  LStyle :=
  'html,' +sLineBreak+
  'body {' +sLineBreak+
  'height: 100%;' +sLineBreak+
  'margin: 0;' +sLineBreak+
  'padding: 0;' +sLineBreak+
  '}' +sLineBreak+

  '#container {'+sLineBreak+
  'height: 100%;'+sLineBreak+
  'display: flex;'+sLineBreak+
  '}'+sLineBreak+

  '#directions_canvas {'+sLineBreak+
  'flex-basis: 15rem;'+sLineBreak+
  'flex-grow: 1;'+sLineBreak+
  'padding: 1rem;'+sLineBreak+
  'max-width: 30rem;'+sLineBreak+
  'height: 100%;'+sLineBreak+
//  'width: 30%;'+sLineBreak+
  'box-sizing: border-box;'+sLineBreak+
  'overflow: auto;'+sLineBreak+
  'flex: 0 1 auto;'+sLineBreak+
  'padding: 0;'+sLineBreak+
  '}'+sLineBreak+

  '#map_canvas {'+sLineBreak+
  'flex: auto;' + sLineBreak+
  'flex-basis: 0;'+sLineBreak+
  'flex-grow: 4;'+sLineBreak+
  'height: 100%;'+sLineBreak+
//  'width: 70%;'+sLineBreak+
  '}';

  LStyle := StringReplace(LStyle,'%','%%',[rfReplaceAll]);

  Result := '<style>' + sLineBreak +  LStyle + sLineBreak + '</style>';
end;

function TEdgeGoogleMapViewer.GetHTMLScript : string;
var
  LJSScript : string;
begin
  LJSScript := GetJSVariables +sLineBreak+
  GetJSInitialize +sLineBreak+
  GetJSCodeAddress + sLineBreak+
  GetJSGotoLatLng + sLineBreak +
  GetJSClearMakers + sLineBreak +
  GetJSPutMarker + sLineBreak +
  GetJSPutCustomMarker + sLineBreak +
  GetJSMapOptions + sLineBreak +
  GetJSMapShowDirectionsPanel + sLineBreak+
  GetJSRouteAddress + sLineBreak +
  GetJSCalcRoute;
  if Assigned(FOnGetJavascript) then
    FOnGetJavascript(Self,LJSScript);
  Result :=
  '<script type="text/javascript"> '+sLineBreak+
  LJSScript + sLineBreak +
  '</script> '+ sLineBreak;
end;




procedure TEdgeGoogleMapViewer.ShowMap(AMapCenter: TLatLng; const AAddress: string = '');
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
  HTMLString := GetHTMLHeader + GetHTMLStyle + GetHTMLScript + GetHTMLBody;
  HTMLString := Format(HTMLString,
    [
      FApiKey,
      CoordToText(MyCenter.Latitude), //Latitudine
      CoordToText(MyCenter.Longitude), //Longitudine
      MapZoom, //Zoom
      B2S(FPanControl),
      B2S(FZoomControl),
      B2S(FTypeControl),
      B2S(FFullScreenControl),
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
  try
    NavigateToURL('file:///'+LFileName);
  finally
    MapIsBusy := False;
  end;
  FMapVisible := True;
end;

procedure TEdgeGoogleMapViewer.ShowPrintUI;
begin
  ExecuteScript('window.print();');
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

procedure TEdgeGoogleMapViewer.SetMapShowDirectionsPanel(const Value: boolean);
begin
  FMapShowDirectionsPanel := Value;
  if MapVisible then
    ShowDirectionsPanel(Value);
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
    GotoLocation(FMapCenter, Trim(Description) <> '');
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

  if Assigned(FBeforeInitMap) then
    FBeforeInitMap(Self);

  Self.UserDataFolder := FUserDataFolder;
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

function TEdgeGoogleMapViewer.JSONEncodeString(const AText: string): string;
begin
  Result := TJson.JsonEncode(AText);
end;

function TEdgeGoogleMapViewer.StripCRLF(AValue, AReplaceWith: string): string;
begin
  Result := AValue;
  Result := StringReplace(Result, #13, '', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, #10, AReplaceWith,
    [rfReplaceAll, rfIgnoreCase]);
end;

function TEdgeGoogleMapViewer.DefaultCustomMarkerJSON : string;
begin
  Result :=
  '{'+SLineBreak+
  '  "path": "M 0,0 C -2,-20 -10,-22 -10,-30 A 10,10 0 1,1 10,-30 C 10,-22 2,-20 0,0 z M -2,-30 a 2,2 0 1,1 4,0 2,2 0 1,1 -4,0",'+SLineBreak+
  '  "fillColor": "#00D800",'+SLineBreak+
  '  "fillOpacity": 1,'+SLineBreak+
  '  "strokeColor": "#000",'+SLineBreak+
  '  "strokeWeight": 2,'+SLineBreak+
  '  "scale": 1'+SLineBreak+
  '}'+SLineBreak;
end;



procedure TEdgeGoogleMapViewer.PutMarker(LatLng: TLatLng; ADescription : string;
  AAnimation : TGoogleMarkerAnimationId;
  ALabel, AInfoWindowContent, ACustomMarkerJSON: string);
var
  LScriptCommand: String;
  LInfoWindowContent : string;
  LAnimation : string;
begin
  if not MapVisible then
  begin
    ShowMap(EmptyLatLng);
    while MapIsBusy do
      Sleep(10);
  end;
  LInfoWindowContent := AInfoWindowContent;
  if LInfoWindowContent = '' then
    LInfoWindowContent := ADescription ;
  LAnimation := Format('google.maps.Animation.%s',[AGoogleMarkerAnimationId[AAnimation]]);
  if ACustomMarkerJSON = '' then
  begin
  LScriptCommand := Format('PutMarker(%s, %s, %s, %s, %s, %s)',[
    CoordToText(LatLng.Latitude),
    CoordToText(LatLng.Longitude),
    QuotedStr(ADescription),
    LAnimation,
    QuotedStr(ALabel),
    QuotedStr(StripCRLF(LInfoWindowContent))
    ]);
  end else
  begin
  LScriptCommand := Format('PutCustomMarker(%s, %s, %s, %s, %s, %s)',[
    CoordToText(LatLng.Latitude),
    CoordToText(LatLng.Longitude),
    QuotedStr(ADescription),
    QuotedStr(ALabel),
    QuotedStr(StripCRLF(LInfoWindowContent)),
    JSONEncodeString(ACustomMarkerJSON)
    ]);
  end;
  ExecuteScript(LScriptCommand);
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
  ScriptCommand := Format('routeByAddress(%s, %s, %s, %s)',[
    QuotedStr(ClearAddressText(StartAddress)),
    QuotedStr(ClearAddressText(DestinationAddress)),
    QuotedStr(AGoogleRouteModeId[RouteMode]),
    B2S(FMapShowDirectionsPanel)
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

procedure TEdgeGoogleMapViewer.SetOnGetHTMLBody(
  const Value: TEdgeGoogleMapViewHTMLBody);
begin
  FOnGetHTMLBody := Value;
end;

procedure TEdgeGoogleMapViewer.SetOnGetJavascript(
  const Value: TEdgeGoogleMapViewJavascript);
begin
  FOnGetJavascript := Value;
end;

procedure TEdgeGoogleMapViewer.SetOnMapClick(
  const Value: TEdgeGoogleMapViewMapClick);
begin
  FOnMapClick := Value;
end;

procedure TEdgeGoogleMapViewer.SetOnMapRightClick(
  const Value: TEdgeGoogleMapViewMapClick);
begin
  FOnMapRightClick := Value;
end;

procedure TEdgeGoogleMapViewer.SetOnMapZoom(
  const Value: TEdgeGoogleMapViewZoomChanged);
begin
  FOnMapZoom := Value;
end;

procedure TEdgeGoogleMapViewer.SetOnWebUnhandledMessageReceived(
  const Value: TWebMessageReceivedEvent);
begin
  FOnWebUnhandledMessageReceived := Value;
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

procedure TEdgeGoogleMapViewer.SetFullScreenControl(const Value: boolean);
begin
  FFullScreenControl := Value;
  if MapVisible then
    ShowFullScreenControl(Value);
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
  ShowZoomControl(FZoomControl);
end;

procedure TEdgeGoogleMapViewer.GotoLocation(LatLng: TLatLng; AAddMarker : boolean);
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
    ScriptCommand := Format('GotoLatLng(%s,%s,%s,%s)',[
      CoordToText(LatLng.Latitude),
      CoordToText(LatLng.Longitude),
      QuotedStr(LatLng.Description),
      B2S(AAddMarker)
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
  ScriptCommand := Format('calcRoute(%s, %s, %s, %s, %s, %s,%s, %s)',[
    CoordToText(Origin.Latitude),
    CoordToText(Origin.Longitude),
    CoordToText(Destination.Latitude),
    CoordToText(Destination.Longitude),
    QuotedStr(AGoogleRouteModeId[RouteMode]),
    QuotedStr(CoordToText(Origin.Latitude) + ',' + CoordToText(Origin.Longitude)),
    QuotedStr(CoordToText(Destination.Latitude) + ',' +  CoordToText(Destination.Longitude)),
    B2S(FMapShowDirectionsPanel)
    ]);
  ExecuteScript(ScriptCommand);
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

procedure TEdgeGoogleMapViewer.ShowDirectionsPanel(const Value: boolean);
begin
  FMapShowDirectionsPanel := Value;
  ExecuteScript(Format('SetMapShowDirectionsPanel(%s)',[B2S(FMapShowDirectionsPanel)]));
end;

procedure TEdgeGoogleMapViewer.ShowMap(const AAddress: string);
begin
  ShowMap(EmptyLatLng, AAddress);
end;

procedure TEdgeGoogleMapViewer.RouteByAddresses;
begin
  if not MapVisible then
  begin
    ShowMap(EmptyLatLng);
    while MapIsBusy do
      Sleep(10);
  end;
  if (FStartAddress <> '') and (FDestinationAddress <> '') then
    RouteByAddress(FStartAddress, FDestinationAddress, FMapRouteModeId);
end;

procedure TEdgeGoogleMapViewer.RouteByLocations;
begin
  if not MapVisible then
  begin
    ShowMap(EmptyLatLng);
    while MapIsBusy do
      Sleep(10);
  end;
  if (FMapStart.Latitude <> 0) and (FMapStart.Longitude <> 0) and
     (FMapDestination.Latitude <> 0) or (FMapDestination.Longitude <> 0) then
    CalcRoute(FMapStart, FMapDestination, FMapRouteModeId);
end;

procedure TEdgeGoogleMapViewer.ShowTraffic(Show: boolean);
begin
  FTraffic := Show;
  ExecuteScript(Format('Traffic(%s)',[B2S(FTraffic)]));
end;

procedure TEdgeGoogleMapViewer.ShowZoomControl(Show: boolean);
begin
  FZoomControl := Show;
  ExecuteScript(Format('zoomControl(%s)',[B2S(FZoomControl)]));
end;

procedure TEdgeGoogleMapViewer.ShowMapTypeControl(Show: boolean);
begin
  FTypeControl := Show;
  ExecuteScript(Format('mapTypeControl(%s)',[B2S(FTypeControl)]));
end;

procedure TEdgeGoogleMapViewer.ShowFullScreenControl(Show: boolean);
begin
  FFullScreenControl := Show;
  ExecuteScript(Format('fullscreenControl(%s)',[B2S(FFullScreenControl)]));
end;

end.

