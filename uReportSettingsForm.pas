unit uReportSettingsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls,
  uReportSettingsFrame, System.Actions;

type
  TfrmReportSettings = class(TForm)
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    alReportSettings: TActionList;
    actnOk: TAction;
    frmReportSettings: TframeReportSettings;
    pnlMain: TPanel;
    procedure actnOkExecute(Sender: TObject);
    procedure actnOkUpdate(Sender: TObject);
  private
    FFileName: string;
    FReportName: String;
    FReportDesc: String;
  public
    { Public declarations }
  end;

  function GetReportWhereData(AFileName: String; var AReportName: string; var AReportDesc: String): Boolean; overload;
  function GetReportWhereData(var AReportName: string; var AReportDesc: String): Boolean; overload;

var
  frmReportSettings: TfrmReportSettings;

implementation

uses uMainForm;

{$R *.dfm}

function GetReportWhereData(AFileName: String; var AReportName: string; var AReportDesc: String): Boolean;
begin
  with TfrmReportSettings.Create(nil) do
  try
    FFileName := AFileName;
    FReportName := AReportName;
    FReportDesc := AReportDesc;
    frmReportSettings.edtReportName.Text := ExtractFileName(FFileName);
    Result := (ShowModal = mrOk);

    if Result then
    begin
      AReportName := frmReportSettings.edtReportName.Text;
      AReportDesc := frmReportSettings.edtReportDescription.Text;
    end;

  finally
    Free;
  end;
end;

function GetReportWhereData(var AReportName: string; var AReportDesc: String): Boolean;
begin
  with TfrmReportSettings.Create(nil) do
  try
    FReportName := AReportName;
    FReportDesc := AReportDesc;
    frmReportSettings.edtReportName.Text := FReportName;
    frmReportSettings.edtReportDescription.Text := FReportDesc;

    Result := (ShowModal = mrOk);

    if Result then
    begin
      AReportName := frmReportSettings.edtReportName.Text;
      AReportDesc := frmReportSettings.edtReportDescription.Text;
    end;

  finally
    Free;
  end;
end;

procedure TfrmReportSettings.actnOkExecute(Sender: TObject);
var AReportName: String;
begin
  ModalResult := mrOk;
end;

procedure TfrmReportSettings.actnOkUpdate(Sender: TObject);
begin
  btnOk.Enabled := Length(frmReportSettings.edtReportName.Text) > 0;
end;

end.
