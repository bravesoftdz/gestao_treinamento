program aoGestao;

uses
  Vcl.Forms,
  ao.Gestao.View in 'ao.Gestao.View.pas' {fGestao},
  ao.Gestao.Model in 'ao.Gestao.Model.pas' {dmGestao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfGestao, fGestao);
  Application.CreateForm(TdmGestao, dmGestao);
  Application.Run;
end.
