unit Converter.Types.Time.Legacy;

interface

  type
    TTimeConvertOptions = (tcoSecond, tcoMinute, tcoHour, tcoDay, tcoMonth, tcoYear);
    TTimeCorrespondencyTable = record
    private
      FSecond, FMinute, FHour, FDay, FMonth, FYear: Double;

    public
      property Second: Double read FSecond write FSecond;
      property Minute: Double read FMinute write FMinute;
      property Hour: Double read FHour write FHour;
      property Day: Double read FDay write FDay;
      property Month: Double read FMonth write FMonth;
      property Year: Double read FYear write FYear;

      constructor Create(ASecondValue, AMinuteValue, AHourValue, ADayValue, AMonthValue, AYearValue: Double);
      function GetCorrespondingProperty(AOpt: TTimeConvertOptions): Double;
    end;

    TTimeConverter = class
    private
      FBaseSecond: TTimeCorrespondencyTable;
      FBaseMinute: TTimeCorrespondencyTable;
      FBaseHour: TTimeCorrespondencyTable;
      FBaseDay: TTimeCorrespondencyTable;
      FBaseMonth: TTimeCorrespondencyTable;
      FBaseYear: TTimeCorrespondencyTable;
      function GetCorrespondingBase(AOpt: TTimeConvertOptions): TTimeCorrespondencyTable;
    public
      constructor Create;
      function Convert(AFromVal: Double; AFromOption, AToOption: TTimeConvertOptions): Double;
    end;

implementation

{ TTimeCorrespondencyTable }

constructor TTimeCorrespondencyTable.Create(ASecondValue, AMinuteValue,
  AHourValue, ADayValue, AMonthValue, AYearValue: Double);
begin
  FSecond := ASecondValue;
  FMinute := AMinuteValue;
  FHour := AHourValue;
  FDay := ADayValue;
  FMonth := AMonthValue;
  FYear := AYearValue;
end;

function TTimeCorrespondencyTable.GetCorrespondingProperty(
  AOpt: TTimeConvertOptions): Double;
begin
  case AOpt of
    tcoSecond: Result := Second;
    tcoMinute: Result := Minute;
    tcoHour: Result := Hour;
    tcoDay: Result := Day;
    tcoMonth: Result := Month;
    tcoYear: Result := Year;
  end;
end;

{ TTimeConverter }

function TTimeConverter.Convert(AFromVal: Double; AFromOption,
  AToOption: TTimeConvertOptions): Double;
var
  CorrespondencyTable: TTimeCorrespondencyTable;
begin
  CorrespondencyTable := GetCorrespondingBase(AToOption);
  Result := AFromVal * CorrespondencyTable.GetCorrespondingProperty(AFromOption);
end;

constructor TTimeConverter.Create;
begin
  FBaseSecond := TTimeCorrespondencyTable.Create(
  1,
  60,
  60*60,
  60*60*24,
  60*60*24*30,
  60*60*24*365);

  FBaseMinute := TTimeCorrespondencyTable.Create(
  1/60,
  1,
  60,
  60*24,
  60*24*30,
  60*24*365);

  FBaseHour := TTimeCorrespondencyTable.Create(
  1/(60*60),
  1/60,
  1,
  24,
  24*30,
  24*365);

  FBaseDay := TTimeCorrespondencyTable.Create(
  1/(60*60*24),
  1/(60*24),
  1/24,
  1,
  30,
  365
  );

  FBaseMonth := TTimeCorrespondencyTable.Create(
  1/(60*60*24*30),
  1/(60*24*30),
  1/(24*30),
  1/30,
  1,
  12);

  FBaseYear := TTimeCorrespondencyTable.Create(
  1/(60*60*24*365),
  1/(60*24*365),
  1/(24*365),
  1/365,
  1/12,
  1);
end;

function TTimeConverter.GetCorrespondingBase(
  AOpt: TTimeConvertOptions): TTimeCorrespondencyTable;
begin

  case AOpt of
    tcoSecond: Result := FBaseSecond ;
    tcoMinute: Result := FBaseMinute;
    tcoHour: Result := FBaseHour;
    tcoDay: Result := FBaseDay;
    tcoMonth: Result := FBaseMonth;
    tcoYear: Result := FBaseYear;
  end;
end;

end.
