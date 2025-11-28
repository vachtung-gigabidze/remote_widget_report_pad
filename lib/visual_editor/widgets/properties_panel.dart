// editor/properties_panel.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/template_model.dart';
import '../services/template_service.dart';
import '../data/rfw_widgets.dart';
import 'property_editors.dart';

class PropertiesPanel extends StatelessWidget {
  const PropertiesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Consumer<TemplateService>(
        builder: (context, service, child) {
          final selectedNode = service.selectedNode;

          if (selectedNode == null) {
            return const Center(child: Text('Выберите виджет для редактирования'));
          }

          return Column(
            children: [
              _buildHeader(selectedNode, service),
              Expanded(child: ListView(children: [_buildNameEditor(selectedNode, service), ..._buildPropertyEditors(selectedNode, service)])),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(TemplateNode node, TemplateService service) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          const Icon(Icons.widgets, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(node.type, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          IconButton(icon: const Icon(Icons.delete, size: 18), onPressed: () => service.removeNode(node), tooltip: 'Удалить виджет'),
        ],
      ),
    );
  }

  Widget _buildNameEditor(TemplateNode node, TemplateService service) {
    final controller = TextEditingController(text: node.name ?? node.type);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Название виджета', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Введите название'),
            onChanged: (value) {
              service.updateNodeName(value);
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPropertyEditors(TemplateNode node, TemplateService service) {
    final properties = RFWWidgets.widgetProperties[node.type] ?? {};
    final currentProperties = node.properties;

    if (properties.isEmpty) {
      return [const Padding(padding: EdgeInsets.all(16.0), child: Text('Нет доступных свойств для этого виджета'))];
    }

    return properties.entries.map((entry) {
      final propertyName = entry.key;
      final propertyType = entry.value;
      final currentValue = currentProperties[propertyName];

      return PropertyEditors.buildPropertyEditor(propertyName, propertyType, currentValue, (newValue) {
        final newProperties = Map<String, dynamic>.from(currentProperties);
        if (newValue == null) {
          newProperties.remove(propertyName);
        } else {
          newProperties[propertyName] = newValue;
        }
        service.updateNodeProperties(newProperties);
      });
    }).toList();
  }
}
