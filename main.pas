unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, DBGrids, DbCtrls, ExtCtrls, Buttons, EditBtn, LR_Class, LR_DBSet,
  ZDataset;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btCariFaktur: TBitBtn;
    btCetak: TBitBtn;
    btBatal: TBitBtn;
    btEdit: TBitBtn;
    btSimpan: TBitBtn;
    btBaru: TBitBtn;
    btPlus: TButton;
    btMinus: TButton;
    tglResep: TDateEdit;
    DBGrid1: TDBGrid;
    cmbObat: TDBLookupComboBox;
    dObat: TDatasource;
    dListObat: TDatasource;
    frDBDataSet1: TfrDBDataSet;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblTotal: TLabel;
    Laporan: TfrReport;
    Label5: TLabel;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    qListObat: TZReadOnlyQuery;
    qTotal: TZReadOnlyQuery;
    Shape1: TShape;
    Shape2: TShape;
    Timer1: TTimer;
    Timer2: TTimer;
    txDokter: TEdit;
    txNama: TEdit;
    txAlamat: TEdit;
    txQty: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    qObat: TZReadOnlyQuery;
    ZQuery1: TZReadOnlyQuery;
    ZQuery2: TZReadOnlyQuery;
    procedure btCariFakturClick(Sender: TObject);
    procedure btBaruClick(Sender: TObject);
    procedure btBatalClick(Sender: TObject);
    procedure btCetakClick(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure btMinusClick(Sender: TObject);
    procedure btPlusClick(Sender: TObject);
    procedure btSimpanClick(Sender: TObject);
    procedure cmbObatKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure LaporanGetValue(const ParName: String; var ParValue: Variant);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure qTotalAfterRefresh(DataSet: TDataSet);
    procedure Shape1ChangeBounds(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);

    {user procedure}
    procedure tombolHidup();
    procedure tombolMati();
    procedure cariResep(idresep:string);
    procedure kosongText();
    procedure txAlamatKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txDokterKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txNamaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txQtyKeyPress(Sender: TObject; var Key: char);
    procedure txQtyKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { private declarations }
    idfaktur:string;
    editMode:boolean;
    {variabel laporan}
    lapNama,lapAlamat,lapDokter:string;
  public
    { public declarations }
  end; 

var
  frmMain: TfrmMain;

implementation
 uses obat,supplier,penerimaanObat,stokobat,lapPenjualanObat,
   carifakturbebas;
{$R *.lfm}

{ TfrmMain }
procedure TfrmMain.kosongText();
begin
  txNama.Text:='';
   txAlamat.Text:='';
   cmbObat.Text:='';
   txQty.Text:='';
   txDokter.Text:='';
   idfaktur:='';
   qListObat.ParamByName('faktur').AsString:='';
   qListObat.Refresh;
end;

procedure TfrmMain.cariResep(idresep:string);
var id:string;
begin
   id:=quotedstr(idresep);
   with zquery1 do
   begin
     sql.text:='select nama,alamat,dokter,tglresep as tgl from faktur_bebas where id='+id;
     execSQL;active:=TRUE;
     idfaktur:=idresep;
     txNama.Text:=fieldbyname('nama').AsString;
     txALamat.Text:=fieldbyname('alamat').AsString;
     txDokter.Text:=fieldbyname('dokter').AsString;
     tglResep.Date:=fieldbyname('tgl').AsDateTime;

     active:=FALSE;
   end;
   qListObat.ParamByName('faktur').AsString:=idfaktur;qListObat.Refresh;
   qTotal.ParamByName('faktur').AsString:=idfaktur;qTotal.Refresh;
end;

procedure TfrmMain.tombolHidup();
begin
   tglResep.Enabled:=TRUE;
   txNama.Enabled:=TRUE;
   txAlamat.Enabled:=TRUE;
   txDokter.Enabled:=TRUE;
   cmbObat.Enabled:=TRUE;
   txQty.Enabled:=TRUE;
   btPlus.Enabled:=TRUE;
   btMinus.Enabled:=TRUE;
   btBaru.Enabled:=FALSE;
   btSimpan.Enabled:=TRUE;
   btBatal.Enabled:=TRUE;
end;
procedure TfrmMain.tombolMati();
begin
   tglResep.Enabled:=FALSE;
   txNama.Enabled:=FALSE;
   txAlamat.Enabled:=FALSE;
   txDokter.Enabled:=FALSE;
   cmbObat.Enabled:=FALSE;
   txQty.Enabled:=FALSE;
   btPlus.Enabled:=FALSE;
   btMinus.Enabled:=FALSE;
   btBaru.Enabled:=TRUE;
   btSimpan.Enabled:=FALSE;
   btBatal.Enabled:=FALSE;


end;

procedure TfrmMain.txAlamatKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then txDokter.SetFocus;
end;

procedure TfrmMain.txDokterKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then cmbObat.SetFocus;
end;

procedure TfrmMain.txNamaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then txAlamat.SetFocus;
end;

procedure TfrmMain.txQtyKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8, #9]) then Key := #0;
end;

procedure TfrmMain.txQtyKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if key=word(13) then btPlus.SetFocus;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  qObat.Active:=TRUE;
  qListObat.Active:=TRUE;
  qTotal.Active:=TRUE;
  lblTotal.Caption:='';
end;

procedure TfrmMain.Label7Click(Sender: TObject);
begin

end;

procedure TfrmMain.LaporanGetValue(const ParName: String; var ParValue: Variant
  );
begin
   if ParName='Nama' then ParValue:=lapNama;
    if ParName='Alamat' then ParValue:=lapAlamat;
   if ParName='Dokter' then ParValue:=lapDokter;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if MessageDlg ('Apakah anda yakin ingin keluar?', mtConfirmation,   [mbYes, mbNo], 0) = mrYes then
     begin
     application.Terminate ;
     end
     else
     CloseAction:=caNone;
end;

procedure TfrmMain.btPlusClick(Sender: TObject);
var id,ob,qty,hrg:string;
begin
  ob:=quotedstr(cmbObat.KeyValue);
  qty:=quotedstr(txQty.Text);
  //hrg:=quotedstr(txHarga.Text);
  id:=quotedstr(idfaktur);
  with zquery1 do
  begin
    sql.text:='insert into obat_bebas(obat,qty,harga,faktur) select '+
    ob+','+qty+',harga,'+id+' from obat where id='+ob;
    execSQL;
  end;
  qListObat.Refresh;
  qTotal.Refresh;

  cmbObat.Text:='';
  txQty.Text:='';
  cmbObat.SetFocus;
end;

procedure TfrmMain.btSimpanClick(Sender: TObject);
var id,nm,al,dok,tgl:string;
begin
  tgl:=quotedstr(FormatDateTime('YYYY-MM-DD',tglResep.Date));
  id:=quotedstr(idfaktur);
  nm:=quotedstr(txNama.Text);
  al:=quotedstr(txALamat.Text);
  dok:=quotedstr(txDokter.Text);
  with zquery1 do
  begin
    sql.text:='update faktur_bebas set nama='+nm+', alamat='+al+
    ',dokter='+dok+',tglresep='+tgl+',simpan=1 where id='+id;
    execSQl;
  end;
  editMode:=FALSE;
  tombolMati();
  lapNama:=txNama.Text;
  lapAlamat:=txALamat.Text;
  lapDokter:=txDokter.Text;
  btCetak.Enabled:=TRUE;

end;

procedure TfrmMain.cmbObatKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then txQty.SetFocus;
end;

procedure TfrmMain.btBaruClick(Sender: TObject);
begin
  kosongText();
  with zquery1 do
  begin
    sql.text:='insert into faktur_bebas(tglresep) values(now())';
    execSQL;
    sql.text:='select LAST_INSERT_ID() as id';
    execSQL;
    active:=TRUE;
    idfaktur:=fieldbyname('id').AsString;
    active:=FALSE;
  end;
  qListObat.ParamByName('faktur').AsString:=idfaktur;
  qListObat.Refresh;
  qTotal.ParamByName('faktur').AsString:=idfaktur;
  qTotal.Refresh;
  tombolHidup();

end;

procedure TfrmMain.btCariFakturClick(Sender: TObject);
begin
  if not Assigned(frmCariFakturBebas) then
    application.CreateForm(TFrmCariFakturBebas,frmCariFakturBebas);
    frmCariFakturBebas.Show;
end;

procedure TfrmMain.btBatalClick(Sender: TObject);
var id:string;
begin
  id:=quotedstr(idfaktur);
  if editMode=FALSE then
    begin
      with zquery1 do
      begin
        sql.text:='delete from faktur_terima where id='+id;
        execSQL;
      end;
    end;
  editMode:=FALSE;
  tombolMati();kosongText();
end;

procedure TfrmMain.btCetakClick(Sender: TObject);
begin
  Laporan.LoadFromFile('Laporan/invoiceObatBebas.lrf');
  Laporan.ShowReport;
end;

procedure TfrmMain.btEditClick(Sender: TObject);
begin
  if (idfaktur<>'') AND  (idfaktur<>'0') then
    begin
    editMode:=TRUE;
    tombolHidup();;
    end;
end;

procedure TfrmMain.btMinusClick(Sender: TObject);
var id:string;
begin
  id:=quotedstr(qListObat.FieldByName('id').AsString);
  with zquery1 do
    begin
      sql.text:='delete from obat_bebas where id='+id;
      execSQL;
    end;
  qListObat.Refresh;
  qTotal.Refresh;
     lblTotal.Caption:=Format('%,0n',[qTotal.FieldByName('harga').AsCurrency]);
end;

procedure TfrmMain.MenuItem2Click(Sender: TObject);
begin
    if not Assigned(frmObat) then
    application.CreateForm(TFrmObat,frmObat);
    frmObat.Show;
end;

procedure TfrmMain.MenuItem4Click(Sender: TObject);
begin
   if not Assigned(frmPenerimaanObat) then
    application.CreateForm(TFrmPenerimaanObat,frmPenerimaanObat);
    frmPenerimaanObat.Show;
end;

procedure TfrmMain.MenuItem5Click(Sender: TObject);
begin
   if not Assigned(frmSupplier) then
    application.CreateForm(TFrmSupplier,frmSupplier);
    frmSupplier.Show;
end;

procedure TfrmMain.MenuItem7Click(Sender: TObject);
begin
  if not Assigned(frmStokObat) then
    application.CreateForm(TFrmStokObat,frmStokObat);
    frmStokObat.Show;
end;

procedure TfrmMain.MenuItem8Click(Sender: TObject);
begin
  if not Assigned(frmLapPenjualanObat) then
    application.CreateForm(TFrmLapPenjualanObat,frmLapPenjualanObat);
    frmLapPenjualanObat.Show;
end;

procedure TfrmMain.qTotalAfterRefresh(DataSet: TDataSet);
begin
  lblTotal.Caption:=Format('%.0n',[qTotal.FieldByName('harga').AsCurrency]);
end;

procedure TfrmMain.Shape1ChangeBounds(Sender: TObject);
begin

end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  if shape2.Brush.Color=clDefault then
    begin
    shape2.Brush.Color:=clRed;
    label7.Font.Color:=clWhite;
    end
    else
      begin
      shape2.Brush.Color:=clDefault;
      label7.Font.Color:=clBlack;
      end;
end;

procedure TfrmMain.Timer2Timer(Sender: TObject);
begin
  with zquery2 do
  begin
    execSQL;
    active:=TRUE;
    if RowsAffected>0 then
      begin
      label7.Caption:=inttostr(zquery2.RecordCount);
      label7.Visible:=TRUE;shape2.Visible:=TRUE;
      Timer1.Enabled:=TRUE;
      end else
      begin
      Timer1.Enabled:=FALSE;
      label7.Visible:=FALSE;shape2.Visible:=FALSE;
      end;
    active:=FALSE;
  end;
end;

end.

