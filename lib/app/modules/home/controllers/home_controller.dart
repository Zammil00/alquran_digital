import 'dart:convert';

// import 'package:alquran_digital/app/data/model/surah.dart';
import 'package:alquran_digital/app/data/model/surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  Future<List<Surah>> getAllsurah() async {
    Uri url = Uri.parse('https://api.quran.gading.dev/surah');
    var response = await http.get(url);

    List? data = (jsonDecode(response.body) as Map<String, dynamic>)['data'];
    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }
}
