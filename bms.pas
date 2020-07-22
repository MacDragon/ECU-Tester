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
    procedure ConnectedClick(Sender: TObject);
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

uses CanTest, powernode;

procedure TBMSHandler.SyncHandler;
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

end.
