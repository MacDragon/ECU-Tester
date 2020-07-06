object MainForm: TMainForm
  Left = 257
  Top = 113
  BorderStyle = bsSingle
  Caption = 'Formula ECUCANTest'
  ClientHeight = 695
  ClientWidth = 1254
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
    1254
    695)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 1238
    Height = 679
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object Label3: TLabel
      Left = 624
      Top = 50
      Width = 26
      Height = 13
      Caption = 'Time:'
    end
    object TimeReceived: TLabel
      Left = 680
      Top = 50
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
      Left = 624
      Top = 69
      Width = 33
      Height = 13
      Caption = 'State :'
    end
    object Label2: TLabel
      Left = 624
      Top = 88
      Width = 56
      Height = 13
      Caption = 'State Info :'
    end
    object State: TLabel
      Left = 691
      Top = 69
      Width = 26
      Height = 13
      Caption = 'State'
    end
    object StateInfo: TLabel
      Left = 691
      Top = 88
      Width = 37
      Height = 13
      Caption = 'Label27'
    end
    object Label27: TLabel
      Left = 280
      Top = 640
      Width = 46
      Height = 13
      Caption = 'Powered:'
    end
    object PoweredDevs: TLabel
      Left = 332
      Top = 640
      Width = 66
      Height = 13
      Caption = 'PoweredDevs'
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
      Left = 223
      Top = 20
      Width = 378
      Height = 452
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
      Left = 607
      Top = 19
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
      Left = 736
      Top = 27
      Width = 97
      Height = 17
      Caption = 'Log to file'
      TabOrder = 11
    end
    object PDMGroup: TGroupBox
      Left = 281
      Top = 509
      Width = 82
      Height = 120
      Caption = 'PDM Flags'
      TabOrder = 12
      object IMD: TCheckBox
        Left = 16
        Top = 47
        Width = 97
        Height = 17
        Caption = 'IMD'
        TabOrder = 0
        OnClick = IMDClick
      end
      object BSPD: TCheckBox
        Left = 16
        Top = 71
        Width = 97
        Height = 17
        Caption = 'BSPD'
        TabOrder = 1
        OnClick = BSPDClick
      end
      object BMS: TCheckBox
        Left = 16
        Top = 24
        Width = 97
        Height = 17
        Caption = 'BMS'
        TabOrder = 2
        OnClick = BMSClick
      end
      object ShutD: TCheckBox
        Left = 16
        Top = 94
        Width = 97
        Height = 17
        Caption = 'ShutD'
        TabOrder = 3
        OnClick = BSPDClick
      end
    end
    object ComboBox1: TComboBox
      Left = 369
      Top = 511
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 13
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6')
    end
    object GroupBox3: TGroupBox
      Left = 616
      Top = 107
      Width = 74
      Height = 187
      Caption = 'LEDs'
      TabOrder = 14
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
      TabOrder = 15
      OnClick = GetADCClick
    end
    object GetADCMinMax: TButton
      Left = 559
      Top = 478
      Width = 75
      Height = 25
      Caption = 'GetADC M/M'
      TabOrder = 16
      OnClick = GetADCMinMaxClick
    end
    object GroupBox4: TGroupBox
      Left = 1002
      Top = 107
      Width = 233
      Height = 461
      Caption = 'State'
      TabOrder = 17
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
      object Label19: TLabel
        Left = 16
        Top = 385
        Width = 45
        Height = 13
        Caption = 'InverterL'
      end
      object Label20: TLabel
        Left = 16
        Top = 404
        Width = 47
        Height = 13
        Caption = 'InverterR'
      end
      object InverterLStat: TLabel
        Left = 88
        Top = 385
        Width = 4
        Height = 13
        Caption = '-'
      end
      object InverterRStat: TLabel
        Left = 86
        Top = 404
        Width = 4
        Height = 13
        Caption = '-'
      end
      object InverterLInternal: TLabel
        Left = 158
        Top = 385
        Width = 4
        Height = 13
        Caption = '-'
      end
      object Label30: TLabel
        Left = 158
        Top = 404
        Width = 4
        Height = 13
        Caption = '-'
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
    end
    object CanDeviceGroup: TGroupBox
      Left = 16
      Top = 509
      Width = 249
      Height = 142
      Caption = 'Can Device '#39'Emulation'#39
      TabOrder = 18
      object Inverters: TCheckBox
        Left = 13
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Inverter Present'
        TabOrder = 0
      end
      object PDM: TCheckBox
        Left = 13
        Top = 47
        Width = 97
        Height = 17
        Caption = 'PDM Present'
        TabOrder = 1
        OnClick = PDMClick
      end
      object FLSpeed: TCheckBox
        Left = 132
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Front Left Speed'
        TabOrder = 2
        OnClick = FLSpeedClick
      end
      object FRSpeed: TCheckBox
        Left = 132
        Top = 47
        Width = 114
        Height = 17
        Caption = 'Front Right Speed'
        TabOrder = 3
        OnClick = FRSpeedClick
      end
      object CANBMS: TCheckBox
        Left = 13
        Top = 70
        Width = 97
        Height = 17
        Caption = 'BMS Present'
        TabOrder = 4
        OnClick = CANBMSClick
      end
      object Pedals: TCheckBox
        Left = 132
        Top = 93
        Width = 97
        Height = 17
        Caption = 'Pedals'
        TabOrder = 5
        OnClick = PedalsClick
      end
      object IMU: TCheckBox
        Left = 132
        Top = 70
        Width = 97
        Height = 17
        Caption = 'IMU'
        TabOrder = 6
        OnClick = IMUClick
      end
      object IVT: TCheckBox
        Left = 13
        Top = 93
        Width = 97
        Height = 17
        Caption = 'IVT'
        TabOrder = 7
        OnClick = IVTClick
      end
      object Memorator: TCheckBox
        Left = 13
        Top = 116
        Width = 97
        Height = 17
        Caption = 'Memorator'
        TabOrder = 8
        OnClick = MemoratorClick
      end
    end
    object GroupBox6: TGroupBox
      Left = 620
      Top = 300
      Width = 66
      Height = 72
      Caption = 'PDM'
      TabOrder = 19
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
      TabOrder = 20
      OnClick = EmuMasterClick
    end
    object HVon: TCheckBox
      Left = 377
      Top = 546
      Width = 97
      Height = 17
      Caption = 'HV On'
      TabOrder = 21
    end
    object HVForce: TButton
      Left = 640
      Top = 478
      Width = 75
      Height = 25
      Caption = 'HV Toggle'
      TabOrder = 22
      OnClick = HVForceClick
    end
    object IVTCAN1: TCheckBox
      Left = 377
      Top = 569
      Width = 97
      Height = 17
      Caption = 'IVT CAN1'
      TabOrder = 23
    end
    object ADCGroup: TGroupBox
      Left = 3
      Top = 143
      Width = 200
      Height = 324
      Caption = 'ADCGroup'
      TabOrder = 24
      object Label6: TLabel
        Left = 24
        Top = 236
        Width = 33
        Height = 13
        Caption = 'TempR'
      end
      object Label4: TLabel
        Left = 26
        Top = 263
        Width = 31
        Height = 13
        Caption = 'TempL'
      end
      object LabelAccelL: TLabel
        Left = 15
        Top = 25
        Width = 30
        Height = 13
        Caption = 'AccelL'
      end
      object LabelAccelR: TLabel
        Left = 15
        Top = 52
        Width = 32
        Height = 13
        Caption = 'AccelR'
      end
      object LabelBrakeF: TLabel
        Left = 15
        Top = 102
        Width = 33
        Height = 13
        Caption = 'BrakeF'
      end
      object LabelBrakeR: TLabel
        Left = 15
        Top = 129
        Width = 34
        Height = 13
        Caption = 'BrakeR'
      end
      object LabelSteering: TLabel
        Left = 15
        Top = 179
        Width = 40
        Height = 13
        Caption = 'Steering'
      end
      object Label9: TLabel
        Left = 21
        Top = 293
        Width = 38
        Height = 13
        Caption = 'Max Nm'
      end
      object Coolant2: TEdit
        Left = 63
        Top = 233
        Width = 121
        Height = 21
        NumbersOnly = True
        TabOrder = 0
        Text = '20'
      end
      object Coolant1: TEdit
        Left = 63
        Top = 260
        Width = 121
        Height = 21
        NumbersOnly = True
        TabOrder = 1
        Text = '20'
      end
      object DriveMode: TComboBox
        Left = 65
        Top = 287
        Width = 121
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = '5'
        Items.Strings = (
          '5'
          '10'
          '15'
          '20'
          '25'
          '30'
          '45'
          '65')
      end
      object Steering: TMaskEdit
        Left = 61
        Top = 176
        Width = 121
        Height = 21
        TabOrder = 3
        Text = '0'
        OnChange = SteeringChange
      end
      object ScrollSteering: TScrollBar
        Left = 63
        Top = 203
        Width = 121
        Height = 17
        Min = -100
        PageSize = 0
        TabOrder = 4
        OnChange = ScrollSteeringChange
      end
      object BrakePedal: TScrollBar
        Left = 63
        Top = 153
        Width = 121
        Height = 17
        PageSize = 0
        TabOrder = 5
        OnChange = BrakePedalChange
      end
      object BrakeR: TEdit
        Left = 63
        Top = 126
        Width = 121
        Height = 21
        NumbersOnly = True
        TabOrder = 6
        Text = '0'
      end
      object BrakeF: TEdit
        Left = 63
        Top = 99
        Width = 121
        Height = 21
        NumbersOnly = True
        TabOrder = 7
        Text = '0'
      end
      object AccelPedal: TScrollBar
        Left = 63
        Top = 76
        Width = 121
        Height = 17
        PageSize = 0
        TabOrder = 8
        OnChange = AccelPedalChange
      end
      object AccelR: TEdit
        Left = 63
        Top = 49
        Width = 121
        Height = 21
        NumbersOnly = True
        TabOrder = 9
        Text = '0'
      end
      object AccelL: TEdit
        Left = 63
        Top = 22
        Width = 121
        Height = 21
        NumbersOnly = True
        TabOrder = 10
        Text = '0'
      end
    end
    object CenterButton: TButton
      Left = 582
      Top = 529
      Width = 27
      Height = 25
      TabOrder = 25
      OnClick = CenterButtonClick
    end
    object LeftButton: TButton
      Left = 559
      Top = 529
      Width = 27
      Height = 25
      Caption = #8592
      TabOrder = 26
      OnClick = CenterButtonClick
    end
    object RightButton: TButton
      Left = 607
      Top = 529
      Width = 27
      Height = 25
      Caption = #8594
      TabOrder = 27
      OnClick = CenterButtonClick
    end
    object UpButton: TButton
      Left = 582
      Top = 509
      Width = 27
      Height = 25
      Caption = #8593
      TabOrder = 28
      OnClick = CenterButtonClick
    end
    object DownButton: TButton
      Left = 582
      Top = 552
      Width = 27
      Height = 25
      Caption = #8595
      TabOrder = 29
      OnClick = CenterButtonClick
    end
    object PowerNodesList: TCheckListBox
      Left = 704
      Top = 121
      Width = 105
      Height = 80
      ItemHeight = 13
      ParentColor = True
      TabOrder = 30
      OnClick = PowerNodesListClick
    end
    object AnalogNodesList: TCheckListBox
      Left = 704
      Top = 201
      Width = 105
      Height = 151
      ItemHeight = 13
      ParentColor = True
      TabOrder = 31
    end
    object ScrollRegen: TScrollBar
      Left = 831
      Top = 517
      Width = 121
      Height = 17
      PageSize = 0
      TabOrder = 32
      OnChange = ScrollRegenChange
    end
    object Regen: TEdit
      Left = 831
      Top = 490
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 33
      Text = '0'
    end
    object PowerNodeError: TButton
      Left = 704
      Top = 358
      Width = 105
      Height = 25
      Caption = 'PowerNodeError'
      TabOrder = 34
      OnClick = PowerNodeErrorClick
    end
    object LVPower: TCheckBox
      Left = 712
      Top = 400
      Width = 97
      Height = 17
      Caption = 'LV Power'
      Checked = True
      State = cbChecked
      TabOrder = 35
      OnClick = LVPowerClick
    end
  end
  object timer200ms: TTimer
    Interval = 200
    OnTimer = timer200msTimer
    Left = 176
    Top = 88
  end
  object timer10ms: TTimer
    Interval = 10
    OnTimer = timer10msTimer
    Left = 176
    Top = 128
  end
  object timer100ms: TTimer
    Interval = 100
    OnTimer = timer100msTimer
    Left = 176
    Top = 40
  end
  object timer1000ms: TTimer
    OnTimer = timer1000msTimer
    Left = 176
    Top = 8
  end
end
