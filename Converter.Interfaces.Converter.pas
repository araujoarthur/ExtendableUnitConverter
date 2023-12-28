unit Converter.Interfaces.Converter;

interface
  uses Generics.Collections, Converter.Interfaces.CorrespondencyTable;

type
  IConverter = interface
  ['{8E8BA9F2-6EF9-48E1-8EFF-28FFED51017B}']
    function Convert(AFromVal: Double; AFromOptionName:string; AToOptionTable: ICorrespondencyTable): Double;
  end;

implementation

end.
