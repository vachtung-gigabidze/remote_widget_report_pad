// editor/properties_panel.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/template_model.dart';
import '../services/template_service.dart';
import '../data/rfw_widgets.dart';
import 'property_editors.dart';

class PropertiesPanel extends StatefulWidget {
  const PropertiesPanel({super.key});

  @override
  State<PropertiesPanel> createState() => _PropertiesPanelState();
}

class _PropertiesPanelState extends State<PropertiesPanel> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _updateControllers(TemplateNode node) {
    // Очищаем старые контроллеры
    _controllers.clear();

    // Создаем новые контроллеры для текущего узла
    final properties = RFWWidgets.widgetProperties[node.type] ?? {};
    for (final entry in properties.entries) {
      final propertyName = entry.key;
      final currentValue = node.properties[propertyName];
      final controller = TextEditingController(text: _valueToString(currentValue));
      _controllers[propertyName] = controller;
    }
  }

  String _valueToString(dynamic value) {
    if (value == null) return '';
    if (value is List) return value.join(', ');
    if (value is Map) return value.toString();
    return value.toString();
  }

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
            _controllers.clear();
            return const Center(child: Text('Выберите виджет для редактирования'));
          }

          // Обновляем контроллеры при смене выбранного узла
          if (_controllers.isEmpty || _controllers.keys.first != selectedNode.id) {
            _updateControllers(selectedNode);
          }

          return Column(
            children: [
              _buildHeader(selectedNode, service),
              Expanded(child: _buildPropertiesList(selectedNode, service)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(TemplateNode node, TemplateService service) {
    final nameController = TextEditingController(text: node.name ?? node.type);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.widgets, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(node.type, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              IconButton(icon: const Icon(Icons.delete, size: 18), onPressed: () => service.removeNode(node), tooltip: 'Удалить виджет'),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Название виджета', isDense: true),
            onChanged: (value) => service.updateNodeName(value),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesList(TemplateNode node, TemplateService service) {
    final properties = RFWWidgets.widgetProperties[node.type] ?? {};

    if (properties.isEmpty) {
      return const Padding(padding: EdgeInsets.all(16.0), child: Text('Нет доступных свойств для этого виджета'));
    }

    return ListView(
      children: properties.entries.map((entry) {
        final propertyName = entry.key;
        final propertyType = entry.value;
        final currentValue = node.properties[propertyName];
        final controller = _controllers[propertyName];

        return PropertyEditor(
          propertyName: propertyName,
          propertyType: propertyType,
          currentValue: currentValue,
          controller: controller,
          onChanged: (newValue) {
            final newProperties = Map<String, dynamic>.from(node.properties);
            if (newValue == null) {
              newProperties.remove(propertyName);
            } else {
              newProperties[propertyName] = newValue;
            }
            service.updateNodeProperties(newProperties);
          },
        );
      }).toList(),
    );
  }
}

class PropertyEditor extends StatefulWidget {
  final String propertyName;
  final String propertyType;
  final dynamic currentValue;
  final TextEditingController? controller;
  final Function(dynamic) onChanged;

  const PropertyEditor({super.key, required this.propertyName, required this.propertyType, required this.currentValue, required this.controller, required this.onChanged});

  @override
  State<PropertyEditor> createState() => _PropertyEditorState();
}

class _PropertyEditorState extends State<PropertyEditor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_formatPropertyName(widget.propertyName), style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          _buildEditorByType(),
        ],
      ),
    );
  }

  Widget _buildEditorByType() {
    switch (widget.propertyType) {
      case 'String|List<String>':
        return _buildTextEditor();
      case 'double':
        return _buildDoubleEditor();
      case 'int':
        return _buildIntEditor();
      case 'Color':
        return _buildColorEditor();
      case 'EdgeInsetsGeometry':
        return _buildEdgeInsetsEditor();
      case 'MainAxisAlignment':
      case 'CrossAxisAlignment':
      case 'TextAlign':
      case 'BoxFit':
        return _buildEnumEditor();
      case 'Widget':
        return _buildChildInfo();
      case 'List<Widget>':
        return _buildChildrenInfo();
      default:
        return _buildJsonEditor();
    }
  }

  Widget _buildTextEditor() {
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
      onChanged: (text) => widget.onChanged(text),
    );
  }

  Widget _buildDoubleEditor() {
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (text) {
        final doubleValue = double.tryParse(text);
        if (doubleValue != null) {
          widget.onChanged(doubleValue);
        }
      },
    );
  }

  Widget _buildIntEditor() {
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
      keyboardType: TextInputType.number,
      onChanged: (text) {
        final intValue = int.tryParse(text);
        if (intValue != null) {
          widget.onChanged(intValue);
        }
      },
    );
  }

  Widget _buildColorEditor() {
    final colorValue = widget.currentValue is int ? widget.currentValue : 0xFF000000;
    final controller = TextEditingController(text: '0x${colorValue.toRadixString(16).padLeft(8, '0').toUpperCase()}');

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(colorValue),
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, labelText: 'HEX значение'),
            onChanged: (text) {
              if (text.startsWith('0x')) {
                final intValue = int.tryParse(text.substring(2), radix: 16);
                if (intValue != null) {
                  widget.onChanged(intValue);
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEnumEditor() {
    final enumValues = RFWWidgets.enumValues[widget.propertyType] ?? [];
    final current = widget.currentValue?.toString() ?? enumValues.first;

    return DropdownButtonFormField<String>(
      value: current,
      items: enumValues.map((value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          widget.onChanged(newValue);
        }
      },
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
    );
  }

  Widget _buildEdgeInsetsEditor() {
    List<double> padding = [0.0, 0.0, 0.0, 0.0];

    if (widget.currentValue is List && (widget.currentValue as List).length == 4) {
      padding = (widget.currentValue as List).cast<double>();
    }

    return Column(
      children: [
        _buildPaddingField('Слева', padding[0], (v) {
          padding[0] = v;
          widget.onChanged([...padding]);
        }),
        const SizedBox(height: 8),
        _buildPaddingField('Сверху', padding[1], (v) {
          padding[1] = v;
          widget.onChanged([...padding]);
        }),
        const SizedBox(height: 8),
        _buildPaddingField('Справа', padding[2], (v) {
          padding[2] = v;
          widget.onChanged([...padding]);
        }),
        const SizedBox(height: 8),
        _buildPaddingField('Снизу', padding[3], (v) {
          padding[3] = v;
          widget.onChanged([...padding]);
        }),
      ],
    );
  }

  Widget _buildPaddingField(String label, double value, Function(double) onChanged) {
    final controller = TextEditingController(text: value.toString());

    return TextField(
      controller: controller,
      decoration: InputDecoration(border: const OutlineInputBorder(), isDense: true, labelText: label),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (text) {
        final doubleValue = double.tryParse(text);
        if (doubleValue != null) onChanged(doubleValue);
      },
    );
  }

  Widget _buildChildInfo() {
    return const Text('Дочерний элемент редактируется в дереве виджетов', style: TextStyle(color: Colors.grey, fontSize: 12));
  }

  Widget _buildChildrenInfo() {
    return const Text('Дочерние элементы редактируются в дереве виджетов', style: TextStyle(color: Colors.grey, fontSize: 12));
  }

  Widget _buildJsonEditor() {
    final controller = widget.controller ?? TextEditingController();

    return TextField(
      controller: controller,
      maxLines: 3,
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, hintText: 'JSON значение'),
      onChanged: (text) {
        widget.onChanged(text);
      },
    );
  }

  String _formatPropertyName(String name) {
    return name[0].toUpperCase() + name.substring(1);
  }
}
