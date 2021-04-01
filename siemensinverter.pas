unit siemensinverter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.CheckLst, device, global, Vcl.StdCtrls, PowerHandler, Vcl.ExtCtrls;

type
  TSiemensInverterForm = class(TForm)
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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TSiemensInverterHandler = class(TDevice)
  public
    function getStatus : Integer;
  protected
    InverterStatus : Word;
    procedure PowerOn; override;
    procedure SyncHandler; override;
 //   procedure CyclicHandler; override;
    procedure getIDs( var IDs : TIDArray ); override;
    function CANHandler( const msg : array of byte; const dlc : byte; const id : integer ) : boolean; override;
  end;

var
  SiemensInverterR1 : TSiemensInverterHandler;
  SiemensInverterR2 : TSiemensInverterHandler;
  SiemensInverterL1 : TSiemensInverterHandler;
  SiemensInverterL2 : TSiemensInverterHandler;
  SiemensInverterForm : TSiemensInverterForm;

implementation

uses CanTest, powernode;

{$R *.dfm}

function TSiemensInverterHandler.getStatus : Integer;
begin
  result := InverterStatus;
end;

procedure TSiemensInverterHandler.PowerOn;
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

procedure TSiemensInverterHandler.getIDs( var IDs : TIDArray );
begin
  SetLength(IDs, 1);
  IDs[0] := can_id+$400;
end;

function TSiemensInverterHandler.CANHandler(const msg: array of byte; const dlc: byte;
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

        7:
        begin
          if InverterStatus = 49 then
             InverterStatus := 51
          else
            InverterStatus := 49;
        end;

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

procedure TSiemensInverterHandler.SyncHandler;
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

procedure TSiemensInverterForm.ConnectedClick(Sender: TObject);
begin
  SiemensInverterL1.Enabled := Connected.Checked;
  SiemensInverterR1.Enabled := Connected.Checked;
  SiemensInverterL2.Enabled := Connected.Checked;
  SiemensInverterR2.Enabled := Connected.Checked;
end;

procedure TSiemensInverterForm.FormCreate(Sender: TObject);
begin
  SiemensInverterL1 := TSiemensInverterHandler.Create(Power, DeviceIDtype.Inverters, $7E, 1);
  SiemensInverterL2 := TSiemensInverterHandler.Create(Power, DeviceIDtype.Inverters, $7C, 1);
  SiemensInverterR1 := TSiemensInverterHandler.Create(Power, DeviceIDtype.Inverters, $7F, 1);
  SiemensInverterR2 := TSiemensInverterHandler.Create(Power, DeviceIDtype.Inverters, $7D, 1);
end;

procedure TSiemensInverterForm.Timer1Timer(Sender: TObject);
begin
  if SiemensInverterR1.Powered then
    SiemensInverterForm.InverterR1Stat.Caption := IntToStr(SiemensInverterR1.getStatus)
  else
    SiemensInverterForm.InverterR1Stat.Caption := '-';

  if SiemensInverterR2.Powered then
    SiemensInverterForm.InverterR2Stat.Caption := IntToStr(SiemensInverterR2.getStatus)
  else
    SiemensInverterForm.InverterR2Stat.Caption := '-';

  if SiemensInverterL1.Powered then
    SiemensInverterForm.InverterL1Stat.Caption := IntToStr(SiemensInverterL1.getStatus)
  else
    SiemensInverterForm.InverterL1Stat.Caption := '-';

  if SiemensInverterL2.Powered then
    SiemensInverterForm.InverterL2Stat.Caption := IntToStr(SiemensInverterL2.getStatus)
  else
    SiemensInverterForm.InverterL2Stat.Caption := '-';
end;

end.
