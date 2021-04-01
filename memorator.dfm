object MemoratorForm: TMemoratorForm
  Left = 0
  Top = 0
  Caption = 'Memorator'
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
  object Connected: TCheckBox
    Left = 16
    Top = 16
    Width = 97
    Height = 17
    Caption = 'Connected'
    TabOrder = 0
    OnClick = ConnectedClick
  end
end
