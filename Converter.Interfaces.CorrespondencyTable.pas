unit Converter.Interfaces.CorrespondencyTable;

interface

uses
  Converter.Interfaces.ConvertOption, Generics.Collections;
type
  ICorrespondencyTable = interface
  ['{E12C5BB0-1853-472D-8E31-C3251358DB48}']
    function GetTable: TDictionary<string, IConvertOption>;
    function GetCorrespondingOption(AConvertType: string): IConvertOption;
    procedure AddToTable(AOption: IConvertOption);
  end;
implementation

end.
