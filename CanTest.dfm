object MainForm: TMainForm
  Left = 257
  Top = 113
  BorderStyle = bsSingle
  Caption = 'Formula ECUCANTest'
  ClientHeight = 734
  ClientWidth = 1021
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    1021
    734)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 1005
    Height = 728
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object Label3: TLabel
      Left = 232
      Top = 26
      Width = 26
      Height = 13
      Caption = 'Time:'
    end
    object TimeReceived: TLabel
      Left = 288
      Top = 26
      Width = 6
      Height = 13
      Caption = '0'
    end
    object OnBus: TLabel
      Left = 8
      Top = 48
      Width = 36
      Height = 13
      Caption = 'Off Bus'
    end
    object Label1: TLabel
      Left = 232
      Top = 45
      Width = 33
      Height = 13
      Caption = 'State :'
    end
    object Label2: TLabel
      Left = 232
      Top = 64
      Width = 56
      Height = 13
      Caption = 'State Info :'
    end
    object State: TLabel
      Left = 299
      Top = 45
      Width = 26
      Height = 13
      Caption = 'State'
    end
    object StateInfo: TLabel
      Left = 299
      Top = 64
      Width = 37
      Height = 13
      Caption = 'Label27'
    end
    object CanDevices: TComboBox
      Left = 3
      Top = 20
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = CanDevicesChange
    end
    object Output: TListBox
      Left = 3
      Top = 129
      Width = 585
      Height = 343
      ItemHeight = 13
      TabOrder = 1
    end
    object SendCANADC: TButton
      Left = 3
      Top = 98
      Width = 75
      Height = 25
      Caption = 'Send ADC'
      Enabled = False
      TabOrder = 2
      OnClick = SendCANADCClick
    end
    object goOnBus: TButton
      Left = 3
      Top = 67
      Width = 75
      Height = 25
      Caption = 'Go on bus'
      TabOrder = 3
      OnClick = goOnBusClick
    end
    object TS: TButton
      Left = 126
      Top = 478
      Width = 75
      Height = 25
      Caption = 'TS'
      TabOrder = 4
      OnClick = TSClick
    end
    object RTDM: TButton
      Left = 207
      Top = 478
      Width = 75
      Height = 25
      Caption = 'RTDM'
      TabOrder = 5
      OnClick = RTDMClick
    end
    object Start: TButton
      Left = 45
      Top = 478
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 6
      OnClick = StartClick
    end
    object SendADC: TCheckBox
      Left = 84
      Top = 98
      Width = 97
      Height = 17
      Caption = 'SendADC'
      TabOrder = 7
      OnClick = SendADCClick
    end
    object Crash: TButton
      Left = 288
      Top = 478
      Width = 75
      Height = 25
      Caption = 'Crash'
      TabOrder = 8
      OnClick = CrashClick
    end
    object Clear: TButton
      Left = 311
      Top = 98
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 9
      OnClick = ClearClick
    end
    object SendNMTWakeups: TButton
      Left = 369
      Top = 478
      Width = 99
      Height = 25
      Caption = 'NMT Wakeup'
      TabOrder = 10
    end
    object Log: TCheckBox
      Left = 208
      Top = 98
      Width = 97
      Height = 17
      Caption = 'Log to file'
      TabOrder = 11
    end
    object GroupBox3: TGroupBox
      Left = 616
      Top = 105
      Width = 74
      Height = 189
      Caption = 'LED State'
      TabOrder = 12
      object RTDMLED: TCheckBox
        Left = 18
        Top = 71
        Width = 97
        Height = 17
        Caption = 'RTDM'
        TabOrder = 0
      end
      object TSOffLED: TCheckBox
        Left = 18
        Top = 48
        Width = 97
        Height = 17
        Caption = 'TSOFF'
        TabOrder = 1
      end
      object TSLED: TCheckBox
        Left = 18
        Top = 25
        Width = 97
        Height = 17
        Caption = 'TS'
        TabOrder = 2
      end
      object IMDLED: TCheckBox
        Left = 16
        Top = 111
        Width = 97
        Height = 17
        Caption = 'IMD'
        TabOrder = 3
      end
      object BMSLED: TCheckBox
        Left = 16
        Top = 134
        Width = 97
        Height = 17
        Caption = 'BMS'
        TabOrder = 4
      end
      object BSPDLED: TCheckBox
        Left = 16
        Top = 157
        Width = 97
        Height = 17
        Caption = 'BSPD'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 5
      end
    end
    object GetADC: TButton
      Left = 474
      Top = 478
      Width = 75
      Height = 25
      Caption = 'GetADC'
      TabOrder = 13
      OnClick = GetADCClick
    end
    object GetADCMinMax: TButton
      Left = 559
      Top = 478
      Width = 75
      Height = 25
      Caption = 'GetADC M/M'
      TabOrder = 14
      OnClick = GetADCMinMaxClick
    end
    object GroupBox4: TGroupBox
      Left = 761
      Top = 81
      Width = 233
      Height = 422
      Caption = 'State'
      TabOrder = 15
      object Label7: TLabel
        Left = 16
        Top = 24
        Width = 30
        Height = 13
        Caption = 'AccelL'
      end
      object Label8: TLabel
        Left = 16
        Top = 43
        Width = 32
        Height = 13
        Caption = 'AccelR'
      end
      object Label10: TLabel
        Left = 16
        Top = 62
        Width = 33
        Height = 13
        Caption = 'BrakeF'
      end
      object Label11: TLabel
        Left = 16
        Top = 81
        Width = 34
        Height = 13
        Caption = 'BrakeR'
      end
      object Label12: TLabel
        Left = 16
        Top = 100
        Width = 40
        Height = 13
        Caption = 'Steering'
      end
      object Label13: TLabel
        Left = 16
        Top = 119
        Width = 38
        Height = 13
        Caption = 'Max Nm'
      end
      object Label14: TLabel
        Left = 14
        Top = 157
        Width = 31
        Height = 13
        Caption = 'TempL'
      end
      object Label15: TLabel
        Left = 14
        Top = 176
        Width = 33
        Height = 13
        Caption = 'TempR'
      end
      object AccelLR: TLabel
        Left = 88
        Top = 24
        Width = 4
        Height = 13
        Caption = '-'
      end
      object AccelRR: TLabel
        Left = 88
        Top = 43
        Width = 4
        Height = 13
        Caption = '-'
      end
      object BrakeFR: TLabel
        Left = 88
        Top = 62
        Width = 4
        Height = 13
        Caption = '-'
      end
      object BrakeRR: TLabel
        Left = 88
        Top = 81
        Width = 4
        Height = 13
        Caption = '-'
      end
      object SteeringR: TLabel
        Left = 88
        Top = 100
        Width = 4
        Height = 13
        Caption = '-'
      end
      object MaxNmR: TLabel
        Left = 88
        Top = 119
        Width = 4
        Height = 13
        Caption = '-'
      end
      object TempLR: TLabel
        Left = 86
        Top = 157
        Width = 4
        Height = 13
        Caption = '-'
      end
      object TempRR: TLabel
        Left = 86
        Top = 176
        Width = 4
        Height = 13
        Caption = '-'
      end
      object Label37: TLabel
        Left = 14
        Top = 195
        Width = 55
        Height = 13
        Caption = 'Torque RqL'
      end
      object Label16: TLabel
        Left = 14
        Top = 214
        Width = 57
        Height = 13
        Caption = 'Torque RqR'
      end
      object TorqueRqLR: TLabel
        Left = 84
        Top = 195
        Width = 4
        Height = 13
        Caption = '-'
      end
      object TorqueRqRR: TLabel
        Left = 86
        Top = 214
        Width = 4
        Height = 13
        Caption = '-'
      end
      object Label17: TLabel
        Left = 15
        Top = 233
        Width = 45
        Height = 13
        Caption = 'Speed RL'
      end
      object Label18: TLabel
        Left = 15
        Top = 252
        Width = 47
        Height = 13
        Caption = 'Speed RR'
      end
      object SpeedRLR: TLabel
        Left = 86
        Top = 233
        Width = 4
        Height = 13
        Caption = '-'
      end
      object SpeedRRR: TLabel
        Left = 86
        Top = 252
        Width = 4
        Height = 13
        Caption = '-'
      end
      object Label21: TLabel
        Left = 15
        Top = 271
        Width = 44
        Height = 13
        Caption = 'Brake Bal'
      end
      object BrakeBalR: TLabel
        Left = 86
        Top = 271
        Width = 4
        Height = 13
        Caption = '-'
      end
      object Label5: TLabel
        Left = 15
        Top = 290
        Width = 37
        Height = 13
        Caption = 'Current'
      end
      object Label22: TLabel
        Left = 15
        Top = 309
        Width = 30
        Height = 13
        Caption = 'Power'
      end
      object Label23: TLabel
        Left = 15
        Top = 328
        Width = 22
        Height = 13
        Caption = 'InvV'
      end
      object Label24: TLabel
        Left = 15
        Top = 347
        Width = 26
        Height = 13
        Caption = 'BMSV'
      end
      object CurrentR: TLabel
        Left = 86
        Top = 290
        Width = 4
        Height = 13
        Caption = '-'
      end
      object PowerR: TLabel
        Left = 86
        Top = 309
        Width = 4
        Height = 13
        Caption = '-'
      end
      object InvVR: TLabel
        Left = 86
        Top = 328
        Width = 4
        Height = 13
        Caption = '-'
      end
      object BMSVR: TLabel
        Left = 86
        Top = 347
        Width = 4
        Height = 13
        Caption = '-'
      end
      object AccelRRRaw: TLabel
        Left = 160
        Top = 43
        Width = 4
        Height = 13
        Caption = '-'
      end
      object AccelLRRaw: TLabel
        Left = 160
        Top = 24
        Width = 4
        Height = 13
        Caption = '-'
      end
      object BrakeFRRaw: TLabel
        Left = 160
        Top = 62
        Width = 4
        Height = 13
        Caption = '-'
      end
      object BrakeRRRaw: TLabel
        Left = 160
        Top = 81
        Width = 4
        Height = 13
        Caption = '-'
      end
      object SteeringRRaw: TLabel
        Left = 160
        Top = 100
        Width = 4
        Height = 13
        Caption = '-'
      end
      object DrivemodeRRaw: TLabel
        Left = 160
        Top = 138
        Width = 4
        Height = 13
        Caption = '-'
      end
      object TempLRRaw: TLabel
        Left = 158
        Top = 157
        Width = 4
        Height = 13
        Caption = '-'
      end
      object TempRRRaw: TLabel
        Left = 158
        Top = 176
        Width = 4
        Height = 13
        Caption = '-'
      end
      object Label25: TLabel
        Left = 14
        Top = 138
        Width = 51
        Height = 13
        Caption = 'Drivemode'
      end
      object DrivemodeR: TLabel
        Left = 88
        Top = 138
        Width = 4
        Height = 13
        Caption = '-'
      end
      object canerrorcount: TLabel
        Left = 86
        Top = 366
        Width = 4
        Height = 13
        Caption = '-'
      end
      object Label26: TLabel
        Left = 15
        Top = 366
        Width = 50
        Height = 13
        Caption = 'CANErrors'
      end
      object SpeedFLR: TLabel
        Left = 158
        Top = 232
        Width = 4
        Height = 13
        Caption = '-'
      end
      object SpeedFRR: TLabel
        Left = 158
        Top = 251
        Width = 4
        Height = 13
        Caption = '-'
      end
      object Label4: TLabel
        Left = 15
        Top = 385
        Width = 48
        Height = 13
        Caption = 'Shutdown'
      end
      object ShutdownR: TLabel
        Left = 86
        Top = 385
        Width = 4
        Height = 13
        Caption = '-'
      end
    end
    object GroupBox6: TGroupBox
      Left = 620
      Top = 300
      Width = 66
      Height = 72
      Caption = 'PDM Req'
      TabOrder = 16
      object HV: TCheckBox
        Left = 16
        Top = 16
        Width = 97
        Height = 17
        Caption = 'HV'
        TabOrder = 0
      end
      object Buzz: TCheckBox
        Left = 16
        Top = 39
        Width = 97
        Height = 17
        Caption = 'Buzz'
        TabOrder = 1
      end
    end
    object EmuMaster: TCheckBox
      Left = 84
      Top = 69
      Width = 105
      Height = 17
      Caption = 'Simulate Devices'
      Checked = True
      State = cbChecked
      TabOrder = 17
      OnClick = EmuMasterClick
    end
    object HVForce: TButton
      Left = 640
      Top = 478
      Width = 75
      Height = 25
      Caption = 'HV Toggle'
      TabOrder = 18
      OnClick = HVForceClick
    end
    object CenterButton: TButton
      Left = 636
      Top = 411
      Width = 27
      Height = 25
      TabOrder = 19
      OnClick = CenterButtonClick
    end
    object LeftButton: TButton
      Left = 613
      Top = 411
      Width = 27
      Height = 25
      Caption = #8592
      TabOrder = 20
      OnClick = CenterButtonClick
    end
    object RightButton: TButton
      Left = 661
      Top = 411
      Width = 27
      Height = 25
      Caption = #8594
      TabOrder = 21
      OnClick = CenterButtonClick
    end
    object UpButton: TButton
      Left = 636
      Top = 391
      Width = 27
      Height = 25
      Caption = #8593
      TabOrder = 22
      OnClick = CenterButtonClick
    end
    object DownButton: TButton
      Left = 636
      Top = 434
      Width = 27
      Height = 25
      Caption = #8595
      TabOrder = 23
      OnClick = CenterButtonClick
    end
    object DeviceControls: TPageControl
      Left = 14
      Top = 509
      Width = 788
      Height = 204
      TabOrder = 24
    end
    object UseCAN2: TCheckBox
      Left = 84
      Top = 47
      Width = 97
      Height = 17
      Caption = 'UseCAN2'
      TabOrder = 25
    end
  end
  object timer10ms: TTimer
    Interval = 10
    OnTimer = timer10msTimer
    Left = 176
    Top = 32
  end
end
