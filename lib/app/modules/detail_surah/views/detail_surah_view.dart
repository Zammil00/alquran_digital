import 'package:alquran_digital/app/data/model/detail_surah.dart' as detail;
import 'package:alquran_digital/app/data/model/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;
  DetailSurahView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          'SURAH ${surah.name.transliteration?.id?.toUpperCase() ?? "error"}',
          style: GoogleFonts.notoKufiArabic(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.pink[300],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      " ${surah.name.transliteration?.id?.toUpperCase() ?? "error"}",
                      style: GoogleFonts.notoKufiArabic(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "( ${surah.name.translation?.id?.toUpperCase() ?? "error"} )",
                      style: GoogleFonts.notoKufiArabic(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      " ${surah.numberOfVerses ?? "error"} Ayat | ${surah.revelation.id}",
                      style: GoogleFonts.notoKufiArabic(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Expanded(
              child: FutureBuilder<detail.DetailSurah>(
                future: controller.getDetailsurah(
                  surah.number.toString(),
                ),
                builder: (context, snapshot) {
                  // print("sna[ppppppppppppppp] ${snapshot.data}");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Tidak Ada Data"),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.verses?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data?.verses == null ||
                          snapshot.data?.verses?.length == 0) {
                        return SizedBox();
                      }
                      detail.Verse? ayat = snapshot.data?.verses?[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            color: Colors.pink[300],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.pink[100],
                                    child: Text(
                                      "${index + 1}",
                                      style: GoogleFonts.notoKufiArabic(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.bookmark_outline_rounded,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.play_arrow,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${ayat!.text.arab}",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${ayat!.text.transliteration?.en}",
                            style: GoogleFonts.notoSansOldItalic(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${ayat!.translation.id}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
