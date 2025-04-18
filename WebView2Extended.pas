unit WebView2Extended;


interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Winapi.ActiveX,
  WebView2;

const
IID_ICoreWebView2EnvironmentOptions6: TGUID = '{57D29CC3-C84F-42A0-B0E2-EFFBD5E179DE}';
IID_ICoreWebView2Profile7: TGUID = '{7B4C7906-A1AA-4CB4-B723-DB09F813D541}';
IID_ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler: TGUID = '{FCE16A1C-F107-4601-8B75-FC4940AE25D0}';
IID_ICoreWebView2ProfileAddBrowserExtensionCompletedHandler: TGUID = '{DF1AAB27-82B9-4AB6-AAE8-017A49398C14}';
IID_ICoreWebView2BrowserExtension: TGUID = '{7EF7FFA0-FAC5-462C-B189-3D9EDBE575DA}';
IID_ICoreWebView2BrowserExtensionEnableCompletedHandler: TGUID = '{30C186CE-7FAD-421F-A3BC-A8EAF071DDB8}';
IID_ICoreWebView2BrowserExtensionRemoveCompletedHandler: TGUID = '{8E41909A-9B18-4BB1-8CDF-930F467A50BE}';
IID_ICoreWebView2BrowserExtensionList: TGUID = '{2EF3D2DC-BD5F-4F4D-90AF-FD67798F0C2F}';
IID_ICoreWebView2Profile8: TGUID = '{FBF70C2F-EB1F-4383-85A0-163E92044011}';
IID_ICoreWebView2ProfileDeletedEventHandler: TGUID = '{DF35055D-772E-4DBE-B743-5FBF74A2B258}';

type
  ICoreWebView2EnvironmentOptions6 = interface(IUnknown)
    ['{57D29CC3-C84F-42A0-B0E2-EFFBD5E179DE}']
    function Get_AreBrowserExtensionsEnabled(out AreBrowserExtensionsEnabled: Integer): HResult; stdcall;
    function Set_AreBrowserExtensionsEnabled(AreBrowserExtensionsEnabled: Integer): HResult; stdcall;
  end;

  ICoreWebView2BrowserExtensionEnableCompletedHandler = interface(IUnknown)
    ['{30C186CE-7FAD-421F-A3BC-A8EAF071DDB8}']
    function Invoke(errorCode: HResult):HResult;
  end;

  ICoreWebView2BrowserExtensionRemoveCompletedHandler = interface(IUnknown)
    ['{8E41909A-9B18-4BB1-8CDF-930F467A50BE}']
     function Invoke(errorCode: HResult): HResult;
  end;

  ICoreWebView2BrowserExtension = interface(IUnknown)
    ['{7EF7FFA0-FAC5-462C-B189-3D9EDBE575DA}']
    function Get_id(out value: PWideChar):HResult;
    function Get_name(out value: PWideChar):HResult;
    function Remove(const handler: ICoreWebView2BrowserExtensionRemoveCompletedHandler):HResult;
    function Get_IsEnabled(out value: Integer):HResult;
    function Enable(IsEnabled: Integer; const handler: ICoreWebView2BrowserExtensionEnableCompletedHandler):HResult;
  end;

  ICoreWebView2ProfileAddBrowserExtensionCompletedHandler = interface(IUnknown)
    ['{DF1AAB27-82B9-4AB6-AAE8-017A49398C14}']
      function Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtension):HResult;
  end;

  ICoreWebView2BrowserExtensionList = interface(IUnknown)
    ['{2EF3D2DC-BD5F-4F4D-90AF-FD67798F0C2F}']
    function Get_Count(out value: SYSUINT):HResult;
    function GetValueAtIndex(index: SYSUINT; out value: ICoreWebView2BrowserExtension):HResult;
  end;

  ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler = interface(IUnknown)
    ['{FCE16A1C-F107-4601-8B75-FC4940AE25D0}']
     function Invoke(errorCode: HResult; const result_: ICoreWebView2BrowserExtensionList):HResult;
  end;

  ICoreWebView2Profile7 = interface(ICoreWebView2Profile6)
    ['{7B4C7906-A1AA-4CB4-B723-DB09F813D541}']
    function AddBrowserExtension(extensionFolderPath: PWideChar;
      const handler: ICoreWebView2ProfileAddBrowserExtensionCompletedHandler): HResult;
    function GetBrowserExtensions(const handler: ICoreWebView2ProfileGetBrowserExtensionsCompletedHandler): HResult;
  end;

  ICoreWebView2ProfileDeletedEventHandler = interface(IUnknown)
    ['{DF35055D-772E-4DBE-B743-5FBF74A2B258}']
    function Invoke(const sender: ICoreWebView2Profile; const args: IUnknown):HResult;
  end;

  ICoreWebView2Profile8 = interface(ICoreWebView2Profile7)
    ['{FBF70C2F-EB1F-4383-85A0-163E92044011}']
    function Delete: HResult;
    function add_Deleted(const eventHandler: ICoreWebView2ProfileDeletedEventHandler; out token: EventRegistrationToken):HResult;
    function remove_Deleted(token: EventRegistrationToken):HResult;
  end;

implementation

end.
