import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_report_constructor/visual_editor/app.dart';
import 'providers/report_provider.dart';
import 'widgets/dartpad_report_builder.dart';

void main() {
  // runApp(const MyApp());
  runApp(appRun());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportProvider(),
      child: MaterialApp(
        title: 'ReportPad - RFW Конструктор',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF2B2B2B),
          colorScheme: const ColorScheme.dark(primary: Color(0xFF4CAF50), secondary: Color(0xFF4CAF50)),
        ),
        home: const DartPadReportBuilder(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
