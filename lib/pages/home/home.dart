import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planeance/data/constant.dart';
import 'package:planeance/planeance.dart';
import 'package:planeance/widget/card_modif_delete.dart';
import 'package:planeance/widget/succes_snake.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String wichSelected = Constant.weekPeriod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planéchance')),
      body: SingleChildScrollView(
        child: Consumer<EcheanceProvider>(
          builder: (context, echeanceP, _) {
            final echeancesList = echeanceP.getEcheancesForPeriod(wichSelected);
            return Center(
              child: Column(
                spacing: 15,
                children: [
                  if (kDebugMode)
                    ElevatedButton(
                      onPressed: () {
                        final (success, message) = echeanceP.delateAll();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SuccesSnake.successSnake(success, message),
                        );
                      },
                      child: Text("Réinitialiser box echeance"),
                    ),
                  Text(
                    "Echéance en apporche",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  Wrap(
                    spacing: 8,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,

                    children: [
                      buttonChoice(Constant.daysPeriod, echeanceP),
                      buttonChoice(Constant.weekPeriod, echeanceP),
                      buttonChoice(Constant.monthPeriod, echeanceP),
                    ],
                  ),

                  Text("Nombre total d'échances : ${echeanceP.all.length}"),
                  if (echeanceP.getEcheancePast().isNotEmpty)
                    Text(
                      "Nombre d'échéances dépasées : ${echeanceP.getEcheancePast().length}",
                      style: TextStyle(color: Colors.red),
                    ),

                  Text(
                    "${_getTitleForSelection(wichSelected)} : ${echeancesList.length}",
                  ),

                  echeancesList.isEmpty
                      ? Text(
                          "Bonne nouvelle!\nTu n'as pas d'échéances",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          shrinkWrap: true, // Important dans une Column
                          itemCount: echeancesList.length,
                          itemBuilder: (context, index) {
                            final echeance = echeancesList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CardEcheance(echeance: echeance),
                            );
                          },
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ElevatedButton buttonChoice(String typeChoice, EcheanceProvider echeanceP) {
    late String nameButton;
    switch (typeChoice) {
      case Constant.daysPeriod:
        nameButton = "Par jour";
        break;
      case Constant.monthPeriod:
        nameButton = "Par mois";
        break;
      default:
        nameButton = "Par semaine";
        break;
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: wichSelected == typeChoice
            ? Colors.green
            : Colors.amber,
      ),
      onPressed: () {
        setState(() {
          wichSelected = typeChoice;
        });
      },
      child: Text(nameButton),
    );
  }

  String _getTitleForSelection(String selection) {
    switch (selection) {
      case Constant.daysPeriod:
        return "Échéance de la journée";
      case Constant.monthPeriod:
        return "Échéance du mois";
      case Constant.weekPeriod:
      default:
        return "Échéance de la semaine";
    }
  }
}
