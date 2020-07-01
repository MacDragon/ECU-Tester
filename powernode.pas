unit powernode;

interface

uses  Vcl.CheckLst;

const
  PowerNode33_ID = 1710;
  PowerNode34_ID = 1711;
  PowerNode35_ID = 1712;
  PowerNode36_ID = 1713;
  PowerNode37_ID = 1714;

  PowerNodeCount = 5;

procedure sendNode33( id : Integer );
procedure sendNode34( id : Integer );
procedure sendNode35( id : Integer );
procedure sendNode36( id : Integer );
procedure sendNode37( id : Integer );

type
 DeviceIDtype = (
	Buzzer,
	Telemetry,
	Front1,
	Inverters,
	ECU,
	Front2,
	LeftFans,
	RightFans,
	LeftPump,
	RightPump,
	IVT,
	Current,
	TSAL,
  None
);

  TNodeFunction = procedure( id : Integer );
  TNodeReceive = procedure( msg : array of byte; dlc : byte );

  TPowerNode = record
    name : String;
    id : Integer;
    canid : Integer;
    payload: TNodeFunction;
    Devices : array[0..5] of DeviceIDtype;
  end;

  TPowerNodeHandler = class(TObject)
  public
    constructor Create(List : TCheckListBox );
    procedure processSync;
    procedure processCmd( msg : array of byte; dlc : byte);
    function  isPowered( Device : DeviceIDtype ) : boolean;
    procedure setPower(Device: DeviceIDtype; state : Boolean );
    function listPowered : String;
  private
       powered : set of DeviceIDtype;
       listptr : TCheckListBox;
  const
       nodes : array[0..PowerNodeCount-1] of TPowerNode =
       ( ( name : 'Node33'; id : 33; canid : PowerNode33_ID; payload : sendNode33; Devices : (None,None,None,None, Telemetry, Front1) ),
         ( name : 'Node34'; id : 34; canid : PowerNode34_ID; payload : sendNode34; Devices : (None,None,None,Inverters, ECU, Front2) ),
         ( name : 'Node35'; id : 35; canid : PowerNode35_ID; payload : sendNode35; Devices : (None,None,LeftFans,RightFans, LeftPump, RightPump) ),
         ( name : 'Node36'; id : 36; canid : PowerNode36_ID; payload : sendNode36; Devices : (Buzzer,IVT,None,None, None, None) ),
         ( name : 'Node37'; id : 37; canid : PowerNode37_ID; payload : sendNode37; Devices : (None,None,None,None, Current, TSAL) )
         );
  end;

implementation

uses CanTest, System.SysUtils, rtti, consts;

procedure sendNode33(id : Integer);
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;

  msgout[0] := 0;     // dhab current? leave zero for now.
  msgout[1] := 0;

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.AccelL.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[2] := byte(tmp shr 8);
  msgout[3] := byte(tmp);

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.Regen.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[4] := byte(tmp shr 8);
  msgout[5] := byte(tmp);

  MainForm.CanSend(id,msgout,6,0);
end;


procedure sendNode34(id : Integer);
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;

  msgout[0] := 0;     // dhab current? leave zero for now.
  msgout[1] := 0;

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.AccelL.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[2] := byte(tmp shr 8);
  msgout[3] := byte(tmp);

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.Regen.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[4] := byte(tmp shr 8);
  msgout[5] := byte(tmp);

  MainForm.CanSend(id,msgout,6,0);
end;


procedure sendNode35(id : Integer);
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;

    // brake temp FL 16

    // brake pres F  8

  msgout[2] := StrToIntDef(MainForm.BrakeF.Text, 0);

    // brake pres L  8

  msgout[3] := StrToIntDef(MainForm.BrakeR.Text, 0);

    // APPS 1 8

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.AccelL.Text, 0))+100) div 256;     // ensures no actual zero or max values.
 // msgout[] := byte(tmp shr 8);
  msgout[4] := byte(tmp);

  // surely should be 2 bytes? and brake pressures too?

  MainForm.CanSend(id,msgout,6,0);
end;


procedure sendNode36(id : Integer);
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;

  msgout[0] := 0;     // dhab current? leave zero for now.
  msgout[1] := 0;

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.AccelL.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[2] := byte(tmp shr 8);
  msgout[3] := byte(tmp);

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.Regen.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[4] := byte(tmp shr 8);
  msgout[5] := byte(tmp);

  MainForm.CanSend(id,msgout,6,0);
end;



procedure sendNode37(id : Integer);
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;

  msgout[0] := 0;     // dhab current? leave zero for now.
  msgout[1] := 0;

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.AccelL.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[2] := byte(tmp shr 8);
  msgout[3] := byte(tmp);

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.Regen.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[4] := byte(tmp shr 8);
  msgout[5] := byte(tmp);

  MainForm.CanSend(id,msgout,6,0);
end;


function IsBitSet(const AValueToCheck, ABitIndex: Integer): Boolean;
begin
  Result := AValueToCheck and (1 shl ABitIndex) <> 0;
end;

function TPowerNodeHandler.isPowered(Device: DeviceIDtype): boolean;
begin
  result := false;
  if Device in powered then
    result := true;
end;

function TPowerNodeHandler.listPowered: String;
var
  I : DeviceIDtype;
begin
  result := '';

  for I := low(DeviceIDtype) to High(DeviceIDtype) do
  if I in powered then
    result := result + ' ' +  TRttiEnumerationType.GetName(I);



end;

constructor TPowerNodeHandler.Create(List: TCheckListBox);
var
  I : Integer;
begin

  powered := [ECU];
  listptr := List;

  for I := 0 to PowerNodeCount-1 do
  begin
     listptr.Items.Add(nodes[i].name);
     listptr.Checked[i] := true;
  end;

   i := listptr.Items.Count-1;

end;


procedure TPowerNodeHandler.processSync;
var
  msgout: array[0..7] of byte;
  i : integer;
begin

for i := 0 to 7 do
    msgout[i] := 0;
    msgout[0] := 0;
 //   msgout[1] := byte(500);
    for I := 0 to listptr.Items.Count-1 do
    begin
     if listptr.Checked[i] then
     begin
      if @nodes[i].payload <> nil then
        nodes[i].payload(nodes[i].id);
     end;
    end;
end;


procedure TPowerNodeHandler.setPower(Device: DeviceIDtype; state : Boolean );
begin
  if state then
   powered := powered + [Device]
  else
   powered := powered - [Device];
end;

procedure TPowerNodeHandler.processCmd( msg : array of byte; dlc : byte);
var
  msgout: array[0..7] of byte;
  oldPowered : set of DeviceIDtype;
  i,j, activecount : integer;
begin
  oldPowered := powered;
  activecount := 0;
  for I := 0 to 7 do msgout[i] := 0;

  for i := 0 to PowerNodeCount-1 do
  if ( nodes[i].id = msg[0] ) and ( msg[1] = 1 ) then
  begin
;
    for j := 0 to 5 do
    begin
      if IsBitSet(msg[2], j) then
      begin
      // For I := Low(Enum) to high(Enum) do /// if I in Set then.
          setPower(  nodes[i].Devices[j], IsBitSet(msg[3], j)); 
        { if IsBitSet(msg[3], j) then
           powered := powered + [nodes[i].Devices[j]]
         else
           powered := powered - [nodes[i].Devices[j]];   }
      end;

      if nodes[i].Devices[j] in powered then
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

      MainForm.CanSend(NodeAck_ID, msgout, 8, 0);
  end;

  if Powered <> oldPowered then
  begin
    MainForm.PoweredDevs.Caption := listPowered;
  end;

end;

end.
