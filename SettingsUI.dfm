object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 561
  ClientWidth = 944
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 126
    Height = 50
    Caption = 'Settings'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -37
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 96
    Width = 45
    Height = 17
    Caption = 'Startup'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 23
    Top = 186
    Width = 46
    Height = 17
    Caption = 'General'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 48
    Top = 118
    Width = 250
    Height = 19
    AutoSize = False
    Caption = 'Open at logon'
    Layout = tlCenter
  end
  object Label5: TLabel
    Left = 64
    Top = 151
    Width = 250
    Height = 19
    AutoSize = False
    Caption = 'Start minimized'
    Layout = tlCenter
  end
  object Label6: TLabel
    Left = 47
    Top = 216
    Width = 250
    Height = 19
    AutoSize = False
    Caption = 'Minimize to tray when closed'
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 664
    Top = 96
    Width = 38
    Height = 17
    Caption = 'About'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 664
    Top = 119
    Width = 193
    Height = 25
    Caption = 'YouTube Music Desktop'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 664
    Top = 148
    Width = 168
    Height = 20
    Caption = 'Made by Codrut Software'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 664
    Top = 326
    Width = 249
    Height = 35
    AutoSize = False
    Caption = 
      'This is an unofficial project, Codrut Software is unaffiliated w' +
      'ith Google LLC.'
    WordWrap = True
  end
  object Label11: TLabel
    Left = 47
    Top = 247
    Width = 250
    Height = 19
    AutoSize = False
    Caption = 'Continue playback after re-opening the app'
    Layout = tlCenter
  end
  object Label12: TLabel
    Left = 808
    Top = 167
    Width = 49
    Height = 13
    Alignment = taRightJustify
    Caption = 'Version x,x'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 24
    Top = 384
    Width = 68
    Height = 17
    Caption = 'Application'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object Label14: TLabel
    Left = 48
    Top = 406
    Width = 250
    Height = 19
    AutoSize = False
    Caption = 'Check for updates once every day'
    Layout = tlCenter
  end
  object Label15: TLabel
    Left = 352
    Top = 96
    Width = 118
    Height = 17
    Caption = 'Browser extensions'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object Label16: TLabel
    Left = 352
    Top = 263
    Width = 99
    Height = 17
    Caption = 'Troubleshooting'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object Label17: TLabel
    Left = 23
    Top = 287
    Width = 72
    Height = 17
    Caption = 'Accessibility'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object Label18: TLabel
    Left = 24
    Top = 310
    Width = 32
    Height = 15
    Caption = 'Zoom'
  end
  object Label19: TLabel
    Left = 263
    Top = 340
    Width = 28
    Height = 15
    Caption = '100%'
  end
  object Panel1: TPanel
    Left = 0
    Top = 501
    Width = 944
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    Color = 1381653
    ParentBackground = False
    TabOrder = 0
    object Button1: TButton
      AlignWithMargins = True
      Left = 791
      Top = 8
      Width = 133
      Height = 44
      Margins.Left = 20
      Margins.Top = 8
      Margins.Right = 20
      Margins.Bottom = 8
      Align = alRight
      Caption = 'Done'
      Default = True
      ModalResult = 1
      Style = bsCommandLink
      TabOrder = 0
    end
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 119
    Width = 275
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    StyleElements = []
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 40
    Top = 152
    Width = 275
    Height = 18
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 2
    StyleElements = []
    OnClick = CheckBox2Click
  end
  object CheckBox3: TCheckBox
    Left = 23
    Top = 217
    Width = 275
    Height = 18
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 3
    StyleElements = []
    OnClick = CheckBox3Click
  end
  object Button2: TButton
    Left = 664
    Top = 186
    Width = 249
    Height = 56
    Caption = 'Official site'
    CommandLinkHint = 'Visit the official site'
    Style = bsCommandLink
    TabOrder = 10
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 664
    Top = 255
    Width = 249
    Height = 56
    Caption = 'Give feedback'
    CommandLinkHint = 'Leave feeedback on the repository'
    Style = bsCommandLink
    TabOrder = 11
    OnClick = Button3Click
  end
  object Panel2: TPanel
    Left = 320
    Top = 80
    Width = 2
    Height = 400
    BevelOuter = bvNone
    Color = 1381653
    ParentBackground = False
    TabOrder = 12
  end
  object CheckBox4: TCheckBox
    Left = 23
    Top = 248
    Width = 275
    Height = 18
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 4
    StyleElements = []
    OnClick = CheckBox4Click
  end
  object CheckBox5: TCheckBox
    Left = 24
    Top = 407
    Width = 275
    Height = 18
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 5
    StyleElements = []
    OnClick = CheckBox5Click
  end
  object Button4: TButton
    Left = 24
    Top = 437
    Width = 275
    Height = 40
    Caption = 'Check for updates now'
    Style = bsCommandLink
    TabOrder = 6
    OnClick = Button4Click
  end
  object ListBox1: TListBox
    Left = 352
    Top = 127
    Width = 273
    Height = 130
    TabStop = False
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 21
    Items.Strings = (
      'uBlock Origin'
      'Adblocker'
      ''
      'ThemeSong for YouTube Music'#8482
      'Improved Visuals'
      'By Kris T')
    ParentColor = True
    ParentFont = False
    TabOrder = 7
  end
  object Panel3: TPanel
    Left = 640
    Top = 80
    Width = 2
    Height = 400
    BevelOuter = bvNone
    Color = 1381653
    ParentBackground = False
    TabOrder = 13
  end
  object Button5: TButton
    Left = 352
    Top = 286
    Width = 249
    Height = 69
    Caption = 'Remove all extensions'
    CommandLinkHint = 'Uninstall all extensions added to the web view'
    Style = bsCommandLink
    TabOrder = 8
    WordWrap = True
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 352
    Top = 361
    Width = 249
    Height = 84
    Caption = 'Reset settings to default'
    CommandLinkHint = 
      'Reset the application'#39's settings to default and delete all data.' +
      ' This will log you out and clear any preferences'
    Style = bsCommandLink
    TabOrder = 9
    WordWrap = True
    OnClick = Button6Click
  end
  object TrackBar1: TTrackBar
    Left = 24
    Top = 333
    Width = 233
    Height = 28
    Max = 400
    Min = 50
    Frequency = 50
    Position = 50
    TabOrder = 14
    OnChange = TrackBar1Change
  end
end
