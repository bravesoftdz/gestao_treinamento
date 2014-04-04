object dmGestao: TdmGestao
  OldCreateOrder = False
  Height = 447
  Width = 498
  object cdsAluno: TClientDataSet
    Active = True
    Aggregates = <>
    FileName = '.\alunos.cds'
    Params = <>
    Left = 40
    Top = 40
    Data = {
      810000009619E0BD010000001800000005000000000003000000810002494404
      00010000000000044E4F4D450100490000000100055749445448020002006400
      05454D41494C01004900000001000557494454480200020064000646554E4341
      4F0100490000000100055749445448020002006400054E4956454C0400010000
      0000000000}
    object cdsAlunoID: TIntegerField
      FieldName = 'ID'
    end
    object cdsAlunoNOME: TStringField
      DisplayWidth = 50
      FieldName = 'NOME'
      Size = 100
    end
    object cdsAlunoEMAIL: TStringField
      DisplayWidth = 50
      FieldName = 'EMAIL'
      Size = 100
    end
    object cdsAlunoFUNCAO: TStringField
      DisplayWidth = 50
      FieldName = 'FUNCAO'
      Size = 100
    end
    object cdsAlunoNIVEL: TIntegerField
      FieldName = 'NIVEL'
    end
  end
  object IdSMTP1: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    Host = 'smtp.gmail.com'
    SASLMechanisms = <>
    Left = 128
    Top = 48
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = 'smtp.gmail.com:25'
    Host = 'smtp.gmail.com'
    MaxLineAction = maException
    Port = 25
    DefaultPort = 0
    SSLOptions.Mode = sslmClient
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 192
    Top = 104
  end
end
