unit ucadproduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, ZDataset, ZSqlUpdate, ZAbstractRODataset, uCadModelo, DB, dm, ucadCategoria, Types;

type

  { TFCadModelo4 }

  TFCadModelo4 = class(TFCadModelo)
    cbOptnPesquisa: TComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBComboBox1: TDBComboBox;
    dsProduto: TDataSource;
    dbEditNome: TDBEdit;
    dbEditObs: TDBEdit;
    dbEditValorV: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel6: TPanel;
    Panel7: TPanel;
    qryProduto: TZQuery;
    qryProdutocategoriaprodutoid: TZIntegerField;
    qryProdutods_categoria_produto: TZRawStringField;
    qryProdutods_produto: TZRawStringField;
    qryProdutodt_cadastro_produto: TZDateTimeField;
    qryProdutoobs_produto: TZRawStringField;
    qryProdutoprodutoid: TZIntegerField;
    qryProdutostatus_produto: TZRawStringField;
    qryProdutovl_venda_produto: TZBCDField;
    updtProduto: TZUpdateSQL;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btInserirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure qryProdutoAfterPost(DataSet: TDataSet);
  private

  public

  end;

var
  FCadModelo4: TFCadModelo4;
  OptionStatus: Integer;

implementation

{$R *.lfm}

{ TFCadModelo4 }

procedure TFCadModelo4.btInserirClick(Sender: TObject);
begin
  pcModelo.ActivePage := pgCadastrar;
  qryProduto.Insert;
  BitBtn3.Enabled := False;
  btExcluir.Enabled := False;
  BitBtn2.Enabled := True;
  BitBtn4.Enabled := True;

end;

procedure TFCadModelo4.BitBtn2Click(Sender: TObject); //salvar
begin
  qryProduto.Open;
  qryProdutodt_cadastro_produto.AsDateTime := Date;
  qryProduto.Post;
  pcModelo.ActivePage:= pgPesquisar;
end;

procedure TFCadModelo4.BitBtn3Click(Sender: TObject); //editar
begin
  pcModelo.ActivePage:= pgPesquisar;
  qryProduto.Edit;
end;

procedure TFCadModelo4.BitBtn4Click(Sender: TObject);  //cancelar
begin
  qryProduto.Cancel;
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := True;
  pcModelo.ActivePage:= pgPesquisar;

end;

procedure TFCadModelo4.btExcluirClick(Sender: TObject);  //excluir
begin
  qryProduto.Delete;
  ShowMessage('Produto excluido com sucesso!');
end;

procedure TFCadModelo4.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFCadModelo4.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := True;
  pcModelo.ActivePage := pgCadastrar;
end;

procedure TFCadModelo4.FormShow(Sender: TObject);
begin
  pcModelo.ActivePage := pgPesquisar;
  if not qryProduto.Active then
    qryProduto.Open;
end;

procedure TFCadModelo4.LabeledEdit1Change(Sender: TObject);
begin
  qryProduto.Close;
  qryProduto.SQL.Clear;

  if LabeledEdit1.Text <> '' then
  begin
      case cbOptnPesquisa.ItemIndex of
        0: begin
          qryProduto.SQL.Add(
          'SELECT P.PRODUTOID, P.DS_PRODUTO, P.OBS_PRODUTO, P.VL_VENDA_PRODUTO,P.DT_CADASTRO_PRODUTO,P.STATUS_PRODUTO,P.CATEGORIAPRODUTOID, C.DS_CATEGORIA_PRODUTO '+
          'FROM PRODUTO P ' +
          'INNER JOIN CATEGORIA_PRODUTO C ON P.CATEGORIAPRODUTOID = C.CATEGORIAPRODUTOID '+
          'WHERE cast(produtoid as text) ILIKE :id'
          );
          qryProduto.ParamByName('id').AsString := '%' + LabeledEdit1.Text + '%';
        end;

        1: begin
          qryProduto.SQL.Add(
          'SELECT P.PRODUTOID, P.DS_PRODUTO, P.OBS_PRODUTO, P.VL_VENDA_PRODUTO,P.DT_CADASTRO_PRODUTO,P.STATUS_PRODUTO, P.CATEGORIAPRODUTOID, C.DS_CATEGORIA_PRODUTO '+
          'FROM PRODUTO P ' +
          'INNER JOIN CATEGORIA_PRODUTO C ON P.CATEGORIAPRODUTOID = C.CATEGORIAPRODUTOID '+
          'WHERE cast(DS_PRODUTO as text) ILIKE :prod'
          );
          qryProduto.ParamByName('prod').AsString := '%' + LabeledEdit1.Text + '%';
        end;

        2: begin
          qryProduto.SQL.Add(
          'SELECT P.PRODUTOID, P.DS_PRODUTO, P.OBS_PRODUTO, P.VL_VENDA_PRODUTO,P.DT_CADASTRO_PRODUTO,P.STATUS_PRODUTO, P.CATEGORIAPRODUTOID, C.DS_CATEGORIA_PRODUTO '+
          'FROM PRODUTO P ' +
          'INNER JOIN CATEGORIA_PRODUTO C ON P.CATEGORIAPRODUTOID = C.CATEGORIAPRODUTOID '+
          'WHERE cast(OBS_PRODUTO as text) ILIKE :obs'
          );
          qryProduto.ParamByName('obs').AsString := '%' + LabeledEdit1.Text + '%';
        end;
        3: begin
          qryProduto.SQL.Add(
          'SELECT P.PRODUTOID, P.DS_PRODUTO, P.OBS_PRODUTO, P.VL_VENDA_PRODUTO,P.DT_CADASTRO_PRODUTO,P.STATUS_PRODUTO, P.CATEGORIAPRODUTOID, C.DS_CATEGORIA_PRODUTO '+
          'FROM PRODUTO P ' +
          'INNER JOIN CATEGORIA_PRODUTO C ON P.CATEGORIAPRODUTOID = C.CATEGORIAPRODUTOID '+
          'WHERE cast(DS_CATEGORIA_PRODUTO as text) ILIKE :cat'
          );
          qryProduto.ParamByName('cat').AsString := '%' + LabeledEdit1.Text + '%';
        end;
      end;
  end
  else
  begin
    qryProduto.SQL.Add(
    'SELECT P.PRODUTOID, P.DS_PRODUTO, P.OBS_PRODUTO, P.VL_VENDA_PRODUTO,P.DT_CADASTRO_PRODUTO,P.STATUS_PRODUTO,P.CATEGORIAPRODUTOID, C.DS_CATEGORIA_PRODUTO '+
    'FROM PRODUTO P ' +
    'INNER JOIN CATEGORIA_PRODUTO C ON P.CATEGORIAPRODUTOID = C.CATEGORIAPRODUTOID '+
    'ORDER BY PRODUTOID ASC'
    );
  end;

  qryProduto.Open;
end;

procedure TFCadModelo4.qryProdutoAfterPost(DataSet: TDataSet);
begin
  qryProduto.Close;
  qryProduto.SQL.Clear;
  qryProduto.SQL.Add('SELECT P.PRODUTOID, P.CATEGORIAPRODUTOID, P.DS_PRODUTO, C.DS_CATEGORIA_PRODUTO, ' +
                           'P.OBS_PRODUTO, P.STATUS_PRODUTO, P.VL_VENDA_PRODUTO, P.DT_CADASTRO_PRODUTO ' +
                           'FROM PRODUTO P LEFT JOIN CATEGORIA_PRODUTO C ON P.CATEGORIAPRODUTOID = C.CATEGORIAPRODUTOID ' +
                           'order by produtoid');
  qryProduto.Open;
end;

end.

