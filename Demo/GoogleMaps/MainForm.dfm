object formMain: TformMain
  Left = 427
  Top = 268
  Caption = 
    'Delphi with Edge Google Maps Viewer Component Demo - Copyright (' +
    'c) Ethea S.r.l.'
  ClientHeight = 729
  ClientWidth = 1479
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
  object Splitter1: TSplitter
    Left = 0
    Top = 579
    Width = 1479
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 151
    ExplicitWidth = 231
  end
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 1479
    Height = 185
    Align = alTop
    TabOrder = 0
    object gbMapAttributes: TGroupBox
      Left = 737
      Top = 1
      Width = 136
      Height = 183
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
      object Zoom: TSpinEdit
        Left = 37
        Top = 122
        Width = 57
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 15
        OnChange = ZoomChange
      end
      object CheckBoxStreeView: TCheckBox
        Left = 13
        Top = 103
        Width = 70
        Height = 17
        Caption = 'Street View'
        TabOrder = 1
        OnClick = CheckBoxStreeViewClick
      end
      object CheckBoxBicycling: TCheckBox
        Left = 13
        Top = 83
        Width = 70
        Height = 17
        Caption = 'Bicycling'
        TabOrder = 2
        OnClick = CheckBoxBicyclingClick
      end
      object CheckBoxTraffic: TCheckBox
        Left = 13
        Top = 64
        Width = 61
        Height = 17
        Caption = 'Traffic'
        TabOrder = 3
        OnClick = CheckBoxTrafficClick
      end
      object MapTypeIdComboBox: TComboBox
        Left = 5
        Top = 32
        Width = 126
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 4
        Text = 'ROADMAP'
        OnChange = MapTypeIdComboBoxChange
        Items.Strings = (
          'ROADMAP'
          'SATELLITE'
          #39'HYBRID'
          'TERRAIN')
      end
      object cbCenterOnClick: TCheckBox
        Left = 13
        Top = 150
        Width = 100
        Height = 17
        Caption = 'Center on click'
        TabOrder = 5
        OnClick = CheckBoxStreeViewClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 280
      Height = 183
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
        TabOrder = 2
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
        TabOrder = 4
      end
    end
    object GroupBox2: TGroupBox
      Left = 281
      Top = 1
      Width = 456
      Height = 183
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
        Left = 156
        Top = 119
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
        Left = 334
        Top = 119
        Width = 116
        Height = 25
        Caption = 'Route by Addresses'
        TabOrder = 8
        OnClick = ButtonRouteByAddressClick
      end
      object CheckBoxDirectionPanel: TCheckBox
        Left = 13
        Top = 123
        Width = 103
        Height = 17
        Caption = 'Direction panel'
        TabOrder = 9
        OnClick = CheckBoxDirectionPanelClick
      end
    end
    object GroupBoxMarker: TGroupBox
      Left = 873
      Top = 1
      Width = 605
      Height = 183
      Align = alClient
      Caption = 'Markers'
      TabOrder = 3
      object PageControlMarker: TPageControl
        Left = 2
        Top = 15
        Width = 601
        Height = 128
        ActivePage = LatLongMarkerTabSheet
        Align = alClient
        TabOrder = 0
        object LatLongMarkerTabSheet: TTabSheet
          Caption = 'Latitute/Longitude'
          object GridPanel1: TGridPanel
            Left = 0
            Top = 0
            Width = 593
            Height = 100
            Align = alClient
            BevelOuter = bvNone
            ColumnCollection = <
              item
                Value = 100.000000000000000000
              end>
            ControlCollection = <
              item
                Column = 0
                Control = GridPanel2
                Row = 0
              end
              item
                Column = 0
                Control = Panel5
                Row = 1
              end>
            RowCollection = <
              item
                Value = 50.000000000000000000
              end
              item
                Value = 50.000000000000000000
              end>
            TabOrder = 0
            object GridPanel2: TGridPanel
              Left = 0
              Top = 0
              Width = 593
              Height = 50
              Align = alClient
              BevelOuter = bvNone
              ColumnCollection = <
                item
                  Value = 50.000000000000000000
                end
                item
                  Value = 50.000000000000000000
                end>
              ControlCollection = <
                item
                  Column = 0
                  Control = Panel2
                  Row = 0
                end
                item
                  Column = 1
                  Control = Panel3
                  Row = 0
                end>
              RowCollection = <
                item
                  Value = 100.000000000000000000
                end>
              TabOrder = 0
              object Panel2: TPanel
                Left = 0
                Top = 0
                Width = 296
                Height = 50
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object Label9: TLabel
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 290
                  Height = 13
                  Align = alTop
                  Caption = 'Latitude'
                  ExplicitWidth = 39
                end
                object editMarkerLat: TEdit
                  AlignWithMargins = True
                  Left = 3
                  Top = 22
                  Width = 290
                  Height = 21
                  Align = alTop
                  TabOrder = 0
                end
              end
              object Panel3: TPanel
                Left = 296
                Top = 0
                Width = 297
                Height = 50
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object Label10: TLabel
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 291
                  Height = 13
                  Align = alTop
                  Caption = 'Longitude'
                  ExplicitWidth = 47
                end
                object editMarkerLng: TEdit
                  AlignWithMargins = True
                  Left = 3
                  Top = 22
                  Width = 291
                  Height = 21
                  Align = alTop
                  TabOrder = 0
                end
              end
            end
            object Panel5: TPanel
              Left = 0
              Top = 50
              Width = 593
              Height = 50
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object Label11: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 587
                Height = 13
                Align = alTop
                Caption = 'Description'
                ExplicitWidth = 53
              end
              object editMarkerDescription: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 22
                Width = 587
                Height = 21
                Align = alTop
                TabOrder = 0
              end
            end
          end
        end
        object TabSheetLabelAnimation: TTabSheet
          Caption = 'Label/Animation'
          ImageIndex = 1
          object Panel6: TPanel
            Left = 0
            Top = 0
            Width = 593
            Height = 54
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label12: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 587
              Height = 13
              Align = alTop
              Caption = 'Label'
              ExplicitWidth = 25
            end
            object editMarkerLabel: TEdit
              AlignWithMargins = True
              Left = 3
              Top = 22
              Width = 587
              Height = 21
              Align = alTop
              TabOrder = 0
            end
          end
          object Panel7: TPanel
            Left = 0
            Top = 54
            Width = 593
            Height = 54
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Label13: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 587
              Height = 13
              Align = alTop
              Caption = 'Animation'
              ExplicitWidth = 47
            end
            object comboMarkerAnimation: TComboBox
              AlignWithMargins = True
              Left = 3
              Top = 22
              Width = 587
              Height = 22
              Align = alTop
              Style = csOwnerDrawFixed
              ItemIndex = 0
              TabOrder = 0
              Text = 'NONE'
              Items.Strings = (
                'NONE'
                'BOUNCE'
                'DROP'
                '')
            end
          end
        end
        object TabSheetInformation: TTabSheet
          Caption = 'Information'
          ImageIndex = 2
          object Label14: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 587
            Height = 13
            Align = alTop
            Caption = 'Information'
            ExplicitWidth = 56
          end
          object memoMarkerInformation: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 22
            Width = 587
            Height = 75
            Align = alClient
            Lines.Strings = (
              '<div id="content">'
              '<h1>Perth</h1>'
              
                '<p>Perth, capital of Western Australia, sits where the Swan Rive' +
                'r meets the southwest coast. Sandy beaches line its suburbs, and' +
                ' the huge, riverside Kings Park and Botanic Garden on Mount Eliz' +
                'a offer sweeping views of the city. The Perth Cultural Centre ho' +
                'uses the state ballet and opera companies, and occupies its own ' +
                'central precinct, including a theatre, library and the Art Galle' +
                'ry of Western Australia.</p>'
              
                '<a href="https://en.wikipedia.org/wiki/Perth" target="_blank">Pe' +
                'rth</a>'
              '</div>')
            TabOrder = 0
            WordWrap = False
          end
        end
        object TabSheetCustom: TTabSheet
          Caption = 'Custom Marker'
          ImageIndex = 3
          object cbMarkerCustom: TCheckBox
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 587
            Height = 17
            Align = alTop
            Caption = 'Custom'
            TabOrder = 0
          end
          object memoMarkerCustomJSON: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 26
            Width = 587
            Height = 71
            Align = alClient
            Lines.Strings = (
              '')
            TabOrder = 1
          end
        end
      end
      object btnAddMarker: TButton
        AlignWithMargins = True
        Left = 5
        Top = 146
        Width = 595
        Height = 32
        Align = alBottom
        Caption = 'Add Marker'
        TabOrder = 1
        OnClick = btnAddMarkerClick
      end
    end
  end
  object EdgeGoogleMapViewer: TEdgeGoogleMapViewer
    Left = 0
    Top = 185
    Width = 1479
    Height = 394
    Align = alClient
    TabOrder = 1
    MapAddress = 'Via Santa Cecilia 4, Carugate, Milano'
    MapLatitude = 25.767314000000000000
    MapLongitude = -80.135694000000000000
    BeforeShowMap = EdgeGoogleMapViewerBeforeShowMap
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 582
    Width = 1479
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
    Top = 682
    Width = 1479
    Height = 47
    Align = alBottom
    TabOrder = 3
    object ShowMapButton: TButton
      AlignWithMargins = True
      Left = 109
      Top = 4
      Width = 99
      Height = 39
      Align = alLeft
      Caption = 'Show Map'
      TabOrder = 0
      OnClick = ShowMapButtonClick
    end
    object HideMapButton: TButton
      AlignWithMargins = True
      Left = 214
      Top = 4
      Width = 99
      Height = 39
      Align = alLeft
      Caption = 'Hide map'
      TabOrder = 1
      OnClick = HideMapButtonClick
    end
    object ButtonClearMarkers: TButton
      AlignWithMargins = True
      Left = 1240
      Top = 4
      Width = 101
      Height = 39
      Align = alRight
      Caption = 'Clear Markers'
      TabOrder = 3
      OnClick = ButtonClearMarkersClick
    end
    object DBNavigator: TDBNavigator
      AlignWithMargins = True
      Left = 1347
      Top = 4
      Width = 128
      Height = 39
      DataSource = dsCustomers
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Align = alRight
      TabOrder = 4
    end
    object LoadTableButton: TButton
      AlignWithMargins = True
      Left = 1135
      Top = 4
      Width = 99
      Height = 39
      Align = alRight
      Caption = 'Load Table'
      TabOrder = 2
      OnClick = LoadTableButtonClick
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 99
      Height = 39
      Align = alLeft
      Caption = 'Show another form...'
      TabOrder = 5
      WordWrap = True
      OnClick = Button1Click
    end
    object Panel1: TPanel
      Left = 316
      Top = 1
      Width = 816
      Height = 45
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 6
      object Label7: TLabel
        Left = 0
        Top = 0
        Width = 816
        Height = 13
        Align = alTop
        Caption = 'File'
        ExplicitWidth = 16
      end
      object FileEdit: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 16
        Width = 810
        Height = 21
        Align = alTop
        TabOrder = 0
        Text = 'customer.xml'
      end
    end
  end
  object PopupMenu: TPopupMenu
    Left = 416
    Top = 264
    object mnuAddMarker: TMenuItem
      Caption = 'Add Marker'
      OnClick = mnuAddMarkerClick
    end
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
