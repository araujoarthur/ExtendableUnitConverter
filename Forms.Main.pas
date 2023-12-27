unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, scStyledForm, scGPControls, scControls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, Converter.Types.Time, Generics.Collections;

type
  TFrmMain = class(TForm)
    scStyledForm1: TscStyledForm;
    scpnlTopBar: TscPanel;
    scbtnClose: TscGPGlyphButton;
    scbtnMinimize: TscGPGlyphButton;
    lblProgramname: TscGPLabel;
    MainPager: TscPageControl;
    scTabTime: TscTabSheet;
    scTabSpeed: TscTabSheet;
    scTabMetric: TscTabSheet;
    scTabExtended: TscTabSheet;
    scTimeFromValue: TscEdit;
    scTimeToValue: TscEdit;
    scbtnConvertTime: TscButton;
    scCbxTimeFromOption: TscComboBox;
    scCbxTimeToOption: TscComboBox;
    tscGpbxFromTime: TscGroupBox;
    tscGpbxToTime: TscGroupBox;
    btnConvertMetric: TscButton;
    tscGpbxFromMetric: TscGroupBox;
    scCbxFromOption: TscComboBox;
    scMetricFromValue: TscEdit;
    tscGpbxToMetric: TscGroupBox;
    scCbxToOption: TscComboBox;
    scMetricToValue: TscEdit;
    btnCustomConvert: TscButton;
    scGpbxFromCustom: TscGroupBox;
    scFromCustom: TscEdit;
    scGpbxToCustom: TscGroupBox;
    scToCustom: TscEdit;
    btnConvertSpeed: TscButton;
    tscGpbxFromSpeed: TscGroupBox;
    scCbxSpeedFromOption: TscComboBox;
    scSpeedFromValue: TscEdit;
    tscGpbxToSpeed: TscGroupBox;
    scCbxSpeedToOption: TscComboBox;
    scSpeedToValue: TscEdit;
    scCbxCustomConvert: TComboBox;
    btnAddConverter: TscButton;
    procedure scbtnCloseClick(Sender: TObject);
    procedure scbtnMinimizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure scbtnConvertTimeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FConvertTimeDictionary: TDictionary<string, TTimeConvertOptions>;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(FConvertTimeDictionary) then
 begin
   FConvertTimeDictionary.Clear;
   FConvertTimeDictionary.Free;
 end;

end;

procedure TFrmMain.FormCreate(Sender: TObject);

  procedure AddToComboTimeComboBox(ACaption: string; AOption: TTimeConvertOptions);
  begin
    scCbxTimeFromOption.AddItem(ACaption, nil);
    scCbxTimeToOption.AddItem(ACaption, nil);
    FConvertTimeDictionary.Add(ACaption, AOption);
  end;
var
  Element: TTimeConvertOptions;
begin
  FConvertTimeDictionary :=  TDictionary<string, TTimeConvertOptions>.Create;
  for Element := Low(TTimeConvertOptions) to High(TTimeConvertOptions) do
  case Element of
    tcoSecond: AddToComboTimeComboBox('Second', tcoSecond);
    tcoMinute: AddToComboTimeComboBox('Minute', tcoMinute);
    tcoHour: AddToComboTimeComboBox('Hour', tcoHour);
    tcoDay: AddToComboTimeComboBox('Day', tcoDay);
    tcoMonth: AddToComboTimeComboBox('Month', tcoMonth);
    tcoYear: AddToComboTimeComboBox('Year', tcoYear);
  end;

end;

procedure TFrmMain.scbtnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.scbtnConvertTimeClick(Sender: TObject);
  function TranslateCaption(ACaption: string): TTimeConvertOptions;
  begin
    var TryGetValueResult: TTimeConvertOptions;
    if FConvertTimeDictionary.TryGetValue(ACaption, TryGetValueResult) then
    begin
      Result := TryGetValueResult;
    end else
    begin
      raise Exception.Create('Error Translating the Caption');
    end;
  end;
var
  TimeConverter: TTimeConverter;
  ConversionResult: Double;
begin
  TimeConverter := TTimeConverter.Create;
  try
    ConversionResult := TimeConverter.Convert(StrToFloat(scTimeFromValue.Text), TranslateCaption(scCbxTimeFromOption.Text), TranslateCaption(scCbxTimeToOption.Text));
    scTimeToValue.Text := FloatToStr(ConversionResult);
  finally
    TimeConverter.Free;
  end;
end;

procedure TFrmMain.scbtnMinimizeClick(Sender: TObject);
begin
  Application.Minimize;
end;

end.
