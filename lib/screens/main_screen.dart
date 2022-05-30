import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mbvv/screens/authentication/login.dart';
import 'package:mbvv/screens/authentication/view_profile.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:mbvv/utils/preferences.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:sizer/sizer.dart';

import 'dashboards.dart/home_dashboard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeDashboard(),
    ProfileDashboard(),
    Container(),
    Container(),
    Container()
  ];
  String appBarTitle = ennglishMarathi["profileen"].toString();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: true,
            actions: currentIndex == 1
                ? [
                    TextButton(
                        onPressed: () {
                          Preferences.saveUserLoggedIn(false);
                          Get.offAll(Login());
                        },
                        child: Text(
                          'Logout',
                          style: Controller.kwhiteSmallStyle(context, white),
                        ))
                  ]
                : null,
            title: Text(
              appBarTitle,
              style:
                  Controller.kblackNormalStyle(context).copyWith(color: white),
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3.w), topRight: Radius.circular(3.w)),
            child: SizedBox(
              // height: 9.h,
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                // elevation: 3,
                type: BottomNavigationBarType.fixed,
                onTap: _onItemTapped,
                backgroundColor: primaryColor,
                selectedItemColor: white,
                unselectedItemColor: grey,
                selectedLabelStyle: TextStyle(color: white, fontSize: 15.sp),
                unselectedLabelStyle: TextStyle(color: grey, fontSize: 12.sp),
                items: [
                  BottomNavigationBarItem(
                      icon: _inActiveIcon(Icons.home),
                      activeIcon: _activeIcon(Icons.home),
                      label: ennglishMarathi["homeen"].toString()),
                  BottomNavigationBarItem(
                    icon: _inActiveIcon(Icons.person_sharp),
                    activeIcon: _activeIcon(Icons.person_sharp),
                    label: ennglishMarathi["profileen"].toString(),
                    //            activeIcon: _activeIcons(DImages.menu),
                  ),
                ],
              ),
            ),
          ),
          body: pages[currentIndex]),
    );
  }

  _inActiveIcon(IconData icon) {
    return Icon(
      icon,
      color: grey,
      size: 20.sp,
    );
  }

  _activeIcon(IconData icon) {
    return Icon(
      icon,
      color: white,
      size: 20.sp,
    );
  }

  void _onItemTapped(int index) {
    print('this is $index tapped');
    setState(() {
      currentIndex = index;
      appBarTitle = index == 1
          ? ennglishMarathi["profileen"].toString()
          : ennglishMarathi["homeen"].toString();
    });
  }
}
