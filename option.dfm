object OptionForm: TOptionForm
  Left = 405
  Top = 205
  BorderStyle = bsSizeToolWin
  Caption = #1053#1072#1083#1072#1096#1090#1091#1074#1072#1085#1085#1103
  ClientHeight = 379
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 514
    Height = 338
    ActivePage = AudVidSheet
    Align = alClient
    TabOrder = 0
    object AudVidSheet: TTabSheet
      Caption = #1040#1091#1076#1080#1086' '#1080' '#1074#1080#1076#1077#1086
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 506
        Height = 310
        ActivePage = WebSheet
        Align = alClient
        TabOrder = 0
        object WebSheet: TTabSheet
          Caption = 'WebSheet'
          DesignSize = (
            498
            282)
          object labelAVCamera: TLabel
            Left = 12
            Top = 12
            Width = 72
            Height = 13
            Caption = 'labelAVCamera'
          end
          object GroupBox: TGroupBox
            Left = 12
            Top = 45
            Width = 474
            Height = 224
            Anchors = [akLeft, akTop, akRight, akBottom]
            Caption = '`'
            TabOrder = 1
            object labelAudioVideo1: TLabel
              Left = 168
              Top = 24
              Width = 82
              Height = 13
              Caption = 'labelAudioVideo1'
            end
            object labelAV2: TLabel
              Left = 168
              Top = 77
              Width = 42
              Height = 13
              Caption = 'labelAV2'
            end
            object labelRecogLight: TLabel
              Left = 12
              Top = 129
              Width = 77
              Height = 13
              Caption = 'labelRecogLight'
            end
            object labelContrast: TLabel
              Left = 237
              Top = 128
              Width = 61
              Height = 13
              Caption = 'labelContrast'
            end
            object GroupMode: TRadioGroup
              Left = 12
              Top = 32
              Width = 150
              Height = 91
              Caption = 'GroupMode'
              ItemIndex = 0
              Items.Strings = (
                '640 x 480'
                '320 x 240')
              TabOrder = 0
              OnClick = GroupModeClick
            end
            object EditKadr: TTrackBar
              Left = 168
              Top = 42
              Width = 299
              Height = 29
              Max = 30
              Min = 5
              Position = 5
              TabOrder = 1
            end
            object KadrEdit: TTrackBar
              Left = 168
              Top = 96
              Width = 299
              Height = 29
              Max = 30
              TabOrder = 2
            end
            object SglagBox: TCheckBox
              Left = 17
              Top = 184
              Width = 221
              Height = 17
              Caption = 'SglagBox'
              TabOrder = 3
            end
            object tbRecogLight: TTrackBar
              Left = 12
              Top = 147
              Width = 230
              Height = 30
              Max = 100
              Position = 50
              TabOrder = 4
              TickStyle = tsManual
            end
            object tbRecogContrast: TTrackBar
              Left = 237
              Top = 147
              Width = 230
              Height = 30
              Max = 50
              TabOrder = 5
              TickStyle = tsManual
            end
            object btnWebDefault: TBitBtn
              Tag = -2
              Left = 384
              Top = 184
              Width = 75
              Height = 25
              Caption = 'Default'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              TabOrder = 6
              OnClick = btnWebDefaultClick
            end
          end
          object VideoCapFilters: TComboBox
            Left = 126
            Top = 9
            Width = 187
            Height = 21
            Style = csDropDownList
            TabOrder = 0
          end
        end
        object AudioSheet: TTabSheet
          Caption = 'AudioSheet'
          ImageIndex = 1
          object Panel1: TPanel
            Tag = -1
            Left = 0
            Top = 241
            Width = 498
            Height = 41
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 0
            object InputLines: TComboBox
              Left = 299
              Top = 6
              Width = 187
              Height = 21
              Style = csDropDownList
              TabOrder = 0
            end
          end
          object Panel2: TPanel
            Tag = -1
            Left = 0
            Top = 43
            Width = 498
            Height = 198
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            DesignSize = (
              498
              198)
            object gbAVSouns: TGroupBox
              Left = 12
              Top = 6
              Width = 474
              Height = 189
              Anchors = [akLeft, akTop, akRight, akBottom]
              Caption = 'gbAVSouns'
              TabOrder = 0
              object AudioFormats: TFRListBox
                Left = 16
                Top = 24
                Width = 441
                Height = 145
                ItemHeight = 13
                TabOrder = 0
              end
            end
          end
          object Panel3: TPanel
            Tag = -1
            Left = 0
            Top = 0
            Width = 498
            Height = 43
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            object labelAVAudio: TLabel
              Left = 12
              Top = 12
              Width = 63
              Height = 13
              Caption = 'labelAVAudio'
            end
            object AudioCapFilters: TComboBox
              Left = 126
              Top = 9
              Width = 187
              Height = 21
              Style = csDropDownList
              TabOrder = 0
              OnClick = AudioCapFiltersClick
            end
          end
        end
        object VideoSheet: TTabSheet
          Caption = 'VideoSheet'
          ImageIndex = 2
          object Bevel4: TBevel
            Left = 12
            Top = 12
            Width = 474
            Height = 257
            Shape = bsFrame
          end
          object labelVideoBright: TLabel
            Left = 20
            Top = 16
            Width = 49
            Height = 13
            Caption = 'Brightness'
          end
          object labelVideoContrast: TLabel
            Left = 24
            Top = 66
            Width = 39
            Height = 13
            Caption = 'Contrast'
          end
          object labelVideoSaturation: TLabel
            Left = 20
            Top = 116
            Width = 48
            Height = 13
            Caption = 'Saturation'
          end
          object labelVideoHue: TLabel
            Left = 20
            Top = 166
            Width = 20
            Height = 13
            Caption = 'Hue'
          end
          object labelVideoPX: TLabel
            Left = 248
            Top = 16
            Width = 47
            Height = 13
            Caption = 'Position X'
          end
          object Label6: TLabel
            Left = 248
            Top = 66
            Width = 47
            Height = 13
            Caption = 'Position Y'
          end
          object Label7: TLabel
            Left = 248
            Top = 116
            Width = 30
            Height = 13
            Caption = 'Size X'
          end
          object Label8: TLabel
            Left = 248
            Top = 166
            Width = 30
            Height = 13
            Caption = 'Size Y'
          end
          object Brightness: TTrackBar
            Left = 20
            Top = 35
            Width = 230
            Height = 25
            Enabled = False
            Max = 0
            Frequency = 0
            TabOrder = 0
            TickStyle = tsNone
            OnChange = BrightnessChange
          end
          object Contrast: TTrackBar
            Left = 20
            Top = 85
            Width = 230
            Height = 25
            Enabled = False
            Max = 0
            Frequency = 0
            TabOrder = 1
            TickStyle = tsNone
            OnChange = ContrastChange
          end
          object Hue: TTrackBar
            Left = 20
            Top = 185
            Width = 230
            Height = 25
            Enabled = False
            Max = 0
            Frequency = 0
            TabOrder = 2
            TickStyle = tsNone
            OnChange = HueChange
          end
          object Saturation: TTrackBar
            Left = 20
            Top = 135
            Width = 230
            Height = 25
            Enabled = False
            Max = 0
            Frequency = 0
            TabOrder = 3
            TickStyle = tsNone
          end
          object AspectRatio: TCheckBox
            Left = 24
            Top = 218
            Width = 122
            Height = 19
            Caption = 'Keep Aspect Ratio'
            Checked = True
            State = cbChecked
            TabOrder = 4
            OnClick = AspectRatioClick
          end
          object PositionX: TTrackBar
            Left = 248
            Top = 35
            Width = 220
            Height = 25
            Enabled = False
            Max = 100
            TabOrder = 5
            TickStyle = tsNone
            OnChange = SizeYChange
          end
          object PositionY: TTrackBar
            Left = 248
            Top = 85
            Width = 220
            Height = 25
            Enabled = False
            Max = 100
            TabOrder = 6
            TickStyle = tsNone
            OnChange = SizeYChange
          end
          object SizeX: TTrackBar
            Left = 248
            Top = 135
            Width = 220
            Height = 25
            Enabled = False
            Max = 100
            Position = 100
            TabOrder = 7
            TickStyle = tsNone
            OnChange = SizeYChange
          end
          object SizeY: TTrackBar
            Left = 248
            Top = 185
            Width = 220
            Height = 25
            Enabled = False
            Max = 100
            Position = 100
            TabOrder = 8
            TickStyle = tsNone
            OnChange = SizeYChange
          end
        end
      end
    end
    object CodecSheet: TTabSheet
      Caption = #1050#1086#1076#1077#1082#1080
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 506
        Height = 310
        ActivePage = CodecVideo
        Align = alClient
        TabOrder = 0
        object CodecVideo: TTabSheet
          Caption = #1042#1080#1076#1077#1086' '#1082#1086#1076#1077#1082#1080
          object CodecBox: TGroupBox
            Left = 12
            Top = 12
            Width = 475
            Height = 255
            Caption = 'CodecBox'
            TabOrder = 0
            object lbVideoCodec: TFRListBox
              Left = 12
              Top = 24
              Width = 450
              Height = 213
              ItemHeight = 13
              TabOrder = 0
            end
          end
        end
        object AudioCodec: TTabSheet
          Caption = #1040#1091#1076#1080#1086' '#1082#1086#1076#1077#1082#1080
          ImageIndex = 1
          object GroupBox2: TGroupBox
            Left = 12
            Top = 12
            Width = 475
            Height = 255
            Caption = 'GroupBox2'
            TabOrder = 0
            object lbAudioCodec: TFRListBox
              Left = 12
              Top = 24
              Width = 450
              Height = 217
              ItemHeight = 13
              TabOrder = 0
            end
          end
        end
      end
    end
    object SystemSheet: TTabSheet
      Caption = #1057#1080#1089#1090#1077#1084#1072
      ImageIndex = 2
      object Bevel2: TBevel
        Left = 12
        Top = 12
        Width = 480
        Height = 285
        Shape = bsFrame
      end
      object lavelSystem: TLabel
        Left = 24
        Top = 101
        Width = 56
        Height = 13
        Caption = 'lavelSystem'
      end
      object cbAutostart: TCheckBox
        Left = 24
        Top = 24
        Width = 460
        Height = 18
        Caption = 'cbAutostart'
        TabOrder = 0
        OnClick = cbAutostartClick
      end
      object cbSystemLanguage: TComboBox
        Left = 169
        Top = 98
        Width = 187
        Height = 21
        Style = csDropDownList
        TabOrder = 3
        OnChange = cbSystemLanguageChange
      end
      object cbSticky: TCheckBox
        Left = 24
        Top = 48
        Width = 460
        Height = 17
        BiDiMode = bdRightToLeftNoAlign
        Caption = 'cbSticky'
        ParentBiDiMode = False
        TabOrder = 1
      end
      object cbSaveFormPos: TCheckBox
        Left = 24
        Top = 70
        Width = 460
        Height = 17
        Caption = 'cbSaveFormPos'
        TabOrder = 2
      end
    end
    object FontSheet: TTabSheet
      Caption = 'Revognition'
      ImageIndex = 3
      object PageControl4: TPageControl
        Left = 0
        Top = 0
        Width = 506
        Height = 310
        ActivePage = tsRecognitionOption
        Align = alClient
        TabOrder = 0
        object tsColorAndRaise: TTabSheet
          Caption = 'tsColorAndRaise'
          object labelFace: TLabel
            Left = 29
            Top = 19
            Width = 62
            Height = 13
            Caption = #1050#1086#1083#1110#1088' '#1088#1072#1084#1082#1080
          end
          object labelFace2: TLabel
            Left = 202
            Top = 21
            Width = 81
            Height = 13
            Caption = #1058#1086#1074#1097#1080#1085#1072' '#1088#1072#1084#1082#1080
          end
          object gbMouth: TGroupBox
            Left = 12
            Top = 215
            Width = 458
            Height = 50
            Caption = #1056#1086#1090
            TabOrder = 1
            object labellMouth2: TLabel
              Left = 190
              Top = 21
              Width = 81
              Height = 13
              Caption = #1058#1086#1074#1097#1080#1085#1072' '#1088#1072#1084#1082#1080
              Enabled = False
            end
            object labellMouth: TLabel
              Left = 16
              Top = 21
              Width = 62
              Height = 13
              Caption = #1050#1086#1083#1110#1088' '#1088#1072#1084#1082#1080
              Enabled = False
            end
            object seMouth4: TSpinEdit
              Left = 320
              Top = 17
              Width = 36
              Height = 22
              Enabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = seFace0Change
            end
            object cbMouth4: TCheckBox
              Tag = -2
              Left = 434
              Top = -1
              Width = 24
              Height = 17
              TabOrder = 1
              OnClick = cbEyes1Click
            end
            object clMouth4: TColorBox
              Left = 91
              Top = 18
              Width = 93
              Height = 22
              Selected = clYellow
              TabOrder = 2
              OnChange = seFace0Change
            end
          end
          object gbNose: TGroupBox
            Left = 12
            Top = 159
            Width = 458
            Height = 50
            Caption = #1053#1110#1089
            TabOrder = 2
            object labelNose2: TLabel
              Left = 190
              Top = 21
              Width = 81
              Height = 13
              Caption = #1058#1086#1074#1097#1080#1085#1072' '#1088#1072#1084#1082#1080
              Enabled = False
            end
            object labelNose: TLabel
              Left = 16
              Top = 21
              Width = 62
              Height = 13
              Caption = #1050#1086#1083#1110#1088' '#1088#1072#1084#1082#1080
              Enabled = False
            end
            object seNose3: TSpinEdit
              Left = 320
              Top = 16
              Width = 36
              Height = 22
              Enabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = seFace0Change
            end
            object cbNose3: TCheckBox
              Tag = -2
              Left = 434
              Top = -1
              Width = 24
              Height = 17
              TabOrder = 1
              OnClick = cbEyes1Click
            end
            object clNose3: TColorBox
              Left = 91
              Top = 16
              Width = 93
              Height = 22
              Selected = clBlue
              TabOrder = 2
              OnChange = seFace0Change
            end
          end
          object gbEyebrows: TGroupBox
            Left = 12
            Top = 103
            Width = 458
            Height = 50
            Caption = #1041#1088#1086#1074#1080
            TabOrder = 3
            object labelEyebrows2: TLabel
              Left = 190
              Top = 21
              Width = 81
              Height = 13
              Caption = #1058#1086#1074#1097#1080#1085#1072' '#1088#1072#1084#1082#1080
              Enabled = False
            end
            object labelEyebrows: TLabel
              Left = 16
              Top = 21
              Width = 62
              Height = 13
              Caption = #1050#1086#1083#1110#1088' '#1088#1072#1084#1082#1080
              Enabled = False
            end
            object seEyebrows2: TSpinEdit
              Left = 320
              Top = 18
              Width = 36
              Height = 22
              Enabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = seFace0Change
            end
            object cbEyeBrowse2: TCheckBox
              Tag = -2
              Left = 434
              Top = -1
              Width = 24
              Height = 17
              TabOrder = 1
              OnClick = cbEyes1Click
            end
            object clEyebrows2: TColorBox
              Left = 91
              Top = 18
              Width = 93
              Height = 22
              Selected = clOlive
              TabOrder = 2
              OnChange = seFace0Change
            end
          end
          object gbEyes: TGroupBox
            Left = 12
            Top = 46
            Width = 458
            Height = 50
            Caption = #1054#1095#1110
            TabOrder = 4
            object labelEyes2: TLabel
              Left = 190
              Top = 21
              Width = 81
              Height = 13
              Caption = #1058#1086#1074#1097#1080#1085#1072' '#1088#1072#1084#1082#1080
              Enabled = False
            end
            object labelEyes: TLabel
              Left = 19
              Top = 21
              Width = 62
              Height = 13
              Caption = #1050#1086#1083#1110#1088' '#1088#1072#1084#1082#1080
              Enabled = False
            end
            object seEsys1: TSpinEdit
              Left = 320
              Top = 16
              Width = 36
              Height = 22
              Enabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = seFace0Change
            end
            object cbEyes1: TCheckBox
              Tag = -2
              Left = 434
              Top = -1
              Width = 24
              Height = 17
              TabOrder = 1
              OnClick = cbEyes1Click
            end
            object clEyes1: TColorBox
              Left = 91
              Top = 18
              Width = 93
              Height = 22
              Selected = clGreen
              TabOrder = 2
              OnChange = seFace0Change
            end
          end
          object seFace0: TSpinEdit
            Left = 332
            Top = 16
            Width = 36
            Height = 22
            MaxValue = 10
            MinValue = 1
            TabOrder = 0
            Value = 1
            OnChange = seFace0Change
          end
          object clFace0: TColorBox
            Left = 103
            Top = 16
            Width = 93
            Height = 22
            Selected = clRed
            TabOrder = 5
            OnChange = seFace0Change
          end
        end
        object tsRecognitionOption: TTabSheet
          Caption = 'tsRecognitionOption'
          ImageIndex = 1
          object Bevel3: TBevel
            Left = 12
            Top = 12
            Width = 472
            Height = 255
            Shape = bsFrame
          end
          object labelRecognition: TLabel
            Left = 24
            Top = 24
            Width = 79
            Height = 13
            Caption = 'labelRecognition'
          end
          object labelFilter: TLabel
            Left = 24
            Top = 127
            Width = 44
            Height = 13
            Caption = 'labelFilter'
          end
          object labelRecognition2: TLabel
            Left = 24
            Top = 76
            Width = 85
            Height = 13
            Caption = 'labelRecognition2'
          end
          object imgIntegral: TImage
            Left = 24
            Top = 45
            Width = 16
            Height = 16
            Picture.Data = {
              07544269746D617036050000424D360500000000000036040000280000001000
              000010000000010008000000000000010000130B0000130B0000000100000001
              00001C1C1C002020200022222200232323002A2A2A002B2B2B002D2D2D002F2F
              2F00303030003131310032323200333333003535350036363600373737003838
              38003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F0040404000424242004343
              4300444444004646460048484800494949004A4A4A004B4B4B004C4C4C004D4D
              4D00505050005151510052525200535353005454540056565600595959005B5B
              5B005E5E5E005F5F5F0061616100636363006464640065656500666666006767
              6700696969006A6A6A006B6B6B006C6C6C006E6E6E0072727200777777007878
              7800797979007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F008080
              8000818181008282820085858500888888008989890091919100929292009797
              970098989800999999009F9F9F00A0A0A000A2A2A200A3A3A300A6A6A600ADAD
              AD00AEAEAE00B2B2B200B9B9B900BCBCBC00CFCFCF00D4D4D400D6D6D600D7D7
              D700DBDBDB00DDDDDD00E3E3E300E6E6E600E8E8E800E9E9E900EBEBEB00EEEE
              EE00EFEFEF00F1F1F100F5F5F500F8F8F800F9F9F900FAFAFA00FCFCFC00FDFD
              FD00FEFEFE00FFFFFF0000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00006767645B524D494645484C505865676768612D132D3638393A3836321322
              5667675A151B43403D3E3F3F3D3A1E16536768631A2444443C3B3B37342B241D
              596867672F2C212526262523201E1618626867674F410E0B11191E14100C0835
              67676867675433071327281906265265676868686767675C260E1D1157666768
              686769696969696831091A2A65686869696969696969695E1E0F1D3055676869
              696969696968684B0404172947676769696969696968673000010D1C2E636769
              696969696968671F0000030B155D676969696969686868311E0C0002125F6768
              69696969696867514A42050A4067686969696969696968654E260B3B60676769
              6969}
            Stretch = True
          end
          object imgIntegral2: TImage
            Left = 266
            Top = 45
            Width = 16
            Height = 16
            Picture.Data = {
              07544269746D617036050000424D360500000000000036040000280000001000
              000010000000010008000000000000010000130B0000130B0000000100000001
              0000000000000101010002020200030303000505050006060600070707000A0A
              0A000E0E0E001010100011111100141414001616160017171700191919001C1C
              1C00222222002424240028282800292929002B2B2B0030303000434343004646
              46004D4D4D005151510052525200595959005C5C5C005D5D5D005F5F5F006060
              60006666660067676700686868006D6D6D006E6E6E0076767600777777007A7A
              7A007D7D7D007E7E7E007F7F7F00808080008181810082828200838383008484
              8400858585008686860087878700888888008D8D8D0091919100939393009494
              9400959595009696960098989800999999009A9A9A009B9B9B009C9C9C009E9E
              9E00A0A0A000A1A1A100A4A4A400A6A6A600A9A9A900ABABAB00ACACAC00ADAD
              AD00AEAEAE00AFAFAF00B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7
              B700B9B9B900BBBBBB00BCBCBC00BDBDBD00BFBFBF00C0C0C000C1C1C100C2C2
              C200C3C3C300C4C4C400C7C7C700C8C8C800C9C9C900CACACA00CCCCCC00CDCD
              CD00CECECE00CFCFCF00D0D0D000D2D2D200D4D4D400D5D5D500DCDCDC00DDDD
              DD00DFDFDF00E3E3E30000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000202050E171C202324211D191104020201083C563C3331302F3133375647
              1302020F544E26292C2B2A2A2C2F4B53160201064F4525252D2E2E32353E454C
              100102023A3D484443434446494B5351070102021A285B5E58504B55595D6134
              02020102021536625642415063431704020101010202020D435B4C5812030201
              010200000000000138604F3F04010100000000000000000B4B5A4C3914020100
              000000000001011E6565524022020200000000000001023969685C4D3B060200
              000000000001024A6969665E540C020000000000010101384B5D6967570A0201
              00000000000102181F27645F2902010000000000000001041B435E2E09020200
              0000}
            Stretch = True
          end
          object tbSensitivity: TTrackBar
            Left = 24
            Top = 95
            Width = 220
            Height = 26
            Max = 50
            Position = 10
            TabOrder = 0
            OnChange = tbSensitivityChange
          end
          object btnRecogDefault: TButton
            Tag = -2
            Left = 400
            Top = 231
            Width = 75
            Height = 25
            Caption = 'Default'
            TabOrder = 1
            OnClick = btnRecogDefaultClick
          end
          object cbFiceCount: TCheckBox
            Left = 24
            Top = 186
            Width = 218
            Height = 17
            Caption = 'cbFiceCount'
            TabOrder = 2
            OnClick = cbFiceCountClick
          end
          object tbMedianFilter: TTrackBar
            Left = 24
            Top = 146
            Width = 220
            Height = 34
            Max = 4
            TabOrder = 3
          end
          object tbSensitivity2: TTrackBar
            Left = 46
            Top = 43
            Width = 220
            Height = 27
            Max = 20
            Position = 10
            TabOrder = 4
            OnChange = tbSensitivity2Change
          end
        end
      end
    end
    object Effect: TTabSheet
      Caption = #1045#1092#1077#1082#1090#1080
      ImageIndex = 4
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 506
        Height = 310
        ActivePage = Filtesr
        Align = alClient
        TabOrder = 0
        object Filtesr: TTabSheet
          Caption = 'Filtesr'
          object gbEffect: TGroupBox
            Left = 12
            Top = 12
            Width = 472
            Height = 253
            Caption = #1042#1089#1103' '#1086#1073#1083#1072#1089#1090#1100
            TabOrder = 0
            object EffectTrackBar: TTrackBar
              Left = 3
              Top = 209
              Width = 469
              Height = 40
              Enabled = False
              Max = 100
              Min = 1
              ParentShowHint = False
              Position = 1
              ShowHint = True
              ShowSelRange = False
              TabOrder = 3
            end
            object rgMirror: TRadioGroup
              Left = 193
              Top = 24
              Width = 267
              Height = 97
              Caption = 'Mirror'
              Enabled = False
              ItemIndex = 0
              Items.Strings = (
                'Horizont'
                'Vertical'
                'Both')
              TabOrder = 2
            end
            object cbEffect: TCheckBox
              Tag = -1
              Left = 448
              Top = -5
              Width = 24
              Height = 24
              TabOrder = 0
              OnClick = cbEffectClick
            end
            object lbEffect: TFRListBox
              Left = 12
              Top = 24
              Width = 169
              Height = 179
              Enabled = False
              ItemHeight = 13
              Items.Strings = (
                'GaussianBlur'
                'SplitBlur'
                'AddColorNoise'
                'AddMonoNoise'
                'AntiAlias'
                'Contrast'
                'FishEye'
                'Lightness'
                'Darkness'
                'Saturation'
                'Mosaic'
                'Twist'
                'Splitlight'
                'Tile'
                'SpotLight'
                'Trace'
                'Emboss'
                'Solorize'
                'Posterize'
                'Grayscale'
                'Invert'
                'Double'
                'Mirror')
              TabOrder = 1
              OnClick = lbEffectClick
            end
          end
        end
        object Fraime: TTabSheet
          Caption = 'Fraime'
          ImageIndex = 1
          object lbEffectFraime: TFRListBox
            Left = 12
            Top = 12
            Width = 469
            Height = 258
            Style = lbOwnerDrawFixed
            Columns = 4
            ItemHeight = 100
            TabOrder = 0
            OnDrawItem = lbEffectFraimeDrawItem
          end
        end
      end
    end
    object tsVideo: TTabSheet
      Caption = #1042#1110#1076#1077#1086
      ImageIndex = 5
      object labelVideo: TLabel
        Left = 12
        Top = 68
        Width = 49
        Height = 13
        Caption = 'labelVideo'
      end
      object labelVideoPath: TLabel
        Left = 12
        Top = 17
        Width = 71
        Height = 13
        Caption = 'labelVideoPath'
      end
      object btnVideoPath: TBitBtn
        Left = 463
        Top = 34
        Width = 33
        Height = 25
        Caption = '...'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = btnVideoPathClick
      end
      object cbVideoFormat: TComboBox
        Left = 12
        Top = 87
        Width = 187
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        Items.Strings = (
          'Windows Format (*.avi)')
      end
      object cbVideo: TCheckBox
        Left = 12
        Top = 130
        Width = 221
        Height = 17
        Caption = 'cbVideo'
        TabOrder = 3
        OnClick = cbVideoClick
      end
      object cbVideo2: TCheckBox
        Left = 12
        Top = 160
        Width = 221
        Height = 17
        Caption = 'cbVideo2'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object seVideo: TSpinEdit
        Left = 248
        Top = 128
        Width = 42
        Height = 22
        Enabled = False
        MaxValue = 30
        MinValue = 5
        TabOrder = 4
        Value = 5
      end
      object edVideo: TEdit
        Left = 12
        Top = 36
        Width = 445
        Height = 21
        TabOrder = 0
      end
    end
    object tsPhoto: TTabSheet
      Caption = #1060#1086#1090#1086
      ImageIndex = 6
      object labelPhoto: TLabel
        Left = 12
        Top = 123
        Width = 50
        Height = 13
        Caption = 'labelPhoto'
      end
      object labelPhoto2: TLabel
        Left = 12
        Top = 68
        Width = 56
        Height = 13
        Caption = 'labelPhoto2'
      end
      object labelPhotoPath: TLabel
        Left = 12
        Top = 17
        Width = 72
        Height = 13
        Caption = 'labelPhotoPath'
      end
      object btnPhotoPath: TBitBtn
        Left = 463
        Top = 34
        Width = 33
        Height = 25
        Caption = '...'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = btnPhotoPathClick
      end
      object cbPhoto: TCheckBox
        Left = 14
        Top = 156
        Width = 228
        Height = 17
        Caption = 'cbPhoto'
        TabOrder = 4
        OnClick = cbPhotoClick
      end
      object cbPhotoFormat: TComboBox
        Left = 12
        Top = 87
        Width = 187
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        Items.Strings = (
          'Bitmap File (*.bmp)')
      end
      object sePhoto: TSpinEdit
        Left = 248
        Top = 120
        Width = 41
        Height = 22
        MaxValue = 10
        MinValue = 1
        TabOrder = 3
        Value = 1
      end
      object sePhoto2: TSpinEdit
        Left = 248
        Top = 154
        Width = 41
        Height = 22
        Enabled = False
        MaxValue = 30
        MinValue = 5
        TabOrder = 5
        Value = 5
      end
      object gbDataTime: TGroupBox
        Left = 12
        Top = 186
        Width = 484
        Height = 112
        Caption = #1044#1072#1090#1072' '#1081' '#1095#1072#1089
        TabOrder = 6
        object Bevel1: TBevel
          Left = 214
          Top = 24
          Width = 7
          Height = 46
          Shape = bsLeftLine
        end
        object labelPhotoDate: TLabel
          Tag = -1
          Left = 236
          Top = 25
          Width = 73
          Height = 13
          Caption = 'labelPhotoDate'
        end
        object labelPhotoTime: TLabel
          Tag = -1
          Left = 236
          Top = 54
          Width = 73
          Height = 13
          Caption = 'labelPhotoTime'
        end
        object labelPhotoDateTime: TLabel
          Left = 12
          Top = 82
          Width = 96
          Height = 13
          Caption = 'labelPhotoDateTime'
        end
        object cbPhotoDate: TCheckBox
          Left = 12
          Top = 24
          Width = 196
          Height = 17
          Caption = 'cbPhotoDate'
          TabOrder = 0
          OnClick = cbPhotoDateClick
        end
        object cbPhotoTime: TCheckBox
          Left = 12
          Top = 53
          Width = 195
          Height = 17
          Caption = 'cbPhotoTime'
          TabOrder = 1
          OnClick = cbPhotoDateClick
        end
        object cbPhotoDateTime: TComboBox
          Left = 122
          Top = 79
          Width = 187
          Height = 21
          Style = csDropDownList
          BiDiMode = bdRightToLeftReadingOnly
          ParentBiDiMode = False
          TabOrder = 2
          Items.Strings = (
            'Left'
            'Center'
            'Right')
        end
      end
      object edPhoto: TEdit
        Left = 12
        Top = 36
        Width = 445
        Height = 21
        TabOrder = 0
      end
    end
  end
  object PanelBtn: TPanel
    Tag = -2
    Left = 0
    Top = 338
    Width = 514
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      514
      41)
    object Cancel: TButton
      Left = 429
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1080#1090#1080
      TabOrder = 2
      OnClick = CancelClick
    end
    object HelpBtn: TButton
      Left = 12
      Top = 6
      Width = 75
      Height = 25
      Action = MainForm.Help
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
    object btnDefault: TButton
      Left = 93
      Top = 6
      Width = 75
      Height = 25
      Caption = #1057#1082#1080#1085#1091#1090#1080
      TabOrder = 1
      OnClick = btnDefaultClick
    end
  end
  object VideoSourceFilter: TFilter
    BaseFilter.data = {00000000}
    Left = 240
    Top = 328
  end
  object AudioSourceFilter: TFilter
    BaseFilter.data = {00000000}
    Left = 296
    Top = 328
  end
  object CaptureGraph: TFilterGraph
    Mode = gmCapture
    GraphEdit = True
    LinearVolume = True
    Left = 184
    Top = 328
  end
  object TimerTime: TTimer
    Enabled = False
    OnTimer = TimerTimeTimer
    Left = 368
    Top = 328
  end
end
