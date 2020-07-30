unit PowerHandler;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.CheckLst, global, Vcl.StdCtrls;

type
  TPowerHandler = class(TObject)
  public
    constructor Create( List : TCheckListBox );
//    procedure processSync;
//    procedure CANReceive( msg : array of byte; dlc : byte; can_id : integer );
    function  isPowered( Device : DeviceIDtype ) : boolean;
    procedure setPower( Device : DeviceIDtype; state : Boolean ); overload;
    procedure setPower( state : Boolean ); overload;
    procedure Enabled( node: integer; state : boolean );
    function listPowered : String;
  private
    powered : DeviceIDtypes;
    listptr : TCheckListBox;
    procedure UpdatePowered;
  end;

  TPowerNodesForm = class(TForm)
    PowerNodesList: TCheckListBox;
    Label27: TLabel;
    PoweredDevs: TLabel;
    LVPower: TCheckBox;
    HVon: TCheckBox;
    PowerNodeError: TButton;
    ShutDCockpit: TCheckBox;
    ShutDLeft: TCheckBox;
    ShutDRight: TCheckBox;
    Inertia: TCheckBox;
    Bots: TCheckBox;
    BSPDBefore: TCheckBox;
    BSPDAfter: TCheckBox;
    IMD: TCheckBox;
    procedure PowerNodesListClick(Sender: TObject);
    procedure LVPowerClick(Sender: TObject);
    procedure HVonClick(Sender: TObject);
    procedure PowerNodeErrorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PowerNodesForm: TPowerNodesForm;
  Power : TPowerHandler;


implementation

uses cantest, powernode, rtti, device, devicelist;

{$R *.dfm}

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

function TPowerHandler.isPowered( Device: DeviceIDtype ): boolean;
begin
  result := false;
  if Device in powered then
    result := true;
end;

function TPowerHandler.listPowered: String;
var
  I : DeviceIDtype;
begin
  result := '';

  for I := low(DeviceIDtype) to High(DeviceIDtype) do
  if I in powered then
    result := result + ' ' +  TRttiEnumerationType.GetName(I);
end;

constructor TPowerHandler.Create(List: TCheckListBox);
var
  I : Integer;
begin
  listptr := List;

  nodes := TArray<TPowerNodeListItem>.Create(
    TPowerNodeListItem.Create('Node33', TPowerNode33.Create(self, LV, 33, PowerNode33_ID, [None,None,None,None, Telemetry, Front1],[])),
    TPowerNodeListItem.Create('Node34', TPowerNode34.Create(self, LV, 34, PowerNode34_ID, [None,None,None,Inverters, ECU, Front2],[ECU])),
    TPowerNodeListItem.Create('Node35', TPowerNode35.Create(self, LV, 35, PowerNode35_ID, [None,None,LeftFans,RightFans, LeftPump, RightPump],[])),
    TPowerNodeListItem.Create('Node36', TPowerNode36.Create(self, LV, 36, PowerNode36_ID, [None, Brake,Buzzer,IVT,Accu,AccuFan],[])),
    TPowerNodeListItem.Create('Node37', TPowerNode37.Create(self, LV, 37, PowerNode37_ID, [None,None,None,None, Current, TSAL],[]))
  );

  for I := 0 to Length(nodes)-1 do
  begin
     listptr.Items.Add(nodes[i].name);
     listptr.Checked[i] := true;
     nodes[I].node.Enabled := true;
 //    Devices.registerdevice(nodes[I].node);
  end;

   i := listptr.Items.Count-1;
end;

{
procedure TPowerHandler.processSync;
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
}

procedure TPowerHandler.setPower(Device : DeviceIDtype; state : Boolean );
var
  i : integer;
  oldPowered : set of DeviceIDtype;
  count : Integer;
begin
  if state then
    powered := powered + [Device]
  else
    powered := powered - [Device];

  devices.processPower;

  UpdatePowered;
end;

procedure TPowerHandler.setPower(state : Boolean );
var
  i : integer;
  oldPowered : set of DeviceIDtype;
  count : Integer;
begin
  if state then
  begin
    powered := powered + [LV];  //[Device];
    count := 0;
    repeat
      oldPowered := powered;
      for i := 0 to length(Nodes)-1 do
        nodes[i].node.processpower;
      inc(count)
    until (oldPowered = powered );// or ( count > length(Nodes)-1 ).
  end
  else
    powered := []; // remove all power

  UpdatePowered;
end;

procedure TPowerHandler.UpdatePowered;
begin
  if Assigned(PowerNodesForm) then
    PowerNodesForm.PoweredDevs.Caption := listPowered;
end;

procedure TPowerHandler.Enabled(node: integer; state : boolean);
var
  oldPowered : set of DeviceIDtype;
  i, count : integer;
begin
  nodes[node].node.Enabled := state;

  count := 0;
  repeat
    oldPowered := powered;
    for i := 0 to length(Nodes)-1 do
      if not nodes[i].node.Powered then
        nodes[i].node.unplug;
    inc(count)
  until (oldPowered = powered );// or ( count > length(Nodes)-1 ).
end;

{
procedure TPowerHandler.CANReceive( msg : array of byte; dlc : byte; can_id : integer );
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
    UpdatePowered;
  end;

end;
}

{ TPowerNodeListItem }

constructor TPowerNodeListItem.Create(name: string; node: TPowerNode);
begin
  self.name := name;
  self.node := node;
end;

procedure TPowerNodesForm.HVonClick(Sender: TObject);
begin
  Power.setPower(DeviceIDType.HV, HVOn.checked);
end;

procedure TPowerNodesForm.LVPowerClick(Sender: TObject);
begin
  Power.setPower(DeviceIDType.LV, LVPower.checked);
end;

procedure TPowerNodesForm.PowerNodeErrorClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  msg[0] := 36;
  msg[1] := 4;
  msg[5] := 112; // send error that output switched off unexpectedly.
  Power.setPower(DeviceIDType.IVT, false);
  MainForm.CanSend(600, msg, 6, 0);
end;

procedure TPowerNodesForm.PowerNodesListClick(Sender: TObject);
begin
  Power.enabled(PowerNodesList.ItemIndex, PowerNodesList.Checked[PowerNodesList.ItemIndex]);
  PoweredDevs.Caption := Power.listPowered;
end;

end.
