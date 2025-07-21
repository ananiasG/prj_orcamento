unit uCadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ZDataset, ZSqlUpdate, ZAbstractRODataset, uCadModelo, DB;

type

  { TFCadModelo3 }

  TFCadModelo3 = class(TFCadModelo)
    DBComboBox1: TDBComboBox;
    dsClientes: TDataSource;
    qryClientes: TZQuery;
    qryClientesclienteid: TZIntegerField;
    qryClientescpf_cnpj_cliente: TZRawStringField;
    qryClientesnome_cliente: TStringField;
    qryClientestipo_cliente: TZRawStringField;
    updtClientes: TZUpdateSQL;
  private

  public

  end;

var
  FCadModelo3: TFCadModelo3;

implementation

{$R *.lfm}

{ TFCadModelo3 }


end.

