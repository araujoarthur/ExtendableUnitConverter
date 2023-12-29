unit Converter.Interfaces.CustomConverter;

interface

type
  ICustomConverter = interface
    function GetConverterPath: string;
    function GetPythonVersionCst: string;
    function Convert(AFromValue: Double): Double;
    property ConverterPath: string read GetConverterPath;
    property PythonVersion: string read GetPythonVersionCst;
  end;

implementation

end.