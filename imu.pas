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
    constructor Create( const powerhandler : TPowerHandler; const powersource : DeviceIDtype; const can_id : Integer; const Channel : Integer );
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
  const powersource: DeviceIDtype; const can_id: Integer; const Channel : Integer );
begin
  inherited Create(powerhandler, powersource, can_id, Channel, 10);
end;

function StuffMsg(const A, B, C, D, E, F, G, H: byte): TMsgArray;
begin
  result[0] := A;
  result[1] := B;
  result[2] := C;
  result[3] := D;
  result[4] := E;
  result[5] := F;
  result[6] := G;
  result[7] := H;
end;

procedure TIMUHandler.CyclicHandler;
var
//  msg: array[0..7] of byte;
  msg : TMsgArray;
  CurTime : TDateTime;
  Year, Month, Day, Hour, Min, Sec, Msec : Word;
begin

  msg :=  StuffMsg($FF,$00,$FF,$00,$FF,$FF,$95,$00);
  CanSend( $101, msg, 8, 0);

  msg :=  StuffMsg($D0, $3A, $81, $32, $7F, $00, $07, $00);
  CanSend( $100, msg, 8, 0);

  msg :=  StuffMsg( $D0, $3A, $81, $32, $32, $E9, $0C, $00 );
  CanSend( $110, msg, 8, 0);

    msg :=  StuffMsg(  $CF, $00, $01, $00, $42, $FC, 0, 0);
  CanSend( $121, msg, 6, 0);

    msg :=  StuffMsg($00, $00, $00, $00, $00, $00, 0, 0 );
  CanSend( $122, msg, 6, 0);

     msg :=  StuffMsg( $CF, $00, $00, $00, $42, $FC, 0, 0 );
  CanSend( $123, msg, 6, 0);

    msg :=  StuffMsg( $00, $00, $FF, $FF, $00, $00, 0, 0 );
  CanSend( $124, msg, 6, 0);

  msg :=  StuffMsg($F8, $FF, $4E, $08, $BF, $5D, 0, 0 );
  CanSend( $132, msg, 6, 0);

  msg :=  StuffMsg($51, $00, $75, $00, $B2, $FF , 0, 0 );
  CanSend( $137, msg, 6, 0);

  msg :=  StuffMsg($24, $00, $73, $FF, $B8, $FF, 0, 0 );
  CanSend( $139, msg, 6, 0);

  msg :=  StuffMsg($03, $F3, $7E, $32, $01, $00, $00, $00 );
  CanSend( $170, msg, 8, 0);

  msg :=  StuffMsg($00, $00, $00, $00, $00, $00, 0, 0 );
  CanSend( $171, msg, 6, 0);

  msg :=  StuffMsg($00, $66, $00, $66, $00, $66, 0, 0 );
  CanSend( $172, msg, 6, 0);

  msg :=  StuffMsg($D1, $25, $13, $C8, $10, $27, 0, 0 );
  CanSend( $220, msg, 6, 0);
end;

{ TIMUForm }

procedure TIMUForm.ConnectedClick(Sender: TObject);
begin
    IMUDevice.Enabled := Connected.Checked;
end;

end.
