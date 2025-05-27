{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2024 Embarcadero Technologies, Inc. }
{              All rights reserved                      }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Edge2;

interface

uses
  System.Classes, System.Win.ComObj, System.Generics.Collections, System.SyncObjs,
  Vcl.Controls, Winapi.Windows, Winapi.Messages, Winapi.WebView2, WebView2Extended;

type
  TCustomEdgeBrowser = class;

  // Microsoft's default implementation of ICoreWebView2EnvironmentOptions et al is in WebView2EnvironmentOptions.h
  TCoreWebView2EnvironmentOptionsExtended = class(TInterfacedObject, ICoreWebView2EnvironmentOptions, ICoreWebView2EnvironmentOptions6)
  private
    FAdditionalBrowserArguments: string;
    FLanguage: string;
    FTargetCompatibleBrowserVersion: string;
    FAllowSingleSignOnUsingOSPrimaryAccount: BOOL;
    FAreBrowserExtensionsEnabled: BOOL;
    class function AllocCOMString(const DelphiString: string): PChar; static;
    class function BOOLToInt(Value: BOOL): Integer; inline; static;
  public
    // ICoreWebView2EnvironmentOptions
    function Get_AdditionalBrowserArguments(out value: PWideChar): HResult; stdcall;
    function Set_AdditionalBrowserArguments(value: PWideChar): HResult; stdcall;
    function Get_Language(out value: PWideChar): HResult; stdcall;
    function Set_Language(value: PWideChar): HResult; stdcall;
    function Get_TargetCompatibleBrowserVersion(out value: PWideChar): HResult; stdcall;
    function Set_TargetCompatibleBrowserVersion(value: PWideChar): HResult; stdcall;
    function Get_AllowSingleSignOnUsingOSPrimaryAccount(out allow: Integer): HResult; stdcall;
    function Set_AllowSingleSignOnUsingOSPrimaryAccount(allow: Integer): HResult; stdcall;

    // ICoreWebView2EnvironmentOptions6
    function Get_AreBrowserExtensionsEnabled(out AreBrowserExtensionsEnabled: Integer): HResult; stdcall;
    function Set_AreBrowserExtensionsEnabled(AreBrowserExtensionsEnabled: Integer): HResult; stdcall;
  end;

  /// <summary>
  ///   Event handler type for the OnContainsFullScreenElementChanged event
  /// </summary>
  TContainsFullScreenElementChangedEvent = procedure (Sender: TCustomEdgeBrowser; ContainsFullScreenElement: Boolean) of object;
  // For C++Builder Classic compiler's benefit
  TUInt64 = type UInt64;
  /// <summary>
  ///   Event handler type for the OnContentLoading event
  /// </summary>
  TContentLoadingEvent = procedure (Sender: TCustomEdgeBrowser; IsErrorPage: Boolean; NavigationID: TUInt64) of object;
  /// <summary>
  ///   Event handler type for the OnDevToolsProtocolEventReceived event
  /// </summary>
  TDevToolsProtocolEventReceivedEvent = procedure (Sender: TCustomEdgeBrowser; const CDPEventName, AParameterObjectAsJson: string) of object;
  /// <summary>
  ///   Event handler type for the OnDocumentTitleChanged event
  /// </summary>
  TDocumentTitleChangedEvent = procedure (Sender: TCustomEdgeBrowser; const ADocumentTitle: string) of object;

  /// <summary>
  ///   Type to wrap the WebView ICoreWebView2DownloadStartingEventArgs interface for the OnDownloadStarting event
  /// </summary>
  TDownloadStartingEventArgs = class(TInterfacedObject, ICoreWebView2DownloadStartingEventArgs)
  private
    FArgsInterface: ICoreWebView2DownloadStartingEventArgs;
  public
    constructor Create(const Args: ICoreWebView2DownloadStartingEventArgs);
    property ArgsInterface: ICoreWebView2DownloadStartingEventArgs
      read FArgsInterface implements ICoreWebView2DownloadStartingEventArgs;
  end;
  /// <summary>
  ///   Event handler type for the OnDownloadStarting event
  /// </summary>
  TDownloadStartingEvent = procedure (Sender: TCustomEdgeBrowser; Args: TDownloadStartingEventArgs) of object;

  /// <summary>
  ///   Event handler type for the OnExecuteScript event
  /// </summary>
  TExecuteScriptEvent = procedure (Sender: TCustomEdgeBrowser; AResult: HResult; const AResultObjectAsJson: string) of object;
  /// <summary>
  ///   Event handler type for the OnDocumentTitleChanged event
  /// </summary>
  THistoryChangedEvent = procedure (Sender: TCustomEdgeBrowser) of object;

  /// <summary>
  ///   Type to wrap the WebView ICoreWebView2NavigationStartingEventArgs interface for the OnNavigationStarting and OnFrameNavigationStarting events
  /// </summary>
  TNavigationStartingEventArgs = class(TInterfacedObject, ICoreWebView2NavigationStartingEventArgs)
  private
    FArgsInterface: ICoreWebView2NavigationStartingEventArgs;
  public
    constructor Create(const Args: ICoreWebView2NavigationStartingEventArgs);
    property ArgsInterface: ICoreWebView2NavigationStartingEventArgs
      read FArgsInterface implements ICoreWebView2NavigationStartingEventArgs;
  end;
  /// <summary>
  ///   Event handler type for the OnNavigationStarting and OnFrameNavigationStarting events
  /// </summary>
  TNavigationStartingEvent = procedure (Sender: TCustomEdgeBrowser; Args: TNavigationStartingEventArgs) of object;
  /// <summary>
  ///   Event handler type for the OnNavigationCompleted and OnFrameNavigationCompleted events
  /// </summary>
  TNavigationCompletedEvent = procedure (Sender: TCustomEdgeBrowser; IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS) of object;

  /// <summary>
  ///   Type to wrap the WebView ICoreWebView2NewWindowRequestedEventArgs interface for the OnNewWindowRequested event
  /// </summary>
  TNewWindowRequestedEventArgs = class(TInterfacedObject, ICoreWebView2NewWindowRequestedEventArgs)
  private
    FArgsInterface: ICoreWebView2NewWindowRequestedEventArgs;
  public
    constructor Create(const Args: ICoreWebView2NewWindowRequestedEventArgs);
    property ArgsInterface: ICoreWebView2NewWindowRequestedEventArgs
      read FArgsInterface implements ICoreWebView2NewWindowRequestedEventArgs;
  end;
  /// <summary>
  ///   Event handler type for the OnNewWindowRequested event
  /// </summary>
  TNewWindowRequestedEvent = procedure (Sender: TCustomEdgeBrowser; Args: TNewWindowRequestedEventArgs) of object;

  /// <summary>
  ///   Type to wrap the WebView ICoreWebView2PermissionRequestedEventArgs interface for the OnPermissionRequested event
  /// </summary>
  TPermissionRequestedEventArgs = class(TInterfacedObject, ICoreWebView2PermissionRequestedEventArgs)
  private
    FArgsInterface: ICoreWebView2PermissionRequestedEventArgs;
  public
    constructor Create(const Args: ICoreWebView2PermissionRequestedEventArgs);
    property ArgsInterface: ICoreWebView2PermissionRequestedEventArgs
      read FArgsInterface implements ICoreWebView2PermissionRequestedEventArgs;
  end;
  /// <summary>
  ///   Event handler type for the OnPermissionRequested event
  /// </summary>
  TPermissionRequestedEvent = procedure (Sender: TCustomEdgeBrowser; Args: TPermissionRequestedEventArgs) of object;
  /// <summary>
  ///   Event handler type for the OnPrintCompleted event
  /// </summary>
  TPrintCompletedEvent = procedure (Sender: TCustomEdgeBrowser; ErrorCode: HResult; PrintStatus: COREWEBVIEW2_PRINT_STATUS) of object;
  /// <summary>
  ///   Event handler type for the OnPrintToPDFCompleted event
  /// </summary>
  TPrintToPDFCompletedEvent = procedure (Sender: TCustomEdgeBrowser; ErrorCode: HResult; IsSuccessful: Boolean) of object;
  /// <summary>
  ///   Event handler type for the OnProcessFailed event
  /// </summary>
  TProcessFailedEvent = procedure (Sender: TCustomEdgeBrowser; ProcessFailedKind: COREWEBVIEW2_PROCESS_FAILED_KIND) of object;

  /// <summary>
  ///   Type to wrap the WebView ICoreWebView2ScriptDialogOpeningEventArgs interface for the OnScriptDialogOpening event
  /// </summary>
  TScriptDialogOpeningEventArgs = class(TInterfacedObject, ICoreWebView2ScriptDialogOpeningEventArgs)
  private
    FArgsInterface: ICoreWebView2ScriptDialogOpeningEventArgs;
  public
    constructor Create(const Args: ICoreWebView2ScriptDialogOpeningEventArgs);
    property ArgsInterface: ICoreWebView2ScriptDialogOpeningEventArgs
      read FArgsInterface implements ICoreWebView2ScriptDialogOpeningEventArgs;
  end;
  /// <summary>
  ///   Event handler type for the OnScriptDialogOpening event
  /// </summary>
  TScriptDialogOpeningEvent = procedure (Sender: TCustomEdgeBrowser; Args: TScriptDialogOpeningEventArgs) of object;
  /// <summary>
  ///   Event handler type for the OnSourceChanged event
  /// </summary>
  TSourceChangedEvent = procedure (Sender: TCustomEdgeBrowser; IsNewDocument: Boolean) of object;
  /// <summary>
  ///   Event handler type for the OnCreateWebViewCompleted and OnCapturePreviewCompleted events
  /// </summary>
  TWebViewStatusEvent = procedure (Sender: TCustomEdgeBrowser; AResult: HResult) of object;

  /// <summary>
  ///   Type to wrap the WebView ICoreWebView2WebMessageReceivedEventArgs interface for the OnWebMessageReceived event
  /// </summary>
  TWebMessageReceivedEventArgs = class(TInterfacedObject, ICoreWebView2WebMessageReceivedEventArgs)
  private
    FArgsInterface: ICoreWebView2WebMessageReceivedEventArgs;
  public
    constructor Create(const Args: ICoreWebView2WebMessageReceivedEventArgs);
    property ArgsInterface: ICoreWebView2WebMessageReceivedEventArgs
      read FArgsInterface implements ICoreWebView2WebMessageReceivedEventArgs;
  end;
  /// <summary>
  ///   Event handler type for the OnWebMessageReceived event
  /// </summary>
  TWebMessageReceivedEvent = procedure (Sender: TCustomEdgeBrowser; Args: TWebMessageReceivedEventArgs) of object;

  /// <summary>
  ///   Type to wrap the WebView ICoreWebView2WebResourceRequestedEventArgs interface for the OnWebResourceRequested event
  /// </summary>
  TWebResourceRequestedEventArgs = class(TInterfacedObject, ICoreWebView2WebResourceRequestedEventArgs)
  private
    FArgsInterface: ICoreWebView2WebResourceRequestedEventArgs;
  public
    constructor Create(const Args: ICoreWebView2WebResourceRequestedEventArgs);
    property ArgsInterface: ICoreWebView2WebResourceRequestedEventArgs
      read FArgsInterface implements ICoreWebView2WebResourceRequestedEventArgs;
  end;
  /// <summary>
  ///   Event handler type for the OnWebResourceRequested event
  /// </summary>
  TWebResourceRequestedEvent = procedure (Sender: TCustomEdgeBrowser; Args: TWebResourceRequestedEventArgs) of object;
  /// <summary>
  ///   Event handler type for the OnZoomFactorChanged event
  /// </summary>
  TZoomFactorChangedEvent = procedure (Sender: TCustomEdgeBrowser; AZoomFactor: Double) of object;

  /// <summary>
  ///   VCL component base class to allow browsing by use of the Edge WebView2 browser control
  /// </summary>
  TCustomEdgeBrowser = class(TWinControl, ICoreWebView2PrintCompletedHandler, ICoreWebView2PrintToPdfCompletedHandler)
  public
    type
      /// <summary>
      ///   Enumerated type to represent the possible life cycle stages of the underlying Edge WebView control
      /// </summary>
      TBrowserControlState = (None, Creating, Created, Failed);
      /// <summary>
      ///   Enumerated type to represent the possible print dialog shown by ShowPrintUI
      /// </summary>
      TPrintUIDialogKind = (Browser, System);
  private
    FBrowserControlState: TBrowserControlState;
    FWebViewEnvironment: ICoreWebView2Environment;
    FWebViewController: ICoreWebView2Controller;
    FWebView: ICoreWebView2;
    FWebView4: ICoreWebView2_4;
    FCoreWebViewProfile: ICoreWebView2Profile;
    FCoreWebViewProfile7: ICoreWebView2Profile7;
    FWebViewSettings: ICoreWebView2Settings;
    FSizeRatio: Double;
    FLastErrorCode: HResult;
    FWebViewFocusEventActive: Boolean;
    FLastURI: string;
    FCritSec: TCriticalSection;
    FBrowserExecutableFolder: string;
    FUserDataFolder: string;
    FInternalClose: Boolean;
    FAdditionalBrowserArguments: string;
    FLanguage: string;
    FTargetCompatibleBrowserVersion: string;
    FAllowSingleSignOnUsingOSPrimaryAccount: Boolean;
    FAreBrowserExtensionsEnabled: Boolean;

    // WebView event tokens
    FAcceleratorKeyPressedToken: EventRegistrationToken;
    FContainsFullScreenElementChangedToken: EventRegistrationToken;
    FContentLoadingToken: EventRegistrationToken;
    FDocumentTitleChangedToken: EventRegistrationToken;
    FDownloadStartingToken: EventRegistrationToken;
    FFrameNavigationStartingToken: EventRegistrationToken;
    FFrameNavigationCompletedToken: EventRegistrationToken;
    FGotFocusToken: EventRegistrationToken;
    FHistoryChangedToken: EventRegistrationToken;
    FLostFocusToken: EventRegistrationToken;
    FMoveFocusRequestedToken: EventRegistrationToken;
    FNavigationStartingToken: EventRegistrationToken;
    FNavigationCompletedToken: EventRegistrationToken;
    FNewWindowRequestedToken: EventRegistrationToken;
    FPermissionRequestedToken: EventRegistrationToken;
    FProcessFailedToken: EventRegistrationToken;
    FScriptDialogOpeningToken: EventRegistrationToken;
    FSourceChangedToken: EventRegistrationToken;
    FWebResourceRequestedToken: EventRegistrationToken;
    FWebMessageReceivedToken: EventRegistrationToken;
    FWindowCloseRequestedToken: EventRegistrationToken;
    FZoomFactorChangedToken: EventRegistrationToken;
    FDevToolsProtocolEventReceivedTokenMap: TDictionary<string, EventRegistrationToken>;

    // Events
    FOnCapturePreviewCompleted: TWebViewStatusEvent;
    FOnContainsFullScreenElementChanged: TContainsFullScreenElementChangedEvent;
    FOnContentLoading: TContentLoadingEvent;
    FOnCreateWebViewCompleted: TWebViewStatusEvent;
    FOnDevToolsProtocolEventReceived: TDevToolsProtocolEventReceivedEvent;
    FOnDocumentTitleChanged: TDocumentTitleChangedEvent;
    FOnDownloadStarting: TDownloadStartingEvent;
    FOnExecuteScript: TExecuteScriptEvent;
    FOnFrameNavigationStarting: TNavigationStartingEvent;
    FOnFrameNavigationCompleted: TNavigationCompletedEvent;
    FOnHistoryChanged: THistoryChangedEvent;
    FOnNavigationStarting: TNavigationStartingEvent;
    FOnNavigationCompleted: TNavigationCompletedEvent;
    FOnNewWindowRequested: TNewWindowRequestedEvent;
    FOnPermissionRequested: TPermissionRequestedEvent;
    FOnPrintCompleted: TPrintCompletedEvent;
    FOnPrintToPDFCompleted: TPrintToPDFCompletedEvent;
    FOnProcessFailed: TProcessFailedEvent;
    FOnScriptDialogOpening: TScriptDialogOpeningEvent;
    FOnSourceChanged: TSourceChangedEvent;
    FOnWebMessageReceived: TWebMessageReceivedEvent;
    FOnWebResourceRequested: TWebResourceRequestedEvent;
    FOnWindowCloseRequested: TNotifyEvent;
    FOnZoomFactorChanged: TZoomFactorChangedEvent;
    function CreateEnvironmentCompleted(AResult: HResult; const AEnvironment: ICoreWebView2Environment): HResult; stdcall;
    function CreateCoreWebView2ControllerCompleted(AResult: HResult; const ACreatedController: ICoreWebView2Controller): HResult; stdcall;
    function GetBrowserProcessID: DWORD;
    function GetBrowserVersionInfo: string;
    function GetCanGoBack: Boolean;
    function GetCanGoForward: Boolean;
    function GetContainsFullScreenElement: Boolean;
    function GetDocumentTitle: string;
    function GetLocationURL: string;
    function GetWebViewCreated: Boolean;
    function GetZoomFactor: Double;
    function ProcessHResult(AHResult: HResult): Boolean;
    procedure SetSizeRatio(const Value: Double);
    procedure SetZoomFactor(const Value: Double);

    // WebView2 settings property getters/setters
    function GetBuiltInErrorPageEnabled: Boolean;
    function GetDefaultContextMenusEnabled: Boolean;
    function GetDefaultScriptDialogsEnabled: Boolean;
    function GetDevToolsEnabled: Boolean;
    function GetScriptEnabled: Boolean;
    function GetStatusBarEnabled: Boolean;
    function GetWebMessageEnabled: Boolean;
    function GetZoomControlEnabled: Boolean;
    procedure SetBuiltInErrorPageEnabled(const Value: Boolean);
    procedure SetDefaultContextMenusEnabled(const Value: Boolean);
    procedure SetDefaultScriptDialogsEnabled(const Value: Boolean);
    procedure SetDevToolsEnabled(const Value: Boolean);
    procedure SetScriptEnabled(const Value: Boolean);
    procedure SetStatusBarEnabled(const Value: Boolean);
    procedure SetWebMessageEnabled(const Value: Boolean);
    procedure SetZoomControlEnabled(const Value: Boolean);

    procedure WaitForWebViewEvent(var EndSignal: boolean; Timeout: integer=-1);

    // Implemented interface methods

    function ICoreWebView2PrintCompletedHandler.Invoke = ICoreWebView2PrintCompletedHandlerInvoke;
    function ICoreWebView2PrintCompletedHandlerInvoke(errorCode: HResult; printStatus: COREWEBVIEW2_PRINT_STATUS): HResult; stdcall;
    function ICoreWebView2PrintToPdfCompletedHandler.Invoke = ICoreWebView2PrintToPdfCompletedHandlerInvoke;
    function ICoreWebView2PrintToPdfCompletedHandlerInvoke(errorCode: HResult; isSuccessful: Integer): HResult; stdcall;
  protected
    procedure InitializeWebView;
    procedure CreateWnd; override;
    procedure DoEnter; override;
    procedure Resize; override;
    procedure CMSysCommand(var &Message: TWMSysCommand); message CM_SYSCOMMAND;
    procedure CMParentVisibleChanged(var &Message: TMessage); message CM_PARENTVISIBLECHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // Extensions
    procedure AddExtension(ExtensionDirectoryPath: string);
    procedure RemoveExtensionByName(ExtensionName: string);
    procedure RemoveExtensionById(ExtensionName: string);
    procedure DeleteAllExtensions;
    function GetAllExtensions: TArray<string>;
    function GetAllExtensionIDs: TArray<string>;

    /// <summary>
    ///   Adds a URI and resource context filter to the OnWebResourceRequested event
    /// </summary>
    procedure AddWebResourceRequestedFilter(const URL: string; ResourceContext: COREWEBVIEW2_WEB_RESOURCE_CONTEXT);
    type
      /// <summary>
      ///   The image format in which to save the captured preview (screenshot)
      /// </summary>
      TPreviewFormat = (PNG, JPEG);
    /// <summary>
    ///   Capture an image of what the WebView control is displaying and save it in a file of a specified image format
    /// </summary>
    procedure CapturePreview(const AFilename: string; PreviewFormat: TPreviewFormat = PNG); overload;
    /// <summary>
    ///   Capture an image of what the WebView control is displaying and write it to a stream
    /// </summary>
    procedure CapturePreview(Stream: TStream; PreviewFormat: TPreviewFormat = PNG); overload;
    /// <summary>
    ///   Creates a print settings object for Print and printToPDF
    /// </summary>
    function CreatePrintSettings: ICoreWebView2PrintSettings;
    /// <summary>
    ///   Starts the asynchronous exercise of creating the WebView control. Use the OnCreateWebViewCompleted event to
    ///   be notified of successful or unsuccessful completion.
    /// </summary>
    procedure CreateWebView;
    /// <summary>
    ///   Close down the current WebView control
    /// </summary>
    procedure CloseWebView;
    /// <summary>
    ///   Close down the current WebView control and ensure its process exits (either of its own accord within 2
    ///   seconds, otherwise by force)
    /// </summary>
    procedure CloseBrowserProcess;
    /// <summary>
    ///   Execute JavaScript code from the javascript parameter in the current top level document rendered in the
    ///   WebView, even if ScriptEnabled is False
    /// </summary>
    procedure ExecuteScript(const JavaScript: string);
    /// <summary>
    ///   Navigates to the previous page in the navigation history
    /// </summary>
    procedure GoBack;
    /// <summary>
    ///   Navigates to the next page in the navigation history
    /// </summary>
    procedure GoForward;
    /// <summary>
    ///   Cause a navigation of the top level document to the specified URI. If the underlying WebView2 control
    ///   has not yet been created then this call will initiate creation and then navigate to the URI.
    /// </summary>
    function Navigate(const AUri: string): Boolean;
    /// <summary>
    ///   Initiates a navigation to AHTMLContent as source HTML of a new document
    /// </summary>
    function NavigateToString(const AHTMLContent: string): Boolean;
    /// <summary>
    ///   Lets you provide post data or additional request headers during navigation. The headers in ARequest
    ///   override headers added by the WebView2 runtime except for Cookie headers.
    ///   The web resource request method must be GET or POST.
    ///   Any post data will be sent only if the method is POST and the URI scheme is HTTP or HTTPS
    /// </summary>
    function NavigateWithWebResourceRequest(const ARequest: ICoreWebView2WebResourceRequest): Boolean;
    /// <summary>
    ///   Print the current web page asynchronously to the specified printer with the provided settings
    /// </summary>
    function Print(const PrintSettings: ICoreWebView2PrintSettings): Boolean;
    /// <summary>
    ///   Print the current page to PDF asynchronously with the provided settings
    /// </summary>
    function PrintToPDF(const ResultFilePath: string; const PrintSettings: ICoreWebView2PrintSettings): Boolean;
    /// <summary>
    ///   Opens the print dialog to print the current web page, where the parameter lets
    ///   you choose between the browser print preview dialog and the system print dialog
    /// </summary>
    function ShowPrintUI(PrintUIDialogKind: TPrintUIDialogKind): Boolean;
    /// <summary>
    ///   Close down the current WebView control and initialise a new one
    /// </summary>
    procedure ReinitializeWebView;
    /// <summary>
    ///   Close down the current WebView control along with the browser process behind it and initialise a new one
    /// </summary>
    procedure ReinitializeWebViewWithNewBrowser;
    /// <summary>
    ///   Reload the current page
    /// </summary>
    procedure Refresh;
    /// <summary>
    ///   Removes a matching WebResource filter that was previously added for the OnWebResourceRequested event
    /// </summary>
    procedure RemoveWebResourceRequestedFilter(const URL: string; ResourceContext: COREWEBVIEW2_WEB_RESOURCE_CONTEXT);
    /// <summary>
    ///   Gives the input focus to the browser control if it has been created.
    /// </summary>
    procedure SetFocus; override;
    /// <summary>
    ///   Stop all navigations and pending resource fetches
    /// </summary>
    procedure Stop;
    /// <summary>
    ///   Subscribe to a Chrome DevTools Protocol event
    /// </summary>
    /// <remarks>
    ///   See <see href="https://chromedevtools.github.io/devtools-protocol/tot/" />
    /// </remarks>
    procedure SubscribeToCDPEvent(const CDPEventName: string);

    /// <summary>
    ///   Indicates which place in the life cycle the underlying WebView control is at
    /// </summary>
    property BrowserControlState: TBrowserControlState read FBrowserControlState;
    /// <summary>
    ///   Browser version info including channel name if it is not the stable channel
    /// </summary>
    property BrowserVersionInfo: string read GetBrowserVersionInfo;
    /// <summary>
    ///   Returns the underlying process ID of the Edge browser if the WebView control has been set up, otherwise 0
    /// </summary>
    property BrowserProcessID: DWORD read GetBrowserProcessID;
    /// <summary>
    ///   Returns the underlying ICoreWebView2 interface if the WebView control has been set up, otherwise nil
    /// </summary>
    property DefaultInterface: ICoreWebView2 read FWebView;
    /// <summary>
    ///   Returns the underlying ICoreWebView2Controller interface if the WebView control has been set up, otherwise nil
    /// </summary>
    property ControllerInterface: ICoreWebView2Controller read FWebViewController;
    /// <summary>
    ///   Returns the underlying ICoreWebView2Environment interface if the WebView control has been set up, otherwise
    ///   nil
    /// </summary>
    property EnvironmentInterface: ICoreWebView2Environment read FWebViewEnvironment;
    /// <summary>
    ///   Returns the underlying ICoreWebView2Settings interface if the WebView control has been set up, otherwise nil
    /// </summary>
    property SettingsInterface: ICoreWebView2Settings read FWebViewSettings;
    /// <summary>
    ///   If set this specifies the location of msedgewebview2.exe, used with WebView2 Fixed Version Distribution mode:
    ///   https://docs.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution#fixed-version-distribution-mode
    ///   The value can contain environment variables surrounded by % signs, e.g. %LOCALAPPDATA%.
    ///   If not set this defaults to looking for an installed version of the WebView2 runtime or alternatively an
    ///   installation of Edge Canary.
    ///   Note that setting this property affects the next creation of the underlying WebView2 control. If this
    ///   component has already created a WebView2 control then setting this property will have no effect unless the
    ///   WebView2 control gets recreated (e.g. by ReinitializeWebView or ReinitializeWebViewWithNewBrowser).
    ///   If the path contains \Edge\Application\ then the WebView2 creation will fail.
    /// </summary>
    property BrowserExecutableFolder: string read FBrowserExecutableFolder write FBrowserExecutableFolder;
    /// <summary>
    ///   If set this specifies the location of the user data folder, where Edge/WebView2 stores e.g. cookies,
    ///   permissions and cached resources.
    ///   The value can contain environment variables surrounded by % signs, e.g. %LOCALAPPDATA%.
    ///   If not set this defaults to the folder {your_exe_name}.WebView2 in the local app data folder.
    ///   If folder creation permission is not available to the process where the user data folder needs to be created
    ///   then the creation of the underlying WebView2 control can fail.
    ///   The application will need to take responsibility for cleaning up the user data folder when it is no longer
    ///   required.
    ///   Note that setting this property affects the next creation of the underlying WebView2 control. If this
    ///   component has already created a WebView2 control then setting this property will have no effect unless the
    ///   WebView2 control gets recreated (e.g. by ReinitializeWebView or ReinitializeWebViewWithNewBrowser).
    /// </summary>
    property UserDataFolder: string read FUserDataFolder write FUserDataFolder;
    /// <summary>
    ///   Can we navigate to a previous page in the navigation history?
    /// </summary>
    property CanGoBack: Boolean read GetCanGoBack;
    /// <summary>
    ///   Can we navigate to a next page in the navigation history?
    /// </summary>
    property CanGoForward: Boolean read GetCanGoForward;
    /// <summary>
    ///   Indicates if the WebView contains a fullscreen HTML element
    /// </summary>
    property ContainsFullScreenElement: Boolean read GetContainsFullScreenElement;
    /// <summary>
    ///   The title for the current top level document
    /// </summary>
    property DocumentTitle: string read GetDocumentTitle;
    /// <summary>
    ///   The HResult code of the last internal WebView2 operation
    /// </summary>
    property LastErrorCode: HResult read FLastErrorCode;
    /// <summary>
    ///   The URI of the current top level document
    /// </summary>
    property LocationURL: string read GetLocationURL;
    /// <summary>
    ///   The size ratio for the WebView
    /// </summary>
    property SizeRatio: Double read FSizeRatio write SetSizeRatio;
    /// <summary>
    ///   Indicates if the WebView control has been created
    /// </summary>
    property WebViewCreated: Boolean read GetWebViewCreated;
    /// <summary>
    ///   The zoom factor for the WebView
    /// </summary>
    property ZoomFactor: Double read GetZoomFactor write SetZoomFactor;

    // WebView2 creation environment options

    /// <summary>
    ///   Command-line arguments passed to the browser process to change its behaviour. These are
    ///   Chromium command line switches to use during browser construction in a space-separated string,
    ///   e.g. for a proxy server and show a startup browser dialog:
    ///     --proxy-server=http://1.2.3.4:8888 --browser-startup-dialog
    ///   e.g. to run browser diagnostics:
    ///     --diagnostics
    /// </summary>
    /// <remarks>
    ///   For information on Chromium command-line switches see:
    ///   https://www.chromium.org/developers/how-tos/run-chromium-with-flags
    /// </remarks>
    property AdditionalBrowserArguments: string read FAdditionalBrowserArguments write FAdditionalBrowserArguments;
    /// <summary>
    ///   Enable single sign on with Azure Active Directory (AAD) and personal Microsoft Account (MSA) resources inside
    ///   WebView
    /// </summary>
    property AllowSingleSignOnUsingOSPrimaryAccount: Boolean read FAllowSingleSignOnUsingOSPrimaryAccount write FAllowSingleSignOnUsingOSPrimaryAccount;
    /// <summary>
    ///   Enable extensions support in the WebView.
    /// </summary>
    property AreBrowserExtensionsEnabled: Boolean read FAreBrowserExtensionsEnabled write FAreBrowserExtensionsEnabled;
    /// <summary>
    ///   The default display language for WebView.
    ///   It is in the format of language[-country] where language is the 2-letter code from ISO 639
    ///   and country is the 2-letter code from ISO 3166
    /// </summary>
    property Language: string read FLanguage write FLanguage;
    /// <summary>
    ///   The version of the WebView2 Runtime binaries required to be compatible with your app.
    ///   This is in the same format as the BrowserVersionInfo property.
    ///   The version of the WebView2 Runtime binaries actually used may be different from the specified
    ///   TargetCompatibleBrowserVersion. Verify the actual version using the BrowserVersionInfo property.
    /// </summary>
    /// <remarks>
    ///   Defaults to '117.0.2045.28', the minimum version for WebView2 SDK 1.0.2045.28, the SDK imported into
    ///   RAD Studio 12.0
    /// </remarks>
    property TargetCompatibleBrowserVersion: string read FTargetCompatibleBrowserVersion write FTargetCompatibleBrowserVersion;

    // WebView2 settings - these properties cause an exception if the WebView control has not yet been instantiated

    /// <summary>
    ///   Used to disable built in error page for navigation failure and render process failure.
    /// </summary>
    /// <remarks>
    ///   Causes an exception if the WebView control has not yet been instantiated
    /// </remarks>
    property BuiltInErrorPageEnabled: Boolean read GetBuiltInErrorPageEnabled write SetBuiltInErrorPageEnabled;
    /// <summary>
    ///   Controls whether default context menus will be shown to user in WebView
    /// </summary>
    /// <remarks>
    ///   Causes an exception if the WebView control has not yet been instantiated
    /// </remarks>
    property DefaultContextMenusEnabled: Boolean read GetDefaultContextMenusEnabled write SetDefaultContextMenusEnabled;
    /// <summary>
    ///   Controls whether OnScriptDialogOpening will fire when a JavaScript dialog shows
    /// </summary>
    /// <remarks>
    ///   Causes an exception if the WebView control has not yet been instantiated
    /// </remarks>
    property DefaultScriptDialogsEnabled: Boolean read GetDefaultScriptDialogsEnabled write SetDefaultScriptDialogsEnabled;
    /// <summary>
    ///   Controls whether the user is able to use the context menu or keyboard shortcuts to open the DevTools window
    /// </summary>
    /// <remarks>
    ///   Causes an exception if the WebView control has not yet been instantiated
    /// </remarks>
    property DevToolsEnabled: Boolean read GetDevToolsEnabled write SetDevToolsEnabled;
    /// <summary>
    ///   Controls if JavaScript execution is enabled in all future navigations in the WebView
    /// </summary>
    /// <remarks>
    ///   Causes an exception if the WebView control has not yet been instantiated
    /// </remarks>
    property ScriptEnabled: Boolean read GetScriptEnabled write SetScriptEnabled;
    /// <summary>
    ///   Controls whether the status bar will be displayed
    /// </summary>
    /// <remarks>
    ///   Causes an exception if the WebView control has not yet been instantiated
    /// </remarks>
    property StatusBarEnabled: Boolean read GetStatusBarEnabled write SetStatusBarEnabled;
    /// <summary>
    ///   Controls whether WebMessages will be received when loading a new HTML document
    /// </summary>
    /// <remarks>
    ///   Causes an exception if the WebView control has not yet been instantiated
    /// </remarks>
    property WebMessageEnabled: Boolean read GetWebMessageEnabled write SetWebMessageEnabled;
    /// <summary>
    ///   Controls whether the user can impact the zoom of the WebView.
    /// </summary>
    /// <remarks>
    ///   Causes an exception if the WebView control has not yet been instantiated
    /// </remarks>
    property ZoomControlEnabled: Boolean read GetZoomControlEnabled write SetZoomControlEnabled;

    // WebView2 events

    property OnCapturePreviewCompleted: TWebViewStatusEvent read FOnCapturePreviewCompleted write FOnCapturePreviewCompleted;
    property OnContainsFullScreenElementChanged: TContainsFullScreenElementChangedEvent read FOnContainsFullScreenElementChanged write FOnContainsFullScreenElementChanged;
    property OnContentLoading: TContentLoadingEvent read FOnContentLoading write FOnContentLoading;
    property OnCreateWebViewCompleted: TWebViewStatusEvent read FOnCreateWebViewCompleted write FOnCreateWebViewCompleted;
    property OnDevToolsProtocolEventReceived: TDevToolsProtocolEventReceivedEvent read FOnDevToolsProtocolEventReceived write FOnDevToolsProtocolEventReceived;
    property OnDocumentTitleChanged: TDocumentTitleChangedEvent read FOnDocumentTitleChanged write FOnDocumentTitleChanged;
    property OnDownloadStarting: TDownloadStartingEvent read FOnDownloadStarting write FOnDownloadStarting;
    property OnExecuteScript: TExecuteScriptEvent read FOnExecuteScript write FOnExecuteScript;
    property OnFrameNavigationStarting: TNavigationStartingEvent read FOnFrameNavigationStarting write FOnFrameNavigationStarting;
    property OnFrameNavigationCompleted: TNavigationCompletedEvent read FOnFrameNavigationCompleted write FOnFrameNavigationCompleted;
    property OnHistoryChanged: THistoryChangedEvent read FOnHistoryChanged write FOnHistoryChanged;
    property OnNavigationStarting: TNavigationStartingEvent read FOnNavigationStarting write FOnNavigationStarting;
    property OnNavigationCompleted: TNavigationCompletedEvent read FOnNavigationCompleted write FOnNavigationCompleted;
    property OnNewWindowRequested: TNewWindowRequestedEvent read FOnNewWindowRequested write FOnNewWindowRequested;
    property OnPermissionRequested: TPermissionRequestedEvent read FOnPermissionRequested write FOnPermissionRequested;
    property OnPrintCompleted: TPrintCompletedEvent read FOnPrintCompleted write FOnPrintCompleted;
    property OnPrintToPDFCompleted: TPrintToPDFCompletedEvent read FOnPrintToPDFCompleted write FOnPrintToPDFCompleted;
    property OnProcessFailed: TProcessFailedEvent read FOnProcessFailed write FOnProcessFailed;
    property OnScriptDialogOpening: TScriptDialogOpeningEvent read FOnScriptDialogOpening write FOnScriptDialogOpening;
    property OnSourceChanged: TSourceChangedEvent read FOnSourceChanged write FOnSourceChanged;
    property OnWebMessageReceived: TWebMessageReceivedEvent read FOnWebMessageReceived write FOnWebMessageReceived;
    property OnWebResourceRequested: TWebResourceRequestedEvent read FOnWebResourceRequested write FOnWebResourceRequested;
    property OnWindowCloseRequested: TNotifyEvent read FOnWindowCloseRequested write FOnWindowCloseRequested;
    property OnZoomFactorChanged: TZoomFactorChangedEvent read FOnZoomFactorChanged write FOnZoomFactorChanged;
  end;

  /// <summary>
  ///   VCL component to allow browsing by use of the Edge WebView2 browser control
  /// </summary>
  /// <remarks>
  ///   Be aware that many of the events are called from the Edge WebView2 control and
  ///   as such may well be called on a thread other than the main User Interface thread
  /// </remarks>
  TEdgeBrowser = class(TCustomEdgeBrowser)
  published
    property Align;
    property Anchors;
    property TabOrder;
    property TabStop;
    property OnEnter;
    property OnExit;

    // WebView2 creation environment options

    /// <summary>
    ///   Command-line arguments passed to the browser process to change its behaviour. These are
    ///   Chromium command line switches to use during browser construction in a space-separated string,
    ///   e.g. for a proxy server and show a startup browser dialog:
    ///     --proxy-server=http://1.2.3.4:8888 --browser-startup-dialog
    ///   e.g. to run browser diagnostics:
    ///     --diagnostics
    /// </summary>
    /// <remarks>
    ///   For information on Chromium command-line switches see:
    ///   https://www.chromium.org/developers/how-tos/run-chromium-with-flags
    /// </remarks>
    property AdditionalBrowserArguments;
    /// <summary>
    ///   Enable single sign on with Azure Active Directory (AAD) and personal Microsoft Account (MSA) resources inside
    ///   WebView
    /// </summary>
    property AllowSingleSignOnUsingOSPrimaryAccount;
    /// <summary>
    ///   The default display language for WebView.
    ///   It is in the format of language[-country] where language is the 2-letter code from ISO 639
    ///   and country is the 2-letter code from ISO 3166
    /// </summary>
    property Language;
    /// <summary>
    ///   The version of the WebView2 Runtime binaries required to be compatible with your app.
    ///   This is in the same format as the BrowserVersionInfo property.
    ///   The version of the WebView2 Runtime binaries actually used may be different from the specified
    ///   TargetCompatibleBrowserVersion. Verify the actual version using the BrowserVersionInfo property.
    /// </summary>
    /// <remarks>
    ///   Defaults to '117.0.2045.28', the minimum version for WebView2 SDK 1.0.2045.28, the SDK imported into
    ///   RAD Studio 12.0
    /// </remarks>
    property TargetCompatibleBrowserVersion;

    /// <summary>
    ///   If set this specifies the location of msedgewebview2.exe, used with WebView2 Fixed Version Distribution mode:
    ///   https://docs.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution#fixed-version-distribution-mode
    ///   The value can contain environment variables surrounded by % signs, e.g. %LOCALAPPDATA%.
    ///   If not set this defaults to looking for an installed version of the WebView2 runtime or alternatively an
    ///   installation of Edge Canary.
    ///   Note that setting this property affects the next creation of the underlying WebView2 control. If this
    ///   component has already created a WebView2 control then setting this property will have no effect unless the
    ///   WebView2 control gets recreated (e.g. by ReinitializeWebView or ReinitializeWebViewWithNewBrowser).
    ///   If the path contains \Edge\Application\ then the WebView2 creation will fail.
    /// </summary>
    property BrowserExecutableFolder;
    /// <summary>
    ///   If set this specifies the location of the user data folder, where Edge/WebView2 stores e.g. cookies,
    ///   permissions and cached resources.
    ///   The value can contain environment variables surrounded by % signs, e.g. %LOCALAPPDATA%.
    ///   If not set this defaults to the folder {your_exe_name}.WebView2 in the local app data folder.
    ///   If folder creation permission is not available to the process where the user data folder needs to be created
    ///   then the creation of the underlying WebView2 control can fail.
    ///   The application will need to take responsibility for cleaning up the user data folder when it is no longer
    ///   required.
    ///   Note that setting this property affects the next creation of the underlying WebView2 control. If this
    ///   component has already created a WebView2 control then setting this property will have no effect unless the
    ///   WebView2 control gets recreated (e.g. by ReinitializeWebView or ReinitializeWebViewWithNewBrowser).
    /// </summary>
    property UserDataFolder;
    /// <summary>
    ///   Fired when the captured screenshot of the WebView has been saved
    /// </summary>
    property OnCapturePreviewCompleted;
    /// <summary>
    ///   Fired when the ContainsFullScreenElement property changes, which means that an HTML element inside the
    ///   WebView is entering or leaving fullscreen. The event handler can make the control larger or smaller as
    ///   required.
    /// </summary>
    property OnContainsFullScreenElementChanged;
    /// <summary>
    ///   Fired before any content is loaded. This follows the OnNavigationStarting and OnSourceChanged events
    ///   and precedes the OnHistoryChanged and OnNavigationCompleted events.
    /// </summary>
    property OnContentLoading;
    /// <summary>
    ///   Fired when the WebView control creation has completed, either successfully or unsuccessfully (for example
    ///   Edge is not installed or the WebView2 control cannot loaded)
    /// </summary>
    property OnCreateWebViewCompleted;
    /// <summary>
    ///   Fired when a Chrome DevTools Protocol event, previously subscribed to with SubscribeToCDPEvent, occurs
    /// </summary>
    property OnDevToolsProtocolEventReceived;
    /// <summary>
    ///   Fired when the DocumentTitle property of the WebView changes and may fire before or after the
    ///   OnNavigationCompleted event
    /// </summary>
    property OnDocumentTitleChanged;
    /// <summary>
    ///   Fires when a download has begun, blocking the default download dialog but not blocking the download progress
    /// </summary>
    property OnDownloadStarting;
    /// <summary>
    ///   Fires when script as invoked by ExecuteScript completes
    /// </summary>
    property OnExecuteScript;
    /// <summary>
    ///   Fired when a child frame in the WebView requests permission to navigate to a different URI. This will fire
    ///   for redirects as well.
    /// </summary>
    property OnFrameNavigationStarting;
    /// <summary>
    ///   Fired when a child frame in the WebView has completely loaded or loading stopped with error.
    /// </summary>
    property OnFrameNavigationCompleted;
    /// <summary>
    ///   Fired on change of navigation history for the top level document. OnHistoryChanged fires after
    ///   OnSourceChanged and OnContentLoading
    /// </summary>
    property OnHistoryChanged;
    /// <summary>
    ///   Fired when the WebView main frame requests permission to navigate to a different URI. This will fire for
    ///   redirects as well.
    /// </summary>
    property OnNavigationStarting;
    /// <summary>
    ///   Fired when the WebView has completely loaded or loading stopped with error.
    /// </summary>
    property OnNavigationCompleted;
    /// <summary>
    ///   OnNewWindowRequested fires when content inside the WebView requested to open a new window, such as through
    ///   window.open or through a context menu
    /// </summary>
    property OnNewWindowRequested;
    /// <summary>
    ///   Fired when content in a WebView requests permission to access a privileged resource
    /// </summary>
    property OnPermissionRequested;
    /// <summary>
    ///   Fired when a call to Print completes
    /// </summary>
    property OnPrintCompleted;
    /// <summary>
    ///   Fired when a call to PrintToPDF completes
    /// </summary>
    property OnPrintToPDFCompleted;
    /// <summary>
    ///   Fired when a WebView process terminated unexpectedly or become unresponsive
    /// </summary>
    property OnProcessFailed;
    /// <summary>
    ///   Fired when a JavaScript dialog (alert, confirm, or prompt) will show for the Webview. This event only
    ///   fires if the DefaultScriptDialogsEnabled property is False. The ScriptDialogOpening event can be used
    ///   to suppress dialogs or replace default dialogs with custom dialogs.
    /// </summary>
    property OnScriptDialogOpening;
    /// <summary>
    ///   Fired for navigating to a different site or fragment navigations. It will not fires for other types of
    ///   navigations such as page reloads. OnSourceChanged fires before OnContentLoading for navigation to a new
    ///   document.
    /// </summary>
    property OnSourceChanged;
    /// <summary>
    ///   Fired when the WebMessageEnabled property is True and the top level document of the W webView calls
    ///   window.chrome.webview.postMessage
    /// </summary>
    property OnWebMessageReceived;
    /// <summary>
    ///   Fired when the WebView is performing an HTTP request to a matching URL and resource context filter that was
    ///   added with AddWebResourceRequestedFilter. At least one filter must be added for the event to fire.
    /// </summary>
    property OnWebResourceRequested;
    /// <summary>
    ///   Fires when content inside the WebView requested to close the window, such as after window.close is called.
    ///   The app should close the WebView and related app window if that makes sense to the app.
    /// </summary>
    property OnWindowCloseRequested;
    /// <summary>
    ///   Fired when the ZoomFactor property of the WebView changes. The event could fire because the caller modified
    ///   the ZoomFactor property, or due to the user manually modifying the zoom, but not from a programmatic change.
    /// </summary>
    property OnZoomFactorChanged;
  end;

  /// <summary>
  ///   Exception type used to indicate an exceptional circumstance from within the TEdgeBrowser component
  /// </summary>
  EEdgeError = class(EOleSysError)
  public
    constructor Create(const Message: UnicodeString; ErrorCode: HRESULT);
    constructor CreateRes(ResStringRec: PResStringRec; ErrorCode: HRESULT);
  end;

implementation

uses
  System.SysUtils, System.IOUtils, Winapi.ShLwApi, Winapi.ActiveX, Vcl.Forms,
  Vcl.EdgeConst, Winapi.EdgeUtils;

type
  TApplicationClass = class(TApplication);

{ TCustomEdgeBrowser }

constructor TCustomEdgeBrowser.Create(AOwner: TComponent);
const
  CLocalAppData = '%LOCALAPPDATA%'; // Do not localize
  CUserDatafolderSuffix = '.WebView2'; // Do not localize
  // From WebView2EnvironmentOptions.h
  CORE_WEBVIEW_TARGET_PRODUCT_VERSION =
    //'84.0.488.0'; // minimum version for WebView2 SDK 0.9.488 - the Edge import for RAD Studio 10.4
    //'101.0.1210.39'; // minimum version for WebView2 SDK 1.0.1210.39 - the Edge import in GetIT for RAD Studio 11
    '117.0.2045.28'; // minimum version for WebView2 SDK 1.0.2045.28 - the Edge import for RAD Studio 12
begin
  inherited;
  FBrowserControlState := TBrowserControlState.None;
  FCritSec := TCriticalSection.Create;
  FDevToolsProtocolEventReceivedTokenMap := TDictionary<string, EventRegistrationToken>.Create;
  FUserDataFolder := TPath.Combine(CLocalAppData, TPath.GetFileName(ParamStr(0) + CUserDatafolderSuffix));
  FTargetCompatibleBrowserVersion := CORE_WEBVIEW_TARGET_PRODUCT_VERSION;
end;

procedure TCustomEdgeBrowser.DeleteAllExtensions;
begin
  if FCoreWebViewProfile7 = nil then
    Exit;

  FCoreWebViewProfile7.GetBrowserExtensions(Callback<HResult, ICoreWebView2BrowserExtensionList>.CreateAs<ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler>(
    function(ErrorCode: HResult; List: ICoreWebView2BrowserExtensionList): HResult stdcall
    begin
      Result := S_OK;

      var ACount: cardinal;
      var Ext: ICoreWebView2BrowserExtension;
      List.Get_Count(ACount);
      for var I := 0 to ACount-1 do begin
        List.GetValueAtIndex(I, Ext);

        Ext.Remove(nil);
      end;

    end));
end;

destructor TCustomEdgeBrowser.Destroy;
begin
  CloseWebView;
  FDevToolsProtocolEventReceivedTokenMap.Free;
  inherited;
  FCritSec.Free;
end;

procedure TCustomEdgeBrowser.DoEnter;
begin
  inherited;
  if not FWebViewFocusEventActive and (FWebViewController <> nil) then
    ProcessHResult(FWebViewController.MoveFocus(COREWEBVIEW2_MOVE_FOCUS_REASON_PROGRAMMATIC));
end;

procedure TCustomEdgeBrowser.AddExtension(ExtensionDirectoryPath: string);
begin
  if FCoreWebViewProfile7 = nil then
    Exit;

  FCoreWebViewProfile7.AddBrowserExtension(PChar(ExtensionDirectoryPath), Callback<HResult, ICoreWebView2BrowserExtension>.CreateAs<ICoreWebView2ProfileAddBrowserExtensionCompletedHandler>(
    function(ErrorCode: HResult; Extension: ICoreWebView2BrowserExtension): HResult stdcall
    begin
      Result := S_OK;
    end));
end;

procedure TCustomEdgeBrowser.AddWebResourceRequestedFilter(const URL: string;
  ResourceContext: COREWEBVIEW2_WEB_RESOURCE_CONTEXT);
begin
  if FWebView <> nil then
    ProcessHResult(FWebView.AddWebResourceRequestedFilter(PChar(URL), ResourceContext));
end;

procedure TCustomEdgeBrowser.CapturePreview(const AFilename: string; PreviewFormat: TPreviewFormat);
begin
  if FWebView = nil then
    Exit;

  var Stream: IStream;
  if ProcessHResult(SHCreateStreamOnFile(PChar(AFilename), STGM_READWRITE or STGM_CREATE, Stream)) then
  begin
    var handler :=
      function(AResult: HResult): HResult stdcall
      begin
        Result := S_OK;
        if Assigned(FOnCapturePreviewCompleted) then
          FOnCapturePreviewCompleted(Self, AResult)
      end;
    var Format := COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_PNG;
    if PreviewFormat = TPreviewFormat.JPEG then
      Format := COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_JPEG;
    ProcessHResult(FWebView.CapturePreview(Format, Stream,
      ICoreWebView2CapturePreviewCompletedHandler(PInterface(@handler)^)));
  end;
end;

procedure TCustomEdgeBrowser.CapturePreview(Stream: TStream; PreviewFormat: TPreviewFormat);
begin
  if FWebView = nil then
    Exit;

  var NewPos: LargeUInt;
  var AdapterIntf: IStream := TStreamAdapter.Create(Stream);
  AdapterIntf.Seek(0, STREAM_SEEK_SET, NewPos);
  var handler :=
    function(AResult: HResult): HResult stdcall
    begin
      Result := S_OK;
      if Assigned(FOnCapturePreviewCompleted) then
        FOnCapturePreviewCompleted(Self, AResult)
    end;
  var Format := COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_PNG;
  if PreviewFormat = TPreviewFormat.JPEG then
    Format := COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_JPEG;
  ProcessHResult(FWebView.CapturePreview(Format, AdapterIntf,
    ICoreWebView2CapturePreviewCompletedHandler(PInterface(@handler)^)));
end;

procedure TCustomEdgeBrowser.CloseBrowserProcess;
begin
  // Get browser process ID before we close it
  var WebviewProcessId := BrowserProcessID;

  // We need to close the current webviews and wait for the browser_process to exit
  // This is so the new webviews don't use the old browser exe
  CloseWebView;

  // Make sure the browser process inside webview is closed
  if WebviewProcessID <> 0 then
  begin
    var BrowserProcess := OpenProcess(PROCESS_TERMINATE, False, WebviewProcessId);
    // Wait for the process to exit by itself
    const TimeOutMS = 2000;
    var WaitResult := WaitForSingleObject(BrowserProcess, TimeOutMS);
    if WaitResult <> WAIT_OBJECT_0 then
    begin
      const ExitCode = 1;
      TerminateProcess(BrowserProcess, ExitCode);
      CloseHandle(BrowserProcess);
    end;
  end;
end;

procedure TCustomEdgeBrowser.CloseWebView;
begin
  if FWebView4 <> nil then
  begin
    try
      FWebView4.remove_DownloadStarting(FDownloadStartingToken);
    finally
      FWebView4 := nil;
    end;
  end;
  if FCoreWebViewProfile <> nil then
    FCoreWebViewProfile := nil;
  if FCoreWebViewProfile7 <> nil then
    FCoreWebViewProfile7 := nil;
  if FWebView <> nil then
  begin
    try
      FWebView.remove_NavigationStarting(FNavigationStartingToken);
      FWebView.remove_NavigationCompleted(FNavigationCompletedToken);
      FWebView.remove_SourceChanged(FSourceChangedToken);
      FWebView.remove_HistoryChanged(FHistoryChangedToken);
      FWebView.remove_ContentLoading(FContentLoadingToken);
      FWebView.remove_DocumentTitleChanged(FDocumentTitleChangedToken);
      FWebView.remove_NewWindowRequested(FNewWindowRequestedToken);
      FWebView.remove_FrameNavigationStarting(FFrameNavigationStartingToken);
      FWebView.remove_FrameNavigationCompleted(FFrameNavigationCompletedToken);
      FWebView.remove_WebResourceRequested(FWebResourceRequestedToken);
      FWebView.remove_ScriptDialogOpening(FScriptDialogOpeningToken);
      FWebView.remove_PermissionRequested(FPermissionRequestedToken);
      FWebView.remove_ProcessFailed(FProcessFailedToken);
      FWebView.remove_WebMessageReceived(FWebMessageReceivedToken);
      FWebView.remove_WindowCloseRequested(FWindowCloseRequestedToken);
      FWebView.remove_ContainsFullScreenElementChanged(FContainsFullScreenElementChangedToken);
      for var CDPEventName in FDevToolsProtocolEventReceivedTokenMap.Keys do
      begin
        var Receiver: ICoreWebView2DevToolsProtocolEventReceiver;
        if ProcessHResult(FWebView.GetDevToolsProtocolEventReceiver(PChar(CDPEventname), Receiver)) then
          Receiver.remove_DevToolsProtocolEventReceived(FDevToolsProtocolEventReceivedTokenMap[CDPEventName]);
      end;
      FDevToolsProtocolEventReceivedTokenMap.Clear;
    finally
      FWebView := nil;
    end;
  end;
  if FWebViewController <> nil then
  begin
    try
      FWebViewController.remove_AcceleratorKeyPressed(FAcceleratorKeyPressedToken);
      FWebViewController.remove_GotFocus(FGotFocusToken);
      FWebViewController.remove_LostFocus(FLostFocusToken);
      FWebViewController.remove_MoveFocusRequested(FMoveFocusRequestedToken);
      FWebViewController.remove_ZoomFactorChanged(FZoomFactorChangedToken);
      FWebViewController.Close;
    finally
      FWebViewController := nil;
    end;
  end;
  // CloseWebView is called (internally) from InitializeWebView - we do not want to reset the state to None in that case
  if not FInternalClose then
    FBrowserControlState := TBrowserControlState.None;
end;

// This is the callback passed to CreateWebViewEnvironmentWithDetails.
// Here we simply create the WebView.
function TCustomEdgeBrowser.CreateEnvironmentCompleted(AResult: HResult; const AEnvironment: ICoreWebView2Environment): HResult;
begin
  if ProcessHResult(AResult) then
  begin
    FWebViewEnvironment := AEnvironment;
    // Add a reference so that after we have cleared up entirely and the
    // WebView tries to tidy up its environment, we don't get a failure
    FWebViewEnvironment._AddRef;
    var AHResult := FWebViewEnvironment.CreateCoreWebView2Controller(Handle,
      Callback<HResult, ICoreWebView2Controller>.CreateAs<ICoreWebView2CreateCoreWebView2ControllerCompletedHandler>(
        CreateCoreWebView2ControllerCompleted
      ));
    if not ProcessHResult(AHResult) then
    begin
      FBrowserControlState := TBrowserControlState.Failed;
      FOnCreateWebViewCompleted(Self, AHResult);
    end;
  end
  else
    if Assigned(FOnCreateWebViewCompleted) then
    begin
      FBrowserControlState := TBrowserControlState.Failed;
      FOnCreateWebViewCompleted(Self, AResult);
    end;
  Result := S_OK;
end;

function TCustomEdgeBrowser.CreatePrintSettings: ICoreWebView2PrintSettings;
var
  LWebView2Environment6: ICoreWebView2Environment6;
begin
  if Supports(FWebViewEnvironment, ICoreWebView2Environment6, LWebView2Environment6) then
    ProcessHResult(LWebView2Environment6.CreatePrintSettings(Result));
end;

procedure TCustomEdgeBrowser.CreateWebView;
begin
  // Microsoft Edge browser only works on Windows 7 and above
  if not IsEdgeSupported then
    Exit;

  // Make web view creation asynchronous
  if (FWebView = nil) and (FBrowserControlState <> TBrowserControlState.Creating) then
  begin
    FBrowserControlState := TBrowserControlState.Creating;
    InitializeWebView
  end;
end;

function TCustomEdgeBrowser.CreateCoreWebView2ControllerCompleted(AResult: HResult;
  const ACreatedController: ICoreWebView2Controller): HResult;
var
  FWebView13: ICoreWebView2_13;
begin
  Result := S_OK;
  if ProcessHResult(AResult) then
  begin
    FWebViewController := ACreatedController;
    var LHResult := FWebViewController.Get_CoreWebView2(FWebView);
    if ProcessHResult(LHResult) then
    begin
      Supports(FWebView, ICoreWebView2_4, FWebView4);
      if Supports(FWebView, ICoreWebView2_13, FWebView13) then begin
        FWebView13.Get_Profile(FCoreWebViewProfile);
        Supports(FCoreWebViewProfile, ICoreWebView2Profile7, FCoreWebViewProfile7); // query profile 7
      end;
      LHResult := FWebView.Get_Settings(FWebViewSettings);
      if ProcessHResult(LHResult) then
      begin
        FBrowserControlState := TBrowserControlState.Created;
        if Assigned(FOnCreateWebViewCompleted) then
          FOnCreateWebViewCompleted(Self, AResult);
        {$REGION 'WebView2 event handlers'}
        if FWebView <> nil then
        begin
          // Register a handler for the NavigationStarting event.
          // The triggered event could, say, enable a Cancel button.
          FWebView.add_NavigationStarting(
            Callback<ICoreWebView2, ICoreWebView2NavigationStartingEventArgs>.CreateAs<ICoreWebView2NavigationStartingEventHandler>(
              function(const Sender: ICoreWebView2; const Args: ICoreWebView2NavigationStartingEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnNavigationStarting) then
                begin
                  var LArgs := TNavigationStartingEventArgs.Create(Args);
                  try
                    FOnNavigationStarting(Self, LArgs);
                  finally
                    LArgs.Free
                  end;
                end;
              end
            ),
            FNavigationStartingToken);
          // Register a handler for the NavigationCompleted event.
          // The triggered event could, say, check whether the navigation succeeded, and if not, do something.
          // It could also update the Back, Forward, and Cancel buttons.
          FWebView.add_NavigationCompleted(
            Callback<ICoreWebView2, ICoreWebView2NavigationCompletedEventArgs>.CreateAs<ICoreWebView2NavigationCompletedEventHandler>(
              function(const Sender: ICoreWebView2; const Args: ICoreWebView2NavigationCompletedEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnNavigationCompleted) then
                begin
                  var IsSuccess: Integer := 0;
                  Args.Get_IsSuccess(IsSuccess);
                  var WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS := COREWEBVIEW2_WEB_ERROR_STATUS_UNKNOWN;
                  Args.Get_WebErrorStatus(WebErrorStatus);
                  FOnNavigationCompleted(Self, LongBool(IsSuccess), WebErrorStatus);
                end;
              end
            ),
            FNavigationCompletedToken);
          // Register a handler for the SourceChanged event.
          // The triggered event could, say, read the webview's source URI and update an address bar.
          FWebView.add_SourceChanged(
            Callback<ICoreWebView2, ICoreWebView2SourceChangedEventArgs>.CreateAs<ICoreWebView2SourceChangedEventHandler>(
              function(const Sender: ICoreWebView2; const Args: ICoreWebView2SourceChangedEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnSourceChanged) then
                begin
                  var IsNewDocument: Integer := 0;
                  Args.Get_IsNewDocument(IsNewDocument);
                  FOnSourceChanged(Self, LongBool(IsNewDocument));
                end;
              end
            ),
            FSourceChangedToken);
          // Register a handler for the HistoryChanged event.
          // The triggered event could, say, check whether Back or Forward buttons should be enabled.
          FWebView.add_HistoryChanged(
            Callback<ICoreWebView2, IUnknown>.CreateAs<ICoreWebView2HistoryChangedEventHandler>(
              function(const Sender: ICoreWebView2; const Args: IUnknown): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnHistoryChanged) then
                  FOnHistoryChanged(Self);
              end
            ),
            FHistoryChangedToken);
          // Register a handler for the ContentLoading event.
          FWebView.add_ContentLoading(
            Callback<ICoreWebView2, ICoreWebView2ContentLoadingEventArgs>.CreateAs<ICoreWebView2ContentLoadingEventHandler>(
              function(const Sender: ICoreWebView2; const Args: ICoreWebView2ContentLoadingEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnContentLoading) then
                begin
                  var IsErrorPage: Integer := 0;
                  Args.Get_IsErrorPage(IsErrorPage);
                  var NavigationId: UInt64 := 0;
                  Args.Get_NavigationId(NavigationId);
                  FOnContentLoading(Self, LongBool(IsErrorPage), NavigationId);
                end;
              end
            ),
            FContentLoadingToken);
          // Register a handler for the DocumentTitleChanged event.
          FWebView.add_DocumentTitleChanged(
            Callback<ICoreWebView2, IUnknown>.CreateAs<ICoreWebView2DocumentTitleChangedEventHandler>(
              function(const Sender: ICoreWebView2; const Args: IUnknown): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnDocumentTitleChanged) then
                  FOnDocumentTitleChanged(Self, DocumentTitle);
              end
            ),
            FDocumentTitleChangedToken);
          // Register a handler for the NewWindowRequested event.
          FWebView.add_NewWindowRequested(
            Callback<ICoreWebView2, ICoreWebView2NewWindowRequestedEventArgs>.CreateAs<ICoreWebView2NewWindowRequestedEventHandler>(
              function(const Sender: ICoreWebView2; const Args: ICoreWebView2NewWindowRequestedEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnNewWindowRequested) then
                begin
                  var LArgs := TNewWindowRequestedEventArgs.Create(Args);
                  try
                    FOnNewWindowRequested(Self, LArgs);
                  finally
                    LArgs.Free
                  end;
                end
              end
            ),
            FNewWindowRequestedToken);
          // Register a handler for the FrameNavigationStarting event.
          FWebView.add_FrameNavigationStarting(
            Callback<ICoreWebView2, ICoreWebView2NavigationStartingEventArgs>.CreateAs<ICoreWebView2NavigationStartingEventHandler>(
              function(const Sender: ICoreWebView2; const Args: ICoreWebView2NavigationStartingEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnFrameNavigationStarting) then
                begin
                  var LArgs := TNavigationStartingEventArgs.Create(Args);
                  try
                    FOnFrameNavigationStarting(Self, LArgs);
                  finally
                    LArgs.Free
                  end;
                end
              end
            ),
            FFrameNavigationStartingToken);
          // Register a handler for the FrameNavigationCompleted event.
          FWebView.add_FrameNavigationCompleted(
            Callback<ICoreWebView2, ICoreWebView2NavigationCompletedEventArgs>.CreateAs<ICoreWebView2NavigationCompletedEventHandler>(
              function(const Sender: ICoreWebView2; const Args: ICoreWebView2NavigationCompletedEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnFrameNavigationCompleted) then
                begin
                  var IsSuccess: Integer := 0;
                  Args.Get_IsSuccess(IsSuccess);
                  var WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS := COREWEBVIEW2_WEB_ERROR_STATUS_UNKNOWN;
                  Args.Get_WebErrorStatus(WebErrorStatus);
                  FOnFrameNavigationCompleted(Self, LongBool(IsSuccess), WebErrorStatus);
                end
              end
            ),
            FFrameNavigationStartingToken);
          // Register a handler for the WebResourceRequested event.
          FWebView.add_WebResourceRequested(
            Callback<ICoreWebView2, ICoreWebView2WebResourceRequestedEventArgs>.CreateAs<ICoreWebView2WebResourceRequestedEventHandler>(
              function(const Webview: ICoreWebView2; const Args: ICoreWebView2WebResourceRequestedEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnWebResourceRequested) then
                begin
                  var LArgs := TWebResourceRequestedEventArgs.Create(Args);
                  try
                    FOnWebResourceRequested(Self, LArgs);
                  finally
                    LArgs.Free
                  end;
                end
              end
            ),
            FWebResourceRequestedToken);
          // Register a handler for the ScriptDialogOpening event.
          FWebView.add_ScriptDialogOpening(
            Callback<ICoreWebView2, ICoreWebView2ScriptDialogOpeningEventArgs>.CreateAs<ICoreWebView2ScriptDialogOpeningEventHandler>(
              function(const Webview: ICoreWebView2; const Args: ICoreWebView2ScriptDialogOpeningEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnScriptDialogOpening) then
                begin
                  var LArgs := TScriptDialogOpeningEventArgs.Create(Args);
                  try
                    FOnScriptDialogOpening(Self, LArgs);
                  finally
                    LArgs.Free
                  end;
                end
              end
            ),
            FScriptDialogOpeningToken);
          // Register a handler for the PermissionRequested event.
          FWebView.add_PermissionRequested(
            Callback<ICoreWebView2, ICoreWebView2PermissionRequestedEventArgs>.CreateAs<ICoreWebView2PermissionRequestedEventHandler>(
              function(const Webview: ICoreWebView2; const Args: ICoreWebView2PermissionRequestedEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnPermissionRequested) then
                begin
                  var LArgs := TPermissionRequestedEventArgs.Create(Args);
                  try
                    FOnPermissionRequested(Self, LArgs);
                  finally
                    LArgs.Free
                  end;
                end
              end
            ),
            FPermissionRequestedToken);
          // Register a handler for the ProcessFailed event.
          FWebView.add_ProcessFailed(
            Callback<ICoreWebView2, ICoreWebView2ProcessFailedEventArgs>.CreateAs<ICoreWebView2ProcessFailedEventHandler>(
              function(const Webview: ICoreWebView2; const Args: ICoreWebView2ProcessFailedEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnProcessFailed) then
                begin
                  var FailureType: COREWEBVIEW2_PROCESS_FAILED_KIND := COREWEBVIEW2_PROCESS_FAILED_KIND_BROWSER_PROCESS_EXITED;
                  Args.Get_ProcessFailedKind(FailureType);
                  FOnProcessFailed(Self, FailureType);
                end;
              end
            ),
            FProcessFailedToken);
          // Register a handler for the WebMessageReceived event.
          FWebView.add_WebMessageReceived(
            Callback<ICoreWebView2, ICoreWebView2WebMessageReceivedEventArgs>.CreateAs<ICoreWebView2WebMessageReceivedEventHandler>(
              function(const Webview: ICoreWebView2; const Args: ICoreWebView2WebMessageReceivedEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnWebMessageReceived) then
                begin
                  var LArgs := TWebMessageReceivedEventArgs.Create(Args);
                  try
                    FOnWebMessageReceived(Self, LArgs);
                  finally
                    LArgs.Free
                  end;
                end
              end
            ),
            FWebMessageReceivedToken);
          // Register a handler for the ContainsFullScreenElementChanged event.
          FWebView.add_ContainsFullScreenElementChanged(
            Callback<ICoreWebView2, IUnknown>.CreateAs<ICoreWebView2ContainsFullScreenElementChangedEventHandler>(
              function(const Webview: ICoreWebView2; const Args: IUnknown): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnContainsFullScreenElementChanged) then
                begin
                  var ContainsFullScreenElement: Integer;
                  if ProcessHResult(WebView.Get_ContainsFullScreenElement(ContainsFullScreenElement)) then
                    FOnContainsFullScreenElementChanged(Self, LongBool(ContainsFullScreenElement));
                end
              end
            ),
            FContainsFullScreenElementChangedToken);
          // Register a handler for the WindowClosedRequested event.
          FWebView.add_WindowCloseRequested(
            Callback<ICoreWebView2, IUnknown>.CreateAs<ICoreWebView2WindowCloseRequestedEventHandler>(
              function(const Webview: ICoreWebView2; const Args: IUnknown): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnWindowCloseRequested) then
                  FOnWindowCloseRequested(Self);
              end
            ),
            FWindowCloseRequestedToken);
        end;
        if FWebView4 <> nil then
        begin
          // Register a handler for the DownloadStarting event.
          FWebView4.add_DownloadStarting(
            Callback<ICoreWebView2, ICoreWebView2DownloadStartingEventArgs>.CreateAs<ICoreWebView2DownloadStartingEventHandler>(
              function(const Sender: ICoreWebView2; const Args: ICoreWebView2DownloadStartingEventArgs): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnDownloadStarting) then
                begin
                  var LArgs := TDownloadStartingEventArgs.Create(Args);
                  try
                    FOnDownloadStarting(Self, LArgs);
                  finally
                    LArgs.Free
                  end;
                end;
              end
            ),
            FDownloadStartingToken);
        end;
        if FWebViewController <> nil then
        begin
          // Register a handler for the ZoomFactorChanged event.
          FWebViewController.add_ZoomFactorChanged(
            Callback<ICoreWebView2, IUnknown>.CreateAs<ICoreWebView2ZoomFactorChangedEventHandler>(
              function(const Sender: ICoreWebView2; const Args: IUnknown): HResult stdcall
              begin
                Result := S_OK;
                if Assigned(FOnZoomFactorChanged) then
                  FOnZoomFactorChanged(Self, ZoomFactor);
              end
            ),
            FZoomFactorChangedToken);
          // Register a handler for the MoveFocusRequested event.
          FWebViewController.add_MoveFocusRequested(
            Callback<ICoreWebView2, ICoreWebView2MoveFocusRequestedEventArgs>.CreateAs<ICoreWebView2MoveFocusRequestedEventHandler>(
              function(const Sender: ICoreWebView2; const Args: ICoreWebView2MoveFocusRequestedEventArgs): HResult stdcall
              begin
                Result := S_OK;
                var Reason: COREWEBVIEW2_MOVE_FOCUS_REASON;
                if ProcessHResult(Args.Get_reason(Reason)) then
                  case Reason of
                    COREWEBVIEW2_MOVE_FOCUS_REASON_PREVIOUS: SelectNext(Self, False, True);
                    COREWEBVIEW2_MOVE_FOCUS_REASON_NEXT: SelectNext(Self, True, True);
                  end;
              end
            ),
            FMoveFocusRequestedToken);
          // Register a handler for the AcceleratorKeyPressed event.
          FWebViewController.add_AcceleratorKeyPressed(
            Callback<ICoreWebView2, ICoreWebView2AcceleratorKeyPressedEventArgs>.CreateAs<ICoreWebView2AcceleratorKeyPressedEventHandler>(
              function(const Sender: ICoreWebView2; const Args: ICoreWebView2AcceleratorKeyPressedEventArgs): HResult stdcall
              begin
                Result := S_OK;
                var KeyEventType: COREWEBVIEW2_KEY_EVENT_KIND;
                if ProcessHResult(Args.Get_KeyEventKind(KeyEventType)) then
                begin
                  var Key: SYSUINT;
                  var LParam: SYSINT;
                  if ProcessHResult(Args.Get_VirtualKey(Key)) and ProcessHResult(Args.Get_KeyEventLParam(LParam)) then
                  begin
                    var Form := GetParentForm(Self);
                    if Form <> nil then
                    begin
                      // Set up a TMessage message record
                      var Msg: TMessage;
                      case KeyEventType of
                        COREWEBVIEW2_KEY_EVENT_KIND_KEY_DOWN:
                          Msg.Msg := WM_KEYDOWN;
                        COREWEBVIEW2_KEY_EVENT_KIND_KEY_UP:
                          Msg.Msg := WM_KEYUP;
                        COREWEBVIEW2_KEY_EVENT_KIND_SYSTEM_KEY_DOWN:
                          Msg.Msg := WM_SYSKEYDOWN;
                        COREWEBVIEW2_KEY_EVENT_KIND_SYSTEM_KEY_UP:
                          Msg.Msg := WM_SYSKEYUP;
                      end;
                      Msg.WParam := Key;
                      Msg.LParam := LParam;
                      if Form.IsShortCut(TWMKey(Msg)) then
                      begin
                        // We have some sort of shortcut on our form, so keep the browser from handling this key
                        Args.Set_Handled(Integer(LongBool(True)));
                      end;
                    end
                  end
                end
              end
            ),
            FAcceleratorKeyPressedToken);
          // Register a handler for the GotFocus event.
          FWebViewController.add_GotFocus(
            Callback<ICoreWebView2, IUnknown>.CreateAs<ICoreWebView2FocusChangedEventHandler>(
              function(const Webview: ICoreWebView2; const Args: IUnknown): HResult stdcall
              begin
                Result := S_OK;
                FWebViewFocusEventActive := True;
                DoEnter;
                FWebViewFocusEventActive := False;
              end
            ),
            FGotFocusToken);
          // Register a handler for the LostFocus event.
          FWebViewController.add_LostFocus(
            Callback<ICoreWebView2, IUnknown>.CreateAs<ICoreWebView2FocusChangedEventHandler>(
              function(const Webview: ICoreWebView2; const Args: IUnknown): HResult stdcall
              begin
                Result := S_OK;
                DoExit;
              end
            ),
            FLostFocusToken);
          // Set the initial size of the WebView
          Resize;
        end;
        {$ENDREGION}
        // Navigate to saved URL, if there is one
        if Length(FLastURI) > 0 then
          Navigate(FLastURI);
      end
    end;
    if Winapi.Windows.Failed(LHResult) and Assigned(FOnCreateWebViewCompleted) then
      FOnCreateWebViewCompleted(Self, LHResult)
  end
  else
  begin
    if csDestroying in ComponentState then
      Exit;
    // A problem occurred along the way - call event handler or raise an error to indicate this
    FBrowserControlState := TBrowserControlState.Failed;
    if Assigned(FOnCreateWebViewCompleted) then
      FOnCreateWebViewCompleted(Self, FLastErrorCode)
    else
      raise EEdgeError.CreateRes(@SWebViewFailure, FLastErrorCode);
  end;
end;

procedure TCustomEdgeBrowser.CreateWnd;
begin
  inherited;
  if FWebView <> nil then
  begin
    FLastURI := LocationURL;
    ReinitializeWebView;
  end;
end;

procedure TCustomEdgeBrowser.ExecuteScript(const JavaScript: string);
begin
  if FWebView <> nil then
    FWebView.ExecuteScript(PChar(JavaScript),
      Callback<HResult, PChar>.CreateAs<ICoreWebView2ExecuteScriptCompletedHandler>(
        function(ErrorCode: HResult; ResultObjectAsJson: PWideChar): HResult stdcall
        begin
          Result := S_OK;
          if Assigned(FOnExecuteScript) then
            FOnExecuteScript(Self, ErrorCode, string(ResultObjectAsJson));
        end));
end;

function TCustomEdgeBrowser.GetAllExtensionIDs: TArray<string>;
var
  EndCallback: boolean;
  AResult: ^TArray<string>;
  Status: HRESULT;
begin
  Result := [];
  if FCoreWebViewProfile7 = nil then
    Exit;
  AResult := @Result;

  EndCallback := false;
  Status := FCoreWebViewProfile7.GetBrowserExtensions(Callback<HResult, ICoreWebView2BrowserExtensionList>.CreateAs<ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler>(
    function(ErrorCode: HResult; List: ICoreWebView2BrowserExtensionList): HResult stdcall
    begin
      Result := S_OK;
      try
        var ACount: cardinal;
        var S: PWIdeChar;
        var Ext: ICoreWebView2BrowserExtension;
        List.Get_Count(ACount);
        for var I := 0 to ACount-1 do begin
          List.GetValueAtIndex(I, Ext);
          Ext.Get_id(S);

          AResult^ := AResult^ + [S];
        end;
      finally
        EndCallback := true;
      end;
    end));

  // Wait
  WaitForWebViewEvent(EndCallback);
end;

function TCustomEdgeBrowser.GetAllExtensions: TArray<string>;
var
  EndCallback: boolean;
  AResult: ^TArray<string>;
begin
  Result := [];
  if FCoreWebViewProfile7 = nil then
    Exit;
  AResult := @Result;

  EndCallback := false;
  FCoreWebViewProfile7.GetBrowserExtensions(Callback<HResult, ICoreWebView2BrowserExtensionList>.CreateAs<ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler>(
    function(ErrorCode: HResult; List: ICoreWebView2BrowserExtensionList): HResult stdcall
    begin
      Result := S_OK;
      try
        var ACount: cardinal;
        var S: PWIdeChar;
        var Ext: ICoreWebView2BrowserExtension;
        List.Get_Count(ACount);
        for var I := 0 to ACount-1 do begin
          List.GetValueAtIndex(I, Ext);
          Ext.Get_name(S);

          AResult^ := AResult^ + [S];
        end;
      finally
        EndCallback := true;
      end;
    end));

  // Wait
  WaitForWebViewEvent(EndCallback);
end;

function TCustomEdgeBrowser.GetBrowserProcessID: DWORD;
begin
  Result := 0;
  if FWebView <> nil then
    ProcessHResult(FWebView.Get_BrowserProcessId(Result));
end;

function TCustomEdgeBrowser.GetBrowserVersionInfo: string;
begin
  Result := '';
  // Microsoft Edge browser only works on Windows 7 and above
  if not IsEdgeSupported then
    Exit;

  var VersionInfo: PChar := nil;
  if FWebView = nil then
    // Handle commands not related to the WebView, which will work even if the WebView is not currently initialized.
    ProcessHResult(GetCoreWebView2BrowserVersionString(nil, VersionInfo))
  else
    // Handle commands related to the WebView. This will do nothing if the WebView is not initialized.
    ProcessHResult(FWebViewEnvironment.Get_BrowserVersionString(VersionInfo));
  if Succeeded(FLastErrorCode) then
    Result := VersionInfo;
  CoTaskMemFree(VersionInfo);
end;

function TCustomEdgeBrowser.GetCanGoBack: Boolean;
begin
  Result := False;
  if FWebView <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebView.Get_CanGoBack(ResultInt)) then
      Result := LongBool(ResultInt);
  end;
end;

function TCustomEdgeBrowser.GetCanGoForward: Boolean;
begin
  Result := False;
  if FWebView <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebView.Get_CanGoForward(ResultInt)) then
      Result := LongBool(ResultInt);
  end;
end;

function TCustomEdgeBrowser.GetContainsFullScreenElement: Boolean;
begin
  Result := False;
  if FWebView <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebView.Get_ContainsFullScreenElement(ResultInt)) then
      Result := LongBool(ResultInt);
  end;
end;

function TCustomEdgeBrowser.GetBuiltInErrorPageEnabled: Boolean;
begin
  if FWebViewSettings <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebViewSettings.Get_IsBuiltInErrorPageEnabled(ResultInt)) then
      Exit(LongBool(ResultInt));
  end;
  raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

function TCustomEdgeBrowser.GetDefaultContextMenusEnabled: Boolean;
begin
  if FWebViewSettings <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebViewSettings.Get_AreDefaultContextMenusEnabled(ResultInt)) then
      Exit(LongBool(ResultInt));
  end;
  raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

function TCustomEdgeBrowser.GetDefaultScriptDialogsEnabled: Boolean;
begin
  if FWebViewSettings <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebViewSettings.Get_AreDefaultScriptDialogsEnabled(ResultInt)) then
      Exit(LongBool(ResultInt));
  end;
  raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

function TCustomEdgeBrowser.GetDevToolsEnabled: Boolean;
begin
  if FWebViewSettings <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebViewSettings.Get_AreDevToolsEnabled(ResultInt)) then
      Exit(LongBool(ResultInt));
  end;
  raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

function TCustomEdgeBrowser.GetDocumentTitle: string;
begin
  if FWebView <> nil then
  begin
    var Title: PChar := nil;
    if ProcessHResult(FWebView.get_DocumentTitle(Title)) then
    begin
      Result := Title;
      CoTaskMemFree(Title);
    end;
  end;
end;

function TCustomEdgeBrowser.GetLocationURL: string;
begin
  if FWebView <> nil then
  begin
    var Uri: PChar;
    ProcessHResult(FWebView.get_Source(Uri));
    if StrIComp(Uri, 'about:blank') <> 0 then
      Result := Uri;
    CoTaskMemFree(Uri);
  end;
end;

function TCustomEdgeBrowser.GetScriptEnabled: Boolean;
begin
  if FWebViewSettings <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebViewSettings.Get_IsScriptEnabled(ResultInt)) then
      Exit(LongBool(ResultInt));
  end;
  raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

function TCustomEdgeBrowser.GetStatusBarEnabled: Boolean;
begin
  if FWebViewSettings <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebViewSettings.Get_IsStatusBarEnabled(ResultInt)) then
      Exit(LongBool(ResultInt));
  end;
  raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

function TCustomEdgeBrowser.GetWebMessageEnabled: Boolean;
begin
  if FWebViewSettings <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebViewSettings.Get_IsWebMessageEnabled(ResultInt)) then
      Exit(LongBool(ResultInt));
  end;
  raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

function TCustomEdgeBrowser.GetWebViewCreated: Boolean;
begin
  Result := (FWebViewEnvironment <> nil) and
            (FWebViewController <> nil) and
            (FWebView <> nil) and
            (FWebViewSettings <> nil);
end;

function TCustomEdgeBrowser.GetZoomControlEnabled: Boolean;
begin
  if FWebViewSettings <> nil then
  begin
    var ResultInt: Integer;
    if ProcessHResult(FWebViewSettings.Get_IsZoomControlEnabled(ResultInt)) then
      Exit(LongBool(ResultInt));
  end;
  raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

function TCustomEdgeBrowser.GetZoomFactor: Double;
begin
  Result := 0;
  if FWebViewController <> nil then
    ProcessHResult(FWebViewController.Get_ZoomFactor(Result));
end;

procedure TCustomEdgeBrowser.GoBack;
begin
  if FWebView <> nil then
    ProcessHResult(FWebView.GoBack);
end;

procedure TCustomEdgeBrowser.GoForward;
begin
  if FWebView <> nil then
    ProcessHResult(FWebView.GoForward);
end;

function TCustomEdgeBrowser.ICoreWebView2PrintCompletedHandlerInvoke(errorCode: HResult;
  printStatus: COREWEBVIEW2_PRINT_STATUS): HResult;
begin
  Result := S_OK;
  if Assigned(FOnPrintCompleted) then
    FOnPrintCompleted(Self, errorCode, printStatus)
end;

function TCustomEdgeBrowser.ICoreWebView2PrintToPdfCompletedHandlerInvoke(errorCode: HResult;
  isSuccessful: Integer): HResult;
begin
  Result := S_OK;
  if Assigned(FOnPrintToPDFCompleted) then
    FOnPrintToPDFCompleted(Self, errorCode, isSuccessful <> 0)
end;

procedure TCustomEdgeBrowser.InitializeWebView;
var
  LBrowserExecutableFolder, LUserDataFolder: string;
  LEnvironmentOptions: ICoreWebView2EnvironmentOptions;
  LEnvironmentOptions6: ICoreWebView2EnvironmentOptions6;

  function ExpandEnvironmentVariableString(const AString: String): String;
  var
    LCharSize: Integer;
  begin
    LCharSize := ExpandEnvironmentStrings(PChar(AString), nil, 0);
    SetLength(Result, Pred(LCharSize));
    if LCharSize > 1 then
      ExpandEnvironmentStrings(PChar(AString), PChar(Result), LCharSize);
  end;

begin
  // To ensure browser switches get applied correctly, we need to close
  // the existing WebView. This will result in a new browser process
  // getting created which will apply the browser switches.
  FInternalClose := True;
  try
    CloseWebView;
  finally
    FInternalClose := False;
  end;
  // Initialise any settings here
  FSizeRatio := 1.0;
  FWebViewFocusEventActive := False;
  // Expand the browser executable folder in case it contains any environment variables
  LBrowserExecutableFolder := ExpandEnvironmentVariableString(BrowserExecutableFolder);
  // Expand the user data folder in case it contains any environment variables
  LUserDataFolder := ExpandEnvironmentVariableString(UserDataFolder);
  // Create the environment with options
  LEnvironmentOptions := TCoreWebView2EnvironmentOptionsExtended.Create;

  LEnvironmentOptions.Set_AdditionalBrowserArguments(PChar(FAdditionalBrowserArguments));
  LEnvironmentOptions.Set_Language(PChar(FLanguage));
  LEnvironmentOptions.Set_TargetCompatibleBrowserVersion(PChar(FTargetCompatibleBrowserVersion));
  LEnvironmentOptions.Set_AllowSingleSignOnUsingOSPrimaryAccount(Integer(Bool(FAllowSingleSignOnUsingOSPrimaryAccount)));

  if Supports(LEnvironmentOptions, IID_ICoreWebView2EnvironmentOptions6, LEnvironmentOptions6) then begin
    LEnvironmentOptions6.Set_AreBrowserExtensionsEnabled( Integer(Bool((FAreBrowserExtensionsEnabled))) );
  end;


  // Create enviroment
  var hr := CreateCoreWebView2EnvironmentWithOptions(PChar(LBrowserExecutableFolder), PChar(LUserDataFolder), LEnvironmentOptions,
    Callback<HResult, ICoreWebView2Environment>.CreateAs<ICoreWebView2CreateCoreWebView2EnvironmentCompletedHandler>(
      CreateEnvironmentCompleted));
  if not ProcessHResult(hr) and Assigned(FOnCreateWebViewCompleted) then
  begin
    FBrowserControlState := TBrowserControlState.Failed;
    FOnCreateWebViewCompleted(Self, hr);
  end;
end;

function TCustomEdgeBrowser.Navigate(const AUri: string): Boolean;
begin
  Result := False;
  if FWebView = nil then
  begin
    if BrowserControlState = TBrowserControlState.None then
      CreateWebView;
    if AUri.Trim.Length > 0 then
      FLastURI := AUri;
  end
  else
    Result := ProcessHResult(FWebView.Navigate(PChar(AUri)));
end;

function TCustomEdgeBrowser.NavigateToString(const AHTMLContent: string): Boolean;
begin
  Result := False;
  if FWebView <> nil then
    Result := ProcessHResult(FWebView.NavigateToString(PChar(AHTMLContent)));
end;

function TCustomEdgeBrowser.NavigateWithWebResourceRequest(const ARequest: ICoreWebView2WebResourceRequest): Boolean;
var
  LWebView_2: ICoreWebView2_2;
begin
  Result := False;
  if FWebView <> nil then
  begin
    if Supports(FWebView, ICoreWebView2_2, LWebView_2) then
      Result := ProcessHResult(LWebView_2.NavigateWithWebResourceRequest(ARequest));
  end;
end;

function TCustomEdgeBrowser.Print(const PrintSettings: ICoreWebView2PrintSettings): Boolean;
var
  LWebView2_16: ICoreWebView2_16;
begin
  Result := False;
  if Supports(FWebView, ICoreWebView2_16, LWebView2_16) then
    Result := ProcessHResult(LWebView2_16.Print(PrintSettings, Self));
end;

function TCustomEdgeBrowser.PrintToPDF(const ResultFilePath: string; const PrintSettings: ICoreWebView2PrintSettings): Boolean;
var
  LWebView2_7: ICoreWebView2_7;
begin
  Result := False;
  if Supports(FWebView, ICoreWebView2_7, LWebView2_7) then
    Result := ProcessHResult(LWebView2_7.PrintToPdf(PChar(ResultFilePath), PrintSettings, Self));
end;

function TCustomEdgeBrowser.ProcessHResult(AHResult: HResult): Boolean;
begin
  FCritSec.Enter;
  FLastErrorCode := AHResult;
  Result := Succeeded(FLastErrorCode);
  FCritSec.Leave;
end;

procedure TCustomEdgeBrowser.Refresh;
begin
  if FWebView <> nil then
    ProcessHResult(FWebView.Reload);
end;

procedure TCustomEdgeBrowser.ReinitializeWebView;
begin
  if FWebView <> nil then
    FLastURI := LocationURL;
  InitializeWebView;
end;

procedure TCustomEdgeBrowser.ReinitializeWebViewWithNewBrowser;
begin
  CloseBrowserProcess;
  ReinitializeWebView;
end;

procedure TCustomEdgeBrowser.RemoveExtensionByName(ExtensionName: string);
begin
  if FCoreWebViewProfile7 = nil then
    Exit;

  FCoreWebViewProfile7.GetBrowserExtensions(Callback<HResult, ICoreWebView2BrowserExtensionList>.CreateAs<ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler>(
    function(ErrorCode: HResult; List: ICoreWebView2BrowserExtensionList): HResult stdcall
    begin
      Result := S_OK;

      var ACount: cardinal;
      var S: PWIdeChar;
      var Ext: ICoreWebView2BrowserExtension;
      List.Get_Count(ACount);
      for var I := 0 to ACount-1 do begin
        List.GetValueAtIndex(I, Ext);
        Ext.Get_name(S);

        // Remove
        if S = ExtensionName then begin
          Ext.Remove(nil);
          break;
        end;
      end;

    end));
end;

procedure TCustomEdgeBrowser.RemoveExtensionById(ExtensionName: string);
begin
  if FCoreWebViewProfile7 = nil then
    Exit;

  FCoreWebViewProfile7.GetBrowserExtensions(Callback<HResult, ICoreWebView2BrowserExtensionList>.CreateAs<ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler>(
    function(ErrorCode: HResult; List: ICoreWebView2BrowserExtensionList): HResult stdcall
    begin
      Result := S_OK;

      var ACount: cardinal;
      var S: PWIdeChar;
      var Ext: ICoreWebView2BrowserExtension;
      List.Get_Count(ACount);
      for var I := 0 to ACount-1 do begin
        List.GetValueAtIndex(I, Ext);
        Ext.Get_id(S);

        // Remove
        if S = ExtensionName then begin
          Ext.Remove(nil);
          break;
        end;
      end;

    end));
end;

procedure TCustomEdgeBrowser.RemoveWebResourceRequestedFilter(const URL: string;
  ResourceContext: COREWEBVIEW2_WEB_RESOURCE_CONTEXT);
begin
  if FWebView <> nil then
    ProcessHResult(FWebView.RemoveWebResourceRequestedFilter(PChar(URL), ResourceContext));
end;

procedure TCustomEdgeBrowser.Resize;
begin
  inherited;
  if FWebViewController <> nil then
  begin
    var DesiredBounds := ClientRect;
    DesiredBounds.Bottom := Trunc((DesiredBounds.Bottom - DesiredBounds.Top) * FSizeRatio + DesiredBounds.Top);
    DesiredBounds.Right := Trunc((DesiredBounds.Right - DesiredBounds.Left) * FSizeRatio + DesiredBounds.Left);
    ProcessHResult(FWebViewController.Set_Bounds(tagRECT(DesiredBounds)));
  end;
end;

procedure TCustomEdgeBrowser.SetBuiltInErrorPageEnabled(const Value: Boolean);
begin
  if FWebViewSettings <> nil then
    ProcessHResult(FWebViewSettings.Set_IsBuiltInErrorPageEnabled(Integer(LongBool(Value))))
  else
    raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

procedure TCustomEdgeBrowser.SetDefaultContextMenusEnabled(const Value: Boolean);
begin
  if FWebViewSettings <> nil then
    ProcessHResult(FWebViewSettings.Set_AreDefaultContextMenusEnabled(Integer(LongBool(Value))))
  else
    raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

procedure TCustomEdgeBrowser.SetDefaultScriptDialogsEnabled(const Value: Boolean);
begin
  if FWebViewSettings <> nil then
    ProcessHResult(FWebViewSettings.Set_AreDefaultScriptDialogsEnabled(Integer(LongBool(Value))))
  else
    raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

procedure TCustomEdgeBrowser.SetDevToolsEnabled(const Value: Boolean);
begin
  if FWebViewSettings <> nil then
    ProcessHResult(FWebViewSettings.Set_AreDevToolsEnabled(Integer(LongBool(Value))))
  else
    raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

procedure TCustomEdgeBrowser.SetFocus;
begin
  inherited;
  if FWebViewController <> nil then
    ProcessHResult(FWebViewController.MoveFocus(COREWEBVIEW2_MOVE_FOCUS_REASON_PROGRAMMATIC));
end;

procedure TCustomEdgeBrowser.SetScriptEnabled(const Value: Boolean);
begin
  if FWebViewSettings <> nil then
    ProcessHResult(FWebViewSettings.Set_IsScriptEnabled(Integer(LongBool(Value))))
  else
    raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

procedure TCustomEdgeBrowser.SetSizeRatio(const Value: Double);
begin
  FSizeRatio := Value;
  Resize;
end;

procedure TCustomEdgeBrowser.SetStatusBarEnabled(const Value: Boolean);
begin
  if FWebViewSettings <> nil then
    ProcessHResult(FWebViewSettings.Set_IsStatusBarEnabled(Integer(LongBool(Value))))
  else
    raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

procedure TCustomEdgeBrowser.SetWebMessageEnabled(const Value: Boolean);
begin
  if FWebViewSettings <> nil then
    ProcessHResult(FWebViewSettings.Set_IsWebMessageEnabled(Integer(LongBool(Value))))
  else
    raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

procedure TCustomEdgeBrowser.SetZoomControlEnabled(const Value: Boolean);
begin
  if FWebViewSettings <> nil then
    ProcessHResult(FWebViewSettings.Set_IsZoomControlEnabled(Integer(LongBool(Value))))
  else
    raise EEdgeError.CreateRes(@SNoWebView, E_FAIL);
end;

procedure TCustomEdgeBrowser.SetZoomFactor(const Value: Double);
begin
  if FWebViewController <> nil then
    ProcessHResult(FWebViewController.Set_ZoomFactor(Value));
end;

function TCustomEdgeBrowser.ShowPrintUI(PrintUIDialogKind: TPrintUIDialogKind): Boolean;
var
  LWebView2_16: ICoreWebView2_16;
  LPrintDialogKind: COREWEBVIEW2_PRINT_DIALOG_KIND;
begin
  Result := False;
  if Supports(FWebView, ICoreWebView2_16, LWebView2_16) then
  begin
    if PrintUIDialogKind = TPrintUIDialogKind.Browser then
      LPrintDialogKind := COREWEBVIEW2_PRINT_DIALOG_KIND_BROWSER
    else
      LPrintDialogKind := COREWEBVIEW2_PRINT_DIALOG_KIND_SYSTEM;
    Result := ProcessHResult(LWebView2_16.ShowPrintUI(LPrintDialogKind));
  end;
end;

procedure TCustomEdgeBrowser.Stop;
begin
  if FWebView <> nil then
    ProcessHResult(FWebView.Stop);
end;

procedure TCustomEdgeBrowser.SubscribeToCDPEvent(const CDPEventName: string);
begin
  if FWebView = nil then
    Exit;

  var Receiver: ICoreWebView2DevToolsProtocolEventReceiver;
  if ProcessHResult(FWebView.GetDevToolsProtocolEventReceiver(PChar(CDPEventname), Receiver)) then
  begin
    // If we are already subscribed to this event, unsubscribe first.
    var PreExistingToken: EventRegistrationToken;
    if FDevToolsProtocolEventReceivedTokenMap.TryGetValue(CDPEventName, PreExistingToken) then
    begin
      if Receiver <> nil then
        Receiver.remove_DevToolsProtocolEventReceived(PreExistingToken)
    end;
    var Token: EventRegistrationToken;
    // Register a handler for the DevToolsProtocolEventReceived event, specific to the relevant CDP Event.
    ProcessHResult(Receiver.add_DevToolsProtocolEventReceived(
      Callback<ICoreWebView2, ICoreWebView2DevToolsProtocolEventReceivedEventArgs>.CreateAs<ICoreWebView2DevToolsProtocolEventReceivedEventHandler>(
        function(const Webview: ICoreWebView2; const Args: ICoreWebView2DevToolsProtocolEventReceivedEventArgs): HResult stdcall
        begin
          Result := S_OK;
          if Assigned(FOnDevToolsProtocolEventReceived) then
          begin
            var ParameterObjectAsJson: PChar;
            Args.Get_ParameterObjectAsJson(ParameterObjectAsJson);
            var ParameterObjectAsJsonStr: string := ParameterObjectAsJson;
            CoTaskMemFree(ParameterObjectAsJson);
            FOnDevToolsProtocolEventReceived(Self, CDPEventName, ParameterObjectAsJsonStr);
          end;
        end
      ),
      Token));
    FDevToolsProtocolEventReceivedTokenMap.TryAdd(CDPEventName, Token);
  end;
end;

procedure TCustomEdgeBrowser.WaitForWebViewEvent(var EndSignal: boolean;
  Timeout: integer);
var
  Cycles: integer;
begin
  Cycles := 0;
  while not EndSignal do begin
    Sleep(1);
    Application.ProcessMessages;

    // Time
    if Timeout > 0 then begin
      Inc(Cycles);
      if Cycles >= Timeout then
        break;
    end;
  end;
end;

procedure TCustomEdgeBrowser.CMParentVisibleChanged(var &Message: TMessage);
begin
  inherited;
  if FWebViewController <> nil then
    ProcessHResult(FWebViewController.Set_IsVisible(Integer(LongBool(Visible))));
end;

procedure TCustomEdgeBrowser.CMSysCommand(var &Message: TWMSysCommand);
begin
  if FWebViewController <> nil then
    case &Message.CmdType and $FFF0 of
      SC_MINIMIZE:
        ProcessHResult(FWebViewController.Set_IsVisible(Integer(LongBool(False))));
      SC_RESTORE, SC_MAXIMIZE:
        if Visible then
          ProcessHResult(FWebViewController.Set_IsVisible(Integer(LongBool(True))));
    end
end;

{ EEdgeError }

constructor EEdgeError.Create(const Message: UnicodeString; ErrorCode: HRESULT);
begin
  inherited Create(Message, ErrorCode, 0)
end;

constructor EEdgeError.CreateRes(ResStringRec: PResStringRec; ErrorCode: HRESULT);
begin
  inherited Create(LoadResString(ResStringRec), ErrorCode, 0)
end;

{ TDownloadStartingEventArgs }

constructor TDownloadStartingEventArgs.Create(const Args: ICoreWebView2DownloadStartingEventArgs);
begin
  FArgsInterface := Args;
end;

{ TNavigationStartingEventArgs }

constructor TNavigationStartingEventArgs.Create(const Args: ICoreWebView2NavigationStartingEventArgs);
begin
  FArgsInterface := Args;
end;

{ TNewWindowRequestedEventArgs }

constructor TNewWindowRequestedEventArgs.Create(const Args: ICoreWebView2NewWindowRequestedEventArgs);
begin
  FArgsInterface := Args;
end;

{ TPermissionRequestedEventArgs }

constructor TPermissionRequestedEventArgs.Create(const Args: ICoreWebView2PermissionRequestedEventArgs);
begin
  FArgsInterface := Args;
end;

{ TScriptDialogOpeningEventArgs }

constructor TScriptDialogOpeningEventArgs.Create(const Args: ICoreWebView2ScriptDialogOpeningEventArgs);
begin
  FArgsInterface := Args;
end;

{ TWebMessageReceivedEventArgs }

constructor TWebMessageReceivedEventArgs.Create(const Args: ICoreWebView2WebMessageReceivedEventArgs);
begin
  FArgsInterface := Args;
end;

{ TWebResourceRequestedEventArgs }

constructor TWebResourceRequestedEventArgs.Create(const Args: ICoreWebView2WebResourceRequestedEventArgs);
begin
  FArgsInterface := Args;
end;

{ TCoreWebView2EnvironmentOptionsExtended }

class function TCoreWebView2EnvironmentOptionsExtended.BOOLToInt(Value: BOOL): Integer;
begin
  // BOOL aka LongBool uses 0 for False and non-zero for True.
  // Specifically Delphi will assign the value of -1 (VARIANT_TRUE in C) for True when assigning to LongBool.
  // Note that WebView2 likes a BOOL value of TRUE to be 1, so we must take care not to cast BOOL to Integer.
  // See also: https://devblogs.microsoft.com/oldnewthing/20041222-00/?p=36923
  if Value then
    Result := 1
  else
    Result := 0;
end;

class function TCoreWebView2EnvironmentOptionsExtended.AllocCOMString(const DelphiString: string): PChar;
begin
  // In this class the caller (WebView2) will free the allocated memory
  var DelphiStringLength := Succ(DelphiString.Length);
  Result := CoTaskMemAlloc(DelphiStringLength * SizeOf(Char));
  StringToWideChar(DelphiString, Result, DelphiStringLength);
end;

function TCoreWebView2EnvironmentOptionsExtended.Get_AdditionalBrowserArguments(out value: PWideChar): HResult;
begin
  try
    value := AllocCOMString(FAdditionalBrowserArguments);
    Result := S_OK
  except
    Result := E_FAIL
  end;
end;

function TCoreWebView2EnvironmentOptionsExtended.Get_Language(out value: PWideChar): HResult;
begin
  try
    value := AllocCOMString(FLanguage);
    Result := S_OK
  except
    Result := E_FAIL
  end;
end;

function TCoreWebView2EnvironmentOptionsExtended.Get_TargetCompatibleBrowserVersion(out value: PWideChar): HResult;
begin
  try
    value := AllocCOMString(FTargetCompatibleBrowserVersion);
    Result := S_OK
  except
    Result := E_FAIL
  end;
end;

function TCoreWebView2EnvironmentOptionsExtended.Get_AllowSingleSignOnUsingOSPrimaryAccount(out allow: Integer): HResult;
begin
  try
    allow := BOOLToInt(FAllowSingleSignOnUsingOSPrimaryAccount);
    Result := S_OK
  except
    Result := E_FAIL
  end;
end;

function TCoreWebView2EnvironmentOptionsExtended.Get_AreBrowserExtensionsEnabled(
  out AreBrowserExtensionsEnabled: Integer): HResult;
begin
  try
    AreBrowserExtensionsEnabled := BOOLToInt(FAreBrowserExtensionsEnabled);
    Result := S_OK
  except
    Result := E_FAIL
  end;
end;

function TCoreWebView2EnvironmentOptionsExtended.Set_AdditionalBrowserArguments(value: PWideChar): HResult;
begin
  try
    FAdditionalBrowserArguments := string(value);
    Result := S_OK
  except
    Result := E_FAIL
  end;
end;

function TCoreWebView2EnvironmentOptionsExtended.Set_Language(value: PWideChar): HResult;
begin
  try
    FLanguage := string(value);
    Result := S_OK
  except
    Result := E_FAIL
  end;
end;

function TCoreWebView2EnvironmentOptionsExtended.Set_TargetCompatibleBrowserVersion(value: PWideChar): HResult;
begin
  try
    FTargetCompatibleBrowserVersion := string(value);
    Result := S_OK
  except
    Result := E_FAIL
  end;
end;

function TCoreWebView2EnvironmentOptionsExtended.Set_AllowSingleSignOnUsingOSPrimaryAccount(allow: Integer): HResult;
begin
  try
    FAllowSingleSignOnUsingOSPrimaryAccount := BOOL(allow);
    Result := S_OK
  except
    Result := E_FAIL
  end;
end;

function TCoreWebView2EnvironmentOptionsExtended.Set_AreBrowserExtensionsEnabled(
  AreBrowserExtensionsEnabled: Integer): HResult;
begin
  try
    FAreBrowserExtensionsEnabled := BOOL(AreBrowserExtensionsEnabled);
    Result := S_OK
  except
    Result := E_FAIL
  end;
end;

end.
