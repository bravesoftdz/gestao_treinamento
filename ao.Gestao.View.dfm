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
      Top = 16
      Width = 161
      Height = 25
      Caption = 'Gerar Apostilas'
      TabOrder = 0
      OnClick = bGerarApostilaClick
    end
    object Button1: TButton
      Left = 183
      Top = 16
      Width = 161
      Height = 25
      Caption = 'Lista de e-mails'
      TabOrder = 1
      OnClick = Button1Click
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
    Left = 112
    Top = 232
  end
end
