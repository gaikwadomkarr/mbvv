import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbvv/screens/criminal/add_criminal.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/widgets/custom_dropdown.dart';
import 'package:sizer/sizer.dart';

import 'custom_textfield.dart';

class DynamicRelativeForm extends StatefulWidget {
  final int? index;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  late String relation = 'selectRelation';
  DynamicRelativeForm({Key? key, this.index}) : super(key: key);

  @override
  _DynamicRelativeFormState createState() => _DynamicRelativeFormState();
}

class _DynamicRelativeFormState extends State<DynamicRelativeForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        decoration: BoxDecoration(border: Border.all(color: black)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CDropDown(
              width: 70.w,
              lable_text: 'Relation',
              // controller: widget.relationController,
              onSaved: (value) {
                setState(() {
                  widget.relation = value.toString();
                });
              },
              value: widget.relation,
              itmes: const [
                'selectRelation',
                'mother',
                'father',
                'brother',
                'sister',
                'mother-in-law',
                'father-in-law',
                'friend',
                'lawyer'
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            CTextField(
              lable_text: 'Name',
              controller: widget.nameController,
              onSaved: (value) {},
              hintTextStyle: const TextStyle(color: primaryColor),
              width: 70.w,
            ),
            SizedBox(
              height: 2.h,
            ),
            CTextField(
              lable_text: 'Address',
              controller: widget.addressController,
              onSaved: (value) {},
              hintTextStyle: const TextStyle(color: primaryColor),
              width: 70.w,
            ),
            SizedBox(
              height: 2.h,
            ),
            CTextField(
              lable_text: 'Mobile Number',
              controller: widget.mobileController,
              onSaved: (value) {},
              maxLength: 10,
              hintTextStyle: const TextStyle(color: primaryColor),
              width: 70.w,
            ),
            // SizedBox(
            //   height: 2.h,
            // ),
          ],
        ),
      ),
    );
  }
}
