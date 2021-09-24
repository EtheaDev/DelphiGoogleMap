program GoogleMapsTest;

uses
  Forms,
  MIdasLib,
  MainForm in 'MainForm.pas' {formMain},
  Vcl.GoogleMap in '..\..\Source\Vcl.GoogleMap.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
