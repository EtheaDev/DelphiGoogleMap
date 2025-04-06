object formMain: TformMain
  Left = 427
  Top = 268
  Caption = 
    'Delphi with Edge Google Maps Viewer Component Demo - Copyright (' +
    'c) Ethea S.r.l.'
  ClientHeight = 729
  ClientWidth = 1445
  Color = clBtnFace
  Constraints.MinHeight = 550
  Constraints.MinWidth = 890
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 1445
    Height = 209
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 1441
    object gbMapAttributes: TGroupBox
      Left = 1
      Top = 1
      Width = 198
      Height = 207
      Align = alLeft
      Caption = 'Map Attributes'
      TabOrder = 0
      object lbZoom: TLabel
        Left = 135
        Top = 16
        Width = 26
        Height = 13
        Caption = 'Zoom'
      end
      object Label5: TLabel
        Left = 6
        Top = 16
        Width = 51
        Height = 13
        Caption = 'View Mode'
      end
      object Zoom: TSpinEdit
        Left = 135
        Top = 32
        Width = 57
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 15
        OnChange = ZoomChange
      end
      object MapTypeIdComboBox: TComboBox
        Left = 6
        Top = 32
        Width = 126
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 0
        Text = 'ROADMAP'
        OnChange = MapTypeIdComboBoxChange
        Items.Strings = (
          'ROADMAP'
          'SATELLITE'
          #39'HYBRID'
          'TERRAIN')
      end
      object cbCenterOnClick: TCheckBox
        Left = 6
        Top = 60
        Width = 100
        Height = 17
        Caption = 'Center on click'
        TabOrder = 2
        OnClick = CheckBoxStreeViewClick
      end
      object mapControlGroupBox: TGroupBox
        Left = -1
        Top = 79
        Width = 196
        Height = 99
        Caption = 'Map Controls'
        TabOrder = 3
        object CheckBoxTraffic: TCheckBox
          Left = 7
          Top = 17
          Width = 90
          Height = 17
          Caption = 'Traffic'
          TabOrder = 0
          OnClick = CheckBoxTrafficClick
        end
        object CheckBoxBicycling: TCheckBox
          Left = 102
          Top = 17
          Width = 90
          Height = 17
          Caption = 'Bicycling'
          TabOrder = 1
          OnClick = CheckBoxBicyclingClick
        end
        object CheckBoxStreeView: TCheckBox
          Left = 7
          Top = 40
          Width = 90
          Height = 17
          Caption = 'Street View'
          TabOrder = 2
          OnClick = CheckBoxStreeViewClick
        end
        object CheckBoxFullScreen: TCheckBox
          Left = 7
          Top = 63
          Width = 90
          Height = 17
          Caption = 'Full Screen'
          TabOrder = 4
          OnClick = CheckBoxFullScreenClick
        end
        object CheckBoxZoom: TCheckBox
          Left = 102
          Top = 40
          Width = 90
          Height = 17
          Caption = 'Zoom'
          TabOrder = 3
          OnClick = CheckBoxZoomClick
        end
        object CheckBoxMapType: TCheckBox
          Left = 102
          Top = 63
          Width = 90
          Height = 17
          Caption = 'Map Type'
          TabOrder = 5
          OnClick = CheckBoxMapTypeClick
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 199
      Top = 1
      Width = 302
      Height = 207
      Align = alLeft
      Caption = 'Location'
      TabOrder = 1
      object LabelLongitude: TLabel
        Left = 30
        Top = 109
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'Longitude'
      end
      object LabelAddress: TLabel
        Left = 10
        Top = 14
        Width = 39
        Height = 13
        Caption = 'Address'
      end
      object LabelLatitude: TLabel
        Left = 38
        Top = 79
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Latitude'
      end
      object MemoAddress: TMemo
        Left = 10
        Top = 29
        Width = 163
        Height = 44
        Lines.Strings = (
          '')
        TabOrder = 0
      end
      object ButtonGotoLocation: TButton
        Left = 177
        Top = 79
        Width = 99
        Height = 48
        Caption = 'Go to Latitude Lngitude'
        TabOrder = 3
        WordWrap = True
        OnClick = ButtonGotoLocationClick
      end
      object Longitude: TEdit
        Left = 83
        Top = 106
        Width = 90
        Height = 21
        TabOrder = 4
      end
      object ButtonGotoAddress: TButton
        Left = 178
        Top = 29
        Width = 99
        Height = 44
        Caption = 'Go to Address'
        TabOrder = 1
        OnClick = ButtonGotoAddressClick
      end
      object Latitude: TEdit
        Left = 83
        Top = 79
        Width = 90
        Height = 21
        TabOrder = 2
      end
    end
    object BottomPanel: TPanel
      Left = 1292
      Top = 1
      Width = 152
      Height = 207
      Align = alRight
      TabOrder = 2
      object ShowPrintUIButton: TButton
        AlignWithMargins = True
        Left = 4
        Top = 66
        Width = 144
        Height = 25
        Align = alTop
        Caption = 'Show Print UI'
        TabOrder = 2
        OnClick = ShowPrintUIButtonClick
        ExplicitWidth = 564
      end
      object ShowMapButton: TButton
        AlignWithMargins = True
        Left = 4
        Top = 35
        Width = 144
        Height = 25
        Align = alTop
        Caption = 'Show Map'
        TabOrder = 1
        OnClick = ShowMapButtonClick
        ExplicitWidth = 564
      end
      object HideMapButton: TButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 144
        Height = 25
        Align = alTop
        Caption = 'Hide map'
        TabOrder = 0
        OnClick = HideMapButtonClick
        ExplicitWidth = 564
      end
    end
  end
  object PopupMenu: TPopupMenu
    Left = 416
    Top = 264
  end
end
