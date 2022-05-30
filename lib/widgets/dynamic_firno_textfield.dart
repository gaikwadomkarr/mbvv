import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbvv/screens/criminal/add_criminal.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:mbvv/widgets/custom_dropdown.dart';
import 'package:sizer/sizer.dart';

import 'custom_textfield.dart';

class DynamicFIRnoTextField extends StatefulWidget {
  final int? index;
  final TextEditingController firnoController = TextEditingController();
  DynamicFIRnoTextField({Key? key, this.index}) : super(key: key);

  @override
  _DynamicFIRnoTextFieldState createState() => _DynamicFIRnoTextFieldState();
}

class _DynamicFIRnoTextFieldState extends State<DynamicFIRnoTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: CTextField(
          lable_text: ennglishMarathi['firnoen'].toString(),
          controller: widget.firnoController,
          onSaved: (value) {},
          hintTextStyle: const TextStyle(color: primaryColor),
          width: 70.w,
        ),
      ),
    );
  }
}
