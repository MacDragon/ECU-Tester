unit device;

interface

uses PowerNodeHandler, global;

type
  TDevice = class(TObject)
  private
    function isEnabled: boolean;
    procedure setEnabled(const Value: boolean);

    function isPowered: boolean;

  public
    constructor Create( const powerhandler : TPowerNodeHandler; const powersource : DeviceIDtype; const can_id : Integer );
    procedure processSync; virtual; abstract;  // send any default sync messages;

    procedure processCyclic; virtual;

    property Enabled : boolean read isEnabled write setEnabled;
    property Powered : boolean read isPowered;

    procedure processpower;
    function getPowertype : DeviceIDType;

    function CANReceive( const msg : array of byte; const dlc : byte; const id : integer ) : boolean; virtual;
  protected
    connected : Boolean;
    connectionprocessed : boolean;
    poweredon : Boolean;
    power : TPowerNodeHandler;
    powertype : DeviceIDtype;
    can_id : Integer;
    procedure powerOn; virtual;
    procedure unplug; virtual;
  end;

implementation

uses CanTest;

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
  end;
end;

constructor TDevice.Create( const powerhandler : TPowerNodeHandler; const powersource : DeviceIDtype; const can_id : Integer );
var
  I : Integer;
begin
  power := powerhandler;
  powertype := powersource;
  poweredon := false;
  self.can_id := can_id;
  connectionprocessed := false;
  powerhandler.registerdevice(self);
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
          MainForm.Output.Items.Add('node connected');
          connectionprocessed := true;
        end;
      end;
    end;

  end;
end;


procedure TDevice.powerOn;
begin
  if connected then
  begin
    poweredon := true;
    MainForm.Output.Items.Add('Nodepower on');
    connectionprocessed := true;
  end
end;

procedure TDevice.processCyclic;
begin

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

procedure TDevice.unplug;
begin
  if poweredon then
  begin
      MainForm.Output.Items.Add('Nodepower off');
      poweredon := false;
  end else
    MainForm.Output.Items.Add('node disconnected');
end;

end.
