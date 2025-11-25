import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Retourne un sélecteur de date et met à jour le contrôleur et la valeur.
///
/// * **ctrl** : le [TextEditingController] du champ texte à mettre à jour.
/// * **onPicked** : callback exécuté avec la [DateTime] sélectionnée.
///
/// La fonction ne fait rien si l’utilisateur annule le sélecteur.
///

class TapInputWideget extends StatefulWidget {
  final String nameInput;
  final TextEditingController nameController;
  final DateTime? startDateTime;
  final ValueChanged<DateTime> onDateSelected;
  const TapInputWideget({
    super.key,
    required this.nameInput,
    required this.nameController,
    required this.onDateSelected,
    this.startDateTime,
  });

  @override
  State<TapInputWideget> createState() => _TapInputWidegetState();
}

class _TapInputWidegetState extends State<TapInputWideget> {
  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      locale: const Locale('fr', 'FR'),
      initialDate: widget.startDateTime != null
          ? DateTime(
              widget.startDateTime!.year,
              widget.startDateTime!.month,
              widget.startDateTime!.day + 1,
            )
          : DateTime.now(),
      firstDate: widget.startDateTime != null
          ? DateTime(
              widget.startDateTime!.year,
              widget.startDateTime!.month,
              widget.startDateTime!.day + 1,
            )
          : DateTime(1960),
      lastDate: DateTime(2050),
    );
    if (date != null) {
      widget.nameController.text = DateFormat.yMd('fr').format(date);
      widget.onDateSelected(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.nameController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.nameInput,
        prefixIcon: const Icon(Icons.calendar_today),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onTap: () =>
 _pickDate(),
      validator: (v) => v == null || v.isEmpty ? 'Choisissez une date' : null,
    );
  }
}
