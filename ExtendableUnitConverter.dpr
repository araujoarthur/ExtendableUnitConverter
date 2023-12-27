program ExtendableUnitConverter;

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {FrmMain},
  TcstFluentTopBar in 'TcstFluentTopBar.pas' {FrmMain1},
  CustomSCFluentTopBar in 'CustomSCFluentTopBar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmMain1, FrmMain1);
  Application.Run;
end.
