unit supplier;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DBGrids, Buttons, ZDataset;

type

  { TfrmSupplier }

  TfrmSupplier = class(TForm)
    btHapus: TBitBtn;
    btBaru: TBitBtn;
    btBatal: TBitBtn;
    btEdit: TButton;
    btSimpan: TBitBtn;
    DBGrid1: TDBGrid;
    dSupplier: TDatasource;
    txSupplier: TEdit;
    txAlamat: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    qSupplier: TZReadOnlyQuery;
    ZQuery1: TZReadOnlyQuery;
    procedure btBaruClick(Sender: TObject);
    procedure btBatalClick(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure btHapusClick(Sender: TObject);
    procedure btSimpanClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qSupplierAfterRefresh(DataSet: TDataSet);

    {user procedure}
    procedure tombolMati();
    procedure tombolHidup();
    procedure txAlamatKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txSupplierKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );

  private
    editMode:boolean;
    idSupplier:string;
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSupplier: TfrmSupplier;

implementation
  uses penerimaanobat;
{$R *.lfm}

{ TfrmSupplier }
procedure TfrmSupplier.tombolMati();
begin
  btBaru.Enabled:=FALSE;
  btSimpan.Enabled:=TRUE;
  btBatal.Enabled:=TRUE;
  btEdit.Enabled:=FALSE;
  btHapus.Enabled:=FALSE;
  txSupplier.Enabled:=TRUE;
  txAlamat.Enabled:=TRUE;
  txSupplier.Text:='';
  txAlamat.Text:='';
end;
procedure TfrmSupplier.tombolHidup();
begin
  btBaru.Enabled:=TRUE;
  btSimpan.Enabled:=FALSE;
  btBatal.Enabled:=FALSE;
  btEdit.Enabled:=TRUE;
  btHapus.Enabled:=TRUE;
  txSupplier.Enabled:=FALSE;
  txAlamat.Enabled:=FALSE;
end;

procedure TfrmSupplier.txAlamatKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=word(13) then btSimpan.SetFocus;
end;

procedure TfrmSupplier.txSupplierKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=word(13) then txAlamat.SetFocus;
end;

procedure TfrmSupplier.FormCreate(Sender: TObject);
begin
  qSupplier.Active:=TRUE;
end;

procedure TfrmSupplier.qSupplierAfterRefresh(DataSet: TDataSet);
begin
  frmPenerimaanObat.qSupplier.Refresh;
end;

procedure TfrmSupplier.btBaruClick(Sender: TObject);
begin
  tombolMati();
  txSupplier.SetFocus;
end;

procedure TfrmSupplier.btBatalClick(Sender: TObject);
begin
  editMode:=FALSE;
  idSupplier:='0';
  tombolHidup();
end;

procedure TfrmSupplier.btEditClick(Sender: TObject);
var id:string;
begin
  editMode:=TRUE;
  idSupplier:=qSupplier.FieldByName('id').AsString;
  id:=quotedstr(idSupplier);
  tombolMati();
  with zquery1 do
  begin
    sql.text:='select supplier,alamat from supplier where id='+id;
    execSQl;active:=TRUE;
    txSupplier.Text:=fieldbyname('supplier').AsString;
    txAlamat.Text:=fieldbyname('alamat').AsString;
    active:=FALSE;
  end;
end;

procedure TfrmSupplier.btHapusClick(Sender: TObject);
var id:string;
begin
   id:=quotedstr(qSupplier.FieldByName('id').AsString);
   with zquery1 do
   begin
     sql.text:='update supplier set aktif=0 where id='+id;
     execSQL;
   end;
   qSupplier.Refresh;
end;

procedure TfrmSupplier.btSimpanClick(Sender: TObject);
var id,sup,al:string;
begin
  sup:=quotedstr(txSupplier.Text);
  al:=quotedstr(txAlamat.Text);
  id:=idSupplier;
  with zquery1 do
  begin
    if editMode=TRUE then
    sql.text:='update supplier set supplier='+sup+',alamat='+al+
    ' where id='+id
    else
    sql.text:='insert into supplier(supplier,alamat) values'+
    '('+sup+','+al+')';
    execSQL;

  end;
  qSupplier.Refresh;
  txSupplier.Text:='';txAlamat.Text:='';
  tombolHidup();
  btBaru.SetFocus;
end;

procedure TfrmSupplier.FormActivate(Sender: TObject);
begin
  btBaru.SetFocus;
end;

end.

