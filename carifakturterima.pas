unit carifakturterima;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, ZDataset, Grids, ExtCtrls, Buttons;

type

  { TfrmCariFakturTerima }

  TfrmCariFakturTerima = class(TForm)
    btLunas: TBitBtn;
    btPilih: TBitBtn;
    DBGrid1: TDBGrid;
    dFaktur: TDatasource;
    Label5: TLabel;
    Label6: TLabel;
    qFaktur: TZReadOnlyQuery;
    Shape1: TShape;
    ZQuery1: TZReadOnlyQuery;
    procedure btLunasClick(Sender: TObject);
    procedure btPilihClick(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmCariFakturTerima: TfrmCariFakturTerima;

implementation
  uses penerimaanobat;
{$R *.lfm}

{ TfrmCariFakturTerima }

procedure TfrmCariFakturTerima.DBGrid1PrepareCanvas(sender: TObject;
  DataCol: Integer; Column: TColumn; AState: TGridDrawState);
begin
   if Column.FieldName='Tersimpan' then
  begin
    if Column.Field.AsString='Tidak' then
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

procedure TfrmCariFakturTerima.FormActivate(Sender: TObject);
begin
  qFaktur.Refresh;
end;

procedure TfrmCariFakturTerima.btPilihClick(Sender: TObject);
begin
  frmCariFakturTerima.Hide;
  frmPenerimaanObat.cariFaktur(qFaktur.FieldByName('id').AsString);
end;

procedure TfrmCariFakturTerima.btLunasClick(Sender: TObject);
var id:string;
begin
   id:=quotedstr(qFaktur.FieldByName('id').AsString);
   with zquery1 do
   begin
     sql.text:='update faktur_terima set lunas=1 where id='+id;
     execSQL;
   end;
   qFaktur.Refresh;
end;

procedure TfrmCariFakturTerima.FormCreate(Sender: TObject);
begin
  qFaktur.Active:=TRUE;
end;

end.

