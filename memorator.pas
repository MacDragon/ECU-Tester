unit memorator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.CheckLst, device, global, Vcl.StdCtrls, PowerHandler;

type
  TMemoratorForm = class(TForm)
    Connected: TCheckBox;
    procedure ConnectedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TMemoratorHandler = class(TDevice)
  public
    constructor Create( const powerhandler : TPowerHandler; const powersource : DeviceIDtype; const can_id : Integer; const Channel : Integer );
  protected
    procedure CyclicHandler; override;
  end;

var
  MemoratorDevice : TMemoratorHandler;
  MemoratorForm: TMemoratorForm;

implementation

uses System.DateUtils, CanTest, powernode;

{$R *.dfm}

constructor TMemoratorHandler.Create(const powerhandler: TPowerHandler;
  const powersource: DeviceIDtype; const can_id: Integer; const Channel : Integer);
begin
  inherited Create(powerhandler, powersource, can_id, Channel, 1000);
end;

procedure TMemoratorHandler.CyclicHandler;
var
  msg: array[0..7] of byte;
  CurTime : TDateTime;
  Year, Month, Day, Hour, Min, Sec, Msec : Word;
begin
    CurTime := Now;

    DecodeTime(CurTime, Hour, Min, Sec, Msec );
    DecodeDate(CurTime, Year, Month, Day);
    //, myMilli);
    msg[0] := Year-2000;  // insert an IVT value here.
    msg[1] := Month;
    msg[2] := Day;
    msg[3] := Hour;
    msg[4] := Min;
    msg[5] := Sec;

    CanSend($7B,msg,6,0);  // IVT
end;

procedure TMemoratorForm.ConnectedClick(Sender: TObject);
begin
  memoratordevice.Enabled := Connected.Checked;
end;

procedure TMemoratorForm.FormCreate(Sender: TObject);
begin
  MemoratorDevice := TMemoratorHandler.Create(Power, DeviceIDType.Front1, $7B, 0);
end;

end.
