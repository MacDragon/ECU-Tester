unit devicelist;

interface

uses Device;

type
  TDevices = class(TObject)
    constructor Create;
    procedure registerdevice( Device : TObject );
    procedure CANReceive( msg : array of byte; dlc : byte; can_id : integer );
    procedure processCyclic;
    procedure processPower;
  private
    devices : Array[0..50] of TDevice;
    devicecount : integer;
  end;

var
  Devices : TDevices;

implementation

{ TDeviceList }

constructor TDevices.Create;
begin
//  inherited Create( powerhandler, DeviceIDtype.None, 0);
  devicecount := 0;
end;

procedure TDevices.processCyclic;
var
  i : integer;
begin
  for i := 0 to devicecount-1 do
    Devices[i].processCyclic;
end;

procedure TDevices.processPower;
var
  i : integer;
begin
  for i := 0 to devicecount-1 do
    Devices[i].processPower;
end;

procedure TDevices.registerdevice(Device: TObject);
begin
  if devicecount < 50 then   // TODO make dynamic size.
  begin
    Devices[devicecount] := TDevice(Device);
    inc(devicecount);
  end;
end;


procedure TDevices.CANReceive( msg : array of byte; dlc : byte; can_id : integer );
var
//  oldPowered : set of DeviceIDtype;
  i : integer;
begin
 // oldPowered := powered;
  for i := 0 to devicecount-1 do
    Devices[i].CANReceive(msg, dlc, can_id);
 { if listptr.Checked[i] then
    nodes[i].node.CANReceive(msg, dlc, can_id);
 }

{  if Powered <> oldPowered then
  begin
    power.UpdatePowered;
  end;
 }
 // power.UpdatePowered;
end;

end.
