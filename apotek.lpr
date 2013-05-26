program apotek;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, login, main, obat, penerimaanobat, supplier, zcomponent, stokobat,
  lazreport, carifakturterima, lappenjualanobat, md5, carifakturbebas
  { you can add units after this };

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmObat, frmObat);
  Application.CreateForm(TfrmPenerimaanObat, frmPenerimaanObat);
  Application.CreateForm(TfrmSupplier, frmSupplier);
  Application.CreateForm(TfrmStokObat, frmStokObat);
  Application.CreateForm(TfrmCariFakturTerima, frmCariFakturTerima);
  Application.CreateForm(TfrmLapPenjualanObat, frmLapPenjualanObat);
  Application.CreateForm(TfrmCariFakturBebas, frmCariFakturBebas);
  Application.Run;
end.

