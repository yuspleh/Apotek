unit carifakturbebas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  Buttons, StdCtrls, ZDataset;

type

  { TfrmCariFakturBebas }

  TfrmCariFakturBebas = class(TForm)
    btPilih: TBitBtn;
    dFaktur: TDatasource;
    DBGrid1: TDBGrid;
    ZQuery1: TZReadOnlyQuery;
    qFaktur: TZReadOnlyQuery;
    procedure btPilihClick(Sender: TObject);
    procedure cmbSimpanChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmCariFakturBebas: TfrmCariFakturBebas;

implementation
 uses main;
{$R *.lfm}

{ TfrmCariFakturBebas }

procedure TfrmCariFakturBebas.FormCreate(Sender: TObject);
begin
  qFaktur.Active:=TRUE;
end;

procedure TfrmCariFakturBebas.cmbSimpanChange(Sender: TObject);
begin


end;

procedure TfrmCariFakturBebas.btPilihClick(Sender: TObject);
var id:string;
begin
  id:=qFaktur.FieldByName('id').AsString;
  frmMain.cariResep(id);
  frmCariFakturBebas.Close;
end;

procedure TfrmCariFakturBebas.FormActivate(Sender: TObject);
begin
  qFaktur.Refresh;
end;

end.

