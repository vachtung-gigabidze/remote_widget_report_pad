// editor/property_editors.dart
import 'package:flutter/material.dart';

import '../data/rfw_widgets.dart';

class PropertyEditors2 {
  static Widget buildPropertyEditor(String propertyName, String propertyType, dynamic currentValue, Function(dynamic) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_formatPropertyName(propertyName), style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          _buildEditorByType(propertyName, propertyType, currentValue, onChanged),
        ],
      ),
    );
  }

  static Widget _buildEditorByType(String propertyName, String propertyType, dynamic currentValue, Function(dynamic) onChanged) {
    switch (propertyType) {
      case 'String|List<String>':
        return _buildTextEditor(propertyName, currentValue, onChanged);
      case 'double':
        return _buildDoubleEditor(propertyName, currentValue, onChanged);
      case 'int':
        return _buildIntEditor(propertyName, currentValue, onChanged);
      case 'Color':
        return _buildColorEditor(propertyName, currentValue, onChanged);
      case 'EdgeInsetsGeometry':
        return _buildEdgeInsetsEditor(propertyName, currentValue, onChanged);
      case 'MainAxisAlignment':
      case 'CrossAxisAlignment':
      case 'TextAlign':
      case 'BoxFit':
        return _buildEnumEditor(propertyName, propertyType, currentValue, onChanged);
      case 'Widget':
        return _buildChildInfo(propertyName);
      case 'List<Widget>':
        return _buildChildrenInfo(propertyName);
      default:
        return _buildJsonEditor(propertyName, currentValue, onChanged);
    }
  }

  static Widget _buildTextEditor(String name, dynamic value, Function(dynamic) onChanged) {
    final controller = TextEditingController(text: value?.toString() ?? '');

    return TextField(
      controller: controller,
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
      onChanged: (text) => onChanged(text),
    );
  }

  static Widget _buildDoubleEditor(String name, dynamic value, Function(dynamic) onChanged) {
    final controller = TextEditingController(text: value?.toString() ?? '0.0');

    return TextField(
      controller: controller,
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (text) {
        final doubleValue = double.tryParse(text);
        if (doubleValue != null) onChanged(doubleValue);
      },
    );
  }

  static Widget _buildIntEditor(String name, dynamic value, Function(dynamic) onChanged) {
    final controller = TextEditingController(text: value?.toString() ?? '0');

    return TextField(
      controller: controller,
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
      keyboardType: TextInputType.number,
      onChanged: (text) {
        final intValue = int.tryParse(text);
        if (intValue != null) onChanged(intValue);
      },
    );
  }

  static Widget _buildColorEditor(String name, dynamic value, Function(dynamic) onChanged) {
    final colorValue = value is int ? value : 0xFF000000;

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
            controller: TextEditingController(text: '0x${colorValue.toRadixString(16).toUpperCase()}'),
            decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, labelText: 'HEX значение'),
            onChanged: (text) {
              if (text.startsWith('0x')) {
                final intValue = int.tryParse(text.substring(2), radix: 16);
                if (intValue != null) onChanged(intValue);
              }
            },
          ),
        ),
      ],
    );
  }

  static Widget _buildEnumEditor(String name, String type, dynamic value, Function(dynamic) onChanged) {
    final enumValues = RFWWidgets.enumValues[type] ?? [];
    final current = value?.toString() ?? enumValues.first;

    return DropdownButtonFormField<String>(
      value: current,
      items: enumValues.map((value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (newValue) => onChanged(newValue),
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
    );
  }

  static Widget _buildEdgeInsetsEditor(String name, dynamic value, Function(dynamic) onChanged) {
    List<double> padding = [0.0, 0.0, 0.0, 0.0];

    if (value is List && value.length == 4) {
      padding = value.cast<double>();
    }

    return Column(
      children: [
        _buildPaddingField('Слева', padding[0], (v) {
          padding[0] = v;
          onChanged([...padding]);
        }),
        const SizedBox(height: 8),
        _buildPaddingField('Сверху', padding[1], (v) {
          padding[1] = v;
          onChanged([...padding]);
        }),
        const SizedBox(height: 8),
        _buildPaddingField('Справа', padding[2], (v) {
          padding[2] = v;
          onChanged([...padding]);
        }),
        const SizedBox(height: 8),
        _buildPaddingField('Снизу', padding[3], (v) {
          padding[3] = v;
          onChanged([...padding]);
        }),
      ],
    );
  }

  static Widget _buildPaddingField(String label, double value, Function(double) onChanged) {
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

  static Widget _buildChildInfo(String name) {
    return const Text('Дочерний элемент редактируется в дереве виджетов', style: TextStyle(color: Colors.grey, fontSize: 12));
  }

  static Widget _buildChildrenInfo(String name) {
    return const Text('Дочерние элементы редактируются в дереве виджетов', style: TextStyle(color: Colors.grey, fontSize: 12));
  }

  static Widget _buildJsonEditor(String name, dynamic value, Function(dynamic) onChanged) {
    final controller = TextEditingController(text: value != null ? _formatJson(value) : '{}');

    return TextField(
      controller: controller,
      maxLines: 3,
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, hintText: 'JSON значение'),
      onChanged: (text) {
        try {
          // В реальном приложении нужен JSON парсер
          onChanged(text);
        } catch (e) {
          // Обработка ошибок
        }
      },
    );
  }

  static String _formatPropertyName(String name) {
    return name[0].toUpperCase() + name.substring(1);
  }

  static String _formatJson(dynamic value) {
    if (value is Map) {
      return '{${value.entries.map((e) => '${e.key}: ${e.value}').join(', ')}}';
    } else if (value is List) {
      return '[${value.join(', ')}]';
    }
    return value.toString();
  }
}
