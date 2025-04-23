import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:imvs/presentation/pages/home_page.dart';
import 'package:imvs/services/api/prayer_api_service.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});
  static const String routeName = "/IntroPage";

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final box = GetStorage();
  bool _loading = true;
  @override
  void initState() {
    super.initState();
      _preloadBibleData();
    Future.delayed(const Duration(seconds: 5), () {
      Get.offNamed(HomePage.routeName);
    });
    //_initializeApp();
  }
  Future<void> _preloadBibleData() async {
    try {
      final bibleBooks = await ApiService.fetchBibleBooks();
      await box.write('bible_books', bibleBooks);

      for (var book in bibleBooks) {
        final chapters = await ApiService.fetchChapters(book);
        await box.write('chapters_$book', chapters);

        for (var chapter in chapters) {
          final verses = await ApiService.fetchVerses(book, chapter);
          await box.write('verses_${book}_$chapter', verses);
        }
      }

      // Go to home after loading
      //Get.offAll(() => const HomePage());
    } catch (e) {
      print("Error during preload: $e");
      // Optionally show an error screen or retry
    }
  }

  /*Future<void> _initializeApp() async {
    try {
      final selectedDate =
          DateTime.now(); // Define selectedDate with the current date
      final dailyReading = await ApiService.fetchDailyReading(selectedDate);
      final allData = await ApiService.fetchAllData();
      final massToday = dailyReading; // You were calling the same twice

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('dailyReading', jsonEncode(dailyReading));
      await prefs.setString('allPrayers', jsonEncode(allData));
      await prefs.setString('massToday', jsonEncode(massToday));
    } catch (e) {
      debugPrint("Error during initialization: $e");
      // Optional: Show a snackbar or retry button here
    }

    setState(() => _loading = false);
    Get.offNamed(HomePage.routeName);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/imvs_church.jpg', // your background image
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.white.withOpacity(0.1),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Top Row - Bishops
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLeaderCard(
                    image: 'assets/images/imvs_Bp2_app.jpg',
                    title: 'Most Rev. Dr.\n Moses D. Prakasam',
                  ),
                  const SizedBox(width: 60),
                  _buildLeaderCard(
                    image: 'assets/images/imvs_Bp_app.jpg',
                    title: ' Most Rev. Pilli  \nAnthony Das',
                  ),
                ],
              ),
              const SizedBox(height: 80),

              // App name in rounded card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
                color: Colors.pink,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      Text(
                        'ఇదే మన విశ్వాసం',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'సింహపురి పీఠం',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Father Image
              _buildLeaderCard(
                image: 'assets/images/imvs_Fr_app.jpg',
                title: ' Rev. Fr. Chandra Kalivela ',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderCard({required String image, required String title}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(height: 20),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 6,
          color: const Color.fromARGB(255, 3, 25, 58),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
