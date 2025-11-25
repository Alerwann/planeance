import 'package:flutter/material.dart';

class JobHome extends StatefulWidget {
  const JobHome({super.key});

  @override
  State<JobHome> createState() => _JobHomeState();
}

class _JobHomeState extends State<JobHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emplois")),
      body: Center(child: Column(children: [Text("Ensembles des Emplois")])),
    );
    
  }
}