program ZasioVCloudReportManager;

uses
  Vcl.Forms,
  MidasLib,
  uMainForm in 'uMainForm.pas' {frmMain},
  uSettingsForm in 'uSettingsForm.pas' {frmSettings},
  uZasioVClient in 'uZasioVClient.pas' {ZasioVClient: TDataModule},
  uLoginForm in 'uLoginForm.pas' {frmLogin},
  uAboutForm in 'uAboutForm.pas' {frmAbout},
  uReportSettingsFrame in 'uReportSettingsFrame.pas' {frameReportSettings: TFrame},
  uReportSettingsForm in 'uReportSettingsForm.pas' {frmReportSettings},
  uClientSettings in 'uClientSettings.pas',
  uGraphicsDataModule in 'uGraphicsDataModule.pas' {dmRCGraphics: TDataModule},
  uSortOrderForm in 'uSortOrderForm.pas' {frmSortOrder},
  uReportPrepSettingsForm in 'uReportPrepSettingsForm.pas' {frmReportPrepSettings},
  uReportPrepSettingsFrame in 'uReportPrepSettingsFrame.pas' {frameReportPrepSettings: TFrame},
  uDataModule in 'uDataModule.pas' {dmMain: TDataModule},
  uExeUpdater in 'uExeUpdater.pas',
  uCodeSigned in 'uCodeSigned.pas',
  uLoginSamlForm in 'uLoginSamlForm.pas' {frmSamlLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;
end.
