import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class RfwService {
  static final Runtime _runtime = Runtime();
  static final DynamicContent _data = DynamicContent();
  static const LibraryName mainName = LibraryName(<String>['main']);
  static void initialize() {
    // Регистрируем стандартные библиотеки
    _runtime.update(const LibraryName(<String>['core', 'widgets']), createCoreWidgets());
  }

  static Widget createPreview(String rfwCode, {Map<String, dynamic> data = const {}}) {
    try {
      // Парсим и компилируем код
      final RemoteWidgetLibrary _remoteWidgets = parseLibraryFile(rfwCode);
      _runtime.update(mainName, _remoteWidgets);

      // Обновляем данные
      _data.update('data', data);

      return RemoteWidget(runtime: _runtime, data: _data, widget: const FullyQualifiedWidgetName(mainName, 'root'));
    } catch (e) {
      // Возвращаем виджет с ошибкой
      return ErrorWidget(rfwCode, e.toString());
    }
  }

  static bool validateCode(String rfwCode) {
    try {
      parseLibraryFile(rfwCode);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class ErrorWidget extends StatelessWidget {
  final String code;
  final String error;

  const ErrorWidget(this.code, this.error, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.error, color: Colors.red),
              const SizedBox(width: 8),
              const Text(
                'Ошибка компиляции RFW',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Ошибка: $error', style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 16),
          const Text('Код с ошибкой:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: SelectableText(
              code,
              style: const TextStyle(fontFamily: 'Monospace', fontSize: 10, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
