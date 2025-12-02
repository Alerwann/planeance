import 'package:flutter/material.dart';

class JobHome extends StatelessWidget {
  const JobHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emplois")),
      body: Center(child: Column(children: [Text("Ensembles des Emplois")])),
    );
    
  }
}