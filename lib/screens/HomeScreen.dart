import 'package:flutter/material.dart';
import '../models.dart';
import '../utilities/Networking.dart';
import 'package:emojis/emojis.dart';
import 'DealScreen.dart';
import 'SubmitScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                                  showCheckboxColumn: false,
                                    columns: [
                                      DataColumn(label: Text("Name")),
                                      DataColumn(label: Text("Price")),
                                      DataColumn(label: Text("Deal"))
                                    ],
                                    rows: data
                                        .map(
                                          (deal) => DataRow(
                                              onSelectChanged: (x) {
                                                Navigator.push(context, MaterialPageRoute(builder: (_) {
                                                  return DealScreen();
                                                }));
                                              },
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