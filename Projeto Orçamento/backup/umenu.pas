unit uMenu;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, uCadCliente, uCadCategoria, uCadproduto, ucadCategoria,
  Menus;

type

  { TFmainMenu }

  TFmainMenu = class(TForm)
    MainMenu1: TMainMenu;
    mnCadOrcamentos: TMenuItem;
    mnCadClientes: TMenuItem;
    mnCadCategoria: TMenuItem;
    mnCadProduto: TMenuItem;
    mnCadastro: TMenuItem;
    mnVendas: TMenuItem;
    mnRelatorios: TMenuItem;
    mnSair: TMenuItem;
    PageControl1: TPageControl;
    procedure mnCadCategoriaClick(Sender: TObject);
    procedure mnCadClientesClick(Sender: TObject);
    procedure mnCadOrcamentosClick(Sender: TObject);
    procedure mnCadProdutoClick(Sender: TObject);
    procedure mnSairClick(Sender: TObject);
  private

  public

  end;

var
  FCadModelo3: TFCadModelo3;
  FCadModelo2: TFCadModelo2;
  FmainMenu: TFmainMenu;

implementation

{$R *.lfm}

{ TFmainMenu }

procedure TFmainMenu.mnCadClientesClick(Sender: TObject);
begin
  if not Assigned(FCadModelo3) then
    FCadModelo3 := TFCadModelo3.Create(Self);

  FCadModelo3.ShowModal;

end;

procedure TFmainMenu.mnCadOrcamentosClick(Sender: TObject);
begin
  if not Assigned(FCadModelo5) then
      FCadModelo5 := TFCadModelo5.Create(Self);

    FCadModelo5.ShowModal;
end;

procedure TFmainMenu.mnCadProdutoClick(Sender: TObject);
begin
  if not Assigned(FCadModelo4) then
    FCadModelo4 := TFCadModelo4.Create(Self);

  FCadModelo4.ShowModal;
end;

procedure TFmainMenu.mnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFmainMenu.mnCadCategoriaClick(Sender: TObject);
begin
  if not Assigned(FCadModelo2) then
    FCadModelo2 := TFCadModelo2.Create(Self);

  FCadModelo2.ShowModal;

end;

end.

