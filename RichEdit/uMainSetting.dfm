object SettingPagesDlg: TSettingPagesDlg
  Left = 195
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Octopus option settings '
  ClientHeight = 636
  ClientWidth = 1100
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1100
    Height = 593
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    object PageControl1: TPageControl
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 1084
      Height = 577
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Serial port setting'
        object Panel6: TPanel
          Left = 326
          Top = 0
          Width = 750
          Height = 545
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object Panel11: TPanel
            AlignWithMargins = True
            Left = 5
            Top = 379
            Width = 740
            Height = 161
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 5
            Align = alTop
            TabOrder = 0
            object Button5: TButton
              Left = 10
              Top = 77
              Width = 336
              Height = 34
              Caption = 'Clear internal cache '
              TabOrder = 0
              OnClick = Button5Click
            end
            object Button4: TButton
              Left = 10
              Top = 29
              Width = 336
              Height = 34
              Caption = 'Open the log and the profile directory '
              TabOrder = 1
              OnClick = Button4Click
            end
            object Button6: TButton
              Left = 520
              Top = 32
              Width = 131
              Height = 57
              Caption = 'test'
              TabOrder = 2
              Visible = False
              OnClick = Button6Click
            end
          end
          object Panel23: TPanel
            AlignWithMargins = True
            Left = 5
            Top = 2
            Width = 740
            Height = 167
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 5
            Align = alTop
            TabOrder = 1
            object Label111: TLabel
              Left = 8
              Top = 93
              Width = 231
              Height = 17
              Caption = 'Automatic save time interval of seconds'
            end
            object Label110: TLabel
              Left = 8
              Top = 34
              Width = 344
              Height = 17
              Caption = 'Transparency, the smaller the value is, the more refreshing '
            end
            object Edit1: TEdit
              Left = 370
              Top = 31
              Width = 90
              Height = 25
              Color = clScrollBar
              ReadOnly = True
              TabOrder = 0
              Text = '238'
            end
            object UpDown1: TUpDown
              Left = 460
              Top = 31
              Width = 16
              Height = 25
              Associate = Edit1
              Min = 1
              Max = 255
              Position = 238
              TabOrder = 1
            end
            object UpDown2: TUpDown
              Left = 460
              Top = 89
              Width = 16
              Height = 25
              Associate = Edit2
              Min = 5
              Max = 32766
              Position = 10
              TabOrder = 2
              OnChanging = UpDown2Changing
            end
            object Edit2: TEdit
              Left = 370
              Top = 89
              Width = 90
              Height = 25
              Hint = #21333#20301#31186
              Color = clScrollBar
              ParentShowHint = False
              ReadOnly = True
              ShowHint = True
              TabOrder = 3
              Text = '10'
            end
            object CheckBox8: TCheckBox
              Left = 8
              Top = 63
              Width = 305
              Height = 20
              Caption = 'Data is automatically saved to a local file'
              TabOrder = 4
            end
            object CheckBox7: TCheckBox
              Left = 8
              Top = 5
              Width = 433
              Height = 20
              Caption = 'The main window background enables a transparent effect '
              TabOrder = 5
            end
          end
          object Panel24: TPanel
            AlignWithMargins = True
            Left = 5
            Top = 174
            Width = 740
            Height = 200
            Margins.Left = 5
            Margins.Top = 2
            Margins.Right = 5
            Align = alTop
            TabOrder = 2
            object CheckBox2: TCheckBox
              Left = 10
              Top = 7
              Width = 535
              Height = 20
              Caption = 
                'The main window is always maintained at the top level of all the' +
                ' windows'
              TabOrder = 0
            end
            object CheckBox6: TCheckBox
              Left = 10
              Top = 34
              Width = 495
              Height = 20
              Caption = 'Send and receive the record for additional time information'
              TabOrder = 1
            end
            object CheckBox3: TCheckBox
              Left = 10
              Top = 61
              Width = 519
              Height = 20
              Caption = 
                'Send and receive records with additional year, month and day inf' +
                'ormation'
              TabOrder = 2
            end
            object CheckBox4: TCheckBox
              Left = 10
              Top = 89
              Width = 423
              Height = 20
              Caption = 'The line number is shown before the data record'
              TabOrder = 3
            end
            object CheckBox5: TCheckBox
              Left = 10
              Top = 116
              Width = 423
              Height = 20
              Caption = 'Displays the data being sent by the serial port'
              TabOrder = 4
            end
            object CheckBox1: TCheckBox
              Left = 10
              Top = 143
              Width = 191
              Height = 20
              Caption = 'Create shortcuts on the desktop '
              Checked = True
              Enabled = False
              State = cbChecked
              TabOrder = 5
            end
            object ComboBox8: TComboBox
              Left = 10
              Top = 168
              Width = 351
              Height = 25
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 6
              Text = 'ENGLISH'
              OnChange = ComboBox8Change
              Items.Strings = (
                'ENGLISH'
                #20013#25991#31616#20307)
            end
          end
        end
        object Panel17: TPanel
          Left = 0
          Top = 0
          Width = 320
          Height = 545
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object Panel3: TPanel
            AlignWithMargins = True
            Left = 6
            Top = 3
            Width = 308
            Height = 76
            Margins.Left = 6
            Margins.Right = 6
            Align = alTop
            TabOrder = 0
            object Button3: TButton
              Left = 5
              Top = 35
              Width = 295
              Height = 34
              Caption = 'Refresh the device list '
              ImageAlignment = iaRight
              ImageIndex = 0
              TabOrder = 1
              OnClick = Button3Click
            end
            object ComboBoxEx1: TComboBoxEx
              Left = 5
              Top = 3
              Width = 295
              Height = 26
              ItemsEx = <>
              Style = csExDropDownList
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnChange = ComboBoxEx1Change
            end
          end
          object Panel19: TPanel
            AlignWithMargins = True
            Left = 6
            Top = 84
            Width = 308
            Height = 234
            Margins.Left = 6
            Margins.Top = 2
            Margins.Right = 6
            Align = alTop
            ParentColor = True
            TabOrder = 1
            object Label105: TLabel
              Left = 5
              Top = 170
              Width = 47
              Height = 17
              Hint = #21457#36865#25968#25454#30340#26684#24335'ASCI'#20026#23383#31526'HEX'#20026#21313#20845#36827#21046'CMD'#20026#25191#34892#26412#22320'Shell'#21629#20196
              Caption = 'Sending'
              ParentShowHint = False
              ShowHint = True
            end
            object Label104: TLabel
              Left = 5
              Top = 138
              Width = 69
              Height = 17
              Caption = 'FlowControl'
            end
            object Label103: TLabel
              Left = 5
              Top = 106
              Width = 32
              Height = 17
              Caption = 'Parity'
            end
            object Label102: TLabel
              Left = 5
              Top = 74
              Width = 52
              Height = 17
              Caption = 'Stop bits'
            end
            object Label101: TLabel
              Left = 5
              Top = 42
              Width = 52
              Height = 17
              Caption = 'Data bits'
            end
            object Label100: TLabel
              Left = 5
              Top = 11
              Width = 56
              Height = 17
              Caption = 'Baud rate'
            end
            object Label106: TLabel
              Left = 5
              Top = 202
              Width = 52
              Height = 17
              Caption = 'Receving'
            end
            object ComboBox6: TComboBox
              Left = 76
              Top = 166
              Width = 224
              Height = 25
              Style = csDropDownList
              ItemIndex = 0
              ParentColor = True
              TabOrder = 0
              Text = 'ASCII Format           '
              Items.Strings = (
                'ASCII Format           '
                'Hexadecimal Format '
                'Octopus Protocol ')
            end
            object ComboBox5: TComboBox
              Left = 76
              Top = 134
              Width = 224
              Height = 25
              Style = csDropDownList
              ParentColor = True
              TabOrder = 1
            end
            object ComboBox4: TComboBox
              Left = 76
              Top = 102
              Width = 224
              Height = 25
              Style = csDropDownList
              ParentColor = True
              TabOrder = 2
            end
            object ComboBox3: TComboBox
              Left = 76
              Top = 70
              Width = 224
              Height = 25
              Style = csDropDownList
              ParentColor = True
              TabOrder = 3
            end
            object ComboBox2: TComboBox
              Left = 76
              Top = 38
              Width = 224
              Height = 25
              Style = csDropDownList
              ParentColor = True
              TabOrder = 4
            end
            object ComboBox1: TComboBox
              Left = 76
              Top = 7
              Width = 224
              Height = 25
              Style = csDropDownList
              DropDownCount = 20
              ParentColor = True
              TabOrder = 5
              OnChange = ComboBox1Change
            end
            object ComboBox7: TComboBox
              Left = 76
              Top = 198
              Width = 224
              Height = 25
              Style = csDropDownList
              ParentColor = True
              TabOrder = 6
            end
          end
          object Panel20: TPanel
            AlignWithMargins = True
            Left = 6
            Top = 323
            Width = 308
            Height = 217
            Margins.Left = 6
            Margins.Top = 2
            Margins.Right = 6
            Align = alTop
            TabOrder = 2
            object Label109: TLabel
              Left = 5
              Top = 144
              Width = 238
              Height = 17
              Caption = ' The alignment mode of hex data  shows'
            end
            object Label108: TLabel
              Left = 5
              Top = 78
              Width = 267
              Height = 17
              Caption = 'The character set encoding format of sending'
            end
            object Label107: TLabel
              Left = 5
              Top = 16
              Width = 270
              Height = 17
              Caption = 'The character set encoding format of receving'
            end
            object CBCodePage: TComboBox
              Left = 5
              Top = 40
              Width = 295
              Height = 25
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 0
              Text = ' CP_ACP        { ANSI / GB2312  }'
              Items.Strings = (
                ' CP_ACP        { ANSI / GB2312  }'
                ' CP_OEMCP   { OEM  code page }'
                ' CP_MACCP   { MAC  code page }'
                ' CP_SYMBOL  { SYMBOL translations }'
                ' CP_UTF7       { UTF-7 translation }'
                ' CP_UTF8       { UTF-8 translation }'
                ' CP_ASCII      { ANSI / ASCII }')
            end
            object CBAlignmentMode: TComboBox
              Left = 5
              Top = 170
              Width = 295
              Height = 25
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 1
              Text = 'Hexadecimal 16Bytes Align'
              Items.Strings = (
                'Hexadecimal 16Bytes Align'
                'Hexadecimal 32Bytes Align'
                'None')
            end
            object CBSendCodePage: TComboBox
              Left = 5
              Top = 103
              Width = 295
              Height = 25
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 2
              Text = 'TEncoding.DEFAULT'
              Items.Strings = (
                'TEncoding.DEFAULT'
                'TEncoding.ASCII.Encoding'
                'TEncoding.ANSI.Encoding'
                'TEncoding.UTF7.Encoding'
                'TEncoding.UTF8.Encoding'
                'TEncoding.Unicode.Encoding'
                'TEncoding.BigEndianUnicode.Encoding')
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'network settings'
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 593
    Width = 1100
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Button1: TButton
      Left = 952
      Top = 0
      Width = 136
      Height = 34
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 809
      Top = 0
      Width = 136
      Height = 34
      Caption = 'Save Settings '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ImageAlignment = iaRight
      ImageIndex = 0
      ParentFont = False
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object ImageList1: TImageList
    Left = 983
    Top = 166
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 983
    Top = 110
  end
end
