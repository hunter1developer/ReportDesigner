unit uReportSettingsFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TframeReportSettings = class(TFrame)
    pnlGroup: TPanel;
    edtReportName: TEdit;
    lblReportName: TLabel;
    lblReportDescription: TLabel;
    edtReportDescription: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
