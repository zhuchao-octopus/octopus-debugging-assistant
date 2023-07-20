object CommandFrm: TCommandFrm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Quick Terminal Commands'
  ClientHeight = 63
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Default'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Label1: TLabel
    Left = 10
    Top = 36
    Width = 253
    Height = 17
    Caption = 'Press the enter key to send it automatically '
  end
  object ComboBox1: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 3
    Width = 617
    Height = 27
    Margins.Left = 10
    Margins.Right = 10
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #26032#23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = ComboBox1KeyPress
    Items.Strings = (
      'Control+C')
    ExplicitWidth = 585
  end
  object Button1: TButton
    Left = 450
    Top = 33
    Width = 85
    Height = 25
    Caption = 'Send As Text'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 542
    Top = 33
    Width = 85
    Height = 25
    Caption = 'Send As Byte'
    TabOrder = 2
    OnClick = Button2Click
  end
end
