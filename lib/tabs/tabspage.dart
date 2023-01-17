import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namastey_india/Provider/UserDataStateMgmt.dart';
import 'package:namastey_india/ui/globals.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../models/userLoginDataModel.dart';
import 'bottom_tabs.dart';

class TabsPage extends StatefulWidget {
  int selectedIndex = 0;
  UserData? userData;

  TabsPage({Key? key, required this.selectedIndex, this.userData}) : super(key: key);

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
      loadUserData();
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

  Future<void> loadUserData() async {
    print('started');
    if(widget.userData != null){
      final userDataState = Provider.of<UserDataStateMgmt>(context,listen: false);
      try{
        print('user data loaded');
        userDataState.userData = widget.userData;
        print(userDataState.userData!.contact.toString());
        print(userDataState.userData!.isActive.toString());
      }catch(e) {
        print('user data not loaded $e');
      }
    }
  }
}
