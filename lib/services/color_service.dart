import 'package:flutter/material.dart';

class ColorService {
  static final Map<String, Color> colorMap = {
    '0xFFF44336': Colors.red,
    '0xFFE91E63': Colors.pink,
    '0xFF9C27B0': Colors.purple,
    '0xFF673AB7': Colors.deepPurple,
    '0xFF3F51B5': Colors.indigo,
    '0xFF2196F3': Colors.blue,
    '0xFF03A9F4': Colors.lightBlue,
    '0xFF00BCD4': Colors.cyan,
    '0xFF009688': Colors.teal,
    '0xFF4CAF50': Colors.green,
    '0xFF8BC34A': Colors.lightGreen,
    '0xFFCDDC39': Colors.lime,
    '0xFFFFEB3B': Colors.yellow,
    '0xFFFFC107': Colors.amber,
    '0xFFFF9800': Colors.orange,
    '0xFFFF5722': Colors.deepOrange,
    '0xFF795548': Colors.brown,
    '0xFF9E9E9E': Colors.grey,
    '0xFF607D8B': Colors.blueGrey,
    '0xFF000000': Colors.black,
    '0xFFFFFFFF': Colors.white,
  };

  static Color? getColorFromHex(String hexColor) {
    return colorMap[hexColor.toUpperCase()];
  }

  static List<Map<String, dynamic>> getColorGroups() {
    return [
      {
        'name': 'Красные',
        'colors': ['0xFFF44336', '0xFFE91E63', '0xFFFF5252', '0xFFFF1744'],
      },
      {
        'name': 'Фиолетовые',
        'colors': ['0xFF9C27B0', '0xFF673AB7', '0xFF3F51B5', '0xFF2196F3'],
      },
      {
        'name': 'Синие',
        'colors': ['0xFF03A9F4', '0xFF00BCD4', '0xFF009688', '0xFF4CAF50'],
      },
      {
        'name': 'Зеленые',
        'colors': ['0xFF8BC34A', '0xFFCDDC39', '0xFFFFEB3B', '0xFFFFC107'],
      },
      {
        'name': 'Оранжевые',
        'colors': ['0xFFFF9800', '0xFFFF5722', '0xFF795548', '0xFF9E9E9E'],
      },
    ];
  }

  static String convertToHexFormat(String flutterColor) {
    if (flutterColor.startsWith('0xFF')) {
      // Конвертируем 0xFFRRGGBB в #RRGGBB
      final hex = flutterColor.replaceFirst('0xFF', '');
      return '#$hex';
    }
    return flutterColor;
  }
}
