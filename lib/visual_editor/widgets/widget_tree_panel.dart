// editor/widget_tree_panel.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/template_service.dart';
import '../models/template_model.dart';

class WidgetTreePanel extends StatelessWidget {
  const WidgetTreePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Дерево виджетов', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Consumer<TemplateService>(
              builder: (context, service, child) {
                return _buildWidgetTree(service.currentTemplate.root, service);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetTree(TemplateNode node, TemplateService service) {
    final isSelected = service.selectedNode?.id == node.id;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Текущий узел
          Container(
            decoration: BoxDecoration(color: isSelected ? Colors.blue.shade100 : Colors.transparent, borderRadius: BorderRadius.circular(4)),
            child: ListTile(
              leading: const Icon(Icons.widgets, size: 16),
              title: Text(node.name ?? node.type),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [IconButton(icon: const Icon(Icons.delete, size: 16), onPressed: () => service.removeNode(node), tooltip: 'Удалить')],
              ),
              onTap: () => service.selectNode(node),
              dense: true,
            ),
          ),

          // Дочерние узлы
          if (node.children.isNotEmpty) ...node.children.map((child) => _buildWidgetTree(child, service)),
        ],
      ),
    );
  }
}
