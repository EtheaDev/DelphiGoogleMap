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
  object Splitter1: TSplitter
    Left = 0
    Top = 579
    Width = 1445
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitWidth = 1190
  end
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 1445
    Height = 209
    Align = alTop
    TabOrder = 0
    object gbMapAttributes: TGroupBox
      Left = 1
      Top = 1
      Width = 198
      Height = 207
      Align = alLeft
      Caption = 'Map Attributes'
      TabOrder = 0
      ExplicitHeight = 183
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
        TabOrder = 0
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
        TabOrder = 1
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
      Width = 280
      Height = 207
      Align = alLeft
      Caption = 'Location'
      TabOrder = 1
      ExplicitHeight = 183
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
      Left = 479
      Top = 1
      Width = 456
      Height = 207
      Align = alLeft
      Caption = 'Routing'
      TabOrder = 2
      ExplicitLeft = 482
      ExplicitTop = -4
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
    object GroupBoxDrawing: TGroupBox
      Left = 935
      Top = 1
      Width = 509
      Height = 207
      Align = alClient
      Caption = 'Drawing'
      TabOrder = 3
      ExplicitLeft = 224
      ExplicitTop = 8
      ExplicitWidth = 185
      ExplicitHeight = 105
      object PCDrawing: TPageControl
        Left = 2
        Top = 15
        Width = 505
        Height = 190
        ActivePage = TabMarkers
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 935
        ExplicitTop = 1
        ExplicitWidth = 509
        ExplicitHeight = 207
        object TabMarkers: TTabSheet
          Caption = 'Markers'
          object btnAddMarker: TButton
            AlignWithMargins = True
            Left = 3
            Top = 127
            Width = 491
            Height = 32
            Align = alBottom
            Caption = 'Add Marker'
            TabOrder = 0
            OnClick = btnAddMarkerClick
            ExplicitLeft = 5
            ExplicitTop = 125
            ExplicitWidth = 487
          end
          object PageControlMarker: TPageControl
            Left = 0
            Top = 0
            Width = 497
            Height = 124
            ActivePage = LatLongMarkerTabSheet
            Align = alClient
            TabOrder = 1
            ExplicitLeft = 2
            ExplicitTop = 15
            ExplicitWidth = 493
            ExplicitHeight = 107
            object LatLongMarkerTabSheet: TTabSheet
              Caption = 'Latitute/Longitude'
              object GridPanel1: TGridPanel
                Left = 0
                Top = 0
                Width = 489
                Height = 96
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
                ExplicitWidth = 485
                ExplicitHeight = 79
                object GridPanel2: TGridPanel
                  Left = 0
                  Top = 0
                  Width = 489
                  Height = 48
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
                  ExplicitWidth = 485
                  ExplicitHeight = 40
                  object Panel2: TPanel
                    Left = 0
                    Top = 0
                    Width = 244
                    Height = 48
                    Align = alClient
                    BevelOuter = bvNone
                    TabOrder = 0
                    ExplicitWidth = 242
                    ExplicitHeight = 40
                    object Label9: TLabel
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 238
                      Height = 13
                      Align = alTop
                      Caption = 'Latitude'
                      ExplicitWidth = 39
                    end
                    object editMarkerLat: TEdit
                      AlignWithMargins = True
                      Left = 3
                      Top = 22
                      Width = 238
                      Height = 21
                      Align = alTop
                      TabOrder = 0
                      ExplicitWidth = 236
                    end
                  end
                  object Panel3: TPanel
                    Left = 244
                    Top = 0
                    Width = 245
                    Height = 48
                    Align = alClient
                    BevelOuter = bvNone
                    TabOrder = 1
                    ExplicitLeft = 242
                    ExplicitWidth = 243
                    ExplicitHeight = 40
                    object Label10: TLabel
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 239
                      Height = 13
                      Align = alTop
                      Caption = 'Longitude'
                      ExplicitWidth = 47
                    end
                    object editMarkerLng: TEdit
                      AlignWithMargins = True
                      Left = 3
                      Top = 22
                      Width = 239
                      Height = 21
                      Align = alTop
                      TabOrder = 0
                      ExplicitWidth = 237
                    end
                  end
                end
                object Panel5: TPanel
                  Left = 0
                  Top = 48
                  Width = 489
                  Height = 48
                  Align = alClient
                  BevelOuter = bvNone
                  TabOrder = 1
                  ExplicitTop = 40
                  ExplicitWidth = 485
                  ExplicitHeight = 39
                  object Label11: TLabel
                    AlignWithMargins = True
                    Left = 3
                    Top = 3
                    Width = 483
                    Height = 13
                    Align = alTop
                    Caption = 'Description'
                    ExplicitWidth = 53
                  end
                  object editMarkerDescription: TEdit
                    AlignWithMargins = True
                    Left = 3
                    Top = 22
                    Width = 483
                    Height = 21
                    Align = alTop
                    TabOrder = 0
                    ExplicitWidth = 479
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
                Width = 489
                Height = 54
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object Label12: TLabel
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 483
                  Height = 13
                  Align = alTop
                  Caption = 'Label'
                  ExplicitWidth = 25
                end
                object editMarkerLabel: TEdit
                  AlignWithMargins = True
                  Left = 3
                  Top = 22
                  Width = 483
                  Height = 21
                  Align = alTop
                  TabOrder = 0
                end
              end
              object Panel7: TPanel
                Left = 0
                Top = 54
                Width = 489
                Height = 54
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                object Label13: TLabel
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 483
                  Height = 13
                  Align = alTop
                  Caption = 'Animation'
                  ExplicitWidth = 47
                end
                object comboMarkerAnimation: TComboBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 22
                  Width = 483
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
                Width = 483
                Height = 13
                Align = alTop
                Caption = 'Information'
                ExplicitWidth = 56
              end
              object memoMarkerInformation: TMemo
                AlignWithMargins = True
                Left = 3
                Top = 22
                Width = 483
                Height = 71
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
                Width = 483
                Height = 17
                Align = alTop
                Caption = 'Custom'
                TabOrder = 0
              end
              object memoMarkerCustomJSON: TMemo
                AlignWithMargins = True
                Left = 3
                Top = 26
                Width = 483
                Height = 67
                Align = alClient
                Lines.Strings = (
                  '')
                TabOrder = 1
              end
            end
          end
        end
        object TabCircles: TTabSheet
          Caption = 'Circles'
          ImageIndex = 1
          object btnAddCircle: TButton
            AlignWithMargins = True
            Left = 3
            Top = 127
            Width = 491
            Height = 32
            Align = alBottom
            Caption = 'Add Cicle'
            TabOrder = 0
            OnClick = btnAddCircleClick
            ExplicitLeft = 5
            ExplicitTop = 125
            ExplicitWidth = 487
          end
          object PageControlCircle: TPageControl
            Left = 0
            Top = 0
            Width = 497
            Height = 124
            ActivePage = TabSheet1
            Align = alClient
            TabOrder = 1
            ExplicitLeft = 2
            ExplicitTop = 15
            ExplicitWidth = 493
            ExplicitHeight = 107
            object TabSheet1: TTabSheet
              Caption = 'Latitute/Longitude'
              object GridPanel3: TGridPanel
                Left = 0
                Top = 0
                Width = 489
                Height = 96
                Align = alClient
                BevelOuter = bvNone
                ColumnCollection = <
                  item
                    Value = 100.000000000000000000
                  end
                  item
                  end>
                ControlCollection = <
                  item
                    Column = 0
                    Control = GridPanel4
                    Row = 0
                  end
                  item
                    Column = 0
                    Control = Panel9
                    Row = 1
                  end>
                RowCollection = <
                  item
                    Value = 50.000000000000000000
                  end
                  item
                    Value = 50.000000000000000000
                  end
                  item
                    SizeStyle = ssAuto
                  end>
                TabOrder = 0
                object GridPanel4: TGridPanel
                  Left = 0
                  Top = 0
                  Width = 489
                  Height = 48
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
                      Control = Panel4
                      Row = 0
                    end
                    item
                      Column = 1
                      Control = Panel8
                      Row = 0
                    end>
                  RowCollection = <
                    item
                      Value = 100.000000000000000000
                    end
                    item
                      SizeStyle = ssAuto
                    end
                    item
                      SizeStyle = ssAuto
                    end>
                  TabOrder = 0
                  object Panel4: TPanel
                    Left = 0
                    Top = 0
                    Width = 244
                    Height = 48
                    Align = alClient
                    BevelOuter = bvNone
                    TabOrder = 0
                    object Label15: TLabel
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 238
                      Height = 13
                      Align = alTop
                      Caption = 'Latitude'
                      ExplicitWidth = 39
                    end
                    object eCircleLat: TEdit
                      AlignWithMargins = True
                      Left = 3
                      Top = 22
                      Width = 238
                      Height = 21
                      Align = alTop
                      TabOrder = 0
                    end
                  end
                  object Panel8: TPanel
                    Left = 244
                    Top = 0
                    Width = 245
                    Height = 48
                    Align = alClient
                    BevelOuter = bvNone
                    TabOrder = 1
                    object Label16: TLabel
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 239
                      Height = 13
                      Align = alTop
                      Caption = 'Longitude'
                      ExplicitWidth = 47
                    end
                    object eCircleLng: TEdit
                      AlignWithMargins = True
                      Left = 3
                      Top = 22
                      Width = 239
                      Height = 21
                      Align = alTop
                      TabOrder = 0
                    end
                  end
                end
                object Panel9: TPanel
                  Left = 0
                  Top = 48
                  Width = 116
                  Height = 48
                  Align = alLeft
                  BevelOuter = bvNone
                  TabOrder = 1
                  object Label21: TLabel
                    AlignWithMargins = True
                    Left = 3
                    Top = 3
                    Width = 110
                    Height = 13
                    Align = alTop
                    Caption = 'Radius'
                    ExplicitWidth = 32
                  end
                  object eCircleRadius: TEdit
                    AlignWithMargins = True
                    Left = 3
                    Top = 22
                    Width = 110
                    Height = 21
                    Align = alTop
                    TabOrder = 0
                  end
                end
              end
            end
            object TabSheet2: TTabSheet
              Caption = 'Behavior'
              ImageIndex = 1
              object Panel10: TPanel
                Left = 0
                Top = 0
                Width = 489
                Height = 97
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object chkCircleEditable: TCheckBox
                  Left = 0
                  Top = 16
                  Width = 103
                  Height = 17
                  Caption = 'Editable'
                  TabOrder = 0
                end
                object chkCircleDraggable: TCheckBox
                  Left = 0
                  Top = 39
                  Width = 103
                  Height = 17
                  Caption = 'Draggable'
                  TabOrder = 1
                end
                object chkCicleClickable: TCheckBox
                  Left = 136
                  Top = 39
                  Width = 103
                  Height = 17
                  Caption = 'Clickable'
                  Checked = True
                  State = cbChecked
                  TabOrder = 2
                end
                object chkCircleVisible: TCheckBox
                  Left = 136
                  Top = 16
                  Width = 103
                  Height = 17
                  Caption = 'Visible'
                  Checked = True
                  State = cbChecked
                  TabOrder = 3
                end
              end
            end
            object TabSheet4: TTabSheet
              Caption = 'Style'
              ImageIndex = 3
              object Label17: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 56
                Height = 13
                Caption = 'StrokeColor'
              end
              object Label18: TLabel
                AlignWithMargins = True
                Left = 76
                Top = 3
                Width = 68
                Height = 13
                Caption = 'StrokeOpacity'
              end
              object Label19: TLabel
                AlignWithMargins = True
                Left = 149
                Top = 3
                Width = 65
                Height = 13
                Caption = 'StrokeWeight'
              end
              object Label22: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 53
                Width = 37
                Height = 13
                Caption = 'FillColor'
              end
              object Label23: TLabel
                AlignWithMargins = True
                Left = 76
                Top = 54
                Width = 49
                Height = 13
                Caption = 'FillOpacity'
              end
              object eCircleStrokeColor: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 22
                Width = 67
                Height = 21
                TabOrder = 0
                Text = '#FF0000'
              end
              object eCircleStrokeOpacity: TEdit
                AlignWithMargins = True
                Left = 76
                Top = 22
                Width = 67
                Height = 21
                TabOrder = 1
                Text = '0.8'
              end
              object eCircleStrokeWeight: TEdit
                AlignWithMargins = True
                Left = 149
                Top = 22
                Width = 67
                Height = 21
                TabOrder = 2
                Text = '2'
              end
              object eCircleFillColor: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 72
                Width = 67
                Height = 21
                TabOrder = 3
                Text = '#FF0000'
              end
              object eCircleFillOpacity: TEdit
                AlignWithMargins = True
                Left = 76
                Top = 72
                Width = 67
                Height = 21
                TabOrder = 4
                Text = '0.35'
              end
            end
            object TabSheet3: TTabSheet
              Caption = 'Information'
              ImageIndex = 2
              object Label20: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 483
                Height = 13
                Align = alTop
                Caption = 'Information'
                ExplicitWidth = 56
              end
              object eCircleInfo: TMemo
                AlignWithMargins = True
                Left = 3
                Top = 22
                Width = 483
                Height = 71
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
                ExplicitWidth = 479
                ExplicitHeight = 54
              end
            end
          end
        end
        object TabPolylines: TTabSheet
          Caption = 'Polylines'
          ImageIndex = 2
          object btnAddPolyline: TButton
            AlignWithMargins = True
            Left = 3
            Top = 127
            Width = 491
            Height = 32
            Align = alBottom
            Caption = 'Add Polyline'
            TabOrder = 0
            OnClick = btnAddPolylineClick
            ExplicitLeft = 5
            ExplicitTop = 125
            ExplicitWidth = 487
          end
          object PageControlPolyline: TPageControl
            Left = 0
            Top = 0
            Width = 497
            Height = 124
            ActivePage = TabSheet5
            Align = alClient
            TabOrder = 1
            ExplicitLeft = 2
            ExplicitTop = 15
            ExplicitWidth = 493
            ExplicitHeight = 107
            object TabSheet5: TTabSheet
              Caption = 'Path'
              object ePolylinesPath: TMemo
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 483
                Height = 90
                Align = alClient
                Lines.Strings = (
                  '['
                  '  { lat: 40.7128, lng: -74.0060 }, // Nueva York, NY'
                  '  { lat: 34.0522, lng: -118.2437 }, // Los '#193'ngeles, CA'
                  '  { lat: 41.8781, lng: -87.6298 }   // Chicago, IL'
                  ']')
                TabOrder = 0
                WordWrap = False
              end
            end
            object TabSheet6: TTabSheet
              Caption = 'Behavior'
              ImageIndex = 1
              object Panel14: TPanel
                Left = 0
                Top = 0
                Width = 489
                Height = 97
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                ExplicitWidth = 485
                object chkPolylineEditable: TCheckBox
                  Left = 0
                  Top = 16
                  Width = 103
                  Height = 17
                  Caption = 'Editable'
                  TabOrder = 0
                end
                object chkPolylineGeodesic: TCheckBox
                  Left = 0
                  Top = 39
                  Width = 103
                  Height = 17
                  Caption = 'Geodesic'
                  TabOrder = 1
                end
                object chkPolylineClickable: TCheckBox
                  Left = 136
                  Top = 39
                  Width = 103
                  Height = 17
                  Caption = 'Clickable'
                  Checked = True
                  State = cbChecked
                  TabOrder = 2
                end
                object chkPolylineVisible: TCheckBox
                  Left = 136
                  Top = 16
                  Width = 103
                  Height = 17
                  Caption = 'Visible'
                  Checked = True
                  State = cbChecked
                  TabOrder = 3
                end
                object chkPolylineFitBounds: TCheckBox
                  Left = 0
                  Top = 62
                  Width = 103
                  Height = 17
                  Caption = 'FitBounds'
                  Checked = True
                  State = cbChecked
                  TabOrder = 4
                end
              end
            end
            object TabSheet7: TTabSheet
              Caption = 'Style'
              ImageIndex = 3
              object Label27: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 56
                Height = 13
                Caption = 'StrokeColor'
              end
              object Label28: TLabel
                AlignWithMargins = True
                Left = 76
                Top = 3
                Width = 68
                Height = 13
                Caption = 'StrokeOpacity'
              end
              object Label29: TLabel
                AlignWithMargins = True
                Left = 149
                Top = 3
                Width = 65
                Height = 13
                Caption = 'StrokeWeight'
              end
              object ePolylineStrokeColor: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 22
                Width = 67
                Height = 21
                TabOrder = 0
                Text = '#FF0000'
              end
              object ePolylineStrokeOpacity: TEdit
                AlignWithMargins = True
                Left = 76
                Top = 22
                Width = 67
                Height = 21
                TabOrder = 1
                Text = '0.8'
              end
              object ePolylineStrokeWeight: TEdit
                AlignWithMargins = True
                Left = 149
                Top = 22
                Width = 67
                Height = 21
                TabOrder = 2
                Text = '2'
              end
            end
            object TabSheet8: TTabSheet
              Caption = 'Information'
              ImageIndex = 2
              object Label32: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 483
                Height = 13
                Align = alTop
                Caption = 'Information'
                ExplicitWidth = 56
              end
              object ePolylineInfo: TMemo
                AlignWithMargins = True
                Left = 3
                Top = 22
                Width = 483
                Height = 71
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
          end
        end
      end
    end
  end
  object EdgeGoogleMapViewer: TEdgeGoogleMapViewer
    Left = 0
    Top = 209
    Width = 1445
    Height = 370
    Align = alClient
    TabOrder = 1
    OnContainsFullScreenElementChanged = EdgeGoogleMapViewerContainsFullScreenElementChanged
    MapAddress = 'Via Santa Cecilia 4, Carugate, Milano'
    MapLatitude = 25.767314000000000000
    MapLongitude = -80.135694000000000000
    BeforeShowMap = EdgeGoogleMapViewerBeforeShowMap
    ExplicitLeft = 1
    ExplicitTop = 210
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 582
    Width = 1445
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
  object BottomPanel: TPanel
    Left = 0
    Top = 682
    Width = 1445
    Height = 47
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 681
    ExplicitWidth = 1441
    object ShowPrintUIButton: TButton
      AlignWithMargins = True
      Left = 90
      Top = 4
      Width = 80
      Height = 39
      Align = alLeft
      Caption = 'Show Print UI'
      TabOrder = 7
      OnClick = ShowPrintUIButtonClick
    end
    object ShowMapButton: TButton
      AlignWithMargins = True
      Left = 176
      Top = 4
      Width = 80
      Height = 39
      Align = alLeft
      Caption = 'Show Map'
      TabOrder = 0
      OnClick = ShowMapButtonClick
    end
    object HideMapButton: TButton
      AlignWithMargins = True
      Left = 262
      Top = 4
      Width = 80
      Height = 39
      Align = alLeft
      Caption = 'Hide map'
      TabOrder = 1
      OnClick = HideMapButtonClick
    end
    object ButtonClearMarkers: TButton
      AlignWithMargins = True
      Left = 992
      Top = 4
      Width = 101
      Height = 39
      Align = alRight
      Caption = 'Clear Markers'
      TabOrder = 3
      OnClick = ButtonClearMarkersClick
      ExplicitLeft = 1095
    end
    object DBNavigator: TDBNavigator
      AlignWithMargins = True
      Left = 1313
      Top = 4
      Width = 128
      Height = 39
      DataSource = dsCustomers
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Align = alRight
      TabOrder = 4
      ExplicitLeft = 1309
    end
    object LoadTableButton: TButton
      AlignWithMargins = True
      Left = 887
      Top = 4
      Width = 99
      Height = 39
      Align = alRight
      Caption = 'Load Table'
      TabOrder = 2
      OnClick = LoadTableButtonClick
      ExplicitLeft = 990
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 80
      Height = 39
      Align = alLeft
      Caption = 'Show another form...'
      TabOrder = 5
      WordWrap = True
      OnClick = Button1Click
    end
    object Panel1: TPanel
      Left = 345
      Top = 1
      Width = 539
      Height = 45
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 6
      ExplicitWidth = 642
      object Label7: TLabel
        Left = 0
        Top = 0
        Width = 539
        Height = 13
        Align = alTop
        Caption = 'File'
        ExplicitWidth = 16
      end
      object FileEdit: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 16
        Width = 533
        Height = 21
        Align = alTop
        TabOrder = 0
        Text = 'customer.xml'
        ExplicitWidth = 636
      end
    end
    object btnClearCircles: TButton
      AlignWithMargins = True
      Left = 1099
      Top = 4
      Width = 101
      Height = 39
      Align = alRight
      Caption = 'Clear Circles'
      TabOrder = 8
      OnClick = btnClearCirclesClick
      ExplicitLeft = 1202
    end
    object btnClearPolylines: TButton
      AlignWithMargins = True
      Left = 1206
      Top = 4
      Width = 101
      Height = 39
      Align = alRight
      Caption = 'Clear Polylines'
      TabOrder = 9
      OnClick = btnClearPolylinesClick
      ExplicitLeft = 1216
      ExplicitTop = 6
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
