object PowerNodesForm: TPowerNodesForm
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsSingle
  Caption = 'PowerNodes'
  ClientHeight = 146
  ClientWidth = 561
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
  object Label27: TLabel
    Left = 8
    Top = 110
    Width = 46
    Height = 13
    Caption = 'Powered:'
  end
  object PoweredDevs: TLabel
    Left = 60
    Top = 110
    Width = 66
    Height = 13
    Caption = 'PoweredDevs'
  end
  object PowerNodesList: TCheckListBox
    Left = 8
    Top = 8
    Width = 105
    Height = 80
    ItemHeight = 13
    ParentColor = True
    TabOrder = 0
    OnClick = PowerNodesListClick
  end
  object LVPower: TCheckBox
    Left = 125
    Top = 8
    Width = 97
    Height = 17
    Caption = 'LV Power'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = LVPowerClick
  end
  object HVon: TCheckBox
    Left = 125
    Top = 31
    Width = 97
    Height = 17
    Caption = 'HV On'
    TabOrder = 2
    OnClick = HVonClick
  end
  object PowerNodeError: TButton
    Left = 119
    Top = 54
    Width = 105
    Height = 25
    Caption = 'PowerNodeError'
    TabOrder = 3
    OnClick = PowerNodeErrorClick
  end
  object PDMGroup: TGroupBox
    Left = 230
    Top = 8
    Width = 82
    Height = 99
    Caption = 'PDM Flags'
    TabOrder = 4
    object IMD: TCheckBox
      Left = 16
      Top = 47
      Width = 97
      Height = 17
      Caption = 'IMD'
      TabOrder = 0
    end
    object BSPD: TCheckBox
      Left = 16
      Top = 71
      Width = 97
      Height = 17
      Caption = 'BSPD'
      TabOrder = 1
    end
    object BMS: TCheckBox
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = 'BMS'
      TabOrder = 2
    end
  end
  object ShutD: TCheckBox
    Left = 328
    Top = 22
    Width = 97
    Height = 17
    Caption = 'Shutdown 1'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object ShutD2: TCheckBox
    Left = 328
    Top = 45
    Width = 97
    Height = 17
    Caption = 'Shutdown 2'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object ShutD3: TCheckBox
    Left = 328
    Top = 71
    Width = 97
    Height = 17
    Caption = 'Shutdown 3'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
end
