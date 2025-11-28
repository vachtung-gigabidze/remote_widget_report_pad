// models/template_model.dart
class TemplateNode {
  final String type;
  final Map<String, dynamic> properties;
  final List<TemplateNode> children;
  final String? id;
  final String? name;

  TemplateNode({required this.type, required this.properties, this.children = const [], this.id, this.name});

  TemplateNode copyWith({String? type, Map<String, dynamic>? properties, List<TemplateNode>? children, String? name}) {
    return TemplateNode(type: type ?? this.type, properties: properties ?? Map.from(this.properties), children: children ?? List.from(this.children), id: id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'properties': properties, 'children': children.map((child) => child.toJson()).toList(), 'id': id, 'name': name};
  }

  factory TemplateNode.fromJson(Map<String, dynamic> json) {
    return TemplateNode(
      type: json['type'],
      properties: Map<String, dynamic>.from(json['properties']),
      children: (json['children'] as List).map((child) => TemplateNode.fromJson(child)).toList(),
      id: json['id'],
      name: json['name'],
    );
  }
}

class Template {
  final String name;
  final String code;
  final TemplateNode root;
  final Map<String, dynamic> testData;

  Template({required this.name, required this.code, required this.root, required this.testData});

  Template copyWith({String? name, String? code, TemplateNode? root, Map<String, dynamic>? testData}) {
    return Template(name: name ?? this.name, code: code ?? this.code, root: root ?? this.root, testData: testData ?? Map.from(this.testData));
  }
}

class UndoState {
  final Template template;
  final TemplateNode? selectedNode;

  UndoState(this.template, this.selectedNode);
}
