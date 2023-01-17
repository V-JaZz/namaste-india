import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:namastey_india/ui/about.dart';

import '../ui/home.dart';
import '../ui/profile.dart';
import '../ui/search.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({required this.page, required this.title, required this.icon});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: Home(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        TabNavigationItem(
          page: Profile(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        TabNavigationItem(
      page: Search(),
      icon: Icon(Icons.search),
      title: Text("Search"),
    ),
        TabNavigationItem(
        page: About(),
        icon: Icon(Icons.home),
        title: Text("About"),
        ),
      ];
}
