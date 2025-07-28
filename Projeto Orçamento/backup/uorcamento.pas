unit uOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, DBCtrls, StdCtrls, ZDataset, ZSqlUpdate, ZAbstractRODataset,
  uCadModelo, DB;

type

  { TFCadModelo5 }

  TFCadModelo5 = class(TFCadModelo)
    Button1: TButton;
    Button2: TButton;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LBDataOrc: TDBEdit;
    LBDataVal: TDBEdit;
    dsOrcamentoItem: TDataSource;
    DBGrid2: TDBGrid;
    dsOrcamento: TDataSource;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    qryOrcamento: TZQuery;
    updtOrcamento: TZUpdateSQL;
    qryOrcamentoItem: TZQuery;
    updtOrcamentoItem: TZUpdateSQL;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btInserirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private

  public

  end;

var
  FCadModelo5: TFCadModelo5;

implementation

{$R *.lfm}

{ TFCadModelo5 }

procedure TFCadModelo5.btInserirClick(Sender: TObject);
var
  dataAtual, dataValidade: TDateTime;
begin
  pcModelo.ActivePage := pgCadastrar;
  dataAtual := Date;
  dataValidade := IncMonth(dataAtual, 3);

  LBDataOrc.Text := DateToStr(dataAtual);
  LBDataVal.Text := DateToStr(dataValidade);
  qryOrcamento.Insert;
  BitBtn3.Enabled := False;
  btExcluir.Enabled := False;
  BitBtn2.Enabled := True;
  BitBtn4.Enabled := True;
end;

procedure TFCadModelo5.BitBtn2Click(Sender: TObject); //salvar
begin
  qryOrcamento.Post;
  qryOrcamento.Open;
  pcModelo.ActivePage:= pgPesquisar;
end;

procedure TFCadModelo5.BitBtn3Click(Sender: TObject);  //editar
begin
  pcModelo.ActivePage:= pgPesquisar;
  qryOrcamento.Edit;
end;

procedure TFCadModelo5.BitBtn4Click(Sender: TObject);  //cancelar
begin
  qryOrcamento.Cancel;
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := false;
  pcModelo.ActivePage:= pgPesquisar;
end;

procedure TFCadModelo5.btExcluirClick(Sender: TObject);  //excluir
begin
  qryOrcamento.Delete;
  ShowMessage('Orçamento excluido com sucesso!')
end;

procedure TFCadModelo5.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFCadModelo5.Button1Click(Sender: TObject);  //add item
begin

end;

procedure TFCadModelo5.Button2Click(Sender: TObject);   //excluir item
begin

end;

procedure TFCadModelo5.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := True;
  pcModelo.ActivePage := pgCadastrar;
end;

end.

