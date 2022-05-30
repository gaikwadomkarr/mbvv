import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mbvv/screens/splash_screen.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:sizer/sizer.dart';

import 'utils/color_constants.dart';
import 'utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceId();
  }

  void getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    DataConstants.uniqueId = deviceId!;
    log(DataConstants.uniqueId);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        theme: lightThemeData(context),
        home: const SplashScreen(),
      );
    });
  }
}
