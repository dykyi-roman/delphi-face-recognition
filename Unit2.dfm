object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 220
  ClientWidth = 596
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
  object Image2: TImage
    Left = 24
    Top = 8
    Width = 177
    Height = 161
    Stretch = True
  end
  object Image3: TImage
    Left = 207
    Top = 8
    Width = 170
    Height = 161
    Stretch = True
  end
  object SpeedButton1: TSpeedButton
    Left = 313
    Top = 178
    Width = 23
    Height = 22
    Caption = '+'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 360
    Top = 178
    Width = 23
    Height = 22
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton2Click
  end
  object Shape1: TShape
    Left = 383
    Top = 8
    Width = 26
    Height = 25
    Brush.Color = clBtnFace
    Pen.Color = clRed
    Pen.Width = 3
  end
  object Shape2: TShape
    Left = 383
    Top = 39
    Width = 26
    Height = 25
    Brush.Color = clBtnFace
    Pen.Color = clBlue
    Pen.Width = 3
  end
  object Shape3: TShape
    Left = 383
    Top = 70
    Width = 26
    Height = 25
    Brush.Color = clBtnFace
    Pen.Color = clGreen
    Pen.Width = 3
  end
  object labelRed: TLabel
    Left = 417
    Top = 14
    Width = 156
    Height = 13
    Caption = '- '#1055#1088#1080#1087#1091#1089#1090#1080#1084#1072' '#1086#1073#1083#1072#1089#1090#1100' '#1086#1073#1083#1080#1095#1095#1103
  end
  object labelBlue: TLabel
    Left = 417
    Top = 45
    Width = 106
    Height = 13
    Caption = '- '#1047#1072#1089#1074#1110#1090#1083#1077#1085#1072' '#1086#1073#1083#1072#1089#1090#1100
  end
  object labelGreen: TLabel
    Left = 417
    Top = 77
    Width = 141
    Height = 13
    Caption = '- '#1086#1073#1083#1072#1089#1090#1100' '#1087#1086#1075#1072#1085#1086#1111' '#1074#1080#1076#1080#1084#1086#1089#1090#1110
  end
  object Shape4: TShape
    Left = 383
    Top = 101
    Width = 26
    Height = 25
    Brush.Color = clBtnFace
    Pen.Color = clYellow
    Pen.Width = 3
  end
  object labelYellow: TLabel
    Left = 417
    Top = 107
    Width = 79
    Height = 13
    Caption = '- '#1054#1073#1083#1072#1089#1090#1100' '#1096#1091#1084#1091
  end
  object Button2: TButton
    Left = 184
    Top = 175
    Width = 123
    Height = 42
    Caption = 'PrScreen'
    TabOrder = 0
    OnClick = Button2Click
  end
  object CheckBox2: TCheckBox
    Left = 24
    Top = 175
    Width = 97
    Height = 17
    Caption = 'Find Eyes'
    TabOrder = 1
  end
  object edCountRect: TEdit
    Left = 336
    Top = 179
    Width = 23
    Height = 21
    TabOrder = 2
    Text = '1'
  end
end
