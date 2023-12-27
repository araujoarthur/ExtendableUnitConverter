unit Converter.Interfaces.ConvertOption;

interface

type
  IConvertOption = interface
    function GetValue: Double;
    function GetName: string;
    property Value: Double read GetValue;
    property Name: string read GetName;
  end;

implementation

end.
