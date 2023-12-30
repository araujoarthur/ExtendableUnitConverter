unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, scStyledForm, scGPControls, scControls,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,
  IniFiles,
  Converter.Types.Time,
  Converter.Types.Metric,
  Generics.Collections,
  Converter.Types.StringObject,
  Converter.Types.Generics,
  Converter.Types.CustomConverter,
  Converter.Interfaces.ConvertOption,
  Converter.Interfaces.CorrespondencyTable,
  Converter.Interfaces.Converter,
  Converter.Interfaces.CustomConverter, PythonEngine;

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
    btnAddConverter: TscButton;
    Memo1: TMemo;
    scCbxCustomConvert: TscComboBox;
    procedure scbtnCloseClick(Sender: TObject);
    procedure scbtnMinimizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConvertMetricClick(Sender: TObject);
    procedure scbtnConvertTimeClick(Sender: TObject);
    procedure SwitchTimeButton(Sender: TObject);
    procedure SwitchMetricButton(Sender: TObject);
    procedure OpenOrCreateFileList;
    procedure FillCustomConverters;
    function ExtractObjectFromCbxSelected(ACbx: TCustomComboBox): TObject;
    procedure btnAddConverterClick(Sender: TObject);
    procedure btnCustomConvertClick(Sender: TObject);
  private
    { Private declarations }
  
    FMetricConverter: IConverter;
    FTimeConverter: IConverter;
  public
    { Public declarations }
  end;

const
  LIST_FILE_NAME = 'customConverterIndex.ini';
  
var
  FrmMain: TFrmMain;
  CustomListFile: TIniFile;

implementation

{$R *.dfm}

procedure TFrmMain.btnAddConverterClick(Sender: TObject);
var
  RawObj: TObject;
  StrObj: IStringObject;
begin
  RawObj := ExtractObjectFromCbxSelected(scCbxCustomConvert);
  if (RawObj is TStringObject) then
  begin
    StrObj := TStringObject(RawObj);
    ShowMessage(StrObj.Text);
  end else
  begin
    ShowMessage('Nope');
  end;

end;

procedure TFrmMain.btnConvertMetricClick(Sender: TObject);
begin
  var FromValue: Double := StrToFloat(scMetricFromValue.Text);
  var CorrespTable: TCorrespondencyTable := TCorrespondencyTable(scCbxMetricFromOption.Items.Objects[scCbxMetricToOption.ItemIndex]);
  scMetricToValue.Text := FloatToStr(FMetricConverter.Convert(FromValue, scCbxMetricFromOption.Text, CorrespTable));
end;

procedure TFrmMain.btnCustomConvertClick(Sender: TObject);
var
  CstConv: ICustomConverter;
begin
  CstConv := TCustomConverter.Create(10, '');
end;

procedure TFrmMain.OpenOrCreateFileList;
var
  AppPath, FileName: string;
begin
  AppPath := ExtractFilePath(Application.ExeName);
  FileName := AppPath + LIST_FILE_NAME;
  CustomListFile := TIniFile.Create(FileName);
  CustomListFile.WriteString('LIST', 'CUSTOM_CONVERTER_EXAMPLE', 'custom_converter_example.py');
end;

function TFrmMain.ExtractObjectFromCbxSelected(ACbx: TCustomComboBox): TObject;
begin
  var ItemIndex: Integer := ACbx.ItemIndex;
  Result := ACbx.Items.Objects[ItemIndex];
end;

procedure TFrmMain.FillCustomConverters;
var
  KeyList: TStringList;
  KeyName: string;
begin
  KeyList := TStringList.Create;
  try
    if Assigned(CustomListFile) then
    begin
      CustomListFile.ReadSection('LIST', KeyList);

      for var KeyIndex: Integer := 0 to KeyList.Count - 1 do
      begin   
        KeyName := KeyList[KeyIndex];
        scCbxCustomConvert.AddItem(KeyName, TStringObject.Create(CustomListFile.ReadString('LIST', KeyName, '')));
      end;
    end;
  finally
    KeyList.Free;
  end;
  
  
end;

procedure TFrmMain.FormCreate(Sender: TObject);

  procedure AddToComboTimeComboBox(AName: string; AConvertOption: ICorrespondencyTable);
  begin
    scCbxTimeFromOption.AddItem(AName, (AConvertOption as TCorrespondencyTable));
    scCbxTimeToOption.AddItem(AName, (AConvertOption as TCorrespondencyTable));
  end;

  procedure AddToComboMetricComboBox(AName: string; AConvertOption: ICorrespondencyTable);
  begin
    scCbxMetricFromOption.AddItem(AName, (AConvertOption as TCorrespondencyTable));
    scCbxMetricToOption.AddItem(AName, (AConvertOption as TCorrespondencyTable));
  end;
var
  Key: string;
  CurrentValue: ICorrespondencyTable;
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
  
  OpenOrCreateFileList;
  FillCustomConverters;
end;

procedure TFrmMain.scbtnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.scbtnConvertTimeClick(Sender: TObject);
begin
  var FromValue: Double := StrToFloat(scTimeFromValue.Text);
  var CorrespTable: TCorrespondencyTable := TCorrespondencyTable(scCbxTimeFromOption.Items.Objects[scCbxTimeToOption.ItemIndex]); 
  scTimeToValue.Text := FloatToStr(FTimeConverter.Convert(FromValue, scCbxTimeFromOption.Text, CorrespTable));

  Memo1.Lines.Add(FloatToStr(FromValue) + ' from ' + scCbxTimeFromOption.Text);
  Memo1.Lines.Add('Table Selected: ' + scCbxTimeFromOption.Text);
  var CurrentVal: IConvertOption;
  for var Key: string in CorrespTable.GetTable.Keys do
  begin
    if CorrespTable.GetTable.TryGetValue(Key, CurrentVal) then
    begin
      Memo1.Lines.Add(Key + ': ' + CurrentVal.Name + ' | ' + FloatToStr(CurrentVal.Value));
    end;
  end;
  Memo1.Lines.Add('-----------------');
end;

procedure TFrmMain.scbtnMinimizeClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TFrmMain.SwitchMetricButton(Sender: TObject);
begin
  if (scCbxMetricFromOption.ItemIndex <> -1) and ((scCbxMetricToOption.ItemIndex <> -1)) and (scMetricFromValue.Text <> '') then
  begin
    btnConvertMetric.Enabled := True;
  end else
  begin
    btnConvertMetric.Enabled := False;
  end;
end;

procedure TFrmMain.SwitchTimeButton(Sender: TObject);
begin
  if (scCbxTimeFromOption.ItemIndex <> -1) and ((scCbxTimeToOption.ItemIndex <> -1)) and (scTimeFromValue.Text <> '') then
  begin 
    scbtnConvertTime.Enabled := True;
  end else
  begin
    scbtnConvertTime.Enabled := False;
  end;
end;

end.
