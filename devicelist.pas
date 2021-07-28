unit devicelist;

interface

uses Device;

const
  maxdevices = 50;

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
    procedure processSync;
    {$ifdef devicecan}
    property OnBus : boolean write setOnbus;
    {$endif}
  private
    devices : Array[0..maxdevices] of TDevice;
    canidlist : Array[0..4096, 0..maxdevices+1] of byte;
    devicecount : integer;
  end;

var
  Devices : TDevices;

implementation

{ TDeviceList }

constructor TDevices.Create;
var
 i, j : integer;
begin
//  inherited Create( powerhandler, DeviceIDtype.None, 0);
  devicecount := 0;
  for i := 0 to 4096 do
    for j := 0 to maxdevices+1 do
      canidlist[i, j] := maxdevices+1;
end;


procedure TDevices.processCyclic;
var
  i : integer;
begin
  for i := 0 to devicecount-1 do
    Devices[i].processCyclic;
end;


procedure TDevices.processSync; // this should ideally process maybe one a ms.
var
  i : integer;
begin
  for i := 0 to devicecount-1 do
    Devices[i].processSync;
end;

procedure TDevices.processPower;
var
  i : integer;
begin
  for i := 0 to devicecount-1 do
    Devices[i].processPower;
end;

procedure TDevices.registerdevice(Device: TObject);
var
  IDs : TIDArray;
  bus, I, J : Word;
begin
  if devicecount < maxdevices then   // TODO make dynamic size.
  begin
    Devices[devicecount] := TDevice(Device);
    bus := TDevice(Device).getBus*2048;
    TDevice(Device).getIDs(IDs);

    // find position in id handling list to insert device id.
    if Length(IDs) > 0 then
      for I := 0 to Length(IDs)-1 do
      begin
        J := 0;
        // find first available slot, most likely first entry for most ID's
        while canidlist[IDs[I]+bus, J] <> maxdevices+1 do
           inc(J);
        canidlist[IDs[I]+bus, J] := devicecount;
      end;

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

 // check if any handlers for the ID have been registered
  if canidlist[can_id+(bus*2048), 0] <> maxdevices+1 then
  begin
  // if so, run all the registered can receive handlers for that id
    i := 0;
    while canidlist[can_id+(bus*2048), i] <> maxdevices+1  do
    begin
       Devices[canidlist[can_id+(bus*2048), i]].CANReceive(msg, dlc, can_id, bus);
       inc(i);
    end;
  end;
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
