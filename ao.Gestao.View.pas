unit ao.Gestao.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Data.DB;

type
  TfGestao = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    bGerarApostila: TButton;
    dsAlunos: TDataSource;
    Button1: TButton;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    Edit1: TEdit;
    Button2: TButton;
    CheckBox1: TCheckBox;
    procedure bGerarApostilaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fGestao: TfGestao;

implementation

{$R *.dfm}

uses ao.Gestao.Model;

procedure TfGestao.bGerarApostilaClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    dmGestao.GerarApostilas(Self.CheckBox1.Checked);
  finally
    Screen.Cursor := crDefault;
    MessageBox(Self.Handle, 'Processo finalizado!', 'Aten��o!', MB_ICONINFORMATION);
  end;
end;

procedure TfGestao.Button1Click(Sender: TObject);
var
  sResultado: string;
begin
  sResultado := dmGestao.ListagemEMail;
  ShowMessage(sResultado);
end;

procedure TfGestao.Button2Click(Sender: TObject);
begin
  if (Self.OpenDialog1.Execute(Self.Handle)) then
  begin
    Self.Edit1.Text := Self.OpenDialog1.FileName;
  end;
end;

procedure TfGestao.Edit1Change(Sender: TObject);
begin
  dmGestao.ArquivoWord := Self.Edit1.Text;
end;

procedure TfGestao.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

end.
