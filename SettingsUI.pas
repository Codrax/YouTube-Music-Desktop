unit SettingsUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, UITypes,
  Cod.SysUtils, Cod.Files, Cod.Windows, IOUtils, Vcl.ComCtrls;

type
  TSettingsForm = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    Label4: TLabel;
    CheckBox2: TCheckBox;
    Label5: TLabel;
    CheckBox3: TCheckBox;
    Label6: TLabel;
    Button2: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Button3: TButton;
    Label10: TLabel;
    Panel2: TPanel;
    Label11: TLabel;
    CheckBox4: TCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    CheckBox5: TCheckBox;
    Button4: TButton;
    Label15: TLabel;
    ListBox1: TListBox;
    Panel3: TPanel;
    Label16: TLabel;
    Button5: TButton;
    Button6: TButton;
    Label17: TLabel;
    Label18: TLabel;
    TrackBar1: TTrackBar;
    Label19: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateStartupFile;
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

uses
  MainUI;

{$R *.dfm}

procedure TSettingsForm.Button2Click(Sender: TObject);
begin
  ShellRun(DEVELOPER_URL, true);
end;

procedure TSettingsForm.Button3Click(Sender: TObject);
begin
  ShellRun(FEEDBACK_URL, true);
end;

procedure TSettingsForm.Button4Click(Sender: TObject);
begin
  TButton(Sender).Enabled := false;
  Application.ProcessMessages;
  try
    // Check
    MainForm.DoUpdateCheck(true);
  finally
    TButton(Sender).Enabled := true;
  end;
end;

procedure TSettingsForm.Button5Click(Sender: TObject);
begin
  if MessageDLG('Are you sure you want to remove all of the installed extensions of the web view? They will be re-installed from the Extensions folder in the apps directory', mtWarning, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  // Delete all
  MainForm.ResetExtensions;
end;

procedure TSettingsForm.Button6Click(Sender: TObject);
begin
  if MessageDLG('Are you sure you want to delete all your settings, preferences and reset the web view to default? This action once executed cannot be undone', mtWarning, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  // Close browser
  MainForm.Browser.CloseBrowserProcess;
  MainForm.Browser.Free;

  // Delete
  TDirectory.Delete(AppData, true);

  // Info
  MessageDLG('The application will now close to finalize the deletion process.', mtInformation, [mbOk], 0);

  Halt;
end;

procedure TSettingsForm.CheckBox1Click(Sender: TObject);
begin
  // File
  UpdateStartupFile;
end;

procedure TSettingsForm.CheckBox2Click(Sender: TObject);
begin
if not TWinControl(Sender).Focused then
    Exit;

  Settings.Put<boolean>('start-minimized', 'startup', TCheckBox(Sender).Checked);

  // File
  UpdateStartupFile;
end;

procedure TSettingsForm.CheckBox3Click(Sender: TObject);
begin
  if not TWinControl(Sender).Focused then
    Exit;

  Settings.Put<boolean>('minimize-to-tray', 'general', TCheckBox(Sender).Checked);
end;

procedure TSettingsForm.CheckBox4Click(Sender: TObject);
begin
  if not TWinControl(Sender).Focused then
    Exit;

  Settings.Put<boolean>('general', 'continue-playback', TCheckBox(Sender).Checked);
end;

procedure TSettingsForm.CheckBox5Click(Sender: TObject);
begin
  if not TWinControl(Sender).Focused then
    Exit;

  Settings.Put<boolean>('app', 'check-updates', TCheckBox(Sender).Checked);
end;

procedure TSettingsForm.FormCreate(Sender: TObject);
begin
  Label12.Caption := 'Version ' + VERSION.ToString;

  // Theme (must be after loading position)
  DarkModeApplyToWindow(Handle, true);

  // Load settings
  CheckBox2.Checked := Settings.Get<boolean>('start-minimized', 'startup', true);
  CheckBox3.Checked := Settings.Get<boolean>('minimize-to-tray', 'general', true);
  CheckBox4.Checked := Settings.Get<boolean>('general', 'continue-playback', true);
  CheckBox5.Checked := Settings.Get<boolean>('app', 'check-updates', true);
  TrackBar1.Position := round(Settings.Get<double>('accessibility', 'zoom', 1)*100);
end;

procedure TSettingsForm.TrackBar1Change(Sender: TObject);
begin
  Label19.Caption := TTrackBar(Sender).Position.ToString + '%';

  // Save
  if TTrackBar(Sender).Focused then begin
    const NewZoom = TTrackBar(Sender).Position / 100;
    Settings.Put<double>('accessibility', 'zoom', NewZoom);

    MainForm.Browser.ZoomFactor := NewZoom;
  end;
end;

procedure TSettingsForm.UpdateStartupFile;
var
  FilePath: string;
  Params: string;
begin
  FilePath := IncludeTrailingPathDelimiter(GetUserShellLocation(TUserShellLocation.Startup))
    + APP_NAME + '.lnk';

  // Check needs exist
  if not CheckBox1.Checked then begin
    if TFile.Exists(FilePath) then
      TFile.Delete(FilePath);

    Exit;
  end;

  // Create
  Params := '';
  if CheckBox2.Checked then
    Params := '-tray';

  CreateShortcut(Application.ExeName, FilePath, APP_NAME, Params);
end;

end.
