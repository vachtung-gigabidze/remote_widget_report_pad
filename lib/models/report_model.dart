class ReportDesign {
  final String id;
  final String name;
  final String rfwCode;
  final Map<String, dynamic> testData;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReportDesign({required this.id, required this.name, required this.rfwCode, this.testData = const {}, required this.createdAt, required this.updatedAt});

  ReportDesign copyWith({String? id, String? name, String? rfwCode, Map<String, dynamic>? testData, DateTime? createdAt, DateTime? updatedAt}) {
    return ReportDesign(
      id: id ?? this.id,
      name: name ?? this.name,
      rfwCode: rfwCode ?? this.rfwCode,
      testData: testData ?? this.testData,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'rfwCode': rfwCode, 'testData': testData, 'createdAt': createdAt.toIso8601String(), 'updatedAt': updatedAt.toIso8601String()};
  }

  factory ReportDesign.fromJson(Map<String, dynamic> json) {
    return ReportDesign(
      id: json['id'],
      name: json['name'],
      rfwCode: json['rfwCode'],
      testData: Map<String, dynamic>.from(json['testData'] ?? {}),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
