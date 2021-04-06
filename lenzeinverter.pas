unit lenzeinverter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.CheckLst, device, global, Vcl.StdCtrls, PowerHandler, Vcl.ExtCtrls;

type
  TLenzeInverterForm = class(TForm)
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
    Label2: TLabel;
    APPC1State: TLabel;
    Label3: TLabel;
    APPC2State: TLabel;
    procedure ConnectedClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TLenzeInverterHandler = class(TDevice)
  public
    function getStatus1 : Integer;
    function getStatus2 : Integer;
    function getAPPCStatus : Word;
  protected
    InverterStatus1 : Word;
    InverterStatus2 : Word;
    APPCStatus : Word;
    procedure powerOn; override;
    procedure SyncHandler; override;
 //   procedure CyclicHandler; override;
    procedure getIDs( var IDs : TIDArray ); override;
    function CANHandler( const msg : array of byte; const dlc : byte; const id : integer ) : boolean; override;
    function LenzeRunState( const request : byte; const curstatus : byte ) : byte;
    procedure SendAPPC;
    procedure SendMC;
  end;

var
  LenzeInverterR : TLenzeInverterHandler;
  LenzeInverterL : TLenzeInverterHandler;
  LenzeInverterForm : TLenzeInverterForm;

implementation

uses CanTest, powernode;

{$R *.dfm}

function TLenzeInverterHandler.getStatus1 : Integer;
begin
  result := InverterStatus1;
end;

function TLenzeInverterHandler.getStatus2 : Integer;
begin
  result := InverterStatus2;
end;

function TLenzeInverterHandler.getAPPCstatus : Word;
begin
  result := APPCStatus;
end;

procedure TLenzeInverterHandler.PowerOn;
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
    InverterStatus1 := 64;
    InverterStatus2 := 64;
    APPCStatus := 1;
//    InverterLStat.Caption := IntToStr(InverterLStatus);
//    InverterRStat.Caption := IntToStr(InverterRStatus);
//    SendInverterClick(nil);
 //   processsync;
  end;

end;


procedure TLenzeInverterHandler.getIDs( var IDs : TIDArray );
begin
  SetLength(IDs, 6);
  IDs[0] := can_id+RPDO1_id;
  IDs[1] := can_id+RPDO2_id;
  IDs[2] := can_id+RPDO3_id;
  IDs[3] := can_id+RPDO4_id;
  IDs[4] := can_id+RPDO5_id;
  IDs[5] := can_id+SDORX_id;
end;


function TLenzeInverterHandler.LenzeRunState( const request : byte; const curstatus : byte ) : byte;
begin
  case request of
    128 : result := 64;

    6:  result := 49;

    7:
    begin
      if curstatus = 49 then
         result := 51
      else
        result := 49;
    end;

    15: result := 55;

    0  : //  send error state       InverterLStatus := 104    -- error

  else
           //     msg[0] := 0;
  end;

end;

function TLenzeInverterHandler.CANHandler(const msg: array of byte; const dlc: byte;
  const id: integer): boolean;
var
  msgout: array[0..7] of byte;
begin

  if Powered then
  begin
  // TODO deal with only allowing enabled when HV.
    if id = can_id+$400 then     // $47e
    begin

      InverterStatus1 := LenzeRunState(msg[0], InverterStatus1);

      msgout[0] := InverterStatus1;
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

procedure TLenzeInverterHandler.SendAPPC;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
  msgout[0] := 0;
  msgout[1] := 1;
  msgout[2] := 0;
  msgout[3] := 0;
  msgout[4] := 0;
  msgout[5] := 0;
  msgout[6] := 0;
  msgout[7] := 0;
  CanSend(can_id+RPDO1_id,msgout,8,0);   // 201
  msgout[1] := 0;
  CanSend(can_id+RPDO2_id,msgout,8,0);   // 301
  msgout[1] := 1;
  CanSend(can_id+RPDO3_id,msgout,8,0);   // 401
  msgout[1] := 0;
  CanSend(can_id+RPDO4_id,msgout,8,0);   // 501
  msgout[0] := $85;
  msgout[1] := $8E;
  CanSend(can_id+RPDO5_id,msgout,8,0);   // 541
  msgout[0] := $1;
  msgout[1] := $1;
//  CanSend(0,msgout,2,0);   // 0 NMT id 1 go online.

  // pdo error.  PDO length exceeded ?
  msgout[0] := $20;
  msgout[1] := $82;
  msgout[2] := $11;
  CanSend($80+can_id+31,msgout,8,0);   // 0 NMT id 1 go online.

  // error reset.
  msgout[0] := $0;
  msgout[1] := $0;
  msgout[2] := $0;
  CanSend($80+can_id+31,msgout,8,0);
end;

procedure TLenzeInverterHandler.SendMC;
var
  msgout: array[0..7] of byte;
  i : integer;
  voltage : integer;
  temp : integer;
const
  TPDO1_id = $180;

  TPDO2_id = $1C0;
  TPDO3_id = $240;
  TPDO4_id = $280;

  TPDO5_id = $2C0;
  TPDO6_id = $340;
  TPDO7_id = $380;
begin
  for i := 0 to 7 do msgout[i] := 0;

  voltage := Power.getHVVoltage;// * 16;  // get current HV voltage from BMS.
  temp := 24 * 16; // hard code temp for now.

 // if voltage > 400 then
  if ( ( InverterStatus1 = 7 ) or ( InverterStatus1 = 15 ) )
        and voltage < 400 then // inverters have lost HV, send error.
  begin
 {     msgout[0] := 0;          // siemens undervolt error.
      msgout[1] := 16;
      msgout[2] := 129;
      msgout[3] := 93;
      msgout[4] := 117;
      msgout[5] := 2;
      msgout[5] := 0;
      msgout[5] := 0;
      CanSend($80+can_id,msgout,8,0);      }
      InverterStatus1 := 104; // set error state.
  end;

  if ( ( InverterStatus2 = 7 ) or ( InverterStatus2 = 15 ) )
        and voltage < 400 then // inverters have lost HV, send error.
  begin
      InverterStatus2 := 104; // set error state.
  end;

  voltage := voltage * 16;
  msgout[0] := voltage;
  msgout[1] := voltage shr 8;

  msgout[2] := temp;
  msgout[3] := temp shr 8;

  // general MC status.
  CanSend(can_id+TPDO1_id,msgout,8,0);
    
  // Drive Profile Inverter A statusword
  msgout[0] := InverterStatus1; //msg[1]+msg[0] shl 8;

  // Inverter A Supervision: latched status 1
//   val2 := msg[2]+msg[3] shl 8 + msg[4] shl 16 + msg[5] shl 24;
  // Inverter A Supervision: latched status 2
//   val3 := msg[6]+msg[7] shl 8;

  // Motor 1
  CanSend(can_id+TPDO2_id,msgout,8,0);
  for i := 0 to 7 do msgout[i] := 0;
  CanSend(can_id+TPDO3_id,msgout,8,0);
  CanSend(can_id+TPDO4_id,msgout,8,0);

  // Motor 2
  msgout[0] := InverterStatus2;
  CanSend(can_id+TPDO5_id,msgout,8,0);
  for i := 0 to 7 do msgout[i] := 0;
  CanSend(can_id+TPDO6_id,msgout,8,0);
  CanSend(can_id+TPDO7_id,msgout,8,0);
end;


procedure TLenzeInverterHandler.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin

  // if APPC send is enabled, send
  if APPCStatus > 0 then
  begin
    SendAPPC;
  end;

  {*
  if ( ( InverterStatus1 = 7 ) or ( InverterStatus1 = 15 ) ) and ( not Power.isPowered(DeviceIDtype.HV) ) then // inverters have lost HV, send error.
  begin
    msgout[0] := 0;          // siemens undervolt error.
    msgout[1] := 16;
    msgout[2] := 129;
    msgout[3] := 93;
    msgout[4] := 117;
    msgout[5] := 2;
    msgout[6] := 0;
    msgout[7] := 0;
    CanSend($80+can_id,msgout,8,0);
    InverterStatus1 := 104; // set error state.
  end;
  *}
  SendMC;
end;

procedure TLenzeInverterForm.ConnectedClick(Sender: TObject);
begin
  LenzeInverterR.Enabled := Connected.Checked;
  LenzeInverterL.Enabled := Connected.Checked;
end;

procedure TLenzeInverterForm.FormCreate(Sender: TObject);
begin
  LenzeInverterR := TLenzeInverterHandler.Create(Power, DeviceIDtype.Inverters, $01, 1);
  LenzeInverterL := TLenzeInverterHandler.Create(Power, DeviceIDtype.Inverters, $02, 1);
end;

procedure TLenzeInverterForm.Timer1Timer(Sender: TObject);
begin
  if LenzeInverterR.Powered then
  begin
    LenzeInverterForm.InverterR1Stat.Caption := IntToStr(LenzeInverterR.getStatus1);
    LenzeInverterForm.InverterR2Stat.Caption := IntToStr(LenzeInverterR.getStatus2);
   // if get then

  end
  else
  begin
    LenzeInverterForm.InverterR1Stat.Caption := '-';
    LenzeInverterForm.InverterR2Stat.Caption := '-';
  end;

  if LenzeInverterL.Powered then
  begin
    LenzeInverterForm.InverterL1Stat.Caption := IntToStr(LenzeInverterL.getStatus1);
    LenzeInverterForm.InverterL2Stat.Caption := IntToStr(LenzeInverterL.getStatus2);
  end
  else
  begin
    LenzeInverterForm.InverterL1Stat.Caption := '-';
    LenzeInverterForm.InverterL2Stat.Caption := '-';
  end;

end;

end.
