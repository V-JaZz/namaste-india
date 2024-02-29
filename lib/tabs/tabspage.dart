import 'package:flutter/material.dart';

import '../constant/colors.dart';
import 'bottom_tabs.dart';

class TabsPage extends StatefulWidget {
  int selectedIndex = 0;

  TabsPage({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;
      print(_selectedIndex);
    });
  }

  @override
  void initState() {
    _onItemTapped(widget.selectedIndex);
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: IndexedStack(
          index: widget.selectedIndex,
          children: [
            for (final tabItem in TabNavigationItem.items) tabItem.page,
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:  Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
              icon:  Icon(Icons.discount_outlined),
            label: 'Discount',
          ),
          BottomNavigationBarItem(
              icon:  Icon(Icons.food_bank_outlined),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        unselectedItemColor:colorLightBlue,
        showUnselectedLabels: true,
      ),
    );
  }
}
