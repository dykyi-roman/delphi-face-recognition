object AboutForm: TAboutForm
  Left = 283
  Top = 233
  BorderStyle = bsToolWindow
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
  ClientHeight = 204
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 290
    Height = 157
    Shape = bsFrame
  end
  object Image1: TImage
    Left = 19
    Top = 16
    Width = 49
    Height = 49
  end
  object labelReadMe: TLabel
    Tag = -2
    Left = 248
    Top = 144
    Width = 41
    Height = 13
    Cursor = crHandPoint
    Caption = 'ReadMe'
    DragCursor = crDefault
    OnClick = labelReadMeClick
    OnMouseEnter = labelReadMeMouseEnter
    OnMouseLeave = labelReadMeMouseLeave
  end
  object labelSite: TLabel
    Tag = -2
    Left = 8
    Top = 179
    Width = 129
    Height = 13
    Cursor = crHandPoint
    Caption = 'www.dukuyteam.ho.ua'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = labelSiteClick
    OnMouseEnter = labelReadMeMouseEnter
    OnMouseLeave = labelReadMeMouseLeave
  end
  object labelIcq: TLabel
    Tag = -2
    Left = 74
    Top = 58
    Width = 84
    Height = 13
    Caption = 'ICQ: 443-731-743'
  end
  object labelmail: TLabel
    Tag = -2
    Left = 111
    Top = 77
    Width = 135
    Height = 13
    Cursor = crHandPoint
    Caption = 'dukuyteam-admin@s1.ho.ua'
    OnClick = labelmailClick
    OnMouseEnter = labelReadMeMouseEnter
    OnMouseLeave = labelReadMeMouseLeave
  end
  object labelemail2: TLabel
    Tag = -2
    Left = 74
    Top = 77
    Width = 31
    Height = 13
    Caption = 'E-mail:'
  end
  object Label1: TLabel
    Tag = -2
    Left = 74
    Top = 39
    Width = 105
    Height = 13
    Caption = 'Author: Dukuy Roman'
  end
  object Cancel: TButton
    Left = 223
    Top = 171
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 0
    OnClick = CancelClick
  end
  object ProgText: TStaticText
    Tag = -2
    Left = 74
    Top = 16
    Width = 215
    Height = 17
    AutoSize = False
    Caption = 'FaceRecognation v 2.5'
    TabOrder = 1
  end
end
