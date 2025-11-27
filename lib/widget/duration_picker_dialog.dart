import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DurationPickerDialog extends StatefulWidget {
  final Function(int years, int months, int days) onDurationChanged;

  const DurationPickerDialog({super.key, required this.onDurationChanged});

  @override
  State<DurationPickerDialog> createState() => _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<DurationPickerDialog> {
  int _selectedYear = 0;
  int _selectedMonth = 0;
  int _selectedDay = 0;

  Widget _buildPicker(String label, int count, Function(int) onChanged) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 100,
          width: 60,
          child: CupertinoPicker(
            itemExtent: 32,
            onSelectedItemChanged: onChanged,
            children: List.generate(
              count,
              (index) => Center(child: Text('$index')),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Choisir une durée"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildPicker("Ans", 100, (v) => _selectedYear = v),
          _buildPicker("Mois", 12, (v) => _selectedMonth = v),
          _buildPicker("Jours", 31, (v) => _selectedDay = v),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onDurationChanged(
              _selectedYear,
              _selectedMonth,
              _selectedDay,
            );
            Navigator.pop(context);
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
