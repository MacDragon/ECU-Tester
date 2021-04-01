program ECUCanTest;

uses
  Vcl.Forms,
  CanTest in 'CanTest.pas' {MainForm},
  canchanex in 'canchanex.pas',
  powernode in 'powernode.pas',
  consts in 'consts.pas',
  device in 'device.pas',
  PowerHandler in 'PowerHandler.pas' {PowerNodesForm},
  global in 'global.pas',
  eeprom in 'eeprom.pas',
  frontspeed in 'frontspeed.pas',
  pdm in 'pdm.pas' {PDMForm},
  analognode in 'analognode.pas' {AnalogNodesForm},
  bms in 'bms.pas' {BMSForm},
  ivt in 'ivt.pas' {IVTForm},
  imu in 'imu.pas' {IMUForm},
  memorator in 'memorator.pas' {MemoratorForm},
  devicelist in 'devicelist.pas',
  siemensinverter in 'siemensinverter.pas' {SiemensInverterForm},
  lenzeinverter in 'lenzeinverter.pas' {LenzeInverterForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
// Application.CreateForm(TSiemensInverterForm, SiemensInverterForm);
//  Application.CreateForm(TLenzeInverterForm, LenzeInverterForm);
  //  Application.CreateForm(TIMUForm, IMUForm);
//  Application.CreateForm(TMemoratorForm, MemoratorForm);
//  Application.CreateForm(TInverterForm, InverterForm);
//  Application.CreateForm(TPDMForm, PDMForm);
//  Application.CreateForm(TAnalogNodesForm, AnalogNodesForm);
//  Application.CreateForm(TPowerNodesForm, PowerNodesForm);
//  Application.CreateForm(TBMSForm, BMSForm);
//  Application.CreateForm(TIVTForm, IVTForm);
  Application.Run;
end.
