object SettingPagesDlg: TSettingPagesDlg
  Left = 195
  Top = 108
  BorderStyle = bsDialog
  Caption = #20843#29226#40060#36873#39033#35774#32622
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
        Caption = #20018#21475#35774#32622
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
            object Label3: TLabel
              Left = 8
              Top = 93
              Width = 152
              Height = 17
              Caption = #33258#21160#20445#23384#26102#38388#38388#38548#31186'  '
            end
            object Label1: TLabel
              Left = 8
              Top = 34
              Width = 147
              Height = 17
              Caption = #36879#26126#24230','#20540#36234#23567#36234#28165#29245
            end
            object Edit2: TEdit
              Left = 186
              Top = 31
              Width = 90
              Height = 25
              Color = clScrollBar
              ReadOnly = True
              TabOrder = 0
              Text = '238'
            end
            object UpDown2: TUpDown
              Left = 276
              Top = 31
              Width = 16
              Height = 25
              Associate = Edit2
              Min = 1
              Max = 255
              Position = 238
              TabOrder = 1
            end
            object UpDown5: TUpDown
              Left = 276
              Top = 90
              Width = 16
              Height = 25
              Associate = Edit3
              Min = 5
              Max = 32766
              Position = 10
              TabOrder = 2
            end
            object Edit3: TEdit
              Left = 186
              Top = 90
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
            object Button5: TButton
              Left = 204
              Top = 125
              Width = 97
              Height = 34
              Caption = #28165#38500#32531#23384
              TabOrder = 4
            end
            object Button6: TButton
              Left = 8
              Top = 125
              Width = 191
              Height = 34
              Caption = #25171#24320#26085#24535#21644#37197#32622#25991#20214#30446#24405
              TabOrder = 5
            end
            object CheckBox8: TCheckBox
              Left = 8
              Top = 63
              Width = 247
              Height = 20
              Caption = #25968#25454#33258#21160#20445#23384#21040#26412#22320#25991#20214
              TabOrder = 6
            end
            object CheckBox7: TCheckBox
              Left = 8
              Top = 5
              Width = 241
              Height = 20
              Caption = #31383#21475#32972#26223#21551#29992#36879#26126#25928#26524
              TabOrder = 7
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
              Width = 269
              Height = 20
              Caption = #22987#32456#20445#25345#22312#25152#26377#31383#21475#30340#26368#39030#23618
              TabOrder = 0
            end
            object CheckBox_DT: TCheckBox
              Left = 10
              Top = 34
              Width = 266
              Height = 20
              Caption = #21457#36865#21644#25509#25910#35760#24405#21069#38754#26174#31034#26102#38388#20449#24687
              TabOrder = 1
            end
            object CheckBox3: TCheckBox
              Left = 10
              Top = 61
              Width = 269
              Height = 20
              Caption = #21457#36865#21644#25509#25910#35760#24405#21069#38754#26174#31034#24180#26376#26085#26399
              TabOrder = 2
            end
            object CheckBox4: TCheckBox
              Left = 10
              Top = 89
              Width = 231
              Height = 20
              Caption = #25968#25454#35760#24405#21069#38754#26174#31034#34892#21495
              TabOrder = 3
            end
            object CheckBox5: TCheckBox
              Left = 10
              Top = 116
              Width = 231
              Height = 20
              Caption = #26174#31034#20018#21475#27491#22312#21457#36865#30340#25968#25454
              TabOrder = 4
            end
            object CheckBox1: TCheckBox
              Left = 10
              Top = 143
              Width = 191
              Height = 20
              Caption = #22312#26700#38754#21019#24314#24555#25463#26041#24335
              Checked = True
              Enabled = False
              State = cbChecked
              TabOrder = 5
            end
            object CheckBox6: TCheckBox
              Left = 10
              Top = 171
              Width = 258
              Height = 20
              Caption = 'Switch To English Language'
              Enabled = False
              TabOrder = 6
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
              Left = 76
              Top = 35
              Width = 224
              Height = 34
              Caption = #25171#24320#20018#21475
              ImageAlignment = iaRight
              ImageIndex = 0
              TabOrder = 2
              OnClick = Button2Click
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
            object Button4: TButton
              Left = 5
              Top = 35
              Width = 63
              Height = 34
              Caption = #26032#35774#22791
              TabOrder = 1
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
            object Label13: TLabel
              Left = 5
              Top = 170
              Width = 64
              Height = 17
              Hint = #21457#36865#25968#25454#30340#26684#24335'ASCI'#20026#23383#31526'HEX'#20026#21313#20845#36827#21046'CMD'#20026#25191#34892#26412#22320'Shell'#21629#20196
              Caption = #21457#36865#26684#24335
              ParentShowHint = False
              ShowHint = True
            end
            object Label15: TLabel
              Left = 5
              Top = 138
              Width = 64
              Height = 17
              Caption = #27969#25511#21046#31526
            end
            object Label5: TLabel
              Left = 5
              Top = 106
              Width = 64
              Height = 17
              Caption = #26657#39564#20301#25968
            end
            object Label9: TLabel
              Left = 5
              Top = 74
              Width = 64
              Height = 17
              Caption = #20572#27490#20301#25968
            end
            object Label12: TLabel
              Left = 5
              Top = 42
              Width = 64
              Height = 17
              Caption = #25968#25454#20301#25968
            end
            object Label2: TLabel
              Left = 5
              Top = 11
              Width = 64
              Height = 17
              Caption = #27874#29305#29575#25968
            end
            object Label10: TLabel
              Left = 5
              Top = 202
              Width = 64
              Height = 17
              Caption = #25509#25910#26684#24335
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
              Text = 'ASCII Format            '#23383#31526#20018
              Items.Strings = (
                'ASCII Format            '#23383#31526#20018
                'Hexadecimal Format '#21313#20845#36827#21046' '
                'Octopus Protocol      '#21327#35758' ')
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
            object Label4: TLabel
              Left = 5
              Top = 144
              Width = 164
              Height = 17
              Caption = #21313#20845#36827#21046#26174#31034#23545#40784#26041#24335' '
            end
            object Label6: TLabel
              Left = 5
              Top = 78
              Width = 192
              Height = 17
              Caption = #21457#36865#31471#23383#31526#38598#32534#30721#26684#24335#36873#25321
            end
            object Label7: TLabel
              Left = 5
              Top = 16
              Width = 192
              Height = 17
              Caption = #25509#21463#31471#23383#31526#38598#32534#30721#26684#24335#36873#25321
            end
            object Combobox_CodePage: TComboBox
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
            object ComboBox8: TComboBox
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
        Caption = #32593#32476#35774#32622
      end
      object TabSheet3: TTabSheet
        Caption = #39640#32423
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
    object OKBtn: TButton
      Left = 925
      Top = 1
      Width = 75
      Height = 34
      Caption = #36864#20986
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 1008
      Top = 1
      Width = 75
      Height = 34
      Cancel = True
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
    end
    object Button2: TButton
      Left = 842
      Top = 1
      Width = 75
      Height = 34
      Caption = #20445#23384#35774#32622
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ImageAlignment = iaRight
      ImageIndex = 0
      ParentFont = False
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object ImageList1: TImageList
    Left = 711
    Top = 54
  end
end
