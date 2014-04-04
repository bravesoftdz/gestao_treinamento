unit ao.Gestao.Model;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Datasnap.DBClient,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP;

type
  TdmGestao = class(TDataModule)
    cdsAluno: TClientDataSet;
    cdsAlunoID: TIntegerField;
    cdsAlunoNOME: TStringField;
    cdsAlunoEMAIL: TStringField;
    cdsAlunoFUNCAO: TStringField;
    cdsAlunoNIVEL: TIntegerField;
    IdSMTP1: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
  private
    { Private declarations }
  public
    procedure GerarApostilas;
    function ListagemEMail: string;
  end;

var
  dmGestao: TdmGestao;

implementation

uses
  System.Zip,
  System.IOUtils,
  System.RegularExpressions,
  Vcl.OleAuto,
  System.Variants,
  IdText,
  IdMessage,
  IdAttachmentFile;

{ %CLASSGROUP 'System.Classes.TPersistent' }

{$R *.dfm}
{ TdmGestao }

procedure TdmGestao.GerarApostilas;
const
  C_ARQUIVO = 'Criando Web Services de Alto Desempenho com Delphi e Python.docx';
  C_ORIGEM  =
    'D:\Material jmarioguedes\arrayOF\apostilas\delphi\Criando Web Services de Alto desempenho com Delphi e Python\Criando Web Services de Alto Desempenho com Delphi e Python.docx';
  C_DESTINO = '\' + C_ARQUIVO;

  procedure _DescompactarOriginal(const ANomeAluno: string);
  var
    oZip    : TZipFile;
    sArquivo: string;
  begin
    sArquivo := '.\' + ANomeAluno + C_DESTINO;
    oZip     := TZipFile.Create;
    try
      TDirectory.CreateDirectory('.\' + ANomeAluno);
      TFile.Copy(C_ORIGEM, sArquivo, True);

      oZip.Open(sArquivo, zmRead);
      oZip.ExtractAll('.\' + ANomeAluno);

    finally
      oZip.Close;
      oZip.Free;

      TFile.Delete(sArquivo);
    end;
  end;

  procedure _MacroSbstituicao(const ANomeAluno: string; AEMail: string);
  const
    C_ARQUIVOS: array [0 .. 1] of string = ('\word\footer1.xml', '\word\document.xml');
  var
    oArquivo : TStringStream;
    sConteudo: string;
    sAlvo    : string;
  begin
    oArquivo := TStringStream.Create('', TEncoding.UTF8);
    try
      for sAlvo in C_ARQUIVOS do
      begin
        oArquivo.LoadFromFile('.\' + ANomeAluno + sAlvo);
        sConteudo := oArquivo.DataString;

        sConteudo := TRegEx.Replace(sConteudo, 'NOME DO ALUNO', ANomeAluno);
        sConteudo := TRegEx.Replace(sConteudo, 'E-MAIL DO ALUNO', AEMail);

        oArquivo.Clear;
        oArquivo.WriteString(sConteudo);
        oArquivo.SaveToFile('.\' + ANomeAluno + sAlvo);
      end;
    finally
      oArquivo.Free;
    end;
  end;

  procedure _CompactarNova(const ANomeAluno: string);
  begin
    TZipFile.ZipDirectoryContents(ANomeAluno + '_' + C_ARQUIVO, '.\' + ANomeAluno);
    TDirectory.Delete('.\' + ANomeAluno, True);
  end;

  procedure _GerarPDF(const ANomeAluno: string);
  const
    wdFormatPDF = 17;
  var
    _msword    : Variant;
    _documento : Variant;
    _apostila  : Variant;
    sArquivo   : string;
    sArquivoPDF: string;
  begin
    sArquivo := ExtractFilePath(ParamStr(0)) + ANomeAluno + '_' + C_ARQUIVO;

    _msword := CreateOleObject('Word.Application');

    _documento := _msword.Documents;
    _apostila  := _documento.Open(ExtractFilePath(ParamStr(0)) + ANomeAluno + '_' + C_ARQUIVO);

    sArquivoPDF := ChangeFileExt(sArquivo, '.pdf');
    _apostila.SaveAs2(FileName := sArquivoPDF, FileFormat := wdFormatPDF);

    _apostila.Close();
    _msword.Quit;
    _msword := Unassigned;

    TFile.Delete(sArquivo);
  end;

  procedure _EnviarEmail(const ANomeAluno: string; AEMail: string);

    function _PrepararHTML: string;
    var
      slBuffer: TStringList;
    begin
      slBuffer := TStringList.Create;
      try
        slBuffer.Add('<html><head></head><body>');
        slBuffer.Add('<p>Olá <strong>%s</strong>!<br><br></p>');
        slBuffer.Add('<p>Você esta recebendo a versão 001 apostila do curso <strong>%s</strong><br></p>');
        slBuffer.Add('<p>Ela estará sempre em desenvolvimento e, mesmo após o término do curso, você receberá as novas versões.<br><br></p>');
        slBuffer.Add('<p>Por favor nos ajude a melhorar apontando erros e dando sugestões. Seu feedback é muito importante.<br><br></p>');
        slBuffer.Add('<p>A equipe arrayOF está honrada em tê-lo conosco.</p>');
        slBuffer.Add('</body></html>');

        Result := slBuffer.Text;
      finally
        slBuffer.Free;
      end;
    end;

  var
    _mensagem: TIdMessage;
    _texto   : TidText;
    sArquivo : string;
    sCurso   : string;
  begin
    _mensagem := TIdMessage.Create(nil);
    sCurso    := ChangeFileExt(C_ARQUIVO, '');
    sArquivo  := ExtractFilePath(ParamStr(0)) + ANomeAluno + '_' + C_ARQUIVO;
    sArquivo  := ChangeFileExt(sArquivo, '.pdf');
    try
      Self.IdSMTP1.Host     := 'smtp.gmail.com';
      Self.IdSMTP1.Port     := 587;
      Self.IdSMTP1.AuthType := satDefault;
      Self.IdSMTP1.UseTLS   := utUseRequireTLS;
      Self.IdSMTP1.Username := 'aluno@arrayof.com.br';
      Self.IdSMTP1.Password := 'aluno2014';
      Self.IdSMTP1.Connect();

      _mensagem.ContentType               := 'multipart/mixed';
      _mensagem.CharSet                   := 'ISO-8859-1';
      _mensagem.From.Address              := 'aluno@arrayof.com.br';
      _mensagem.From.Name                 := 'Central do Aluno - arrayOF Treinamento e Consultoria';
      _mensagem.Recipients.EMailAddresses := 'jmarioguedes@gmail.com'; // AEMail;
      _mensagem.CCList.EMailAddresses     := 'mario.guedes@arrayof.com.br';
      _mensagem.Subject                   := 'Apostila do Curso [Versão 001]: ' + sCurso;

      _texto             := TidText.Create(_mensagem.MessageParts, nil);
      _texto.ContentType := 'text/html';
      _texto.CharSet     := 'ISO-8859-1';
      _texto.Body.Text   := Format(_PrepararHTML, [ANomeAluno, sCurso]);

      TIdAttachmentFile.Create(_mensagem.MessageParts, sArquivo);

      Self.IdSMTP1.Send(_mensagem);
      Self.IdSMTP1.Disconnect(True);

      TFile.Delete(sArquivo);

    finally
      _mensagem.Free;
    end;
  end;

var
  aBook: TArray<Byte>;
begin
  Self.cdsAluno.DisableControls;
  try
    aBook := Self.cdsAluno.GetBookmark;

    Self.cdsAluno.First;
    while not Self.cdsAluno.Eof do
    begin

      _DescompactarOriginal(Self.cdsAlunoNOME.AsString);

      _MacroSbstituicao(Self.cdsAlunoNOME.AsString, Self.cdsAlunoEMAIL.AsString);

      _CompactarNova(Self.cdsAlunoNOME.AsString);

      _GerarPDF(Self.cdsAlunoNOME.AsString);

      _EnviarEmail(Self.cdsAlunoNOME.AsString, Self.cdsAlunoEMAIL.AsString);

      Self.cdsAluno.Next;
    end;

    Self.cdsAluno.GotoBookmark(aBook);
  finally
    Self.cdsAluno.EnableControls;
  end;
end;

function TdmGestao.ListagemEMail: string;
var
  aBook: TArray<Byte>;
begin
  Self.cdsAluno.DisableControls;
  try
    aBook := Self.cdsAluno.GetBookmark;
    Self.cdsAluno.First;
    while not Self.cdsAluno.Eof do
    begin
      if Length(Result) = 0 then
      begin
        Result := Self.cdsAlunoEMAIL.AsString;
      end
      else
      begin
        Result := Result + ', ' + Self.cdsAlunoEMAIL.AsString;
      end;

      Self.cdsAluno.Next;
    end;
    Self.cdsAluno.GotoBookmark(aBook);
  finally
    Self.cdsAluno.EnableControls;
  end;
end;

end.
