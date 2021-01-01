import 'package:flutter/material.dart';
import 'models.dart';
import 'screens/HomeScreen.dart';
import 'utilities/Networking.dart';
import 'package:emojis/emojis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weekday_selector/weekday_selector.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Deal>> futureDeal;

  @override
  void initState() {
    futureDeal = fetchDeal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Hour List',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          accentColor: Colors.white),
      home: HomeScreen(),
    );
  }
}