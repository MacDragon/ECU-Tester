unit ivt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.CheckLst, device, global, Vcl.StdCtrls;

type
  TIVTForm = class(TForm)
    Connected: TCheckBox;
    procedure ConnectedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TIVTHandler = class(TDevice)
  public
    procedure SyncHandler; override;
  private
    procedure sendIVT(msg0, msg1, msg2, msg3 : byte);
  protected
    procedure unplug; override;
  end;

var
  IVTDevice : TIVTHandler;
  IVTForm: TIVTForm;

implementation

uses CanTest, powernode, powerhandler;

{$R *.dfm}

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
    CanSend($411, msg, 8, 0);
    Sleep(100);
end;

procedure TIVTHandler.unplug;
begin
  if poweredon then
  begin
      MainForm.Output.Items.Add('IVT Power off');
  end else
    MainForm.Output.Items.Add('IVT disconnected');

  inherited;

end;

procedure TIVTHandler.SyncHandler;
var
  msg: array[0..7] of byte;
  i : integer;
begin
  msg[0] := 0;  // insert an IVT value here.
  msg[1] := 0;
  msg[2] := 0;
  msg[3] := 0;
  msg[4] := 90;
  msg[5] := 10;

  CanSend($521,msg,6,0);  // IVT
  msg[0] := 1;  // insert an IVT value here.

  if Power.isPowered( DeviceIDtype.HV )  then
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

  { 100ms timer from mainform
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
      CanSend($521, msg, 6, 0);
    end;
        msg[0] := 1;
        msg[4] := $50;
        msg[5] := $3C;

    with CanChannel1 do begin
      if Active then
      CanSend($522, msg, 6 , 0);
    end;
        msg[0] := 2;
    with CanChannel1 do begin
      if Active then
      CanSend($523, msg, 6 , 0);
    end;
    }

end;


procedure TIVTForm.ConnectedClick(Sender: TObject);
begin
  ivtdevice.Enabled := Connected.Checked;
end;

end.
