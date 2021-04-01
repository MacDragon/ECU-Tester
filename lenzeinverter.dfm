object LenzeInverterForm: TLenzeInverterForm
  Left = 0
  Top = 0
  Caption = 'Lenze Inverters'
  ClientHeight = 261
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object InverterL1Internal: TLabel
    Left = 200
    Top = 72
    Width = 4
    Height = 13
    Caption = '-'
  end
  object InverterL1Stat: TLabel
    Left = 130
    Top = 72
    Width = 4
    Height = 13
    Caption = '-'
  end
  object Label19: TLabel
    Left = 58
    Top = 72
    Width = 51
    Height = 13
    Caption = 'InverterL1'
  end
  object Label20: TLabel
    Left = 58
    Top = 91
    Width = 53
    Height = 13
    Caption = 'InverterR1'
  end
  object InverterR1Stat: TLabel
    Left = 130
    Top = 91
    Width = 4
    Height = 13
    Caption = '-'
  end
  object InverterR1Internal: TLabel
    Left = 200
    Top = 91
    Width = 4
    Height = 13
    Caption = '-'
  end
  object Label1: TLabel
    Left = 58
    Top = 112
    Width = 51
    Height = 13
    Caption = 'InverterL2'
  end
  object InverterL2Stat: TLabel
    Left = 130
    Top = 112
    Width = 4
    Height = 13
    Caption = '-'
  end
  object InverterL2Internal: TLabel
    Left = 200
    Top = 112
    Width = 4
    Height = 13
    Caption = '-'
  end
  object Label4: TLabel
    Left = 58
    Top = 131
    Width = 53
    Height = 13
    Caption = 'InverterR2'
  end
  object InverterR2Stat: TLabel
    Left = 130
    Top = 131
    Width = 4
    Height = 13
    Caption = '-'
  end
  object InverterR2Internal: TLabel
    Left = 200
    Top = 131
    Width = 4
    Height = 13
    Caption = '-'
  end
  object Label2: TLabel
    Left = 306
    Top = 72
    Width = 32
    Height = 13
    Caption = 'APPC1'
  end
  object APPC1State: TLabel
    Left = 378
    Top = 72
    Width = 4
    Height = 13
    Caption = '-'
  end
  object Label3: TLabel
    Left = 306
    Top = 91
    Width = 32
    Height = 13
    Caption = 'APPC2'
  end
  object APPC2State: TLabel
    Left = 378
    Top = 91
    Width = 4
    Height = 13
    Caption = '-'
  end
  object Connected: TCheckBox
    Left = 16
    Top = 16
    Width = 97
    Height = 17
    Caption = 'Connected'
    TabOrder = 0
    OnClick = ConnectedClick
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 416
    Top = 40
  end
end
