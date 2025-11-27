class ReportTemplates {
  static const String simpleReport = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    crossAxisAlignment: "start",
    children: [
      Text(
        text: [data.data.title],
        style: {
          "fontSize": 24.0,
          "fontWeight": "bold",
          "color": 0xFF2C3E50,
        },
      ),
      SizedBox(height: 16.0),
      Text(
        text: [data.data.subtitle],
        style: {
          "fontSize": 16.0,
          "color": 0xFF7F8C8D,
        },
      ),
      SizedBox(height: 20.0),
      Container(
        decoration: {
          "color": 0xFFECF0F1,
          "borderRadius": 8.0,
        },
        padding: [12.0, 12.0, 12.0, 12.0],
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: "start",
                children: [
                  Text(
                    text: [data.data.metricTitle],
                    style: {
                      "fontSize": 16.0,
                      "fontWeight": "bold",
                    },
                  ),
                  Text(
                    text: [data.data.metricSubtitle],
                    style: {
                      "fontSize": 12.0,
                      "color": 0xFF7F8C8D,
                    },
                  ),
                ],
              ),
            ),
            Icon(
              icon: {
                "icon": 0xe5d5,
                "fontFamily": "MaterialIcons"
              },
              color: 0xFF27AE60,
              size: 24.0,
            ),
          ],
        ),
      ),
    ],
  ),
);
''';

  static const String cardReport = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    children: [
      Container(
        decoration: {
          "color": 0xFFFFFFFF,
          "borderRadius": 8.0,
          "boxShadow": [
            {
              "blurRadius": 4.0,
              "offset": {"dx": 0.0, "dy": 2.0},
              "color": 0x1A000000,
            },
          ],
        },
        padding: [16.0, 16.0, 16.0, 16.0],
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon: {
                    "icon": 0xe5d2,
                    "fontFamily": "MaterialIcons"
                  },
                  color: 0xFF2196F3,
                  size: 24.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  text: [data.data.cardTitle],
                  style: {
                    "fontSize": 20.0,
                    "fontWeight": "bold",
                  },
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text(
              text: [data.data.cardDescription],
              style: {
                "fontSize": 14.0,
                "color": 0xFF666666,
              },
            ),
            SizedBox(height: 16.0),
            Container(
              width: "infinity",
              height: 4.0,
              decoration: {
                "color": 0xFFE0E0E0,
                "borderRadius": 2.0,
              },
              child: Container(
                width: [data.data.progress],
                decoration: {
                  "color": 0xFF4CAF50,
                  "borderRadius": 2.0,
                },
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              text: ["Прогресс: ", data.data.progress],
              style: {
                "fontSize": 12.0,
                "color": 0xFF666666,
              },
            ),
          ],
        ),
      ),
    ],
  ),
);
''';

  static const String tableReport = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    children: [
      Row(
        children: [
          Icon(
            icon: {
              "icon": 0xe265,
              "fontFamily": "MaterialIcons"
            },
            color: 0xFF4CAF50,
            size: 28.0,
          ),
          SizedBox(width: 8.0),
          Text(
            text: [data.data.tableTitle],
            style: {
              "fontSize": 24.0,
              "fontWeight": "bold",
            },
          ),
        ],
      ),
      SizedBox(height: 20.0),
      Container(
        decoration: {
          "border": {"width": 1.0, "color": 0xFFE0E0E0},
          "borderRadius": 8.0,
        },
        child: Column(
          children: [
            // Заголовок таблицы
            Container(
              color: 0xFFF5F5F5,
              padding: [12.0, 12.0, 12.0, 12.0],
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      text: "Наименование",
                      style: {
                        "fontWeight": "bold",
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text: "Количество",
                      style: {
                        "fontWeight": "bold",
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text: "Сумма",
                      style: {
                        "fontWeight": "bold",
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Строка 1
            Container(
              padding: [12.0, 12.0, 12.0, 12.0],
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(text: [data.data.item1]),
                  ),
                  Expanded(
                    child: Text(text: [data.data.quantity1]),
                  ),
                  Expanded(
                    child: Text(text: [data.data.price1]),
                  ),
                ],
              ),
            ),
            // Строка 2
            Container(
              color: 0xFFFAFAFA,
              padding: [12.0, 12.0, 12.0, 12.0],
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(text: [data.data.item2]),
                  ),
                  Expanded(
                    child: Text(text: [data.data.quantity2]),
                  ),
                  Expanded(
                    child: Text(text: [data.data.price2]),
                  ),
                ],
              ),
            ),
            // Итого
            Container(
              color: 0xFFE8F5E8,
              padding: [12.0, 12.0, 12.0, 12.0],
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      text: "Итого:",
                      style: {
                        "fontWeight": "bold",
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text: [data.data.totalQuantity],
                      style: {
                        "fontWeight": "bold",
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text: [data.data.totalPrice],
                      style: {
                        "fontWeight": "bold",
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);
''';

  static const String statsReport = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    children: [
      Text(
        text: [data.data.reportTitle],
        style: {
          "fontSize": 24.0,
          "fontWeight": "bold",
          "color": 0xFF2C3E50,
        },
      ),
      SizedBox(height: 16.0),
      // Статистические карточки
      Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        children: [
          // Карточка 1
          Container(
            width: 150.0,
            decoration: {
              "color": 0xFFE3F2FD,
              "borderRadius": 12.0,
              "boxShadow": [
                {
                  "blurRadius": 6.0,
                  "offset": {"dx": 0.0, "dy": 2.0},
                  "color": 0x1A000000,
                },
              ],
            },
            padding: [16.0, 16.0, 16.0, 16.0],
            child: Column(
              children: [
                Icon(
                  icon: {
                    "icon": 0xe7e7,
                    "fontFamily": "MaterialIcons"
                  },
                  color: 0xFF1976D2,
                  size: 32.0,
                ),
                SizedBox(height: 8.0),
                Text(
                  text: [data.data.stat1Value],
                  style: {
                    "fontSize": 24.0,
                    "fontWeight": "bold",
                    "color": 0xFF1976D2,
                  },
                ),
                SizedBox(height: 4.0),
                Text(
                  text: [data.data.stat1Label],
                  style: {
                    "fontSize": 12.0,
                    "color": 0xFF546E7A,
                    "fontWeight": "bold",
                  },
                  textAlign: "center",
                ),
              ],
            ),
          ),
          // Карточка 2
          Container(
            width: 150.0,
            decoration: {
              "color": 0xFFE8F5E8,
              "borderRadius": 12.0,
              "boxShadow": [
                {
                  "blurRadius": 6.0,
                  "offset": {"dx": 0.0, "dy": 2.0},
                  "color": 0x1A000000,
                },
              ],
            },
            padding: [16.0, 16.0, 16.0, 16.0],
            child: Column(
              children: [
                Icon(
                  icon: {
                    "icon": 0xe8e5,
                    "fontFamily": "MaterialIcons"
                  },
                  color: 0xFF388E3C,
                  size: 32.0,
                ),
                SizedBox(height: 8.0),
                Text(
                  text: [data.data.stat2Value],
                  style: {
                    "fontSize": 24.0,
                    "fontWeight": "bold",
                    "color": 0xFF388E3C,
                  },
                ),
                SizedBox(height: 4.0),
                Text(
                  text: [data.data.stat2Label],
                  style: {
                    "fontSize": 12.0,
                    "color": 0xFF546E7A,
                    "fontWeight": "bold",
                  },
                  textAlign: "center",
                ),
              ],
            ),
          ),
          // Карточка 3
          Container(
            width: 150.0,
            decoration: {
              "color": 0xFFFFF3E0,
              "borderRadius": 12.0,
              "boxShadow": [
                {
                  "blurRadius": 6.0,
                  "offset": {"dx": 0.0, "dy": 2.0},
                  "color": 0x1A000000,
                },
              ],
            },
            padding: [16.0, 16.0, 16.0, 16.0],
            child: Column(
              children: [
                Icon(
                  icon: {
                    "icon": 0xe63a,
                    "fontFamily": "MaterialIcons"
                  },
                  color: 0xFFF57C00,
                  size: 32.0,
                ),
                SizedBox(height: 8.0),
                Text(
                  text: [data.data.stat3Value],
                  style: {
                    "fontSize": 24.0,
                    "fontWeight": "bold",
                    "color": 0xFFF57C00,
                  },
                ),
                SizedBox(height: 4.0),
                Text(
                  text: [data.data.stat3Label],
                  style: {
                    "fontSize": 12.0,
                    "color": 0xFF546E7A,
                    "fontWeight": "bold",
                  },
                  textAlign: "center",
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
);
''';

  static const String listReport = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    crossAxisAlignment: "start",
    children: [
      Row(
        children: [
          Icon(
            icon: {
              "icon": 0xe0b2,
              "fontFamily": "MaterialIcons"
            },
            color: 0xFF2196F3,
            size: 28.0,
          ),
          SizedBox(width: 8.0),
          Text(
            text: [data.data.listTitle],
            style: {
              "fontSize": 24.0,
              "fontWeight": "bold",
            },
          ),
        ],
      ),
      SizedBox(height: 16.0),
      Container(
        decoration: {
          "border": {"width": 1.0, "color": 0xFFE0E0E0},
          "borderRadius": 8.0,
        },
        child: Column(
          children: [
            // Элемент списка 1
            Container(
              padding: [12.0, 16.0, 12.0, 16.0],
              child: Row(
                children: [
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: {
                      "color": 0xFF4CAF50,
                      "shape": "circle",
                    },
                    child: Icon(
                      icon: {
                        "icon": 0xe5ca,
                        "fontFamily": "MaterialIcons"
                      },
                      color: 0xFFFFFFFF,
                      size: 16.0,
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      text: [data.data.task1],
                      style: {
                        "fontSize": 16.0,
                      },
                    ),
                  ),
                  Text(
                    text: [data.data.status1],
                    style: {
                      "fontSize": 12.0,
                      "color": 0xFF4CAF50,
                    },
                  ),
                ],
              ),
            ),
            // Разделитель
            Container(height: 1.0, color: 0xFFF0F0F0),
            // Элемент списка 2
            Container(
              padding: [12.0, 16.0, 12.0, 16.0],
              child: Row(
                children: [
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: {
                      "color": 0xFFFF9800,
                      "shape": "circle",
                    },
                    child: Icon(
                      icon: {
                        "icon": 0xe615,
                        "fontFamily": "MaterialIcons"
                      },
                      color: 0xFFFFFFFF,
                      size: 16.0,
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      text: [data.data.task2],
                      style: {
                        "fontSize": 16.0,
                      },
                    ),
                  ),
                  Text(
                    text: [data.data.status2],
                    style: {
                      "fontSize": 12.0,
                      "color": 0xFFFF9800,
                    },
                  ),
                ],
              ),
            ),
            // Разделитель
            Container(height: 1.0, color: 0xFFF0F0F0),
            // Элемент списка 3
            Container(
              padding: [12.0, 16.0, 12.0, 16.0],
              child: Row(
                children: [
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: {
                      "color": 0xFFF44336,
                      "shape": "circle",
                    },
                    child: Icon(
                      icon: {
                        "icon": 0xe033,
                        "fontFamily": "MaterialIcons"
                      },
                      color: 0xFFFFFFFF,
                      size: 16.0,
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      text: [data.data.task3],
                      style: {
                        "fontSize": 16.0,
                      },
                    ),
                  ),
                  Text(
                    text: [data.data.status3],
                    style: {
                      "fontSize": 12.0,
                      "color": 0xFFF44336,
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);
''';

  // Создаем шаблон с примерами конкатенации текста
  static const String textExamples = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    crossAxisAlignment: "start",
    children: [
      Text(
        text: "Примеры работы с текстом",
        style: {
          "fontSize": 20.0,
          "fontWeight": "bold",
          "color": 0xFF2C3E50,
        },
      ),
      SizedBox(height: 16.0),
      
      // Простой текст
      Text(
        text: "Простой текст",
        style: {
          "fontSize": 16.0,
        },
      ),
      SizedBox(height: 8.0),
      
      // Конкатенация строк
      Text(
        text: ["Текст из ", "нескольких ", "частей"],
        style: {
          "fontSize": 16.0,
          "color": 0xFF2196F3,
        },
      ),
      SizedBox(height: 8.0),
      
      // Текст с данными
      Text(
        text: ["Значение: ", [data.data.value]],
        style: {
          "fontSize": 16.0,
          "fontWeight": "bold",
        },
      ),
      SizedBox(height: 8.0),
      
      // Многострочный текст
      Text(
        text: "Это многострочный текст, который будет автоматически переноситься на новую строку при необходимости",
        style: {
          "fontSize": 14.0,
          "color": 0xFF666666,
        },
      ),
      SizedBox(height: 16.0),
      
      // Примеры иконок
      Row(
        children: [
          Icon(
            icon: {
              "icon": 0xe5d5, // trending_up
              "fontFamily": "MaterialIcons"
            },
            color: 0xFF4CAF50,
            size: 24.0,
          ),
          SizedBox(width: 8.0),
          Text(
            text: ["Иконка: ", "trending_up"],
            style: {
              "fontSize": 14.0,
            },
          ),
        ],
      ),
      SizedBox(height: 8.0),
      
      Row(
        children: [
          Icon(
            icon: {
              "icon": 0xe8e5, // check_circle
              "fontFamily": "MaterialIcons"
            },
            color: 0xFF2196F3,
            size: 24.0,
          ),
          SizedBox(width: 8.0),
          Text(
            text: ["Иконка: ", "check_circle"],
            style: {
              "fontSize": 14.0,
            },
          ),
        ],
      ),
    ],
  ),
);
''';

  // Тестовые данные
  static const Map<String, dynamic> simpleReportData = {
    "title": "Финансовый отчет 2024",
    "subtitle": "Годовой отчет по основным показателям",
    "metricTitle": "Основные показатели",
    "metricSubtitle": "Успешное выполнение плана на 95%",
  };

  static const Map<String, dynamic> cardReportData = {"cardTitle": "Прогресс выполнения проекта", "cardDescription": "Разработка мобильного приложения", "progress": "75%"};

  static const Map<String, dynamic> tableReportData = {
    "tableTitle": "Отчет по продажам за квартал",
    "item1": "Ноутбуки Dell XPS",
    "quantity1": "15 шт.",
    "price1": "750,000 ₽",
    "item2": "Мониторы Samsung",
    "quantity2": "8 шт.",
    "price2": "160,000 ₽",
    "totalQuantity": "23 шт.",
    "totalPrice": "910,000 ₽",
  };

  static const Map<String, dynamic> statsReportData = {
    "reportTitle": "Ключевые метрики компании",
    "stat1Value": "1,250",
    "stat1Label": "Новых клиентов",
    "stat2Value": "94%",
    "stat2Label": "Удовлетворенность",
    "stat3Value": "45%",
    "stat3Label": "Рост прибыли",
  };

  static const Map<String, dynamic> listReportData = {
    "listTitle": "Статус выполнения задач",
    "task1": "Разработка интерфейса",
    "status1": "Выполнено",
    "task2": "Тестирование функционала",
    "status2": "В процессе",
    "task3": "Документация проекта",
    "status3": "Ожидание",
  };

  static const Map<String, dynamic> textExamplesData = {"value": "12345"};

  // Дополнительные шаблоны
  static const Map<String, String> allTemplates = {'simple': simpleReport, 'card': cardReport, 'table': tableReport, 'stats': statsReport, 'list': listReport, 'textExamples': textExamples};

  static const Map<String, Map<String, dynamic>> allTemplateData = {
    'simple': simpleReportData,
    'card': cardReportData,
    'table': tableReportData,
    'stats': statsReportData,
    'list': listReportData,
    'textExamples': textExamplesData,
  };

  // Коды Material Icons для справки
  static const Map<String, int> materialIcons = {
    'trending_up': 0xe5d5,
    'check': 0xe5ca,
    'schedule': 0xe615,
    'pending': 0xe033,
    'dashboard': 0xe5d2,
    'assessment': 0xe265,
    'list_alt': 0xe0b2,
    'person': 0xe7e7,
    'check_circle': 0xe8e5,

    'attach_money': 0xe63a,
  };
}
