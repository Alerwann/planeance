import 'package:flutter/material.dart';
import 'package:planeance/pages/all_type_echeances/health/links_health_utils.dart';

class HealthHome extends StatefulWidget {
  const HealthHome({super.key});

  @override
  State<HealthHome> createState() => _HealthHomeState();
}

class _HealthHomeState extends State<HealthHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Santé")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog();
                  },
                );
              },
              child: Text("Ajout d'une échéance"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LinksHealthUtils()),
                );
              },
              child: Text('Aller vers les liens'),
            ),
          ],
        ),
      ),
    );
  }
}
