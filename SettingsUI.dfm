object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 461
  ClientWidth = 624
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
    Left = 24
    Top = 193
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
    Left = 48
    Top = 223
    Width = 250
    Height = 19
    AutoSize = False
    Caption = 'Minimize to tray when closed'
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 352
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
    Left = 352
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
    Left = 352
    Top = 150
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
    Left = 352
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
    Left = 48
    Top = 254
    Width = 250
    Height = 19
    AutoSize = False
    Caption = 'Continue playback after re-opening the app'
    Layout = tlCenter
  end
  object Panel1: TPanel
    Left = 0
    Top = 401
    Width = 624
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    Color = 1381653
    ParentBackground = False
    TabOrder = 0
    object Button1: TButton
      AlignWithMargins = True
      Left = 471
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
      ExplicitLeft = 456
      ExplicitTop = -24
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
    Left = 24
    Top = 224
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
    Left = 352
    Top = 186
    Width = 249
    Height = 56
    Caption = 'Official site'
    CommandLinkHint = 'Visit the official site'
    Style = bsCommandLink
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 352
    Top = 255
    Width = 249
    Height = 56
    Caption = 'Give feedback'
    CommandLinkHint = 'Leave feeedback on the repository'
    Style = bsCommandLink
    TabOrder = 5
    OnClick = Button3Click
  end
  object Panel2: TPanel
    Left = 291
    Top = 80
    Width = 1
    Height = 299
    BevelOuter = bvNone
    Color = 1381653
    ParentBackground = False
    TabOrder = 6
  end
  object CheckBox4: TCheckBox
    Left = 24
    Top = 255
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
    TabOrder = 7
    StyleElements = []
    OnClick = CheckBox4Click
  end
end
