object FrontSpeedForm: TFrontSpeedForm
  Left = 0
  Top = 0
  Caption = 'FrontSpeed'
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
  object LConnected: TCheckBox
    Left = 16
    Top = 16
    Width = 97
    Height = 17
    Caption = 'Left Connected'
    TabOrder = 0
    OnClick = LConnectedClick
  end
  object RConnected: TCheckBox
    Left = 16
    Top = 39
    Width = 97
    Height = 17
    Caption = 'Right Connected'
    TabOrder = 1
    OnClick = RConnectedClick
  end
end
