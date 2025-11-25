import 'package:flutter/material.dart';

class HandicapHome extends StatefulWidget {
  const HandicapHome({super.key});

  @override
  State<HandicapHome> createState() => _HandicapHomeState();
}

class _HandicapHomeState extends State<HandicapHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Handicap")),
      body: Center(child: Text("Ici on verra la handicap")),
    );
  }
}