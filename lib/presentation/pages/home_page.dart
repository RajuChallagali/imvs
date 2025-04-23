import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imvs/presentation/pages/bible_page.dart';
import 'package:imvs/presentation/pages/liturgy_page.dart';
import 'package:imvs/presentation/pages/mass_page.dart';
import 'package:imvs/presentation/pages/songs_page.dart';
import 'package:imvs/presentation/pages/prayers_page.dart';
import 'package:imvs/presentation/pages/youtube_page.dart';
import 'package:imvs/presentation/utils/const/const.dart';
import 'package:imvs/presentation/widgets/app_drawer.dart';
import 'package:imvs/presentation/widgets/custom_navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  static const String routeName = "/HomePage";
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 
  int _selectedIndex = 0;

  final List<String> _titles = [
    'ప్రార్థనలు',
    'పఠనములు',
    'దివ్యబలిపూజ',
    'బైబిల్',
    'పాటలు',
    'మేత్రాసన యూట్యూబ్ ఛానెల్',
  ];

  final List<Color> _backgroundColors = [
    Colors.yellow.shade50,
    Colors.green.shade50,
    Colors.blue.shade50,
    Colors.brown.shade50,
    Colors.blue.shade50,
    Colors.red.shade50,
  ];

  final List<Widget> _pages = [
    const PrayersPage(),
    const LiturgyPage(),
    const MassPage(),
    const BiblePage(),
    const SongsPage(),
    const YouTubePage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            _backgroundColors[_selectedIndex], // ✅ Dynamic Background Color
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: _backgroundColors[_selectedIndex].withOpacity(1),
          title: Text(_titles[_selectedIndex]),
          actions: <Widget>[
            PopupMenuButton<Choice>(itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
              return PopupMenuItem<Choice>(
                value: choice,
                child: InkWell(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          choice.icon,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            choice.title!,
                           
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => _onSelected(context, choice),
                ),
              );
            }).toList();
            },),
          ],
        ),
        drawer: const AppDrawer(),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavTapped,
        ),
      ),
    );
  }
  _onSelected(BuildContext context, Choice choice) {
    switch (choice.title) {
      
      case Choice.feedback:
        launch('mailto:${feedback_email}?subject=$app_name&body=Feedback');
        return;
      case Choice.share_the_app:
        Navigator.of(context).pop();
        Share.share(Platform.isIOS ? share_text_ios : share_text_android);
        return;
      case Choice.rate_the_app:
        launchUrl(Uri.parse(Platform.isIOS ? appstore_link : playstore_link));
        return;
    }
  }

  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class Choice {

  static const String feedback = 'Feedback';
  static const String share_the_app = 'Share the App';
  static const String rate_the_app = 'Rate the App';

  const Choice({this.title, this.icon});

  final String? title;
  final IconData? icon;
}

const List<Choice> choices = const <Choice>[

  const Choice(title: Choice.feedback, icon: Icons.email),
  const Choice(title: Choice.share_the_app, icon: Icons.share),
  const Choice(title: Choice.rate_the_app, icon: Icons.star),
];

