// editor/widget_palette.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/template_service.dart';
import '../data/rfw_widgets.dart';

class WidgetPalette extends StatelessWidget {
  const WidgetPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: ListView(
        children: [
          _buildCategory('Макет', RFWWidgets.layoutWidgets),
          _buildCategory('Контент', RFWWidgets.contentWidgets),
          _buildCategory('Стили', RFWWidgets.stylingWidgets),
          _buildCategory('Интерактив', RFWWidgets.interactiveWidgets),
        ],
      ),
    );
  }

  Widget _buildCategory(String title, List<String> widgets) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: widgets.map((widgetType) => _buildWidgetItem(widgetType)).toList(),
    );
  }

  Widget _buildWidgetItem(String widgetType) {
    return Builder(
      builder: (context) {
        return ListTile(title: Text(widgetType), onTap: () => _addWidgetToTree(context, widgetType));
      },
    );
  }

  void _addWidgetToTree(BuildContext context, String widgetType) {
    final service = context.read<TemplateService>();
    final selectedNode = service.selectedNode;
    final newWidget = RFWWidgets.createWidget(widgetType);

    if (selectedNode != null) {
      service.addChildNode(selectedNode, newWidget);
    } else {
      // Если ничего не выбрано, заменяем корневой виджет
      service.updateTemplate(service.currentTemplate.copyWith(root: newWidget));
    }
  }
}
