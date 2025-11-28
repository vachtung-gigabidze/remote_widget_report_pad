// editor/preview_panel.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/template_model.dart';
import '../services/template_service.dart';

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Предпросмотр', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Consumer<TemplateService>(
            builder: (context, service, child) {
              return Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _buildPreview(service.currentTemplate.root),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPreview(TemplateNode node) {
    // Здесь будет преобразование TemplateNode в реальный Flutter виджет
    // Для демонстрации используем упрощенный вариант
    return _nodeToWidget(node);
  }

  Widget _nodeToWidget(TemplateNode node) {
    switch (node.type) {
      case 'Container':
        return Container(
          padding: _parseEdgeInsets(node.properties['padding']),
          color: _parseColor(node.properties['color']),
          child: node.children.isNotEmpty ? _nodeToWidget(node.children.first) : null,
        );
      case 'Column':
        return Column(children: node.children.map(_nodeToWidget).toList());
      case 'Row':
        return Row(children: node.children.map(_nodeToWidget).toList());
      case 'Text':
        return Text(node.properties['text']?.toString() ?? 'Текст', style: _parseTextStyle(node.properties['style']));
      case 'Icon':
        return Icon(
          IconData(_parseIconData(node.properties['icon']), fontFamily: 'MaterialIcons'),
          color: _parseColor(node.properties['color']),
          size: node.properties['size']?.toDouble(),
        );
      default:
        return Container(
          color: Colors.grey.shade200,
          child: Center(child: Text(node.type)),
        );
    }
  }

  EdgeInsets _parseEdgeInsets(dynamic value) {
    if (value is List && value.length == 4) {
      return EdgeInsets.fromLTRB(value[0].toDouble(), value[1].toDouble(), value[2].toDouble(), value[3].toDouble());
    }
    return EdgeInsets.zero;
  }

  Color _parseColor(dynamic value) {
    if (value is int) {
      return Color(value);
    }
    return Colors.transparent;
  }

  TextStyle _parseTextStyle(dynamic value) {
    if (value is Map) {
      return TextStyle(fontSize: value['fontSize']?.toDouble(), color: _parseColor(value['color']), fontWeight: value['fontWeight'] == 'bold' ? FontWeight.bold : FontWeight.normal);
    }
    return const TextStyle();
  }

  int _parseIconData(dynamic value) {
    if (value is Map) {
      return value['icon'] ?? 0;
    }
    return 0;
  }
}
