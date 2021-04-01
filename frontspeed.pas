unit frontspeed;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.CheckLst, device, global, Vcl.StdCtrls, PowerHandler;

type
  TFrontSpeedForm = class(TForm)
    LConnected: TCheckBox;
    RConnected: TCheckBox;
    procedure LConnectedClick(Sender: TObject);
    procedure RConnectedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TFrontSpeedHandler = class(TDevice)
  public
    constructor Create( const powerhandler : TPowerHandler; const powersource : DeviceIDtype; const can_id : Integer );
  protected
    procedure CyclicHandler; override;
    procedure SyncHandler; override;
  end;

var
  FrontLSpeedDevice : TFrontSpeedHandler;
  FrontRSpeedDevice : TFrontSpeedHandler;
  FrontSpeedForm: TFrontSpeedForm;

implementation

uses System.DateUtils, CanTest, powernode;

{$R *.dfm}


constructor TFrontSpeedHandler.Create(const powerhandler: TPowerHandler;
  const powersource: DeviceIDtype; const can_id: Integer);

begin
  inherited Create(powerhandler, powersource, can_id, 10);
end;

procedure TFrontSpeedHandler.CyclicHandler;
var
  msg: array[0..7] of byte;
begin
    msg[0] := 0;
    msg[1] := 0;
    msg[2] := 0;
    CanSend(can_id+$700,msg,3,0);  // $711
end;

procedure TFrontSpeedHandler.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
  for i := 0 to 7 do
  msgout[i] := 0;

  msgout[0] := 127;
//   msgout[1] := byte(500);
  CanSend(can_id+$180,msgout,8,0);  //  $1f0
end;



{ TFrontSpeedForm }

procedure TFrontSpeedForm.RConnectedClick(Sender: TObject);
begin
    FrontrSpeedDevice.Enabled := RConnected.Checked;
end;

procedure TFrontSpeedForm.FormCreate(Sender: TObject);
begin
  FrontLSpeedDevice := TFrontSpeedHandler.Create(Power, DeviceIDType.Front2, $70);
  FrontRSpeedDevice := TFrontSpeedHandler.Create(Power, DeviceIDType.Front2, $71);
end;

procedure TFrontSpeedForm.LConnectedClick(Sender: TObject);
begin
    FrontlSpeedDevice.Enabled := LConnected.Checked;
end;

end.
