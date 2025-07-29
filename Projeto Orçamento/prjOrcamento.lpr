program prjOrcamento;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, uCadModelo, ucadusuarios, dm, zcomponent, ucadCategoria,
  uCadCliente, uMenu, ucadproduto, uOrcamento;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFmainMenu, FmainMenu);
  Application.CreateForm(TFCadModelo5, FCadModelo5);
  Application.Run;
end.

