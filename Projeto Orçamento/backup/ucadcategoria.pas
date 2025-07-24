unit ucadCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, ExtCtrls,
  StdCtrls, ZDataset, ZSqlUpdate, ZAbstractRODataset, uCadModelo, DB;

type

  { TFCadModelo2 }

  TFCadModelo2 = class(TFCadModelo)
    bdInfoCat: TDBMemo;
    cbOptnPesquisa: TComboBox;
    dsCategorias: TDataSource;
    edtUsuario: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel6: TPanel;
    qryCategorias: TZQuery;
    qryCategoriascategoriaprodutoid: TZIntegerField;
    qryCategoriasds_categoria_produto: TZRawStringField;
    qryCategoriasinfo_categoria_produto: TZRawStringField;
    updtCategorias: TZUpdateSQL;
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
  FCadModelo2: TFCadModelo2;

implementation

{$R *.lfm}

{ TFCadModelo2 }

procedure TFCadModelo2.btInserirClick(Sender: TObject);
begin
  pcModelo.ActivePage := pgCadastrar;
  qryCategorias.Insert;
  BitBtn3.Enabled := False;
  btExcluir.Enabled := False;
  BitBtn2.Enabled := True;
  BitBtn4.Enabled := True;
end;

procedure TFCadModelo2.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFCadModelo2.BitBtn2Click(Sender: TObject); //salvar
begin
  qryCategorias.Post;
  qryCategorias.Open;
  pcModelo.ActivePage:= pgPesquisar;
end;

procedure TFCadModelo2.BitBtn3Click(Sender: TObject); //editar
begin
  pcModelo.ActivePage:= pgPesquisar;
  qryCategorias.Edit;
end;

procedure TFCadModelo2.BitBtn4Click(Sender: TObject);  //cancelar
begin
  qryCategorias.Cancel;
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := True;
  pcModelo.ActivePage:= pgPesquisar;
end;

procedure TFCadModelo2.btExcluirClick(Sender: TObject);   //excluir
begin
  qryCategorias.Delete;
  ShowMessage('Categoria excluido com sucesso!');
end;

procedure TFCadModelo2.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := True;
  pcModelo.ActivePage := pgCadastrar;
end;

procedure TFCadModelo2.FormCreate(Sender: TObject);
begin
  pcModelo.ActivePage := pgPesquisar;
  qryCategorias.Active:= true;
end;

procedure TFCadModelo2.LabeledEdit1Change(Sender: TObject);
begin
  qryCategorias.close;
  qryCategorias.SQL.clear;

  if LabeledEdit1.Text <> '' then
  begin
    if cbOptnPesquisa.ItemIndex = 0 then
    begin
      qryCategorias.SQL.Add('SELECT CATEGORIAPRODUTOID, DS_CATEGORIA_PRODUTO, INFO_CATEGORIA_PRODUTO ' +
                                  'FROM CATEGORIA_PRODUTO ' +
                                  'WHERE CATEGORIAPRODUTOID::text ILIKE :id ');
      qryCategorias.ParamByName('id').AsString := '%' + LabeledEdit1.Text + '%';
    end else
    if cbOptnPesquisa.ItemIndex = 1 then
    begin
      qryCategorias.SQL.Add('SELECT CATEGORIAPRODUTOID, DS_CATEGORIA_PRODUTO, INFO_CATEGORIA_PRODUTO ' +
                                  'FROM CATEGORIA_PRODUTO ' +
                                  'WHERE DS_CATEGORIA_PRODUTO ILIKE :ds_categoria ');
      qryCategorias.ParamByName('ds_categoria').AsString := '%' + LabeledEdit1.Text + '%';
    end else
    if cbOptnPesquisa.ItemIndex = 2 then
    begin
      qryCategorias.SQL.Add('SELECT CATEGORIAPRODUTOID, DS_CATEGORIA_PRODUTO, INFO_CATEGORIA_PRODUTO ' +
                                  'FROM CATEGORIA_PRODUTO ' +
                                  'WHERE INFO_CATEGORIA_PRODUTO ILIKE :info_cat ');
      qryCategorias.ParamByName('info_cat').AsString := '%' + LabeledEdit1.Text + '%';
    end;
  end else
  begin
       qryCategorias.SQL.Add('SELECT CATEGORIAPRODUTOID, DS_CATEGORIA_PRODUTO, INFO_CATEGORIA_PRODUTO ' +
                                   'FROM CATEGORIA_PRODUTO ' +
                                   'ORDER BY CATEGORIAPRODUTOID ASC');
  end;
  qryCategorias.Open;

end;

end.

