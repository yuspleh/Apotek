unit login;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ZConnection, ZDataset;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    txUser: TEdit;
    txPass: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Koneksi: TZConnection;
    ZQuery1: TZReadOnlyQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txPassKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txUserKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { private declarations }

  public
    { public declarations }
     iduser:string;
  end; 

var
  frmLogin: TfrmLogin;

implementation
   uses md5,main;
{$R *.lfm}

{ TfrmLogin }

procedure TfrmLogin.FormCreate(Sender: TObject);
begin

end;

procedure TfrmLogin.txPassKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then button1.SetFocus;
end;

procedure TfrmLogin.txUserKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=word(13) then txPass.SetFocus;
end;

procedure TfrmLogin.Button1Click(Sender: TObject);
var user,pass:string;
begin
  user:=quotedstr(txUser.Text);
  pass:=quotedstr(md5.StrMD5(txPass.Text));
  with zquery1 do
  begin
    sql.text:='select id from user where username='+user+
    ' and password='+pass;
    execSQL;
    active:=TRUE;
    if (RowsAffected=1) and (fieldbyname('id').AsString<>'') then
       begin
       iduser:=fieldbyname('id').AsString;
       active:=FALSE;
       application.CreateForm(TFrmMain,FrmMain);
       FrmMain.Show;
       frmLogin.Hide;
       end;
  end;
  txUser.Text:=''; txPass.Text:='';

  // application.CreateForm(TFrmMain,FrmMain);
  //     FrmMain.Show;
  //     frmLogin.Hide;

end;

procedure TfrmLogin.Button2Click(Sender: TObject);
begin
   if MessageDlg ('Apakah anda yakin ingin keluar?', mtConfirmation,   [mbYes, mbNo], 0) = mrYes then
     begin
     application.Terminate ;
     end
end;

end.

