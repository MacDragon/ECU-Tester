program ECUCanTest;

uses
  Vcl.Forms,
  CanTest in 'CanTest.pas' {MainForm},
  canchanex in 'canchanex.pas',
  powernode in 'powernode.pas',
  analognode in 'analognode.pas',
  consts in 'consts.pas',
  ivt in 'ivt.pas',
  device in 'device.pas',
  PowerNodeHandler in 'PowerNodeHandler.pas',
  global in 'global.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
