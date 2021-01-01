import 'package:flutter/material.dart';
import '../widgets/eventhero.dart';

class DealScreen extends StatelessWidget {
  DealScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Happy Hour List'),
        ),
        body: Column(children: <Widget>[
          EventHero(),
          Container(child: Text("jfldfjlk")),
        ]));
  }
}
