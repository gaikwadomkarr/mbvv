import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbvv/screens/dashboards.dart/home_dashboard.dart';
import 'package:mbvv/screens/main_screen.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/image_constants.dart';
import 'package:mbvv/utils/preferences.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:sizer/sizer.dart';

import 'authentication/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController useridController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getLoggedIn();
  }

  void getLoggedIn() async {
    // TOKEN = await Preferences.getToken();
    // var loggedIn = await Preferences.getUserLoggedIn();
    // if (loggedIn) {
    //   Future.delayed(const Duration(seconds: 2), () {
    //     Get.off(MainScreen());
    //   });
    // } else {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(Login());
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                mbvvlogo,
                height: 25.h,
              ),
              Text(
                ennglishMarathi["taglineen"].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
