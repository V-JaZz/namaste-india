import 'package:flutter/material.dart';
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
          icon: const Icon(Icons.home),
          title: const Text("Home"),
        ),
        TabNavigationItem(
          page: Profile(),
          icon: const Icon(Icons.home),
          title: const Text("Home"),
        ),
        TabNavigationItem(
      page: Search(),
      icon: const Icon(Icons.search),
      title: const Text("Search"),
    ),
        TabNavigationItem(
        page: About(),
        icon: const Icon(Icons.home),
        title: const Text("About"),
        ),
      ];
}
