import 'package:flutter/material.dart';

class BillHome extends StatelessWidget {
  const BillHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fatures")),
      body: Center(child: Column(children: [Text("Ensembles des factures")])),
    );
  }
}
