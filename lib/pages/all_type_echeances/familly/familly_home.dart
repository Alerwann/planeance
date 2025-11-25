import 'package:flutter/material.dart';

class FamillyHome extends StatefulWidget {
  const FamillyHome({super.key});

  @override
  State<FamillyHome> createState() => _FamillyHomeState();
}

class _FamillyHomeState extends State<FamillyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Famille")));
  }
}
