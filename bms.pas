unit bms;

interface

uses Vcl.CheckLst, device, global;

type
  TBMSHandler = class(TDevice)
  public
    procedure processSync; override;
  end;

implementation

uses System.SysUtils, CanTest, powernode;

procedure TBMSHandler.processSync;
var
  msg: array[0..7] of byte;
begin
  msg[0] := 0;//+badvalue;
  // if badvalue > 0 then badvalue := badvalue-1;
  msg[1] := 0;
  msg[2] := 2;
  msg[3] := 48;
  msg[4] := 0;
  msg[5] := 0;
  msg[6] := $AB;
  msg[7] := $CD;
  // 		uint16_t voltage = CanState.BMSVolt.data[2]*256+CanState.BMSVolt.data[3];

  //	if ( CanState.BMSVolt.dlcsize == 8 &&  voltage > 480 && voltage < 600 ) // check data sanity

  if Powered then MainForm.CanSend($B,msg,8,0);
end;

end.
