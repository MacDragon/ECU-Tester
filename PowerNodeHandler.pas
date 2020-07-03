unit PowerNodeHandler;

interface

uses Vcl.CheckLst, global;

type
  TPowerNodeHandler = class(TObject)
  public
    constructor Create( List : TCheckListBox );
    procedure processSync;
    procedure CANReceive( msg : array of byte; dlc : byte; can_id : integer );
    function  isPowered( Device : DeviceIDtype ) : boolean;
    procedure setPower( Device: DeviceIDtype; state : Boolean );
    procedure unplug( node : integer );
    function listPowered : String;
  private
    powered : set of DeviceIDtype;
    listptr : TCheckListBox;
  end;

implementation

uses cantest, powernode, rtti, device;

//    TPowerNodeTypeClass = class of TPowerNode;

const
  PowerNode33_ID = 1710;
  PowerNode34_ID = 1711;
  PowerNode35_ID = 1712;
  PowerNode36_ID = 1713;
  PowerNode37_ID = 1714;

type
  TPowerNodeListItem = class
  public
    name : String;
    node: TPowerNode;
    constructor Create( name : string; node : TPowerNode );
  end;

var
  nodes : TArray<TPowerNodeListItem>;

function TPowerNodeHandler.isPowered( Device: DeviceIDtype ): boolean;
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

  powered := [ECU, Front2];
  listptr := List;

  nodes := TArray<TPowerNodeListItem>.Create(
    TPowerNodeListItem.Create('Node33', TPowerNode33.Create(self, NONE, 33, PowerNode33_ID, [None,None,None,None, Telemetry, Front1])),
    TPowerNodeListItem.Create('Node34', TPowerNode34.Create(self, NONE, 34, PowerNode34_ID, [None,None,None,Inverters, ECU, Front2])),
    TPowerNodeListItem.Create('Node35', TPowerNode35.Create(self, None, 35, PowerNode35_ID, [None,None,LeftFans,RightFans, LeftPump, RightPump])),
    TPowerNodeListItem.Create('Node36', TPowerNode36.Create(self, Front2, 36, PowerNode36_ID, [Buzzer,IVT,None,None, None, None])),
    TPowerNodeListItem.Create('Node37', TPowerNode37.Create(self, Front2, 37, PowerNode37_ID, [None,None,None,None, Current, TSAL]))
  );

  for I := 0 to Length(nodes)-1 do
  begin
     listptr.Items.Add(nodes[i].name);
     listptr.Checked[i] := true;
  end;

   i := listptr.Items.Count-1;

end;


procedure TPowerNodeHandler.processSync;
var
  i : Integer;
begin
    for i := 0 to listptr.Items.Count-1 do
    begin
     if listptr.Checked[i] then
     begin
      if @nodes[i].node <> nil then
        nodes[i].node.processSync;
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

procedure TPowerNodeHandler.unplug(node: integer);
var
  oldPowered : set of DeviceIDtype;
  i, count : integer;
begin
  nodes[node].node.unplug;
  count := 0;
  repeat
    oldPowered := powered;
    for i := 0 to length(Nodes)-1 do
      if not nodes[i].node.isPowered then
        nodes[i].node.unplug;
    inc(count)
  until (oldPowered = powered );// or ( count > length(Nodes)-1 ).
end;

procedure TPowerNodeHandler.CANReceive( msg : array of byte; dlc : byte; can_id : integer );
var
  oldPowered : set of DeviceIDtype;
  i : integer;
begin
  oldPowered := powered;

  for i := 0 to length(Nodes)-1 do
  if listptr.Checked[i] then
    nodes[i].node.CANReceive(msg, dlc, can_id);

  if Powered <> oldPowered then
  begin
    MainForm.PoweredDevs.Caption := listPowered;
  end;

end;



{ TPowerNodeListItem }

constructor TPowerNodeListItem.Create(name: string; node: TPowerNode);
begin
  self.name := name;
  self.node := node;
end;

end.
