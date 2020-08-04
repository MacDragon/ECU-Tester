unit device;

interface

uses PowerHandler, global, CanChanEx;

type
  TDevice = class(TObject)
  private
    function isEnabled: boolean;
    procedure setEnabled(const Value: boolean);
    function isPowered: boolean;
    {$ifdef devicecan}
    function isOnBus: boolean;
    procedure setOnbus(const Value: boolean);
    {$endif}
  public
    constructor Create( const powerhandler : TPowerHandler;
                        const powersource : DeviceIDtype; const can_id : Integer;
                        const channel : integer; const Cycletime : Integer = 1000 );
    procedure processSync; virtual; // send any default sync messages;

    procedure processCyclic; virtual;

    property Enabled : boolean read isEnabled write setEnabled;
    property Powered : boolean read isPowered;
    {$ifdef devicecan}
    property OnBus : boolean read isOnBus write setOnbus;
    {$endif}
    procedure processpower;
    function getPowertype : DeviceIDType;

    function CANReceive( const msg : array of byte; const dlc : byte; const id, bus : integer ) : boolean;
    procedure Output( const str: String);
  protected
    connected : Boolean;
    connectionprocessed : boolean;
    poweredon : Boolean;
    power : TPowerHandler;
    powertype : DeviceIDtype;
    can_id : Integer;
    {$ifdef devicecan}
    procedure CanChannel1CanRx(Sender: TObject);
    {$endif}
    procedure powerOn; virtual;
    procedure unplug; virtual;

    procedure CyclicHandler; virtual;
    procedure SyncHandler; virtual;
    function CANHandler( const msg : array of byte; const dlc : byte; const id : integer ) : boolean; virtual;

    function CanSend(id: Longint; var msg; dlc, flags: Cardinal): integer;
  private
    CANFail : Boolean;
    Channel : Integer;
 //   CanChannel: TCanChannelEx;
    lastsend : TDateTime;
    cycletime : Int64;
  end;

implementation

uses CanTest, System.SysUtils, System.DateUtils, devicelist, canlib,  Vcl.Dialogs;

procedure TDevice.Output(const str: String);
begin
  MainForm.AddOutput(str);
end;

{$ifdef devicecan}
procedure TDevice.CanChannel1CanRx(Sender: TObject);
var
  dlc, flag, time: cardinal;
  msg, msgout: array[0..7] of byte;
  status : cardinal;
  id: longint;
  formattedDateTime, str : string;
begin
//  Output.Items.BeginUpdate;
  with CanChannel do
  begin
    while Read(id, msg, dlc, flag, time) >= 0 do
    begin
      if MainForm.EmuMaster.checked then // only process if device sim enabled.
        if Powered then // process messages if we have power.
        case id of
          $0 : begin  // received nmt message, respond.
           if ( msg[1] = can_id ) or (msg[1] = 0 )then   // acknowledge NMT if specific to node or all nodes.
             if ( msg[0] = $81 ) or ( msg[0] = $82 ) then // or ( msg[0] = $0 ) then       // reset
             begin
               PowerOn; // rerun power on.
             end;
          end;
         $80 : SyncHandler;
        else
          CANHandler(msg, dlc, id);
        end;
    end;
  end;
end;
{$endif}

function TDevice.CANHandler(const msg: array of byte; const dlc: byte;
  const id: integer): boolean;
begin

end;

function TDevice.CANReceive( const msg: array of byte; const dlc: byte;
  const id, bus: integer): boolean;
var
  msgout : array[0..7] of byte;
begin
  result := false;
  if ( bus = channel ) and Powered then // process messages if we have power.
  case id of
     $0 :  begin  // received nmt message, respond.
       if ( msg[1] = can_id ) or (msg[1] = 0 )then   // acknowledge NMT if specific to node or all nodes.
         if ( msg[0] = $81 ) or ( msg[0] = $82 ) then // or ( msg[0] = $0 ) then       // reset
         begin
           PowerOn; // rerun power on.
         end;
     end;
     $80 : SyncHandler;
  else
    CANHandler(msg, dlc, id);
  end;
end;

function TDevice.CanSend(id: Longint; var msg; dlc, flags: Cardinal): integer;
var exception : Boolean;
begin
  exception := false;
{$ifndef devicecan}
if Channel = 0 then
  result := MainForm.CanSend(id, msg, dlc, flags)
else
  result := MainForm.CanSend2(id, msg, dlc, flags)
{$else}
  with CanChannel do
  beginh
    try
      Check(Write(id, msg, dlc, flags), 'Write failed');
    except
      if not CANFail then
        MainForm.Output.Items.Add('Error Sending to CAN');
       exception := true;
   //   goOnBusClick(nil);
    end;
    if exception then CANFail := true else CANFail := false;
  end;
  result := 0;
{$endif}
end;

constructor TDevice.Create( const powerhandler : TPowerHandler;
                            const powersource : DeviceIDtype;
                            const can_id : Integer;
                            const Channel : Integer;
                            const Cycletime : Integer );
var
  I : Integer;
  val : byte;
  pVal : pbyte;
begin
  lastsend := Now;
  self.Channel := Channel;
  self.cycletime := cycletime;
  power := powerhandler;
  powertype := powersource;
  poweredon := false;
  self.can_id := can_id;
  connectionprocessed := false;
  Devices.registerdevice(self);
{$ifdef devicecan}
  try
    CanChannel := TCanChannelEx.Create(nil);
    val := 0;
    pVal := Addr(val);
    CanChannel.IoCtl(canIOCTL_SET_LOCAL_TXECHO,pVal,1);
  except
     ShowMessage('Error initialisiting, are KVASER drivers installed?');
  end;
{$endif}
 // powerhandler.registerdevice(self);
end;

procedure TDevice.CyclicHandler;
begin

end;

function TDevice.getPowertype: DeviceIDType;
begin
  result := powertype;
end;

function TDevice.isEnabled: boolean;
begin
  result := connected;
end;


function TDevice.isPowered: boolean;
begin
  if connected then
  begin
    if Assigned(power) then
    begin
      result := power.isPowered(powertype);
    end else
    begin
      result := false;
    end;
  end else
    result := false; // can't be powered if not connected.
end;


procedure TDevice.processpower;
var
  powerstate : boolean;
begin
  if connected then
  begin
    if Assigned(power) then
    begin
      powerstate := power.isPowered(powertype);
    end else powerstate := true;

    if not poweredon and powerstate then
    begin
      powerOn;
    end else
    begin
      if poweredon and not powerstate then
        unplug
      else
      begin
        if not connectionprocessed then
        begin
          Output('node connected');
          connectionprocessed := true;
        end;
      end;
    end;

  end;
end;


procedure TDevice.processSync;
begin
  if Powered then SyncHandler;
end;

procedure TDevice.powerOn;
begin
  if connected then
  begin
    poweredon := true;
    Output('Nodepower on');
    connectionprocessed := true;
  end
end;

procedure TDevice.processCyclic;
begin
   if MilliSecondsBetween( Now, lastsend ) > CycleTime-1 then
   if powered then
   begin
     lastsend := Now;
     CyclicHandler;
   end;
end;

procedure TDevice.setEnabled(const Value: boolean);
var
  oldconnected : boolean;
begin
  if connected <> Value then  // only process if actually changed
  begin
    connected := value;

    if connected then
  //    poweredon := false;
      processpower
    else
    begin
      connectionprocessed := false;
      unplug;
    end;
  end;
end;

{$ifdef devicecan}
procedure TDevice.setOnbus(const Value: boolean);
begin
  if Value then
  begin
    if not CanChannel.Active then begin
      CanChannel.Bitrate := canBITRATE_1M;
      CanChannel.Channel := Channel;
      //  TCanChanOption = (ccNotExclusive, ccNoVirtual, ccAcceptLargeDLC);
      //  TCanChanOptions = set of TCanChanOption;
      CanChannel.Options := [ccNotExclusive];
      CanChannel.Open;
    //  SetHardwareFilters($20, canFILTER_SET_CODE_STD);
    //  SetHardwareFilters($FE, canFILTER_SET_MASK_STD);
      CanChannel.OnCanRx := CanChannel1CanRx;
      CanChannel.BusActive := true;
    end;
  end else
  begin
    CanChannel.BusActive := false;
  end;
end;
{$endif}

procedure TDevice.SyncHandler;
begin

end;

procedure TDevice.unplug;
begin
  if poweredon then
  begin
      Output('Nodepower off');
      poweredon := false;
  end else
    Output('node disconnected');
end;

end.
