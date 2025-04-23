import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imvs/presentation/pages/about_page.dart';
import 'package:imvs/presentation/pages/bible_page.dart';
import 'package:imvs/presentation/pages/home_page.dart';
import 'package:imvs/presentation/pages/introPage.dart';
import 'package:imvs/presentation/pages/liturgy_page.dart';
import 'package:imvs/presentation/pages/mass_page.dart';
import 'package:imvs/presentation/pages/prayers_page.dart';
import 'package:imvs/presentation/pages/settings_page.dart';
import 'package:imvs/presentation/pages/songs_page.dart';
import 'package:imvs/presentation/pages/splash_page.dart';
import 'package:imvs/presentation/pages/youtube_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ide Mana Vishvasamu',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255,243, 233, 215)),
        useMaterial3: true,
      ),
      home: const SplashPage(title: 'ఇదే మన విశ్వాసం'),
      getPages: [
        GetPage(name: HomePage.routeName, page: ()=>const HomePage(title: 'ఇదే మన విశ్వాసం'),),
        GetPage(name: IntroPage.routeName, page: ()=>const IntroPage(),),
        GetPage(name: PrayersPage.routeName, page: ()=>const PrayersPage(),),
        GetPage(name: LiturgyPage.routeName, page: ()=>const LiturgyPage(),),
        GetPage(name: MassPage.routeName, page: ()=>const MassPage(),),
        GetPage(name: BiblePage.routeName, page: ()=>const BiblePage(),),
        GetPage(name: SongsPage.routeName, page: ()=>const SongsPage(),),
        GetPage(name: SettingsPage.routeName, page: ()=>const SettingsPage(),),
        GetPage(name: AboutPage.routeName, page: ()=>const AboutPage(),),
        GetPage(name: YouTubePage.routeName, page: ()=>const YouTubePage(),),
      ],
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text('ఇదే మన విశ్వాసం'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'ప్రార్థనలు'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'బైబిల్'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), label: 'పూజ పఠనములు'),
          BottomNavigationBarItem(
              icon: Icon(Icons.music_note), label: 'పాటలు'),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/