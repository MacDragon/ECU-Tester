unit imu;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.CheckLst, device, global, Vcl.StdCtrls, PowerHandler;

type
  TIMUForm = class(TForm)
    Connected: TCheckBox;
    procedure ConnectedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  TIMUHandler = class(TDevice)
  public
    constructor Create( const powerhandler : TPowerHandler; const powersource : DeviceIDtype; const can_id : Integer );
  protected
    procedure CyclicHandler; override;
  end;

var
  IMUDevice : TIMUHandler;
  IMUForm: TIMUForm;

implementation

uses System.DateUtils, CanTest, powernode;

{$R *.dfm}

constructor TIMUHandler.Create(const powerhandler: TPowerHandler;
  const powersource: DeviceIDtype; const can_id: Integer);
begin
  inherited Create(powerhandler, powersource, can_id, 10);
end;

procedure TIMUHandler.CyclicHandler;
var
  msg: array[0..7] of byte;
  CurTime : TDateTime;
  Year, Month, Day, Hour, Min, Sec, Msec : Word;
begin

end;

{ TIMUForm }

procedure TIMUForm.ConnectedClick(Sender: TObject);
begin
    IMUDevice.Enabled := Connected.Checked;
end;

end.
