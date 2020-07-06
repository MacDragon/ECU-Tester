unit global;

interface

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
  LV,
  None
);

 DeviceIDtypes = set of DeviceIDtype;

const
  NodeAck_ID = 601;

implementation

end.
