import 'package:flutter/material.dart';

class BillHome extends StatefulWidget {
  const BillHome({super.key});

  @override
  State<BillHome> createState() => _BillHomeState();
}

class _BillHomeState extends State<BillHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fatures")),
      body: Center(child: Column(children: [Text("Ensembles des factures")])),
    );
  }
}
