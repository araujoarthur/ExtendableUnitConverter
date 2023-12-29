unit Converter.Types.CustomConverter;

interface

uses
  PythonEngine,
  PythonVersions,
  Converter.Interfaces.CustomConverter,
  SysUtils,
  Forms,
  Vcl.Dialogs;

type
  TCustomConverter = class(TInterfacedObject, ICustomConverter)
  private
    FPythonEngine: TPythonEngine;
    FConverterPath: string;
    FAppPath: string;
    function GetConverterPath: string;
    function GetPythonVersionCst: string;
    procedure SetupPythonEngine;
  public
    constructor Create(AFromValue: Double; AConverterPath: string);
    destructor Destroy; override;
    function Convert(AFromValue: Double): Double;
    property ConverterPath: string read GetConverterPath;
    property PythonVersion: string read GetPythonVersionCst;
  end;

const
  CONVERTER_FOLDER_NAME = 'converters';

implementation

{ TCustomConverter }

function TCustomConverter.Convert(AFromValue: Double): Double;
begin

end;

constructor TCustomConverter.Create(AFromValue: Double; AConverterPath: string);
begin
  SetupPythonEngine;
  FAppPath := ExtractFilePath(Application.ExeName) + IncludeTrailingPathDelimiter(CONVERTER_FOLDER_NAME);
  ShowMessage(FAppPath);
end;

destructor TCustomConverter.Destroy;
begin
  if Assigned(FPythonEngine) then
    if FPythonEngine.Initialized then
      FPythonEngine.Py_Finalize;
    FPythonEngine.Free;

  inherited;
end;

function TCustomConverter.GetConverterPath: string;
begin
  Result := FConverterPath;
end;

function TCustomConverter.GetPythonVersionCst: string;
begin
  Result := FPythonEngine.RegVersion;
end;

procedure TCustomConverter.SetupPythonEngine;
begin
  FPythonEngine := TPythonEngine.Create(nil);
  FPythonEngine.UseLastKnownVersion := False;
  FPythonEngine.PyFlags := [pfInteractive];
  FPythonEngine.AutoFinalize := False;
  FPythonEngine.LoadDll;
end;

end.
