unit ivt;

interface

uses Vcl.CheckLst;


type
  TNodeFunction = procedure( id : Integer );

  TAnalogNode = record
    name : String;
    id : Integer;
    payload: TNodeFunction;
  end;

  TIVTHandler = class(TObject)
  public
    constructor Create(List : TCheckListBox );
    procedure processSync;
    procedure sendIVT(msg0, msg1, msg2, msg3 : byte);
  private
  end;

implementation

uses powernode, System.SysUtils, CanTest;


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

constructor TIVTHandler.Create(List: TCheckListBox);
var
  I : Integer;
begin

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


{

procedure IVTprogramCycClick(Sender: TObject);
begin
  with CanChannel1 do begin
    if not Active then begin
      if True then

     // Bitrate := canBITRATE_500K;
      Bitrate := canBITRATE_1M;

      Channel := CanDevices.ItemIndex;

      Open;
      OnCanRx := CanChannel1CanRx;
      BusActive := true;
      CanDevices.Enabled := false;
      StartTime := Now;
      SendCANADC.Enabled := true;
      with CanChannel1 do begin
          sendIVT( $34, 0, 1, 0);     // stop operation.
       //   sendIVT( $3A ,2, 0, 0);     // set 1mbit canbus.

         // cyclic default settings..
          sendIVT( $20, 2, 0, 10);  // current 20ms
          sendIVT( $21, 2, 0, 10);  // voltages 60ms
          sendIVT( $22, 2, 0, 10);
          sendIVT( $23, 0, 0, 10);

          sendIVT( $24, 0, 0, 100);    // temp on. 100ms
          sendIVT( $25, 2, 0, 100);    // watts on. 100ms
          sendIVT( $26, 0, 0, 100);   // watt hours on.  100ms
          sendIVT( $27, 2, 0, 255);   // watt hours on.  100ms
          sendIVT( $32, 0, 0, 100);   // save settings.
          sendIVT( $34, 1, 1, 0);    // turn operation back on.

//          BusActive := false;

      end
    end;
  end;
end;

procedure IVTprograTrigClick(Sender: TObject);
begin
  with CanChannel1 do begin
    if not Active then begin
      if True then

   //   Bitrate := canBITRATE_500K;
      Bitrate := canBITRATE_1M;

      Channel := CanDevices.ItemIndex;

      Open;
      OnCanRx := CanChannel1CanRx;
      BusActive := true;
      StartTime := Now;
      with CanChannel1 do begin
          sendIVT( $34, 0, 1, 0);     // stop operation.
       //   sendIVT( $3A ,2, 0, 0);     // set 1mbit canbus., cycle connection after.
       // 1041, 52, 0, 1, 0 // stop operation
       // 1041, 58, 4, 0, 0     <- 500k , 2 for 1mbitm

       // reset everything message, 48, 0, 0, 0, 0, 19, 235

      // ivt serial no 5099 ( 0,0, 19, 235 )

      // alive message, 191, can id for messages ( hi, lo), serial  ( hh, hm, ml, ll )



              // cyclic 100ms settings.
          sendIVT( $20, 1, 0, 1);   // current
          sendIVT( $21, 1, 0, 1);   // v1
          sendIVT( $22, 1, 0, 1);   // v2
          sendIVT( $23, 1, 0, 1);   // v3
          sendIVT( $24, 1, 0, 1);   // temp

          sendIVT( $25, 1, 0, 1);   // watts on.
          sendIVT( $26, 1, 0, 1);   // As?
          sendIVT( $27, 1, 0, 1);   // watt hours on.

          sendIVT( $32, 1, 0, 1);   // save settings.
          sendIVT( $34, 1, 1, 0);

                                    // trigger $31, 7 = i,v1,v2
       //   BusActive := false;

      end
    end;
  end;
end;

}

end.
