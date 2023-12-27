unit Converter.Interfaces.Converter;

interface
  uses Generics.Collections, Converter.Interfaces.CorrespondencyTable;

type
  IConverter = interface
    function Convert(AFromVal: Double; AFromOptionName:string; AToOptionTable: ICorrespondencyTable): Double;
  end;

implementation

end.
