unit bms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.CheckLst, device, global,
  Vcl.StdCtrls;

type
  TBMSForm = class(TForm)
    LimpMode: TCheckBox;
    BMSVolt: TEdit;
    Label1: TLabel;
    Connected: TCheckBox;
    BMSError: TCheckBox;
    BMSErrorCode: TComboBox;
    procedure ConnectedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TBMSHandler = class(TDevice)
  public
    procedure SyncHandler; override;
  end;

var
  BMSForm: TBMSForm;
  BMSDevice : TBMSHandler;

implementation

{$R *.dfm}

uses CanTest, powernode, PowerHandler;

procedure TBMSHandler.SyncHandler;
var
  msg: array[0..7] of byte;
begin
  msg[0] := byte(BMSForm.BMSError.Checked);//+badvalue;
  if msg[0] <> 0 then
  begin
    msg[1] := BMSForm.BMSErrorCode.ItemIndex;
  end;
  // if badvalue > 0 then badvalue := badvalue-1;
  msg[2] := 0;
  msg[3] := 0;
  msg[4] := 0;
  msg[5] := 0;
  msg[6] := 0;   // constant to verify message.
  msg[7] := 0;
  // 		uint16_t voltage = CanState.BMSVolt.data[2]*256+CanState.BMSVolt.data[3];
  //	if ( CanState.BMSVolt.dlcsize == 8 &&  voltage > 480 && voltage < 600 ) // check data sanity

  CanSend($9,msg,8,0);



  msg[0] := 0;//+badvalue;
  // if badvalue > 0 then badvalue := badvalue-1;
  msg[1] := 0;
  msg[2] := 2;
  msg[3] := 48;
  msg[4] := 0;
  msg[5] := 0;
  msg[6] := $AB;   // constant to verify message.
  msg[7] := $CD;
  // 		uint16_t voltage = CanState.BMSVolt.data[2]*256+CanState.BMSVolt.data[3];
  //	if ( CanState.BMSVolt.dlcsize == 8 &&  voltage > 480 && voltage < 600 ) // check data sanity

  CanSend($B,msg,8,0);
end;


procedure TBMSForm.ConnectedClick(Sender: TObject);
begin
  bmsdevice.Enabled := Connected.Checked;
end;

procedure TBMSForm.FormCreate(Sender: TObject);
begin
  // BMS is always powered if LV on, as it is supplying the power.
  BMSDevice := TBMSHandler.Create(Power,DeviceIDtype.LV, $8, 0);
  BMSErrorCode.ItemIndex := 0;
end;

end.
