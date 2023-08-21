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
unit Vcl.GoogleMapRegister;

interface

uses
  System.Classes
  , DesignIntf
  , DesignEditors
  , VCLEditors;

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
  , System.SysUtils
  , System.StrUtils
  , Winapi.ShellApi
  , Winapi.Windows
  ;

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
  RegisterComponentEditor(TEdgeGoogleMapViewer, TEdgeGoogleMapCompEditor);
  RegisterComponents('Ethea', [TEdgeGoogleMapViewer]);
end;

end.

