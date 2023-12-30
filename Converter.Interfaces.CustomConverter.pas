unit Converter.Interfaces.CustomConverter;

interface

type
  ICustomConverter = interface
    function GetConverterName: string;
    function GetPythonVersionCst: string;
    function Convert(AFromValue: Double): Double;
    property PythonVersion: string read GetPythonVersionCst;
  end;

implementation

end.
