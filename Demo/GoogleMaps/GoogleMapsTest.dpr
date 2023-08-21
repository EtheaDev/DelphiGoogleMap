program GoogleMapsTest;

uses
  Forms,
  MIdasLib,
  MainForm in 'MainForm.pas' {formMain},
  Vcl.GoogleMap in '..\..\Source\Vcl.GoogleMap.pas',
  SecondaryForm in 'SecondaryForm.pas' {FormSecondary};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Delphi with Edge Google Maps Viewer Component Demo';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
