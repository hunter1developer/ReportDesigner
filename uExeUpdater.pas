unit uExeUpdater;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ShellApi, Vcl.StdCtrls, TlHelp32, System.Generics.Collections;

type
  TTypeUpdate = (tuAppExe, tuInstaller);
  TProcessRec = class
  public
    ExeName: string;
    Process_PID: DWORD;
  end;
  TExeUpdate = class
  private
    fPrefix: string;
    fAppFileName: string;
    fProcessList: TList<TProcessRec>;
    fAppPID: DWORD;
    fTypeUpdate: TTypeUpdate;

    procedure LoadProcesses;
    procedure KillProcesses();

    procedure DoProcessApp;
    procedure DoProcessInstaller;
  public
    constructor Create(const AAppFileName: string; const AAppPID: DWORD; const APrefix: string; const ADoProcess: boolean = true); overload;
    constructor Create(const AFileInstaller: string; const AAppPID: DWORD; const ADoProcess: boolean = true); overload;
    destructor Destroy; override;

    function KillProcess(pid: DWORD): boolean;
    procedure DoProcess;

    property Prefix: string read fPrefix write fPrefix;
    property AppFileName: string read fAppFileName write fAppFileName;
    property AppPID: DWORD read fAppPID write FAppPID;
    property TypeUpdate: TTypeUpdate read fTypeUpdate;
  end;
implementation

{ TExeUpdater }

procedure TExeUpdate.LoadProcesses;
var
  connector: THandle;
  stamped: LongBool;
  exe: TProcessEntry32;
  procRec: TProcessRec;
begin
  connector := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  exe.dwSize := SizeOf(exe);
  stamped := Process32First(connector, exe);
  while stamped do
  begin
    if (exe.szExeFile = ExtractFileName(fAppFileName)) and (exe.th32ProcessID <> GetCurrentProcessId) then
    begin
      procRec := TProcessRec.Create;
      procRec.ExeName := exe.szExeFile;
      procRec.Process_PID := exe.th32ProcessID;
      fProcessList.Add(procRec);
    end;
    stamped := Process32Next(connector, exe);
  end;
end;

constructor TExeUpdate.Create(const AAppFileName: string; const AAppPID: DWORD; const APrefix: string; const ADoProcess: boolean = true);
begin
  fTypeUpdate := tuAppExe;
  fProcessList := TList<TProcessRec>.Create;
  fAppFileName := AAppFileName;
  fAppPID := AAppPID;
  fPrefix := APrefix;
  if ADoProcess then
    DoProcess;
end;

constructor TExeUpdate.Create(const AFileInstaller: string; const AAppPID: DWORD; const ADoProcess: boolean = true);
begin
  fTypeUpdate := tuInstaller;
  fProcessList := TList<TProcessRec>.Create;
  fAppFileName := AFileInstaller;
  fAppPID := AAppPID;
  if ADoProcess then
    DoProcess;
end;

destructor TExeUpdate.Destroy;
begin
  fProcessList.Free;
end;

function TExeUpdate.KillProcess(pid: DWORD): boolean;
var
  killer: Thandle;
  code: string;
begin
  code := '';
  killer := OpenProcess(PROCESS_TERMINATE, false, pid);
  if TerminateProcess(killer, 0) then
  begin
    Result := true;
  end
  else
  begin
    Result := false;
  end;
end;

procedure TExeUpdate.KillProcesses();
var
  process: TProcessRec;
begin
  for process in fProcessList do
  begin
    if process.ExeName = ExtractFileName(fAppFileName) then
      KillProcess(process.Process_PID);
  end;
end;

procedure TExeUpdate.DoProcess;
begin
  case fTypeUpdate of
    tuAppExe: DoProcessApp;
    tuInstaller: DoProcessInstaller;
  end;
end;

procedure TExeUpdate.DoProcessApp;
const
  constNewSelfName = '%s\%s%s';
var
  SelfNameFull: string;
  SelfName: string;
  NewSelfName: string;
  FilePath: string;
begin
  SelfNameFull := fAppFileName;
  SelfName := ExtractFileName(fAppFileName);
  FilePath := ExtractFileDir(fAppFileName);
  NewSelfName := Format(constNewSelfName, [FilePath, fPrefix, SelfName]);

  LoadProcesses;
  ShellExecute(0, 'open', 'cmd.exe', PChar('/C choice /C Y /N /D Y /T 1 & Del ' + SelfName), nil, SW_HIDE);
  ShellExecute(0, 'open', 'cmd.exe', PChar('/C choice /C Y /N /D Y /T 5 & Ren ' + NewSelfName + ' ' + SelfName), nil, SW_HIDE);
  ShellExecute(0, 'open', 'cmd.exe', PChar('/C choice /C Y /N /D Y /T 7 & ' + SelfName), nil, SW_HIDE);
  KillProcesses;
  KillProcess(fAppPID);
end;

procedure TExeUpdate.DoProcessInstaller;
var
  SelfNameFull: string;
begin
  SelfNameFull := fAppFileName;

  LoadProcesses;
  ShellExecute(0, 'open', 'cmd.exe', PChar('/C choice /C Y /N /D Y /T 3 & ' + SelfNameFull), nil, SW_HIDE);
  KillProcesses;
  KillProcess(fAppPID);
end;

end.
