unit Converter.Types.Time;

interface
uses
  Converter.Types.Generics,
  Converter.Interfaces.Converter,
  Converter.Interfaces.ConvertOption,
  Generics.Collections,
  System.SysUtils;

type
   TTimeConverter = class(TConverter)
  private
    FBaseSecond, FBaseMinute, FBaseHour, FBaseDay, FBaseMonth, FBaseYear: TCorrespondencyTable;
  public
    constructor Create;
    destructor Destroy;
  end;


implementation

{ TTimeConverter }

constructor TTimeConverter.Create;
var
  BaseSecond_Second, BaseSecond_Minute, BaseSecond_Hour, BaseSecond_Day, BaseSecond_Month, BaseSecond_Year: IConvertOption;
  BaseMinute_Second, BaseMinute_Minute, BaseMinute_Hour, BaseMinute_Day, BaseMinute_Month, BaseMinute_Year: IConvertOption;
  BaseHour_Second, BaseHour_Minute, BaseHour_Hour, BaseHour_Day, BaseHour_Month, BaseHour_Year: IConvertOption;
  BaseDay_Second, BaseDay_Minute, BaseDay_Hour, BaseDay_Day, BaseDay_Month, BaseDay_Year: IConvertOption;
  BaseMonth_Second, BaseMonth_Minute, BaseMonth_Hour, BaseMonth_Day, BaseMonth_Month, BaseMonth_Year: IConvertOption;
  BaseYear_Second, BaseYear_Minute, BaseYear_Hour, BaseYear_Day, BaseYear_Month, BaseYear_Year: IConvertOption;
begin
  FBases := TDictionary<string, TCorrespondencyTable>.Create;

  { Base Second }

  BaseSecond_Second := TConvertOption.Create('Second', 1);
  BaseSecond_Minute := TConvertOption.Create('Minute', 60);
  BaseSecond_Hour := TConvertOption.Create('Hour', 60*60);
  BaseSecond_Day  := TConvertOption.Create('Day', 60*60*24);
  BaseSecond_Month := TConvertOption.Create('Month', 60*60*24*30);
  BaseSecond_Year  := TConvertOption.Create('Year', 60*60*24*365);

  FBaseSecond := TCorrespondencyTable.Create;
  FBaseSecond.AddToTable(BaseSecond_Second);
  FBaseSecond.AddToTable(BaseSecond_Minute);
  FBaseSecond.AddToTable(BaseSecond_Hour);
  FBaseSecond.AddToTable(BaseSecond_Day);
  FBaseSecond.AddToTable(BaseSecond_Month);
  FBaseSecond.AddToTable(BaseSecond_Year);

  { Base Minute }

  BaseMinute_Second := TConvertOption.Create('Second', 1/60);
  BaseMinute_Minute := TConvertOption.Create('Minute', 1);
  BaseMinute_Hour := TConvertOption.Create('Hour', 60);
  BaseMinute_Day  := TConvertOption.Create('Day', 60*24);
  BaseMinute_Month := TConvertOption.Create('Month', 60*24*30);
  BaseMinute_Year  := TConvertOption.Create('Year', 60*24*365);

  FBaseMinute := TCorrespondencyTable.Create;
  FBaseMinute.AddToTable(BaseMinute_Second);
  FBaseMinute.AddToTable(BaseMinute_Minute);
  FBaseMinute.AddToTable(BaseMinute_Hour);
  FBaseMinute.AddToTable(BaseMinute_Day);
  FBaseMinute.AddToTable(BaseMinute_Month);
  FBaseMinute.AddToTable(BaseMinute_Year);

  { Base Hour }

  BaseHour_Second := TConvertOption.Create('Second', 1/(60*60));
  BaseHour_Minute := TConvertOption.Create('Minute', 1/60);
  BaseHour_Hour := TConvertOption.Create('Hour', 1);
  BaseHour_Day  := TConvertOption.Create('Day', 24);
  BaseHour_Month := TConvertOption.Create('Month', 24*30);
  BaseHour_Year  := TConvertOption.Create('Year', 24*365);

  FBaseHour := TCorrespondencyTable.Create;
  FBaseHour.AddToTable(BaseHour_Second);
  FBaseHour.AddToTable(BaseHour_Minute);
  FBaseHour.AddToTable(BaseHour_Hour);
  FBaseHour.AddToTable(BaseHour_Day);
  FBaseHour.AddToTable(BaseHour_Month);
  FBaseHour.AddToTable(BaseHour_Year);

  { Base Day }

  BaseDay_Second := TConvertOption.Create('Second', 1/(60*60*24));
  BaseDay_Minute := TConvertOption.Create('Minute', 1/(60*24));
  BaseDay_Hour := TConvertOption.Create('Hour', 1/24);
  BaseDay_Day  := TConvertOption.Create('Day', 1);
  BaseDay_Month := TConvertOption.Create('Month', 30);
  BaseDay_Year  := TConvertOption.Create('Year', 365);

  FBaseDay := TCorrespondencyTable.Create;
  FBaseDay.AddToTable(BaseDay_Second);
  FBaseDay.AddToTable(BaseDay_Minute);
  FBaseDay.AddToTable(BaseDay_Hour);
  FBaseDay.AddToTable(BaseDay_Day);
  FBaseDay.AddToTable(BaseDay_Month);
  FBaseDay.AddToTable(BaseDay_Year);

  { Base Month }

  BaseMonth_Second := TConvertOption.Create('Second', 1/(60*60*24*365));
  BaseMonth_Minute := TConvertOption.Create('Minute', 1/(60*24*365));
  BaseMonth_Hour := TConvertOption.Create('Hour', 1/(24*365));
  BaseMonth_Day  := TConvertOption.Create('Day', 1/365);
  BaseMonth_Month := TConvertOption.Create('Month', 1/12);
  BaseMonth_Year  := TConvertOption.Create('Year', 1);

  FBaseMonth := TCorrespondencyTable.Create;
  FBaseMonth.AddToTable(BaseMonth_Second);
  FBaseMonth.AddToTable(BaseMonth_Minute);
  FBaseMonth.AddToTable(BaseMonth_Hour);
  FBaseMonth.AddToTable(BaseMonth_Day);
  FBaseMonth.AddToTable(BaseMonth_Month);
  FBaseMonth.AddToTable(BaseMonth_Year);
  { Base Year }

  BaseYear_Second := TConvertOption.Create('Second', 1);
  BaseYear_Minute := TConvertOption.Create('Minute', 60);
  BaseYear_Hour := TConvertOption.Create('Hour', 60*60);
  BaseYear_Day  := TConvertOption.Create('Day', 60*60*24);
  BaseYear_Month := TConvertOption.Create('Month', 60*60*24*30);
  BaseYear_Year  := TConvertOption.Create('Year', 60*60*24*365);

  FBaseYear := TCorrespondencyTable.Create;
  FBaseYear.AddToTable(BaseYear_Second);
  FBaseYear.AddToTable(BaseYear_Minute);
  FBaseYear.AddToTable(BaseYear_Hour);
  FBaseYear.AddToTable(BaseYear_Day);
  FBaseYear.AddToTable(BaseYear_Month);
  FBaseYear.AddToTable(BaseYear_Year);

  FBases.Add('Second', FBaseSecond);
  FBases.Add('Minute', FBaseMinute);
  FBases.Add('Hour', FBaseHour);
  FBases.Add('Day', FBaseDay);
  FBases.Add('Month', FBaseMonth);
  FBases.Add('Year', FBaseYear);
end;

destructor TTimeConverter.Destroy;
begin

end;

end.
