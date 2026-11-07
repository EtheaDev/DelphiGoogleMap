# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**TEdgeGoogleMapViewer** — A Delphi VCL component wrapping Google Maps via WebView2 (Chromium-based Edge browser). Provides routing, markers, circles, polylines, polygons, and geometry calculations. Apache 2.0 licensed, by Carlo Barazzetta / Ethea S.r.l.

## Build & Install

Packages live in `Packages/D10_4`, `D11`, `D12`, `D13` (one folder per Delphi version). Each contains:
- `DelphiGoogleMap.dpk` — runtime package
- `dclDelphiGoogleMap.dpk` — design-time package
- `DelphiGoogleMapsPackages.groupproj` — group project to build both

**To build manually:** Open the group project for your Delphi version, build the runtime package first, then build+install the design-time package. Add the `Source` folder to Delphi's library path.

**Automated installer:** Run `Setup/BuildSetup.bat` to build the Inno Setup installer (`Setup/Setup.iss`).

## Architecture

### Source Files

- **`Source/Vcl.GoogleMap.pas`** — The whole runtime component. `TEdgeGoogleMapViewer` inherits from `TCustomEdgeBrowser`, generates the full HTML page (header, style, inline JavaScript, body) as Pascal strings and loads it with `NavigateToString`. All map features (navigation, routing, overlays, events) are here.
- **`Source/Vcl.GoogleMapRegister.pas`** — Design-time registration: component editor, splash screen, about box, palette registration under "Ethea" category. Includes `Packages/DelphiGoogleMapsSplash.res` (splash/about bitmaps loaded as RCDATA).

### Runtime vs Design-time Split

The runtime package (`DelphiGoogleMap.bpl`) contains `Vcl.GoogleMap.pas` and is required by end-user applications. The design-time package (`dclDelphiGoogleMap.bpl`) contains `Vcl.GoogleMapRegister.pas` and is only loaded in the IDE.

### Key Dependencies

- **Delphi RTL/VCL** — standard units plus `Vcl.Edge` and `WebView2` for browser control
- **REST.Json / System.JSON** — JSON handling for markers and data exchange
- **Google Maps JavaScript API** — loaded by a synchronous `<script src=".../maps/api/js?key=...&libraries=geometry,marker">` in the page header; `initialize()` runs from `<body onload>`. Requires a valid API key (`MapAPIKey` property / `RegisterGoogleMapsApiKey`). Uses `AdvancedMarkerElement` (with `mapId`) when there is no animation/label, otherwise (and as fallback) the legacy `Marker`; `PutCustomMarker` always uses the legacy `Marker`.
- **WebView2Loader.dll** — must ship with the application (copies in `Demo/GoogleMaps/Bin/Win32` and `Win64`)

### Demo Application

`Demo/GoogleMaps/GoogleMapsTest.dproj` — comprehensive demo showcasing all component features.

**Initialization pattern** (in `MainForm.pas` initialization section):
1. `TEdgeGoogleMapViewer.RegisterUserDataFolder(...)` — sets WebView2 temp folder (required before any map usage)
2. `TEdgeGoogleMapViewer.RegisterGoogleMapsApiKey('...')` — registers the Google Maps API key globally (class method, shared by all instances)

**MainForm (`MainForm.pas`)** — the main demo form, structured in panels:

- **Top panel (`PanelHeader`)**: Show/Hide/Print map buttons, map attribute controls (zoom via `TSpinEdit`, map type via `TComboBox`), map control toggles (traffic, bicycling, street view, fullscreen, zoom, map type controls — each a `TCheckBox` that calls the corresponding `EdgeGoogleMapViewer.Show*` or sets `MapShow*` properties).

- **Navigation GroupBox**: Address-based navigation (`GotoAddress`) and coordinate-based navigation (`GotoLocation`). Uses `TEdgeGoogleMapViewer.TextToCoord` / `CoordToText` class methods for locale-safe coordinate parsing.

- **Routing GroupBox**: Two modes — route by lat/lng coordinates (`RouteByLocations`) and route by addresses (`RouteByAddresses`). Travel mode selector (`TGoogleRouteModeId`) and optional directions panel (`MapShowDirectionsPanel`).

- **Drawing section (`PCDrawing` TPageControl)** with tabs for each overlay type:
  - **Markers tab**: Add markers with lat/lng, description, label, animation (`TGoogleMarkerAnimationId`), optional info window, and optional custom JSON (`DefaultCustomMarkerJSON` provides the template). "By Address" sub-tab for geocoding-based marker placement (`PutMarkerByAddress`). Show/Hide/Clear markers.
  - **Circles tab**: Add circles with center lat/lng, radius, editable/draggable/visible/clickable flags, stroke and fill colors/opacity/weight. Show/Hide/Clear circles.
  - **Polylines tab**: Add polylines from a path (text list of coordinates), geodesic flag, stroke styling, fitBounds option. Show/Hide/Clear polylines.
  - **Polygons tab**: Same structure as polylines with additional fill color/opacity. Show/Hide/Clear polygons.
  - **Geometry tab**: `ComputeDistanceBetween` — calculates distance in meters between two lat/lng points.

- **Bottom panel**: `TDBGrid` + `TDBNavigator` bound to `cdsCustomers` (`TClientDataSet` loaded from `Data/customer.xml`). On `AfterScroll`, the dataset builds an address from fields (Addr1, Addr2, City, State, Country) and calls `GotoAddress` — demonstrating data-driven map navigation.

- **Events**: `OnMapClick` centers the map if `cbCenterOnClick` is checked; `OnMapRightClick` stores the clicked coordinates and shows a popup menu to add a marker at that position; `OnMapZoom` syncs the zoom SpinEdit.

- **Fullscreen handling**: `OnContainsFullScreenElementChanged` hides/shows the header and bottom panels to give the map full screen.

**SecondaryForm (`SecondaryForm.pas`)** — a simpler second form (opened via Button1) demonstrating multiple `TEdgeGoogleMapViewer` instances in the same application. Has basic navigation, routing, and layer controls. Shows the `BeforeShowMap` event pattern to prompt for API key if not already registered.

## Multi-Version Support

Supported: Delphi 10.4.2, 11 Alexandria, 12 Athens, 13 Florence.

Each version has its own package folder; the runtime package requires `rtl`, `vcl`, `vcledge`, `RESTComponents`.

## Key Types & API

- `TEdgeGoogleMapViewer` — main component class
- `TLatLng` — record with `Latitude`, `Longitude`, `Description`
- `TGoogleMapTypeId` — `mtROADMAP`, `mtSATELLITE`, `mtHYBRID`, `mtTERRAIN`
- `TGoogleRouteModeId` — `rmDRIVING`, `rmWALKING`, `rmBICYCLING`, `rmTRANSIT`
- `TGoogleMapColorScheme` — `csLIGHT`, `csDARK` (v2.0)
- Core methods: `GotoAddress`, `GotoLocation`, `RouteByLocations`, `RouteByAddresses`, `PutMarker` (two overloads), `PutMarkerByAddress`, `PutCircle`, `PutPolyline`, `PutPolygon`
- Key properties (v2.0): `MapColorScheme` (light/dark theme, requires map recreation)

## Page & JavaScript generation

There is no separate `.js` file or resource: the JavaScript is written inline as Pascal strings
in `Vcl.GoogleMap.pas`, one `protected virtual` function per block (`GetJSVariables`,
`GetJSInitialize`, `GetJSPutMarker`, `GetJSPutCircle`, ...). To change JS behavior, edit those
functions (or override them in a descendant).

How `ShowMap` builds the page:
1. `GetHTMLScript` concatenates the `GetJS*` blocks. `GetJSInitialize` is a `Format` template
   (`%s`/`%d` for center, zoom, controls, map type, color scheme, description, address, layers):
   `GetHTMLScript` fills it with the values that `ShowMap` stores in `FShowCenter`/`FShowAddress`.
2. `OnGetJavascript` then receives the **final** JavaScript (no placeholders; a literal `%` is
   written as `%`).
3. A `load` listener is appended that posts `{"event":"map_ready"}` after `initialize()`.
4. The whole page (`GetHTMLHeader + GetHTMLStyle + GetHTMLScript + GetHTMLBody`) goes through one
   last `Format` that only inserts the API key in the header: script, style and body double every
   `%` (`%%`) before that, so any new text added to them must do the same.

Rules for Pascal → JavaScript values:
- Strings: always `JSQuotedStr(...)` (JS string literal, escapes quotes, newlines, `</script>`...).
  Never `QuotedStr`, which is Pascal escaping and breaks on apostrophes.
- Coordinates: `CoordToText` (invariant, 6 decimals); other floats: `Format(..., TFormatSettings.Invariant)`
  with `%g`. Never change the global `FormatSettings`.
- Booleans: `B2S`.

Synchronization and events:
- `NavigateToString` is asynchronous. `ShowMap` sets `FMapIsBusy := True`; the `map_ready` message
  clears it. Methods that may need to show the map first (`Put*`, routing, `ComputeDistanceBetween`)
  call `EnsureMapReady` (show if hidden + `WaitForMapReady`, which pumps messages, 15 s timeout)
  before `ExecuteScript`.
- JS → Delphi messages (`click`, `rightclick`, `zoom_changed`, `response_value`, `map_ready`) are
  JSON strings sent with `window.chrome.webview.postMessage` and parsed in `HandleWebMessageEvent`;
  unknown messages go to `OnWebUnhandledMessageReceived`. User event handlers are called outside the
  parsing `try/except`, and `CustomWebMessageReceived` reports their exceptions with
  `Application.HandleException` (never let an exception escape a WebView2 callback).
- `OnNavigationCompleted`, `OnCreateWebViewCompleted` and `OnWebMessageReceived` are **redeclared**
  in `TEdgeGoogleMapViewer` with their own fields: the inherited `TCustomEdgeBrowser` events are
  hooked in the constructor (via a `TCustomEdgeBrowser(Self)` cast) by the internal handlers, which
  then call the user's handlers. Don't assign the inherited events elsewhere.

## DPM package (delphi.dev)

The library is also published as a DPM package (Delphi Package Manager, https://delphi.dev,
organization EtheaDev): spec `EtheaDev.DelphiGoogleMap.dspec` in the root (id `EtheaDev.DelphiGoogleMap`). It is packed from the GitHub
clone and pushed by `D:\ETHEA\GitHub_EtheaDev\_sync\sync_project.py DelphiGoogleMap --release`; `version`
is aligned to the README release notes automatically and `repositoryCommit: '#HASH#'` is replaced
at pack time: don't edit them by hand.

**Keep the dspec aligned with the packages and the Setup**: when a package folder is added or
removed (new Delphi version), a `.dpk` is added/renamed, a new kind of file is needed by the
packages (`.dfm`, `.res`, `.dcr`, ...), or a platform is enabled/disabled in a runtime `.dproj`,
update `targetPlatforms` / `templates` (`source`, `build`, `design`) in the same commit. Check
with `python D:\ETHEA\GitHub_EtheaDev\_sync\dpm_tools.py DelphiGoogleMap`: the publishing script refuses
to commit/release while the check fails.

- Delphi 10.4 to 13, Win32/Win64. `copyLocal` copies `WebView2Loader.dll` (taken from
  `Demo\GoogleMaps\Bin\Win32|Win64`) next to the executable.
