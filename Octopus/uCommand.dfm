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
  TextHeight = 17
  object Label1: TLabel
    Left = 3
    Top = 36
    Width = 253
    Height = 17
    Caption = 'Press the enter key to send it automatically '
  end
  object ComboBox1: TComboBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 631
    Height = 27
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
  end
  object Button1: TButton
    Left = 451
    Top = 33
    Width = 88
    Height = 25
    Caption = 'Send As Text'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 546
    Top = 33
    Width = 88
    Height = 25
    Caption = 'Send As Bytes'
    TabOrder = 2
    OnClick = Button2Click
  end
  object CheckBox100: TCheckBox
    Left = 270
    Top = 37
    Width = 166
    Height = 17
    Caption = 'Displays sending data'
    TabOrder = 3
    OnClick = CheckBox100Click
  end
end
