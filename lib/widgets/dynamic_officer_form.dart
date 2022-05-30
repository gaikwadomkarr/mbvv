import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbvv/screens/criminal/add_criminal.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:mbvv/widgets/custom_dropdown.dart';
import 'package:sizer/sizer.dart';

import 'custom_textfield.dart';

class DynamicOfficerForm extends StatefulWidget {
  final int? index;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  late String relation = 'Select Relation';
  late String policeStation = 'Police Station';
  String? isFromDepartment = 'policeStation';
  int departmentId = 1;
  DynamicOfficerForm({Key? key, this.index}) : super(key: key);

  @override
  _DynamicOfficerFormState createState() => _DynamicOfficerFormState();
}

class _DynamicOfficerFormState extends State<DynamicOfficerForm> {
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
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        decoration: BoxDecoration(border: Border.all(color: black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 3.w),
                  child: Text('Is From',
                      style: TextStyle(fontSize: 13.sp, color: black)),
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: widget.departmentId,
                      activeColor: primaryColor,
                      onChanged: (val) {
                        setState(() {
                          widget.isFromDepartment = 'policeStation';
                          widget.departmentId = 1;
                          widget.policeStation = 'Police Station';
                        });
                      },
                    ),
                    Text(
                      'Police Station',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Radio(
                      value: 2,
                      groupValue: widget.departmentId,
                      activeColor: primaryColor,
                      onChanged: (val) {
                        setState(() {
                          widget.isFromDepartment = 'specialUnit';
                          widget.departmentId = 2;
                          widget.policeStation = 'Select Unit';
                        });
                      },
                    ),
                    Text(
                      'Special Unit',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // CDropDown(
                //   width: 50.w,
                //   lable_text: 'Relation',
                //   // controller: widget.relationController,
                //   onSaved: (value) {
                //     setState(() {
                //       widget.relation = value.toString();
                //     });
                //   },
                //   value: widget.relation,
                //   itmes: const [
                //     'Select Relation',
                //     'officer',
                //     'policeman',
                //   ],
                // ),
                // SizedBox(
                //   width: 2.w,
                // ),

                CDropDown(
                    width: widget.departmentId == 1 ? 70.w : 70.w,
                    lable_text: widget.departmentId == 1
                        ? 'Police Station'
                        : 'Special Unit',
                    // controller: widget.relationController,
                    onSaved: (value) {
                      setState(() {
                        widget.policeStation = value.toString();
                      });
                    },
                    value: widget.policeStation,
                    itmes: widget.departmentId == 1
                        ? policeStations
                        : specialUnits),
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
                  lable_text: 'Mobile Number',
                  controller: widget.mobileController,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) {},
                  hintTextStyle: const TextStyle(color: primaryColor),
                  width: 70.w,
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
