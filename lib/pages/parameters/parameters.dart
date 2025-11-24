import 'package:flutter/material.dart';

class Parameters extends StatefulWidget {
  const Parameters({super.key});

  @override
  State<Parameters> createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Paramètre"), centerTitle: true, ),
      body: Center(child: Text("Parametre")),
    );
  }
}
