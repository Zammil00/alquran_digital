import 'package:alquran_digital/app/data/model/surah.dart';
import 'package:alquran_digital/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Surah>>(
        future: controller.getAllsurah(),
        builder: (context, Snapshot) {
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!Snapshot.hasData) {
            return Center(
              child: Text("TIDAK ADA DATA"),
            );
          }
          print(Snapshot.data);
          return ListView.builder(
              itemCount: Snapshot.data!.length,
              itemBuilder: (context, index) {
                Surah surah = Snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.pink,
                    child: Text(
                      "${surah.number}",
                      style: GoogleFonts.sora(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    ' ${surah.name.transliteration.id}',
                    style: GoogleFonts.sora(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    '${surah.numberOfVerses} Ayat  | ${surah.revelation.id}',
                    style: GoogleFonts.sora(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Text(
                    '${surah.name.short}',
                    style: GoogleFonts.sora(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
