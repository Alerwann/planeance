import 'package:flutter/material.dart';

class MeetingHome extends StatefulWidget {
  const MeetingHome({super.key});

  @override
  State<MeetingHome> createState() => _MeetingHomeState();
}

class _MeetingHomeState extends State<MeetingHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Rendez-vous")));
  }
}