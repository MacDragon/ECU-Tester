unit powernode;

interface

uses PowerHandler, device, global;

type
 // TPowerNodeListHandler = class(TObject);

  TPowerNode = class(TDevice)
    constructor Create( powerhandler : TPowerHandler;
                         powersource : DeviceIDType;
                         node_id : Integer;
                         can_id : Integer;
                         Devices : array of DeviceIDtype; defaultpower : DeviceIDtypes );
    procedure powerOn; override;
    procedure unplug; override;
  protected
    defaultpower : set of DeviceIDtype;
    node_id : integer;
    Devices : array[0..5] of DeviceIDtype;
    function CANHandler( const msg : array of byte; const dlc : byte; const can_id : integer ) : boolean; override;
  end;

  TPowerNode33 = class(TPowerNode)
     procedure SyncHandler; override;
  end;

  TPowerNode34 = class(TPowerNode)
     procedure SyncHandler; override;
  end;

  TPowerNode35 = class(TPowerNode)
     procedure SyncHandler; override;
  end;

  TPowerNode36 = class(TPowerNode)
     procedure SyncHandler; override;
  end;

  TPowerNode37 = class(TPowerNode)
     procedure SyncHandler; override;
  end;


implementation

uses CanTest, System.SysUtils, consts;

procedure TPowerNode33.SyncHandler;
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  CanSend(can_id,msgout,3,0);
end;

procedure TPowerNode34.SyncHandler;
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  if PowerNodesForm.ShutD.Checked then inc(msgout[0],4); //0b00011100
  if PowerNodesForm.ShutD2.Checked then inc(msgout[0],8);
  if PowerNodesForm.ShutD3.Checked then inc(msgout[0],16);
  CanSend(can_id,msgout,4,0);
end;


procedure TPowerNode35.SyncHandler;
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  CanSend(can_id,msgout,4,0);
end;


procedure TPowerNode36.SyncHandler;
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  CanSend(can_id,msgout,7,0);
end;



procedure TPowerNode37.SyncHandler;
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  MainForm.CanSend(can_id,msgout,3,0);
end;


function IsBitSet(const AValueToCheck, ABitIndex: Integer): Boolean;
begin
  Result := AValueToCheck and (1 shl ABitIndex) <> 0;
end;


{ TPowerNode }

function TPowerNode.CanHandler( const msg: array of byte; const dlc: byte;
  const can_id: integer): boolean;
var
  msgout: array[0..7] of byte;
  oldPowered : set of DeviceIDtype;
  i,j, activecount : integer;
begin
  if Powered then
  begin
    if can_id = $602 then
    begin
      activecount := 0;
      for I := 0 to 7 do msgout[i] := 0;

      if ( node_id = msg[0] ) and ( msg[1] = 1 ) then
      begin
        for j := 0 to 5 do
        begin
          if IsBitSet(msg[2], j) then
          begin
              power.setPower(  Devices[j], IsBitSet(msg[3], j));
          end;

          if power.isPowered(Devices[j]) then
          begin
            msgout[3] := msgout[3] or (1 shl j);   // set bit if that device is currently powered.
            inc(activecount);
          end

        end;

    //   Acknowledge(SWITCH_POWER, enableSwitching, newState, 0, activeTotal);
      //            cmd,
        msgout[0] := msg[0];
        msgout[1] := 1;

        msgout[2] := msg[2]; // enable switching.
     //   msgout[3] := // newstate
        msgout[4] := 0; // nothing
        msgout[5] :=  activecount;

        msgout[6] := 0; // ack no, keep track for emulation matching?
        msgout[7] := msgout[1]; // cmd repeated.

        CanSend(NodeAck_ID, msgout, 8, 0);
      end;
    end;
  end;

end;

constructor TPowerNode.Create( powerhandler : TPowerHandler;
                         powersource : DeviceIDType;
                         node_id : Integer;
                         can_id : Integer;
                         Devices : array of DeviceIDtype;
                         defaultpower : DeviceIDtypes );
var
   i : integer;
begin
  inherited Create(powerhandler, powersource, can_id);
  self.node_id := node_id;
  for i := 0 to 5 do
    self.Devices[i] := Devices[i];
  self.defaultpower  := defaultpower;
end;

procedure TPowerNode.powerOn;
var
  i : Integer;
begin
  inherited;
  for i := 0 to 5 do
    if Devices[i] in defaultpower then
      power.setPower( Devices[i], true );
end;

procedure TPowerNode.unplug;
var
  i : Integer;
begin
  inherited;
  for i := 0 to 5 do
    power.setPower( Devices[i], false );
end;

end.
