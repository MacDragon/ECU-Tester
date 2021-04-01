unit global;

interface

uses Vcl.Forms;

type
  DeviceIDtype = (
    Buzzer,
    Telemetry,
    Front1,
    Inverters,
    ECU,
    Front2,
    LeftFans,
    RightFans,
    LeftPump,
    RightPump,
    IVT,
    Current,
    TSAL,
    Accu,
    AccuFan,
    Brake,
    LV,
    HV,
    AllowHV,
    None
  );

  TMsgArray = array[0..7] of byte;

  DeviceIDtypes = set of DeviceIDtype;


 pForm = ^TForm;

const
  NodeAck_ID = 601;
  RPDO1_id = $200;
  RPDO2_id = $300;
  RPDO3_id = $400;
  RPDO4_id = $500;
  RPDO5_id = $540;
  SDORX_id = $580;

implementation


function InterPolateSteering(SteeringAngle : Integer) : Word;
   var
     i, dx, dy : Integer;

   const
     Input : Array[0..20] of Integer  = ( -100,-90,-80,-70,-60,-50,-40,-30,-20,-10,
                                  0,10,20,30,40,50,60,70,80,90,100 );

     Output  : Array[0..20] of Word = ( 1210,1270,1320,1360,1400,1450,1500,1540,1570,1630,
                                1680,1720,1770,2280,2700,3150,3600,4100,4700,5000,5500 );
   // output steering range. +-100%
   begin
      if SteeringAngle < Input[0] then
      begin
         result := Output[0];
         exit;
      end;

      if SteeringAngle > Input[Length(Input)-1] then
      begin
         result := Output[Length(Output)-1];
         exit;
      end;

    // loop through input values table till we find space where requested fits.
      i := 0;
      while Input[i+1] < SteeringAngle do inc(i);

      // interpolate
      dx := Input[i+1] - Input[i];
      dy := Output[i+1] - Output[i];
      Result := Round( Output[i] + ((SteeringANgle - Input[i]) * dy / dx) );
   end;

end.
