unit uReportPrepSettingsFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TframeReportPrepSettings = class(TFrame)
    pnlGroup: TPanel;
    rbTopCount: TRadioButton;
    rbWithoutData: TRadioButton;
    rbSelectedIndexes: TRadioButton;
    edtIndexes: TEdit;
    edtReportName: TEdit;
    lblReportName: TLabel;
    lblReportDescription: TLabel;
    edtReportDescription: TEdit;
    edtTopCount: TEdit;
    procedure edtIndexesEnter(Sender: TObject);
    procedure edtTopCountEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TframeReportPrepSettings.edtIndexesEnter(Sender: TObject);
begin
  rbSelectedIndexes.Checked := True;
end;

procedure TframeReportPrepSettings.edtTopCountEnter(Sender: TObject);
begin
  rbTopCount.Checked := true;
end;

end.
