unit obat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DBGrids, ZDataset, Grids, Buttons;

type

  { TfrmObat }

  TfrmObat = class(TForm)
    btBaru: TBitBtn;
    btBatal: TBitBtn;
    btEdit: TButton;
    btHapus: TButton;
    btSimpan: TBitBtn;
    dObat: TDatasource;
    DBGrid1: TDBGrid;
    txObat: TEdit;
    Label1: TLabel;
    ZQuery1: TZReadOnlyQuery;
    qObat: TZReadOnlyQuery;
    procedure btBaruClick(Sender: TObject);
    procedure btBatalClick(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure btHapusClick(Sender: TObject);
    procedure btSimpanClick(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    {user procedure}
    procedure tombolMati();
    procedure tombolHidup();

    procedure txObatKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { private declarations }
    editMode:boolean;
    idObat:string;
  public
    { public declarations }
  end; 

var
  frmObat: TfrmObat;

implementation
  uses main,penerimaanobat;
{$R *.lfm}

{ TfrmObat }
procedure TfrmObat.tombolMati();
begin
  btBaru.Enabled:=FALSE;
  btSimpan.Enabled:=TRUE;
  btBatal.Enabled:=TRUE;
  btEdit.Enabled:=FALSE;
  btHapus.Enabled:=FALSE;
  txObat.Enabled:=TRUE;
  dbGrid1.Enabled:=FALSE;
end;
procedure TfrmObat.tombolHidup();
begin
  btBaru.Enabled:=TRUE;
  btSimpan.Enabled:=FALSE;
  btBatal.Enabled:=FALSE;
  btEdit.Enabled:=TRUE;
  btHapus.Enabled:=TRUE;
  txObat.Enabled:=FALSE;
  dbGrid1.Enabled:=TRUE;
end;

procedure TfrmObat.txObatKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then btSimpan.SetFocus;
end;

procedure TfrmObat.FormCreate(Sender: TObject);
begin
  qObat.Active:=TRUE;

end;

procedure TfrmObat.btSimpanClick(Sender: TObject);
var ob:string;
begin
  ob:=quotedstr(txObat.Text);
  with zquery1 do
  begin
    if editMode=TRUE then
    sql.text:='update obat set obat='+ob+' where id='+quotedstr(idObat)
    else
    sql.text:='insert into obat(obat,tgl,oleh) values'+
    '('+ob+',now(),0)';
    execSQL;
    frmMain.qObat.Refresh;
  end;
  frmPenerimaanObat.qObat.Refresh;
  frmMain.qObat.execSQL;
  frmMain.qObat.active:=TRUE;
  qObat.ExecSQL;qObat.Active:=TRUE;
  txObat.Text:='';
  tombolHidup();
  btBaru.SetFocus;
  editMode:=FALSE;

end;

procedure TfrmObat.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin

end;

procedure TfrmObat.FormActivate(Sender: TObject);
begin
  btBaru.SetFocus;
end;

procedure TfrmObat.btBaruClick(Sender: TObject);
begin
  tombolMati();
  txObat.SetFocus;
end;

procedure TfrmObat.btBatalClick(Sender: TObject);
begin
  tombolHidup();
  txObat.Text:='';
end;

procedure TfrmObat.btEditClick(Sender: TObject);
begin
  editMode:=TRUE;
  idObat:=qObat.FieldByName('id').AsString;
  txObat.Text:=qObat.FieldByName('obat').AsString;
  tombolMati();
end;

procedure TfrmObat.btHapusClick(Sender: TObject);
var id:string;
begin
   id:=quotedstr(qObat.FieldByName('id').AsString);
   with zquery1 do
   begin
     sql.text:='update obat set aktif=0 where id='+id;
     execSQL;
   end;
   qObat.Refresh;
end;

end.

