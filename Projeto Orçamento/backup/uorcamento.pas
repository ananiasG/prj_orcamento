unit uOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, DBCtrls, StdCtrls, DBDateTimePicker, ZDataset, ZSqlUpdate,
  ZAbstractRODataset, uCadModelo, DB;

type

  { TFCadModelo5 }

  TFCadModelo5 = class(TFCadModelo)
    btAdd: TButton;
    btDel: TButton;
    DataCad: TDBEdit;
    DataVal: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    bdDataCad: TDBEdit;
    DBEdit6: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dsOrcamentoItem: TDataSource;
    DBGrid2: TDBGrid;
    dsOrcamento: TDataSource;
    Label8: TLabel;
    Label9: TLabel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    qryOrcamento: TZQuery;
    qryOrcamentoclienteid: TZIntegerField;
    qryOrcamentodt_orcamento: TZDateTimeField;
    qryOrcamentodt_validade_orcamento: TZDateTimeField;
    qryOrcamentoItemorcamentoid: TZIntegerField;
    qryOrcamentoItemorcamentoitemid: TZIntegerField;
    qryOrcamentoItemprodutodesc: TZRawStringField;
    qryOrcamentoItemprodutoid: TZIntegerField;
    qryOrcamentoItemqt_produto: TZBCDField;
    qryOrcamentoItemvl_total: TZBCDField;
    qryOrcamentoItemvl_unitario: TZBCDField;
    qryOrcamentoorcamentoid: TZIntegerField;
    qryOrcamentovl_total_orcamento: TZBCDField;
    updtOrcamento: TZUpdateSQL;
    qryOrcamentoItem: TZQuery;
    updtOrcamentoItem: TZUpdateSQL;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btInserirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btDelClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure qryOrcamentoAfterPost(DataSet: TDataSet);
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
  dataAtual, dataValidade: TDate;
begin
  pcModelo.ActivePage := pgCadastrar;
  dataAtual := Date;
  dataValidade := IncMonth(dataAtual, 3);

  DataCad.Text := DateToStr(dataAtual);
  DataVal.Text := DateToStr(dataValidade);

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

procedure TFCadModelo5.btAddClick(Sender: TObject);  //add item
begin
  qryOrcamentoItem.Close;
  qryOrcamentoItem.Insert;
  qryOrcamentoItem.Post;
  qryOrcamentoItem.Open;
end;

procedure TFCadModelo5.btDelClick(Sender: TObject);   //excluir item
begin
  qryOrcamentoitem.Delete;
end;

procedure TFCadModelo5.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := True;
  pcModelo.ActivePage := pgCadastrar;
end;

procedure TFCadModelo5.qryOrcamentoAfterPost(DataSet: TDataSet);
begin
  qryOrcamento.Close;
  qryOrcamento.SQL.Clear;
  qryOrcamento.SQL.Add('SELECT P.PRODUTOID, P.CATEGORIAPRODUTOID, P.DS_PRODUTO, C.DS_CATEGORIA_PRODUTO, ' +
                           'P.OBS_PRODUTO, P.STATUS_PRODUTO, P.VL_VENDA_PRODUTO, P.DT_CADASTRO_PRODUTO ' +
                           'FROM PRODUTO P LEFT JOIN CATEGORIA_PRODUTO C ON P.CATEGORIAPRODUTOID = C.CATEGORIAPRODUTOID ' +
                           'order by produtoid');
  qryOrcamento.Open;
end;

end.

