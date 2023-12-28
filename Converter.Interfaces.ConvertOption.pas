unit Converter.Interfaces.ConvertOption;

interface

type
  IConvertOption = interface
    ['{B26D8ADF-56D8-4CC3-B472-306307D765DE}']
    function GetValue: Double;
    function GetName: string;
    property Value: Double read GetValue;
    property Name: string read GetName;
  end;

implementation

end.
