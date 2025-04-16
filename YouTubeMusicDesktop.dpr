program YouTubeMusicDesktop;

uses
  Winapi.Windows,
  Winapi.Messages,
  Vcl.Forms,
  Cod.SysUtils,
  Cod.Windows,
  Cod.Instances,
  MainUI in 'MainUI.pas' {MainForm},
  SettingsUI in 'SettingsUI.pas' {SettingsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);

  // Instance
  SetSemaphore( APP_USER_MODEL_ID );

  InitializeInstance( true );
  if HasOtherInstance then begin
    if HasAppInfo then begin
      const Info = GetAppInfo;

      // Restore from tray
      SendMessage(Info.HWND, WM_RESTOREAPPFROMTRAY, 0, 0);
    end;

    Halt;
  end;

  if HasAppInfo then
    const Info = GetAppInfo;


  // Start hidden
  if HasParameter('tray') then begin
    Application.ShowMainForm := false;

    MainForm.InTray := true;
  end;

  // Enable tray
  MainForm.TrayIcon.Visible := true;

  // Run
  Application.Run;
end.
