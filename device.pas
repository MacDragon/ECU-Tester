unit device;

interface

uses PowerHandler, global;

type
  TDevice = class(TObject)
  private
    function isEnabled: boolean;
    procedure setEnabled(const Value: boolean);

    function isPowered: boolean;

  public
    constructor Create( const powerhandler : TPowerHandler; const powersource : DeviceIDtype; const can_id : Integer; const Cycletime : Integer = 1000 );
    procedure processSync; virtual; // send any default sync messages;

    procedure processCyclic; virtual;

    property Enabled : boolean read isEnabled write setEnabled;
    property Powered : boolean read isPowered;

    procedure processpower;
    function getPowertype : DeviceIDType;

    function CANReceive( const msg : array of byte; const dlc : byte; const id : integer ) : boolean;
    procedure Output( const str: String);
  protected
    connected : Boolean;
    connectionprocessed : boolean;
    poweredon : Boolean;
    power : TPowerHandler;
    powertype : DeviceIDtype;
    can_id : Integer;

    procedure powerOn; virtual;
    procedure unplug; virtual;

    procedure CyclicHandler; virtual;
    procedure SyncHandler; virtual;
    function CANHandler( const msg : array of byte; const dlc : byte; const id : integer ) : boolean; virtual;

    function CanSend(id: Longint; var msg; dlc, flags: Cardinal): integer;
  private
    lastsend : TDateTime;
    cycletime : Int64;
  end;

implementation

uses CanTest, System.SysUtils, System.DateUtils, devicelist;

procedure TDevice.Output(const str: String);
begin
  MainForm.AddOutput(str);
end;

function TDevice.CANHandler(const msg: array of byte; const dlc: byte;
  const id: integer): boolean;
begin

end;

function TDevice.CANReceive( const msg: array of byte; const dlc: byte;
  const id: integer): boolean;
var
  msgout : array[0..7] of byte;
begin
  result := false;
  if Powered then // process messages if we have power.
  case id of
     $0 :  begin  // received nmt message, respond.
       if ( msg[1] = can_id ) or (msg[1] = 0 )then   // acknowledge NMT if specific to node or all nodes.
         if ( msg[0] = $81 ) or ( msg[0] = $82 ) then // or ( msg[0] = $0 ) then       // reset
         begin
           PowerOn; // rerun power on.
         end;
     end;
     $80 : SyncHandler;
  else
    CANHandler(msg, dlc, id);
  end;
end;

function TDevice.CanSend(id: Longint; var msg; dlc, flags: Cardinal): integer;
begin
  result := MainForm.CanSend(id, msg, dlc, flags);
end;

constructor TDevice.Create( const powerhandler : TPowerHandler; const powersource : DeviceIDtype; const can_id : Integer; const Cycletime : Integer );
var
  I : Integer;
begin
  lastsend := Now;
  self.cycletime := cycletime;
  power := powerhandler;
  powertype := powersource;
  poweredon := false;
  self.can_id := can_id;
  connectionprocessed := false;
  Devices.registerdevice(self);
 // powerhandler.registerdevice(self);
end;

procedure TDevice.CyclicHandler;
begin

end;

function TDevice.getPowertype: DeviceIDType;
begin
  result := powertype;
end;

function TDevice.isEnabled: boolean;
begin
  result := connected;
end;

function TDevice.isPowered: boolean;
begin
  if connected then
  begin
    if Assigned(power) then
    begin
      result := power.isPowered(powertype);
    end else
    begin
      result := false;
    end;
  end else
    result := false; // can't be powered if not connected.
end;


procedure TDevice.processpower;
var
  powerstate : boolean;
begin
  if connected then
  begin
    if Assigned(power) then
    begin
      powerstate := power.isPowered(powertype);
    end else powerstate := true;

    if not poweredon and powerstate then
    begin
      powerOn;
    end else
    begin
      if poweredon and not powerstate then
        unplug
      else
      begin
        if not connectionprocessed then
        begin
          Output('node connected');
          connectionprocessed := true;
        end;
      end;
    end;

  end;
end;


procedure TDevice.processSync;
begin
  if Powered then SyncHandler;
end;

procedure TDevice.powerOn;
begin
  if connected then
  begin
    poweredon := true;
    Output('Nodepower on');
    connectionprocessed := true;
  end
end;

procedure TDevice.processCyclic;
begin
   if MilliSecondsBetween( Now, lastsend ) > CycleTime-1 then
   if powered then
   begin
     lastsend := Now;
     CyclicHandler;
   end;
end;

procedure TDevice.setEnabled(const Value: boolean);
var
  oldconnected : boolean;
begin
  if connected <> Value then  // only process if actually changed
  begin
    connected := value;

    if connected then
  //    poweredon := false;
      processpower
    else
    begin
      connectionprocessed := false;
      unplug;
    end;
  end;
end;

procedure TDevice.SyncHandler;
begin

end;

procedure TDevice.unplug;
begin
  if poweredon then
  begin
      Output('Nodepower off');
      poweredon := false;
  end else
    Output('node disconnected');
end;

end.
