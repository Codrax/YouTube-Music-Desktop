unit SettingsUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Cod.SysUtils, Cod.Files, Cod.Windows, IOUtils;

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
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
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

procedure TSettingsForm.FormCreate(Sender: TObject);
begin
  // Theme (must be after loading position)
  DarkModeApplyToWindow(Handle, true);

  // Load settings
  CheckBox2.Checked := Settings.Get<boolean>('start-minimized', 'startup', true);
  CheckBox3.Checked := Settings.Get<boolean>('minimize-to-tray', 'general', true);
  CheckBox4.Checked := Settings.Get<boolean>('general', 'continue-playback', true);
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
