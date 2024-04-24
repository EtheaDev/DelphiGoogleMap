object FormSecondary: TFormSecondary
  Left = 0
  Top = 0
  Caption = 
    'Delphi with Edge Google Maps Viewer Component Demo - Secondary f' +
    'orm'
  ClientHeight = 791
  ClientWidth = 1353
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
  TextHeight = 13
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 273
    Height = 791
    Align = alLeft
    TabOrder = 0
    object gbMapAttributes: TGroupBox
      Left = 1
      Top = 428
      Width = 271
      Height = 152
      Align = alTop
      Caption = 'Map Attributes'
      TabOrder = 0
      object lbZoom: TLabel
        Left = 5
        Top = 126
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
      object MapTypeIdComboBox: TComboBox
        Left = 3
        Top = 35
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
      object Zoom: TSpinEdit
        Left = 37
        Top = 122
        Width = 57
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 15
        OnChange = ZoomChange
      end
      object CheckBoxStreeView: TCheckBox
        Left = 13
        Top = 103
        Width = 70
        Height = 17
        Caption = 'Street View'
        TabOrder = 2
        OnClick = CheckBoxStreeViewClick
      end
      object CheckBoxBicycling: TCheckBox
        Left = 13
        Top = 83
        Width = 70
        Height = 17
        Caption = 'Bicycling'
        TabOrder = 3
        OnClick = CheckBoxBicyclingClick
      end
      object CheckBoxTraffic: TCheckBox
        Left = 13
        Top = 64
        Width = 61
        Height = 17
        Caption = 'Traffic'
        TabOrder = 4
        OnClick = CheckBoxTrafficClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 271
      Height = 136
      Align = alTop
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
      object LabelLatitude: TLabel
        Left = 38
        Top = 79
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Latitude'
      end
      object LabelAddress: TLabel
        Left = 10
        Top = 14
        Width = 39
        Height = 13
        Caption = 'Address'
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
        Left = 179
        Top = 79
        Width = 85
        Height = 48
        Caption = 'Go to Latitude Lngitude'
        TabOrder = 4
        WordWrap = True
        OnClick = ButtonGotoLocationClick
      end
      object Longitude: TEdit
        Left = 83
        Top = 106
        Width = 90
        Height = 21
        TabOrder = 3
      end
      object Latitude: TEdit
        Left = 83
        Top = 79
        Width = 90
        Height = 21
        TabOrder = 2
      end
      object ButtonGotoAddress: TButton
        Left = 181
        Top = 29
        Width = 87
        Height = 44
        Caption = 'Go to Address'
        TabOrder = 1
        OnClick = ButtonGotoAddressClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 137
      Width = 271
      Height = 291
      Align = alTop
      Caption = 'Routing'
      TabOrder = 2
      object Label3: TLabel
        Left = 42
        Top = 64
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'START'
      end
      object Label4: TLabel
        Left = 6
        Top = 90
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'DESTINATION'
      end
      object Label1: TLabel
        Left = 77
        Top = 46
        Width = 39
        Height = 13
        Caption = 'Latitude'
      end
      object Label2: TLabel
        Left = 174
        Top = 46
        Width = 47
        Height = 13
        Caption = 'Longitude'
      end
      object Label6: TLabel
        Left = 32
        Top = 151
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Address'
        WordWrap = True
      end
      object Label8: TLabel
        Left = 10
        Top = 23
        Width = 26
        Height = 13
        Alignment = taRightJustify
        Caption = 'Mode'
      end
      object StartLat: TEdit
        Left = 77
        Top = 61
        Width = 90
        Height = 21
        TabOrder = 1
      end
      object StartLng: TEdit
        Left = 174
        Top = 61
        Width = 90
        Height = 21
        TabOrder = 2
      end
      object DestLat: TEdit
        Left = 77
        Top = 87
        Width = 90
        Height = 21
        TabOrder = 3
      end
      object DestLng: TEdit
        Left = 174
        Top = 87
        Width = 90
        Height = 21
        TabOrder = 4
      end
      object cbxTravelMode: TComboBox
        Left = 42
        Top = 18
        Width = 126
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 0
        Text = 'DRIVING'
        OnChange = cbxTravelModeChange
        Items.Strings = (
          'DRIVING'
          'WALKING'
          'BICYCLING'
          'TRANSIT')
      end
      object ButtonRouteLatLng: TButton
        Left = 159
        Top = 117
        Width = 107
        Height = 25
        Caption = 'Route by locations'
        TabOrder = 5
        OnClick = ButtonRouteLatLngClick
      end
      object StartAddressMemo: TMemo
        Left = 77
        Top = 148
        Width = 187
        Height = 44
        Lines.Strings = (
          '')
        TabOrder = 6
      end
      object DestinationAddressMemo: TMemo
        Left = 77
        Top = 198
        Width = 187
        Height = 44
        Lines.Strings = (
          '')
        TabOrder = 7
      end
      object ButtonRouteByAddress: TButton
        Left = 159
        Top = 248
        Width = 107
        Height = 25
        Caption = 'Route by Addresses'
        TabOrder = 8
        OnClick = ButtonRouteByAddressClick
      end
    end
  end
  object EdgeGoogleMapViewer: TEdgeGoogleMapViewer
    Left = 273
    Top = 0
    Width = 1080
    Height = 791
    Align = alClient
    TabOrder = 1
    MapAddress = 'Via Santa Cecilia 4, Carugate, Milano'
    MapLatitude = 25.767314000000000000
    MapLongitude = -80.135694000000000000
    BeforeShowMap = EdgeGoogleMapViewerBeforeShowMap
  end
end
