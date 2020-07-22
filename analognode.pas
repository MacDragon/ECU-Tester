unit analognode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.CheckLst, Device, powernode, PowerHandler, global, Vcl.StdCtrls,
  Vcl.Mask;

const
  AnalogNode1_ID  = 1664;
  AnalogNode9_ID  = 1680;
  AnalogNode10_ID	= 1682;
  AnalogNode11_ID	= 1684;

  AnalogNodeCount = 3;

type
  TAnalogNode = class(TDevice)
     constructor Create(powerhandler: TPowerHandler; powersource : DeviceIDType; node_id : Integer; can_id : Integer );
  protected
    node_id : integer;
  end;

  TAnalogNode1 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;

  TAnalogNode9 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;

  TAnalogNode11 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;

  TAnalogNodeListItem = record
    name : String;
    node_id : Integer;
    node: TDevice;
  end;

  TAnalogNodeListHandler = class(TObject)
  public
    constructor Create( powerhandler : TPowerHandler; List : TCheckListBox);
//    procedure processSync;
  private
       listptr : TCheckListBox;
  end;

  TAnalogNodesForm = class(TForm)
    AnalogNodesList: TCheckListBox;
    ADCGroup: TGroupBox;
    Label6: TLabel;
    Label4: TLabel;
    LabelAccelL: TLabel;
    LabelAccelR: TLabel;
    LabelBrakeF: TLabel;
    LabelBrakeR: TLabel;
    LabelSteering: TLabel;
    Label9: TLabel;
    Coolant2: TEdit;
    Coolant1: TEdit;
    DriveMode: TComboBox;
    Steering: TMaskEdit;
    ScrollSteering: TScrollBar;
    BrakePedal: TScrollBar;
    BrakeR: TEdit;
    BrakeF: TEdit;
    AccelPedal: TScrollBar;
    AccelR: TEdit;
    AccelL: TEdit;
    Regen: TEdit;
    ScrollRegen: TScrollBar;
    Label1: TLabel;
    procedure BrakePedalChange(Sender: TObject);
    procedure ScrollSteeringChange(Sender: TObject);
    procedure SteeringChange(Sender: TObject);
    procedure AccelPedalChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AnalogNodesForm: TAnalogNodesForm;
  AnalogNodes : TAnalogNodeListHandler;

implementation

uses CanTest, devicelist;

{$R *.dfm}

var
  Node1 : TAnalogNode1;
  Node9 : TAnalogNode9;
  Node11 : TAnalogNode11;

  nodes : array[0..2] of TAnalogNodeListItem =
  ( ( name : 'Node1'; node_id : 1 ),
   ( name : 'Node9'; node_id : 9 ),
   ( name : 'Node11'; node_id : 11 )
   );

constructor TAnalogNode.Create(powerhandler: TPowerHandler;
  powersource: DeviceIDType; node_id: Integer; can_id : Integer );
begin
  inherited Create(powerhandler, powersource, can_id);
  self.node_id := node_id;
end;

procedure TAnalogNode1.SyncHandler;
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;

  msgout[0] := 0;     // dhab current? leave zero for now.
  msgout[1] := 0;

  tmp := round((( 4095/110 ) * StrToIntDef(AnalogNodesForm.AccelL.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[2] := byte(tmp shr 8);
  msgout[3] := byte(tmp);

  tmp := round((( 4095/110 ) * StrToIntDef(AnalogNodesForm.Regen.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[4] := byte(tmp shr 8);
  msgout[5] := byte(tmp);

  CanSend(can_id,msgout,6,0);
end;


procedure TAnalogNode9.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  CanSend(can_id,msgout,6,0);
end;


procedure TAnalogNode11.SyncHandler;
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;

    // brake temp FL 16

    // brake pres F  8

  msgout[2] := StrToIntDef(AnalogNodesForm.BrakeF.Text, 0);

    // brake pres L  8

  msgout[3] := StrToIntDef(AnalogNodesForm.BrakeR.Text, 0);

    // APPS 1 8

  tmp := round((( 4095/110 ) * StrToIntDef(AnalogNodesForm.AccelR.Text, 0))+100);     // ensures no actual zero or max values.
 // msgout[] := byte(tmp shr 8);
  msgout[4] := byte(tmp shr 8);
  msgout[5] := byte(tmp);

  // surely should be 2 bytes? and brake pressures too?

  CanSend(can_id,msgout,6,0);
end;



function IsBitSet(const AValueToCheck, ABitIndex: Integer): Boolean;
begin
  Result := AValueToCheck and (1 shl ABitIndex) <> 0;
end;

constructor TAnalogNodeListHandler.Create( powerhandler : TPowerHandler; List: TCheckListBox);
var
  I : Integer;
begin
  //inherited Create(powerhandler, none);
  nodes[0].node := TAnalogNode1.Create(powerhandler, LV, nodes[0].node_id, AnalogNode1_ID);
  nodes[1].node := TAnalogNode9.Create(powerhandler, LV, nodes[1].node_id, AnalogNode9_ID);
  nodes[2].node := TAnalogNode11.Create(powerhandler, LV, nodes[2].node_id, AnalogNode11_ID);

  listptr := List;

  for I := 0 to AnalogNodeCount-1 do
  begin
     listptr.Items.Add(nodes[i].name);
     listptr.Checked[i] := true;
     nodes[I].node.Enabled := true;
 //    Devices.registerdevice(nodes[I].node);
  end;

//   i := listptr.Items.Count-1;
end;

{
procedure TAnalogNodeListHandler.processSync;
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
      if @nodes[i].node <> nil then
        nodes[i].node.processSync;
     end;
    end;
end;
}

procedure TAnalogNodesForm.AccelPedalChange(Sender: TObject);
begin
   AccelL.Text := AccelPedal.Position.ToString;
   AccelR.Text := AccelPedal.Position.ToString;
end;

procedure TAnalogNodesForm.BrakePedalChange(Sender: TObject);
begin
   BrakeF.Text := BrakePedal.Position.ToString;
   BrakeR.Text := BrakePedal.Position.ToString;
end;

procedure TAnalogNodesForm.ScrollSteeringChange(Sender: TObject);
begin
  Steering.Text := ScrollSteering.Position.ToString;
end;

procedure TAnalogNodesForm.SteeringChange(Sender: TObject);
begin
  ScrollSteering.position := StrToInt(Steering.Text);
end;

end.
