unit VK.VCL.OAuth2;

interface

uses
  Windows, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.OleCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, SHDocVw;

type
  TFormOAuth2 = class;

  TAuthResult = reference to procedure(From: TFormOAuth2);

  TFormOAuth2 = class(TForm)
    Browser: TWebBrowser;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure BrowserNavigateComplete2(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BrowserFileDownload(ASender: TObject; ActiveDocument: WordBool; var Cancel: WordBool);
  private
    FLastTitle: string;
    FProxyUserName: string;
    FProxyPassword: string;
    FLastURL: string;
    FBrakeAll: Boolean;
    FIsError: Boolean;
    FToken: string;
    FTokenExpiry: Int64;
    FChangePasswordHash: string;
    FProc: TAuthResult;
    procedure SetIsError(const Value: Boolean);
    procedure FAfterRedirect(const AURL: string; var DoCloseWebView: Boolean);
    procedure SetToken(const Value: string);
    procedure SetTokenExpiry(const Value: Int64);
    procedure SetChangePasswordHash(const Value: string);
  public
    procedure ShowWithURL(const AURL: string; Modal: Boolean); overload;
    procedure ShowWithURL(AParent: TWinControl; const AURL: string; Modal: Boolean); overload;
    procedure SetProxy(Server: string; Port: Integer; UserName: string = ''; Password: string = '');
    property LastTitle: string read FLastTitle;
    property LastURL: string read FLastURL;
    property IsError: Boolean read FIsError write SetIsError;
    property Token: string read FToken write SetToken;
    property TokenExpiry: Int64 read FTokenExpiry write SetTokenExpiry;
    property ChangePasswordHash: string read FChangePasswordHash write SetChangePasswordHash;
    class procedure Execute(Url: string; Proc: TAuthResult; Modal: Boolean = False); static;
  end;

var
  FormOAuth2: TFormOAuth2;

procedure DeleteCache(URLContains: string);

procedure FixIE;

implementation

uses
  WinInet, Registry, UrlMon, DateUtils, System.Net.HttpClient;

{$R *.dfm}

class procedure TFormOAuth2.Execute(Url: string; Proc: TAuthResult; Modal: Boolean);
var
  Form: TFormOAuth2;
begin
  Form := TFormOAuth2.Create(nil);
  Form.FProc := Proc;
  Form.ShowWithURL(nil, Url, Modal);
end;

procedure TFormOAuth2.SetChangePasswordHash(const Value: string);
begin
  FChangePasswordHash := Value;
end;

procedure TFormOAuth2.SetIsError(const Value: Boolean);
begin
  FIsError := Value;
end;

procedure TFormOAuth2.SetProxy(Server: string; Port: Integer; UserName: string; Password: string);
var
  PIInfo: PInternetProxyInfo;
begin
  New(PIInfo);
  PIInfo^.dwAccessType := INTERNET_OPEN_TYPE_PROXY;
  PIInfo^.lpszProxy := PAnsiChar(AnsiString(Server + ':' + Port.ToString));
  PIInfo^.lpszProxyBypass := '';
  UrlMkSetSessionOption(INTERNET_OPTION_PROXY, PIInfo, SizeOf(Internet_Proxy_Info), 0);
  Dispose(PIInfo);
  FProxyUserName := UserName;
  FProxyPassword := Password;
end;

procedure TFormOAuth2.SetToken(const Value: string);
begin
  FToken := Value;
end;

procedure TFormOAuth2.SetTokenExpiry(const Value: Int64);
begin
  FTokenExpiry := Value;
end;

procedure FixIE;
const
  IEVersion = 11001;
var
  Reg: TRegistry;
begin
  Reg := TRegIniFile.Create(KEY_WRITE);
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION', True) then
  begin
    try
      Reg.WriteInteger(ExtractFileName(Application.ExeName), IEVersion);
    except
    end;
  end;
  Reg.CloseKey;
  Reg.Free;
end;

procedure DeleteCache;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
begin
  dwEntrySize := 0;
  FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);
  GetMem(lpEntryInfo, dwEntrySize);
  if dwEntrySize > 0 then
    lpEntryInfo^.dwStructSize := dwEntrySize;
  hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
  if hCacheDir <> 0 then
  begin
    repeat
      if (URLContains = '') or (Pos(URLContains, lpEntryInfo^.lpszSourceUrlName) <> 0) then
        DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
      FreeMem(lpEntryInfo, dwEntrySize);
      dwEntrySize := 0;
      FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
      GetMem(lpEntryInfo, dwEntrySize);
      if dwEntrySize > 0 then
        lpEntryInfo^.dwStructSize := dwEntrySize;
    until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize);
  end;
  FreeMem(lpEntryInfo, dwEntrySize);
  FindCloseUrlCache(hCacheDir);
end;

procedure TFormOAuth2.BrowserFileDownload(ASender: TObject; ActiveDocument: WordBool; var Cancel: WordBool);
begin
  Cancel := False;
end;

procedure TFormOAuth2.BrowserNavigateComplete2(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
var
  LDoCloseForm: Boolean;
begin
  FLastURL := VarToStrDef(URL, '');
  LDoCloseForm := False;

  FAfterRedirect(FLastURL, LDoCloseForm);

  if LDoCloseForm then
  begin
    Close;
  end;
end;

procedure TFormOAuth2.FAfterRedirect(const AURL: string; var DoCloseWebView: Boolean);
var
  i: integer;
  Str: string;
  Params: TStringList;
begin
  i := Pos('#access_token=', AURL);
  if (i = 0) then
    i := Pos('&access_token=', AURL);
  if (i <> 0) and (FToken.IsEmpty) then
  begin
    Str := AURL;
    Delete(Str, 1, i);
    Params := TStringList.Create;
    try
      Params.Delimiter := '&';
      Params.DelimitedText := Str;
      FChangePasswordHash := Params.Values['change_password_hash'];
      FToken := Params.Values['access_token'];
      if Params.IndexOf('expires_in') >= 0 then
        FTokenExpiry := StrToInt(Params.Values['expires_in'])
      else
        FTokenExpiry := 0;
      DoCloseWebView := True;
    finally
      Params.Free;
    end;
  end;
end;

procedure TFormOAuth2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FProc(Self);
  Action := caFree;
end;

procedure TFormOAuth2.FormCreate(Sender: TObject);
begin
  FLastTitle := '';
  FIsError := False;
  FBrakeAll := False;
  FLastURL := '';
  FixIE;
end;

procedure TFormOAuth2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) then
  begin
    Close;
  end;
end;

procedure TFormOAuth2.ShowWithURL(AParent: TWinControl; const AURL: string; Modal: Boolean);
var
  S: string;
begin
  if Assigned(AParent) then
  begin
    SetParent(AParent);
    Align := alClient;
    BorderStyle := bsNone;
  end
  else
  begin
    SetParent(nil);
    Align := alNone;
    BorderStyle := bsSizeable;
  end;

  FLastURL := AURL;
  FToken := '';
  FTokenExpiry := 0;

  if not FProxyUserName.IsEmpty then
  begin
    //Base64EncodeStr(FProxyUserName + ':' + FProxyPassword, S);
    Browser.Navigate2(AURL, EmptyParam{Flags}, EmptyParam{TargetFrameName}, EmptyParam{PostData},
      'Proxy-Authorization: BASIC ' + S + #13#10 + 'X-StopHandling: 1' + #13#10);
  end
  else
    Browser.Navigate(AURL);

  if Modal then
    ShowModal
  else
  begin
    Show;
  end;
end;

procedure TFormOAuth2.ShowWithURL(const AURL: string; Modal: Boolean);
begin
  ShowWithURL(nil, AURL, Modal);
end;

end.

