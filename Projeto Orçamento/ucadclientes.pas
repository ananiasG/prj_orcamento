unit uCadClientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ZDataset, ZSqlUpdate,
  uCadModelo, DB;

type

  { TFCadModelo1 }

  TFCadModelo1 = class(TFCadModelo)
    dsClientes: TDataSource;
    qryClientes: TZQuery;
    updtClientes: TZUpdateSQL;
  private

  public

  end;

var
  FCadModelo1: TFCadModelo1;

implementation

{$R *.lfm}

end.

