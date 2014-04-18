object fGestao: TfGestao
  Left = 0
  Top = 0
  Caption = 'Gest'#227'o de Treinamento :: Alunos | Apostilas | Certificados'
  ClientHeight = 582
  ClientWidth = 848
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 848
    Height = 97
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object bGerarApostila: TButton
      Left = 16
      Top = 58
      Width = 161
      Height = 25
      Caption = 'Gerar Apostilas'
      TabOrder = 0
      OnClick = bGerarApostilaClick
    end
    object Button1: TButton
      Left = 183
      Top = 58
      Width = 161
      Height = 25
      Caption = 'Lista de e-mails'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 97
      Top = 17
      Width = 624
      Height = 21
      TabOrder = 2
      Text = 'Edit1'
      OnChange = Edit1Change
    end
    object Button2: TButton
      Left = 16
      Top = 14
      Width = 75
      Height = 25
      Caption = '&Abrir'
      TabOrder = 3
      OnClick = Button2Click
    end
    object CheckBox1: TCheckBox
      Left = 368
      Top = 62
      Width = 97
      Height = 17
      Caption = 'Modo Teste'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 97
    Width = 848
    Height = 466
    ActivePage = TabSheet1
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Alunos'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 840
        Height = 232
        Align = alClient
        DataSource = dsAlunos
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Panel2: TPanel
        Left = 0
        Top = 232
        Width = 840
        Height = 203
        Align = alBottom
        BevelInner = bvLowered
        Caption = 'Panel2'
        ShowCaption = False
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Convite e intru'#231#245'es - Grupos'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 840
        Height = 435
        Align = alClient
        Lines.Strings = (
          'Nome do grupo: turma999'
          ''
          '--'
          ''
          'Ol'#225'!'
          ''
          
            'Estamos criando este grupo para facilitar a comunica'#231#227'o e fortal' +
            'ecer a parceria entre a MORInfo e a arrayOF.'
          ''
          
            'D'#250'vidas, coment'#225'rios, sugest'#245'es, corre'#231#245'es e qualquer outro assu' +
            'nto relacionado ao treinamento "Criando Web Services de Alto Des' +
            'empenho com Delphi e Python" poder'#225' '
          'ser tratado por este canal.'
          ''
          'Sucesso a todos!'
          ''
          'M'#225'rio Guedes')
        TabOrder = 0
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 563
    Width = 848
    Height = 19
    Panels = <>
  end
  object dsAlunos: TDataSource
    DataSet = dmGestao.cdsAluno
    Left = 784
    Top = 16
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivos do MSWord|*.docx'
    Title = 'Selecionar arquivo ...'
    Left = 128
    Top = 208
  end
end
