unit Converter.Types.CustomConverter;

interface

uses
  PythonEngine,
  Converter.Interfaces.CustomConverter,
  SysUtils,
  Forms,
  Vcl.Dialogs;

type
  TCustomConverter = class(TInterfacedObject, ICustomConverter)
  private
    FPythonEngine: TPythonEngine;
    FConverterPath: string;
    FConvertersPath: string;
    FConverterName: string;
    function GetConverterName: string;
    function GetPythonVersionCst: string;
    procedure SetupPythonEngine;
  public
    constructor Create(AFromValue: Double; AConverterName: string);
    destructor Destroy; override;
    function Convert(AFromValue: Double): Double;
    property ConverterName: string read GetConverterName;
    property PythonVersion: string read GetPythonVersionCst;
  end;

const
  CONVERTER_FOLDER_NAME = 'converters';

implementation

{ TCustomConverter }

function TCustomConverter.Convert(AFromValue: Double): Double;
var
  PythonModule, PythonArguments, PythonResult: PPyObject;
  PythonFunctionDoConversion: TPythonDelphiVar;
  ConverterModule: TPythonModule;
begin
  try
   { FPythonEngine.ExecString(Format('import sys; sys.path.append(r"%s")', [FConvertersPath]));
    FPythonEngine.ExecString('import ' + FConverterName);

    PythonModule := FPythonEngine.PyImport_ImportModule  }
    ConverterModule := TPythonModule.Create(nil);
    
    try
      ConverterModule.ModuleName := FConverterName;
      ConverterModule.Engine := FPythonEngine;
      try
        FPythonEngine.ExecString('import sys');
        FPythonEngine.ExecString('sys.path.appedn("./converters")');
        FPythonEngine.ExecString('import ' + FConverterName);
        PythonFunctionDoConversion := TPythonDelphiVar.Create(nil);
        try
          try
            PythonFunctionDoConversion.Engine := FPythonEngine;
            
          except on E: Exception do
            raise Exception.Create('Error Creating PythonDelphiVar');
          end;
        finally
          PythonFunctionDoConversion.Free;
        end;
      except on E: Exception do
        raise Exception.Create('Error on importing');
      end;
    finally
      ConverterModule.Free;
    end;
    
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

constructor TCustomConverter.Create(AFromValue: Double; AConverterName: string);
begin
  SetupPythonEngine;
  FConvertersPath := ExtractFilePath(Application.ExeName) + IncludeTrailingPathDelimiter(CONVERTER_FOLDER_NAME);
  FConverterName := AConverterName;
end;

destructor TCustomConverter.Destroy;
begin
  if Assigned(FPythonEngine) then
    if FPythonEngine.Initialized then
      FPythonEngine.Py_Finalize;
    FPythonEngine.Free;

  inherited;
end;

function TCustomConverter.GetConverterName: string;
begin
  Result := FConverterName;
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
