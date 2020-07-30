object BMSForm: TBMSForm
  Left = 0
  Top = 0
  Caption = 'BMS'
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
  object Label1: TLabel
    Left = 151
    Top = 67
    Width = 36
    Height = 13
    Caption = 'Voltage'
  end
  object LimpMode: TCheckBox
    Left = 24
    Top = 41
    Width = 97
    Height = 17
    Caption = 'LimpMode'
    TabOrder = 0
  end
  object BMSVolt: TEdit
    Left = 24
    Top = 64
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    Text = '560'
  end
  object Connected: TCheckBox
    Left = 24
    Top = 18
    Width = 97
    Height = 17
    Caption = 'BMS Connected'
    TabOrder = 2
    OnClick = ConnectedClick
  end
  object BMSError: TCheckBox
    Left = 24
    Top = 91
    Width = 97
    Height = 17
    Caption = 'Error'
    TabOrder = 3
  end
  object BMSErrorCode: TComboBox
    Left = 24
    Top = 114
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 4
    Items.Strings = (
      'undefined'
      'overvoltage'
      'undervoltage'
      'overtemperature'
      'undertemperature'
      'overcurrent'
      'overpower'
      'external'
      'pec_error'
      'Accumulator Undervoltage'
      'IVT timeout')
  end
end
