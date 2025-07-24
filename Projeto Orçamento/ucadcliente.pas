unit uCadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ExtCtrls, ZDataset, ZSqlUpdate, ZAbstractRODataset, uCadModelo, DB;

type

  { TFCadModelo3 }

  TFCadModelo3 = class(TFCadModelo)
    cbOptnPesquisa: TComboBox;
    ComboBox1: TComboBox;
    DBComboBox2: TDBComboBox;
    DBEdit1: TDBEdit;
    dsClientes: TDataSource;
    edtUsuario: TDBEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel6: TPanel;
    qryClientes: TZQuery;
    qryClientesclienteid: TZIntegerField;
    qryClientescpf_cnpj_cliente: TZRawStringField;
    qryClientesnome_cliente: TStringField;
    qryClientestipo_cliente: TZRawStringField;
    updtClientes: TZUpdateSQL;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btInserirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
  private

  public

  end;

var
  FCadModelo3: TFCadModelo3;

implementation

{$R *.lfm}

{ TFCadModelo3 }

procedure TFCadModelo3.BitBtn2Click(Sender: TObject); //salvar
begin
  qryClientes.Post;
  qryClientes.Open;
  pcModelo.ActivePage:= pgPesquisar;
end;

procedure TFCadModelo3.BitBtn3Click(Sender: TObject); //editar
begin
  pcModelo.ActivePage:= pgPesquisar;
  qryClientes.Edit;
end;

procedure TFCadModelo3.BitBtn4Click(Sender: TObject);  //cancelar
begin
  qryClientes.Cancel;
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := True;
  pcModelo.ActivePage:= pgPesquisar;
end;

procedure TFCadModelo3.btExcluirClick(Sender: TObject);//excluir
begin
  qryClientes.Delete;
  ShowMessage('Cliente excluido com sucesso!');
end;

procedure TFCadModelo3.btInserirClick(Sender: TObject);
begin
  pcModelo.ActivePage := pgCadastrar;
  qryClientes.Insert;
  BitBtn3.Enabled := False;
  btExcluir.Enabled := False;
  BitBtn2.Enabled := True;
  BitBtn4.Enabled := True;
end;

procedure TFCadModelo3.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFCadModelo3.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := True;
  pcModelo.ActivePage := pgCadastrar;
end;

procedure TFCadModelo3.FormCreate(Sender: TObject);
begin
  pcModelo.ActivePage := pgPesquisar;
  qryClientes.Active:= true;
end;

procedure TFCadModelo3.LabeledEdit1Change(Sender: TObject);
begin
  qryClientes.close;
  qryClientes.SQL.clear;

  if LabeledEdit1.Text <> '' then
  begin
    if cbOptnPesquisa.ItemIndex = 0 then // CLIENTEID
    begin
      qryClientes.SQL.Add('SELECT CLIENTEID, NOME_CLIENTE, TIPO_CLIENTE, CPF_CNPJ_CLIENTE ' +
                          'FROM CLIENTE ' +
                          'WHERE CLIENTEID::text ILIKE :id');
      qryClientes.ParamByName('id').AsString := '%' + LabeledEdit1.Text + '%';
    end else
    if cbOptnPesquisa.ItemIndex = 1 then
    begin
      qryClientes.SQL.Add('SELECT clienteid, NOME_CLIENTE, TIPO_CLIENTE, CPF_CNPJ_CLIENTE ' +
                                  'FROM CLIENTE ' +
                                  'WHERE NOME_CLIENTE::text ILIKE :nome ');
      qryClientes.ParamByName('nome').AsString := '%' + LabeledEdit1.Text + '%';
    end
  end
  else
  begin
    qryClientes.SQL.Add('SELECT CLIENTEID, NOME_CLIENTE, TIPO_CLIENTE, CPF_CNPJ_CLIENTE ' +
                        'FROM CLIENTE ' +
                        'ORDER BY CLIENTEID ASC');
  end;

  qryClientes.Open;
end;

end.

