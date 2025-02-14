import 'dart:convert';

import 'package:alquran_digital/app/data/model/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailSurahController extends GetxController {
  Future<DetailSurah> getDetailsurah(String id) async {
    Uri url = Uri.parse('https://api.quran.gading.dev/surah/$id');
    var response = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(response.body) as Map<String, dynamic>)['data'];

    // print("HALOOOOOOOOOOOOO ==== ${data}");

    return DetailSurah.fromJson(data);
  }
}
