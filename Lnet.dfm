object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 480
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 480
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 321
      Height = 74
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 0
      object Button1: TButton
        Left = 240
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 0
        OnClick = Button1Click
      end
    end
    object TreeView1: TTreeView
      Left = 0
      Top = 74
      Width = 321
      Height = 406
      Align = alClient
      Indent = 19
      TabOrder = 1
    end
    object Button2: TButton
      Left = 80
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Button2'
      DropDownMenu = PopupMenu1
      Style = bsSplitButton
      TabOrder = 2
    end
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 32
    Top = 400
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    Left = 32
    Top = 344
  end
  object PopupMenu1: TPopupMenu
    Left = 88
    Top = 208
    object fd1: TMenuItem
      Caption = 'fd'
    end
    object tt1: TMenuItem
      Caption = 'tt'
    end
  end
end
