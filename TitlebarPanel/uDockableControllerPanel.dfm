object FrmDockableController: TFrmDockableController
  Left = 0
  Top = 0
  Caption = 'FrmDockableController'
  ClientHeight = 545
  ClientWidth = 840
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 840
    Height = 545
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel6'
    TabOrder = 0
    object Notebook3: TNotebook
      Left = 0
      Top = 0
      Width = 840
      Height = 515
      Align = alClient
      PageIndex = 1
      TabOrder = 0
      object TPage
        Left = 0
        Top = 0
        HelpContext = 1
        Caption = #22359#21457#36865
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 834
          Height = 509
          Align = alClient
          BevelOuter = bvNone
          Color = clMenuBar
          ParentBackground = False
          TabOrder = 0
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 834
            Height = 509
            Align = alClient
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object Panel7: TPanel
              Left = 0
              Top = 0
              Width = 834
              Height = 438
              Align = alClient
              BevelOuter = bvNone
              ParentColor = True
              TabOrder = 0
              object Memo2: TMemo
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 828
                Height = 432
                Align = alClient
                BevelOuter = bvRaised
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ScrollBars = ssVertical
                ShowHint = False
                TabOrder = 0
              end
            end
            object Panel8: TPanel
              Left = 0
              Top = 438
              Width = 834
              Height = 71
              Align = alBottom
              BevelOuter = bvNone
              ParentBackground = False
              ParentColor = True
              TabOrder = 1
              object Button7: TButton
                Left = 0
                Top = 0
                Width = 78
                Height = 34
                Caption = #28165#31354
                TabOrder = 0
                OnClick = Button7Click
              end
              object Button8: TButton
                Left = 79
                Top = 0
                Width = 123
                Height = 34
                Caption = #21457#36865#25991#26412#20869#23481
                TabOrder = 1
              end
              object Button25: TButton
                Left = 0
                Top = 37
                Width = 834
                Height = 34
                Hint = #21435#25481#22810#20313#31354#26684#12289#36887#21495#12289'0x'#12289'0X'#20998#21106#31526#21495
                Align = alBottom
                Caption = #26684#24335#21270#21313#20845#36827#21046#25968#25454
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
              end
            end
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'Octopus '#21333#26465#21457#36865
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel12: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 834
          Height = 509
          Align = alClient
          BevelOuter = bvNone
          DoubleBuffered = True
          ParentBackground = False
          ParentDoubleBuffered = False
          TabOrder = 0
          object Panel4: TPanel
            Left = 0
            Top = 471
            Width = 834
            Height = 38
            Align = alBottom
            Alignment = taLeftJustify
            BevelOuter = bvNone
            ParentBackground = False
            ParentColor = True
            TabOrder = 0
            object Button1: TButton
              Left = 79
              Top = 3
              Width = 178
              Height = 34
              Caption = #24490#29615#21457#36865#36873#20013#30340#20869#23481
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object Button3: TButton
              Left = 0
              Top = 3
              Width = 78
              Height = 34
              Caption = #20572#27490#24490#29615
              TabOrder = 1
            end
          end
          object StringGrid1: TStringGrid
            Left = 0
            Top = 0
            Width = 834
            Height = 471
            Align = alClient
            DrawingStyle = gdsClassic
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goFixedColClick, goFixedRowDefAlign]
            TabOrder = 1
            OnDrawCell = StringGrid1DrawCell
            OnFixedCellClick = StringGrid1FixedCellClick
            OnKeyPress = StringGrid1KeyPress
            OnMouseDown = StringGrid1MouseDown
            OnSelectCell = StringGrid1SelectCell
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = #21327#35758#36716#25442
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel10: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 834
          Height = 509
          Align = alClient
          BevelOuter = bvNone
          Color = clMenuBar
          ParentBackground = False
          TabOrder = 0
          object Memo5: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 127
            Width = 828
            Height = 309
            Align = alClient
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object Panel16: TPanel
            Left = 0
            Top = 439
            Width = 834
            Height = 70
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object Button16: TButton
              Left = 79
              Top = 0
              Width = 122
              Height = 34
              Caption = #21457#36865#25991#26412#20869#23481
              TabOrder = 0
            end
            object Button27: TButton
              Left = 0
              Top = 0
              Width = 78
              Height = 34
              Caption = #28165#31354
              TabOrder = 1
            end
            object Button28: TButton
              Left = 0
              Top = 36
              Width = 834
              Height = 34
              Align = alBottom
              Caption = #21457#36865#25991#20214' ( *.bin  *.hex )'
              TabOrder = 2
            end
          end
          object Panel18: TPanel
            Left = 0
            Top = 0
            Width = 834
            Height = 124
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            object Label18: TLabel
              Left = 3
              Top = 102
              Width = 64
              Height = 17
              Caption = #25805#20316#31867#22411
            end
            object Label11: TLabel
              Left = 3
              Top = 72
              Width = 64
              Height = 17
              Caption = #35835#23383#33410#25968
            end
            object Label8: TLabel
              Left = 3
              Top = 42
              Width = 64
              Height = 17
              Caption = #22120#20214#22320#22336
            end
            object Label7: TLabel
              Left = 3
              Top = 13
              Width = 64
              Height = 17
              Caption = #36890#35759#21327#35758
            end
            object ComboBox12: TComboBox
              Left = 73
              Top = 96
              Width = 237
              Height = 25
              Style = csDropDownList
              ItemIndex = 1
              TabOrder = 0
              Text = 'Write'
              Items.Strings = (
                'Read'
                'Write'
                'Test Connection')
            end
            object ComboBox9: TComboBox
              AlignWithMargins = True
              Left = 73
              Top = 5
              Width = 237
              Height = 25
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 1
              Text = 'Octopus'
              Items.Strings = (
                'Octopus'
                'I2C'
                'SPI'
                'RS232'
                'RS485'
                'RS422'
                'CAN'
                'IRDA'
                'ZigBee'
                'Wireless'
                'ModBus')
            end
            object ComboBox10: TComboBox
              Left = 73
              Top = 34
              Width = 237
              Height = 25
              TabOrder = 2
              Text = '0x08000000'
              Items.Strings = (
                '0x08000000'
                '0x08002000')
            end
            object ComboBox11: TComboBox
              Left = 73
              Top = 66
              Width = 237
              Height = 25
              TabOrder = 3
              Text = '1'
            end
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'Graphic '
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel9: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 834
          Height = 509
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object GroupBox10: TGroupBox
            Left = 0
            Top = 0
            Width = 834
            Height = 509
            Align = alClient
            TabOrder = 0
            object CheckBox10: TCheckBox
              Left = 5
              Top = 69
              Width = 161
              Height = 25
              Caption = #22270#24418#36319#38543#21521#24038#28378#21160' '
              Checked = True
              State = cbChecked
              TabOrder = 0
            end
            object Button15: TButton
              Left = 4
              Top = 98
              Width = 308
              Height = 34
              Caption = #20840#23631#26174#31034#25152#26377#25968#25454
              TabOrder = 1
            end
            object Button18: TButton
              Left = 4
              Top = 170
              Width = 308
              Height = 34
              Caption = #25918#22823#22270#24418' ZOOM OUT'
              TabOrder = 2
            end
            object Button19: TButton
              Left = 4
              Top = 206
              Width = 308
              Height = 34
              Caption = #32553#23567#22270#24418' ZOOM IN'
              TabOrder = 3
            end
            object ButtonColor1: TButtonColor
              Left = 4
              Top = 242
              Width = 308
              Height = 34
              Caption = #35774#32622#22270#24418' 1 '#30340#39068#33394
              TabOrder = 4
            end
            object ButtonColor2: TButtonColor
              Left = 4
              Top = 278
              Width = 308
              Height = 34
              Caption = #35774#32622#22270#24418' 2 '#30340#39068#33394
              TabOrder = 5
            end
            object CheckBox11: TCheckBox
              Left = 169
              Top = 73
              Width = 137
              Height = 17
              Caption = #22270#24418#21472#21152#22312#19968#36215
              TabOrder = 6
            end
            object Button20: TButton
              Left = 4
              Top = 314
              Width = 308
              Height = 34
              Caption = #23558#25968#25454#23548#20986#21040'EXCEL'
              TabOrder = 7
            end
            object Button21: TButton
              Left = 4
              Top = 134
              Width = 308
              Height = 34
              Caption = #28165#38500#22270#34920#25968#25454
              TabOrder = 8
            end
            object Button22: TButton
              Left = 4
              Top = 351
              Width = 308
              Height = 34
              Caption = #23558#22270#24418#20445#23384#20026#22270#29255
              TabOrder = 9
            end
            object Panel15: TPanel
              Left = 4
              Top = 4
              Width = 308
              Height = 60
              BevelOuter = bvNone
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 10
              object Label16: TLabel
                Left = 2
                Top = 8
                Width = 18
                Height = 16
                Caption = 'X:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'TeamViewer13'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label17: TLabel
                Left = 2
                Top = 32
                Width = 27
                Height = 16
                Caption = 'Y: '
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'TeamViewer13'
                Font.Style = [fsBold]
                ParentFont = False
              end
            end
          end
        end
      end
    end
    object TabSet3: TTabSet
      Left = 0
      Top = 515
      Width = 840
      Height = 30
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      SelectedColor = clMenuHighlight
      SoftTop = True
      Style = tsModernTabs
      TabHeight = 30
      Tabs.Strings = (
        'Octopus '#33258#23450#20041#21457#36865
        #35774#32622)
      TabIndex = 0
      OnChange = TabSet3Change
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 276
    Top = 76
  end
end
