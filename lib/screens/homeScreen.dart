import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:staffs/screens/staffEntry.dart';
import 'package:staffs/screens/staffList.dart';
import '../DBfirebase/dbFunctions.dart';
import '../DBfirebase/staff.dart';
import '../Utilities/customAnimatedBar.dart';
import '../Constants/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> staff = [];
  int bottomNavIndex = 0;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        log("clicked Staff Entry");
        return const StaffEntry();
      case 1:
        log("clicked Staff List");

        return StaffList(
          list: staff,
        );
      default:
        return const Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titleList[bottomNavIndex]),
      ),
      bottomNavigationBar: _buildBottomBar(),
      body: _getDrawerItemWidget(bottomNavIndex),
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.black,
      selectedIndex: bottomNavIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: ((index) async {
        log("bottom bar index" + index.toString());
        if (index == 1) {
          staff = await DBfunctions.getStaffList();
        }
        setState(() => bottomNavIndex = index);
      }),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.apps),
          title: const Text('Staff Entry'),
          activeColor: Colors.green,
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.people),
          title: const Text('Staff List'),
          activeColor: Colors.purpleAccent,
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
