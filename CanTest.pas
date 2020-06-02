unit CanTest;

interface

{$Define HPF20}

uses
//  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
//  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CanChanEx, Vcl.ExtCtrls,
//  Vcl.Mask;
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, CanChanEx, ExtCtrls,
  Mask, System.Diagnostics;


type
  TMainForm = class(TForm)
    goOnBus: TButton;
    SendCANADC: TButton;
    timer200ms: TTimer;
    Output: TListBox;
    GroupBox1: TGroupBox;
    CanDevices: TComboBox;
    TS: TButton;
    RTDM: TButton;
    Start: TButton;
    SendADC: TCheckBox;
    Label3: TLabel;
    TimeReceived: TLabel;
    Crash: TButton;
    Clear: TButton;
    SendNMTWakeups: TButton;
    Log: TCheckBox;
    IVTprogramTrig: TButton;
    IVTprogramCyc: TButton;
    PDMGroup: TGroupBox;
    IMD: TCheckBox;
    BSPD: TCheckBox;
    BMS: TCheckBox;
    ComboBox1: TComboBox;
    GroupBox3: TGroupBox;
    RTDMLED: TCheckBox;
    TSOffLED: TCheckBox;
    TSLED: TCheckBox;
    IMDLED: TCheckBox;
    BMSLED: TCheckBox;
    BSPDLED: TCheckBox;
    GetADC: TButton;
    GetADCMinMax: TButton;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    AccelLR: TLabel;
    AccelRR: TLabel;
    BrakeFR: TLabel;
    BrakeRR: TLabel;
    SteeringR: TLabel;
    MaxNmR: TLabel;
    TempLR: TLabel;
    TempRR: TLabel;
    Label37: TLabel;
    Label16: TLabel;
    TorqueRqLR: TLabel;
    TorqueRqRR: TLabel;
    OnBus: TLabel;
    CanDeviceGroup: TGroupBox;
    Inverters: TCheckBox;
    PDM: TCheckBox;
    FLSpeed: TCheckBox;
    FRSpeed: TCheckBox;
    CANBMS: TCheckBox;
    Pedals: TCheckBox;
    IMU: TCheckBox;
    IVT: TCheckBox;
    Label17: TLabel;
    Label18: TLabel;
    SpeedRLR: TLabel;
    SpeedRRR: TLabel;
    GroupBox6: TGroupBox;
    HV: TCheckBox;
    Buzz: TCheckBox;
    Label21: TLabel;
    BrakeBalR: TLabel;
    EmuMaster: TCheckBox;
    Label5: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    CurrentR: TLabel;
    PowerR: TLabel;
    InvVR: TLabel;
    BMSVR: TLabel;
    AccelRRRaw: TLabel;
    AccelLRRaw: TLabel;
    BrakeFRRaw: TLabel;
    BrakeRRRaw: TLabel;
    SteeringRRaw: TLabel;
    DrivemodeRRaw: TLabel;
    TempLRRaw: TLabel;
    TempRRRaw: TLabel;
    Label25: TLabel;
    DrivemodeR: TLabel;
    canerrorcount: TLabel;
    Label26: TLabel;
    timer10ms: TTimer;
    timer100ms: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    State: TLabel;
    StateInfo: TLabel;
    HVon: TCheckBox;
    Label19: TLabel;
    Label20: TLabel;
    InverterLStat: TLabel;
    InverterRStat: TLabel;
    InverterLInternal: TLabel;
    Label30: TLabel;
    SpeedFLR: TLabel;
    SpeedFRR: TLabel;
    HVForce: TButton;
    IVTCAN1: TCheckBox;
    ShutD: TCheckBox;
    ADCGroup: TGroupBox;
    Coolant2: TEdit;
    Label6: TLabel;
    Label4: TLabel;
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
    LabelAccelL: TLabel;
    LabelAccelR: TLabel;
    LabelBrakeF: TLabel;
    LabelBrakeR: TLabel;
    LabelSteering: TLabel;
    Label9: TLabel;
    SendConfig: TButton;
    GetConfig: TButton;
    testeepromwrite: TButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure goOnBusClick(Sender: TObject);
    procedure SendCANADCClick(Sender: TObject);
    procedure CanDevicesChange(Sender: TObject);
    procedure ScrollSteeringChange(Sender: TObject);
    procedure SteeringChange(Sender: TObject);
    procedure TSClick(Sender: TObject);
    procedure RTDMClick(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure SendInverterClick(Sender: TObject);
    procedure CrashClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure InvertersClick(Sender: TObject);
    procedure PDMClick(Sender: TObject);
    procedure FLSpeedClick(Sender: TObject);
    procedure FRSpeedClick(Sender: TObject);
    procedure PedalsClick(Sender: TObject);
    procedure CANBMSClick(Sender: TObject);
    procedure SendNMTWakeupsClick(Sender: TObject);
    procedure IMUClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IVTprograTrigClick(Sender: TObject);
    procedure IVTClick(Sender: TObject);
    procedure IVTprogramCycClick(Sender: TObject);
    procedure GetADCClick(Sender: TObject);
    procedure GetADCMinMaxClick(Sender: TObject);
    procedure BMSClick(Sender: TObject);
    procedure IMDClick(Sender: TObject);
    procedure BSPDClick(Sender: TObject);
    procedure timer200msTimer(Sender: TObject);
    procedure timer10msTimer(Sender: TObject);
    procedure AccelPedalChange(Sender: TObject);
    procedure BrakePedalChange(Sender: TObject);
    procedure SendADCClick(Sender: TObject);
    procedure timer100msTimer(Sender: TObject);
    procedure HVForceClick(Sender: TObject);
    procedure EmuMasterClick(Sender: TObject);
    procedure SendConfigClick(Sender: TObject);
    procedure GetConfigClick(Sender: TObject);
    procedure testeepromwriteClick(Sender: TObject);
  private
    { Private declarations }
    StartTime: TDateTime;
    CanChannel1: TCanChannelEx;
    logFile, adcdata : TextFile;
    logOpen : Boolean;
    MainStatus : Word;
    InverterLStatus : Word;
    InverterLStatusRequest : Word;
    InverterRStatus : Word;
    InverterRStatusRequest : Word;
    ErrorPos : Word;
    Sanityfail : Boolean;
    CANFail : Boolean;
    ACKReceived : Boolean;
    SendData : Boolean;
    ReceiveData : Boolean;

    SendPos : Integer;
    SendTime : TStopwatch;
    SendBuffer: array[0..4095] of byte;
    ReceiveSize : Integer;
    procedure SendNextData;
    procedure SendDataAck(code: byte);
    procedure ReceiveNextData(var data : array of byte );
    procedure CanChannel1CanRx(Sender: TObject);
    function InterPolateSteering(SteeringAngle : Integer) : Word;
    procedure sendIVT(msg0, msg1, msg2, msg3 : byte);
    procedure sendINVL;
    procedure sendINVR;

    function CanSend(id: Longint; var msg; dlc, flags: Cardinal): integer;
  public
    { Public declarations }
    procedure PopulateList;
  end;

var
  MainForm: TMainForm;

implementation

uses DateUtils, canlib;

{$R *.dfm}

const
{$IfDef HPF19}
  PDMReceived = 0;
  BMSReceived = 1;
  InverterReceived	= 2;
  InverterLReceived	= 2;
  FLeftSpeedReceived	= 3;
  FRightSpeedReceived =	4;
  PedalADCReceived	= 5;
  IVTReceived = 6;
  InverterRReceived = 7;
{$EndIf}

{$IfDef HPF20}
  PDMReceived = 6;
  BMSReceived = 5;
  Inverter1Received	= 0;
  Inverter2Received	= 2;
  PedalADCReceived	= 4;
  IVTReceived = 8;
 // InverterRReceived = 7;
{$EndIf}

  BrakeFErrorBit = 0;
  BrakeRErrorBit = 1;
  Coolant1ErrorBit = 2;
  Coolant2ErrorBit = 3;
  SteeringAngleErrorBit	= 4;
  AccelLErrorBit = 5;
  AccelRErrorBit = 6;
  ADCholdingbit	= 7;

  InverterLErrorBit	= 9;
  InverterRErrorBit	= 10;

  BMSVoltageErrorBit = 11;

  var
    badvalue : byte;


function TMainForm.CanSend(id: Longint; var msg; dlc, flags: Cardinal): integer;
var exception : Boolean;
begin
  exception := false;
  with CanChannel1 do
  begin
    try
      Check(Write(id, msg, dlc, flags), 'Write failed');
    except
      if not CANFail then
        Output.Items.Add('Error Sending to CAN');
      exception := true;
      goOnBusClick(nil);
    end;
    if exception then CANFail := true else CANFail := false;
  end;
  result := 0;
end;

procedure TMainForm.StartClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
 msg[1] := 1;
  with CanChannel1 do begin
    CanSend($612, msg, 1 { sizeof(msg) }, 0);
    Output.Items.Add('Sending Start');
  end;
end;


procedure TMainForm.IMDClick(Sender: TObject);
begin
  PDMClick(nil);
end;

function TMainForm.InterPolateSteering(SteeringAngle : Integer) : Word;
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


procedure TMainForm.InvertersClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin

  msg[0] := 0;
  msg[1] := 0;
  msg[2] := 0;
  if Inverters.Checked then
  begin
    with CanChannel1 do
    begin
      if Active then
      begin
            CanSend($77E,msg,2,0);  // inverter NMT response
            InverterLStatus := 64;
            InverterRStatus := 64;
            MainStatus := 0;
            InverterLStat.Caption := IntToStr(InverterLStatus);
            InverterRStat.Caption := IntToStr(InverterRStatus);
            SendInverterClick(nil);
      end;
    end;
  end;
end;



procedure TMainForm.sendINVL;
var
  msg: array[0..7] of byte;
begin
      if Inverters.checked then

      with CanChannel1 do
      begin
        case InverterLStatusRequest of
          128 : InverterLStatus := 64;

          6:  InverterLStatus := 49;

          7:  InverterLStatus := 51;

          15: InverterLStatus := 55;

          0  : //  send error state       InverterLStatus := 104    -- error

        else
             //     msg[0] := 0;
        end;


        msg[0] := InverterLStatus;
        msg[1] := 22;
        msg[2] := 0;
        msg[3] := 0;
        msg[4] := 0;
        msg[5] := 0;



   //     if Random(100) > 50 then  msg[1] := 0;

        CanSend($2fe,msg,6,0);

        msg[1] := 22+badvalue;

                badvalue := 0;

        CanSend($3fe,msg,4,0);
        InverterLStat.Caption := IntToStr(InverterLStatus);
      end;
end;

procedure TMainForm.sendINVR;
var
  msg: array[0..7] of byte;
begin
      if Inverters.checked then
      with CanChannel1 do
      begin
        case InverterRStatusRequest of
          128 : InverterRStatus := 64;

          6:  InverterRStatus := 49;

          7:  InverterRStatus := 51;

          15: InverterRStatus := 55;

        else
 //                 msg[0] := 0;
        end;


        msg[0] := InverterRStatus;
        msg[1] := 22;
        msg[2] := 0;
        msg[3] := 0;
        msg[4] := 0;
        msg[5] := 0;

  //      if Random(100) > 50 then  msg[1] := 0;

        CanSend($2ff,msg,6,0);

        msg[1] := 22;

        CanSend($3ff,msg,4,0);
        InverterRStat.Caption := IntToStr(InverterRStatus);
      end;
end;

procedure TMainForm.sendIVT(msg0, msg1, msg2, msg3 : byte);
var
  msg: array[0..7] of byte;
begin
    msg[0] := msg0;
    msg[1] := msg1;
    msg[2] := msg2;
    msg[3] := msg3;
    Output.Items.Add('IVTSend('+IntToStr(msg[0] )+','+IntToStr(msg[1] )+','+
                            IntToStr(msg[2] )+','+  IntToStr(msg[3] )+')');
    with CanChannel1 do CanSend($411, msg, 8, 0);
    Sleep(100);
end;

procedure TMainForm.IVTClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  if EmuMaster.checked then
  begin
    msg[0] := 0;  // insert an IVT value here.
    msg[1] := 0;
    msg[2] := 0;
    msg[3] := 0;
    msg[4] := 90;
    msg[5] := 10;

    with CanChannel1 do
    begin
      if Active then
      begin
        if IVT.Checked then
        begin

          CanSend($521,msg,6,0);  // IVT
          msg[0] := 1;  // insert an IVT value here.

          if HVOn.checked then
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
end;

procedure TMainForm.IVTprogramCycClick(Sender: TObject);
{var
  msg: array[0..7] of byte;
  formattedDateTime : String;
  }
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

procedure TMainForm.IVTprograTrigClick(Sender: TObject);
{var
  msg: array[0..7] of byte;
  formattedDateTime : String;
}
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

procedure TMainForm.PDMClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  if EmuMaster.checked then
  begin
    if BMS.checked then msg[0] := 1 else msg[0] := 0;
    if IMD.checked then msg[1] := 1 else msg[1] := 0;
    if BSPD.checked then msg[2] := 1 else msg[2] := 0;

    if ShutD.checked then msg[6] := 0 else msg[6] := 1;


    msg[1] := msg[1];//+badvalue;
   // if badvalue>0 then badvalue := badvalue-1;
  
    msg[3] := 100;
    msg[4] := 100;
    msg[5] := 0;
   // msg[6] := 0;
    msg[7] := msg[6]; // checked to be equal.

    with CanChannel1 do
    begin
      if Active then
      begin
        if PDM.Checked then
        begin
          CanSend($520,msg,8,0);  // PDM
        end;
      end;
    end;
  end;
end;

procedure TMainForm.PedalsClick(Sender: TObject);

var
  msg: array[0..7] of byte;
begin
  if EmuMaster.checked then
  begin
    msg[0] := 0;
    msg[1] := 0;
    msg[2] := 0;
    with CanChannel1 do
    begin
      if Active then
      begin
        if Pedals.Checked then
        begin
          SendCANADCClick(nil);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.PopulateList;
var
  i : Integer;
  p : AnsiString;
begin
  SetLength(p, 64);
  CanDevices.Items.clear;
  CanChannel1.Options := [ccNoVirtual];
  for i := 0 to CanChannel1.ChannelCount - 1 do
  begin
    if ansipos('Virtual', CanChannel1.ChannelNames[i]) = 0 then  // don't populate virtual channels.
      CanDevices.Items.Add(CanChannel1.ChannelNames[i]);
  end;
  if CanDevices.Items.Count > 0 then
    CanDevices.ItemIndex := 0;
end;

procedure TMainForm.RTDMClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
 msg[1] := 1;
  with CanChannel1 do begin
    Output.Items.Add('Sending RTDM');
    CanSend($611, msg, 1 { sizeof(msg) }, 0);
  end;
end;

procedure TMainForm.BrakePedalChange(Sender: TObject);
begin
   BrakeF.Text := BrakePedal.Position.ToString;
   BrakeR.Text := BrakePedal.Position.ToString;
end;

procedure TMainForm.ScrollSteeringChange(Sender: TObject);
begin
  Steering.Text := ScrollSteering.Position.ToString;
end;

procedure TMainForm.SendADCClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  with CanChannel1 do
  begin
    if SendADC.checked then  // send our 'fake' adc data from form input.
    begin
      msg[0] := 1;
      msg[1] := 99; // if received value in ID is not 0 assume true and switch to fakeADC over CAN.
    end else
        begin
      msg[0] := 0;
      msg[1] := 0; // if received value in ID is not 0 assume true and switch to fakeADC over CAN.
    end;
    if Active then CanSend($600,msg,2,0);
  end;
  SendCANADC.Enabled := SendADC.Checked;
end;

procedure TMainForm.SendCANADCClick(Sender: TObject);
var
  msg: array[0..7] of byte;  { this was defined as char in original test code
which is nowadays 16 bit in delphi. }
const
  ADCENABLE = $600;
  ADCID  = $601;
  DrivingModeValue : array[0..7] of word = ( 5, 10,15,20,25,30,45, 65 );
begin
  with CanChannel1 do begin
    if Boolean ( SendADC.checked ) then  // send our 'fake' adc data from form input.
    begin
      msg[0] := StrToInt(Steering.Text);
      msg[1] := StrToInt(AccelL.Text);
      msg[2] := StrToInt(AccelR.Text);
      msg[3] := StrToInt(BrakeF.Text);
      msg[4] := StrToInt(BrakeR.Text);
      msg[5] := DrivingModeValue[DriveMode.ItemIndex];
      msg[6] := StrToInt(Coolant1.Text);
      msg[7] := StrToInt(Coolant2.Text);
      CanSend(ADCID,msg,8,0);
      end;
      //Output.Items.Add('ADCSent() : '+TimeToStr(System.SysUtils.Now));
    end;
end;

procedure TMainForm.SendConfigClick(Sender: TObject);
var
  openDialog : topendialog;    // Open dialog variable
  F: TFileStream;
begin

  if ( MainStatus = 1) and ( not SendData ) then
  begin

    // Create the open dialog object - assign to our open dialog variable
    openDialog := TOpenDialog.Create(self);

    // Set up the starting directory to be the current one
    openDialog.InitialDir := GetCurrentDir;

    // Only allow existing files to be selected
    openDialog.Options := [ofFileMustExist];

    // Allow only .dpr and .pas files to be selected
    openDialog.Filter :=
      'ECU EEPROM Datafile|*.dat';

    // Select pascal files as the starting filter type
    openDialog.FilterIndex := 1;

    // Display the open file dialog
    if openDialog.Execute
    then
    begin
      openDialog.FileName;

      F := TFileStream.Create(openDialog.FileName, fmOpenRead);

      if F.Size = 4096 then
      begin
        F.Read(SendBuffer, 4096);
      end;

      F.Free;

      SendConfig.Enabled := false;
      GetConfig.Enabled := false;
      Output.Items.Add('Sending EEPROM Data.');
      SendData := true;
      SendPos := -1;
      SendNextData;

    end
    else ShowMessage('Open file was cancelled');

    // Free up the dialog
    openDialog.Free;
  end;
end;

procedure TMainForm.SendInverterClick(Sender: TObject);
begin
  if EmuMaster.checked then
  begin
    sendINVL;
    sendINVR;
  end;
end;

procedure TMainForm.SendNMTWakeupsClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  if EmuMaster.checked then
  begin
    msg[0] := 0;
    msg[1] := 0;
    msg[2] := 0;

    with CanChannel1 do
    begin
      if Active then
      begin
        if Inverters.Checked then
        begin
          CanSend($77E,msg,2,0);  // inverter NMT response
          InverterLStatus := 64;
          InverterRStatus := 64;
          MainStatus := 0;
          InverterLStat.Caption := IntToStr(InverterLStatus);
          InverterRStat.Caption := IntToStr(InverterRStatus);
          SendInverterClick(nil);
        end;
      end;
    end;
  //  CANBMSClick(nil);
  //  InvertersClick(nil);
  //  FLSpeedClick(nil);
  //  FRSpeedClick(nil);
  //  PDMClick(nil);               now on timer.

    if Pedals.Checked then
    begin
    //  PedalsClick(nil);
      // Check(CanChannel1.Write($520,msg,3,0);  // PDM response
    end;
  end;
end;

procedure TMainForm.SteeringChange(Sender: TObject);
begin
  ScrollSteering.position := StrToInt(Steering.Text);
 // Output.Items.Add(IntToStr(InterPolateSteering(StrToInt((Steering.Text)))));
end;

procedure TMainForm.timer100msTimer(Sender: TObject);
var
  msg: array[0..5] of byte;
begin

  if SendData then  // ensure timeout runs
  begin
     if SendTime.ElapsedMilliseconds > 1000  then
      begin
        // timeout
        SendData := false;
        SendPos := -1;
        SendConfig.Enabled := true;
        GetConfig.Enabled := true;
        Output.Items.Add('Send Timeout');
      end;
  end;

  if ReceiveData then  // ensure timeout runs
  begin
     if SendTime.ElapsedMilliseconds > 1000  then
      begin
        // timeout
        ReceiveData := false;
        SendPos := -1;
        SendConfig.Enabled := true;
        GetConfig.Enabled := true;
        Output.Items.Add('Receive Timeout');
      end;
  end;

  if EmuMaster.checked then
  begin
        InverterRStat.Caption := IntToStr(InverterRStatus);
        InverterLStat.Caption := IntToStr(InverterLStatus);
  end;
  if IVTCAN1.checked then
  begin
  if Active then

    msg[0] := 0;
    msg[1] := 1;
    msg[2] := 0;
    msg[3] := 0;
    msg[4] := 0;
    msg[5] := 1;
    with CanChannel1 do begin
      if Active then
      CanSend($521, msg, 6 { sizeof(msg) }, 0);
    end;
        msg[0] := 1;
        msg[4] := $50;
        msg[5] := $3C;

    with CanChannel1 do begin
      if Active then
      CanSend($522, msg, 6 { sizeof(msg) }, 0);
    end;
        msg[0] := 2;
    with CanChannel1 do begin
      if Active then
      CanSend($523, msg, 6 { sizeof(msg) }, 0);
    end;

  end;
end;

procedure TMainForm.SendDataAck(code: byte);
var
  msg: array[0..7] of byte;
begin
        msg[0] := 30; // send err
        msg[1] := code;
        CanSend($21,msg,3,0);
end;

procedure TMainForm.ReceiveNextData( var data: array of byte );
var
  receivepos : integer;
  msg: array[0..7] of byte;
  F: TFileStream;
  saveDialog : tsavedialog;    // Save dialog variable
begin

		 receivepos := data[1]*256+data[2];
			// check receive buffer address matches sending position
			if ( receivepos <> SendPos ) then
      begin
				// unexpected data sequence, reset receive status;

		//		resetReceive();
				Output.Items.add('Receive OutSeq.');
        SendDataAck(99);
			 //	CAN_SendStatus(ReceivingData,ReceiveErr,0);
			end else // position good, continue.
			begin

				if SendPos+data[3]<=4096 then
				begin

          move(data[4], SendBuffer[SendPos], data[3]);

					if (data[3] < 4) then // data received ok, but wasn't full block. end of data.
					begin
            Inc(Sendpos, data[3]);
            SendDataAck(1);
					end else
					begin
            Inc(Sendpos, 4);
            SendDataAck(1);
					end;

          if (data[3] = 0 ) then
          begin
						ReceiveData := false;
            GetConfig.Enabled := true;
            SendConfig.Enabled := true;
						Output.Items.Add('Receive Done.');


            // Create the save dialog object - assign to our save dialog variable
            saveDialog := TSaveDialog.Create(self);

            // Give the dialog a title
            saveDialog.Title := 'Save ECU Config data.';

            // Set up the starting directory to be the current one
            saveDialog.InitialDir := GetCurrentDir;

            // Allow only .txt and .doc file types to be saved
            saveDialog.Filter := 'ECU EEPROM Datafile|*.dat';

            saveDialog.FileName := 'ECUEEPROM.dat';

            // Set the default extension
            saveDialog.DefaultExt := 'dat';

            // Select text files as the starting filter type
            saveDialog.FilterIndex := 1;

            // Display the open file dialog
            if saveDialog.Execute
            then
            begin

              saveDialog.FileName;
              try
                F := TFileStream.Create(saveDialog.FileName, fmCreate);

                if F.Size = 0 then
                begin
                  F.Write(SendBuffer, 4096);
                end;
                Output.Items.Add('File saved.');

              except
                Output.Items.Add('Error writing file');
              end;
              F.Free;
            end;
          //  else ShowMessage('Save file was cancelled');

            // Free up the dialog
            saveDialog.Free;


          end;

				end else
				begin
					// TODO tried to receive too much data! error.
		 //			resetReceive();
     //		lcd_send_stringpos(3,0,"Receive Error.    ");
		 //			CAN_SendStatus(ReceivingData, ReceiveErr,0);
          msg[0] := 30; // send err
          msg[1] := 99;
          CanSend($21,msg,3,0);
          Output.Items.add('Receive Err.');
				end
			end;
end;

procedure TMainForm.SendNextData;
var
  msg: array[0..7] of byte;
  I : integer;
begin
  with CanChannel1 do
    begin
      if Active then
      begin
        if SendData then  // if request to send data activated.
        begin
          if SendPos = -1 then
          begin
      //      for I := 0 to 4095 do SendBuffer[I] := I;
            msg[0] := 8;

            msg[1] := byte(4096 shr 8);
            msg[2] := byte(4096);

            SendPos := 0;

            CanSend($21,msg,3,0);  // send start of transfer.
            SendTime := TStopwatch.StartNew;
          end else
          begin
          if ACKReceived then //and ( SendTime.ElapsedMilliseconds > 100 ) then
            begin
              ACKReceived := false;
              if sendpos < 4095 then // not yet at end
              begin

                msg[0] := 9; // sending byte.


                msg[1] := byte(sendpos shr 8);
                msg[2] := byte(sendpos);

            //    if sendpos=32 then sendpos:=33;

                msg[3] := 4;

                msg[4] := SendBuffer[sendpos];
                msg[5] := SendBuffer[sendpos+1];
                msg[6] := SendBuffer[sendpos+2];
                msg[7] := SendBuffer[sendpos+3];
                sendpos := sendpos+4;

                CanSend($21,msg,8,0);

  //              Sleep(100);
              end else
              if sendpos >= 4096 then
              begin
                sendpos := 4096;
                msg[1] := byte(sendpos shr 8);
                msg[2] := byte(sendpos);

                for I := 3 to 7 do msg[I] := 0;

                CanSend($21,msg,8,0);
                SendData := false;
                SendConfig.Enabled := true;
                GetConfig.Enabled := true;
                Output.Items.Add('Send Done');

              end;

            end;
          end;

      end;
    end;

  end;
end;


procedure TMainForm.timer10msTimer(Sender: TObject);

begin
//  PDMClick(nil);
//  IVTClick(nil);
//  CANBMSClick(nil);
 // SendNextData;
end;

procedure TMainForm.timer200msTimer(Sender: TObject);
begin
  if EmuMaster.checked then
  begin
    PDMClick(nil);
    CANBMSClick(nil);
    IVTClick(nil);
  end;
end;

procedure TMainForm.TSClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
 msg[1] := 1;
  with CanChannel1 do begin
    Output.Items.Add('Sending TS');
    CanSend($610, msg, 1 { sizeof(msg) }, 0);
  end;
end;

procedure TMainForm.IMUClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  if EmuMaster.checked then
  begin
    msg[0] := 0;

    msg[1] := 0;
    msg[2] := 0;

    with CanChannel1 do
    begin
      if Active then
      begin
        if PDM.Checked then
        begin
          CanSend($772,msg,3,0);  // inverter NMT response
        end;
      end;
    end;
  end;
end;

procedure TMainForm.goOnBusClick(Sender: TObject);
var
  formattedDateTime : String;
begin
  with CanChannel1 do begin
    if not Active then begin
      Bitrate := canBITRATE_1M;
      Channel := CanDevices.ItemIndex;
      //  TCanChanOption = (ccNotExclusive, ccNoVirtual, ccAcceptLargeDLC);
      //  TCanChanOptions = set of TCanChanOption;
      Options := [ccNotExclusive];
      Open;
    //  SetHardwareFilters($20, canFILTER_SET_CODE_STD);
    //  SetHardwareFilters($FE, canFILTER_SET_MASK_STD);
      OnCanRx := CanChannel1CanRx;
      BusActive := true;
      CanDevices.Enabled := false;
      onBus.Caption := 'On bus';
      goOnBus.Caption := 'Go off bus';
      StartTime := Now;
 //     SendCANADC.Enabled := true;

      AssignFile(logfile, 'canlog.txt');
      AssignFile(adcdata, 'adcdata.txt');

      if not logOpen then
      begin
         if FileExists('canlog.txt') then
           Append(logfile)
        else
           ReWrite(logfile);
        logOpen := true;
      end;
        if FileExists('adcdata.txt') then
           Append(adcdata)
        else
           ReWrite(adcdata);
      DateTimeToString(formattedDateTime, 'hh:mm:ss.zzzzzz', SysUtils.Now);

      WriteLn(logfile,'Log: ' + formattedDateTime);
      WriteLn(adcdata,'ADC saved on: ' + formattedDateTime);


      SendADCClick(nil);
      InverterLStatus := 64;
      InverterRStatus := 64;
    end
    else begin
      if logOpen then
      begin
        CloseFile(logFile);
        CloseFile(adcdata);
        logOpen := false;
      end;
      try
        BusActive := false;
      except

      end;
      onBus.Caption := 'Off bus';
      goOnBus.Caption := 'Go on bus';
      CanDevices.Enabled := true;
      SendCANADC.Enabled := false;
      Close;
    end;

  //  if Active then Label1.Caption := 'Active' else Label1.Caption := 'Inactive';

  end;
end;

procedure TMainForm.CanDevicesChange(Sender: TObject);
begin
   CanChannel1.Channel := CanDevices.ItemIndex;
end;

procedure TMainForm.ClearClick(Sender: TObject);
begin
  Output.Clear;
end;

procedure TMainForm.CrashClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
//   badvalue := 1;
  msg[0] := 1;
  msg[1] := 0;
  msg[2] := 0;

  with CanChannel1 do
  begin
    if Active then
    begin
      if FLSpeed.Checked then
      begin
        CanSend($613,msg,3,0);
      end;
    end;
  end;

end;

procedure TMainForm.EmuMasterClick(Sender: TObject);
begin
  if EmuMaster.Checked then
  begin
    CanDeviceGroup.Visible := true;
    PDMGroup.Visible := true;
  end
  else
  begin
    CanDeviceGroup.Visible := false;
    PDMGroup.Visible := false;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with CanChannel1 do
  begin
        BusActive := false;
        onBus.Caption := 'Off bus';
        goOnBus.Caption := 'Go on bus';
        CanDevices.Enabled := true;
        Close;
  end;
  try
      if logOpen then
        CloseFile(logfile);
  except
    // If there was an error the reason can be found here
    on E: EInOutError do
      writeln('File handling error occurred. Details: ', E.ClassName, '/', E.Message);
  end;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  try
    CanChannel1 := TCanChannelEx.Create(Self);
  except
     ShowMessage('Error initialisiting, are KVASER drivers installed?');
     Application.Terminate();
  end;
  EmuMasterClick(nil);
  CanChannel1.Channel := 0;
  Sanityfail := false;
  CANFail := false;
  SendData := false;
  ACKReceived := false;
  Output.clear;
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = chr(27) then Close; //  close window on hitting Esc
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  PopulateList;
end;


procedure TMainForm.FLSpeedClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  if EmuMaster.checked then
  begin
    msg[0] := 0;
    msg[1] := 0;
    msg[2] := 0;

    with CanChannel1 do
    begin
      if Active then
      begin
        if FLSpeed.Checked then
        begin
          CanSend($770,msg,3,0);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.FRSpeedClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  if EmuMaster.checked then
  begin
    msg[0] := 0;
    msg[1] := 0;
    msg[2] := 0;

    with CanChannel1 do
    begin
      if Active then
      begin
        if FRSpeed.Checked then
        begin
          CanSend($771,msg,3,0);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.GetADCClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  msg[0] := 1;
  msg[1] := 0;
  msg[2] := 0;

  with CanChannel1 do
  begin
    if Active then
    begin
        CanSend($21,msg,3,0);
    end;
  end;
end;

procedure TMainForm.GetADCMinMaxClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  msg[0] := 2;
  msg[1] := 0;
  msg[2] := 0;

  with CanChannel1 do
  begin
    if Active then
    begin
        CanSend($21,msg,3,0);

    end;
  end;
end;

procedure TMainForm.GetConfigClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin

  with CanChannel1 do
  begin
    if Active then
    begin
      if ( MainStatus = 1) and ( not SendData ) then  // only send request if in startup state.
      begin

        msg[0] := 10;
        msg[1] := 1; // specify EEPROM

        GetConfig.Enabled := false;
        SendConfig.Enabled := false;
        Output.Items.Add('Getting EEPROM Data.');
        ReceiveData := true;
        SendPos := 0;
        CanSend($21,msg,8,0);
        SendTime := TStopwatch.StartNew;
      end;
    end;
  end;

end;

procedure TMainForm.AccelPedalChange(Sender: TObject);
begin
   AccelL.Text := AccelPedal.Position.ToString;
   AccelR.Text := AccelPedal.Position.ToString;
end;

procedure TMainForm.BMSClick(Sender: TObject);
begin
 // PDMClick(nil);
end;

procedure TMainForm.BSPDClick(Sender: TObject);
begin
 // PDMClick(nil);
end;

procedure TMainForm.testeepromwriteClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  msg[0] := 11;
  with CanChannel1 do
  begin
    if Active then
    begin
      if MainStatus = 1 then  // only send request if in startup state.
      begin
        CanSend($21,msg,3,0);
      end;
    end;
  end;
end;

procedure TMainForm.HVForceClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  msg[0] := 3;
  with CanChannel1 do
  begin
    if Active then
    begin
      if MainStatus = 1 then  // only send request if in startup state.
      begin
        CanSend($21,msg,8,0);
      end;
    end;
  end;
end;

procedure TMainForm.CANBMSClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  if EmuMaster.checked then
  begin
    msg[0] := 0;//+badvalue;
    if badvalue > 0 then badvalue := badvalue-1;
    msg[1] := 0;
    msg[2] := 2;
    msg[3] := 48;
    msg[4] := 0;
    msg[5] := 0;
    msg[6] := $AB;
    msg[7] := $CD;
    // 		uint16_t voltage = CanState.BMSVolt.data[2]*256+CanState.BMSVolt.data[3];

    //	if ( CanState.BMSVolt.dlcsize == 8 &&  voltage > 480 && voltage < 600 ) // check data sanity
    with CanChannel1 do
    begin
      if Active then
      begin
        if CANBMS.Checked then
        begin
          CanSend($B,msg,8,0);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.CanChannel1CanRx(Sender: TObject);
var
  dlc, flag, time: cardinal;
  msg, msgout: array[0..7] of byte;
  i : integer;
  status : cardinal;
  id: longint;
  formattedDateTime, str : string;
begin
//  Output.Items.BeginUpdate;
  with CanChannel1 do begin
    while Read(id, msg, dlc, flag, time) >= 0 do begin
      DateTimeToString(formattedDateTime, 'hh:mm:ss.zzzzzz', SysUtils.Now);
      if flag = $20 then
      begin
        Output.Items.Add('Error Frame');
        if Output.TopIndex > Output.Items.Count - 2 then
        Output.TopIndex := Output.Items.Count - 1;
        if logOpen then
        begin
           WriteLn(logfile, 'Error Frame ' + TimeToStr(SysUtils.Now));
        end;

      end
      else
      begin
        for i := 0 to 7 do
        msgout[i] := 0;
        if logOpen then
        begin
           system.Write(logfile, id:5, dlc:4,':');
           for i := 0 to 7 do
             if i < dlc then
               system.Write(logfile, msg[i]:4)
             else
               system.Write(logfile, ' ':4);
           WriteLn(logfile,' ' + formattedDateTime:12);
        end;
        case id of


          $10 :  begin
                    Output.Items.Add(Format('State %d %d', [msg[0], msg[1]]));
         //                   if Output.TopIndex > Output.Items.Count - 2 then
                            Output.TopIndex := Output.Items.Count - 1;
                 end;

          $20+2 : begin // led status
                        TSLED.Caption := 'TS';
                        if msg[1] <>0 then
                        begin
                          TSLED.Checked := true;
                          if ( msg[1] >= 1 ) and ( msg[1] <= 8 ) then TSLED.Caption := 'TS b' + IntToStr(msg[1]);

                        end else TSLED.Checked := false;

                        RTDMLED.Caption := 'RTDM';
                        if msg[2] <> 0 then
                        begin
                          RTDMLED.Checked := true;
                           if ( msg[2] >= 1 ) and ( msg[2] <=8 )then RTDMLED.Caption := 'RTDM b' + IntToStr(msg[2]);
                        end else RTDMLED.Checked := false;

                        TSOffLED.Caption := 'TSOff';
                        if msg[3] <>0 then
                        begin
                          TSOffLED.Checked := true;
                          if ( msg[3] >= 1 ) and ( msg[3] <= 8 ) then TSOffLED.Caption := 'TSOff b'+IntToStr(msg[3]);
                        end else TSOffLED.Checked := false;


                        IMDLED.Caption := 'IMD';
                        if msg[4] <> 0 then
                        begin
                          IMDLED.Checked := true;
                           if ( msg[4] >= 1 ) and ( msg[4] <=8 )then IMDLED.Caption := 'IMD b' + IntToStr(msg[4]);
                        end else IMDLED.Checked := false;


                        BMSLED.Caption := 'BMS';
                        if msg[5] <> 0 then
                        begin
                          BMSLED.Checked := true;
                           if ( msg[5] >= 1 ) and ( msg[5] <=8 )then BMSLED.Caption := 'BMS b' + IntToStr(msg[5]);
                        end else BMSLED.Checked := false;

                        BSPDLED.Caption := 'BSPD';
                        if msg[6] <> 0 then
                        begin
                          BSPDLED.Checked := true;
                           if ( msg[6] >= 1 ) and ( msg[6] <=8 )then BSPDLED.Caption := 'BSPD b' + IntToStr(msg[6]);
                        end else BSPDLED.Checked := false;

                        //if msg[4] <>0 then IMDLED.Checked := true else IMDLED.Checked := false;
                       // if msg[5] <>0 then BMSLED.Checked := true else BMSLED.Checked := false;
                       // if msg[6] <>0 then BSPDLED.Checked := true else BSPDLED.Checked := false;
                    end;


          $20+$10  :  begin
                    AccelLRRaw.Caption := IntToStr(msg[1]*256+msg[0]);
                    AccelRRRaw.Caption := IntToStr(msg[3]*256+msg[2]);
              //      WriteLn(adcdata, TorqueRqLR.Caption+','+IntToStr(msg[1]*256+msg[0])+','+IntToStr(msg[3]*256+msg[2]));
                    BrakeFRRaw.Caption := IntToStr(msg[5]*256+msg[4]);
                    BrakeRRRaw.Caption := IntToStr(msg[7]*256+msg[6]);
                 end;

          $20+$11  : begin
                    SteeringRRaw.Caption := IntToStr(msg[1]*256+msg[0]);
                    DrivemodeRRaw.Caption := IntToStr(msg[3]*256+msg[2]);
                    TempLRRaw.Caption := IntToStr(msg[5]*256+msg[4]);
                    TempRRRaw.Caption := IntToStr(msg[7]*256+msg[6]);
                 end;

          $20+$12  :  begin
     {              WriteLn(adcdata, 'AccelLRRawError '+IntToStr(msg[1]*256+msg[0]));
                   WriteLn(adcdata, 'AccelRRRawError '+IntToStr(msg[3]*256+msg[2]));
                   WriteLn(adcdata, 'BrakeFRRawError '+IntToStr(msg[5]*256+msg[4]));
                   WriteLn(adcdata, 'BrakeRRRawError '+IntToStr(msg[7]*256+msg[6]));   }
                //   if not Sanityfail then
                   begin
                      Output.Items.Add('ADCSanityError()');
                      Sanityfail := true;
                   end;
             {      Output.Items.Add('AccelLRRawError '+IntToStr(msg[1]*256+msg[0]));
                   Output.Items.Add('AccelRRRawError '+IntToStr(msg[3]*256+msg[2]));
                   Output.Items.Add('BrakeFRRawError '+IntToStr(msg[5]*256+msg[4]));
                   Output.Items.Add('BrakeRRRawError '+IntToStr(msg[7]*256+msg[6]));   }

                 end;

          $20+$13  : begin
              {      WriteLn(adcdata, 'SteeringRRaw '+IntToStr(msg[1]*256+msg[0]));
                    WriteLn(adcdata, 'DrivemodeRRaw '+IntToStr(msg[3]*256+msg[2]));
                    WriteLn(adcdata, 'TempLRRaw '+IntToStr(msg[5]*256+msg[4]));
                    WriteLn(adcdata, 'TempRRRaw '+IntToStr(msg[7]*256+msg[6]));    }

               {     Output.Items.Add('SteeringRRaw '+IntToStr(msg[1]*256+msg[0]));
                    Output.Items.Add('DrivemodeRRaw '+IntToStr(msg[3]*256+msg[2]));
                    Output.Items.Add('TempLRRaw '+IntToStr(msg[5]*256+msg[4]));
                    Output.Items.Add('TempRRRaw '+IntToStr(msg[7]*256+msg[6]));     }
                 end;

          $21 : begin     // data receive
                  if ReceiveData then
                  begin
                    if msg[0] = 8 then  // receive data.
                    begin
                      ReceiveSize := msg[1]*256+msg[2];
                      SendPos := 0;
                      SendDataAck(1);
                      Output.Items.Add('StartReceive('+inttostr(Receivesize)+')');
                      SendTime := TStopwatch.StartNew;
                    end;

                    if msg[0] = 9 then  // receive data.
                    begin
           //            Output.Items.Add('RCV block');;
                       ReceiveNextData(msg);
                       SendTime.Reset;
                       SendTime.Start;
                    end;
                  end;
          end;

          $20 :  begin
                    if msg[0] = 20 then
                    begin
                       case msg[1] of
                          1,11,21 : str := 'TorqueF';
                          2,12,22 : str := 'TorqueR';
                          3,13,23 : str := 'BrakeF';
                          4,14,24 : str := 'BrakeR';
                          5,15,25 : str := 'Steering';
                          6,16,26 : str := 'Maxrequest';
                          7,17,27 : str := 'Temp1';
                          8,18,28 : str := 'Temp2'
                       end;

                       if msg[1] > 20 then str := str +'Max'
                       else if msg[1] > 10 then str := str + 'Min';
                       str := str + '(' + IntToStr(msg[3]*256+msg[2])+')';
                       Output.Items.Add(str);
                       WriteLn(adcdata, str);
                    end
                    else if msg[0] = $21 then
                    begin
                      case msg[1] of
                        3 :  Output.Items.Add('HVOn('+IntToStr(msg[2])+') : '+formattedDateTime);
                      end;
                    end
                    else if ( msg[0] = 30 ) then
                    begin
                        // message sending
                        if msg[1] = 1 then
                        begin
                    //      Output.Items.Add('DataAck');
                          ACKReceived := true;
                          SendTime.Reset;
                          SendTime.Start;
                          SendNextData;
                        end else if msg[1] = 99 then
                        begin
                          Output.Items.Add('DataErr!');
                          ACKReceived := false;
                          SendData := false;
                          SendTime.Stop;
                          SendNextData;
                          SendConfig.Enabled := true;
                        end;
                    end
               {     else if ( msg[0] = 100 ) and ( msg[1] = 0 ) then
                    begin
                      Output.Items.Add('Speed(Left: '+
                      IntToStr(msg[5]*16777216+msg[4]*65536+msg[3]*256+msg[2])+'rpm)');
                    end
                    else if ( msg[0] = 100 ) and ( msg[1] = 1 )  then
                    begin
                      Output.Items.Add('Speed(Right: '+
                      IntToStr(msg[5]*16777216+msg[4]*65536+msg[3]*256+msg[2])+'rpm)');
                    end    }
                    else if msg[0] >= 99 then   // can packet error.
                         begin

                           case msg[0] of
                             99 : str := 'Data:';
                             200 : str := 'Timeout:';
                           else
                             str := IntToStr(msg[0])+':';
                           end;

                           case msg[1] of
                              PDMReceived, PDMReceived+100, PDMReceived+200 : str := str + 'PDM';
                              BMSReceived, BMSReceived+100, BMSReceived+200 : str := str + 'BMS';
                              {$IfDef HPF19}
                              InverterLReceived, InverterLReceived+100, InverterLReceived+200: str := str + 'INVL';
                              InverterRReceived, InverterRReceived+100, InverterRReceived+200: str := str + 'INVR';
                              {$EndIf}

                              {$IfDef HPF20}
                              Inverter1Received, Inverter1Received+100, Inverter1Received+200: str := str + 'INV1';
                              Inverter2Received, Inverter2Received+100, Inverter2Received+200: str := str + 'INV2';
                              {$EndIf}

                              {$IfDef HPF19}
                              FLeftSpeedReceived, FLeftSpeedReceived+100, FLeftSpeedReceived+200 : str := str + 'FLS';
                              FRightSpeedReceived, FRightSpeedReceived+100, FRightSpeedReceived+200 : str := str + 'FRS';
                              {$EndIf}
                              PedalADCReceived, PedalADCReceived+100, PedalADCReceived+200 : str := str + 'ADC';
                              IVTReceived+110, IVTReceived+210  : str := str + 'IVTI';
                              IVTReceived+111, IVTReceived+211  : str := str + 'IVTU1';
                              IVTReceived+112, IVTReceived+212  : str := str + 'IVTU2';
                              IVTReceived+115, IVTReceived+215  : str := str + 'IVTW';
                           else
                               str := str + IntToStr(msg[1]);
                           end;

                           Output.Items.Add('CANError('+ str +','+IntToStr((msg[5]*16777216+msg[4]*65536+msg[3]*256+msg[2]))+') : '+formattedDateTime);
                         end
                    else
                    begin
                        if MainStatus <> msg[1] then
                        begin
                          Output.Items.Add('StatusChange('+IntToStr(msg[1])+') '+formattedDateTime);
                          Output.TopIndex := Output.Items.Count - 1;
                          MainStatus := msg[1];
                        end;

                        State.Caption := IntToStr(msg[0])+','+IntToStr(msg[1])+','+IntToStr(msg[2])
                        +','+IntToStr(msg[3])+','+ IntToStr(msg[4])+','+IntToStr(msg[5]) + ' : ' + formattedDateTime;

                    //  , Inverters('+ IntToStr(InverterLStatus) +' ' + IntToStr(InverterLStatus) + ') : ' + formattedDateTime);


                      if ( msg[1] <= 50 ) and not ( ( msg[2]=$ff ) and ( msg[3]=$ff ) ) then    // pre operational state.
                      begin
                        status := msg[2];

                        if msg[1] = 50 then status := msg[4];
                        
                        str := '';
                        if status and (1 shl PDMReceived) <> 0 then str := str + 'PDM ';
                        if status and (1 shl BMSReceived) <> 0 then str := str + 'BMS ';

                        if status and (1 shl Inverter1Received) <> 0 then
                          if msg[1] = 1 then str := str + 'INV ' else str := str + 'INVL ';

                        if status and (1 shl Inverter2Received) <> 0 then str := str + 'INVR ';
                        {$IfDef HPF19}
                        if status and (1 shl FLeftSpeedReceived) <> 0 then str := str + 'FLS ';
                        if status and (1 shl FRightSpeedReceived) <> 0 then str := str + 'FRS ';
                        {$EndIf}
                        if status and (1 shl PedalADCReceived) <> 0 then str := str + 'ADC ';
                        if status and (1 shl IVTReceived) <> 0 then str := str + 'IVT ';

                        if not ( ( msg[2]=$ff ) and ( msg[3]=$ff ) ) then    // getting devices operational state.
                        begin
                          //CAN_SendStatus(1, OperationalReadyState, sanitystate+(devicestate<<16));
                          status := msg[4]+256*msg[5];
                          str := str+' ';
                          if status and ($1 shl BrakeFErrorBit) <> 0 then str := str + 'BRF ';
                          if status and ($1 shl BrakeRErrorBit) <> 0 then str := str + 'BRR ';
                          if status and ($1 shl Coolant1ErrorBit) <> 0 then str := str + 'TMP1 ';
                          if status and ($1 shl Coolant2ErrorBit) <> 0 then str := str + 'TMP2 ';
                          if status and ($1 shl SteeringAngleErrorBit) <> 0 then str := str + 'ANG ';
                          if status and ($1 shl AccelLErrorBit) <> 0 then str := str + 'TQL ';
                          if status and ($1 shl AccelRErrorBit) <> 0 then str := str + 'TQR ';
                          if status and ($1 shl InverterLErrorBit) <> 0 then str := str + 'INVL ';
                          if status and ($1 shl InverterRErrorBit) <> 0 then str := str + 'INVR ';
                          if status and ($1 shl BMSVoltageErrorBit) <> 0 then str := str + 'BMS ';
                        end;

                        StateInfo.Caption := 'Not Received( ' +str + ')';
                      end;



                    end;



           //               if Output.TopIndex > Output.Items.Count - 2 then
                          Output.TopIndex := Output.Items.Count - 1;
                   // status messages
                 end;


           $66 : begin
                    if msg[0]+256*msg[1] <> ErrorPos then
                    begin
                      ErrorPos := msg[0]+256*msg[1];
                      Output.Items.Add('ErrorCode('+ IntToStr(msg[0]+256*msg[1])+','
                                + IntToStr(msg[2]+256*msg[3])+')'+formattedDateTime);
                      Output.TopIndex := Output.Items.Count - 1;
                    end;
                 end;

          $100 : begin
            //          Output.Items.Add(Format('Id=%d Len=%d %d', [id, dlc, msg[0]]));
       //               if Output.TopIndex > Output.Items.Count - 2 then
            //            Output.TopIndex := Output.Items.Count - 1;

                    Output.Items.Add('CanTimes('+ IntToStr(msg[0]+256*msg[1])+','
                              + IntToStr(msg[2]+256*msg[3])+','
                              + IntToStr(msg[4]+256*msg[5])+','
                              + IntToStr(msg[6]+256*msg[7])+')'+formattedDateTime);
                    Output.TopIndex := Output.Items.Count - 1;
                 end;
          $101 : begin
//          Output.Items.Add(Format('Id=%d Len=%d %d', [id, dlc, msg[0]]));
//               if Output.TopIndex > Output.Items.Count - 2 then
//            Output.TopIndex := Output.Items.Count - 1;

         {           Output.Items.Add('CanMessageCount('+ IntToStr(msg[0]+256*msg[1])+','
                              + IntToStr(msg[2]+256*msg[3])+','
                              + IntToStr(msg[4]+256*msg[5]+65536*msg[6]+16777216*msg[7])+')'+formattedDateTime);
                   Output.TopIndex := Output.Items.Count - 1;   }
                 end;




          $511 : begin
                  { Output.Items.Add('IVTReceive('+ IntToStr(msg[0])+','+IntToStr(msg[1])+','+IntToStr(msg[2])
                      +','+IntToStr(msg[3])+','+ IntToStr(msg[4])+','+IntToStr(msg[5]) +
                      ','+ IntToStr(msg[6])+','+IntToStr(msg[7])
                      +') : ' + formattedDateTime);    }
                 end;

          $118 : begin
                   if msg[0] = 0 then HV.Checked := false else HV.Checked := true;
                   if msg[1] = 0 then Buzz.Checked := false else Buzz.Checked := true;
                 end;

          $7C6  : begin
                    AccelLR.Caption := IntToStr(msg[1]+256*msg[0]); //torq_req_l can0 0x7C6 0,16be
                    AccelRR.Caption := IntToStr(msg[3]+256*msg[2]); //torq_req_r can0 0x7C6 16,16be
                    BrakeFR.Caption := IntToStr(msg[5]+256*msg[4]); //brk_press_f can0 0x7C6 32,16bee
                    BrakeRR.Caption := IntToStr(msg[7]+256*msg[6]); //brk_press_r can0 0x7C6 48,16be
                  end;

          $7C7 : begin
	                //wheel_speed_right_calculated can0 0x7c7 0,32BE
                  //wheel_speed_left_calculated can0 0x7c7 32,32BE
                    SpeedRRR.Caption := IntToStr(smallint(msg[3]+256*msg[2]));
                    SpeedRLR.Caption := IntToStr(smallint(msg[7]+256*msg[6]));
                 end;

  	      $7C8 : begin
                   TempLR.Caption := IntToStr(msg[0]); //temp_sensor1 can0 0x7c8 0,8
                   TempRR.Caption := IntToStr(msg[2]); //temp_sensor_2 can0 0x7c8 16,8

                   MaxNmR.Caption := IntToStr(msg[1]); //torq_req_max can0 0x7c8 8,8

                   DrivemodeR.Caption := IntToStr(msg[3]); //future_torq_req_max can0 0x7c8 24,8
                   TorqueRqLR.Caption := IntToStr(msg[5]+256*msg[4]); //torq_req_l_perc can0 0x7c8 32,16be
                   TorqueRqRR.Caption := IntToStr(msg[7]+256*msg[6]); //torq_req_r_perc can0 0x7c8 48,16be
                 end;

          $7CA : begin
                   BrakeBalR.Caption := IntToStr(msg[0]*16777216+msg[1]*65536+msg[2]*256+msg[3]); //brake_balance can0 0x7CA 0,32be
                   SteeringR.Caption :=  IntToStr(msg[4]*16777216+msg[5]*65536+msg[6]*256+msg[7]);
                 end;

          $7CB : begin
                   CurrentR.Caption := IntToStr(msg[1]+256*msg[0]);
                   InvVR.Caption := IntToStr(msg[5]+256*msg[4]);
                   BMSVR.Caption := IntToStr(msg[3]+256*msg[2]);
                   PowerR.Caption := IntToStr(msg[7]+256*msg[6])
                 end;

          $7CC : begin
	                //wheel_speed_right_calculated can0 0x7c7 0,32BE
                  //wheel_speed_left_calculated can0 0x7c7 32,32BE
                    SpeedFRR.Caption := IntToStr(smallint(msg[3]+256*msg[2]));
                    SpeedFLR.Caption := IntToStr(smallint(msg[7]+256*msg[6]));
                 end;

          else



          end;

          if EmuMaster.checked then
          case id of
              $80 :  begin    // canopen sync., speed sensors at least.
                {   if CANBMS.checked then
                   begin
                     CANBMSClick(nil);
                   end;      }

                   if Inverters.Checked then
                   begin
                   //   SendInverterClick(nil);
                   end;

                   if FLSpeed.Checked then
                   begin
                      for i := 0 to 7 do
                      msgout[i] := 0;

                      msgout[0] := 127;
                   //   msgout[1] := byte(500);
                      CanSend($1f0,msgout,8,0);
                   end;

                   if FRSpeed.Checked then
                   begin
                      for i := 0 to 7 do
                      msgout[i] := 0;

                      msgout[0] := 127;
                 //     msgout[1] := byte(500);
                      CanSend($1f1,msgout,8,0);
                   end;

            {       if IVT.Checked then
                   begin
                      for i := 0 to 7 do
                      msgout[i] := 0;

                      msgout[0] := 100;
                      Check(CanChannel1.Write($521,msgout,6,0);

                      msgout[4] := 5000 shr 8;
                      msgout[5] := 5000 div 256;
                      Check(CanChannel1.Write($523,msgout,6,0);
                   end;  }


                   SendCANADCClick(nil);

                 end;

          $0 :   begin  // received nmt message, respond.
              //     Output.Items.Add(Format('NMT(%d %d)', [msg[0], msg[1]]));

                   Output.TopIndex := Output.Items.Count - 1;
                   msgout[0] := 0;
                   msgout[1] := 0;
                   msgout[2] := 0;

                   if ( msg[0] = $81 ) or ( msg[0] = $82 ) or ( msg[0] = $0 ) then       // reset
                   begin
                      if msg[0] = $81 then SendNMTWakeupsClick(nil);
                      if msg[0] = $82 then SendNMTWakeupsClick(nil);

                      SendADCClick(nil);

                      if SendADC.checked then
                       begin
                          msg[0] := 1;
                          CanSend($600, msg, 1, 0); // tell ECU to use can 'ADC' values for testing.
                       end
                       else
                       begin
                          msg[0] := 0;
                          CanSend($600, msg, 1, 0); // tell ECU to not use can 'ADC' values for testing.
                       end;

                     if (msg[1] = 0) or ( msg[1] = 129 ) and CANBMS.checked then
                     begin
                       CANBMSClick(nil);
                     end;

                     if (msg[1] = 0) or ( msg[1] = 0 ) and Inverters.Checked then
                     begin
                 //       InvertersClick(nil);
                     end;

                     if (msg[1] = 0) or ( msg[1] = 112 ) and FLSpeed.Checked then
                     begin
                        FLSpeedClick(nil);
                     end;

                     if (msg[1] = 0) or ( msg[1] = 113 ) and FRSpeed.Checked then
                     begin
                        FRSpeedClick(nil);
                     end;

                     if (msg[1] = 0) or ( msg[1] = 0 ) and PDM.checked then
                     begin
                        PDMClick(nil);
                     end;

                     if (msg[1] = 0) or ( msg[1] = 0 ) and Pedals.Checked then
                     begin
                      //  PedalsClick(nil);
                        // Check(CanChannel1.Write($520,msg,3,0);  // PDM response
                     end;

                   end;

                   if ( msg[1] = $80 ) or ( msg[0] = $0 ) then begin end; // go pre operational
                 end;

          $47E : begin
                    InverterLStatusRequest := msg[0];

               {     Output.Items.Add( formattedDateTime +
                      ' InverterL 2FE sent status '
                      + IntToStr(InverterLStatus));

                    Output.TopIndex := Output.Items.Count - 1;     }
                    sendINVL;
                 end;

          $47F : begin
                   InverterRStatusRequest := msg[0];

            {      Output.Items.Add( formattedDateTime +
                  ' InverterR 2FF sent status '
                  + IntToStr(InverterRStatus));

         //            if Output.TopIndex > Output.Items.Count - 2 then
                  Output.TopIndex := Output.Items.Count - 1;
                                                            }
                  sendINVR;

                 end;
          end;

      end;


    end;
  end;
//  Output.Items.EndUpdate;
end;

end.
