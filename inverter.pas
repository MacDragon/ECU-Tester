unit inverter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.CheckLst, device, global, Vcl.StdCtrls, PowerHandler, Vcl.ExtCtrls;

type
  TInverterForm = class(TForm)
    Connected: TCheckBox;
    InverterL1Internal: TLabel;
    InverterL1Stat: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    InverterR1Stat: TLabel;
    InverterR1Internal: TLabel;
    Label1: TLabel;
    InverterL2Stat: TLabel;
    InverterL2Internal: TLabel;
    Label4: TLabel;
    InverterR2Stat: TLabel;
    InverterR2Internal: TLabel;
    Timer1: TTimer;
    procedure ConnectedClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TInverterHandler = class(TDevice)
  public
    function getStatus : Integer;
  protected
    InverterStatus : Word;
    procedure PowerOn; override;
    procedure SyncHandler; override;
 //   procedure CyclicHandler; override;
    function CANHandler( const msg : array of byte; const dlc : byte; const id : integer ) : boolean; override;
  end;

var
  InverterR1 : TInverterHandler;
  InverterR2 : TInverterHandler;
  InverterL1 : TInverterHandler;
  InverterL2 : TInverterHandler;
  InverterForm : TInverterForm;

implementation

uses CanTest, powernode;

{$R *.dfm}

function TInverterHandler.getStatus : Integer;
begin
  result := InverterStatus;
end;

procedure TInverterHandler.PowerOn;
var
  msg : array[0..7] of byte;
begin
  inherited;
  msg[0] := 0;
  msg[1] := 0;
  msg[2] := 0;
  if Powered then
  begin
    CanSend($700+can_id,msg,2,0);  // inverter NMT response      $77E
    InverterStatus := 64;
//    InverterLStat.Caption := IntToStr(InverterLStatus);
//    InverterRStat.Caption := IntToStr(InverterRStatus);
//    SendInverterClick(nil);
 //   processsync;
  end;

end;

function TInverterHandler.CANHandler(const msg: array of byte; const dlc: byte;
  const id: integer): boolean;
var
  msgout: array[0..7] of byte;
begin

  if Powered then
  begin

  // TODO deal with only allowing enabled when HV.

    if id = can_id+$400 then     // $47e
    begin

      case msg[0] of
        128 : InverterStatus := 64;

        6:  InverterStatus := 49;

        7:  InverterStatus := 51;

        15: InverterStatus := 55;

        0  : //  send error state       InverterLStatus := 104    -- error

      else
           //     msg[0] := 0;
      end;


    msgout[0] := InverterStatus;
    msgout[1] := 22;
    msgout[2] := 0;
    msgout[3] := 0;
    msgout[4] := 0;
    msgout[5] := 0;

    //     if Random(100) > 50 then  msg[1] := 0;

    CanSend($180+can_id,msgout,4,0);
    end;
  end;
end;

procedure TInverterHandler.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
    if ( ( InverterStatus = 7 ) or ( InverterStatus = 15 ) ) and ( not Power.isPowered(DeviceIDtype.HV) ) then // inverters have lost HV, send error.
    begin
      msgout[0] := 0;          // siemens undervolt error.
      msgout[1] := 16;
      msgout[2] := 129;
      msgout[3] := 93;
      msgout[4] := 117;
      msgout[5] := 2;
      msgout[5] := 0;
      msgout[5] := 0;
      CanSend($80+can_id,msgout,8,0);
      InverterStatus := 104; // set error state.
    end;

    msgout[0] := InverterStatus;
    msgout[1] := 22;
    msgout[2] := 0;
    msgout[3] := 0;
    msgout[4] := 0;
    msgout[5] := 0;

  //     if Random(100) > 50 then  msg[1] := 0;
    CanSend($280+can_id,msgout,6,0);

    msgout[1] := 22;//+badvalue;

    CanSend($380+can_id,msgout,4,0);

end;

procedure TInverterForm.ConnectedClick(Sender: TObject);
begin
  InverterL1.Enabled := Connected.Checked;
  InverterR1.Enabled := Connected.Checked;
  InverterL2.Enabled := Connected.Checked;
  InverterR2.Enabled := Connected.Checked;
end;

procedure TInverterForm.Timer1Timer(Sender: TObject);
begin
  if InverterR1.Powered then
    InverterForm.InverterR1Stat.Caption := IntToStr(InverterR1.getStatus)
  else
    InverterForm.InverterR1Stat.Caption := '-';

  if InverterR2.Powered then
    InverterForm.InverterR2Stat.Caption := IntToStr(InverterR2.getStatus)
  else
    InverterForm.InverterR2Stat.Caption := '-';

  if InverterL1.Powered then
    InverterForm.InverterL1Stat.Caption := IntToStr(InverterL1.getStatus)
  else
    InverterForm.InverterL1Stat.Caption := '-';

  if InverterL2.Powered then
    InverterForm.InverterL2Stat.Caption := IntToStr(InverterL2.getStatus)
  else
    InverterForm.InverterL2Stat.Caption := '-';
end;

end.
