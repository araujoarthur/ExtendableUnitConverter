unit Converter.Types.Generics;

interface

uses
  Converter.Types.Generics.Interfaces, Generics.Collections;


type
  TCorrespondencyTable = class(TInterfacedObject, ICorrespondencyTable)
  private
    FTable: TDictionary<string, IConvertOptionsList>;
  public
    constructor Create; virtual; abstract;
    function GetTable: TDictionary<string, IConvertOptionsList>;
  end;

  TConverter = class(TInterfacedObject, IConverter)
  public
    constructor Create; virtual; abstract;
    function Convert(AFromVal: Double; AFromOption, AToOption: IConvertOption): Double;
  end;
implementation


{ TConverter }

function TConverter.Convert(AFromVal: Double; AFromOption,
  AToOption: IConvertOption): Double;
var
  CorrespondencyTable: ICorrespondencyTable;
begin
  CorrespondencyTable := nil;
  Result := AFromVal * CorrespondencyTable.GetCorrespondingProperty(AFromOption);
end;

{ TCorrespondencyTable }

function TCorrespondencyTable.GetTable: TDictionary<string, IConvertOptionsList>;
begin
  Result := FTable;
end;

end.
