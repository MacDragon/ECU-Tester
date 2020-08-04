unit pdm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.CheckLst, device, global, powerhandler, Vcl.StdCtrls;

type
  TPDMHandler = class(TDevice)
  public
    constructor Create( const powerhandler : TPowerHandler; const powersource : DeviceIDtype; const can_id : Integer; const Channel : Integer );
  private
    procedure unplug; override;
    procedure CyclicHandler; override;
  end;

  TPDMForm = class(TForm)
    PDMGroup: TGroupBox;
    IMD: TCheckBox;
    BSPD: TCheckBox;
    BMS: TCheckBox;
    ShutD: TCheckBox;
    connected: TCheckBox;
    procedure connectedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PDMForm: TPDMForm;
  PDMDevice : TPDMHandler;

implementation

uses CanTest, powernode;

{$R *.dfm}

procedure TPDMHandler.unplug;
begin
  inherited;
end;

procedure TPDMHandler.CyclicHandler;
var
  msg: array[0..7] of byte;
  i : integer;
begin

  msg[1] := msg[1];//+badvalue;
 // if badvalue>0 then badvalue := badvalue-1;
  msg[3] := 100;
  msg[4] := 100;
  msg[5] := 0;
 // msg[6] := 0;

  if PDMForm.BMS.checked then msg[0] := 1 else msg[0] := 0;
  if PDMForm.IMD.checked then msg[1] := 1 else msg[1] := 0;
  if PDMForm.BSPD.checked then msg[2] := 1 else msg[2] := 0;

  if PDMForm.ShutD.checked then msg[6] := 0 else msg[6] := 1;

  if msg[6] = 1 then
  begin
     msg[7] := msg[6];
  end;

  msg[7] := msg[6]; // checked to be equal.

  CanSend($520,msg,8,0);  // PDM
end;

constructor TPDMHandler.Create(const powerhandler: TPowerHandler;
  const powersource: DeviceIDtype; const can_id: Integer; const Channel : Integer);
begin
  inherited Create(powerhandler, powersource, can_id, Channel, 20);
end;


procedure TPDMForm.connectedClick(Sender: TObject);
begin
 PDMdevice.Enabled := connected.Checked;
end;

end.
