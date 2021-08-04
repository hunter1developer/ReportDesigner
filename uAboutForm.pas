unit uAboutForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  dxGDIPlusClasses;

type
  TfrmAbout = class(TForm)
    Panel1: TPanel;
    btnCancel: TButton;
    lblDesc: TLabel;
    Image1: TImage;
    lblVersion: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

resourcestring
  rsVersionInfo = 'Version %s (%s)';
implementation

uses uCommonUtils;

{$R *.dfm}

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  lblVersion.Caption := Format(rsVersionInfo, [TCommonUtils.GetFileVersionStr(Application.ExeName),
                                               TCommonUtils.GetFileArchitectureStr(Application.ExeName)]);
end;

end.
