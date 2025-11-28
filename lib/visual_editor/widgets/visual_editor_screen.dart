// editor/visual_editor_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../templates/report_templates.dart';
import '../models/template_model.dart';
import '../services/template_service.dart';
import '../data/rfw_widgets.dart';
import 'widget_tree_panel.dart';
import 'properties_panel.dart';
import 'preview_panel.dart';
import 'widget_palette.dart';
import 'source_code_panel.dart';

class VisualEditorScreen extends StatefulWidget {
  const VisualEditorScreen({super.key});

  @override
  State<VisualEditorScreen> createState() => _VisualEditorScreenState();
}

class _VisualEditorScreenState extends State<VisualEditorScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey, appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Consumer<TemplateService>(
        builder: (context, service, child) {
          return Text('RFW Editor - ${service.currentTemplate.name}');
        },
      ),
      actions: [
        // Переключение между визуальным редактором и кодом
        Consumer<TemplateService>(
          builder: (context, service, child) {
            return IconButton(
              icon: Icon(service.showSourceCode ? Icons.dashboard : Icons.code),
              onPressed: service.toggleSourceCodeView,
              tooltip: service.showSourceCode ? 'Визуальный редактор' : 'Исходный код',
            );
          },
        ),

        // Кнопки Undo/Redo
        Consumer<TemplateService>(
          builder: (context, service, child) {
            return Row(
              children: [
                IconButton(icon: const Icon(Icons.undo), onPressed: service.canUndo ? service.undo : null, tooltip: 'Отменить'),
                IconButton(icon: const Icon(Icons.redo), onPressed: service.canRedo ? service.redo : null, tooltip: 'Вернуть'),
              ],
            );
          },
        ),

        // Сохранение
        IconButton(icon: const Icon(Icons.save), onPressed: _saveTemplate, tooltip: 'Сохранить шаблон'),

        // Меню шаблонов
        PopupMenuButton<String>(
          onSelected: _loadTemplate,
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'simple', child: Text('Простой отчет')),
            const PopupMenuItem(value: 'card', child: Text('Карточный отчет')),
            const PopupMenuItem(value: 'table', child: Text('Табличный отчет')),
            const PopupMenuItem(value: 'stats', child: Text('Статистика')),
            const PopupMenuItem(value: 'new', child: Text('Новый шаблон')),
          ],
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Consumer<TemplateService>(
      builder: (context, service, child) {
        if (service.showSourceCode) {
          return const SourceCodePanel();
        }

        return Row(
          children: [
            // Панель виджетов
            const WidgetPalette(),

            // Дерево виджетов
            const Expanded(flex: 2, child: WidgetTreePanel()),

            // Предпросмотр
            const Expanded(flex: 3, child: PreviewPanel()),

            // Панель свойств
            const Expanded(flex: 2, child: PropertiesPanel()),
          ],
        );
      },
    );
  }

  void _loadTemplate(String templateType) {
    final service = context.read<TemplateService>();
    final template = _createTemplateFromType(templateType);
    service.loadTemplate(template);
  }

  Template _createTemplateFromType(String type) {
    switch (type) {
      case 'simple':
        return Template(name: 'Простой отчет', code: ReportTemplates.simpleReport, root: _parseTemplateToNode(ReportTemplates.simpleReport), testData: ReportTemplates.simpleReportData);
      case 'card':
        return Template(name: 'Карточный отчет', code: ReportTemplates.cardReport, root: _parseTemplateToNode(ReportTemplates.cardReport), testData: ReportTemplates.cardReportData);
      case 'table':
        return Template(name: 'Табличный отчет', code: ReportTemplates.tableReport, root: _parseTemplateToNode(ReportTemplates.tableReport), testData: ReportTemplates.tableReportData);
      case 'stats':
        return Template(name: 'Статистика', code: ReportTemplates.statsReport, root: _parseTemplateToNode(ReportTemplates.statsReport), testData: ReportTemplates.statsReportData);
      case 'new':
      default:
        return Template(name: 'Новый шаблон', code: 'import core.widgets;\n\nwidget root = Container();', root: RFWWidgets.createWidget('Container'), testData: {});
    }
  }

  TemplateNode _parseTemplateToNode(String code) {
    // Упрощенный парсинг - в реальном приложении нужен полноценный парсер
    if (code.contains('Column')) {
      return RFWWidgets.createWidget('Column');
    }
    return RFWWidgets.createWidget('Container');
  }

  void _saveTemplate() {
    final service = context.read<TemplateService>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Сохранить шаблон'),
        content: const Text('Шаблон успешно сохранен!'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }
}
