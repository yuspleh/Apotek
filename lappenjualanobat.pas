unit lappenjualanobat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  DBGrids, Calendar, StdCtrls, EditBtn, ZDataset;

type

  { TfrmLapPenjualanObat }

  TfrmLapPenjualanObat = class(TForm)
    Button1: TButton;
    tgl1: TDateEdit;
    tgl2: TDateEdit;
    DBGrid1: TDBGrid;
    dObat: TDatasource;
    Label1: TLabel;
    Label2: TLabel;
    qObat: TZReadOnlyQuery;
    ZQuery1: TZReadOnlyQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmLapPenjualanObat: TfrmLapPenjualanObat;

implementation

{$R *.lfm}

{ TfrmLapPenjualanObat }

procedure TfrmLapPenjualanObat.Button1Click(Sender: TObject);
var tg1,tg2:string;
begin
  tg1:=quotedstr(FormatDateTime('YYYY-MM-DD 00:00:00',tgl1.Date));
  tg2:=quotedstr(FormatDateTime('YYYY-MM-DD 23:59:59',tgl2.Date));
  with qObat do
  begin
    sql.text:='select o.id,o.obat, sum(ob.qty) as jumlah '+
    'from obat_bebas as ob '+
    'left join obat as o on o.id=ob.obat '+
    'left join faktur_bebas as fb on fb.id = ob.faktur '+
    'where fb.simpan=1 and fb.tgl between '+tg1+ ' and '+tg2+
    ' group by ob.obat';
    execSQL; active:=TRUE;
  end;
end;

procedure TfrmLapPenjualanObat.FormActivate(Sender: TObject);
begin
  qObat.Refresh;
end;

procedure TfrmLapPenjualanObat.FormCreate(Sender: TObject);
begin
  qObat.Active:=TRUE;
end;

end.

