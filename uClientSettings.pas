unit uClientSettings;

interface

uses
  Windows, SysUtils, uCustomIniSettings, System.Win.Registry;

type
  TClientSettings = class(TCommonSettings)
  private
    FRegFile: TRegistry;
    procedure SetServerAddress(const Value: String);
    procedure SetServerPort(const Value: Integer);
    function GetServerAddress: String;
    function GetServerPort: Integer;

    function GetLastUserId: string;
    procedure SetLastUesrId(const Value: string);
    function GetSamlAuthentication: boolean;
    procedure SetSamlAuthentication(const Value: boolean);
  protected
    property RegFile: TRegistry read FRegFile write FRegFile;
  public
    constructor Create(Filename: String = ''); override;
    destructor Destroy; override;

    property LastUserId: string read GetLastUserId write SetLastUesrId;
  published
    property ServerPort: Integer read GetServerPort write SetServerPort;
    property ServerAddress: String read GetServerAddress write SetServerAddress;
    property SamlAuthentication: boolean read GetSamlAuthentication write SetSamlAuthentication;
  end;

implementation

uses IniFiles, Classes;

const
  constCommSection = 'Communications';
  constServerAddress = 'ServerAddress';
  constServerPort = 'ServerPort';
  constSamlAuth = 'SamlAuth';

{ TClientSettings }

constructor TClientSettings.Create(Filename: String);
const
  KeyName = 'Software\Zasio\VersatileReportDesigner';
begin
  inherited;
  FRegFile := TRegistry.Create(KEY_ALL_ACCESS);
  FRegFile.OpenKey(KeyName, True);
end;

destructor TClientSettings.Destroy;
begin
  FreeAndNil(FRegFile);
  inherited;
end;

function TClientSettings.GetLastUserId: string;
begin
  if RegFile.ValueExists('Last Login User Id') then
    Result := RegFile.ReadString('Last Login User Id')
  else
    Result := '';
end;

function TClientSettings.GetSamlAuthentication: boolean;
begin
  Result := IniFile.ReadBool(constCommSection, constSamlAuth, true);
end;

function TClientSettings.GetServerAddress: String;
begin
  Result := IniFile.ReadString(constCommSection, constServerAddress, 'reports.zasiocloud.com');
end;

function TClientSettings.GetServerPort: Integer;
begin
  Result := IniFile.ReadInteger(constCommSection, constServerPort, 443);
end;

procedure TClientSettings.SetLastUesrId(const Value: string);
begin
  RegFile.WriteString('Last Login User Id', Value);
end;

procedure TClientSettings.SetSamlAuthentication(const Value: boolean);
begin
  IniFile.WriteBool(constCommSection, constSamlAuth, Value);
end;

procedure TClientSettings.SetServerAddress(const Value: String);
begin
  IniFile.WriteString(constCommSection, constServerAddress, Value);
end;

procedure TClientSettings.SetServerPort(const Value: Integer);
begin
  IniFile.WriteInteger(constCommSection, constServerPort, Value);
end;

initialization
  Classes.RegisterClass(TClientSettings);

end.
