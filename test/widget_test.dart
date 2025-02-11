import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse('https://api.quran.gading.dev/surah');

  var response = await http.get(url).timeout(Duration(seconds: 10));
  print(response.body);

  List data = (json.decode(response.body) as Map<String, dynamic>)['data'];
  if (kDebugMode) {
    print(data[113]);
  }
  // print(data[0]['name']);
  // print(data[0]['name']['short']);
  // print(data[0]['name']['long']);
}
