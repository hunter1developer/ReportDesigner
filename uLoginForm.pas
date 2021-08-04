unit uLoginForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, Data.DB, uDAInterfaces, uDADataTable, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, cxDBEdit, System.Actions;

type
  TfrmLogin = class(TForm)
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnLogin: TButton;
    alLoginForm: TActionList;
    actnLogin: TAction;
    pnlMain: TPanel;
    edtUserId: TEdit;
    edtPassword: TEdit;
    lblUserId: TLabel;
    lblPassword: TLabel;
    procedure actnLoginExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ShowLoginDialog: Boolean;

var
  frmLogin: TfrmLogin;

implementation

uses
  uZasioVClient,
  uCommonUtils;

{$R *.dfm}

function ShowLoginDialog: Boolean;
begin
  with TfrmLogin.Create(nil) do
  try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TfrmLogin.actnLoginExecute(Sender: TObject);
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

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtUserId.Text := ZasioVClient.Settings.LastUserId;
  if edtUserId.Text = EmptyStr then
    edtUserId.SetFocus
  else
    edtPassword.SetFocus;

  {$REGION Test code}
//  edtUserId.Text := 'zei@11';
//  edtPassword.Text := 'zei';
  {$ENDREGION}
end;

end.
