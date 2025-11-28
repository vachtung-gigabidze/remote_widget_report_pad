// services/template_service.dart
import 'package:flutter/material.dart';
import '../models/template_model.dart';

class TemplateService extends ChangeNotifier {
  Template _currentTemplate = Template(
    name: 'Новый шаблон',
    code: 'import core.widgets;\n\nwidget root = Container();',
    root: TemplateNode(type: 'Container', properties: {}, children: [], id: 'root', name: 'Container'),
    testData: {},
  );

  TemplateNode? _selectedNode;
  final List<UndoState> _undoStack = [];
  final List<UndoState> _redoStack = [];
  bool _showSourceCode = false;

  Template get currentTemplate => _currentTemplate;
  TemplateNode? get selectedNode => _selectedNode;
  bool get showSourceCode => _showSourceCode;

  void toggleSourceCodeView() {
    _showSourceCode = !_showSourceCode;
    notifyListeners();
  }

  void selectNode(TemplateNode? node) {
    _selectedNode = node;
    notifyListeners();
  }

  void updateTemplate(Template template) {
    _undoStack.add(UndoState(_currentTemplate, _selectedNode));
    _redoStack.clear();
    _currentTemplate = template;
    _generateCodeFromTree();
    notifyListeners();
  }

  void updateNodeProperties(Map<String, dynamic> newProperties) {
    if (_selectedNode == null) return;

    final newRoot = _updateNodePropertiesRecursive(_currentTemplate.root, _selectedNode!, newProperties);

    updateTemplate(_currentTemplate.copyWith(root: newRoot));
  }

  TemplateNode _updateNodePropertiesRecursive(TemplateNode currentNode, TemplateNode targetNode, Map<String, dynamic> newProperties) {
    if (currentNode.id == targetNode.id) {
      return currentNode.copyWith(properties: newProperties);
    }

    return currentNode.copyWith(children: currentNode.children.map((child) => _updateNodePropertiesRecursive(child, targetNode, newProperties)).toList());
  }

  void updateNodeName(String newName) {
    if (_selectedNode == null) return;

    final newRoot = _updateNodeNameRecursive(_currentTemplate.root, _selectedNode!, newName);

    updateTemplate(_currentTemplate.copyWith(root: newRoot));
  }

  TemplateNode _updateNodeNameRecursive(TemplateNode currentNode, TemplateNode targetNode, String newName) {
    if (currentNode.id == targetNode.id) {
      return currentNode.copyWith(name: newName);
    }

    return currentNode.copyWith(children: currentNode.children.map((child) => _updateNodeNameRecursive(child, targetNode, newName)).toList());
  }

  void addChildNode(TemplateNode parent, TemplateNode newChild) {
    final newRoot = _addChildNodeRecursive(_currentTemplate.root, parent, newChild);
    updateTemplate(_currentTemplate.copyWith(root: newRoot));
    selectNode(newChild);
  }

  TemplateNode _addChildNodeRecursive(TemplateNode currentNode, TemplateNode parentNode, TemplateNode newChild) {
    if (currentNode.id == parentNode.id) {
      return currentNode.copyWith(children: [...currentNode.children, newChild]);
    }

    return currentNode.copyWith(children: currentNode.children.map((child) => _addChildNodeRecursive(child, parentNode, newChild)).toList());
  }

  void removeNode(TemplateNode node) {
    final newRoot = _removeNodeRecursive(_currentTemplate.root, node);
    updateTemplate(_currentTemplate.copyWith(root: newRoot));
    selectNode(null);
  }

  TemplateNode _removeNodeRecursive(TemplateNode currentNode, TemplateNode targetNode) {
    if (currentNode.id == targetNode.id) {
      return TemplateNode(type: 'Container', properties: {}, id: 'root', name: 'Container');
    }

    return currentNode.copyWith(children: currentNode.children.where((child) => child.id != targetNode.id).map((child) => _removeNodeRecursive(child, targetNode)).toList());
  }

  void _generateCodeFromTree() {
    final buffer = StringBuffer();
    buffer.writeln("import core.widgets;");
    buffer.writeln();
    buffer.writeln("widget root = ${_nodeToCode(_currentTemplate.root)};");

    _currentTemplate = _currentTemplate.copyWith(code: buffer.toString());
  }

  String _nodeToCode(TemplateNode node) {
    final buffer = StringBuffer();
    buffer.write("${node.type}(");

    final properties = node.properties;
    final propertyEntries = properties.entries.where((entry) => entry.value != null).toList();

    for (int i = 0; i < propertyEntries.length; i++) {
      final entry = propertyEntries[i];
      buffer.write("${entry.key}: ${_valueToCode(entry.value)}");
      if (i < propertyEntries.length - 1 || node.children.isNotEmpty) {
        buffer.write(", ");
      }
    }

    if (node.children.isNotEmpty) {
      if (node.children.length == 1) {
        if (propertyEntries.isNotEmpty) buffer.write(", ");
        buffer.write("child: ${_nodeToCode(node.children.first)}");
      } else {
        if (propertyEntries.isNotEmpty) buffer.write(", ");
        buffer.write("children: [");
        for (int i = 0; i < node.children.length; i++) {
          buffer.write(_nodeToCode(node.children[i]));
          if (i < node.children.length - 1) {
            buffer.write(", ");
          }
        }
        buffer.write("]");
      }
    }

    buffer.write(")");
    return buffer.toString();
  }

  String _valueToCode(dynamic value) {
    if (value == null) return 'null';

    if (value is String) {
      return '"$value"';
    } else if (value is num) {
      return '$value';
    } else if (value is bool) {
      return value.toString();
    } else if (value is List) {
      return '[${value.map(_valueToCode).join(', ')}]';
    } else if (value is Map) {
      final entries = value.entries.where((e) => e.value != null).toList();
      return '{${entries.map((e) => '"${e.key}": ${_valueToCode(e.value)}').join(', ')}}';
    }

    return value.toString();
  }

  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  void undo() {
    if (_undoStack.isEmpty) return;

    _redoStack.add(UndoState(_currentTemplate, _selectedNode));
    final previousState = _undoStack.removeLast();
    _currentTemplate = previousState.template;
    _selectedNode = previousState.selectedNode;
    notifyListeners();
  }

  void redo() {
    if (_redoStack.isEmpty) return;

    _undoStack.add(UndoState(_currentTemplate, _selectedNode));
    final nextState = _redoStack.removeLast();
    _currentTemplate = nextState.template;
    _selectedNode = nextState.selectedNode;
    notifyListeners();
  }

  void loadTemplate(Template template) {
    _undoStack.clear();
    _redoStack.clear();
    _currentTemplate = template;
    _selectedNode = null;
    notifyListeners();
  }

  void updateCode(String newCode) {
    try {
      final newRoot = _parseCodeToNode(newCode);
      updateTemplate(_currentTemplate.copyWith(code: newCode, root: newRoot));
    } catch (e) {
      print('Ошибка парсинга кода: $e');
    }
  }

  TemplateNode _parseCodeToNode(String code) {
    // Упрощенный парсинг для демонстрации
    return TemplateNode(type: 'Container', properties: {}, children: [], id: 'root', name: 'Container');
  }
}
