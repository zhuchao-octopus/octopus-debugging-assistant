object DownloaderFrm: TDownloaderFrm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Downloader And Upgrade'
  ClientHeight = 379
  ClientWidth = 856
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Default'
  Font.Style = []
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 836
    Height = 359
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Upgrade'
      object Label1: TLabel
        Left = 761
        Top = 16
        Width = 66
        Height = 17
        Caption = '0%            '
      end
      object Label2: TLabel
        Left = 761
        Top = 44
        Width = 4
        Height = 17
      end
      object Label3: TLabel
        Left = 761
        Top = 72
        Width = 4
        Height = 17
      end
      object Label4: TLabel
        Left = 761
        Top = 100
        Width = 4
        Height = 17
      end
      object Label5: TLabel
        Left = 761
        Top = 128
        Width = 4
        Height = 17
      end
      object ProgressBar1: TProgressBar
        Left = 24
        Top = 13
        Width = 731
        Height = 22
        BarColor = clHighlight
        TabOrder = 0
      end
      object ButtonUpgrade: TButton
        Left = 672
        Top = 290
        Width = 137
        Height = 34
        Caption = 'Start Upgrading'
        TabOrder = 1
        OnClick = ButtonUpgradeClick
      end
      object Memo1: TMemo
        Left = 24
        Top = 156
        Width = 785
        Height = 125
        DoubleBuffered = True
        ParentDoubleBuffered = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 2
      end
      object ProgressBar2: TProgressBar
        Left = 24
        Top = 41
        Width = 731
        Height = 22
        BarColor = clLime
        TabOrder = 3
      end
      object ProgressBar3: TProgressBar
        Left = 24
        Top = 70
        Width = 731
        Height = 22
        BarColor = clAqua
        TabOrder = 4
      end
      object ProgressBar4: TProgressBar
        Left = 24
        Top = 98
        Width = 731
        Height = 22
        BarColor = clAqua
        TabOrder = 5
      end
      object ProgressBar5: TProgressBar
        Left = 24
        Top = 127
        Width = 731
        Height = 22
        TabOrder = 6
      end
      object Button1: TButton
        Left = 368
        Top = 296
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 7
        Visible = False
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 184
        Top = 296
        Width = 75
        Height = 25
        Caption = 'Button2'
        TabOrder = 8
        Visible = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Downloader'
      ImageIndex = 1
    end
  end
end
