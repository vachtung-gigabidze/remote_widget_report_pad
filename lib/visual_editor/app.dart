import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/template_service.dart';
import 'widgets/visual_editor_screen.dart';

appRun() {
  return MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TemplateService())],
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RFW Visual Editor',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const VisualEditorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
