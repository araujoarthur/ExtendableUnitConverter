program ExtendableUnitConverter;

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {FrmMain},
  TcstFluentTopBar in 'TcstFluentTopBar.pas' {FrmMain1},
  Converter.Types.Time in 'Converter.Types.Time.pas',
  Converter.Types.Generics in 'Converter.Types.Generics.pas',
  Converter.Types.Generics.Interfaces in 'Converter.Types.Generics.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmMain1, FrmMain1);
  Application.Run;
end.
