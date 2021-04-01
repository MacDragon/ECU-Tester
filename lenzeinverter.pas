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

procedure TLenzeInverterHandler.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
    if ( ( InverterStatus1 = 7 ) or ( InverterStatus1 = 15 ) ) and ( not Power.isPowered(DeviceIDtype.HV) ) then // inverters have lost HV, send error.
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
      InverterStatus1 := 104; // set error state.
    end;

    msgout[0] := InverterStatus1;
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
