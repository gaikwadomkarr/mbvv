import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sizer/sizer.dart';

class Controller {
  // var theme = Theme.of(context);
  static TextStyle kblackNormalStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 15.sp, color: Colors.black);
  }

  // static void launchURL(String url) async {
  //   if (!await launch(url, enableJavaScript: true, forceWebView: true))
  //     throw 'Could not launch $url';
  // }

  static String formatDate(DateTime dateTime) {
    String dateFormat = DateFormat('hh:mm a').format(dateTime);
    return dateFormat;
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String camelToSentence(String text) {
    var result = text.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), r" ");
    var finalResult = result[0].toUpperCase() + result.substring(1);
    return finalResult;
  }

  static TextStyle kwhiteSemiBoldNormalStyle(
      BuildContext context, Color color) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 15.sp, color: color);
  }

  static TextStyle hintTextStyle(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          color: color ?? grey,
          fontSize: 12.sp,
        );
  }

  static TextStyle textFieldLabel(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.subtitle1!.copyWith(
          color: color ?? grey,
          letterSpacing: 1,
          fontSize: 12.sp,
        );
  }

  static TextStyle pageHeadingLabel(BuildContext context, {Color? color}) {
    return TextStyle(
        fontSize: 22.sp,
        color: primaryColor,
        fontWeight: FontWeight.bold,
        letterSpacing: 2);
  }

  static TextStyle textfieldTextStyle(BuildContext context, {Color? color}) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(color: black, letterSpacing: 1, fontSize: 13.sp);
  }

  static TextStyle buttonText(BuildContext context, {Color? color}) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(color: black, letterSpacing: 1, fontSize: 15.sp);
  }

  static TextStyle kwhiteSmallStyle(BuildContext context, Color color) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 10.sp, color: color);
  }

  static TextStyle kblackSemiNormalStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 12.sp, color: Colors.black);
  }

  static TextStyle kblackSemiBoldStyle(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
        fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.bold);
  }

  static Future<bool?> getInternetStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com',
          type: InternetAddressType.any);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

  static void showErrorToast(String? msg, BuildContext context,
      {int duration = 3}) {
    showToastWidget(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.red),
        child: Text(
          msg!,
          textAlign: TextAlign.center,
          style: kblackSemiNormalStyle(context).copyWith(color: white),
        ),
      ),
      context: context,
      duration: Duration(seconds: duration),
      // backgroundColor: Colors.red,
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromTopFade,
      animDuration: const Duration(milliseconds: 200),
      reverseAnimation: StyledToastAnimation.slideToTopFade,
      // textAlign: TextAlign.center,
      // textStyle:
      //     Theme.of(context).textTheme.headline6!.copyWith(color: kwhite)
    );
  }

  static void showSuccessToast1(String? msg, BuildContext context,
      {int duration = 3}) {
    showToastWidget(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.green[700]),
        child: Text(
          msg!,
          textAlign: TextAlign.center,
          style: kblackSemiNormalStyle(context).copyWith(color: white),
        ),
      ),
      context: context,
      duration: Duration(seconds: duration),
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromTopFade,
      animDuration: const Duration(milliseconds: 200),
      reverseAnimation: StyledToastAnimation.slideToTopFade,
    );
  }

  static Future<File> imgFromCamera() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    return File(pickedFile!.path);
  }

  static Future<File> imgFromGallery() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);
    return File(pickedFile!.path);
  }

  static showImagePicker(context) async {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: primaryColor,
                      ),
                      title: new Text(
                        'Gallery',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      onTap: () {
                        Navigator.of(context).pop('gallery');
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera, color: primaryColor),
                    title: new Text('Camera',
                        style: Theme.of(context).textTheme.headline3),
                    onTap: () {
                      Navigator.of(context).pop('camera');
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
