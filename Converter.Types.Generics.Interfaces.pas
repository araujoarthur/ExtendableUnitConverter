unit Converter.Types.Generics.Interfaces;

interface
  uses Generics.Collections;

type
  IConvertOption = interface
    procedure SetOption(AOption: string; AValue: Double);
  end;

  ICorrespondencyTable = interface
    function GetTable: TDictionary<string, IConvertOption>;
    function GetCorrespondingOption(AConvertType: string): IConvertOption;
  end;

  IConverter = interface
    function Convert(AFromVal: Double; AFromOption, AToOption: IConvertOption): Double;
  end;

implementation

end.
