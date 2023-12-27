unit Converter.Interfaces.CorrespondencyTable;

interface

uses
  Converter.Interfaces.ConvertOption, Generics.Collections;
type
  ICorrespondencyTable = interface
    function GetTable: TDictionary<string, IConvertOption>;
    function GetCorrespondingOption(AConvertType: string): IConvertOption;
    procedure AddToTable(AOption: IConvertOption);
  end;
implementation

end.
