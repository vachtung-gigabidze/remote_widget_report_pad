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
  // static const Map<String, String> allTemplates = {'simple': simpleReport, 'card': cardReport, 'table': tableReport, 'stats': statsReport, 'list': listReport, 'textExamples': textExamples};

  // static const Map<String, Map<String, dynamic>> allTemplateData = {
  //   'simple': simpleReportData,
  //   'card': cardReportData,
  //   'table': tableReportData,
  //   'stats': statsReportData,
  //   'list': listReportData,
  //   'textExamples': textExamplesData,
  // };

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

  static const String advancedLayout = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    mainAxisAlignment: "start",
    crossAxisAlignment: "center",
    children: [
      Text(
        text: "Расширенная верстка",
        style: {
          "fontSize": 24.0,
          "fontWeight": "bold",
          "color": 0xFF2C3E50,
        },
      ),
      SizedBox(height: 20.0),
      
      // Row с разным выравниванием
      Container(
        width: "infinity",
        padding: [12.0, 12.0, 12.0, 12.0],
        decoration: {
          "color": 0xFFF5F5F5,
          "borderRadius": 8.0,
          "border": [
            {
              "width": 2.0,
              "color": 0xFF2196F3,
            }
          ],
        },
        child: Column(
          children: [
            Text(
              text: "Row с MainAxisAlignment",
              style: {
                "fontSize": 16.0,
                "fontWeight": "bold",
              },
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: "spaceBetween",
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: 0xFFFF5252,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: 0xFF4CAF50,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: 0xFF2196F3,
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      
      // Expanded и Flex
      Container(
        width: "infinity",
        height: 100.0,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: 0xFFFF9800,
                child: Center(
                  child: Text(
                    text: "Flex: 2",
                    style: {
                      "color": 0xFFFFFFFF,
                      "fontWeight": "bold",
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: 0xFF2196F3,
                child: Center(
                  child: Text(
                    text: "Flex: 3",
                    style: {
                      "color": 0xFFFFFFFF,
                      "fontWeight": "bold",
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      
      // Stack с позиционированием
      Container(
        width: 200.0,
        height: 120.0,
        child: Stack(
          children: [
            Container(
              width: "infinity",
              height: "infinity",
              color: 0xFFE3F2FD,
            ),
            Positioned(
              left: 10.0,
              top: 10.0,
              child: Container(
                width: 60.0,
                height: 60.0,
                color: 0xFFFF5252,
              ),
            ),
            Positioned(
              right: 10.0,
              bottom: 10.0,
              child: Container(
                width: 60.0,
                height: 60.0,
                color: 0xFF4CAF50,
              ),
            ),
            Align(
              alignment: {"x": 0.5, "y": 0.5},
              child: Container(
                width: 40.0,
                height: 40.0,
                color: 0xFFFFEB3B,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);
''';

  static const String decorationExamples = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    children: [
      Text(
        text: "Примеры декораций",
        style: {
          "fontSize": 24.0,
          "fontWeight": "bold",
          "color": 0xFF2C3E50,
        },
      ),
      SizedBox(height: 20.0),
      
      // BoxDecoration с градиентом
      Container(
        width: 200.0,
        height: 100.0,
        decoration: {
          "type": "box",
          "gradient": {
            "type": "linear",
            "begin": {"x": 0.0, "y": 0.0},
            "end": {"x": 1.0, "y": 1.0},
            "colors": [0xFFFF5252, 0xFFFF9800, 0xFF4CAF50],
            "stops": [0.0, 0.5, 1.0],
          },
          "borderRadius": [12.0, 12.0, 12.0, 12.0],
          "boxShadow": [
            {
              "blurRadius": 8.0,
              "offset": {"dx": 2.0, "dy": 2.0},
              "color": 0x33000000,
            },
          ],
        },
        child: Center(
          child: Text(
            text: "Линейный градиент",
            style: {
              "color": 0xFFFFFFFF,
              "fontWeight": "bold",
            },
          ),
        ),
      ),
      SizedBox(height: 16.0),
      
      // RoundedRectangleBorder
      Container(
        width: 200.0,
        height: 80.0,
        decoration: {
          "type": "shape",
          "shape": {
            "type": "rounded",
            "borderRadius": [20.0, 20.0, 20.0, 20.0],
          },
          "color": 0xFF2196F3,
        },
        child: Center(
          child: Text(
            text: "Rounded Border",
            style: {
              "color": 0xFFFFFFFF,
            },
          ),
        ),
      ),
      SizedBox(height: 16.0),
      
      // Border с разными сторонами
      Container(
        width: 200.0,
        height: 80.0,
        decoration: {
          "type": "box",
          "color": 0xFFE8F5E8,
          "border": [
            {
              "width": 4.0,
              "color": 0xFF4CAF50,
            },
            {
              "width": 2.0,
              "color": 0xFF81C784,
            },
            {
              "width": 4.0,
              "color": 0xFF4CAF50,
            },
            {
              "width": 2.0,
              "color": 0xFF81C784,
            },
          ],
        ),
        child: Center(
          child: Text(
            text: "Разные границы",
            style: {
              "color": 0xFF2E7D32,
            },
          ),
        ),
      ),
    ],
  ),
);
''';

  static const String typographyExamples = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    crossAxisAlignment: "start",
    children: [
      Text(
        text: "Типография и текст",
        style: {
          "fontSize": 24.0,
          "fontWeight": "bold",
          "color": 0xFF2C3E50,
        },
      ),
      SizedBox(height: 20.0),
      
      // Разные стили текста
      Text(
        text: "Обычный текст",
        style: {
          "fontSize": 16.0,
          "color": 0xFF000000,
        },
      ),
      SizedBox(height: 8.0),
      
      Text(
        text: "Жирный текст",
        style: {
          "fontSize": 16.0,
          "fontWeight": "bold",
          "color": 0xFFD32F2F,
        },
      ),
      SizedBox(height: 8.0),
      
      Text(
        text: "Курсивный текст",
        style: {
          "fontSize": 16.0,
          "fontStyle": "italic",
          "color": 0xFF1976D2,
        },
      ),
      SizedBox(height: 8.0),
      
      Text(
        text: "Подчеркнутый текст",
        style: {
          "fontSize": 16.0,
          "decoration": "underline",
          "color": 0xFF388E3C,
        },
      ),
      SizedBox(height: 8.0),
      
      Text(
        text: "Зачеркнутый текст",
        style: {
          "fontSize": 16.0,
          "decoration": "lineThrough",
          "color": 0xFFF57C00,
        },
      ),
      SizedBox(height: 16.0),
      
      // Текст с тенью
      Text(
        text: "Текст с тенью",
        style: {
          "fontSize": 20.0,
          "fontWeight": "bold",
          "color": 0xFFFFFFFF,
          "shadows": [
            {
              "blurRadius": 4.0,
              "offset": {"dx": 2.0, "dy": 2.0},
              "color": 0x66000000,
            },
          ],
        },
      ),
      SizedBox(height: 16.0),
      
      // Многострочный текст
      Container(
        width: 200.0,
        child: Text(
          text: "Это очень длинный текст, который должен переноситься на несколько строк для демонстрации работы текстового виджета",
          style: {
            "fontSize": 14.0,
            "color": 0xFF666666,
          },
          textAlign: "center",
        ),
      ),
      SizedBox(height: 16.0),
      
      // Rich Text (через конкатенацию)
      Text(
        text: [
          "Обычный текст, ",
          "жирный текст",
        ],
        style: {
          "fontSize": 16.0,
        },
      ),
    ],
  ),
);
''';

  static const String interactiveExamples = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    children: [
      Text(
        text: "Интерактивные элементы",
        style: {
          "fontSize": 24.0,
          "fontWeight": "bold",
          "color": 0xFF2C3E50,
        },
      ),
      SizedBox(height: 20.0),
      
      // Кнопки
      Row(
        mainAxisAlignment: "spaceAround",
        children: [
          ElevatedButton(
            onPressed: {
              "action": "showMessage",
              "args": {"message": "Primary кнопка нажата!"}
            },
            child: Text(text: "Primary"),
          ),
          OutlinedButton(
            onPressed: {
              "action": "showMessage", 
              "args": {"message": "Outlined кнопка нажата!"}
            },
            child: Text(text: "Outlined"),
          ),
          TextButton(
            onPressed: {
              "action": "showMessage",
              "args": {"message": "Text кнопка нажата!"}
            },
            child: Text(text: "Text"),
          ),
        ],
      ),
      SizedBox(height: 16.0),
      
      // Карточка с интерактивностью
      GestureDetector(
        onTap: {
          "action": "showMessage",
          "args": {"message": "Карточка нажата!"}
        },
        child: Container(
          width: 200.0,
          height: 100.0,
          decoration: {
            "color": 0xFFE3F2FD,
            "borderRadius": 12.0,
            "boxShadow": [
              {
                "blurRadius": 6.0,
                "offset": {"dx": 0.0, "dy": 2.0},
                "color": 0x33000000,
              },
            ],
          },
          child: Center(
            child: Column(
              mainAxisAlignment: "center",
              children: [
                Icon(
                  icon: {
                    "icon": 0xe5d5,
                    "fontFamily": "MaterialIcons"
                  },
                  color: 0xFF2196F3,
                  size: 32.0,
                ),
                Text(
                  text: "Нажми меня",
                  style: {
                    "color": 0xFF1976D2,
                    "fontWeight": "bold",
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 16.0),
      
      // Индикатор прогресса
      Column(
        children: [
          Text(
            text: "Линейный прогресс",
            style: {
              "fontSize": 14.0,
              "color": 0xFF666666,
            },
          ),
          SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: 0.7,
            backgroundColor: 0xFFE0E0E0,
            valueColor: 0xFF4CAF50,
          ),
          SizedBox(height: 16.0),
          Text(
            text: "Круговой прогресс",
            style: {
              "fontSize": 14.0,
              "color": 0xFF666666,
            },
          ),
          SizedBox(height: 8.0),
          CircularProgressIndicator(
            value: 0.5,
            backgroundColor: 0xFFE0E0E0,
            valueColor: 0xFF2196F3,
          ),
        ],
      ),
    ],
  ),
);
''';

  static const String gridExamples = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  child: Column(
    children: [
      Text(
        text: "Сетки и списки",
        style: {
          "fontSize": 24.0,
          "fontWeight": "bold",
          "color": 0xFF2C3E50,
        },
      ),
      SizedBox(height: 20.0),
      
      // GridView
      Container(
        height: 200.0,
        child: GridView(
          gridDelegate: {
            "type": "fixedCrossAxisCount",
            "crossAxisCount": 3,
            "crossAxisSpacing": 8.0,
            "mainAxisSpacing": 8.0,
          },
          children: [
            Container(color: 0xFFFF5252, child: Center(child: Text(text: "1"))),
            Container(color: 0xFFFF9800, child: Center(child: Text(text: "2"))),
            Container(color: 0xFFFFEB3B, child: Center(child: Text(text: "3"))),
            Container(color: 0xFF4CAF50, child: Center(child: Text(text: "4"))),
            Container(color: 0xFF2196F3, child: Center(child: Text(text: "5"))),
            Container(color: 0xFF9C27B0, child: Center(child: Text(text: "6"))),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      
      // ListView
      Container(
        height: 150.0,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(icon: {"icon": 0xe5d5, "fontFamily": "MaterialIcons"}, color: 0xFF4CAF50),
              title: Text(text: "Первая строка"),
              subtitle: Text(text: "Подзаголовок первой строки"),
            ),
            ListTile(
              leading: Icon(icon: {"icon": 0xe8e5, "fontFamily": "MaterialIcons"}, color: 0xFF2196F3),
              title: Text(text: "Вторая строка"),
              subtitle: Text(text: "Подзаголовок второй строки"),
            ),
            ListTile(
              leading: Icon(icon: {"icon": 0xe615, "fontFamily": "MaterialIcons"}, color: 0xFFFF9800),
              title: Text(text: "Третья строка"),
              subtitle: Text(text: "Подзаголовок третьей строки"),
            ),
          ],
        ),
      ),
    ],
  ),
);
''';

  static const String complexLayout = '''
import core.widgets;

widget root = Container(
  padding: [16.0, 16.0, 16.0, 16.0],
  decoration: {
    "type": "box",
    "gradient": {
      "type": "linear",
      "begin": {"x": 0.0, "y": 0.0},
      "end": {"x": 1.0, "y": 1.0},
      "colors": [0xFFE3F2FD, 0xFFF3E5F5],
    },
  },
  child: Column(
    children: [
      // Заголовок с иконкой
      Row(
        mainAxisAlignment: "center",
        children: [
          Icon(
            icon: {"icon": 0xe869, "fontFamily": "MaterialIcons"},
            color: 0xFF7B1FA2,
            size: 32.0,
          ),
          SizedBox(width: 8.0),
          Text(
            text: "Комплексный макет",
            style: {
              "fontSize": 28.0,
              "fontWeight": "bold",
              "color": 0xFF7B1FA2,
              "shadows": [
                {
                  "blurRadius": 2.0,
                  "offset": {"dx": 1.0, "dy": 1.0},
                  "color": 0x33FFFFFF,
                },
              ],
            },
          ),
        ],
      ),
      SizedBox(height: 24.0),
      
      // Карточки в Wrap
      Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: "center",
        children: [
          _buildFeatureCard("Быстро", "Высокая производительность", 0xFFFF5252),
          _buildFeatureCard("Надежно", "Стабильная работа", 0xFF4CAF50),
          _buildFeatureCard("Удобно", "Простой интерфейс", 0xFF2196F3),
          _buildFeatureCard("Гибко", "Настройка под задачи", 0xFFFF9800),
        ],
      ),
      SizedBox(height: 24.0),
      
      // Статистика в Row
      Container(
        width: "infinity",
        padding: [16.0, 16.0, 16.0, 16.0],
        decoration: {
          "type": "box",
          "color": 0x22FFFFFF,
          "borderRadius": 12.0,
          "border": [
            {
              "width": 1.0,
              "color": 0x33FFFFFF,
            }
          ],
        },
        child: Row(
          mainAxisAlignment: "spaceAround",
          children: [
            _buildStatItem("Пользователи", "1.2K", 0xFF4CAF50),
            _buildStatItem("Задачи", "356", 0xFF2196F3),
            _buildStatItem("Проекты", "89", 0xFFFF9800),
          ],
        ),
      ),
    ],
  ),
);

widget _buildFeatureCard = Container(
  width: 150.0,
  padding: [16.0, 16.0, 16.0, 16.0],
  decoration: {
    "type": "box",
    "color": 0xFFFFFFFF,
    "borderRadius": 12.0,
    "boxShadow": [
      {
        "blurRadius": 8.0,
        "offset": {"dx": 0.0, "dy": 4.0},
        "color": 0x1A000000,
      },
    ],
  },
  child: Column(
    children: [
      Container(
        width: 48.0,
        height: 48.0,
        decoration: {
          "type": "box",
          "color": [args.color],
          "shape": "circle",
        },
        child: Icon(
          icon: {"icon": 0xe5ca, "fontFamily": "MaterialIcons"},
          color: 0xFFFFFFFF,
          size: 24.0,
        ),
      ),
      SizedBox(height: 8.0),
      Text(
        text: [args.title],
        style: {
          "fontSize": 16.0,
          "fontWeight": "bold",
          "color": 0xFF2C3E50,
        },
        textAlign: "center",
      ),
      SizedBox(height: 4.0),
      Text(
        text: [args.description],
        style: {
          "fontSize": 12.0,
          "color": 0xFF666666,
        },
        textAlign: "center",
      ),
    ],
  ),
);

widget _buildStatItem = Column(
  children: [
    Text(
      text: [args.value],
      style: {
        "fontSize": 24.0,
        "fontWeight": "bold",
        "color": [args.color],
      },
    ),
    Text(
      text: [args.label],
      style: {
        "fontSize": 12.0,
        "color": 0xFF666666,
      },
    ),
  ],
);
''';

  // Тестовые данные для новых шаблонов
  static const Map<String, dynamic> advancedLayoutData = {"title": "Расширенная верстка"};

  static const Map<String, dynamic> decorationExamplesData = {"title": "Примеры декораций"};

  static const Map<String, dynamic> typographyExamplesData = {"title": "Типография и текст"};

  static const Map<String, dynamic> interactiveExamplesData = {"title": "Интерактивные элементы"};

  static const Map<String, dynamic> gridExamplesData = {"title": "Сетки и списки"};

  static const Map<String, dynamic> complexLayoutData = {"title": "Комплексный макет"};

  // Обновляем список всех шаблонов
  static const Map<String, String> allTemplates = {
    'simple': simpleReport,
    'card': cardReport,
    'table': tableReport,
    'stats': statsReport,
    'list': listReport,
    'textExamples': textExamples,
    'advancedLayout': advancedLayout,
    'decorationExamples': decorationExamples,
    'typographyExamples': typographyExamples,
    'interactiveExamples': interactiveExamples,
    'gridExamples': gridExamples,
    'complexLayout': complexLayout,
  };

  static const Map<String, Map<String, dynamic>> allTemplateData = {
    'simple': simpleReportData,
    'card': cardReportData,
    'table': tableReportData,
    'stats': statsReportData,
    'list': listReportData,
    'textExamples': textExamplesData,
    'advancedLayout': advancedLayoutData,
    'decorationExamples': decorationExamplesData,
    'typographyExamples': typographyExamplesData,
    'interactiveExamples': interactiveExamplesData,
    'gridExamples': gridExamplesData,
    'complexLayout': complexLayoutData,
  };
}
