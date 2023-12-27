unit CustomSCFluentTopBar;

interface

uses System.Classes;

procedure Register;

implementation

uses Forms.Main;

procedure Register;
begin
  RegisterComponents('TscCustomFluentMainFormTopBar', [scpnlTopBar]);
end;

end.
