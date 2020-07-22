object PDMForm: TPDMForm
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsSingle
  Caption = 'PDM'
  ClientHeight = 136
  ClientWidth = 325
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
  object PDMGroup: TGroupBox
    Left = 8
    Top = 8
    Width = 82
    Height = 120
    Caption = 'PDM Flags'
    TabOrder = 0
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
    object ShutD: TCheckBox
      Left = 16
      Top = 94
      Width = 97
      Height = 17
      Caption = 'ShutD'
      TabOrder = 3
    end
  end
  object connected: TCheckBox
    Left = 96
    Top = 15
    Width = 97
    Height = 17
    Caption = 'PDM Present'
    TabOrder = 1
    OnClick = connectedClick
  end
end
