object formMain: TformMain
  Left = 427
  Top = 268
  Caption = 
    'Delphi with Edge Google Maps Viewer Component Demo - CopyRight (' +
    'c) Ethea S.r.l.'
  ClientHeight = 611
  ClientWidth = 968
  Color = clBtnFace
  Constraints.MinHeight = 550
  Constraints.MinWidth = 890
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 461
    Width = 968
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 151
    ExplicitWidth = 231
  end
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 968
    Height = 151
    Align = alTop
    TabOrder = 0
    object gbMapAttributes: TGroupBox
      Left = 737
      Top = 1
      Width = 136
      Height = 149
      Align = alLeft
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
        Left = 5
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
      Width = 280
      Height = 149
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
        Left = 177
        Top = 79
        Width = 99
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
        Left = 177
        Top = 29
        Width = 99
        Height = 44
        Caption = 'Go to Address'
        TabOrder = 1
        OnClick = ButtonGotoAddressClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 281
      Top = 1
      Width = 456
      Height = 149
      Align = alLeft
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
        Left = 240
        Top = 17
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
        Left = 157
        Top = 117
        Width = 107
        Height = 25
        Caption = 'Route by locations'
        TabOrder = 5
        OnClick = ButtonRouteLatLngClick
      end
      object StartAddressMemo: TMemo
        Left = 285
        Top = 14
        Width = 163
        Height = 44
        Lines.Strings = (
          '')
        TabOrder = 6
      end
      object DestinationAddressMemo: TMemo
        Left = 285
        Top = 64
        Width = 163
        Height = 44
        Lines.Strings = (
          '')
        TabOrder = 7
      end
      object ButtonRouteByAddress: TButton
        Left = 332
        Top = 117
        Width = 116
        Height = 25
        Caption = 'Route by Addresses'
        TabOrder = 8
        OnClick = ButtonRouteByAddressClick
      end
    end
  end
  object EdgeGoogleMapViewer: TEdgeGoogleMapViewer
    Left = 0
    Top = 151
    Width = 968
    Height = 310
    Align = alClient
    TabOrder = 1
    MapAddress = 'Via Santa Cecilia 4, Carugate, Milano'
    MapLatitude = 25.767314000000000000
    MapLongitude = -80.135694000000000000
    BeforeShowMap = EdgeGoogleMapViewerBeforeShowMap
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 464
    Width = 968
    Height = 100
    Align = alBottom
    DataSource = dsCustomers
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CustNo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Company'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Addr1'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Addr2'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'City'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'State'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Zip'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Country'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Phone'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FAX'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TaxRate'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Contact'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastInvoiceDate'
        Visible = True
      end>
  end
  object paBottom: TPanel
    Left = 0
    Top = 564
    Width = 968
    Height = 47
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      968
      47)
    object ShowMapButton: TButton
      Left = 11
      Top = 6
      Width = 99
      Height = 35
      Caption = 'Show Map'
      TabOrder = 0
      OnClick = ShowMapButtonClick
    end
    object HideMapButton: TButton
      Left = 116
      Top = 6
      Width = 99
      Height = 35
      Caption = 'Hide map'
      TabOrder = 1
      OnClick = HideMapButtonClick
    end
    object ButtonClearMarkers: TButton
      Left = 719
      Top = 6
      Width = 101
      Height = 35
      Anchors = [akTop, akRight]
      Caption = 'Clear Markers'
      TabOrder = 4
      OnClick = ButtonClearMarkersClick
    end
    object DBNavigator: TDBNavigator
      Left = 826
      Top = 6
      Width = 128
      Height = 35
      DataSource = dsCustomers
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Anchors = [akTop, akRight]
      TabOrder = 5
    end
    object FileEdit: TLabeledEdit
      Left = 221
      Top = 19
      Width = 405
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 120
      EditLabel.Height = 13
      EditLabel.Caption = 'Customers ClientDataSet'
      TabOrder = 2
      Text = 'customer.xml'
    end
    object LoadTableButton: TButton
      Left = 632
      Top = 6
      Width = 81
      Height = 35
      Anchors = [akTop, akRight]
      Caption = 'Load Table'
      TabOrder = 3
      OnClick = LoadTableButtonClick
    end
  end
  object PopupMenu: TPopupMenu
    Left = 416
    Top = 264
  end
  object cdsCustomers: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsCustomersAfterScroll
    Left = 664
    Top = 264
    object cdsCustomersCustNo: TFloatField
      FieldName = 'CustNo'
    end
    object cdsCustomersCompany: TStringField
      FieldName = 'Company'
      Size = 30
    end
    object cdsCustomersAddr1: TStringField
      FieldName = 'Addr1'
      Size = 30
    end
    object cdsCustomersAddr2: TStringField
      FieldName = 'Addr2'
      Size = 30
    end
    object cdsCustomersCity: TStringField
      FieldName = 'City'
      Size = 15
    end
    object cdsCustomersState: TStringField
      FieldName = 'State'
    end
    object cdsCustomersZip: TStringField
      FieldName = 'Zip'
      Size = 10
    end
    object cdsCustomersCountry: TStringField
      FieldName = 'Country'
    end
    object cdsCustomersPhone: TStringField
      FieldName = 'Phone'
      Size = 15
    end
    object cdsCustomersFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object cdsCustomersTaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object cdsCustomersContact: TStringField
      FieldName = 'Contact'
    end
    object cdsCustomersLastInvoiceDate: TDateTimeField
      FieldName = 'LastInvoiceDate'
    end
  end
  object dsCustomers: TDataSource
    DataSet = cdsCustomers
    Left = 824
    Top = 272
  end
end
