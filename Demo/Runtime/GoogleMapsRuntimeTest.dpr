program GoogleMapsRuntimeTest;

uses
  Forms,
  MIdasLib,
  MainForm in 'MainForm.pas' {formMain},
  Vcl.GoogleMap in '..\..\Source\Vcl.GoogleMap.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Delphi with Edge Google Maps Viewer Component Demo';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
