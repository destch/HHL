import 'package:flutter/material.dart';
import 'picturebutton.dart';

class EventHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: Hero(
            tag: "event1",
            child: PictureButton(
              height: 300,
              isEvent: true,
              width: MediaQuery.of(context).size.width - 40,
              pic: NetworkImage("https://www.buzztonight.com/new-york-city/wp-content/uploads/2017/02/clockwork.jpg"),
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Clockwork Bar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "21 Essex St, New York, NY 10002",
                      style: TextStyle(color: Color(0xaaffffff), fontSize: 18),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    width: 100,
                    height: 26,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xDD333333)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "12-5 PM",
                            style: TextStyle(
                                color: Color(0xaaffffff), fontSize: 14),
                          ),
                        ])),
              ],
            ))));
  }
}