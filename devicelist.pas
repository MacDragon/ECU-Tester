unit devicelist;

interface

uses Device;

type
  TDevices = class(TObject)
  {$ifdef devicecan}
  private
      procedure setOnbus(const Value: boolean);
  {$endif}
  public
    constructor Create;
    procedure registerdevice( Device : TObject );
    procedure CANReceive( const msg : array of byte; const dlc : byte; const can_id, bus : integer );
    procedure processCyclic;
    procedure processPower;
    {$ifdef devicecan}
    property OnBus : boolean write setOnbus;
    {$endif}
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

{$ifdef devicecan}
procedure TDevices.setOnbus(const Value: boolean);
var
  i : integer;
begin
  for i := 0 to devicecount-1 do
    Devices[i].OnBus := Value;
end;
{$endif}

procedure TDevices.CANReceive( const msg : array of byte; const dlc : byte; const can_id, bus : integer );
var
//  oldPowered : set of DeviceIDtype;
  i : integer;
begin
 // oldPowered := powered;
  for i := 0 to devicecount-1 do
    Devices[i].CANReceive(msg, dlc, can_id, bus);
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
