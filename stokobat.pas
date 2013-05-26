unit stokobat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, ZDataset, Grids;

type

  { TfrmStokObat }

  TfrmStokObat = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    dStokObat: TDatasource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    txObat: TEdit;
    ZQuery1: TZReadOnlyQuery;
    qStokObat: TZReadOnlyQuery;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
    paramCari:string;
  public
    { public declarations }
  end; 

var
  frmStokObat: TfrmStokObat;

implementation

{$R *.lfm}

{ TfrmStokObat }

procedure TfrmStokObat.FormCreate(Sender: TObject);
begin
  paramCari:='%%';
  qStokObat.Active:=TRUE;
  qStokObat.ParamByName('obat').AsString:=paramCari;
  qStokObat.Refresh;
end;

procedure TfrmStokObat.Button1Click(Sender: TObject);
var ob:string;
begin
   ob:='%'+txObat.Text+'%';
   with qStokObat do
   begin
     paramCari:=ob;
     parambyname('obat').AsString:=ob;
     refresh;
   end;
end;

procedure TfrmStokObat.ComboBox1Change(Sender: TObject);
var fld,urut:string;
begin
   {Abjad A-Z
Abjaz Z-A
Stok Terkecil
Stok Terbesar
}
   if combobox1.Text = 'Abjad A-Z' then begin fld:='o.obat'; urut:='ASC'; end;
   if combobox1.Text = 'Abjad Z-A' then begin fld:='o.obat'; urut:='DESC'; end;
   if combobox1.Text = 'Stok Terkecil' then begin fld:='stok'; urut:='ASC'; end;
    if combobox1.Text = 'Stok Terbesar' then begin fld:='stok'; urut:='DESC'; end;

  with qStokObat do
  begin
    active:=FALSE;
    sql.text:='select o.id,o.obat,'+
    ' (select ifnull(sum(os.qty),0) as qty  from obat_stok as os  left join faktur_terima as ft on ft.id=os.faktur where ft.simpan=1 and os.obat=o.id) -  '+
    ' (select ifnull(sum(ob.qty),0) as qty  from obat_bebas as ob  left join faktur_bebas as fb on fb.id=ob.faktur where fb.simpan=1 and ob.obat=o.id) '+
    ' as stok '+
    ' from obat as o '+
    ' where o.obat LIKE :obat '+
    ' order by '+fld+ ' ' +urut;
    parambyname('obat').AsString:=paramCari;
    execSQL;  active:=TRUE;
  end;
end;

procedure TfrmStokObat.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin
  if Column.FieldName='stok' then
  begin
    if Column.Field.AsInteger<=0 then
    begin
      with (Sender As TDBGrid) do
      begin
        //Custom drawing
        //Canvas.Brush.Color:=clYellow;
        Canvas.Brush.Color:=TColor($d4fcff);
        Canvas.Font.Color:=clRed;
        //Canvas.Font.Style:=[fsBold];
      end;
    end;

  end;

end;

procedure TfrmStokObat.FormActivate(Sender: TObject);
begin
  qStokObat.Refresh;
end;

end.

