import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';
import 'package:planeance/widget/alerte_dialogue/alerte_delete.dart';

class CardEcheance extends StatelessWidget {
  final EcheanceModel echeance;
  const CardEcheance({super.key, required this.echeance});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(echeance.echeanceName),
        subtitle: Text("Date limite d'échéance : ${echeance.subType}"),
        leading: IconButton(
          icon: Icon(Icons.delete_forever_rounded),
          color: Colors.red,
          onPressed: () {
            AlerteDelete.showDeleteDialog(null, echeance, context);
          },
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.mode_edit_outline_rounded, color: Colors.grey),
        ),
      ),
    );
  }
}
