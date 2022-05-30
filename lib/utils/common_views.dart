import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'color_constants.dart';
import 'controller.dart';

class CommonView {
  static OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: new BorderRadius.all(Radius.circular(10.w)),
      borderSide: new BorderSide(
          width: 0.8, style: BorderStyle.solid, color: Colors.redAccent));
  static OutlineInputBorder enableBorder = new OutlineInputBorder(
      borderRadius: new BorderRadius.all(Radius.circular(10.w)),
      borderSide: new BorderSide(
          width: 0.8, style: BorderStyle.solid, color: Colors.grey));
  static OutlineInputBorder focusBorder = new OutlineInputBorder(
      borderRadius: new BorderRadius.all(Radius.circular(10.w)),
      borderSide: new BorderSide(
          width: 0.8, style: BorderStyle.solid, color: primaryColor));

  // for max line
  static OutlineInputBorder errorBorderMaxLine = OutlineInputBorder(
      borderRadius: new BorderRadius.all(Radius.circular(5.w)),
      borderSide: new BorderSide(
          width: 0.8, style: BorderStyle.solid, color: Colors.redAccent));
  static OutlineInputBorder enableBorderMaxLine = new OutlineInputBorder(
      borderRadius: new BorderRadius.all(Radius.circular(5.w)),
      borderSide: new BorderSide(
          width: 0.8, style: BorderStyle.solid, color: Colors.grey));
  static OutlineInputBorder focusBorderMaxLine = new OutlineInputBorder(
      borderRadius: new BorderRadius.all(Radius.circular(5.w)),
      borderSide: new BorderSide(
          width: 0.8, style: BorderStyle.solid, color: primaryColor));

  static BoxDecoration dropDownDecoration = new BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
          color: primaryColor, style: BorderStyle.solid, width: 0.5));

  static final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    onPrimary: white,
    primary: white,
    fixedSize: Size(140.w, 42.h),
    padding: EdgeInsets.symmetric(horizontal: 7.w),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
  static Widget buildDetails(String heading, String value, BuildContext context,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.h),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(
              heading,
              style: Controller.kblackSemiNormalStyle(context)
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Container(
            child: Text(
              value,
              style: Controller.kblackSemiNormalStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}
