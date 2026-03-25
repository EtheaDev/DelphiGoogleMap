{******************************************************************************}
{                                                                              }
{       Delphi Google Map Viewer                                               }
{                                                                              }
{       Copyright (c) 2021-2026 (Ethea S.r.l.)                                 }
{       Author: Carlo Barazzetta                                               }
{       Contributors:                                                          }
{         littleearth (https://github.com/littleearth)                         }
{         tbegsr (https://github.com/tbegsr)                                   }
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

resourcestring
  ERROR_CANNOT_INITALIZE = 'Error: cannot initilize Google Map Viewer!';
  CHECK_DLL_IN_APP_PATH = 'Check if webview2loader.dll is present in System Path or Application Path';
  ERROR_API_KEY = 'Error: you must put your Google API Key into TEdgeGoogleMapViewer.APIKey property!';

const
  DEFAULT_ZOOM_FACTOR = 15;
  DelphiGoogleMapViewerVersion = '2.0.0';

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

  TGoogleMapColorScheme = (csLIGHT, csDARK);

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

  AGoogleMapColorScheme : Array[TGoogleMapColorScheme] of string =
    ('LIGHT',
     'DARK');

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
  [ComponentPlatforms(pidWin32 or pidWin64)]
  TEdgeGoogleMapViewer = class(TCustomEdgeBrowser)
  strict private
    class var FApiKey: string;
    class var FUserDataFolder: string;
  private
    FMapIsBusy: boolean;
    FViewerReady: boolean;
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

    FMapColorScheme: TGoogleMapColorScheme;

    //variables for result functions
    FDistance: Variant;

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
    function GetAPIKey: string;
    procedure SetApiKey(const Value: string);
    procedure CheckAPIKeyPresent;
    procedure SetMapColorScheme(const Value: TGoogleMapColorScheme);
    procedure DoPutMarker(LatLng: TLatLng; const ADescription: string;
      AAnimation: TGoogleMarkerAnimationId; const ALabel, AInfoTitle,
      AInfoWindowContent, ACustomMarkerJSON: string);
  protected
    procedure Loaded; override;
    function GetHTMLHeader: string; virtual;
    function GetHTMLStyle : string; virtual;
    function GetHTMLScript: string; virtual;
    function GetHTMLBody : string; virtual;
    function GetJSVariables: string; virtual;
    function GetJSInitialize: string; virtual;
    function GetJSCodeAddress: string; virtual;
    function GetJSGotoLatLng: string; virtual;
    function GetJSClearMarkers: string; virtual;
    function GetJSPutMarker: string; virtual;
    function GetJSOpenInfoWindow: string; virtual;
    function GetJSPutCustomMarker: string; virtual;
    function GetJSPutMarkerByAddress: string; virtual;
    function GetJSMapOptions: string; virtual;
    function GetJSMapShowDirectionsPanel: string;
    function GetJSRouteAddress: string;
    function GetJSCalcRoute: string;
    function GetJSPutCircle: string; virtual;
    function GetJSClearCircles: string; virtual;
    function GetJSPutPolyline: string; virtual;
    function GetJSClearPolylines: string; virtual;
    function GetJSPutPolygon: string; virtual;
    function GetJSClearPolygons: string; virtual;
    function GetJSGeometry: string; virtual;
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
    procedure NavigateToURL(const URL: string);
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
    //Different Show Methods
    procedure ShowMap(AMapCenter: TLatLng; const AAddress: string = ''); overload;
    procedure ShowStreetViewControl(Show: boolean);
    procedure ShowBicycling(Show: boolean);
    procedure ShowTraffic(Show: boolean);
    procedure ShowDirectionsPanel(const Value: boolean);
    procedure ShowZoomControl(Show: boolean);
    procedure ShowMapTypeControl(Show: boolean);
    procedure ShowFullScreenControl(Show: boolean);
    procedure PutMarker(LatLng: TLatLng; ADescription : string; AAnimation : TGoogleMarkerAnimationId = maNONE;
      ALabel : string = ''; AInfoWindowContent : string = ''; ACustomMarkerJSON : string = ''); overload;
    procedure PutMarker(LatLng: TLatLng; ADescription : string;
      AInfoTitle: string; AAnimation : TGoogleMarkerAnimationId;
      ALabel : string = ''; AInfoWindowContent : string = ''; ACustomMarkerJSON : string = ''); overload;
    procedure PutMarkerByAddress(const AAddress: string;
      const AInfoTitle: string = ''; const AInfoWindowContent: string = '');
    procedure ClearMarkers;
    procedure HideMarkers;
    procedure ShowMarkers;

    class property ApiKey: string read FApiKey;
    //Circle
    procedure PutCircle(LatLng: TLatLng; Radius: Double; Editable, Draggable, Visible, Clickable: Boolean;
      StrokeColor: String; StrokeOpacity: Double; StrokeWeight: Integer; FillColor: String; FillOpacity: Double;
      AInfoWindowContent : string = '');
    procedure ClearCircles;
    procedure HideCircles;
    procedure ShowCircles;

    //Polyline
    procedure PutPolyline(Path:String; Geodesic, Editable, Visible, Clickable, FitBounds: Boolean;
      StrokeColor: String; StrokeOpacity: Double; StrokeWeight: Integer;
      AInfoWindowContent : string = '');
    procedure ClearPolylines;
    procedure HidePolylines;
    procedure ShowPolylines;

    //Polygon
    procedure PutPolygon(Path:String; Editable, Visible, Clickable, FitBounds: Boolean;
      StrokeColor: String; StrokeOpacity: Double; StrokeWeight: Integer; FillColor: String; FillOpacity: Double;
      AInfoWindowContent : string = '');
    procedure ClearPolygons;
    procedure HidePolygons;
    procedure ShowPolygons;

    //geometry
    function ComputeDistanceBetween(Origin, Destination: TLatLng): Double;

  published
    //Inherited Properties
    property Align;
    property Anchors;
    property TabOrder;
    property TabStop;
    property OnEnter;
    property OnExit;
    {$IF CompilerVersion >= 35} //Delphi 11+
    property BrowserExecutableFolder;
    property UserDataFolder;
    property PopupMenu;
    {$ENDIF}
    {$IF CompilerVersion >= 36} //Delphi 12+
    property AdditionalBrowserArguments;
    property AllowSingleSignOnUsingOSPrimaryAccount;
    property Language;
    property TargetCompatibleBrowserVersion;
    {$ENDIF}
    {$IF CompilerVersion >= 37} //Delphi 13+
    property PopupMenuMode;
    property InitScript;
    {$ENDIF}
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
    {$IF CompilerVersion >= 36} //Delphi 12+
    property OnDownloadStarting;
    property OnPrintCompleted;
    property OnPrintToPDFCompleted;
    {$ENDIF}
    property OnProcessFailed;
    property OnScriptDialogOpening;
    property OnSourceChanged;
    property OnWebMessageReceived;
    property OnWebResourceRequested;
    property OnWindowCloseRequested;
    property OnZoomFactorChanged;
    // Custom properties
    property MapAPIKey: string read GetAPIKey write SetApiKey;
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
    property MapColorScheme: TGoogleMapColorScheme read FMapColorScheme write SetMapColorScheme default csLIGHT;
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
  , System.JSON
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
  raise EGoogleMapError.Create(ERROR_CANNOT_INITALIZE+slineBreak+
    CHECK_DLL_IN_APP_PATH)
  else
    FViewerReady := True;
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
  Field:String;
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
       if SameText(LEvent,'response_value') then
      begin
        Field := LEventValue.GetValue('field').GetValue<string>;
        if Field='distance' then
            FDistance:=LEventValue.GetValue('value').GetValue<Double>;
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
  FMapColorScheme := csLIGHT;
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

procedure TEdgeGoogleMapViewer.HideMarkers;
begin
  ExecuteScript('HideMarkers()');
end;

procedure TEdgeGoogleMapViewer.ShowMarkers;
begin
  ExecuteScript('ShowMarkers()');
end;

procedure TEdgeGoogleMapViewer.PutMarkerByAddress(const AAddress: string;
  const AInfoTitle: string; const AInfoWindowContent: string);
var
  LScriptCommand: String;
begin
  if not MapVisible then
  begin
    ShowMap(EmptyLatLng);
    while FMapIsBusy do
      Sleep(10);
  end;
  LScriptCommand := Format('PutMarkerByAddress(%s, %s, %s)',[
    QuotedStr(ClearAddressText(AAddress)),
    QuotedStr(StripCRLF(AInfoTitle)),
    QuotedStr(StripCRLF(AInfoWindowContent))
    ]);
  ExecuteScript(LScriptCommand);
end;

procedure TEdgeGoogleMapViewer.SetMapColorScheme(const Value: TGoogleMapColorScheme);
begin
  if FMapColorScheme <> Value then
  begin
    FMapColorScheme := Value;
    if MapVisible then
      ShowMap(EmptyLatLng); // colorScheme requires map recreation
  end;
end;

function TEdgeGoogleMapViewer.GetHTMLHEader : string;
begin
    Result := '<html> '+sLineBreak+
  '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'+sLineBreak+
  '<head> '+sLineBreak+
  '<meta name="viewport" content="initial-scale=1.0, user-scalable=yes" /> '+sLineBreak+
  '<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=%s&libraries=geometry,marker"></script> '+sLineBreak;
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

function TEdgeGoogleMapViewer.GetJSVariables: string;
begin
  Result :=
  '  var geocoder;'+sLineBreak+
  '  var directionsDisplay;'+sLineBreak+
  '  var directionsService;'+sLineBreak+
  '  var infoWindow;'+sLineBreak+
  '  var map;'+sLineBreak+
  '  var trafficLayer;'+sLineBreak+
  '  var bikeLayer;'+sLineBreak+
  '  var markersArray = [];'+sLineBreak+
  '  var circlesArray = [];'+sLineBreak+
  '  var polylinesArray = [];'+sLineBreak+
  '  var polygonsArray = [];'+sLineBreak+
  '  var _geocodeBatchQueue = [];'+sLineBreak+
  '  var _geocodeBatchRunning = false;';
end;

function TEdgeGoogleMapViewer.GetJSInitialize: string;
begin
  Result := '  function initialize() { '+sLineBreak+
  '    geocoder = new google.maps.Geocoder();'+sLineBreak+
  '    directionsService = new google.maps.DirectionsService();'+sLineBreak+
  '    directionsDisplay = new google.maps.DirectionsRenderer();'+sLineBreak+
  '    infoWindow = new google.maps.InfoWindow();'+sLineBreak+
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
  '      mapTypeId: google.maps.MapTypeId.%s, '+sLineBreak+
  '      mapId: "edgegooglemap-main", '+sLineBreak+
  '      colorScheme: "%s" '+sLineBreak+
  '    }; '+sLineBreak+
  '    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions); '+sLineBreak+
  '    if (latlng.lat() !== 0 || latlng.lng() !== 0) {'+sLineBreak+
  '      PutMarker(latlng.lat(), latlng.lng(), %s, null, null, null, %s);'+sLineBreak+
  '    }'+sLineBreak+
  '    codeAddress(%s);'+sLineBreak+
  '    trafficLayer = new google.maps.TrafficLayer();'+sLineBreak+
  '    Traffic(%s);'+sLineBreak+
  '    bikeLayer = new google.maps.BicyclingLayer();'+sLineBreak+
  '    Bicycling(%s);'+sLineBreak+
  '    map.addListener("click", function(mapsMouseEvent) {'+sLineBreak+
  '      window.chrome.webview.postMessage(JSON.stringify({"event" : "click",'+sLineBreak+
  '      "lat" : mapsMouseEvent.latLng.lat().toFixed(4),'+sLineBreak+
  '      "lng" : mapsMouseEvent.latLng.lng().toFixed(4) } , null, 2));'+sLineBreak+
  '    });'+sLineBreak+
  '    map.addListener("rightclick", function(mapsMouseEvent) {'+sLineBreak+
  '      window.chrome.webview.postMessage(JSON.stringify({"event" : "rightclick",'+sLineBreak+
  '      "lat" : mapsMouseEvent.latLng.lat().toFixed(4),'+sLineBreak+
  '      "lng" : mapsMouseEvent.latLng.lng().toFixed(4) } , null, 2));'+sLineBreak+
  '    });'+sLineBreak+
  '    map.addListener("zoom_changed", function() {'+sLineBreak+
  '      window.chrome.webview.postMessage(JSON.stringify({"event" : "zoom_changed",'+sLineBreak+
  '      "zoom" : map.getZoom()} , null, 2));'+sLineBreak+
  '    });'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSCodeAddress: string;
begin
  Result := '  function codeAddress(address) { '+sLineBreak+
  '    if (geocoder && address) {'+sLineBreak+
  '      geocoder.geocode( { ''address'': address}, function(results, status) { '+sLineBreak+
  '        if (status == google.maps.GeocoderStatus.OK) {'+sLineBreak+
  '          SetMapShowDirectionsPanel(false,true);'+sLineBreak+
  '          map.setCenter(results[0].geometry.location);'+sLineBreak+
  '          PutMarker(results[0].geometry.location.lat(), results[0].geometry.location.lng(), address, null, null, null, address);'+sLineBreak+
  '        }'+sLineBreak+
  '      });'+sLineBreak+
  '    }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSGotoLatLng: string;
begin
  Result := '  function GotoLatLng(Lat, Lng, Description, AddMarker) { '+sLineBreak+
  '   var latlng = new google.maps.LatLng(Lat,Lng);'+sLineBreak+
  '   SetMapShowDirectionsPanel(false, true);'+sLineBreak+
  '   map.setCenter(latlng);'+sLineBreak+
  '   if (AddMarker) { PutMarker(Lat, Lng, Description, null, null, null, Description); }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSClearMarkers: string;
begin
  Result :=
  '  function ClearMarkers() {'+sLineBreak+
  '    if (markersArray) { HideMarkers(); markersArray = []; }'+sLineBreak+
  '  }'+sLineBreak+
  '  function HideMarkers() {'+sLineBreak+
  '    if (markersArray) {'+sLineBreak+
  '      for (var i = 0; i < markersArray.length; i++) {'+sLineBreak+
  '        var m = markersArray[i];'+sLineBreak+
  '        if (m.setMap) { m.setMap(null); }'+sLineBreak+
  '        else if ("map" in m) { m.map = null; }'+sLineBreak+
  '      }'+sLineBreak+
  '    }'+sLineBreak+
  '  }'+sLineBreak+
  '  function ShowMarkers() {'+sLineBreak+
  '    if (markersArray) {'+sLineBreak+
  '      for (var i = 0; i < markersArray.length; i++) {'+sLineBreak+
  '        var m = markersArray[i];'+sLineBreak+
  '        if (m.setMap) { m.setMap(map); }'+sLineBreak+
  '        else if ("map" in m) { m.map = map; }'+sLineBreak+
  '      }'+sLineBreak+
  '    }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSOpenInfoWindow: string;
begin
  Result :=
  '  function _openInfoWindow(anchor, title, content) {'+sLineBreak+
  '    if (title && infoWindow.setHeaderContent) {'+sLineBreak+
  '      var header = document.createElement("span");'+sLineBreak+
  '      header.style.cssText = "font-weight:bold;font-size:14px";'+sLineBreak+
  '      header.textContent = title;'+sLineBreak+
  '      infoWindow.setHeaderContent(header);'+sLineBreak+
  '      infoWindow.setHeaderDisabled(false);'+sLineBreak+
  '    } else if (infoWindow.setHeaderDisabled) {'+sLineBreak+
  '      infoWindow.setHeaderDisabled(!title);'+sLineBreak+
  '      if (title) {'+sLineBreak+
  '        var h2 = document.createElement("span");'+sLineBreak+
  '        h2.style.cssText = "font-weight:bold;font-size:14px";'+sLineBreak+
  '        h2.textContent = title;'+sLineBreak+
  '        infoWindow.setHeaderContent(h2);'+sLineBreak+
  '      }'+sLineBreak+
  '    }'+sLineBreak+
  '    infoWindow.setContent(content || "");'+sLineBreak+
  '    if (anchor.position && !anchor.getPosition) {'+sLineBreak+
  '      infoWindow.open({ anchor: anchor, map: map });'+sLineBreak+
  '    } else {'+sLineBreak+
  '      infoWindow.open(map, anchor);'+sLineBreak+
  '    }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSPutMarker: string;
begin
  Result :=
  '  function PutMarker(Lat, Lng, Msg, Animation, Label, InfoTitle, Info) { '+sLineBreak+
  '   var latlng = new google.maps.LatLng(Lat,Lng);'+sLineBreak+
  '   var marker; var isAdvanced = false;'+sLineBreak+
  '   if (google.maps.marker && google.maps.marker.AdvancedMarkerElement && !Animation && !Label) {'+sLineBreak+
  '     try {'+sLineBreak+
  '       marker = new google.maps.marker.AdvancedMarkerElement({'+sLineBreak+
  '         position: latlng, map: map, title: Msg || ""'+sLineBreak+
  '       });'+sLineBreak+
  '       isAdvanced = true;'+sLineBreak+
  '     } catch(e) { isAdvanced = false; }'+sLineBreak+
  '   }'+sLineBreak+
  '   if (!isAdvanced) {'+sLineBreak+
  '     marker = new google.maps.Marker({'+sLineBreak+
  '       position: latlng, map: map, title: Msg,'+sLineBreak+
  '       label: Label || undefined, animation: Animation || undefined'+sLineBreak+
  '     });'+sLineBreak+
  '   }'+sLineBreak+
  '   markersArray.push(marker);'+sLineBreak+
  '   if (Info || InfoTitle) {'+sLineBreak+
  '     var clickEvent = isAdvanced ? "gmp-click" : "click";'+sLineBreak+
  '     marker.addListener(clickEvent, function() { _openInfoWindow(marker, InfoTitle, Info); });'+sLineBreak+
  '   }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSPutCustomMarker: string;
begin
  Result :=
  '  function PutCustomMarker(Lat, Lng, Msg, Label, InfoTitle, Info, CustomMarker) { '+sLineBreak+
  '   var latlng = new google.maps.LatLng(Lat,Lng);'+sLineBreak+
  '   var marker = new google.maps.Marker({'+sLineBreak+
  '      position: latlng, map: map, title: Msg,'+sLineBreak+
  '      label: Label || undefined, icon: CustomMarker'+sLineBreak+
  '   });'+sLineBreak+
  '   markersArray.push(marker);'+sLineBreak+
  '   if (Info || InfoTitle) {'+sLineBreak+
  '     marker.addListener("click", function() { _openInfoWindow(marker, InfoTitle, Info); });'+sLineBreak+
  '   }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSPutMarkerByAddress: string;
begin
  Result :=
  '  function PutMarkerByAddress(address, infoTitle, infoContent) {'+sLineBreak+
  '    _geocodeBatchQueue.push({ address: address, title: infoTitle || "", info: infoContent || "" });'+sLineBreak+
  '    if (!_geocodeBatchRunning) { _processGeocodeBatch(); }'+sLineBreak+
  '  }'+sLineBreak+
  '  function _processGeocodeBatch() {'+sLineBreak+
  '    if (_geocodeBatchQueue.length === 0) { _geocodeBatchRunning = false; return; }'+sLineBreak+
  '    _geocodeBatchRunning = true;'+sLineBreak+
  '    var batchSize = 5, delay = 300;'+sLineBreak+
  '    var batch = _geocodeBatchQueue.splice(0, batchSize);'+sLineBreak+
  '    for (var i = 0; i < batch.length; i++) {'+sLineBreak+
  '      (function(item) {'+sLineBreak+
  '        geocoder.geocode({ "address": item.address }, function(results, status) {'+sLineBreak+
  '          if (status === "OK" && results[0]) {'+sLineBreak+
  '            var pos = results[0].geometry.location;'+sLineBreak+
  '            PutMarker(pos.lat(), pos.lng(), item.address, null, null, item.title, item.info);'+sLineBreak+
  '          }'+sLineBreak+
  '        });'+sLineBreak+
  '      })(batch[i]);'+sLineBreak+
  '    }'+sLineBreak+
  '    if (_geocodeBatchQueue.length > 0) { setTimeout(_processGeocodeBatch, delay); }'+sLineBreak+
  '    else { _geocodeBatchRunning = false; }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSMapOptions: string;
begin
  Result :=
  '  function Traffic(On) { if (On) {trafficLayer.setMap(map);} else {trafficLayer.setMap(null);} }'+sLineBreak+
  '  function Bicycling(On) { if (On) {bikeLayer.setMap(map);} else {bikeLayer.setMap(null);} }'+sLineBreak+
  '  function StreetViewControl(On) { map.set("streetViewControl", On); }'+sLineBreak+
  '  function zoomControl(On) { map.set("zoomControl", On); }'+sLineBreak+
  '  function mapTypeControl(On) { map.set("mapTypeControl", On); }'+sLineBreak+
  '  function fullscreenControl(On) { map.set("fullscreenControl", On); }'+sLineBreak+
  '  function SetZoom(zoom) { map.setZoom(zoom); }';
end;

function TEdgeGoogleMapViewer.GetJSMapShowDirectionsPanel: string;
begin
  Result :=
  '  function SetMapShowDirectionsPanel(On, clearMap) { if (On) {'+sLineBreak+
  '    directionsDisplay.setPanel(document.getElementById("directions_canvas"));'+sLineBreak+
  '  } else {'+sLineBreak+
  '    if (clearMap) { directionsDisplay.setMap(null); }'+sLineBreak+
  '    directionsDisplay.setPanel(null);'+sLineBreak+
  '  } }';
end;

function TEdgeGoogleMapViewer.GetJSRouteAddress: string;
begin
  Result := '  function routeByAddress(startAddress, destinationAddress, travelMode, showDirections) {'+sLineBreak+
  '    if (geocoder) {'+sLineBreak+
  '      geocoder.geocode( { ''address'': startAddress}, function(results, status) { '+sLineBreak+
  '        if (status == google.maps.GeocoderStatus.OK) {'+sLineBreak+
  '          var originLat = results[0].geometry.location.lat();'+sLineBreak+
  '          var originLng = results[0].geometry.location.lng();'+sLineBreak+
  '          geocoder.geocode( { ''address'': destinationAddress}, function(results, status) { '+sLineBreak+
  '            if (status == google.maps.GeocoderStatus.OK) {'+sLineBreak+
  '              calcRoute(originLat, originLng, results[0].geometry.location.lat(), results[0].geometry.location.lng(), travelMode, startAddress, destinationAddress, showDirections);'+sLineBreak+
  '            }'+sLineBreak+
  '          });'+sLineBreak+
  '        }'+sLineBreak+
  '      });'+sLineBreak+
  '    }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSCalcRoute: string;
begin
  Result :=
  '  function calcRoute(originLat, originLng, destinationLat, destinationLng, travelMode, originDesc, destinationDesc, showDirections) {'+sLineBreak+
  '   var origin_route = new google.maps.LatLng(originLat,originLng);'+sLineBreak+
  '   var destination_route = new google.maps.LatLng(destinationLat,destinationLng);'+sLineBreak+
  '   var request = { origin: origin_route, destination: destination_route, travelMode: google.maps.TravelMode[travelMode] };'+sLineBreak+
  '   directionsService.route(request, function(response, status) {'+sLineBreak+
  '    if (status == google.maps.DirectionsStatus.OK) {'+sLineBreak+
  '      SetMapShowDirectionsPanel(showDirections);'+sLineBreak+
  '      directionsDisplay.setMap(map);'+sLineBreak+
  '      directionsDisplay.setDirections(response);'+sLineBreak+
  '    }'+sLineBreak+
  '   });'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSPutCircle: string;
begin
  Result :=
  '  function PutCircle(Lat, Lng, Radius, Editable, Draggable, Visible, Clickable, StrokeColor, StrokeOpacity, StrokeWeight, FillColor, FillOpacity, Info){'+sLineBreak+
  '   var latlng = new google.maps.LatLng(Lat,Lng);'+sLineBreak+
  '   var circle = new google.maps.Circle({ center: latlng, map: map, radius: Radius,'+sLineBreak+
  '     editable: Editable, draggable: Draggable, visible: Visible, clickable: Clickable,'+sLineBreak+
  '     strokeColor: StrokeColor, strokeOpacity: StrokeOpacity, strokeWeight: StrokeWeight,'+sLineBreak+
  '     fillColor: FillColor, fillOpacity: FillOpacity });'+sLineBreak+
  '   circlesArray.push(circle);'+sLineBreak+
  '   if (Info) { circle.addListener("click", function() {'+sLineBreak+
  '     infoWindow.setPosition(circle.getCenter()); infoWindow.setContent(Info); infoWindow.open(map);'+sLineBreak+
  '   }); }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSClearCircles: string;
begin
  Result :=
  '  function ClearCircles() { if (circlesArray) { HideCircles(); circlesArray = []; } }'+sLineBreak+
  '  function HideCircles() { if (circlesArray) { for (var i=0;i<circlesArray.length;i++) { circlesArray[i].setMap(null); } } }'+sLineBreak+
  '  function ShowCircles() { if (circlesArray) { for (var i=0;i<circlesArray.length;i++) { circlesArray[i].setMap(map); } } }';
end;

function TEdgeGoogleMapViewer.GetJSPutPolyline: string;
begin
  Result :=
  '  function PutPolyline(Path, Geodesic, Editable, Visible, Clickable, FitBounds, StrokeColor, StrokeOpacity, StrokeWeight, Info){'+sLineBreak+
  '   var polyline = new google.maps.Polyline({ path: Path, map: map, geodesic: Geodesic, zIndex: 1,'+sLineBreak+
  '     editable: Editable, clickable: Clickable, visible: Visible,'+sLineBreak+
  '     strokeColor: StrokeColor, strokeOpacity: StrokeOpacity, strokeWeight: StrokeWeight });'+sLineBreak+
  '   polylinesArray.push(polyline);'+sLineBreak+
  '   if (Info) { google.maps.event.addListener(polyline, "click", function(event) {'+sLineBreak+
  '     infoWindow.setPosition(event.latLng); infoWindow.setContent(Info); infoWindow.open(map);'+sLineBreak+
  '   }); }'+sLineBreak+
  '   if (FitBounds) { var b = new google.maps.LatLngBounds();'+sLineBreak+
  '     polyline.getPath().forEach(function(latLng) { b.extend(latLng); }); map.fitBounds(b); }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSClearPolylines: string;
begin
  Result :=
  '  function ClearPolylines() { if (polylinesArray) { HidePolylines(); polylinesArray = []; } }'+sLineBreak+
  '  function HidePolylines() { if (polylinesArray) { for (var i=0;i<polylinesArray.length;i++) { polylinesArray[i].setMap(null); } } }'+sLineBreak+
  '  function ShowPolylines() { if (polylinesArray) { for (var i=0;i<polylinesArray.length;i++) { polylinesArray[i].setMap(map); } } }';
end;

function TEdgeGoogleMapViewer.GetJSPutPolygon: string;
begin
  Result :=
  '  function PutPolygon(Path, Editable, Visible, Clickable, FitBounds, StrokeColor, StrokeOpacity, StrokeWeight, FillColor, FillOpacity, Info){'+sLineBreak+
  '   var polygon = new google.maps.Polygon({ path: Path, map: map, zIndex: 1,'+sLineBreak+
  '     editable: Editable, clickable: Clickable, visible: Visible,'+sLineBreak+
  '     strokeColor: StrokeColor, strokeOpacity: StrokeOpacity, strokeWeight: StrokeWeight,'+sLineBreak+
  '     fillColor: FillColor, fillOpacity: FillOpacity });'+sLineBreak+
  '   polygonsArray.push(polygon);'+sLineBreak+
  '   if (Info) { google.maps.event.addListener(polygon, "click", function(event) {'+sLineBreak+
  '     infoWindow.setPosition(event.latLng); infoWindow.setContent(Info); infoWindow.open(map);'+sLineBreak+
  '   }); }'+sLineBreak+
  '   if (FitBounds) { var b = new google.maps.LatLngBounds();'+sLineBreak+
  '     polygon.getPath().forEach(function(latLng) { b.extend(latLng); }); map.fitBounds(b); }'+sLineBreak+
  '  }';
end;

function TEdgeGoogleMapViewer.GetJSClearPolygons: string;
begin
  Result :=
  '  function ClearPolygons() { if (polygonsArray) { HidePolygons(); polygonsArray = []; } }'+sLineBreak+
  '  function HidePolygons() { if (polygonsArray) { for (var i=0;i<polygonsArray.length;i++) { polygonsArray[i].setMap(null); } } }'+sLineBreak+
  '  function ShowPolygons() { if (polygonsArray) { for (var i=0;i<polygonsArray.length;i++) { polygonsArray[i].setMap(map); } } }';
end;

function TEdgeGoogleMapViewer.GetJSGeometry: string;
begin
  Result :=
  '  function ComputeDistanceBetween(FromLat, FromLng, ToLat, ToLng){'+sLineBreak+
  '   var From = new google.maps.LatLng(FromLat, FromLng);'+sLineBreak+
  '   var To = new google.maps.LatLng(ToLat, ToLng);'+sLineBreak+
  '   var distance = google.maps.geometry.spherical.computeDistanceBetween(From, To);'+sLineBreak+
  '   window.chrome.webview.postMessage(JSON.stringify({"event" : "response_value",'+sLineBreak+
  '     "field": "distance", "value": distance} , null, 2));'+sLineBreak+
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
  LJSScript := GetJSVariables + sLineBreak +
  GetJSInitialize + sLineBreak +
  GetJSCodeAddress + sLineBreak +
  GetJSGotoLatLng + sLineBreak +
  GetJSOpenInfoWindow + sLineBreak +
  GetJSClearMarkers + sLineBreak +
  GetJSPutMarker + sLineBreak +
  GetJSPutCustomMarker + sLineBreak +
  GetJSPutMarkerByAddress + sLineBreak +
  GetJSPutCircle + sLineBreak +
  GetJSClearCircles + sLineBreak +
  GetJSPutPolyline + sLineBreak +
  GetJSClearPolylines + sLineBreak +
  GetJSPutPolygon + sLineBreak +
  GetJSClearPolygons + sLineBreak +
  GetJSMapOptions + sLineBreak +
  GetJSMapShowDirectionsPanel + sLineBreak +
  GetJSRouteAddress + sLineBreak +
  GetJSGeometry + sLineBreak +
  GetJSCalcRoute;
  if Assigned(FOnGetJavascript) then
    FOnGetJavascript(Self, LJSScript);
  Result :=
  '<script type="text/javascript"> '+sLineBreak+
  LJSScript + sLineBreak +
  '</script> '+ sLineBreak;
end;




procedure TEdgeGoogleMapViewer.ShowMap(AMapCenter: TLatLng; const AAddress: string = '');
var
  HTMLString  : String;
  LAddress, MyAddress: string;
  MyCenter: TLatLng;
begin
  if csDesigning in ComponentState then
    Exit;

  while not FViewerReady do
  begin
    Application.ProcessMessages;
    Sleep(10);
  end;

  if Assigned(FBeforeShowMap) then
    FBeforeShowMap(Self);

  CheckAPIKeyPresent;

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
      FApiKey, //ApiKey (in header script URL)
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
      AGoogleMapColorScheme[FMapColorScheme], //ColorScheme
      QuotedStr(MyCenter.Description), //Description as Msg
      QuotedStr(MyCenter.Description), //Description as Info
      QuotedStr(LAddress), //Address
      B2S(FTraffic), //Traffic
      B2S(FBicycling) //Bicycling
    ]);
  FMapIsBusy := True;
  try
    {$IFDEF DEBUG2}
    //var LFileName := TPath.GetTempFileName+'.html';
    var LFileName := 'D:\ETHEA\DelphiGoogleMap\test.html';
    DeleteFile(Pchar(LFileName));
    TFile.AppendAllText(LFileName, HTMLString, TEncoding.UTF8);
    LFileName := StringReplace(LFileName, '\', '/', [rfReplaceAll]);
    NavigateToURL('file:///'+LFileName);
    {$ELSE}
    NavigateToString(HTMLString);
    {$ENDIF}
  finally
    FMapIsBusy := False;
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

procedure TEdgeGoogleMapViewer.SetApiKey(const Value: string);
begin
  RegisterGoogleMapsApiKey(Value);
end;

function TEdgeGoogleMapViewer.GetAPIKey: string;
begin
  Result := FApiKey;
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
  FMapVisible := False;
  if FViewerReady then
    Navigate(ABOUT_BLANK_PAGE);

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
begin
  DoPutMarker(LatLng, ADescription, AAnimation, ALabel, '', AInfoWindowContent, ACustomMarkerJSON);
end;

procedure TEdgeGoogleMapViewer.PutMarker(LatLng: TLatLng; ADescription : string;
  AInfoTitle: string; AAnimation : TGoogleMarkerAnimationId;
  ALabel, AInfoWindowContent, ACustomMarkerJSON: string);
begin
  DoPutMarker(LatLng, ADescription, AAnimation, ALabel, AInfoTitle, AInfoWindowContent, ACustomMarkerJSON);
end;

procedure TEdgeGoogleMapViewer.DoPutMarker(LatLng: TLatLng; const ADescription: string;
  AAnimation: TGoogleMarkerAnimationId; const ALabel, AInfoTitle,
  AInfoWindowContent, ACustomMarkerJSON: string);
var
  LScriptCommand: String;
  LInfoWindowContent : string;
  LAnimation : string;
begin
  if not MapVisible then
  begin
    ShowMap(EmptyLatLng);
    while FMapIsBusy do
      Sleep(10);
  end;
  LInfoWindowContent := AInfoWindowContent;
  if (LInfoWindowContent = '') and (AInfoTitle = '') then
    LInfoWindowContent := ADescription;
  LAnimation := Format('google.maps.Animation.%s',[AGoogleMarkerAnimationId[AAnimation]]);
  if ACustomMarkerJSON = '' then
  begin
    LScriptCommand := Format('PutMarker(%s, %s, %s, %s, %s, %s, %s)',[
      CoordToText(LatLng.Latitude),
      CoordToText(LatLng.Longitude),
      QuotedStr(ADescription),
      LAnimation,
      QuotedStr(ALabel),
      QuotedStr(StripCRLF(AInfoTitle)),
      QuotedStr(StripCRLF(LInfoWindowContent))
      ]);
  end else
  begin
    LScriptCommand := Format('PutCustomMarker(%s, %s, %s, %s, %s, %s, %s)',[
      CoordToText(LatLng.Latitude),
      CoordToText(LatLng.Longitude),
      QuotedStr(ADescription),
      QuotedStr(ALabel),
      QuotedStr(StripCRLF(AInfoTitle)),
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
    while FMapIsBusy do
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
  if not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
  begin
    InitMap;
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
    while FMapIsBusy do
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

procedure TEdgeGoogleMapViewer.CheckAPIKeyPresent;
begin
  if FApiKey = '' then
    raise EGoogleMapError.Create(ERROR_API_KEY);
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
    while FMapIsBusy do
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
    while FMapIsBusy do
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


//Circles

procedure TEdgeGoogleMapViewer.ClearCircles;
begin
  ExecuteScript('ClearCircles()');
end;

procedure TEdgeGoogleMapViewer.HideCircles;
begin
  ExecuteScript('HideCircles()');
end;

procedure TEdgeGoogleMapViewer.ShowCircles;
begin
  ExecuteScript('ShowCircles()');
end;

procedure TEdgeGoogleMapViewer.PutCircle(LatLng: TLatLng; Radius: Double; Editable, Draggable, Visible, Clickable: Boolean;
    StrokeColor: String; StrokeOpacity: Double; StrokeWeight: Integer; FillColor: String; FillOpacity: Double;
    AInfoWindowContent : string = '');
var
  LScriptCommand: String;
begin
  FormatSettings.DecimalSeparator := '.';
  if not MapVisible then
  begin
    ShowMap(EmptyLatLng);
    while FMapIsBusy do
      Sleep(10);
  end;
  LScriptCommand := Format('PutCircle(%s, %s, %f, %s, %s, %s, %s, %s, %f, %d, %s, %f,%s)',[
    CoordToText(LatLng.Latitude),
    CoordToText(LatLng.Longitude),
    Radius,
    LowerCase(BoolToStr(Editable, True)),
    LowerCase(BoolToStr(Draggable, True)),
    LowerCase(BoolToStr(Visible, True)),
    LowerCase(BoolToStr(Clickable, True)),
    QuotedStr(StripCRLF(StrokeColor)),
    StrokeOpacity,
    StrokeWeight,
    QuotedStr(StripCRLF(FillColor)),
    FillOpacity,
    QuotedStr(StripCRLF(AInfoWindowContent))
    ]);
  ExecuteScript(LScriptCommand);
end;

//Polylines

procedure TEdgeGoogleMapViewer.ClearPolylines;
begin
  ExecuteScript('ClearPolylines()');
end;

procedure TEdgeGoogleMapViewer.HidePolylines;
begin
  ExecuteScript('HidePolylines()');
end;

procedure TEdgeGoogleMapViewer.ShowPolylines;
begin
  ExecuteScript('ShowPolylines()');
end;

procedure TEdgeGoogleMapViewer.PutPolyline(Path:String; Geodesic, Editable, Visible, Clickable, FitBounds: Boolean;
    StrokeColor: String; StrokeOpacity: Double; StrokeWeight: Integer;
    AInfoWindowContent : string = '');
var
  LScriptCommand: String;
begin
  FormatSettings.DecimalSeparator := '.';
  if not MapVisible then
  begin
    ShowMap(EmptyLatLng);
    while FMapIsBusy do
      Sleep(10);
  end;
  LScriptCommand := Format('PutPolyline(%s, %s, %s, %s, %s, %s, %s, %f, %d, %s)',[
    Path,
    LowerCase(BoolToStr(Geodesic, True)),
    LowerCase(BoolToStr(Editable, True)),
    LowerCase(BoolToStr(Visible, True)),
    LowerCase(BoolToStr(Clickable, True)),
    LowerCase(BoolToStr(FitBounds, True)),
    QuotedStr(StripCRLF(StrokeColor)),
    StrokeOpacity,
    StrokeWeight,
    QuotedStr(StripCRLF(AInfoWindowContent))
    ]);
  ExecuteScript(LScriptCommand);
end;

function TEdgeGoogleMapViewer.ComputeDistanceBetween(Origin, Destination: TLatLng): Double;
Const
  MaxTimeResponse = 2000; //Miliseconds
  Step = 1; //Miliseconds
var
  LScriptCommand: String;
  i: Integer;
Begin
    LScriptCommand := Format('ComputeDistanceBetween(%s, %s, %s, %s)',[
      CoordToText(Origin.Latitude),
      CoordToText(Origin.Longitude),
      CoordToText(Destination.Latitude),
      CoordToText(Destination.Longitude)
    ]);
    FDistance:=Null;
    ExecuteScript(LScriptCommand);
    //Wait for response
    i:=0;
    while (FDistance=Null) and (I<MaxTimeResponse)do
    Begin
        Application.ProcessMessages;
        Sleep(Step);
        I:=I+Step;
    End;
    if FDistance<>Null then
      Result:=FDistance
    Else
      raise EGoogleMapError.Create('ComputeDistanceBetween timeout');
End;
//Polygon

procedure TEdgeGoogleMapViewer.ClearPolygons;
begin
  ExecuteScript('ClearPolygons()');
end;

procedure TEdgeGoogleMapViewer.HidePolygons;
begin
  ExecuteScript('HidePolygons()');
end;

procedure TEdgeGoogleMapViewer.ShowPolygons;
begin
  ExecuteScript('ShowPolygons()');
end;

procedure TEdgeGoogleMapViewer.PutPolygon(Path:String; Editable, Visible, Clickable, FitBounds: Boolean;
    StrokeColor: String; StrokeOpacity: Double; StrokeWeight: Integer; FillColor: String; FillOpacity: Double;
    AInfoWindowContent : string = '');
var
  LScriptCommand: String;
begin
  FormatSettings.DecimalSeparator := '.';
  if not MapVisible then
  begin
    ShowMap(EmptyLatLng);
    while FMapIsBusy do
      Sleep(10);
  end;
  LScriptCommand := Format('PutPolygon(%s, %s, %s, %s, %s, %s, %f, %d, %s, %f, %s)',[
    Path,
    LowerCase(BoolToStr(Editable, True)),
    LowerCase(BoolToStr(Visible, True)),
    LowerCase(BoolToStr(Clickable, True)),
    LowerCase(BoolToStr(FitBounds, True)),
    QuotedStr(StripCRLF(StrokeColor)),
    StrokeOpacity,
    StrokeWeight,
    QuotedStr(StripCRLF(FillColor)),
    FillOpacity,
    QuotedStr(StripCRLF(AInfoWindowContent))
    ]);
  ExecuteScript(LScriptCommand);
end;

end.

