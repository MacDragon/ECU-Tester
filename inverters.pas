unit inverters;

interface

type
  TDevice = class(TObject)
  private
    FPowered : Boolean;
    procedure ReceiveCAN(var msg : array of byte );
  private
    property Powered : Boolean read FPowered write Fpowered;
  end;

  TMyClass = class
private
  FFu : integer;
public
  property Fu :integer read FFu write FFu;
end;

implementation


{ TDevice }

procedure TDevice.ReceiveCAN(var msg: array of byte);
begin

end;


end.
