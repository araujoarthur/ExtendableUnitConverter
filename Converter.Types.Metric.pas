unit Converter.Types.Metric;

interface

uses
  Converter.Types.Generics,
  Converter.Interfaces.ConvertOption,
  Converter.Interfaces.CorrespondencyTable,
  Generics.Collections,
  System.SysUtils;

type

  TMetricConverter = class(TConverter)
  private
    FBaseMilimeter, FBaseCentimeter, FBaseMeter, FBaseKilometer: ICorrespondencyTable;
  public
    constructor Create;
    destructor Destroy;
  end;


implementation


{ TMetricConverter }

constructor TMetricConverter.Create;
var
  BaseMilimeter_Milimeter, BaseMilimeter_Centimeter, BaseMilimeter_Meter, BaseMilimeter_Kilometer: IConvertOption;
  BaseCentimeter_Milimeter, BaseCentimeter_Centimeter, BaseCentimeter_Meter, BaseCentimeter_Kilometer: IConvertOption;
  BaseMeter_Milimeter, BaseMeter_Centimeter, BaseMeter_Meter, BaseMeter_Kilometer: IConvertOption;
  BaseKilometer_Milimeter, BaseKilometer_Centimeter, BaseKilometer_Meter, BaseKilometer_Kilometer: IConvertOption;
begin

  FBases := TDictionary<string, ICorrespondencyTable>.Create;

  { Base Milimeter }
  BaseMilimeter_Milimeter := TConvertOption.Create('Milimeter', 1);
  BaseMilimeter_Centimeter := TConvertOption.Create('Centimeter', 10);
  BaseMilimeter_Meter := TConvertOption.Create('Meter', 1000);
  BaseMilimeter_Kilometer := TConvertOption.Create('Kilometer', 1000000);

  FBaseMilimeter := TCorrespondencyTable.Create;
  FBaseMilimeter.AddToTable(BaseMilimeter_Milimeter);
  FBaseMilimeter.AddToTable(BaseMilimeter_Centimeter);
  FBaseMilimeter.AddToTable(BaseMilimeter_Meter);
  FBaseMilimeter.AddToTable(BaseMilimeter_Kilometer);

  { Base Centimeter }
  BaseCentimeter_Milimeter := TConvertOption.Create('Milimeter', 1/10);
  BaseCentimeter_Centimeter := TConvertOption.Create('Centimeter', 1);
  BaseCentimeter_Meter := TConvertOption.Create('Meter', 100);
  BaseCentimeter_Kilometer := TConvertOption.Create('Kilometer', 100000);

  FBaseCentimeter := TCorrespondencyTable.Create;
  FBaseCentimeter.AddToTable(BaseCentimeter_Milimeter);
  FBaseCentimeter.AddToTable(BaseCentimeter_Centimeter);
  FBaseCentimeter.AddToTable(BaseCentimeter_Meter);
  FBaseCentimeter.AddToTable(BaseCentimeter_Kilometer);

  { Base Meter }
  BaseMeter_Milimeter := TConvertOption.Create('Milimeter', 1/1000);
  BaseMeter_Centimeter := TConvertOption.Create('Centimeter', 1/100);
  BaseMeter_Meter := TConvertOption.Create('Meter', 1);
  BaseMeter_Kilometer := TConvertOption.Create('Kilometer', 1000);

  FBaseMeter := TCorrespondencyTable.Create;
  FBaseMeter.AddToTable(BaseMeter_Milimeter);
  FBaseMeter.AddToTable(BaseMeter_Centimeter);
  FBaseMeter.AddToTable(BaseMeter_Meter);
  FBaseMeter.AddToTable(BaseMeter_Kilometer);

  { Base Kilometer }
  BaseKilometer_Milimeter := TConvertOption.Create('Milimeter', 1/1000000);
  BaseKilometer_Centimeter := TConvertOption.Create('Centimeter', 1/100000);
  BaseKilometer_Meter := TConvertOption.Create('Meter', 1/1000);
  BaseKilometer_Kilometer := TConvertOption.Create('Kilometer', 1);

  FBaseKilometer := TCorrespondencyTable.Create;
  FBaseKilometer.AddToTable(BaseKilometer_Milimeter);
  FBaseKilometer.AddTotable(BaseKilometer_Centimeter);
  FBaseKilometer.AddTotable(BaseKilometer_Meter);
  FBaseKilometer.AddTotable(BaseKilometer_Kilometer);

  FBases.Add('Milimeter', FBaseMilimeter);
  FBases.Add('Centimeter', FBaseCentimeter);
  FBases.Add('Meter', FBaseMeter);
  FBases.Add('Kilometer', FBaseKilometer);
end;

destructor TMetricConverter.Destroy;
begin
  if Assigned(FBases) then
    FBases.Free;
end;

end.
