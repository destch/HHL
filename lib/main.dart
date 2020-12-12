import 'dart:ffi';

import 'package:flutter/material.dart';
import 'API.dart';
import 'package:emojis/emojis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';


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
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Future<List<Deal>> futureDeal;

  @override
  void initState() {
    futureDeal = fetchDeal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Hour List'),
      ),
      body: FutureBuilder<List<Deal>>(
          future: futureDeal,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              List<Deal> data = snapshot.data;
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    columns: [
                                      DataColumn(label: Text("Name")),
                                      DataColumn(label: Text("Price")),
                                      DataColumn(label: Text("Deal"))
                                    ],
                                    rows: data
                                        .map(
                                          (deal) => DataRow(
                                            cells: [
                                              DataCell(Text(deal.dealLoc)),
                                              DataCell(Text(
                                                  '\$${deal.dealPrice.toInt()}')),
                                              DataCell(Text(
                                                  '${Emojis.beerMug} ${Emojis.tumblerGlass}'))
                                            ],
                                          ),
                                        )
                                        .toList())))
                      ]));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("snapshot had error");
            } else {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Center(
                        child: Padding(
                      child: Text("loading deals"),
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                    ))
                  ]);
            }
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return SubmitScreen();
            }));
          }),
    );
  }
}

class SubmitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Hour List'),
      ),
      body: SubmitForm(),
    );
  }
}

class SubmitForm extends StatefulWidget {
  @override
  SubmitFormState createState() {
    return SubmitFormState();
  }
}

class SubmitFormState extends State<SubmitForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isBeerSelected = false;
  bool _isShotSelected = false;
  bool _isCocktailSelected = false;
  final locController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    locController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.all(50.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: locController,
                  decoration: InputDecoration(labelText: "Name of the spot"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter text";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(labelText: "Price of deal"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter text";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        child: Text("Items included in deal",
                            style: TextStyle(fontSize: 16)),
                        alignment: Alignment(-1.0, 0),
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Colors.blue,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text('Beer ${Emojis.beerMug}'),
                        value: _isBeerSelected,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isBeerSelected = newValue;
                          });
                        },
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Colors.blue,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text('Shot ${Emojis.tumblerGlass}'),
                        value: _isShotSelected,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isShotSelected = newValue;
                          });
                        },
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Colors.blue,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text('Cocktail ${Emojis.tropicalDrink}'),
                        value: _isCocktailSelected,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isCocktailSelected = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    child: Align(
                      child: RaisedButton(child: Text("Submit"), onPressed: () {
                        _submitDeal("test", locController, priceController, _isBeerSelected, _isShotSelected, _isShotSelected);
                        final snackBar = SnackBar(content: Text('Deal submitted!'));

                        // Find the Scaffold in the widget tree and use it to show a SnackBar.
                        Scaffold.of(context).showSnackBar(snackBar);
                      },),
                      alignment: Alignment(-1.0, 0),
                    ))
              ],
            )));
  }
}

Future<http.Response> _submitDeal(String title, final locController, final priceController,
    _isBeerSelected, _isShotSelected, _isCocktailSelected) {
  return http.post(
    'http://localhost:9000/createdeal',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'dealLoc': locController.text,
      'dealPrice': double.parse(priceController.text),
      'dealItems': <String, bool>{"beer":_isBeerSelected, "shot":_isShotSelected, "cocktail":_isBeerSelected}
    }),
  );
}
