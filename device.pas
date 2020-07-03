unit device;

interface

uses PowerNodeHandler, global;

type
  TDevice = class(TObject)
  public
    constructor Create( powerhandler : TPowerNodeHandler; powersource : DeviceIDtype; can_id : Integer );
    procedure processSync; virtual; abstract;  // send any default sync messages;
    procedure processCyclic; virtual;
    function isPowered : boolean;
    function getPowertype : DeviceIDType;
    function CANReceive( msg : array of byte; dlc : byte; id : integer ) : boolean; virtual;
  protected
    power : TPowerNodeHandler;
    powertype : DeviceIDtype;
    can_id : Integer;
  end;

implementation

function TDevice.CANReceive(msg: array of byte; dlc: byte;
  id: integer): boolean;
begin
  result := false;
end;

constructor TDevice.Create( powerhandler : TPowerNodeHandler; powersource : DeviceIDtype; can_id : Integer );
var
  I : Integer;
begin
  power := powerhandler;
  powertype := powersource;
  self.can_id := can_id;
end;

function TDevice.getPowertype: DeviceIDType;
begin
  result := powertype;
end;

function TDevice.isPowered: boolean;
begin
  if powertype = None then
    result := true
  else
  if Assigned(power) then
  begin
     result := power.isPowered(powertype);
  end else result := false;
end;

procedure TDevice.processCyclic;
begin

end;

end.
