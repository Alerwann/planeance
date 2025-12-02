import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';

class AlertDialogueDirectory extends StatelessWidget {
  final DirectoryProvider directP;
  const AlertDialogueDirectory({super.key, required this.directP});

  @override
  Widget build(BuildContext context) {
      DirectoryModel? selectedDirectory = directP.availableDirectories.first;
    return AlertDialog(
      title: Text("Ajout d'une catégorie"),
 
      actions: [
        DropdownButtonFormField<DirectoryModel>(
          initialValue: selectedDirectory,
          decoration: InputDecoration(
            labelText: "Nom du domaine",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          items: directP.availableDirectories
              .map(
                (d) => DropdownMenuItem<DirectoryModel>(
                  value: d,
                  child: Text(d.name),
                ),
              )
              .toList(),
          onChanged: (DirectoryModel? value) {
            if (value != null) {
              selectedDirectory = value;
            }
          },
        ),

        Row(
          children: [
            TextButton(
              onPressed: () async {
                if (selectedDirectory != null) {
                   directP.add(selectedDirectory!);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              child: Text("Ajout"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Annuler"),
            ),
          ],
        ),
      ],
    );
  }
}
