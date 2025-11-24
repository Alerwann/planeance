import 'package:flutter/material.dart';

class HealthHome extends StatefulWidget {
  const HealthHome({super.key});

  @override
  State<HealthHome> createState() => _HealthHomeState();
}

class _HealthHomeState extends State<HealthHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Health")),
      body: Center(child: Text("Ici on verra la santé")),
    );
  }
}
