unit analognode;

interface

uses  Vcl.CheckLst;

const
  AnalogNode1_ID  = 1664;
  AnalogNode9_ID  = 1680;
  AnalogNode10_ID	= 1682;
  AnalogNode11_ID	= 1684;

  AnalogNodeCount = 3;

procedure sendNode1( id : Integer );
procedure sendNode9( id : Integer );
//procedure sendNode10( id : Integer );
procedure sendNode11( id : Integer );

type
  TNodeFunction = procedure( id : Integer );

  TAnalogNode = record
    name : String;
    id : Integer;
    payload: TNodeFunction;
  end;

  TAnalogNodeHandler = class(TObject)
  public
    constructor Create(List : TCheckListBox );
    procedure processSync;
  private
       powered : Integer;
       listptr : TCheckListBox;
  const
       nodes : array[0..2] of TAnalogNode =
       ( ( name : 'Node1'; id : AnalogNode1_ID; payload : sendNode1 ),
         ( name : 'Node9'; id : AnalogNode9_ID; payload : sendNode9 ),
         ( name : 'Node11'; id : AnalogNode11_ID; payload : sendNode11 )
         );
  end;

implementation

uses CanTest, System.SysUtils;

procedure sendNode1(id : Integer);
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;

  msgout[0] := 0;     // dhab current? leave zero for now.
  msgout[1] := 0;

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.AccelL.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[2] := byte(tmp shr 8);
  msgout[3] := byte(tmp);

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.Regen.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[4] := byte(tmp shr 8);
  msgout[5] := byte(tmp);

  MainForm.CanSend(id,msgout,6,0);
end;


procedure sendNode9(id : Integer);
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;

  msgout[0] := 0;     // dhab current? leave zero for now.
  msgout[1] := 0;

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.AccelL.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[2] := byte(tmp shr 8);
  msgout[3] := byte(tmp);

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.Regen.Text, 0))+100);     // ensures no actual zero or max values.
  msgout[4] := byte(tmp shr 8);
  msgout[5] := byte(tmp);

  MainForm.CanSend(id,msgout,6,0);
end;


procedure sendNode11(id : Integer);
var
  msgout: array[0..7] of byte;
  i, tmp : integer;
begin
  for I := 0 to 7 do
    msgout[i] := 0;

    // brake temp FL 16

    // brake pres F  8

  msgout[2] := StrToIntDef(MainForm.BrakeF.Text, 0);

    // brake pres L  8

  msgout[3] := StrToIntDef(MainForm.BrakeR.Text, 0);

    // APPS 1 8

  tmp := round((( 4095/110 ) * StrToIntDef(MainForm.AccelL.Text, 0))+100) div 256;     // ensures no actual zero or max values.
 // msgout[] := byte(tmp shr 8);
  msgout[4] := byte(tmp);

  // surely should be 2 bytes? and brake pressures too?

  MainForm.CanSend(id,msgout,6,0);
end;





function IsBitSet(const AValueToCheck, ABitIndex: Integer): Boolean;
begin
  Result := AValueToCheck and (1 shl ABitIndex) <> 0;
end;

constructor TAnalogNodeHandler.Create(List: TCheckListBox);
var
  I : Integer;
begin
  listptr := List;

  for I := 0 to AnalogNodeCount-1 do
  begin
     listptr.Items.Add(nodes[i].name);
     listptr.Checked[i] := true;
  end;

   i := listptr.Items.Count-1;
end;

procedure TAnalogNodeHandler.processSync;
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
      if @nodes[i].payload <> nil then
        nodes[i].payload(nodes[i].id);
     end;
    end;
end;

end.
