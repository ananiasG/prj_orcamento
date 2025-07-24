unit ucadproduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, ZDataset, ZSqlUpdate, ZAbstractRODataset, uCadModelo, DB, dm, ucadCategoria;

type

  { TFCadModelo4 }

  TFCadModelo4 = class(TFCadModelo)
    dbCBCategoria: TDBComboBox;
    dbCBStatus: TDBComboBox;
    cbOptnPesquisa: TDBComboBox;
    CBStatus: TDBComboBox;
    dbEditNome: TDBEdit;
    dbEditObs: TDBEdit;
    dbEditValorV: TDBEdit;
    dsProduto: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel6: TPanel;
    Panel7: TPanel;
    qryProduto: TZQuery;
    qryProdutods_categoria_produto: TZRawStringField;
    qryProdutods_produto: TZRawStringField;
    qryProdutodt_cadastro_produto: TZDateTimeField;
    qryProdutoobs_produto: TZRawStringField;
    qryProdutoprodutoid: TZIntegerField;
    qryProdutostatus_produto: TZRawStringField;
    qryProdutovl_venda_produto: TZBCDField;
    updtProduto: TZUpdateSQL;
    qryCategorias: TZQuery;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btInserirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
  private

  public

  end;

var
  FCadModelo4: TFCadModelo4;

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
  qryProduto.Post;
  qryProduto.Open;
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

procedure TFCadModelo4.FormCreate(Sender: TObject);
begin
  pcModelo.ActivePage := pgPesquisar;
  qryProduto.Active:= true;
end;

procedure TFCadModelo4.FormShow(Sender: TObject);
begin
  dbCBCategoria.Items.Clear;

  qryCategorias.Close;
  qryCategorias.SQL.Text :=
    'SELECT CATEGORIAPRODUTOID, DS_CATEGORIA_PRODUTO FROM CATEGORIA_PRODUTO ORDER BY DS_CATEGORIA_PRODUTO';
  qryCategorias.Open;

  while not qryCategorias.EOF do
  begin
    dbCBCategoria.Items.AddObject(
      qryCategorias.FieldByName('DS_CATEGORIA_PRODUTO').AsString,
      TObject(qryCategorias.FieldByName('CATEGORIAPRODUTOID').AsInteger)
    );
    qryCategorias.Next;
  end;
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
          'SELECT produtoid, DS_PRODUTO, OBS_PRODUTO, VL_VENDA_PRODUTO, DT_CADASTRO_PRODUTO, STATUS_PRODUTO ' +
          'FROM PRODUTO ' +
            'WHERE DS_PRODUTO ILIKE :ds_produto'
        );
        qryProduto.ParamByName('ds_produto').AsString := '%' + LabeledEdit1.Text + '%';
      end;

      1: begin
        qryProduto.SQL.Add(
          'SELECT DS_PRODUTO, OBS_PRODUTO, VL_VENDA_PRODUTO, DT_CADASTRO_PRODUTO, STATUS_PRODUTO ' +
          'FROM PRODUTO ' +
          'WHERE OBS_PRODUTO ILIKE :obs'
        );
        qryProduto.ParamByName('obs').AsString := '%' + LabeledEdit1.Text + '%';
      end;

      2: begin
        qryProduto.SQL.Add(
          'SELECT DS_PRODUTO, OBS_PRODUTO, VL_VENDA_PRODUTO, DT_CADASTRO_PRODUTO, STATUS_PRODUTO ' +
          'FROM PRODUTO ' +
          'WHERE STATUS_PRODUTO ILIKE :status'
        );
        qryProduto.ParamByName('status').AsString := '%' + LabeledEdit1.Text + '%';
      end;
    end;
  end
  else
  begin
    qryProduto.SQL.Add(
      'SELECT DS_PRODUTO, OBS_PRODUTO, VL_VENDA_PRODUTO, DT_CADASTRO_PRODUTO, STATUS_PRODUTO ' +
      'FROM PRODUTO ' +
      'ORDER BY DS_PRODUTO ASC'
    );
  end;

  qryProduto.Open;
end;


end.

