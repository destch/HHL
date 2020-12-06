import 'dart:ffi';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<Deal>> fetchDeal() async {
  final response =
  await http.get('http://localhost:9000/getdeals');
  if (response.statusCode == 200) {
    var parsed = json.decode(response.body);
    List jsonResponse = parsed["results"] as List;
    return jsonResponse.map((job) => new Deal.fromJson(job)).toList();
  } else {
    throw Exception("failed to load Deal");

  }
}

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

