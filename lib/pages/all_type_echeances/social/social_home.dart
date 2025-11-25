import 'package:flutter/material.dart';

class SocialHome extends StatefulWidget {
  const SocialHome({super.key});

  @override
  State<SocialHome> createState() => _SocialHomeState();
}

class _SocialHomeState extends State<SocialHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Social")));
  }
}