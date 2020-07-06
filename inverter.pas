unit inverter;

interface

uses Vcl.CheckLst, device, global;

type
  TInverterHandler = class(TDevice)
  public
    procedure processSync; override;
    function CANReceive( const msg : array of byte; const dlc : byte; const id : integer ) : boolean; override;
    function getStatus : Integer;
  protected
    InverterStatus : Word;
    InverterStatusRequest : Word;
    procedure PowerOn; override;
  end;

implementation

uses System.SysUtils, CanTest, powernode;

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
    MainForm.CanSend($700+can_id,msg,2,0);  // inverter NMT response      $77E
    InverterStatus := 64;
//    InverterLStat.Caption := IntToStr(InverterLStatus);
//    InverterRStat.Caption := IntToStr(InverterRStatus);
//    SendInverterClick(nil);
    processsync;
  end;
end;

function TInverterHandler.CANReceive(const msg: array of byte; const dlc: byte;
  const id: integer): boolean;
begin
  if Powered then
    if id = can_id+$400 then     // $47e
    begin
      InverterStatusRequest := msg[0];
      processsync;
    end;
end;

procedure TInverterHandler.processSync;
var
  msg: array[0..7] of byte;
  i : integer;
begin
  if MainForm.PowerNodes.isPowered(DeviceIDType.IVT) and MainForm.EmuMaster.checked  then
  begin
    msg[0] := 0;  // insert an IVT value here.
    msg[1] := 0;
    msg[2] := 0;
    msg[3] := 0;
    msg[4] := 90;
    msg[5] := 10;

  end;
end;

{
procedure sendINVL;
var
  msg: array[0..7] of byte;
begin
      if Inverters.checked then

      with CanChannel1 do
      begin
        case InverterLStatusRequest of
          128 : InverterLStatus := 64;

          6:  InverterLStatus := 49;

          7:  InverterLStatus := 51;

          15: InverterLStatus := 55;

          0  : //  send error state       InverterLStatus := 104    -- error

        else
             //     msg[0] := 0;
        end;


        msg[0] := InverterLStatus;
        msg[1] := 22;
        msg[2] := 0;
        msg[3] := 0;
        msg[4] := 0;
        msg[5] := 0;



   //     if Random(100) > 50 then  msg[1] := 0;

        CanSend($2fe,msg,6,0);

        msg[1] := 22+badvalue;

                badvalue := 0;

        CanSend($3fe,msg,4,0);
        InverterLStat.Caption := IntToStr(InverterLStatus);
      end;
end;

procedure TMainForm.sendINVR;
var
  msg: array[0..7] of byte;
begin
      if Inverters.checked then
      with CanChannel1 do
      begin
        case InverterRStatusRequest of
          128 : InverterRStatus := 64;

          6:  InverterRStatus := 49;

          7:  InverterRStatus := 51;

          15: InverterRStatus := 55;

        else
 //                 msg[0] := 0;
        end;

        msg[0] := InverterRStatus;
        msg[1] := 22;
        msg[2] := 0;
        msg[3] := 0;
        msg[4] := 0;
        msg[5] := 0;

  //      if Random(100) > 50 then  msg[1] := 0;

        CanSend($2ff,msg,6,0);

        msg[1] := 22;

        CanSend($3ff,msg,4,0);
        InverterRStat.Caption := IntToStr(InverterRStatus);
      end;
end; }


end.
