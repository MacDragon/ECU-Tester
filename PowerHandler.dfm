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
  object ShutDCockpit: TCheckBox
    Left = 328
    Top = 22
    Width = 97
    Height = 17
    Caption = 'Cockpit Button'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object ShutDLeft: TCheckBox
    Left = 328
    Top = 45
    Width = 97
    Height = 17
    Caption = 'Left Button'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object ShutDRight: TCheckBox
    Left = 328
    Top = 71
    Width = 97
    Height = 17
    Caption = 'Right Button'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object Inertia: TCheckBox
    Left = 328
    Top = 94
    Width = 97
    Height = 17
    Caption = 'Inertia Switch'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object Bots: TCheckBox
    Left = 431
    Top = 22
    Width = 97
    Height = 17
    Caption = 'Bots'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object BSPDBefore: TCheckBox
    Left = 431
    Top = 45
    Width = 97
    Height = 17
    Caption = 'BSPD Before Del'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object BSPDAfter: TCheckBox
    Left = 431
    Top = 68
    Width = 97
    Height = 17
    Caption = 'BSPD After Del'
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object IMD: TCheckBox
    Left = 431
    Top = 94
    Width = 97
    Height = 17
    Caption = 'IMD'
    Checked = True
    State = cbChecked
    TabOrder = 11
  end
end
