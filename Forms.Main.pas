unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, scStyledForm, scGPControls, scControls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, Converter.Types.Time, Converter.Types.Metric, Generics.Collections, Converter.Types.Generics, Converter.Interfaces.ConvertOption, Converter.Interfaces.CorrespondencyTable, Converter.Interfaces.Converter;

type
  TFrmMain = class(TForm)
    scStyledForm1: TscStyledForm;
    scpnlTopBar: TscPanel;
    scbtnClose: TscGPGlyphButton;
    scbtnMinimize: TscGPGlyphButton;
    lblProgramname: TscGPLabel;
    MainPager: TscPageControl;
    scTabTime: TscTabSheet;
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
    scCbxMetricFromOption: TscComboBox;
    scMetricFromValue: TscEdit;
    tscGpbxToMetric: TscGroupBox;
    scCbxMetricToOption: TscComboBox;
    scMetricToValue: TscEdit;
    btnCustomConvert: TscButton;
    scGpbxFromCustom: TscGroupBox;
    scFromCustom: TscEdit;
    scGpbxToCustom: TscGroupBox;
    scToCustom: TscEdit;
    scCbxCustomConvert: TComboBox;
    btnAddConverter: TscButton;
    procedure scbtnCloseClick(Sender: TObject);
    procedure scbtnMinimizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConvertMetricClick(Sender: TObject);
    procedure scbtnConvertTimeClick(Sender: TObject);
  private
    { Private declarations }
  
    FMetricConverter: TConverter;
    FTimeConverter: TConverter;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.btnConvertMetricClick(Sender: TObject);
begin
  var FromValue: Double := StrToFloat(scMetricFromValue.Text);
  var CorrespTable: TCorrespondencyTable := TCorrespondencyTable(scCbxMetricToOption.Items.Objects[scCbxMetricToOption.ItemIndex]); 
  scMetricToValue.Text := FloatToStr(FMetricConverter.Convert(FromValue, scCbxMetricFromOption.Text, CorrespTable));
  
end;

procedure TFrmMain.FormCreate(Sender: TObject);

  procedure AddToComboTimeComboBox(AName: string; AConvertOption: TCorrespondencyTable);
  begin
    scCbxTimeFromOption.AddItem(AName, AConvertOption);
    scCbxTimeToOption.AddItem(AName, AConvertOption);
  end;

  procedure AddToComboMetricComboBox(AName: string; AConvertOption: TCorrespondencyTable);
  begin
    scCbxMetricFromOption.AddItem(AName, AConvertOption);
    scCbxMetricToOption.AddItem(AName, AConvertOption);
  end;
var
  Key: string;
  CurrentValue: TCorrespondencyTable;
begin
  FMetricConverter := TMetricConverter.Create;
  FTimeConverter := TTimeConverter.Create;
  
  for Key in FMetricConverter.Bases.Keys do
  begin
    if FMetricConverter.Bases.TryGetValue(Key, CurrentValue) then
    begin
      AddToComboMetricComboBox(Key, CurrentValue);
    end
  end;

  for Key in FTimeConverter.Bases.Keys do
  begin
    if FTimeConverter.Bases.TryGetValue(Key, CurrentValue) then
    begin
      AddToComboTimeComboBox(Key, CurrentValue);
    end
  end;

end;

procedure TFrmMain.scbtnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.scbtnConvertTimeClick(Sender: TObject);
begin
  var FromValue: Double := StrToFloat(scTimeFromValue.Text);
  var CorrespTable: TCorrespondencyTable := TCorrespondencyTable(scCbxTimeToOption.Items.Objects[scCbxTimeToOption.ItemIndex]); 
  scTimeToValue.Text := FloatToStr(FTimeConverter.Convert(FromValue, scCbxTimeFromOption.Text, CorrespTable));
end;

procedure TFrmMain.scbtnMinimizeClick(Sender: TObject);
begin
  Application.Minimize;
end;

end.
