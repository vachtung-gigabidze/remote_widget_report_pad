import 'package:flutter/foundation.dart';
import '../models/report_model.dart';

class ReportProvider with ChangeNotifier {
  final List<ReportDesign> _reports = [];
  ReportDesign? _currentDesign;

  List<ReportDesign> get reports => _reports;
  ReportDesign? get currentDesign => _currentDesign;

  void createNewReport(String name, {String? template, Map<String, dynamic> testData = const {}}) {
    final defaultTemplate =
        template ??
        '''
import core;
import widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    children: [
      Text(
        text: "Новый отчет",
        style: {
          "fontSize": 24.0,
          "fontWeight": "bold",
        },
      ),
      SizedBox(height: 16.0),
      Text(
        text: "Добавьте содержимое отчета здесь",
        style: {
          "fontSize": 16.0,
          "color": "#666666",
        },
      ),
    ],
  ),
);
''';

    final newReport = ReportDesign(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      rfwCode: defaultTemplate,
      testData: testData,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _reports.add(newReport);
    _currentDesign = newReport;
    notifyListeners();
  }

  void updateCurrentDesign(String newRfwCode) {
    if (_currentDesign != null) {
      final index = _reports.indexWhere((r) => r.id == _currentDesign!.id);
      if (index != -1) {
        _reports[index] = _reports[index].copyWith(rfwCode: newRfwCode, updatedAt: DateTime.now());
        _currentDesign = _reports[index];
        notifyListeners();
      }
    }
  }

  void updateTestData(Map<String, dynamic> newTestData) {
    if (_currentDesign != null) {
      final index = _reports.indexWhere((r) => r.id == _currentDesign!.id);
      if (index != -1) {
        _reports[index] = _reports[index].copyWith(testData: newTestData, updatedAt: DateTime.now());
        _currentDesign = _reports[index];
        notifyListeners();
      }
    }
  }

  void setCurrentDesign(ReportDesign design) {
    _currentDesign = design;
    notifyListeners();
  }

  void deleteReport(String id) {
    _reports.removeWhere((r) => r.id == id);
    if (_currentDesign?.id == id) {
      _currentDesign = null;
    }
    notifyListeners();
  }
}
