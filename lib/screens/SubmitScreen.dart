import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/services.dart';
import 'package:weekday_selector/weekday_selector.dart';
import '../utilities/Networking.dart';

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
  final days = List.filled(7, true);
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
                  padding: EdgeInsets.symmetric(vertical: 15.0),
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
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          child: Text("Days Deal is Available",
                              style: TextStyle(fontSize: 16)),
                          alignment: Alignment(-1.0, 0),
                        ),
                      ),
                      WeekdaySelector(
                        onChanged: (int day) {
                          setState(() {
                            // Use module % 7 as Sunday's index in the array is 0 and
                            // DateTime.sunday constant integer value is 7.
                            final index = day % 7;
                            // We "flip" the value in this example, but you may also
                            // perform validation, a DB write, an HTTP call or anything
                            // else before you actually flip the value,
                            // it's up to your app's needs.
                            days[index] = !days[index];
                          });
                        },
                        values: days,
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Align(
                      child: RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          submitDeal(
                              locController,
                              priceController,
                              _isBeerSelected,
                              _isShotSelected,
                              _isShotSelected,
                              days);
                          final snackBar =
                          SnackBar(content: Text('Deal submitted!'));

                          // Find the Scaffold in the widget tree and use it to show a SnackBar.
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                      ),
                      alignment: Alignment(-1.0, 0),
                    ))
              ],
            )));
  }
}