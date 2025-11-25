import 'package:flutter/material.dart';

class TransportHome extends StatefulWidget {
  const TransportHome({super.key});

  @override
  State<TransportHome> createState() => _TransportHomeState();
}

class _TransportHomeState extends State<TransportHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Transports"),));
  }
}