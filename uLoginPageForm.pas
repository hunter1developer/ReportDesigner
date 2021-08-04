unit uLoginPageForm;

interface

uses
  ActiveX,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls,Inifiles,
  ExtCtrls, ActnList;

type
  TLoginPage = class(TForm)
    Panel1: TPanel;
    Timer1: TTimer;
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
  private
    { Private declarations }
    FOwnerWnd: HWND;
    fServerAddr: string;
    fCloseWindowTime: integer;
    fConnection: string;
    fUsername : string;
    fUserPass : string;
    fUserCompId: string;
    fSamlResponse: string;
    fFlagGetResponse: string;
    fCloseState: TModalResult;
    fCheckState: Boolean;
    FOleInPlaceActiveObject: IOleInPlaceActiveObject;
    procedure MsgHandler(var Msg: TMsg; var Handled: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(const AOwnerWnd: HWND); reintroduce;
    { Public declarations }
    property ServerAddr: string read fServerAddr write fServerAddr;
    property CheckState: Boolean read fCheckState write fCheckState;
    property CloseWindowTime: integer read fCloseWindowTime write fCloseWindowTime;
    property Connection: string read fConnection write fConnection;
    property Username : string read fUsername write fUsername;
    property UserPass : string read fUserPass write fUserPass;
    property UserCompId: string read fUserCompId write fUserCompId;
    property SamlResponse: string read fSamlResponse write fSamlResponse;
    property FlagGetResponse: string read fFlagGetResponse write fFlagGetResponse;
    procedure Connect; overload;
    procedure Connect(aUrl: string); overload;
    procedure GetDecryptValues;
    procedure CheckAllValues;
    procedure CheckUserValue;
  end;

var
  LoginPage: TLoginPage;

implementation

Uses MSHTML, ComObj, Math;

{$R *.dfm}

function GetModuleFileName(const hModule: HMODULE): String;
var
  lpBuffer: PChar;
begin
  GetMem(lpBuffer, MAX_PATH + 1);
  try
    if Windows.GetModuleFileName(hModule, lpBuffer, MAX_PATH) > 0 then
    begin
      Result := lpBuffer;
    end else
    begin
      Result := '';
    end;
  finally
    FreeMem(lpBuffer);
  end;
end;

function GetCurrentModuleFileName: String;
begin
  Result := GetModuleFileName(hInstance);
end;




function WideStringToString(const ws: WideString; codePage: Word):
AnsiString;
var
  l: integer;
begin
  if ws = '' then
    Result := ''
  else begin
    l := WideCharToMultiByte(codePage,
           WC_COMPOSITECHECK or
           WC_DISCARDNS or
           WC_SEPCHARS or
           WC_DEFAULTCHAR,
           @ws[1], -1, nil, 0, nil, nil);
    SetLength(Result, l-1);
    if l > 1 then
      WideCharToMultiByte(codePage,
        WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
        @ws[1], -1, @Result[1], l-1, nil, nil);
  end;
end;



procedure TLoginPage.Connect;
begin
  WebBrowser1.Navigate(fServerAddr);

end;

procedure TLoginPage.GetDecryptValues;
begin

end;


procedure TLoginPage.FormCreate(Sender: TObject);
begin
  fConnection:=EmptyStr;
  fUsername:=EmptyStr;
  fUserPass:=EmptyStr;
  fUserCompId:=EmptyStr;
  fSamlResponse := EmptyStr;
end;

procedure TLoginPage.CheckAllValues;
begin
  if (fSamlResponse=EmptyStr) and (fFlagGetResponse=EmptyStr) then
    Exit;

  if (fSamlResponse <> EmptyStr) and
     (fFlagGetResponse <> 'N') then
  begin
    Timer1.Interval:=fCloseWindowTime;
    Timer1.Enabled:=True;
    fCloseState:=mrOk;
  end
  else
  begin
    Timer1.Interval:=fCloseWindowTime;
    Timer1.Enabled:=True;
    fCloseState:=mrCancel;
  end;
end;

procedure TLoginPage.CheckUserValue;
begin
  if (fSamlResponse = EmptyStr) then
    Exit;
  if (fFlagGetResponse = 'Y') then
   begin
         Timer1.Interval:=fCloseWindowTime;
         Timer1.Enabled:=True;
         fCloseState:=mrOk;
   end
   else
   begin
       Timer1.Interval:=fCloseWindowTime;
       Timer1.Enabled:=True;
       fCloseState:=mrCancel;
  end;
end;


procedure TLoginPage.Connect(aUrl: string);
begin
  WebBrowser1.Navigate(aUrl);
end;

constructor TLoginPage.Create(const AOwnerWnd: HWND);
begin
  FOwnerWnd := AOwnerWnd;
  Application.OnMessage := MsgHandler;
  inherited Create(nil);
end;

procedure TLoginPage.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := FOwnerWnd;
end;

procedure TLoginPage.Timer1Timer(Sender: TObject);
var
  fIni: TIniFile;
begin
   fIni:=TIniFile.Create(ExtractFileDir(GetCurrentModuleFileName)+'\zSaml.ini');
    try
      fIni.WriteInteger('Position','Left',Self.Left);
      fIni.WriteInteger('Position','Top',Self.Top);
      fIni.WriteInteger('Position','Width',Self.Width);
      fIni.WriteInteger('Position','Height',Self.Height);
    finally
      fIni.Free;
    end;
//  if (fFlagGetResponse = 'Y') then
//    ModalResult := mrOk;
    ModalResult:=fCloseState;
end;



procedure TLoginPage.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
var
  tmpIWebBrowser2: IWebBrowser2;
  tmpIHTMLDocument2: IHTMLDocument2;
  tmpIForms: IHTMLElementCollection;
  tmpIFormElement: IHTMLFormElement;
  tmpIHTMLInputHiddenElement: IHTMLInputHiddenElement;
  DecodedValues: string;
begin
  DecodedValues:='Received values'+#13#10;
  tmpIWebBrowser2 := WebBrowser1.ControlInterface;
  if tmpIWebBrowser2 <> nil then
  try
    try
      if Supports(tmpIWebBrowser2.Document, IHTMLDocument2, tmpIHTMLDocument2) then
      try
        tmpIForms := tmpIHTMLDocument2.forms;
        if tmpIForms <> nil then
        try
          if Supports(tmpIForms.item('zasio_login_form', Unassigned), IHTMLFormElement,  tmpIFormElement) then
          try
            if Supports(tmpIFormElement.item('SAMLResponse', Unassigned), IHTMLInputHiddenElement, tmpIHTMLInputHiddenElement) then
            try
              fSamlResponse := tmpIHTMLInputHiddenElement.value;
            finally
              tmpIHTMLInputHiddenElement := nil;
            end;

            if Supports(tmpIFormElement.item('IsGetResponse', Unassigned), IHTMLInputHiddenElement, tmpIHTMLInputHiddenElement) then
            try
              fFlagGetResponse :=tmpIHTMLInputHiddenElement.value;
            finally
              tmpIHTMLInputHiddenElement := nil;
            end;
          finally
            tmpIFormElement := nil;
          end;
          if CheckState=True then
            CheckAllValues
          else
            CheckUserValue;
        finally
          tmpIForms := nil;
        end;
      finally
        tmpIHTMLDocument2 := nil;
      end;
    except
      // keep silence
    end;
  finally
    tmpIWebBrowser2 := nil;
  end;
end;

procedure TLoginPage.MsgHandler(var Msg: TMsg; var Handled: Boolean);
const
  StdKeys = [VK_BACK, VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT];
var IOIPAO: IOleInPlaceActiveObject;
  Dispatch: IDispatch;
begin
  if WebBrowser1 = nil then
  begin
    Handled := False;
    Exit;
  end;
  Handled := (IsDialogMessage(WebBrowser1.Handle, Msg) = True);
  if (Handled) and (not WebBrowser1.Busy) then
  begin
    if FOleInPlaceActiveObject = nil then
    begin
      Dispatch := WebBrowser1.Application;
      if Dispatch <> nil then
      begin
        Dispatch.QueryInterface(IOleInPlaceActiveObject, IOIPAO);
        if IOIPAO <> nil then FOleInPlaceActiveObject := IOIPAO;
      end;
    end;
    if FOleInPlaceActiveObject <> nil then
      if ((Msg.message = WM_KEYDOWN) or (Msg.message = WM_KEYUP)) and
        (Msg.wParam in StdKeys) then
        //nothing  -  do not pass on Backspace, Left, Right, Up, Down arrows
      else FOleInPlaceActiveObject.TranslateAccelerator(Msg);
  end;
end;


procedure TLoginPage.FormDestroy(Sender: TObject);
begin
  FOleInPlaceActiveObject := nil;
end;

initialization
  CoInitialize(nil);
  OleInitialize(nil);
finalization
  CoUnInitialize;
  OleUninitialize;

end.
