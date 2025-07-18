unit uCadModelo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, Buttons, DBGrids, DBCtrls, dm;

type

  { TFCadModelo }

  TFCadModelo = class(TForm)
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    btSair: TBitBtn;
    btInserir: TBitBtn;
    btExcluir: TBitBtn;
    DBGrid1: TDBGrid;
    LabeledEdit1: TLabeledEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    pcModelo: TPageControl;
    pgPesquisar: TTabSheet;
    pgCadastrar: TTabSheet;
  private

  public

  end;

var
  FCadModelo: TFCadModelo;

implementation

{$R *.lfm}

{ TFCadModelo }



end.

