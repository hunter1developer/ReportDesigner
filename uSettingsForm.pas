unit uSettingsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxSpinEdit, Vcl.ActnList, System.Actions;

type
  TfrmSettings = class(TForm)
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    pnlMain: TPanel;
    lblServerAddress: TLabel;
    lblServerPort: TLabel;
    spnServerPort: TcxSpinEdit;
    edtServerAddress: TcxTextEdit;
    alSettings: TActionList;
    actnSave: TAction;
    btnTestConnection: TButton;
    actnTestConnection: TAction;
    chbSamlAuth: TCheckBox;
    procedure actnSaveExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actnTestConnectionExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ShowSettingsDialog: Boolean;

var
  frmSettings: TfrmSettings;

implementation

uses
  uMainForm,
  uZasioVClient,
  uCommonUtils;

{$R *.dfm}

function ShowSettingsDialog: Boolean;
begin
  with TfrmSettings.Create(nil) do
  try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TfrmSettings.actnSaveExecute(Sender: TObject);
begin
  ZasioVClient.Settings.ServerAddress := edtServerAddress.Text;
  ZasioVClient.Settings.ServerPort := spnServerPort.Value;
  ZasioVClient.Settings.SamlAuthentication := chbSamlAuth.Checked;
  ZasioVClient.PrepareServerAddress;
  ModalResult := mrOk;
end;

procedure TfrmSettings.actnTestConnectionExecute(Sender: TObject);
begin
  try
    ZasioVClient.SetTestServerAddress(edtServerAddress.Text, spnServerPort.Value);
    ZasioVClient.CheckDownloadInstallVersion(frmMain.Version);
  except
    Exit;
  end;

  if ZasioVClient.TestConnection(edtServerAddress.Text, spnServerPort.Value) then
    TCommonUtils.ShowInfoMessage('Server successfully responded');
end;

procedure TfrmSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ZasioVClient.TypeConnect := tcWork;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
begin
  edtServerAddress.Text := ZasioVClient.Settings.ServerAddress;
  spnServerPort.Value := ZasioVClient.Settings.ServerPort;
  ZasioVClient.TypeConnect := tcTest;
  chbSamlAuth.Checked := ZasioVClient.Settings.SamlAuthentication;
end;

end.
