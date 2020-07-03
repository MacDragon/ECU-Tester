unit ivt;

interface

uses Vcl.CheckLst, device, global;

type
  TIVTHandler = class(TDevice)
  public
    procedure processSync; override;
  private
    procedure sendIVT(msg0, msg1, msg2, msg3 : byte);
  end;

implementation

uses System.SysUtils, CanTest, powernode;


procedure TIVTHandler.sendIVT(msg0, msg1, msg2, msg3 : byte);
var
  msg: array[0..7] of byte;
begin
    msg[0] := msg0;
    msg[1] := msg1;
    msg[2] := msg2;
    msg[3] := msg3;
    MainForm.Output.Items.Add('IVTSend('+IntToStr(msg[0] )+','+IntToStr(msg[1] )+','+
                            IntToStr(msg[2] )+','+  IntToStr(msg[3] )+')');
    MainForm.CanSend($411, msg, 8, 0);
    Sleep(100);
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


procedure TIVTHandler.processSync;
var
  msg: array[0..7] of byte;
  i : integer;
begin
  if MainForm.PowerNodes.isPowered(DeviceIDType.IVT) and MainForm.EmuMaster.checked  then
  begin
    msg[0] := 0;  // insert an IVT value here.
    msg[1] := 0;
    msg[2] := 0;
    msg[3] := 0;
    msg[4] := 90;
    msg[5] := 10;

    with MainForm do
    begin
      if IVT.Checked then
      begin

        CanSend($521,msg,6,0);  // IVT
        msg[0] := 1;  // insert an IVT value here.

        if ( HVOn.checked ) and HV.checked then
        begin
          msg[3] := 8;
          msg[4] := 90;
          msg[5] := 10;
        end
        else
        begin
          msg[3] := 0;
          msg[4] := 90;
          msg[5] := 10;
        end;

        CanSend($522,msg,6,0);  // IVT
        msg[0] := 2;  // insert an IVT value here.
        CanSend($523,msg,6,0);  // IVT

        msg[3] := 0;
        msg[4] := 90;
        msg[5] := 10;

        msg[0] := 5;  // insert an IVT value here.

        CanSend($526,msg,6,0);  // IVT

        msg[0] := 7;  // insert an IVT value here.
        CanSend($528,msg,6,0);  // IVT
      end;
    end;
  end;
end;


end.
