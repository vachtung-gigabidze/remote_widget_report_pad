// data/rfw_widgets.dart
import '../models/template_model.dart';

class RFWWidgets {
  static const List<String> layoutWidgets = [
    'Container',
    'Column',
    'Row',
    'Stack',
    'Expanded',
    'Flexible',
    'SizedBox',
    'Padding',
    'Align',
    'Center',
    'AspectRatio',
    'FractionallySizedBox',
    'IntrinsicWidth',
    'IntrinsicHeight',
    'FittedBox',
    'Spacer',
    'SafeArea',
    'SingleChildScrollView',
  ];

  static const List<String> contentWidgets = ['Text', 'Icon', 'Image', 'Placeholder', 'ListView', 'GridView', 'Wrap'];

  static const List<String> stylingWidgets = ['Opacity', 'ClipRRect', 'ColoredBox', 'DefaultTextStyle', 'IconTheme', 'Directionality', 'Rotation', 'Scale'];

  static const List<String> interactiveWidgets = ['GestureDetector', 'ListBody'];

  static const Map<String, Map<String, dynamic>> widgetProperties = {
    'Container': {
      'padding': 'EdgeInsetsGeometry',
      'margin': 'EdgeInsetsGeometry',
      'color': 'Color',
      'decoration': 'Decoration',
      'width': 'double',
      'height': 'double',
      'alignment': 'AlignmentGeometry',
      'child': 'Widget',
    },
    'Column': {'children': 'List<Widget>', 'mainAxisAlignment': 'MainAxisAlignment', 'crossAxisAlignment': 'CrossAxisAlignment', 'mainAxisSize': 'MainAxisSize'},
    'Row': {'children': 'List<Widget>', 'mainAxisAlignment': 'MainAxisAlignment', 'crossAxisAlignment': 'CrossAxisAlignment', 'mainAxisSize': 'MainAxisSize'},
    'Stack': {'children': 'List<Widget>', 'alignment': 'AlignmentDirectional'},
    'Text': {'text': 'String|List<String>', 'style': 'TextStyle', 'textAlign': 'TextAlign'},
    'Icon': {'icon': 'IconData', 'color': 'Color', 'size': 'double'},
    'Image': {'source': 'String', 'width': 'double', 'height': 'double', 'fit': 'BoxFit'},
    'Padding': {'padding': 'EdgeInsetsGeometry', 'child': 'Widget'},
    'Align': {'alignment': 'AlignmentGeometry', 'child': 'Widget'},
    'Center': {'child': 'Widget'},
    'Expanded': {'flex': 'int', 'child': 'Widget'},
    'SizedBox': {'width': 'double', 'height': 'double', 'child': 'Widget'},
    'Opacity': {'opacity': 'double', 'child': 'Widget'},
    'GestureDetector': {'onTap': 'Event', 'child': 'Widget'},
  };

  static const Map<String, List<String>> enumValues = {
    'MainAxisAlignment': ['start', 'end', 'center', 'spaceBetween', 'spaceAround', 'spaceEvenly'],
    'CrossAxisAlignment': ['start', 'end', 'center', 'stretch', 'baseline'],
    'MainAxisSize': ['min', 'max'],
    'TextAlign': ['left', 'right', 'center', 'justify', 'start', 'end'],
    'BoxFit': ['fill', 'contain', 'cover', 'fitWidth', 'fitHeight', 'none', 'scaleDown'],
    'BlendMode': [
      'clear',
      'src',
      'dst',
      'srcOver',
      'dstOver',
      'srcIn',
      'dstIn',
      'srcOut',
      'dstOut',
      'srcATop',
      'dstATop',
      'xor',
      'plus',
      'modulate',
      'screen',
      'overlay',
      'darken',
      'lighten',
      'colorDodge',
      'colorBurn',
      'hardLight',
      'softLight',
      'difference',
      'exclusion',
      'multiply',
      'hue',
      'saturation',
      'color',
      'luminosity',
    ],
  };

  static TemplateNode createWidget(String type, {String? name}) {
    return TemplateNode(type: type, properties: _getDefaultProperties(type), children: _getDefaultChildren(type), id: '${DateTime.now().millisecondsSinceEpoch}', name: name ?? type);
  }

  static Map<String, dynamic> _getDefaultProperties(String type) {
    switch (type) {
      case 'Container':
        return {
          'padding': [16.0, 16.0, 16.0, 16.0],
        };
      case 'Column':
        return {'mainAxisAlignment': 'start', 'crossAxisAlignment': 'start'};
      case 'Row':
        return {'mainAxisAlignment': 'start', 'crossAxisAlignment': 'center'};
      case 'Text':
        return {
          'text': 'Текст',
          'style': {'fontSize': 16.0, 'color': 0xFF000000},
        };
      case 'Icon':
        return {
          'icon': {'icon': 0xe5d5, 'fontFamily': 'MaterialIcons'},
          'size': 24.0,
          'color': 0xFF000000,
        };
      case 'Image':
        return {'source': 'https://example.com/image.jpg', 'width': 100.0, 'height': 100.0};
      case 'Expanded':
        return {'flex': 1};
      case 'SizedBox':
        return {'width': 100.0, 'height': 100.0};
      case 'Opacity':
        return {'opacity': 0.5};
      default:
        return {};
    }
  }

  static List<TemplateNode> _getDefaultChildren(String type) {
    switch (type) {
      case 'Column':
      case 'Row':
      case 'Stack':
        return [createWidget('Container', name: 'Child 1')];
      default:
        return [];
    }
  }
}
