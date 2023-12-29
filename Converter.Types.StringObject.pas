unit Converter.Types.StringObject;

interface

type
  IStringObject = interface
    function GetText: string;
    property Text: string read GetText;
  end;

  TStringObject = class(TInterfacedObject, IStringObject)
  private
    FText: string;
    function GetText: string;
  public
    constructor Create(AText: string);
    property Text: string read GetText;
  end;
implementation

{ TStringObject }

constructor TStringObject.Create(AText: string);
begin
  FText := AText;
end;

function TStringObject.GetText: string;
begin
  Result := FText;
end;

end.
