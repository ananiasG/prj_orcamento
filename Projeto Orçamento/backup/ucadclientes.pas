unit uCadClientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  DBCtrls, StdCtrls, Buttons, ZDataset, ZSqlUpdate, uCadModelo, DB, SQLDB, dm, Types;

type

  { TFCadModelo1 }

  TFCadModelo1 = class(TFCadModelo)
    cbOptnPesquisa: TComboBox;
    edtUsuario: TDBEdit;
    edtNomeCompleto: TDBEdit;
    edtSenha: TDBEdit;
    dsClientes: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel6: TPanel;
    qryClientes: TZQuery;
    updtClientes: TZUpdateSQL;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btInserirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure cbOptnPesquisaChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure dsClientesDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure qryClientesAfterPost(DataSet: TDataSet);
  private

  public

  end;

var
  FCadModelo1: TFCadModelo1;

implementation

{$R *.lfm}

{ TFCadModelo1 }

procedure TFCadModelo1.BitBtn2Click(Sender: TObject);
begin
  qryClientes.Post;
  qryClientes.Open;
  pcModelo.ActivePage:= pgPesquisar;
end;

procedure TFCadModelo1.BitBtn3Click(Sender: TObject);
begin
  pcModelo.ActivePage:= pgPesquisar;
  qryClientes.Edit;
end;

procedure TFCadModelo1.BitBtn4Click(Sender: TObject);
begin
  qryClientes.Cancel;
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := True;
  pcModelo.ActivePage:= pgPesquisar;
end;

procedure TFCadModelo1.btExcluirClick(Sender: TObject);
begin
  qryClientes.Delete;
  ShowMessage('Usuário excluido com sucesso!');
end;

procedure TFCadModelo1.btInserirClick(Sender: TObject);
begin
  qryClientes.Insert;
  pcModelo.ActivePage:= pgCadastrar;
  BitBtn3.Enabled := False;
  btExcluir.Enabled := False;
  BitBtn2.Enabled := True;
  BitBtn4.Enabled := True;
end;

procedure TFCadModelo1.btSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFCadModelo1.cbOptnPesquisaChange(Sender: TObject);
begin
  qryClientes.Open;
end;

procedure TFCadModelo1.DBGrid1DblClick(Sender: TObject);
begin
  pcModelo.ActivePage:= pgCadastrar;
  BitBtn3.Enabled := True;
  btExcluir.Enabled := True;
  BitBtn2.Enabled := false;
  BitBtn4.Enabled := True;
end;

procedure TFCadModelo1.dsClientesDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TFCadModelo1.FormCreate(Sender: TObject);
begin
  pcModelo.ActivePage := pgPesquisar;
end;

procedure TFCadModelo1.LabeledEdit1Change(Sender: TObject);
begin
  qryClientes.close;
  qryClientes.SQL.clear;

  if LabeledEdit1.Text <> '' then
  begin
    if cbOptnPesquisa.ItemIndex = 0 then
    begin
      qryClientes.SQL.Add('SELECT id, nome_completo, usuario, senha ' +
                                  'FROM USUARIOS ' +
                                  'WHERE id::text ILIKE :Pid ');
      qryClientes.ParamByName('Pid').AsString := '%' + LabeledEdit1.Text + '%';
    end else
    if cbOptnPesquisa.ItemIndex = 1 then
    begin
      qryClientes.SQL.Add('SELECT id, nome_completo, usuario, senha ' +
                                  'FROM USUARIOS ' +
                                  'WHERE nome_completo ILIKE :pNomeCompleto ');
      qryClientes.ParamByName('pNomeCompleto').AsString := '%' + LabeledEdit1.Text + '%';
    end else
    if cbOptnPesquisa.ItemIndex = 2 then
    begin
      qryClientes.SQL.Add('SELECT id, nome_completo, usuario, senha ' +
                                  'FROM USUARIOS ' +
                                  'WHERE usuario ILIKE :pUsuario ');
      qryClientes.ParamByName('pUsuario').AsString := '%' + LabeledEdit1.Text + '%';
    end;
  end else
  begin
       qryClientes.SQL.Add('SELECT id, nome_completo, usuario, senha ' +
                                   'FROM usuarios ' +
                                   'ORDER BY id ASC');
  end;
  qryClientes.Open;

end;
procedure TFCadModelo1.qryClientesAfterPost(DataSet: TDataSet);
begin
  qryClientes.Close;
  qryClientes.SQL.Clear;
  qryClientes.SQL.Add('SELECT id, nome_completo, usuario, senha ' +
                                   'FROM usuarios ' +
                                   'ORDER BY id ASC');
  qryClientes.Open;
end;


end.

