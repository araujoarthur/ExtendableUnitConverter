program ExtendableUnitConverter;

uses
  Vcl.Forms,
  Converter.Interfaces.Converter in 'Converter.Interfaces.Converter.pas',
  Converter.Interfaces.ConvertOption in 'Converter.Interfaces.ConvertOption.pas',
  Converter.Interfaces.CorrespondencyTable in 'Converter.Interfaces.CorrespondencyTable.pas',
  Converter.Types.Generics in 'Converter.Types.Generics.pas',
  Converter.Types.Metric in 'Converter.Types.Metric.pas',
  Converter.Types.Time.Legacy in 'Converter.Types.Time.Legacy.pas',
  Converter.Types.Time in 'Converter.Types.Time.pas',
  Forms.Main in 'Forms.Main.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
