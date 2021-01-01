import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Deal {
  final String dealLoc;
  final double dealPrice;
  final String dealDesc;

  Deal({this.dealLoc, this.dealPrice, this.dealDesc});

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      dealLoc: json['dealLoc'],
      dealPrice: json['dealPrice'],
      dealDesc: json['dealDesc'],
    );
  }
}



