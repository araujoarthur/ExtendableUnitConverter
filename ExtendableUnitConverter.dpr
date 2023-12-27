program ExtendableUnitConverter;

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {FrmMain},
  Converter.Interfaces.Converter in 'Converter.Interfaces.Converter.pas',
  Converter.Types.Generics in 'Converter.Types.Generics.pas',
  Converter.Types.Time.Legacy in 'Converter.Types.Time.Legacy.pas',
  Converter.Types.Speed in 'Converter.Types.Speed.pas',
  Converter.Types.Metric in 'Converter.Types.Metric.pas',
  Converter.Types.Time in 'Converter.Types.Time.pas',
  Converter.Interfaces.CorrespondencyTable in 'Converter.Interfaces.CorrespondencyTable.pas',
  Converte.Interfaces.ConvertOption in 'Converte.Interfaces.ConvertOption.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
