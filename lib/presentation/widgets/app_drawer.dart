import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imvs/presentation/pages/about_page.dart';
import 'package:imvs/presentation/pages/bible_page.dart';
import 'package:imvs/presentation/pages/home_page.dart';
import 'package:imvs/presentation/pages/liturgy_page.dart';
import 'package:imvs/presentation/pages/prayers_page.dart';
import 'package:imvs/presentation/pages/settings_page.dart';
import 'package:imvs/presentation/pages/songs_page.dart';
import 'package:imvs/presentation/pages/youtube_page.dart';
import 'package:imvs/presentation/utils/const/const_enum.dart';

class AppDrawer extends StatefulWidget {
  static int PRAYERS_INDEX = 0;
  static int LITURGY_INDEX = 1;
static int MASS_INDEX = 2;
  static int BIBLE_INDEX = 3;
  static int SONGS_INDEX =4;
  static int YOUTUBE_INDEX = 5;
  //static int SETTINGS_INDEX = 5;
  static int ABOUT_INDEX = 6;
  final int? selectedIndex;

  const AppDrawer({this.selectedIndex});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
 static int _selectedIndex = 0;
  static int selectedIndex = 0;

  final List<String> _titles = [
    'ప్రార్థనలు',
    'పఠనములు',
    'బైబిల్',
    'పాటలు',
    'యూట్యూబ్',
  ];

  final List<Color> _backgroundColors = [
    Colors.yellow,
    Colors.green,
    const Color.fromARGB(255, 92, 33, 11),
    Colors.blue,
    Colors.white,
  ];

  final List<Widget> _pages = [
    const PrayersPage(),
    const LiturgyPage(),
    const BiblePage(),
    const SongsPage(),
    const YouTubePage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> _drawerMenuItemTitles = [
    "ప్రార్థనలు",
    "పూజ పఠనములు",
    "దివ్యబలిపూజ",
    "బైబిల్",
    "పాటలు",
    "యూట్యూబ్",
    //"సెట్టింగులు",
    "మా గురించి",
  ];
  final List<IconData> _drawerMenuItemIcons = [
    Icons.auto_stories_rounded,
    Icons.menu_book_rounded,
    Icons.church_rounded,
    Icons.book_rounded,
    Icons.music_note_rounded,
    Icons.video_library_rounded,
    //Icons.settings_rounded,
    Icons.info_outline_rounded,
  ];

  final List<String> _drawerMenuItemSubtitles = [
    "అనుదిన కతోలిక ప్రార్థనలు",
    "దివ్యబలి పూజా పఠనములు",
    "దివ్యబలిపూజ క్రమము",
    "పవిత్ర బైబిల్ గ్రంథము కతోలిక అనువాదం",
    "దైవార్చన గీతాలు",
    "మేత్రాసన అధికారిక యూట్యూబ్ ఛానెల్",
    //"ఆప్ సెట్టింగులు",
    "మరిన్ని విశేషాలు",
  ];
  final List<String> _drawerMenuItemRoutes = [
    HomePage.routeName,
    HomePage.routeName,
    HomePage.routeName,
    HomePage.routeName,
    HomePage.routeName,
    HomePage.routeName,
    //SettingsPage.routeName,
    AboutPage.routeName,
  ];

  final List<RouteType> _drawerMenuItemRoutesType = [
    RouteType.toNamed,
    RouteType.toNamed,
    RouteType.toNamed,
    RouteType.toNamed,
    RouteType.toNamed,
    RouteType.toNamed,
    //RouteType.toNamed,
    RouteType.toNamed,
  ];
  _buildAppDrawerItems() {
    int index = -1;
    return _drawerMenuItemTitles.map((String title) {
      ++index;
      return AppDrawerItem(
        title: title,
        icons: _drawerMenuItemIcons[index],
        subtitle: _drawerMenuItemSubtitles[index],
        routeName: _drawerMenuItemRoutes[index],
        routeType: _drawerMenuItemRoutesType[index],
        index: index,
        selectedIndex: selectedIndex,
        menuItemSelected: (int selIndex) {
          setState(() {
            selectedIndex = selIndex;
          });
        },
      );
    }).toList();
  }
  @override
  void initState() {
    super.initState();
    if (null != widget.selectedIndex && widget.selectedIndex != 0) {
      selectedIndex = widget.selectedIndex ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    Widget drawerHeader = DrawerHeader(
      decoration: BoxDecoration(color: Colors.deepPurple),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //const AppLogo(),
          Image.asset('assets/images/imvsAppLogo.png',
              width: 80.0, height: 80.0),
          const Padding(
            padding: EdgeInsets.only(
              left: 8.0,
              bottom: 4.0,
              //top: 2.0,
            ),
            child: Text('ఇదే మన విశ్వాసం',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal)),
          ),
        ],
      ),
    );

    widgets.add(drawerHeader);
    widgets.addAll(_buildAppDrawerItems());
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: widgets,
      ),
    );
  }
}

class AppDrawerItem extends StatelessWidget {
  String? title, subtitle;
  IconData? icons;
  String routeName;
  int? index, selectedIndex;
  ValueChanged<int>? menuItemSelected;
  RouteType routeType;

  AppDrawerItem(
      {@required this.title,
      @required this.subtitle,
      @required this.icons,
      @required this.routeName = HomePage.routeName,
      required this.routeType,
      @required this.index,
      @required this.selectedIndex,
      @required this.menuItemSelected});

  @override
  Widget build(BuildContext context) {
    print('the route name is $routeName');
    return ListTile(
      leading: Icon(icons),
      title: Text(title ?? ''),
      subtitle: Text(subtitle ?? ''),
      onTap: () {
        print('the route selected was $routeName');
        menuItemSelected!(index!);
        Get.back();

        if (routeType == RouteType.offAndToNamed) {
          Get.offAndToNamed(routeName);
        } else {
          Get.toNamed(routeName);
        }
      },
      selected: (selectedIndex == index),
    );
  }
}