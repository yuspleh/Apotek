unit penerimaanobat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DBGrids, EditBtn, DbCtrls, Buttons, ZDataset;

type

  { TfrmPenerimaanObat }

  TfrmPenerimaanObat = class(TForm)
    btBaru: TBitBtn;
    btBatal: TBitBtn;
    btCari: TBitBtn;
    btEdit: TBitBtn;
    btHapus: TBitBtn;
    btPlus: TButton;
    btMinus: TButton;
    btSimpan: TBitBtn;
    dObatStok: TDatasource;
    Label7: TLabel;
    qObatStok: TZReadOnlyQuery;
    tglTempo: TDateEdit;
    DBGrid1: TDBGrid;
    cmbObat: TDBLookupComboBox;
    cmbSupplier: TDBLookupComboBox;
    dObat: TDatasource;
    dSupplier: TDatasource;
    txFaktur: TEdit;
    txHrgNet: TEdit;
    txQty: TEdit;
    txHarga: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    qObat: TZReadOnlyQuery;
    qSupplier: TZReadOnlyQuery;
    ZQuery1: TZReadOnlyQuery;
    procedure btBaruClick(Sender: TObject);
    procedure btBatalClick(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure btHapusClick(Sender: TObject);
    procedure btMinusClick(Sender: TObject);
    procedure btPlusClick(Sender: TObject);
    procedure btSimpanClick(Sender: TObject);
    procedure btCariClick(Sender: TObject);
    procedure cmbObatKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbSupplierKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qObatAfterRefresh(DataSet: TDataSet);
    procedure qSupplierAfterRefresh(DataSet: TDataSet);
    procedure tglTempoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    {user procedure}
    procedure tombolMati();
    procedure tombolMatiEdit();
    procedure tombolHidup();
    procedure kosongText();
    procedure cariFaktur(id:string);
    procedure txFakturKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txHargaKeyPress(Sender: TObject; var Key: char);
    procedure txHargaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txHrgNetKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txQtyKeyPress(Sender: TObject; var Key: char);
    procedure txQtyKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { private declarations }
    idfaktur:string;
    editMode:boolean;
  public
    { public declarations }
  end; 

var
  frmPenerimaanObat: TfrmPenerimaanObat;

implementation
 uses carifakturterima;
{$R *.lfm}

{ TfrmPenerimaanObat }
procedure TfrmPenerimaanObat.kosongText();
begin
  txFaktur.Text:='';
  cmbSupplier.Text:='';
  cmbObat.Text:='';
  txQty.Text:='';
  txHarga.Text:='';
  txHrgNet.Text:='';
  idfaktur:='0';
  qObatStok.ParamByName('faktur').AsString:='0';
  qObatStok.Refresh;
end;

procedure TfrmPenerimaanObat.cariFaktur(id:string);
var idf:string;
begin
   idf:=quotedstr(id);
   with zquery1 do
   begin
      sql.text:='select ft.id,ft.no,ft.supplier from faktur_terima as ft '+
      'where ft.id='+idf;
      execSQL;
      active:=TRUE;
      idfaktur:=fieldbyname('id').AsString;
      txFaktur.Text:=fieldbyname('no').AsString;
      cmbSupplier.Text:='';
      cmbSupplier.KeyValue:=fieldbyname('supplier').AsString;
      active:=FALSE;
   end;
   qObatStok.ParamByName('faktur').AsString:=idfaktur;
   qObatStok.Refresh;
end;

procedure TfrmPenerimaanObat.tombolMati();
begin
  btBaru.Enabled:=FALSE;
  btSimpan.Enabled:=TRUE;
  btBatal.Enabled:=TRUE;
  btEdit.Enabled:=FALSE;
  txFaktur.Enabled:=TRUE;
  cmbSupplier.Enabled:=TRUE;
  tglTempo.Enabled:=TRUE;
  cmbObat.Enabled:=TRUE;
  txQty.Enabled:=TRUE;
  txHarga.Enabled:=TRUE;
  txHrgNet.Enabled:=TRUE;
  btPlus.Enabled:=TRUE;
  btMinus.Enabled:=TRUE;
  kosongText();
end;
procedure TfrmPenerimaanObat.tombolMatiEdit();
begin
  btBaru.Enabled:=FALSE;
  btSimpan.Enabled:=TRUE;
  btBatal.Enabled:=TRUE;
  btEdit.Enabled:=FALSE;
  txFaktur.Enabled:=TRUE;
  cmbSupplier.Enabled:=TRUE;
  tglTempo.Enabled:=TRUE;
  cmbObat.Enabled:=TRUE;
  txQty.Enabled:=TRUE;
  txHarga.Enabled:=TRUE;
  txHrgNet.Enabled:=TRUE;
  btPlus.Enabled:=TRUE;
  btMinus.Enabled:=TRUE;

end;
procedure TfrmPenerimaanObat.tombolHidup();
begin
  btBaru.Enabled:=TRUE;
  btSimpan.Enabled:=FALSE;
  btBatal.Enabled:=FALSE;
  btEdit.Enabled:=TRUE;
  txFaktur.Enabled:=FALSE;
  cmbSupplier.Enabled:=FALSE;
  tglTempo.Enabled:=FALSE;
  cmbObat.Enabled:=FALSE;
  txQty.Enabled:=FALSE;
  txHarga.Enabled:=FALSE;
  txHrgNet.Enabled:=FALSE;
  btPlus.Enabled:=FALSE;
  btMinus.Enabled:=FALSE;

end;

procedure TfrmPenerimaanObat.txFakturKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then cmbSupplier.SetFocus;
end;

procedure TfrmPenerimaanObat.txHargaKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8, #9]) then Key := #0;
end;

procedure TfrmPenerimaanObat.txHargaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then btPlus.SetFocus;
end;

procedure TfrmPenerimaanObat.txHrgNetKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then txHarga.SetFocus;
end;

procedure TfrmPenerimaanObat.txQtyKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8, #9]) then Key := #0;
end;

procedure TfrmPenerimaanObat.txQtyKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then txHrgNet.SetFocus;
end;

procedure TfrmPenerimaanObat.FormCreate(Sender: TObject);
begin
  qObat.Active:=TRUE;
  qSupplier.Active:=TRUE;
  qObatStok.Active:=TRUE;
end;

procedure TfrmPenerimaanObat.qObatAfterRefresh(DataSet: TDataSet);
begin
  cmbObat.Refresh;
end;

procedure TfrmPenerimaanObat.qSupplierAfterRefresh(DataSet: TDataSet);
begin
  cmbSupplier.Refresh;
end;

procedure TfrmPenerimaanObat.tglTempoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then cmbObat.SetFocus;
end;

procedure TfrmPenerimaanObat.btBaruClick(Sender: TObject);
begin
  with zquery1 do
  begin
    sql.text:='insert into faktur_terima(tgl) values(now())';
    execSQL;
    sql.text:='select LAST_INSERT_ID() as id';
    execSQL;
    active:=TRUE;
    idfaktur:=fieldbyname('id').AsString;
    active:=FALSE;
  end;
  tombolMati();
  qObatStok.ParamByName('faktur').AsString:=idfaktur;
  txFaktur.SetFocus;
end;

procedure TfrmPenerimaanObat.btBatalClick(Sender: TObject);
var idf:string;
begin
  idf:=quotedstr(idfaktur);
  if editMode=FALSE then
    begin
      with zquery1 do
      begin
        sql.text:='delete from faktur_terima where id='+idf;
        execSQL;
      end;
    end;
  tombolHidup();
  kosongText();
end;

procedure TfrmPenerimaanObat.btEditClick(Sender: TObject);
begin
  if (idfaktur<>'') AND  (idfaktur<>'0') then
    begin
    editMode:=TRUE;
    tombolMatiEdit();
    end;
end;

procedure TfrmPenerimaanObat.btHapusClick(Sender: TObject);
var id:string;
begin
  if (idfaktur<>'') and (idfaktur<>'0') then
  begin
  id:=quotedstr(idfaktur);
  if MessageDlg ('Apakah anda yakin akan menghapus faktur ini?', mtConfirmation,   [mbYes, mbNo], 0) = mrYes then
     begin
     with zquery1 do
          begin
            sql.text:='delete from faktur_terima where id='+id;
            execSQL;
            sql.text:='delete from obat_stok where faktur='+id;
            execSQL;
          end;
     end;
  tombolHidup();
  idfaktur:='';
   txFaktur.Text:='';
  cmbSupplier.Text:='';
  cmbObat.Text:='';
  txQty.Text:='';
  txHarga.Text:='';
  qObatStok.ParamByName('faktur').AsString:='0';
  qObatStok.Refresh;
  end;

end;

procedure TfrmPenerimaanObat.btMinusClick(Sender: TObject);
var id:string;
begin
   id:=quotedstr(qObatStok.FieldByName('id').AsString);
   with zquery1 do
   begin
     sql.text:='delete from obat_stok where id='+id;
     execSQL;
   end;
   qObatStok.Refresh;
end;

procedure TfrmPenerimaanObat.btPlusClick(Sender: TObject);
var id,ob,qty,hrg,hrgs,nett:string;
  hrgsat:currency;
  qtysat:integer;
begin
  qtysat:=strtoint(txQty.Text);
  hrgsat:=strtocurr(txHarga.Text)/qtysat;
  hrgs:=quotedstr(currtostr(hrgsat));
  ob:=quotedstr(cmbObat.KeyValue);
  qty:=quotedstr(txQty.Text);
  hrg:=quotedstr(txHarga.Text);
  id:=quotedstr(idfaktur);
  nett:=quotedstr(txHrgNet.Text);

  with zquery1 do
  begin
    sql.text:='insert into obat_stok(obat,qty,harga,faktur,netto) values'+
    '('+ob+','+qty+','+hrg+','+id+','+nett+')';
    execSQL;
    sql.text:='update obat set harga=round('+hrgs+'+('+hrgs+'*30/100)) where id='+ob;
    execSQL;
  end;
  qObatStok.Refresh;
  cmbObat.Text:='';
  txQty.Text:='';
  txHarga.Text:='';txHrgNet.Text:='';
  cmbObat.SetFocus;

end;

procedure TfrmPenerimaanObat.btSimpanClick(Sender: TObject);
var id,fak,sup,tgl:string;
begin
  if txFaktur.Text='' then
    begin
      MessageDlg('Maaf, No Faktur harus diisi.',mtError,[mbOK],0);
      exit;
    end;

  id:=quotedstr(idfaktur);
  fak:=quotedstr(txFaktur.Text);
  sup:=quotedstr(cmbSupplier.KeyValue);
  tgl:=quotedstr(FormatDateTime('YYYY-MM-DD',tglTempo.Date));
  with zquery1 do
  begin
    sql.text:='update faktur_terima set no='+fak+', supplier='+sup+
    ',tempo='+tgl+',simpan=1 where id='+id;
    execSQl;
  end;
  tombolHidup();
end;

procedure TfrmPenerimaanObat.btCariClick(Sender: TObject);
begin
  if not Assigned(frmCariFakturTerima) then
    application.CreateForm(TFrmCariFakturTerima,frmCariFakturTerima);
    frmCariFakturTerima.Show;
end;

procedure TfrmPenerimaanObat.cmbObatKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then txQty.SetFocus;
end;

procedure TfrmPenerimaanObat.cmbSupplierKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then tglTempo.SetFocus;
end;

procedure TfrmPenerimaanObat.FormActivate(Sender: TObject);
begin
  kosongText();
  qObat.execSQL; qObat.Active:=TRUE;
  qSupplier.execSQL;qSupplier.Active:=TRUE;
  qObatStok.execSQL;qObatStok.Active:=TRUE;
end;

end.

