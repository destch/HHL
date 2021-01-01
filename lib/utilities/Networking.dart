import '../models.dart';
import 'dart:async';
import 'dart:convert';
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

Future<http.Response> submitDeal(final locController, final priceController,
    _isBeerSelected, _isShotSelected, _isCocktailSelected, final days) {
  return http.post(
    'http://localhost:9000/createdeal',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'dealLoc': locController.text,
      'dealPrice': double.parse(priceController.text),
      'dealItems': <String, bool>{
        "beer": _isBeerSelected,
        "shot": _isShotSelected,
        "cocktail": _isBeerSelected
      },
      'dealDays': <String, bool>{
        "M": days[0],
        "T": days[1],
        "W": days[2],
        "R": days[3],
        "F": days[4],
        "Sa": days[5],
        "Su": days[6]
      }
    }),
  );
}