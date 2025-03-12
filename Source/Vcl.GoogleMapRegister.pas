{******************************************************************************}
{                                                                              }
{       Delphi Google Map Viewer                                               }
{                                                                              }
{       Copyright (c) 2021-2025 (Ethea S.r.l.)                                 }
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
unit Vcl.GoogleMapRegister;

interface

{$R ..\DelphiGoogleMapsSplash.res}

uses
  System.Classes
  , DesignIntf
  , DesignEditors
  , VCLEditors
  , System.Types
  , Vcl.Graphics
  ;

type
  TEdgeGoogleMapCompEditor = class(TComponentEditor)
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

procedure Register;

implementation

uses
  Vcl.GoogleMap
  , BrandingAPI
  , System.SysUtils
  , System.StrUtils
  , Winapi.ShellApi
  , Winapi.Windows
  , ToolsAPI
  , Vcl.Imaging.PngImage
  ;

const
  Component_Docs_URL = 'https://github.com/EtheaDev/DelphiGoogleMap';
  {$IF (CompilerVersion >= 28.0)}
  ABOUT_RES_NAME = 'GOOGLEMAPS_SPLASH48PNG';
  SPLASH_RES_NAME = 'GOOGLEMAPS_SPLASH48PNG';
  {$ELSE}
  ABOUT_RES_NAME = 'GOOGLEMAPS_SPLASH24BMP';
  SPLASH_RES_NAME = 'GOOGLEMAPS_SPLASH24BMP';
  {$IFEND}
  RsAboutTitle = 'Ethea Google Maps Viewer';
  RsAboutDescription = 'Ethea - Google Maps Viewer Component - https://github.com/EtheaDev/DelphiGoogleMap/' + sLineBreak +
    'Delphi WebView2 Component to View Google Map with Routing and Markers Support';
  RsAboutLicense = 'Apache 2.0 (Free/Opensource)';
var
  AboutBoxServices: IOTAAboutBoxServices = nil;
  AboutBoxIndex: Integer;

{$IF (CompilerVersion >= 28.0)}
function CreateBitmapFromPngRes(const AResName: string): Vcl.Graphics.TBitmap;
var
  LPngImage: TPngImage;
  LResStream: TResourceStream;
begin
  LPngImage := nil;
  try
    Result := Vcl.Graphics.TBitmap.Create;
    LPngImage := TPngImage.Create;
    LResStream := TResourceStream.Create(HInstance, AResName, RT_RCDATA);
    try
      LPngImage.LoadFromStream(LResStream);
      Result.Assign(LPngImage);
    finally
      LResStream.Free;
    end;
  finally
    LPngImage.Free;
  end;
end;

procedure RegisterAboutBox;
var
  LBitmap: Vcl.Graphics.TBitmap;
begin
  Supports(BorlandIDEServices,IOTAAboutBoxServices, AboutBoxServices);
  LBitmap := CreateBitmapFromPngRes(ABOUT_RES_NAME);
  try
    AboutBoxIndex := AboutBoxServices.AddPluginInfo(
      RsAboutTitle+' '+DelphiGoogleMapViewerVersion,
      RsAboutDescription, LBitmap.Handle, False, RsAboutLicense);
  finally
    LBitmap.Free;
  end;
end;

procedure UnregisterAboutBox;
begin
  if (AboutBoxIndex <> 0) and Assigned(AboutBoxServices) then
  begin
    AboutBoxServices.RemovePluginInfo(AboutBoxIndex);
    AboutBoxIndex := 0;
    AboutBoxServices := nil;
  end;
end;

procedure RegisterWithSplashScreen;
var
  LBitmap: Vcl.Graphics.TBitmap;
begin
  LBitmap := CreateBitmapFromPngRes(SPLASH_RES_NAME);
  try
    SplashScreenServices.AddPluginBitmap(
      RsAboutTitle+' '+DelphiGoogleMapViewerVersion,
      LBitmap.Handle, False, RsAboutLicense, '');
  finally
    LBitmap.Free;
  end;
end;
{$ELSE}
procedure RegisterAboutBox;
var
  ProductImage: HBITMAP;
begin
  Supports(BorlandIDEServices,IOTAAboutBoxServices, AboutBoxServices);
  ProductImage := LoadBitmap(FindResourceHInstance(HInstance), ABOUT_RES_NAME);
  AboutBoxIndex := AboutBoxServices.AddPluginInfo(RsAboutTitle+' '+SVGIconImageListVersion, 
    RsAboutDescription, ProductImage, False, RsAboutLicense);
end;

procedure UnregisterAboutBox;
begin
  if (AboutBoxIndex <> 0) and Assigned(AboutBoxServices) then
  begin
    AboutBoxServices.RemovePluginInfo(AboutBoxIndex);
    AboutBoxIndex := 0;
    AboutBoxServices := nil;
  end;
end;

procedure RegisterWithSplashScreen;
var
  ProductImage: HBITMAP;
begin
  ProductImage := LoadBitmap(FindResourceHInstance(HInstance), SPLASH_RES_NAME);
  SplashScreenServices.AddPluginBitmap(RsAboutTitle, ProductImage,
    False, RsAboutLicense);
end;
{$IFEND}

{ TEdgeGoogleMapCompEditor }

procedure TEdgeGoogleMapCompEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  if Index = 0 then
  begin
    ShellExecute(0, 'open',
      PChar('https://github.com/EtheaDev/DelphiGoogleMap'), nil, nil,
      SW_SHOWNORMAL)
  end;
end;

function TEdgeGoogleMapCompEditor.GetVerb(Index: Integer): string;
begin
  Result := '';
  case Index of
    0: Result := Format('Ver. %s - (c) Ethea S.r.l. - show help...',[DelphiGoogleMapViewerVersion]);
  end;
end;

function TEdgeGoogleMapCompEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Register;
begin
  RegisterWithSplashScreen;

  RegisterComponentEditor(TEdgeGoogleMapViewer, TEdgeGoogleMapCompEditor);
  RegisterComponents('Ethea', [TEdgeGoogleMapViewer]);
end;


initialization
  RegisterAboutBox;

finalization
  UnRegisterAboutBox;

end.

