unit MainUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.WebView2, Winapi.ActiveX,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, Vcl.Imaging.pngimage, Cod.Types,
  {Vcl.Edge, } Edge2, Cod.SysUtils, Cod.Files, Cod.Windows, Cod.Internet,
  Cod.IniSettings, Winapi.ShlObj, DateUtils, Cod.Version, Cod.StringUtils,
  SettingsUI, UITypes, IOUtils, System.SyncObjs, System.TimeSpan, JSON, Winapi.EdgeUtils,
  System.Win.TaskbarCore, Vcl.Taskbar, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, System.Generics.Collections;

const IID_ICoreWebView2EnvironmentOptions6: TGUID = '{57D29CC3-C84F-42A0-B0E2-EFFBD5E179DE}';

const
    WM_RESTOREAPPFROMTRAY = WM_USER + 100;

type
  ICoreWebView2EnvironmentOptions6 = interface(IUnknown)
    function Get_AreBrowserExtensionsEnabled(out IsVisible: Integer): HResult; stdcall;
    function Set_AreBrowserExtensionsEnabled(IsVisible: Integer): HResult; stdcall;
  end;

  // Define custom class
  TMainBrowser = class(TCustomEdgeBrowser)
  private
    type TScriptCallback = reference to procedure (Status: HResult; ResultObjectJSON: string);

    procedure HandleCreateWebViewCompleted(Sender: TCustomEdgeBrowser; AResult: HResult);
  protected
    procedure OpenDevTools;

    // Scripts
    procedure ExecuteScript(const JavaScript: string; Callback: TScriptCallback); overload;
    function ExecuteScriptAwait(const JavaScript: string; out Output: string; Timeout: cardinal=1000): boolean; overload;

  public
    constructor Create(AOwner: TComponent); override;
  end;

  TMainForm = class(TForm)
    TrayIcon: TTrayIcon;
    TrayMenu: TPopupMenu;
    ShowYouTubeMusic1: TMenuItem;
    MinimizetoTray1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    N2: TMenuItem;
    YourLibrary1: TMenuItem;
    Explore1: TMenuItem;
    N3: TMenuItem;
    Givefeedback1: TMenuItem;
    StartupLogo: TImage;
    DelayedUpdateCheck: TTimer;
    ErrorPane: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    BtAct_Refresh: TButton;
    BtAct_Reload: TButton;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    DebugPanel: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Button4: TButton;
    Button5: TButton;
    Label7: TLabel;
    Button6: TButton;
    Label8: TLabel;
    Edit1: TEdit;
    Button7: TButton;
    DebugStat: TTimer;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Panel2: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Button3: TButton;
    Label16: TLabel;
    Label17: TLabel;
    Button11: TButton;
    Edit2: TEdit;
    Button12: TButton;
    Label18: TLabel;
    StartURLLoader: TTimer;
    Settings1: TMenuItem;
    N4: TMenuItem;
    Taskbar1: TTaskbar;
    ActionList1: TActionList;
    ActionPlayPause: TAction;
    ActionPrev: TAction;
    ActionNext: TAction;
    PeriodicUpdaterTask: TTimer;
    Image1: TImage;
    ic_play: TImage;
    ic_pause: TImage;
    BtAct_Offline: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TrayIconDblClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure MinimizetoTray1Click(Sender: TObject);
    procedure ShowYouTubeMusic1Click(Sender: TObject);
    procedure YourLibrary1Click(Sender: TObject);
    procedure Explore1Click(Sender: TObject);
    procedure Givefeedback1Click(Sender: TObject);
    procedure BtAct_RefreshClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DelayedUpdateCheckTimer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure DebugStatTimer(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure StartURLLoaderTimer(Sender: TObject);
    procedure BtAct_ReloadClick(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure ActionPlayPauseExecute(Sender: TObject);
    procedure ActionPrevExecute(Sender: TObject);
    procedure ActionNextExecute(Sender: TObject);
    procedure PeriodicUpdaterTaskTimer(Sender: TObject);
    procedure BtAct_OfflineClick(Sender: TObject);
  protected
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMRestoreAppFromTray(var Message: TMessage); message WM_RESTOREAPPFROMTRAY;

    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;

  private
    procedure CloseProgram;

    // Extensions
    function ReadKnownExtensions: TArray<string>;
    procedure WriteKnownExtensions(AList: TArray<string>);

    // Tray
    procedure MinimizeToTray;
    procedure RestoreFromTray;

    // Update procs
    procedure UpdateTaskbarButtons;
    procedure UpdateNetworkState;

    // Window
    procedure CreateSystemMenu;

    // Forms
    procedure OpenSettingsForm;

    // Utils
    procedure ReloadWebViewBase;

    // Media
    function IsPlaying: boolean;
    procedure DoPlayPause;
    procedure DoPrev;
    procedure DoNext;

    // Browser
    procedure InitializeSite(FirstLoad: boolean=false);
    procedure WaitBrowserNavigation;
    procedure WaitBrowserInitialization;

    // Main
    procedure NavigateHome;

    // Events
    procedure BrowserExecuteScript(Sender: TCustomEdgeBrowser; AResult: HResult; const AResultObjectAsJson: string);
    procedure BrowserNavigationStarting(Sender: TCustomEdgeBrowser; Args: TNavigationStartingEventArgs);
    procedure BrowserNavigationCompleted(Sender: TCustomEdgeBrowser;
      IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);

    procedure CreatingWebViewFinalized(Sender: TCustomEdgeBrowser; AResult: HResult);
  public
    Browser: TMainBrowser;

    { Public declarations }
    InTray: boolean;

    // Extensions
    procedure ResetExtensions;

    // Update
    procedure DoUpdateCheck(NotifyStatus: boolean);
  end;

const
  VERSION: TVersion = (Major: 1; Minor: 2; Maintenance: 1);
  EXTENSIONS_VERSION: TVersion = (Major: 1; Minor: 1; Maintenance: 1); // change to re-install all extensions

  APP_NAME = 'YouTube Music Desktop';

  DEVELOPER_URL = 'https://www.codrutsoft.com/';
  FEEDBACK_URL = 'https://github.com/Codrax/YouTube-Music-Desktop';
  WEBSITE_APP_LINK = 'https://www.codrutsoft.com/apps/youtube-music-desktop/';

  APP_USER_MODEL_ID = 'com.codrutsoft.youtubemusicdesktop';

  // Menu (titlebar)
  MENU_ACTION = 999;
  MENU_ACTION_RELOAD = MENU_ACTION+1;
  MENU_ACTION_TRAY = MENU_ACTION+2;
  MENU_ACTION_SETTINGS = MENU_ACTION+3;

  // Links
  YTMUSIC_BASE_URL = 'https://music.youtube.com/';
  YTMUSIC_URL = YTMUSIC_BASE_URL;
  YTMUSIC_URL_LIBRARY = YTMUSIC_BASE_URL + 'library';
  YTMUSIC_URL_EXPLORE = YTMUSIC_BASE_URL + 'explore';

  // Dirs
  DIR_EXT = 'Extensions\';

  // Default
  HOME_URL = YTMUSIC_URL;

var
  MainForm: TMainForm;

  // System
  AppData: string;
  AppDir: string;
  Settings: TSettingsManager;
  Status: TSectionSettingsManager;

  DebugMode: boolean;
  AppInitialized: boolean;

  TaskbarPlayingState: boolean = false;

  // Browser
  BrowserInitialized: boolean;
  BrowserNavigating: boolean;

  // Utils
  StartURL: string;
  ShowWhenLoaded: boolean;
  InitializeWhenLoaded: boolean;

  // App state
  CurrentState: string;
  LastNetworkConnectedState: boolean = true;

implementation

{$R *.dfm}

procedure TMainForm.ActionNextExecute(Sender: TObject);
begin
  DoNext;
end;

procedure TMainForm.ActionPlayPauseExecute(Sender: TObject);
begin
  DoPlayPause;
end;

procedure TMainForm.ActionPrevExecute(Sender: TObject);
begin
  DoPrev;
end;

procedure TMainForm.BrowserExecuteScript(Sender: TCustomEdgeBrowser;
  AResult: HResult; const AResultObjectAsJson: string);
begin
  //
end;

procedure TMainForm.BrowserNavigationCompleted(Sender: TCustomEdgeBrowser;
  IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
begin
  CurrentState := 'Navigation done';

  BrowserNavigating := false;

  // Hidden
  if ShowWhenLoaded then begin
    ShowWhenLoaded := false;
    Browser.Align := alClient;
  end;

  // Init
  if InitializeWhenLoaded then begin
    AppInitialized := true;
    StartupLogo.Hide;
  end;

  // Error
  if not (WebErrorStatus in [COREWEBVIEW2_WEB_ERROR_STATUS_UNKNOWN, COREWEBVIEW2_WEB_ERROR_STATUS_CONNECTION_ABORTED]) then begin
    var S := '';
    case WebErrorStatus of
      COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_COMMON_NAME_IS_INCORRECT: S := 'CERTIFICATE_COMMON_NAME_IS_INCORRECT';
      COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_EXPIRED: S := 'CERTIFICATE_EXPIRED';
      COREWEBVIEW2_WEB_ERROR_STATUS_CLIENT_CERTIFICATE_CONTAINS_ERRORS: S := 'CLIENT_CERTIFICATE_CONTAINS_ERRORS';
      COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_REVOKED: S := 'CERTIFICATE_REVOKED';
      COREWEBVIEW2_WEB_ERROR_STATUS_CERTIFICATE_IS_INVALID: S := 'CERTIFICATE_IS_INVALID';
      COREWEBVIEW2_WEB_ERROR_STATUS_SERVER_UNREACHABLE: S := 'SERVER_UNREACHABLE';
      COREWEBVIEW2_WEB_ERROR_STATUS_TIMEOUT: S := 'TIMEOUT';
      COREWEBVIEW2_WEB_ERROR_STATUS_ERROR_HTTP_INVALID_SERVER_RESPONSE: S := 'ERROR_HTTP_INVALID_SERVER_RESPONSE';
      //COREWEBVIEW2_WEB_ERROR_STATUS_CONNECTION_ABORTED: S := 'CONNECTION_ABORTED';
      COREWEBVIEW2_WEB_ERROR_STATUS_CONNECTION_RESET: S := 'CONNECTION_RESET';
      COREWEBVIEW2_WEB_ERROR_STATUS_DISCONNECTED: S := 'DISCONNECTED';
      COREWEBVIEW2_WEB_ERROR_STATUS_CANNOT_CONNECT: S := 'CANNOT_CONNECT';
      COREWEBVIEW2_WEB_ERROR_STATUS_HOST_NAME_NOT_RESOLVED: S := 'HOST_NAME_NOT_RESOLVED';
      COREWEBVIEW2_WEB_ERROR_STATUS_OPERATION_CANCELED: S := 'OPERATION_CANCELED';
      COREWEBVIEW2_WEB_ERROR_STATUS_REDIRECT_FAILED: S := 'REDIRECT_FAILED';
      COREWEBVIEW2_WEB_ERROR_STATUS_UNEXPECTED_ERROR: S := 'UNEXPECTED_ERROR';
      COREWEBVIEW2_WEB_ERROR_STATUS_VALID_AUTHENTICATION_CREDENTIALS_REQUIRED: S := 'VALID_AUTHENTICATION_CREDENTIALS_REQUIRED';
      COREWEBVIEW2_WEB_ERROR_STATUS_VALID_PROXY_AUTHENTICATION_REQUIRED: S := 'VALID_PROXY_AUTHENTICATION_REQUIRED';
      else S := 'An unknown error has occured';
    end;

    // Error panel
    Browser.Hide;
    ErrorPane.Show;

    Label4.Caption := S;
  end else begin
    Browser.Show;
    ErrorPane.Hide;
  end;
end;

procedure TMainForm.BrowserNavigationStarting(Sender: TCustomEdgeBrowser;
  Args: TNavigationStartingEventArgs);
begin
  CurrentState := 'Navigating';

  BrowserNavigating := true;
end;

procedure TMainForm.Button10Click(Sender: TObject);
begin
  Browser.Navigate('about:blank');
end;

procedure TMainForm.Button11Click(Sender: TObject);
begin
  Browser.AddExtension( Edit2.Text );
end;

procedure TMainForm.Button12Click(Sender: TObject);
begin
  Browser.RemoveExtensionByName( Edit2.Text );
end;

procedure TMainForm.BtAct_OfflineClick(Sender: TObject);
begin
  InitializeSite;

  //
  StartURL := HOME_URL;
  StartURLLoader.Enabled := true;
end;

procedure TMainForm.BtAct_RefreshClick(Sender: TObject);
begin
  // Re-fresh
  Browser.Refresh;
end;

procedure TMainForm.BtAct_ReloadClick(Sender: TObject);
begin
  // Re-load
  ReloadWebViewBase
end;

procedure TMainForm.Button3Click(Sender: TObject);
var
  S: string;
  A: TArray<string>;
begin
  A := Browser.GetAllExtensions;
  for var P in A do
    S := S + P + #13;

  ShowMessage(S);
end;

procedure TMainForm.Button4Click(Sender: TObject);
begin
  Browser.Show;

  // Align
  Browser.Align := alClient;
end;

procedure TMainForm.Button5Click(Sender: TObject);
begin
  Browser.Hide;
end;

procedure TMainForm.Button6Click(Sender: TObject);
begin
  ErrorPane.Hide;
  StartupLogo.Hide;
end;

procedure TMainForm.Button7Click(Sender: TObject);
begin
  Browser.Navigate(Edit1.Text);
end;

procedure TMainForm.Button8Click(Sender: TObject);
begin
  NavigateHome;
end;

procedure TMainForm.Button9Click(Sender: TObject);
begin
  Browser.Refresh;
end;

procedure TMainForm.CloseProgram;
begin
  InTray := true; // to prevent mimimizing
  Close;
end;

procedure TMainForm.Givefeedback1Click(Sender: TObject);
begin
  ShellRun(FEEDBACK_URL, true);
end;

procedure TMainForm.InitializeSite;
begin
  CurrentState := 'Initializing browser...';

  // UI
  if not DebugMode then
    StartupLogo.Show;

  Browser.Show;
  ErrorPane.Hide;

  // Align
  if not DebugMode then begin
    Browser.Align := alNone;
    Browser.Width := ClientWidth;
    Browser.Height := ClientHeight;
    Browser.Top := -Browser.Height;
  end;

  BrowserInitialized := false;

  // Init
  Browser.ReinitializeWebView;
  Application.ProcessMessages;

  // Wait for initializaiton
  WaitBrowserInitialization;

  // Navigate
  Browser.Navigate('about:blank');
  WaitBrowserNavigation;
end;

function TMainForm.IsPlaying: boolean;
var
  S: string;
begin
  Browser.ExecuteScriptAwait('navigator.mediaSession.playbackState', S, 100);

  try
    S := S.TrimLeft(['"']).TrimRight(['"']);
    if (S = '') then
      Exit(false);

    Result := S = 'playing';
  except
    Exit(false);
  end;
end;

procedure TMainForm.CreateSystemMenu;
var
  HhMenu: HMENU;
procedure AddSeparator;
begin
  InsertMenu(HhMenu, 999   , MF_BYPOSITION or MF_SEPARATOR, 0, nil);
end;
procedure AddMenu(Name: string; id: integer);
begin
  InsertMenu(HhMenu, 999, MF_BYPOSITION, id, PChar(Name));
end;
begin
  // Get the handle to the system menu
  HhMenu := GetSystemMenu(Handle, False);

  // Item
  AddSeparator;
  AddMenu('Reload web view', MENU_ACTION_RELOAD);
  AddSeparator;
  AddMenu('Minimize to tray', MENU_ACTION_TRAY);
  AddMenu('Settings', MENU_ACTION_SETTINGS);
end;

procedure TMainForm.CreatingWebViewFinalized(Sender: TCustomEdgeBrowser;
  AResult: HResult);
begin
  // Initialized
  BrowserInitialized := true;

  // Context menu
  if not DebugMode then begin
    Browser.DefaultContextMenusEnabled := false;
    Browser.BuiltInErrorPageEnabled := false;
    Browser.DevToolsEnabled := false;
    Browser.StatusBarEnabled := false;
    Browser.ZoomControlEnabled := false;
  end else
    Browser.OpenDevTools;

  // Reset extensions
  if Settings.Get<string>('extension version', 'version', '') <> EXTENSIONS_VERSION.ToString then begin
    ResetExtensions;
    Settings.Put<string>('extension version', 'version', EXTENSIONS_VERSION.ToString);
  end;

  // Get settings
  Browser.ZoomFactor := Settings.Get<double>('zoom', 'accessibility', 1);

  // Get installed
  var Installed := ReadKnownExtensions;
  var ExtensionsChanged := false;

  // Get expected
  var ExtensionsFolders: TArray<string>;
  if TDirectory.Exists(AppDir + DIR_EXT) then
    ExtensionsFolders := TDirectory.GetDirectories(AppDir + DIR_EXT);
  var Expected: TArray<string>; Expected:=[];
    for var S in ExtensionsFolders do Expected := Expected + [ExtractFileName(S)];

  // Install all NEW extensions
  for var Dir in ExtensionsFolders do begin
    const ExtID = ExtractFileName(Dir);
    if not TArray.Contains<string>(Installed, ExtID) then begin
      Browser.AddExtension(Dir);

      Installed := Installed + [ExtID];
      ExtensionsChanged := true;
    end;
  end;

  // Remove all DELETED extensions
  var KeptExts: TArray<string>;
  for var ExtID in Installed do
    if not TArray.Contains<string>(Expected, ExtID) then begin
      Browser.RemoveExtensionById(ExtID);
    end else
      KeptExts := KeptExts + [ExtID];
  if Length(KeptExts) <> Length(Installed) then begin
    Installed := KeptExts;

    ExtensionsChanged := true;
  end;

  // Save list
  if ExtensionsChanged then
    WriteKnownExtensions(Installed);
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  CloseProgram;
end;

procedure TMainForm.Explore1Click(Sender: TObject);
begin
  Browser.Navigate(YTMUSIC_URL_EXPLORE);

  // Show
  RestoreFromTray;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if AppInitialized and not InTray and not DebugMode and Settings.Get<boolean>('minimize-to-tray', 'general', true) then begin
    MinimizeToTray;

    CanClose := false;
    Exit;
  end;

  // Save positions
  FormPositionSettings(Self, AppData+'form-pos.ini', false);

  // Last location
  var LastURL: string; LastURL := '';
  if Browser.LocationURL.StartsWith(YTMUSIC_BASE_URL) then
    LastURL := Browser.LocationURL;
  Settings.Put<string>('last-location', 'session', LastURL);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Dirs
  AppData := GetPathInAppData(APP_NAME, TAppDataType.Roaming);
  AppDir := IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));

  // UI
  FixDelphiXDialogs;

  // Settings
  Settings := TSettingsManager.Create(AppData + 'settings.ini');
  Status := TSectionSettingsManager.Create(AppData + 'status.ini', 'status');

  // Create system menu
  CreateSystemMenu;

  // Load form
  FormPositionSettings(Self, AppData+'form-pos.ini', true);

  // Theme (must be after loading position)
  DarkModeApplyToWindow(Handle, true);

  // Debug Mode
  if DebugMode then begin
    DebugPanel.BringToFront;
    DebugPanel.Show;
    DebugStat.Enabled := true;
    Label15.Caption := VERSION.ToString(true);
  end else begin
    DebugPanel.Destroy;
    DebugStat.Destroy;
  end;

  // Tasks
  DelayedUpdateCheck.Enabled := Settings.Get<boolean>('app', 'check-updates', true);

  // Player
  SetCurrentProcessExplicitAppUserModelID( APP_USER_MODEL_ID );

  // Browser
  Browser := TMainBrowser.Create(Self);

  Browser.Parent := Self;
  Browser.Align := alClient;
  Browser.SendToBack; // dev

  Browser.AreBrowserExtensionsEnabled := true;

  Browser.OnExecuteScript := BrowserExecuteScript;
  Browser.OnNavigationStarting := BrowserNavigationStarting;
  Browser.OnNavigationCompleted := BrowserNavigationCompleted;
  Browser.OnCreateWebViewCompleted := CreatingWebViewFinalized;

  const AppDataBrowser = AppData + 'Browser\';
  Browser.UserDataFolder := AppDataBrowser;

  // Init
  InitializeSite;

  // Init - Updates
  UpdateNetworkState;

  // Start URL
  StartURL := HOME_URL;
  if Settings.Get<boolean>('general', 'continue-playback', true) then begin
    const URL = Settings.Get<string>('last-location', 'session', '');

    // Nav
    if URL.StartsWith(YTMUSIC_BASE_URL) then
      StartURL := URL;
  end;

  if not GetNetworkConnected then // offline mode
    StartURL := HOME_URL;

  // Begin loading
  StartURLLoader.Enabled := true;
end;

procedure TMainForm.FormResize(Sender: TObject);
var
  Sz: integer;
begin
  // Size
  Sz := 2;

  if ClientHeight < 600 then
    Sz := 1;

  // UI
  if Sz = 1 then begin
    Panel1.Align := alTop;

    ErrorPane.Margins.Top := 15;
    ErrorPane.Margins.Right := 50;
    ErrorPane.Margins.Bottom := 15;
    ErrorPane.Margins.Left := 50;
  end
  else begin
    Panel1.Align := alBottom;

    ErrorPane.Margins.Top := 100;
    ErrorPane.Margins.Right := 100;
    ErrorPane.Margins.Bottom := 100;
    ErrorPane.Margins.Left := 100;
  end;
end;

procedure TMainForm.MinimizeToTray;
begin
  if InTray then
    Exit;
  InTray := true;

  // Set
  Hide;

  ShowYouTubeMusic1.Visible := true;
  MinimizetoTray1.Visible := false;
end;

procedure TMainForm.MinimizetoTray1Click(Sender: TObject);
begin
  MinimizeToTray;
end;

procedure TMainForm.NavigateHome;
begin
  // Navigate
  Browser.Navigate( HOME_URL );
end;

procedure TMainForm.OpenSettingsForm;
begin
  with TSettingsForm.Create(Self) do
    try
      // Show
      ShowModal;
    finally
      Free;
    end;
end;

function TMainForm.ReadKnownExtensions: TArray<string>;
begin
  Result := [];
  if TFile.Exists(AppData+'known-extensions.txt') then
    with TStringList.Create do
      try
        LoadFromFile(AppData+'known-extensions.txt');

        for var I := 0 to Count-1 do
          Result := Result + [Strings[I]];
      finally
        Free;
      end;
end;

procedure TMainForm.ReloadWebViewBase;
begin
  InitializeSite;

  //
  StartURL := HOME_URL;
  StartURLLoader.Enabled := true;
end;

procedure TMainForm.ResetExtensions;
begin
  Browser.DeleteAllExtensions;
  WriteKnownExtensions( [] );
end;

procedure TMainForm.RestoreFromTray;
begin
  if not InTray then
    Exit;
  InTray := false;

  // Set
  Show;

  ShowYouTubeMusic1.Visible := false;
  MinimizetoTray1.Visible := true;
end;

procedure TMainForm.Settings1Click(Sender: TObject);
begin
  OpenSettingsForm;
end;

procedure TMainForm.ShowYouTubeMusic1Click(Sender: TObject);
begin
  RestoreFromTray;
end;

procedure TMainForm.StartURLLoaderTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := false;

  // Default page
  InitializeWhenLoaded := true;
  ShowWhenLoaded := true;

  // Navigate
  Browser.Navigate( StartURL );
end;

procedure TMainForm.DebugStatTimer(Sender: TObject);
begin
  Label11.Caption := BooleanToString( BrowserNavigating );
  Label13.Caption := Browser.LocationURL;
  Label17.Caption := int64(Browser.LastErrorCode).ToString;
end;

procedure TMainForm.DelayedUpdateCheckTimer(Sender: TObject);
begin
  // Is in tray
  if InTray then
    Exit;

  // Disable self
  TTimer(Sender).Enabled := false;

  // Last check < a day ago
  const LastUpdateCheck = Status.Get<double>('last-update-check', 0);
  if (LastUpdateCheck <> 0) and (DaysBetween(Now, LastUpdateCheck) < 1) then
    Exit;

  // Write last update check
  Status.Put<double>('last-update-check', Now);

  // Update
  DoUpdateCheck(false);
end;

procedure TMainForm.DoNext;
begin
  Browser.ExecuteScript('document.querySelector(''yt-icon-button[title="Next"]'').click();');
end;

procedure TMainForm.DoPlayPause;
begin
  Browser.ExecuteScript('document.getElementById(''play-pause-button'').click()');

  // Sooner
  PeriodicUpdaterTask.Interval := 100;
end;

procedure TMainForm.DoPrev;
begin
  Browser.ExecuteScript('document.querySelector(''yt-icon-button[title="Previous"]'').click();');
end;

procedure TMainForm.DoUpdateCheck(NotifyStatus: boolean);
var
  Server: TVersion;
begin
  // Start update check
  try
    Server.APILoad('youtube-music-desktop', VERSION);

    if not Server.NewerThan(VERSION) then begin
      if NotifyStatus then
        MessageDLG('There are no new updates avalabile.', mtWarning, [mbOk], 0);
      Exit;
    end;

    // Alert user
    if MessageDLG('There is a new version of YouTube Music Desktop avalabile on the server. Do you wish to download It now? The app will close to update', mtWarning, [mbYes, mbNo], 0) <> mrYes then
      Exit;

    // Start download
    try
      const DownloadLink = Server.GetDownloadLink();
      const OutputFile = ReplaceWinPath(Format('%%TEMP%%\updateinstall_%S.exe', [
        GenerateString(8, [TStrGenFlag.UppercaseLetters, TStrGenFlag.LowercaseLetters, TStrGenFlag.Numbers])
        ]));
      DownloadFile(DownloadLink, OutputFile);

      // Run
      ShellRun( OutputFile, true, '-ad' );

      // Close
      Application.Terminate;
    except
      if MessageDLG('The download failed. Open the website?', mtWarning, [mbYes, mbNo], 0) <> mrYes then
        Exit;

      ShellRun(WEBSITE_APP_LINK, true);
    end;
  except
    // failure
  end;
end;

procedure TMainForm.PeriodicUpdaterTaskTimer(Sender: TObject);
begin
  if not Visible then Exit;

  // Reset interval
  TTimer(sender).Interval := 2000;

  // Update taskbar
  UpdateTaskbarButtons;

  // Check internet connectivity
  UpdateNetworkState;
end;

procedure TMainForm.TrayIconDblClick(Sender: TObject);
begin
  if InTray then
    RestoreFromTray
  else
    BringToTopAndFocusWindow(Handle);
end;

procedure TMainForm.UpdateNetworkState;
begin
  const State = GetNetworkConnected;
  if State <> LastNetworkConnectedState then begin
    if State then
      Caption := APP_NAME
    else
      Caption := APP_NAME + ' (Offline)';

    LastNetworkConnectedState := State;
  end;
end;

procedure TMainForm.UpdateTaskbarButtons;
var
  Playing: boolean;
begin
  try
    Playing := IsPlaying;
    if Playing = TaskbarPlayingState then
      Exit;

    // Set new icons
    const I = TIcon.Create;
    try
      if Playing then
        Taskbar1.TaskBarButtons[1].Icon.Assign( ic_pause.Picture.Icon )
      else
        Taskbar1.TaskBarButtons[1].Icon.Assign( ic_play.Picture.Icon );

      Taskbar1.ApplyButtonsChanges;
    finally
      I.Free;
    end;

    TaskbarPlayingState := Playing;
  except
  end;
end;

procedure TMainForm.WaitBrowserInitialization;
begin
  var I: integer; I := 0;
  while not BrowserInitialized and (I < 5000) do begin
      Sleep(1);
      Application.ProcessMessages;
  end;
end;

procedure TMainForm.WaitBrowserNavigation;
begin
  var I: integer; I := 0;
  while not BrowserNavigating and (I < 5000) do begin
      Sleep(1);
      Application.ProcessMessages;
  end;
end;

procedure TMainForm.WMActivate(var Msg: TWMActivate);
begin
  inherited;

  if (Msg.Active in [WA_ACTIVE, WA_CLICKACTIVE]) and not Msg.Minimized then
    try
      // Select webview
      if Browser.Visible then
        Browser.DoEnter;
        //Browser.SetFocus;
    except
    end;
end;

procedure TMainForm.WMRestoreAppFromTray(var Message: TMessage);
begin
  RestoreFromTray;
end;

procedure TMainForm.WMSysCommand(var Message: TWMSysCommand);
begin
  // Handle menus
  case Message.CmdType of
    MENU_ACTION_RELOAD: ReloadWebViewBase;
    MENU_ACTION_TRAY: MinimizeToTray;
    MENU_ACTION_SETTINGS: OpenSettingsForm;
  end;

  // Done
  inherited;
end;

procedure TMainForm.WriteKnownExtensions(AList: TArray<string>);
begin
  with TStringList.Create do
    try
      for var S in AList do
        Add(S);

      SaveToFile(AppData+'known-extensions.txt');
    finally
      Free;
    end;
end;

procedure TMainForm.YourLibrary1Click(Sender: TObject);
begin
  Browser.Navigate(YTMUSIC_URL_LIBRARY);

  // Show
  RestoreFromTray;
end;

{ TMainBrowser }

constructor TMainBrowser.Create(AOwner: TComponent);
begin
  inherited;
  OnCreateWebViewCompleted := HandleCreateWebViewCompleted;

  // Args
  AdditionalBrowserArguments := '--autoplay-policy=no-user-gesture-required';
end;

procedure TMainBrowser.ExecuteScript(const JavaScript: string;
  Callback: TScriptCallback);
begin
  if DefaultInterface <> nil then
    DefaultInterface.ExecuteScript(PChar(JavaScript),
      Callback<HResult, PChar>.CreateAs<ICoreWebView2ExecuteScriptCompletedHandler>(
        function(ErrorCode: HResult; ResultObjectAsJson: PWideChar): HResult stdcall
        begin
          Result := S_OK;

          Callback(ErrorCode, string(ResultObjectAsJson));
        end));
end;

function TMainBrowser.ExecuteScriptAwait(const JavaScript: string; out Output: string; Timeout: cardinal=1000): boolean;
var
  FWaiting: boolean;
  FResult: string;
begin
  const StartTime = Now;
  FWaiting := true;
  if DefaultInterface <> nil then
    DefaultInterface.ExecuteScript(PChar(JavaScript),
      Callback<HResult, PChar>.CreateAs<ICoreWebView2ExecuteScriptCompletedHandler>(
        function(ErrorCode: HResult; ResultObjectAsJson: PWideChar): HResult stdcall
        begin
          Result := S_OK;

          FResult := string(ResultObjectAsJson);
          FWaiting := false;
        end));

  // Wait
  while FWaiting do begin
    Sleep(10);
    Application.ProcessMessages;

    if MilliSecondsBetween(StartTime, Now) >= Timeout then
      Exit(false);
  end;

  // Done
  Output := FResult;
  Result := true;
end;

procedure TMainBrowser.HandleCreateWebViewCompleted(Sender: TCustomEdgeBrowser; AResult: HResult);
var
  View3: ICoreWebView2_13;
  Profile: ICoreWebView2Profile;
begin
  // Set dark mode
  if Assigned(DefaultInterface) then
    if Succeeded(DefaultInterface.QueryInterface(ICoreWebView2_13, View3)) then
      if Succeeded(View3.Get_Profile(Profile)) and Assigned(Profile) then
        if not Succeeded(Profile.Set_PreferredColorScheme( COREWEBVIEW2_PREFERRED_COLOR_SCHEME_DARK )) then
          OutputDebugString('Failed to set profile.');
end;

procedure TMainBrowser.OpenDevTools;
begin
  DefaultInterface.OpenDevToolsWindow;
end;

end.
