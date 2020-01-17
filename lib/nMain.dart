import 'package:flutter/material.dart';
import 'series/seriesPage.dart';
import 'package:movie_app/trendingPage.dart';
import 'movie/moviesPage.dart';
import 'constants.dart';
import 'package:movie_app/userAccount.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  final widgetOptions = [
    TrendingPage(key: PageStorageKey('TrendingPage')),
    MoviesPage(),
    SeriesPage(),
    UserAccount()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(
          child: widgetOptions[currentPage],
          bucket: bucket,
        ),
        bottomNavigationBar: buildFancyBottomNavigation());
  }

  final PageStorageBucket bucket = PageStorageBucket();

  FancyBottomNavigation buildFancyBottomNavigation() {
    return FancyBottomNavigation(
      initialSelection: currentPage,
      circleColor: kSemiGeneralColor,
      inactiveIconColor: kSemiGeneralColor,
      tabs: [
        TabData(
          iconData: Icons.home,
          title: "Home",
        ),
        TabData(iconData: Icons.movie, title: "Movies"),
        TabData(iconData: Icons.apps, title: "Series"),
        TabData(iconData: Icons.account_circle, title: "Account"),
      ],
      onTabChangedListener: (position) {
        setState(() {
          currentPage = position;
        });
      },
    );
  }
}
