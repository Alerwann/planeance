import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planeance/planeance.dart';

class CardListTitle extends StatelessWidget {
  final EcheanceProvider echeanceP;
  final EcheanceModel echeance;
  const CardListTitle({super.key, required this.echeanceP, required this.echeance});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(echeance.echeanceName, textAlign: TextAlign.center),
        iconColor: Colors.red,
        subtitle: Text(
          "Fin le : ${DateFormat.yMd('fr').format(echeance.endDate)}",
        ),
        trailing: IconButton(
          onPressed: () {
            echeanceP.deleteOne(echeance.key as int);
          },
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
