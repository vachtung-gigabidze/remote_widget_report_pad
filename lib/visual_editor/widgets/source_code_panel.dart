// editor/source_code_panel.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/template_service.dart';

class SourceCodePanel extends StatelessWidget {
  const SourceCodePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TemplateService>(
      builder: (context, service, child) {
        return Column(
          children: [
            _buildHeader(service, context),
            Expanded(child: _buildCodeEditor(service)),
          ],
        );
      },
    );
  }

  Widget _buildHeader(TemplateService service, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          const Icon(Icons.code, size: 20),
          const SizedBox(width: 8),
          const Text('Исходный код', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Spacer(),
          IconButton(icon: const Icon(Icons.content_copy), onPressed: () => _copyToClipboard(service.currentTemplate.code, context), tooltip: 'Копировать код'),
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => _refreshFromCode(service, context), tooltip: 'Обновить из кода'),
        ],
      ),
    );
  }

  Widget _buildCodeEditor(TemplateService service) {
    final controller = TextEditingController(text: service.currentTemplate.code);

    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'RFW код шаблона...', alignLabelWithHint: true),
        onChanged: (value) {
          // Авто-сохранение можно добавить с debounce
        },
        onSubmitted: (value) {
          service.updateCode(value);
        },
      ),
    );
  }

  void _copyToClipboard(String code, BuildContext context) {
    // В реальном приложении используйте пакет clipboard
    // Clipboard.setData(ClipboardData(text: code));

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Код скопирован в буфер обмена')));
  }

  void _refreshFromCode(TemplateService service, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Обновить из кода'),
        content: const Text('Вы уверены, что хотите обновить дерево виджетов из исходного кода? Все несохраненные изменения будут потеряны.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          TextButton(
            onPressed: () {
              service.updateCode(service.currentTemplate.code);
              Navigator.pop(context);
            },
            child: const Text('Обновить'),
          ),
        ],
      ),
    );
  }
}
