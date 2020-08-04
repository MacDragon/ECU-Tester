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
  AnalogNode12_ID	= 1686;
  AnalogNode13_ID	= 1688;
  AnalogNode14_ID	= 1690;
  AnalogNode15_ID	= 1692;
  AnalogNode16_ID	= 1694;
  AnalogNode17_ID	= 1696;
  AnalogNode18_ID	= 1698;

  AnalogNodeCount = 11;

type
  TAnalogNode = class(TDevice)
     constructor Create(powerhandler: TPowerHandler; powersource : DeviceIDType; node_id : Integer; can_id : Integer; Channel : Integer );
  protected
    node_id : integer;
  end;

  TAnalogNode1 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;

  TAnalogNode9 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;

  TAnalogNode10 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;

  TAnalogNode11 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;

  TAnalogNode12 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;


  TAnalogNode13 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;


  TAnalogNode14 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;


  TAnalogNode15 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;


  TAnalogNode16 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;

  TAnalogNode17 = class(TAnalogNode)
     procedure SyncHandler; override;
  end;

  TAnalogNode18 = class(TAnalogNode)
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
  Node10 : TAnalogNode10;
  Node11 : TAnalogNode11;
 // Node11 : TAnalogNode11;

  nodes : array[0..10] of TAnalogNodeListItem =
  ( ( name : 'Node1'; node_id : 1 ),
   ( name : 'Node9'; node_id : 9 ),
   ( name : 'Node10'; node_id : 10 ),
   ( name : 'Node11'; node_id : 11 ),
   ( name : 'Node12'; node_id : 12 ),
   ( name : 'Node13'; node_id : 13 ),
   ( name : 'Node14'; node_id : 14 ),
   ( name : 'Node15'; node_id : 15 ),
   ( name : 'Node16'; node_id : 16 ),
   ( name : 'Node17'; node_id : 17 ),
   ( name : 'Node18'; node_id : 18 )
   );

constructor TAnalogNode.Create(powerhandler: TPowerHandler;
  powersource: DeviceIDType; node_id: Integer; can_id : Integer; Channel : Integer );
begin
  inherited Create(powerhandler, powersource, can_id, Channel);
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

procedure TAnalogNode10.SyncHandler;
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


procedure TAnalogNode12.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  CanSend(can_id,msgout,6,0);
end;

procedure TAnalogNode13.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  CanSend(can_id,msgout,6,0);
end;

procedure TAnalogNode14.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  CanSend(can_id,msgout,6,0);
end;


procedure TAnalogNode15.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  CanSend(can_id,msgout,6,0);
end;

procedure TAnalogNode16.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  CanSend(can_id,msgout,6,0);
end;

procedure TAnalogNode17.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
  CanSend(can_id,msgout,6,0);
end;

procedure TAnalogNode18.SyncHandler;
var
  msgout: array[0..7] of byte;
  i : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;
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
  nodes[0].node := TAnalogNode1.Create(powerhandler, LV, nodes[0].node_id, AnalogNode1_ID, 1);
  nodes[1].node := TAnalogNode9.Create(powerhandler, LV, nodes[1].node_id, AnalogNode9_ID, 0);
  nodes[2].node := TAnalogNode10.Create(powerhandler, LV, nodes[2].node_id, AnalogNode10_ID, 0);
  nodes[3].node := TAnalogNode11.Create(powerhandler, LV, nodes[3].node_id, AnalogNode11_ID, 0);
  nodes[4].node := TAnalogNode12.Create(powerhandler, LV, nodes[4].node_id, AnalogNode12_ID, 0);
  nodes[5].node := TAnalogNode13.Create(powerhandler, LV, nodes[5].node_id, AnalogNode13_ID, 0);
  nodes[6].node := TAnalogNode14.Create(powerhandler, LV, nodes[6].node_id, AnalogNode14_ID, 0);
  nodes[7].node := TAnalogNode15.Create(powerhandler, LV, nodes[7].node_id, AnalogNode15_ID, 0);
  nodes[8].node := TAnalogNode16.Create(powerhandler, LV, nodes[8].node_id, AnalogNode16_ID, 0);
  nodes[9].node := TAnalogNode17.Create(powerhandler, LV, nodes[9].node_id, AnalogNode17_ID, 0);
  nodes[10].node := TAnalogNode18.Create(powerhandler, LV, nodes[10].node_id, AnalogNode18_ID, 0);

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
