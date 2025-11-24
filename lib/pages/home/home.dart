import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planéchance')),
      body: Consumer<EcheanceProvider>(
        builder: (context, echeanceP, _) {
          return Center(
            child: Column(
    
                    children: [
                      Text("Echeance en apporche"),
                      Text("Nombre total d'échances : ${echeanceP.all.length}")
                      // ListView.builder(
                      //   itemCount: echeanceP.all.length,
                      //   itemBuilder: (context, index) {
                      //     return Text(echeanceP.all[index].echeanceName);
                      //   },
                      // ),
                    ],
                  ),
          
          );
        },
      ),
    );
  }
}
