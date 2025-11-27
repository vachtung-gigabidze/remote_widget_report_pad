import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import '../models/report_model.dart';
import '../providers/report_provider.dart';
import '../services/color_service.dart';
import '../templates/report_templates.dart';
import '../services/rfw_service.dart';
import 'color_picker_dialog.dart';

class DartPadReportBuilder extends StatefulWidget {
  const DartPadReportBuilder({Key? key}) : super(key: key);

  @override
  _DartPadReportBuilderState createState() => _DartPadReportBuilderState();
}

class _DartPadReportBuilderState extends State<DartPadReportBuilder> {
  late CodeController _codeController;
  final TextEditingController _reportNameController = TextEditingController();
  bool _showConsole = false;
  bool _showDataEditor = false;
  String _consoleOutput = '';
  final ScrollController _consoleScrollController = ScrollController();

  // Для подсветки цветов
  final Map<String, String> _colorHighlights = {};
  final GlobalKey _codeFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _codeController = CodeController();
    _setupCodeController();
    RfwService.initialize();
  }

  void _setupCodeController() {
    _codeController.addListener(_onCodeChanged);
    _codeController.addListener(_updateColorHighlights);
  }

  void _onCodeChanged() {
    final provider = Provider.of<ReportProvider>(context, listen: false);
    if (provider.currentDesign != null) {
      provider.updateCurrentDesign(_codeController.text);
    }
  }

  void _updateColorHighlights() {
    final text = _codeController.text;
    // Ищем цвета в формате 0xFFFFFFFF без кавычек
    final colorRegex = RegExp(r'"color":\s*(0x[0-9A-Fa-f]{8})');
    final matches = colorRegex.allMatches(text);

    final newHighlights = <String, String>{};
    for (final match in matches) {
      final color = match.group(1)!;
      newHighlights[color] = color;
    }

    if (!_mapsEqual(_colorHighlights, newHighlights)) {
      setState(() {
        _colorHighlights.clear();
        _colorHighlights.addAll(newHighlights);
      });
    }
  }

  bool _mapsEqual(Map<String, String> a, Map<String, String> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _reportNameController.dispose();
    _consoleScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2B2B),
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(child: _buildMainContent()),
          if (_showConsole) _buildConsole(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 60,
      color: const Color(0xFF3C3F41),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [_buildLogo(), const SizedBox(width: 24), _buildFileDropdown(), const Spacer(), _buildActionButtons()]),
    );
  }

  Widget _buildLogo() {
    return const Row(
      children: [
        Icon(Icons.code, color: Color(0xFF4CAF50), size: 24),
        SizedBox(width: 8),
        Text(
          'ReportPad',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFileDropdown() {
    return Consumer<ReportProvider>(
      builder: (context, provider, child) {
        ReportDesign? currentValue;
        if (provider.currentDesign != null && provider.reports.isNotEmpty) {
          currentValue = provider.reports.firstWhere((report) => report.id == provider.currentDesign!.id, orElse: () => provider.currentDesign!);
        }

        return Container(
          width: 200, // Фиксированная ширина для dropdown
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ReportDesign>(
              isExpanded: true, // Важно для правильной верстки
              value: currentValue,
              dropdownColor: const Color(0xFF3C3F41),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              hint: const Text('Выберите отчет', style: TextStyle(color: Colors.white70)),
              items: _buildDropdownItems(provider),
              onChanged: (design) {
                if (design != null) {
                  _loadReport(provider, design);
                }
              },
            ),
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<ReportDesign>> _buildDropdownItems(ReportProvider provider) {
    final items = <DropdownMenuItem<ReportDesign>>[];

    for (final design in provider.reports) {
      items.add(
        DropdownMenuItem(
          value: design,
          child: Container(
            constraints: const BoxConstraints(minWidth: 180, maxWidth: 180),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.description, size: 16, color: Colors.white70),
                const SizedBox(width: 8),
                Expanded(child: Text(design.name, overflow: TextOverflow.ellipsis, maxLines: 1)),
                const SizedBox(width: 8),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      _deleteReport(provider, design.id);
                    },
                    child: const Icon(Icons.close, size: 14, color: Colors.white54),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (provider.reports.isNotEmpty) {
      items.add(const DropdownMenuItem(value: null, enabled: false, child: Divider(height: 1, color: Colors.white54)));
    }

    items.add(
      DropdownMenuItem(
        value: null,
        child: Container(
          constraints: const BoxConstraints(minWidth: 180, maxWidth: 180),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, size: 16, color: Color(0xFF4CAF50)),
              SizedBox(width: 8),
              Text('Новый отчет'),
            ],
          ),
        ),
        onTap: () => _createNewReport(provider),
      ),
    );

    return items;
  }

  Widget _buildActionButtons() {
    return Consumer<ReportProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow, color: Color(0xFF4CAF50)),
              tooltip: 'Запустить (Ctrl+Enter)',
              onPressed: provider.currentDesign != null ? () => _runCode(provider) : null,
            ),
            IconButton(
              icon: const Icon(Icons.save, color: Colors.blue),
              tooltip: 'Сохранить (Ctrl+S)',
              onPressed: provider.currentDesign != null ? () => _saveDesign(provider) : null,
            ),
            IconButton(
              icon: const Icon(Icons.data_object, color: Colors.orange),
              tooltip: 'Тестовые данные',
              onPressed: provider.currentDesign != null ? () => _toggleDataEditor() : null,
            ),
            IconButton(
              icon: const Icon(Icons.folder_open, color: Colors.purple),
              tooltip: 'Шаблоны',
              onPressed: _showTemplatesDialog,
            ),
            IconButton(
              icon: Icon(_showConsole ? Icons.expand_less : Icons.expand_more, color: Colors.white70),
              tooltip: 'Консоль',
              onPressed: () {
                setState(() {
                  _showConsole = !_showConsole;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            children: [
              Expanded(child: _buildCodeEditor()),
              Container(height: 2, color: const Color(0xFF4C4C4C)),
              Expanded(child: _buildPreview()),
            ],
          );
        }

        return Row(
          children: [
            Expanded(flex: 1, child: _buildCodeEditor()),
            Container(width: 2, color: const Color(0xFF4C4C4C)),
            Expanded(flex: 1, child: _buildPreview()),
          ],
        );
      },
    );
  }

  Widget _buildEditorHeader(ReportProvider provider) {
    return Container(
      height: 40,
      color: const Color(0xFF3C3F41),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (provider.currentDesign != null) ...[
            const Icon(Icons.description, size: 16, color: Colors.white70),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _reportNameController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Название отчета...',
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                onChanged: (value) {
                  if (provider.currentDesign != null) {
                    _updateReportName(provider, value);
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF4CAF50).withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
              child: const Text('RFW', style: TextStyle(color: Colors.white54, fontSize: 12)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPreview() {
    return Consumer<ReportProvider>(
      builder: (context, provider, child) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              _buildPreviewHeader(provider),
              if (_showDataEditor && provider.currentDesign != null) _buildDataEditor(provider),
              Expanded(
                child: Container(color: Colors.white, child: _buildPreviewContent(provider)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPreviewHeader(ReportProvider provider) {
    return Container(
      height: 40,
      color: const Color(0xFFE8E8E8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.phone_android, size: 16, color: Colors.black54),
          const SizedBox(width: 8),
          const Text(
            'Предпросмотр',
            style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          if (provider.currentDesign != null)
            IconButton(
              icon: Icon(_showDataEditor ? Icons.code_off : Icons.code, size: 18, color: Colors.black54),
              tooltip: 'Редактор данных',
              onPressed: _toggleDataEditor,
            ),
        ],
      ),
    );
  }

  Widget _buildDataEditor(ReportProvider provider) {
    final data = provider.currentDesign!.testData;
    final dataController = TextEditingController(text: _formatJson(data));

    return Container(
      height: 150,
      padding: const EdgeInsets.all(8),
      color: const Color(0xFFF5F5F5),
      child: Column(
        children: [
          const Text(
            'Тестовые данные (JSON):',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 29, 29, 29)),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                controller: dataController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(8), isDense: true),
                style: const TextStyle(fontFamily: 'Monospace', fontSize: 10, color: Color.fromARGB(255, 29, 29, 29)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  try {
                    final newData = _parseJson(dataController.text);
                    provider.updateTestData(newData);
                    setState(() {
                      _consoleOutput = 'Данные обновлены';
                    });
                  } catch (e) {
                    setState(() {
                      _consoleOutput = 'Ошибка в JSON: $e';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
                child: const Text('Применить', style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showDataEditor = false;
                  });
                },
                style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
                child: const Text('Скрыть', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewContent(ReportProvider provider) {
    if (provider.currentDesign == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.visibility, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Предпросмотр отчета\nпоявится здесь',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    try {
      return RfwService.createPreview(provider.currentDesign!.rfwCode, data: provider.currentDesign!.testData);
    } catch (e) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Ошибка в коде: $e',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildConsole() {
    return Container(
      height: 150,
      color: const Color(0xFF1E1E1E),
      child: Column(
        children: [
          Container(
            height: 32,
            color: const Color(0xFF323232),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'КОНСОЛЬ',
                  style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.clear, size: 16, color: Colors.white54),
                  onPressed: () {
                    setState(() {
                      _consoleOutput = '';
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _consoleScrollController,
              padding: const EdgeInsets.all(16),
              child: SelectableText(
                _consoleOutput.isEmpty ? 'Готов к выполнению...' : _consoleOutput,
                style: const TextStyle(color: Colors.white, fontFamily: 'Monospace', fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Вспомогательные методы
  String _formatJson(Map<String, dynamic> json) {
    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(json);
  }

  Map<String, dynamic> _parseJson(String jsonString) {
    final decoder = JsonDecoder();
    return Map<String, dynamic>.from(decoder.convert(jsonString));
  }

  void _toggleDataEditor() {
    setState(() {
      _showDataEditor = !_showDataEditor;
    });
  }

  void _createNewReport(ReportProvider provider) {
    final newNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF3C3F41),
        title: const Text('Новый отчет', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: newNameController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Название отчета',
            labelStyle: TextStyle(color: Colors.white70),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              final name = newNameController.text.isEmpty ? 'report_${DateTime.now().millisecondsSinceEpoch}' : newNameController.text;

              provider.createNewReport(name);
              _codeController.text = provider.currentDesign!.rfwCode;
              _reportNameController.text = provider.currentDesign!.name;
              Navigator.pop(context);

              setState(() {
                _consoleOutput = 'Создан новый отчет: $name';
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
            child: const Text('Создать', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _loadReport(ReportProvider provider, ReportDesign design) {
    provider.setCurrentDesign(design);
    _codeController.text = design.rfwCode;
    _reportNameController.text = design.name;

    setState(() {
      _consoleOutput = 'Загружен отчет: ${design.name}';
      _showDataEditor = false;
    });
  }

  void _saveDesign(ReportProvider provider) {
    if (provider.currentDesign != null) {
      provider.updateCurrentDesign(_codeController.text);
      setState(() {
        _consoleOutput = 'Отчет "${provider.currentDesign!.name}" сохранен в ${DateTime.now().toString()}';
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Отчет "${provider.currentDesign!.name}" сохранен'), backgroundColor: const Color(0xFF4CAF50)));
    }
  }

  void _updateReportName(ReportProvider provider, String newName) {
    if (provider.currentDesign != null && newName.isNotEmpty) {
      _reportNameController.text = newName;
    }
  }

  void _deleteReport(ReportProvider provider, String reportId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF3C3F41),
        title: const Text('Удалить отчет?', style: TextStyle(color: Colors.white)),
        content: const Text('Вы уверены, что хотите удалить этот отчет?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              provider.deleteReport(reportId);
              Navigator.pop(context);

              setState(() {
                _consoleOutput = 'Отчет удален';
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Удалить', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _runCode(ReportProvider provider) {
    if (provider.currentDesign != null) {
      final isValid = RfwService.validateCode(provider.currentDesign!.rfwCode);
      setState(() {
        _consoleOutput = isValid ? '✅ Код валиден!\nОтчет готов к использованию\n${DateTime.now().toString()}' : '❌ Ошибка валидации кода\nПроверьте синтаксис RFW';
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_consoleScrollController.hasClients) {
          _consoleScrollController.animateTo(_consoleScrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        }
      });
    }
  }

  void _showTemplatesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF3C3F41),
        title: const Text('Выберите шаблон', style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: 500,
          height: 450,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _buildTemplateItem('Простой отчет', 'simple'),
                    _buildTemplateItem('Карточный отчет', 'card'),
                    _buildTemplateItem('Табличный отчет', 'table'),
                    _buildTemplateItem('Статистический отчет', 'stats'),
                    _buildTemplateItem('Список задач', 'list'),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(String title, String templateKey) {
    return Card(
      color: const Color(0xFF4C4C4C),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.description, color: Colors.white70),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text('С тестовыми данными', style: const TextStyle(color: Colors.white54)),
        onTap: () {
          final provider = Provider.of<ReportProvider>(context, listen: false);
          _createNewReportWithTemplate(provider, title, templateKey);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _createNewReportWithTemplate(ReportProvider provider, String name, String templateKey) {
    final template = ReportTemplates.allTemplates[templateKey] ?? ReportTemplates.simpleReport;
    final data = ReportTemplates.allTemplateData[templateKey] ?? ReportTemplates.simpleReportData;

    final reportName = '${name}_${DateTime.now().millisecondsSinceEpoch}';
    provider.createNewReport(reportName, template: template, testData: data);
    _codeController.text = provider.currentDesign!.rfwCode;
    _reportNameController.text = provider.currentDesign!.name;

    setState(() {
      _consoleOutput = 'Создан новый отчет из шаблона: $name';
      _showDataEditor = true;
    });
  }

  Widget _buildCodeEditor() {
    return Consumer<ReportProvider>(
      builder: (context, provider, child) {
        return Container(
          color: const Color(0xFF2B2B2B),
          child: Column(
            children: [
              _buildEditorHeader(provider),
              Expanded(
                child: Stack(
                  children: [
                    if (provider.currentDesign != null)
                      CodeTheme(
                        data: CodeThemeData(styles: darculaTheme),
                        child: Container(color: const Color(0xFF2B2B2B), child: _buildInteractiveCodeField()),
                      ),
                    if (provider.currentDesign == null)
                      Container(
                        color: const Color(0xFF2B2B2B),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.code, size: 64, color: Colors.white30),
                              const SizedBox(height: 16),
                              const Text(
                                'Создайте новый отчет\nили выберите существующий',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white54, fontSize: 16),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () => _createNewReport(provider),
                                icon: const Icon(Icons.add),
                                label: const Text('Создать отчет'),
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50), foregroundColor: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColorSidebar() {
    return Positioned(
      right: 8, // Отступ от края
      top: 50, // Отступ сверху чтобы не перекрывать заголовок
      bottom: 8, // Отступ снизу
      child: Container(
        width: 70, // Немного шире для формата 0xFFFFFFFF
        decoration: BoxDecoration(
          color: const Color(0xFF3C3F41).withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white54, width: 1),
        ),
        child: Column(
          children: [
            // Заголовок панели цветов
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF4C4C4C),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              child: const Text(
                'Цвета',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: _colorHighlights.isEmpty
                  ? const Center(
                      child: Text('Нет цветов', style: TextStyle(color: Colors.white54, fontSize: 10)),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(8),
                      children: _colorHighlights.keys.map((color) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () => _showColorPickerDialog(color),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: ColorService.getColorFromHex(color),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.white54, width: 1),
                              ),
                              height: 40,
                              child: Tooltip(
                                message: 'Нажмите чтобы изменить цвет\n$color',
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      color.replaceAll('0xFF', ''),
                                      style: TextStyle(fontSize: 8, color: _getContrastColor(ColorService.getColorFromHex(color)), fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      ColorService.convertToHexFormat(color),
                                      style: TextStyle(fontSize: 7, color: _getContrastColor(ColorService.getColorFromHex(color))),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPickerDialog(String currentColor) {
    showDialog(
      context: context,
      builder: (context) => ColorPickerDialog(
        selectedColor: currentColor,
        onColorSelected: (newColor) {
          _replaceAllColorOccurrences(currentColor, newColor);
        },
      ),
    );
  }

  Color _getContrastColor(Color? backgroundColor) {
    if (backgroundColor == null) return Colors.black;

    // Вычисляем яркость цвета
    final brightness = backgroundColor.computeLuminance();

    // Возвращаем белый для темных цветов, черный для светлых
    return brightness > 0.5 ? Colors.black : Colors.white;
  }

  Widget _buildInteractiveCodeField() {
    return Stack(
      children: [
        CodeField(
          key: _codeFieldKey,
          controller: _codeController,
          textStyle: const TextStyle(fontFamily: 'Monospace', fontSize: 14, height: 1.5),
          lineNumberStyle: const LineNumberStyle(margin: 8, textStyle: TextStyle(color: Colors.white54)),
          decoration: BoxDecoration(
            color: const Color(0xFF2B2B2B),
            border: Border.all(color: Colors.transparent),
          ),
          expands: true,
        ),
        // Боковая панель с цветами
        if (_colorHighlights.isNotEmpty) _buildColorSidebar(),
      ],
    );
  }

  Widget _buildSimpleColorHighlights() {
    return IgnorePointer(
      child: Container(
        color: Colors.transparent,
        child: CustomPaint(
          painter: ColorHighlightsPainter(codeController: _codeController, colorHighlights: _colorHighlights),
        ),
      ),
    );
  }

  void _replaceAllColorOccurrences(String oldColor, String newColor) {
    final text = _codeController.text;
    // Заменяем без кавычек
    final newText = text.replaceAll(oldColor, newColor);
    _codeController.value = _codeController.value.copyWith(text: newText, selection: TextSelection.collapsed(offset: 0));
  }

  // Widget _buildColorOverlays() {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       return SingleChildScrollView(
  //         child: ConstrainedBox(
  //           constraints: BoxConstraints(minHeight: constraints.maxHeight),
  //           child: Stack(children: _createColorOverlays()),
  //         ),
  //       );
  //     },
  //   );
  // }

  // List<Widget> _createColorOverlays() {
  //   final overlays = <Widget>[];
  //   final text = _codeController.text;
  //   final lines = text.split('\n');

  //   double currentTop = 0;
  //   const lineHeight = 21.0; // Примерная высота строки

  //   for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
  //     final line = lines[lineIndex];
  //     final colorRegex = RegExp(r'"color":\s*"(#[\dA-Fa-f]{6})"');
  //     final matches = colorRegex.allMatches(line);

  //     for (final match in matches) {
  //       final color = match.group(1)!;
  //       final start = match.start;
  //       final end = match.end;

  //       // Примерное позиционирование (упрощенное)
  //       final left = start * 8.0; // Примерная ширина символа
  //       final width = (end - start) * 8.0;

  //       overlays.add(
  //         Positioned(
  //           left: left,
  //           top: currentTop + 4,
  //           child: GestureDetector(
  //             onTap: () => _showColorPickerForText(color, lineIndex, start, end),
  //             child: Container(
  //               width: width,
  //               height: lineHeight - 8,
  //               decoration: BoxDecoration(
  //                 color: Colors.transparent,
  //                 border: Border.all(color: Colors.yellow.withOpacity(0.5), width: 1),
  //                 borderRadius: BorderRadius.circular(2),
  //               ),
  //               child: Tooltip(
  //                 message: 'Нажмите для выбора цвета',
  //                 child: Container(
  //                   margin: const EdgeInsets.all(1),
  //                   decoration: BoxDecoration(color: ColorService.getColorFromHex(color)?.withOpacity(0.3), borderRadius: BorderRadius.circular(1)),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     }

  //     currentTop += lineHeight;
  //   }

  //   return overlays;
  // }

  void _showColorPickerForText(String currentColor, int lineIndex, int start, int end) {
    showDialog(
      context: context,
      builder: (context) => ColorPickerDialog(
        selectedColor: currentColor,
        onColorSelected: (newColor) {
          _replaceColorInCode(lineIndex, start, end, newColor);
        },
      ),
    );
  }

  void _replaceColorInCode(int lineIndex, int start, int end, String newColor) {
    final text = _codeController.text;
    final lines = text.split('\n');

    if (lineIndex < lines.length) {
      final line = lines[lineIndex];
      final newLine = line.substring(0, start) + '"$newColor"' + line.substring(end);
      lines[lineIndex] = newLine;

      final newText = lines.join('\n');
      _codeController.value = _codeController.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: start + newColor.length + 2),
      );
    }
  }
}

class ColorHighlightsPainter extends CustomPainter {
  final CodeController codeController;
  final Map<String, String> colorHighlights;

  ColorHighlightsPainter({required this.codeController, required this.colorHighlights});

  @override
  void paint(Canvas canvas, Size size) {
    final text = codeController.text;
    final colorRegex = RegExp(r'"color":\s*"(#[\dA-Fa-f]{6})"');
    final matches = colorRegex.allMatches(text);

    final paint = Paint()
      ..color = Colors.yellow.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (final match in matches) {
      final colorValue = match.group(1)!;

      // Упрощенная отрисовка - просто показываем полосы справа
      final color = ColorService.getColorFromHex(colorValue);
      if (color != null) {
        final colorPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

        // Рисуем цветной индикатор справа
        final indicatorRect = Rect.fromLTWH(size.width - 30, 20 + matches.toList().indexOf(match) * 25, 20, 20);

        canvas.drawRect(indicatorRect, colorPaint);
        canvas.drawRect(indicatorRect, paint);

        // Добавляем текст с hex-кодом
        final paragraph = _buildTextParagraph(colorValue, size.width - 80);
        paragraph.layout(const ParagraphConstraints(width: 50));
        canvas.drawParagraph(paragraph, Offset(size.width - 75, 20 + matches.toList().indexOf(match) * 25));
      }
    }
  }

  Paragraph _buildTextParagraph(String text, double maxWidth) {
    final builder = ParagraphBuilder(ParagraphStyle(fontSize: 10, fontFamily: 'Monospace', textAlign: TextAlign.left))
      ..pushStyle(TextStyle(color: Colors.white, fontSize: 10).getTextStyle())
      ..addText(text);

    return builder.build();
  }

  @override
  bool shouldRepaint(covariant ColorHighlightsPainter oldDelegate) {
    return codeController.text != oldDelegate.codeController.text || colorHighlights != oldDelegate.colorHighlights;
  }
}
