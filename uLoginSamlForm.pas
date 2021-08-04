unit uLoginSamlForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, zeiAccessControlFile;

type
  TfrmSamlLogin = class(TForm)
    pnlMain: TPanel;
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnNext: TButton;
    alLoginForm: TActionList;
    actnLogin: TAction;
    actnNext: TAction;
    NotebookPages: TNotebook;
    Label1: TLabel;
    Label3: TLabel;
    edtUserId: TEdit;
    chbRememberMe: TCheckBox;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtPassword: TEdit;
    lblUserId: TLabel;
    lblChangeUserId: TLabel;
    actnChangeUserID: TAction;
    btnLogin: TButton;
    procedure actnChangeUserIDExecute(Sender: TObject);
    procedure actnNextExecute(Sender: TObject);
    procedure actnLoginExecute(Sender: TObject);
    procedure lblChangeUserIdClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure SelectPage(const NamePage: string); overload;
    function IsSamlAuthentication(const UserCloudId: string): boolean;
    function GetSamlIdpName(const UserCloudId: string): string;
    function CheckUserCloudId(const UserCloudId: string): boolean;
    function EncodeString(const AText: string): string;
    function DecodeString(const AText: string): string;
  public
    { Public declarations }
  end;

  function ShowLoginSamlDialog: Boolean;

var
  frmSamlLogin: TfrmSamlLogin;

implementation

uses
  uZasioVClient,
  uCommonUtils,
  uMainForm;

{$R *.dfm}

function ShowLoginSamlDialog: Boolean;
begin
  with TfrmSamlLogin.Create(nil) do
  try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TfrmSamlLogin.actnChangeUserIDExecute(Sender: TObject);
begin
  SelectPage('UserID');
end;

procedure TfrmSamlLogin.actnLoginExecute(Sender: TObject);
begin
  if Trim(edtUserId.Text) = EmptyStr then
  begin
    TCommonUtils.ShowWarningMessage('User name can not be empty!');
    Exit;
  end;

  if Trim(edtPassword.Text) = EmptyStr then
  begin
    TCommonUtils.ShowWarningMessage('Password can not be empty!');
    Exit;
  end;

  if ZasioVClient.Login(edtUserId.Text, edtPassword.Text) then begin
    ZasioVClient.Settings.LastUserId := edtUserID.Text;
    ModalResult := mrOK;
  end;
end;

procedure TfrmSamlLogin.actnNextExecute(Sender: TObject);
var
  tmpUserId: string;
  tmpIdpName: string;
begin
  if chbRememberMe.Checked then
    ZasioVClient.UserCloudIdRegistry := EncodeString(edtUserId.Text)
  else
    ZasioVClient.UserCloudIdRegistry := EmptyStr;

  if CheckUserCloudId(edtUserId.Text) then begin
    if not ZasioVClient.Settings.SamlAuthentication then begin
      SelectPage('Login');
      Exit;
    end;

    if IsSamlAuthentication(edtUserId.Text) then begin
      tmpIdpName := GetSamlIdpName(edtUserId.Text);
      tmpUserId := VarToStr(ZasioVClient.GetSAMLUserID(tmpIdpName));
      if (tmpUserId <> EmptyStr) and (ZasioVClient.LoginSSO(tmpUserId)) then begin
        ModalResult := mrOk;
      end
      else begin
        TCommonUtils.ShowErrorMessage('SAML Authentication FAILURE!');
        Exit;
      end;
    end
    else
      SelectPage('Login');
  end
  else
    TCommonUtils.ShowErrorMessage(Format('UserID: %s is FAILURE!',[edtUserId.Text]));
end;

function TfrmSamlLogin.CheckUserCloudId(const UserCloudId: string): boolean;
begin
  Result := ZasioVClient.CheckCloudUserId(UserCloudId);
end;

function TfrmSamlLogin.DecodeString(const AText: string): string;
begin
  Result := TzeiAccessControlFile3.DecryptString(AText);
end;

function TfrmSamlLogin.EncodeString(const AText: string): string;
begin
  Result := TzeiAccessControlFile3.EncryptString(AText);
end;

procedure TfrmSamlLogin.FormShow(Sender: TObject);
var
  tmpUserId: string;
begin
  tmpUserId := DecodeString(ZasioVClient.UserCloudIdRegistry);
  SelectPage('UserID');
  if tmpUserId <> EmptyStr then begin
    chbRememberMe.Checked := true;
    edtUserId.Text := tmpUserId;
  end;
end;

function TfrmSamlLogin.GetSamlIdpName(const UserCloudId: string): string;
begin
  Result := ZasioVClient.GetSamlIdpName(UserCloudId);
end;

function TfrmSamlLogin.IsSamlAuthentication(const UserCloudId: string): boolean;
begin
  Result := ZasioVClient.CheckSamlAuthentication(UserCloudId);
end;

procedure TfrmSamlLogin.lblChangeUserIdClick(Sender: TObject);
begin
  SelectPage('UserID');
end;

procedure TfrmSamlLogin.SelectPage(const NamePage: string);
begin
  NotebookPages.ActivePage := NamePage;
  if NamePage = 'UserID' then begin
    btnNext.Visible := true;
    btnLogin.Visible := false;
  end;
  if NamePage = 'Login' then begin
    lblUserId.Caption := edtUserId.Text;
    btnNext.Visible := false;
    btnLogin.Visible := true;
  end;
end;


end.
