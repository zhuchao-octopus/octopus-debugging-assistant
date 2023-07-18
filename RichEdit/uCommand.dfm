object CommandFrm: TCommandFrm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Quick Terminal Commands'
  ClientHeight = 39
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object ComboBox1: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 3
    Width = 464
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
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 789
  end
end
