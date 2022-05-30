import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbvv/screens/criminal/add_criminal.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:mbvv/widgets/custom_dropdown.dart';
import 'package:sizer/sizer.dart';

import 'custom_textfield.dart';

class DynamicSectionTextField extends StatefulWidget {
  final int? index;
  final TextEditingController sectionController = TextEditingController();
  DynamicSectionTextField({Key? key, this.index}) : super(key: key);

  @override
  _DynamicSectionTextFieldState createState() =>
      _DynamicSectionTextFieldState();
}

class _DynamicSectionTextFieldState extends State<DynamicSectionTextField> {
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
          lable_text: ennglishMarathi['sectionen'].toString(),
          controller: widget.sectionController,
          onSaved: (value) {},
          hintTextStyle: const TextStyle(color: primaryColor),
          width: 70.w,
        ),
      ),
    );
  }
}
