object AnalogNodesForm: TAnalogNodesForm
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsSingle
  Caption = 'AnalogNodes'
  ClientHeight = 559
  ClientWidth = 946
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object AnalogNodesList: TCheckListBox
    Left = 8
    Top = 8
    Width = 105
    Height = 151
    ItemHeight = 13
    ParentColor = True
    TabOrder = 0
    OnClick = AnalogNodesListClick
  end
  object ADCGroup: TGroupBox
    Left = 119
    Top = 8
    Width = 602
    Height = 151
    Caption = 'Analogue Inputs'
    TabOrder = 1
    object Label6: TLabel
      Left = 416
      Top = 25
      Width = 33
      Height = 13
      Caption = 'TempR'
    end
    object Label4: TLabel
      Left = 418
      Top = 52
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
      Left = 199
      Top = 25
      Width = 33
      Height = 13
      Caption = 'BrakeF'
    end
    object LabelBrakeR: TLabel
      Left = 199
      Top = 52
      Width = 34
      Height = 13
      Caption = 'BrakeR'
    end
    object LabelSteering: TLabel
      Left = 17
      Top = 102
      Width = 40
      Height = 13
      Caption = 'Steering'
    end
    object Label9: TLabel
      Left = 411
      Top = 79
      Width = 38
      Height = 13
      Caption = 'Max Nm'
    end
    object Label1: TLabel
      Left = 201
      Top = 102
      Width = 31
      Height = 13
      Caption = 'Regen'
    end
    object Coolant2: TEdit
      Left = 463
      Top = 22
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      Text = '20'
    end
    object Coolant1: TEdit
      Left = 463
      Top = 49
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 1
      Text = '20'
    end
    object DriveMode: TComboBox
      Left = 465
      Top = 76
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
      Left = 63
      Top = 99
      Width = 121
      Height = 21
      TabOrder = 3
      Text = '0'
      OnChange = SteeringChange
    end
    object ScrollSteering: TScrollBar
      Left = 65
      Top = 126
      Width = 121
      Height = 17
      Min = -100
      PageSize = 0
      TabOrder = 4
      OnChange = ScrollSteeringChange
    end
    object BrakePedal: TScrollBar
      Left = 247
      Top = 76
      Width = 121
      Height = 17
      PageSize = 0
      TabOrder = 5
      OnChange = BrakePedalChange
    end
    object BrakeR: TEdit
      Left = 247
      Top = 49
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 6
      Text = '0'
    end
    object BrakeF: TEdit
      Left = 247
      Top = 22
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
    object Regen: TEdit
      Left = 247
      Top = 99
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 11
      Text = '0'
    end
    object ScrollRegen: TScrollBar
      Left = 247
      Top = 126
      Width = 121
      Height = 17
      PageSize = 0
      TabOrder = 12
    end
  end
end
