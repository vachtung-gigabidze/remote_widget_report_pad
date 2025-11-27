import 'package:flutter/material.dart';
import '../services/color_service.dart';

class ColorPickerDialog extends StatefulWidget {
  final String? selectedColor;
  final ValueChanged<String> onColorSelected;

  const ColorPickerDialog({Key? key, this.selectedColor, required this.onColorSelected}) : super(key: key);

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  String? _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF3C3F41),
      title: const Text('Выберите цвет', style: TextStyle(color: Colors.white)),
      content: SizedBox(
        width: 400,
        height: 500,
        child: Column(
          children: [
            // Показать выбранный цвет
            if (_selectedColor != null)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(color: const Color(0xFF4C4C4C), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorService.getColorFromHex(_selectedColor!),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white54),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text('Выбран: $_selectedColor', style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            Expanded(child: ListView(children: [for (final group in ColorService.getColorGroups()) _buildColorGroup(group['name'] as String, group['colors'] as List<String>)])),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена', style: TextStyle(color: Colors.white70)),
        ),
        ElevatedButton(
          onPressed: _selectedColor != null
              ? () {
                  widget.onColorSelected(_selectedColor!);
                  Navigator.pop(context);
                }
              : null,
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
          child: const Text('Выбрать', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildColorGroup(String name, List<String> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            name,
            style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(spacing: 8, runSpacing: 8, children: colors.map((color) => _buildColorItem(color)).toList()),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildColorItem(String color) {
    final isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: ColorService.getColorFromHex(color),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: isSelected ? 3 : 1),
          boxShadow: [if (isSelected) BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 8, spreadRadius: 2)],
        ),
        child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
      ),
    );
  }
}
