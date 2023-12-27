unit Converter.Types.Generics;

interface

uses
  Converter.Interfaces.Converter,
  Converte.Interfaces.ConvertOption,
  Converter.Interfaces.CorrespondencyTable,
  Generics.Collections,
  System.SysUtils;


type
  TConvertOption = class(TInterfacedObject, IConvertOption)
  private
    FOptionValue: Double;
    FOptionName: string;
  public
    constructor Create(AOption: string; AValue: Double);
    function GetValue: Double;
    function GetName: string;

    property Value: Double read GetValue;
    property Name: string read GetName;
  end;

  TCorrespondencyTable = class(TInterfacedObject, ICorrespondencyTable)
  private
    FTable: TDictionary<string, IConvertOption>;
  public
    constructor Create; virtual;
    procedure AddToTable(AOption: IConvertOption);
    function GetTable: TDictionary<string, IConvertOption>;
    function GetCorrespondingOption(AConvertType: string): IConvertOption;
  end;

  TConverter = class(TInterfacedObject, IConverter)
  protected
    FBases: TDictionary<string, TCorrespondencyTable>;
    function GetCorrespondingBase(AOption: string): ICorrespondencyTable;
  public
    constructor Create; virtual; abstract;
    property Bases: TDictionary<string, TCorrespondencyTable> read FBases;
    function Convert(AFromVal: Double; AFromOptionName:string; AToOptionTable: ICorrespondencyTable): Double; virtual;
  end;
implementation


{ TConverter }

function TConverter.Convert(AFromVal: Double; AFromOptionName:string;
AToOptionTable: ICorrespondencyTable): Double;

begin
  Result := AFromVal * AToOptionTable.GetCorrespondingOption(AFromOptionName).Value;
end;

function TConverter.GetCorrespondingBase(
  AOption: string): ICorrespondencyTable;
var
  CorrespondingBase: TCorrespondencyTable;
begin
  if FBases.TryGetValue(AOption, CorrespondingBase)  then
  begin
    result := CorrespondingBase;
  end else
  begin
    raise Exception.Create('Corresponding Base Not Found.');
  end;
end;

{ TCorrespondencyTable }

procedure TCorrespondencyTable.AddToTable(AOption: IConvertOption);
begin
  FTable.Add(AOption.Name, AOption);
end;

constructor TCorrespondencyTable.Create;
begin
  FTable := TDictionary<string, IConvertOption>.Create;
end;

function TCorrespondencyTable.GetCorrespondingOption(
  AConvertType: string): IConvertOption;
var
  ConvOpt: IConvertOption;
begin
  if FTable.TryGetValue(AConvertType, ConvOpt)  then
  begin
    Result := ConvOpt;
  end else
  begin
    raise Exception.Create('Error Getting The Type');
  end;

end;

function TCorrespondencyTable.GetTable: TDictionary<string, IConvertOption>;
begin
  Result := FTable;
end;

{ TConvertOption }

constructor TConvertOption.Create(AOption: String; AValue: Double);
begin
  FOptionName := AOption;
  FOptionValue := AValue;
end;

function TConvertOption.GetName: string;
begin
  result := FOptionName;
end;

function TConvertOption.GetValue: Double;
begin
  result := FOptionValue;
end;

end.
