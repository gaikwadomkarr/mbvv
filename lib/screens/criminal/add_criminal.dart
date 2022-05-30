import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mbvv/models/accused_list_response.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:mbvv/utils/validations.dart';
import 'package:mbvv/widgets/custom_button.dart';
import 'package:mbvv/widgets/custom_dropdown.dart';
import 'package:mbvv/widgets/custom_textfield.dart';
import 'package:mbvv/widgets/dynamic_officer_form.dart';
import 'package:mbvv/widgets/dynamic_relative_form.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart' as dio;

class AddEditCriminalRecord extends StatefulWidget {
  final Accused? accused;
  AddEditCriminalRecord({Key? key, this.accused}) : super(key: key);

  @override
  _AddEditCriminalRecordState createState() => _AddEditCriminalRecordState();
}

class _AddEditCriminalRecordState extends State<AddEditCriminalRecord> {
  // Step 1 controllers
  // TextEditingController criminalnameController = TextEditingController();
  // TextEditingController criminalaliasnameController = TextEditingController();
  // TextEditingController criminaladdressController = TextEditingController();
  // TextEditingController criminalmobileController = TextEditingController();
  // TextEditingController criminalpassportController = TextEditingController();
  // TextEditingController criminalbankacntController = TextEditingController();
  // TextEditingController criminalpannoController = TextEditingController();
  // TextEditingController criminalelectionidController = TextEditingController();
  // DateTime selectedDateTime = DateTime.now();
  // String radioButtonItem = 'Male';
  // int id = 1;
  // File? profilePicFile;
  // late String profilePicFileName = '';
  // late String selectedphotoUrl = '';
  // File? profilePicFileLeft;
  // late String profilePicFileLeftName = '';
  // late String selectedphotoLeftUrl = '';
  // File? profilePicRightFile;
  // late String profilePicRightFileName = '';
  // late String selectedphotoRightUrl = '';
  // late List<dynamic> selectedModusOperandi = [];

  // Step 2 controllers
  String? doesDrugString = 'Yes';
  int doesDrug = 1;
  String? haveInfoStrting = 'Yes';
  int haveInfo = 1;
  bool relativesexpanded = false;
  bool ploicelawyerexpanded = false;
  bool firexpanded = false;
  bool sectionexpanded = false;
  // TextEditingController checkdatetime = TextEditingController();
  // TextEditingController latlongController = TextEditingController();
  TextEditingController firnoController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController crimewayController = TextEditingController();
  TextEditingController drugsNameController = TextEditingController();
  TextEditingController moreInfoController = TextEditingController();
  late String policeStation = 'Police Station';
  double _animatedHeight = 0.0;
  double _ploicelawyeranimatedHeight = 0.0;
  double _firanimatedHeight = 0.0;
  double _sectionanimatedHeight = 0.0;
  String guestName = '', fromTime = '', toTime = '', guestPhone = '';
  TextEditingController fromtimeController = TextEditingController();
  TextEditingController totimeController = TextEditingController();

  // Step 3 controllers
  // TextEditingController vehicleController = TextEditingController();
  TextEditingController ordernoController = TextEditingController();
  // TextEditingController moreInfoController = TextEditingController();
  String? usesvehicleStrting = '2W';
  int usesvehicle = 1;
  String? isDeportedStrting = 'No';
  int isDeported = 2;
  String? carryingWeaponStrting = 'No';
  int carryingWeapon = 2;

  final _formKey1 = GlobalKey<FormState>();
  int currentStep = 0;
  late var _items;

  @override
  void initState() {
    super.initState();
    DataConstants.criminalControllerMobx.familyList.clear();
    DataConstants.criminalControllerMobx.officerList.clear();
    DataConstants.criminalControllerMobx.firnoList.clear();
    DataConstants.criminalControllerMobx.sectionList.clear();
    var modusoperandilist = ennglishMarathi["modusopoerandien"] as List;
    _items = modusoperandilist.map((e) => MultiSelectItem(e, e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: BackButton(
            color: white,
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title: Text(
            'Check-Up Form',
            style: Controller.kblackNormalStyle(context).copyWith(color: white),
          ),
        ),
        body: Observer(builder: (context) {
          return AbsorbPointer(
            absorbing:
                DataConstants.criminalControllerMobx.showCheckUpFormUpLoading,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                  child: Form(
                    key: _formKey1,
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //         setState(() {
                        //           currentStep = 0;
                        //         });
                        //       },
                        //       child: CircleAvatar(
                        //         radius: 5.w,
                        //         backgroundColor: primaryColor1,
                        //         child: const Text(
                        //           '1',
                        //           style: TextStyle(color: white),
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 25.w,
                        //       height: 0.5.h,
                        //       color: currentStep == 1 || currentStep == 2
                        //           ? primaryColor1
                        //           : grey,
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         setState(() {
                        //           currentStep = 1;
                        //         });
                        //       },
                        //       child: CircleAvatar(
                        //         radius: 5.w,
                        //         backgroundColor:
                        //             currentStep == 1 || currentStep == 2
                        //                 ? primaryColor1
                        //                 : grey,
                        //         child: const Text(
                        //           '2',
                        //           style: TextStyle(color: white),
                        //         ),
                        //       ),
                        //     ),
                        //     // Container(
                        //     //   width: 25.w,
                        //     //   height: 0.5.h,
                        //     //   color: currentStep == 2 ? primaryColor1 : grey,
                        //     // ),
                        //     // GestureDetector(
                        //     //   onTap: () {
                        //     //     setState(() {
                        //     //       currentStep = 2;
                        //     //     });
                        //     //   },
                        //     //   child: CircleAvatar(
                        //     //     radius: 5.w,
                        //     //     backgroundColor:
                        //     //         currentStep == 2 ? primaryColor1 : grey,
                        //     //     child: const Text(
                        //     //       '3',
                        //     //       style: TextStyle(color: white),
                        //     //     ),
                        //     //   ),
                        //     // ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        // if (currentStep == 0)
                        Step2Form(context),
                        // if (currentStep == 1) Step3Form(context),
                        // if (currentStep == 2) Step3Form(context)
                      ],
                    ),
                  ),
                ),
                if (DataConstants.criminalControllerMobx.showLoader)
                  Loader(
                    radius: 10.w,
                    color: primaryColor,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget Step2Form(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          children: [
            SizedBox(
              height: 2.h,
            ),
            CDropDown(
              width: double.infinity,
              lable_text: policeStation,
              // controller: widget.relationController,
              onSaved: (value) {
                setState(() {
                  policeStation = value.toString();
                });
              },
              value: policeStation,
              itmes: policeStations,
            ),
            SizedBox(
              height: 2.h,
            ),

            GestureDetector(
              onTap: () => setState(() {
                firexpanded = !firexpanded;
                _firanimatedHeight != 0.0
                    ? _firanimatedHeight = 0.0
                    : _firanimatedHeight = 300.0;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('FIR(s)',
                        style: TextStyle(fontSize: 13.sp, color: black)),
                    SizedBox(
                      width: 2.w,
                    ),
                    // GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         firexpanded = !firexpanded;
                    //         _firanimatedHeight != 0.0
                    //             ? _firanimatedHeight = 0.0
                    //             : _firanimatedHeight = 300.0;
                    //       });
                    //     },
                    //     child: Icon(
                    //         firexpanded
                    //             ? Icons.arrow_circle_up_sharp
                    //             : Icons.arrow_circle_down_sharp,
                    //         color: primaryColor)),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_firanimatedHeight != 300.0) {
                              _firanimatedHeight = 300.0;
                            }
                          });
                          DataConstants.criminalControllerMobx.addNewFIR(
                              DataConstants
                                      .criminalControllerMobx.firnoList.isEmpty
                                  ? 0
                                  : DataConstants
                                      .criminalControllerMobx.firnoList.length);
                        },
                        child: Icon(Icons.add, color: primaryColor)),
                  ],
                ),
                color: textfieldbgColor,
                height: 5.h,
                width: double.infinity,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              child: Observer(builder: (context) {
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DataConstants.criminalControllerMobx.firnoList[index],
                        GestureDetector(
                            onTap: () {
                              log('you clicked remove');
                              log(DataConstants.criminalControllerMobx
                                  .firnoList[index].firnoController.text
                                  .toString());

                              DataConstants.criminalControllerMobx
                                  .removeFIR(index);
                            },
                            child: CircleAvatar(
                              radius: 5.w,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.remove, color: white),
                            ))
                      ],
                    );
                  },
                  itemCount:
                      DataConstants.criminalControllerMobx.firnoList.length,
                );
              }),
              // height: _firanimatedHeight,
              color: textfieldbgColor,
              width: double.infinity,
            ),

            SizedBox(
              height: 2.h,
            ),
            GestureDetector(
              onTap: () => setState(() {
                sectionexpanded = !sectionexpanded;
                _sectionanimatedHeight != 0.0
                    ? _sectionanimatedHeight = 0.0
                    : _sectionanimatedHeight = 300.0;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Section(s)',
                        style: TextStyle(fontSize: 13.sp, color: black)),
                    SizedBox(
                      width: 2.w,
                    ),
                    // GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         sectionexpanded = !sectionexpanded;
                    //         _sectionanimatedHeight != 0.0
                    //             ? _sectionanimatedHeight = 0.0
                    //             : _sectionanimatedHeight = 300.0;
                    //       });
                    //     },
                    //     child: Icon(
                    //         sectionexpanded
                    //             ? Icons.arrow_circle_up_sharp
                    //             : Icons.arrow_circle_down_sharp,
                    //         color: primaryColor)),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_sectionanimatedHeight != 300.0) {
                              _sectionanimatedHeight = 300.0;
                            }
                          });
                          DataConstants.criminalControllerMobx.addNewSection(
                              DataConstants.criminalControllerMobx.sectionList
                                      .isEmpty
                                  ? 0
                                  : DataConstants.criminalControllerMobx
                                      .sectionList.length);
                        },
                        child: Icon(Icons.add, color: primaryColor)),
                  ],
                ),
                color: textfieldbgColor,
                height: 5.h,
                width: double.infinity,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              child: Observer(builder: (context) {
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DataConstants.criminalControllerMobx.sectionList[index],
                        GestureDetector(
                            onTap: () {
                              log('you clicked remove');
                              log(DataConstants.criminalControllerMobx
                                  .sectionList[index].sectionController.text
                                  .toString());

                              DataConstants.criminalControllerMobx
                                  .removeSection(index);
                            },
                            child: CircleAvatar(
                              radius: 5.w,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.remove, color: white),
                            ))
                      ],
                    );
                  },
                  itemCount:
                      DataConstants.criminalControllerMobx.sectionList.length,
                );
              }),
              // height: _sectionanimatedHeight,
              color: textfieldbgColor,
              width: double.infinity,
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              color: textfieldbgColor,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(ennglishMarathi['doesdrugen'].toString(),
                        style: TextStyle(fontSize: 13.sp, color: black)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: doesDrug,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          setState(() {
                            doesDrugString =
                                ennglishMarathi['yesen'].toString();
                            doesDrug = 1;
                          });
                        },
                      ),
                      Text(
                        ennglishMarathi['yesen'].toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Radio(
                        value: 2,
                        groupValue: doesDrug,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          setState(() {
                            doesDrugString = ennglishMarathi['noen'].toString();
                            doesDrug = 2;
                          });
                        },
                      ),
                      Text(
                        ennglishMarathi['noen'].toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Radio(
                        value: 3,
                        groupValue: doesDrug,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          setState(() {
                            doesDrugString =
                                ennglishMarathi['sometimesen'].toString();
                            doesDrug = 3;
                          });
                        },
                      ),
                      Text(
                        ennglishMarathi['sometimesen'].toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  if (doesDrug == 1)
                    SizedBox(
                      height: 2.h,
                    ),
                  if (doesDrug == 1)
                    CTextField(
                      lable_text: ennglishMarathi['whichdrugsen'].toString(),
                      controller: drugsNameController,
                      onSaved: (value) {},
                      width: double.infinity,
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            // CTextField(
            //   lable_text: ennglishMarathi['moreinfoen'].toString(),
            //   expands: true,
            //   maxline: 3,
            //   controller: moreInfoController,
            //   onSaved: (value) {},
            //   width: double.infinity,
            //   hintTextStyle: Controller.kwhiteSmallStyle(context, black),
            // ),
            // SizedBox(
            //   height: 2.h,
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              color: textfieldbgColor,
              // decoration: BoxDecoration(
              //     border: Border.all(color: primaryColor, width: 1)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(ennglishMarathi['moreinfoen'].toString(),
                        style: TextStyle(fontSize: 13.sp, color: black)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: haveInfo,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          setState(() {
                            haveInfoStrting =
                                ennglishMarathi['yesen'].toString();
                            haveInfo = 1;
                          });
                        },
                      ),
                      Text(
                        ennglishMarathi['yesen'].toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Radio(
                        value: 2,
                        groupValue: haveInfo,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          setState(() {
                            haveInfoStrting =
                                ennglishMarathi['noen'].toString();
                            haveInfo = 2;
                          });
                        },
                      ),
                      Text(
                        ennglishMarathi['noen'].toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  if (haveInfo == 1)
                    SizedBox(
                      height: 2.h,
                    ),
                  if (haveInfo == 1)
                    CTextField(
                      lable_text: ennglishMarathi['moreinfoen'].toString(),
                      expands: true,
                      maxline: 3,
                      controller: moreInfoController,
                      onSaved: (value) {},
                      width: double.infinity,
                      hintTextStyle:
                          Controller.kwhiteSmallStyle(context, black),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              color: textfieldbgColor,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Does the accused carried deadly weapon?',
                        style: TextStyle(fontSize: 13.sp, color: black)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: carryingWeapon,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          setState(() {
                            carryingWeaponStrting = 'Yes';
                            carryingWeapon = 1;
                          });
                        },
                      ),
                      Text(
                        'Yes',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Radio(
                        value: 2,
                        groupValue: carryingWeapon,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          setState(() {
                            carryingWeaponStrting = 'No';
                            carryingWeapon = 2;
                          });
                        },
                      ),
                      Text(
                        'No',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 2.h,
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            //   color: textfieldbgColor,
            //   // decoration: BoxDecoration(
            //   //     border: Border.all(color: primaryColor, width: 1)),
            //   child: Column(
            //     children: [
            //       Container(
            //         alignment: Alignment.topLeft,
            //         child: Text('Whether this accused is a deported accused?',
            //             style: TextStyle(fontSize: 13.sp, color: black)),
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Radio(
            //             value: 1,
            //             groupValue: isDeported,
            //             activeColor: primaryColor,
            //             onChanged: (val) {
            //               setState(() {
            //                 isDeportedStrting = 'Yes';
            //                 isDeported = 1;
            //               });
            //             },
            //           ),
            //           Text(
            //             'Yes',
            //             style: Theme.of(context).textTheme.subtitle1,
            //           ),
            //           Radio(
            //             value: 2,
            //             groupValue: isDeported,
            //             activeColor: primaryColor,
            //             onChanged: (val) {
            //               setState(() {
            //                 isDeportedStrting = 'No';
            //                 isDeported = 2;
            //               });
            //             },
            //           ),
            //           Text(
            //             'No',
            //             style: Theme.of(context).textTheme.subtitle1,
            //           ),
            //         ],
            //       ),
            //       if (isDeported == 1)
            //         SizedBox(
            //           height: 2.h,
            //         ),
            //       if (isDeported == 1)
            //         Column(
            //           children: [
            //             CTextField(
            //               lable_text: 'Order Number',
            //               controller: ordernoController,
            //               onSaved: (value) {},
            //               width: double.infinity,
            //             ),
            //             Container(
            //               margin: EdgeInsets.only(top: 2.h),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                   GestureDetector(
            //                     onTap: () async {
            //                       FocusScope.of(context).unfocus();
            //                       var selectedDate = await showDatePicker(
            //                           context: context,
            //                           firstDate: DateTime(1900, 1, 1),
            //                           lastDate: DateTime.now(),
            //                           fieldHintText: 'Select From Date',
            //                           helpText: 'SELECT FROM DATE',
            //                           initialDate: DateTime.now());
            //                       if (selectedDate != null) {
            //                         log(selectedDate.toString());
            //                         setState(() {
            //                           fromtimeController.text =
            //                               DateFormat('dd-MM-yyyy')
            //                                   .format(selectedDate);
            //                           fromTime = selectedDate.toString();
            //                         });
            //                       }
            //                     },
            //                     child: AbsorbPointer(
            //                       child: Container(
            //                         width: 40.w,
            //                         alignment: Alignment.center,
            //                         padding: EdgeInsets.symmetric(
            //                             vertical: 1.3.h, horizontal: 3.w),
            //                         decoration: BoxDecoration(
            //                             borderRadius:
            //                                 BorderRadius.circular(3.w),
            //                             border: const Border.fromBorderSide(
            //                                 BorderSide(
            //                                     width: 1,
            //                                     style: BorderStyle.solid,
            //                                     color: primaryColor))),
            //                         child: Text(
            //                           fromtimeController.text.isEmpty
            //                               ? 'From Date'
            //                               : fromtimeController.text,
            //                           style: Controller.kblackSemiNormalStyle(
            //                                   context)
            //                               .copyWith(
            //                                   fontSize: 12.sp,
            //                                   color: primaryColor),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 5.w,
            //                   ),
            //                   GestureDetector(
            //                     onTap: () async {
            //                       var selectedDate = await showDatePicker(
            //                           context: context,
            //                           firstDate: DateTime(1900, 1, 1),
            //                           lastDate: DateTime.now(),
            //                           fieldHintText: 'Select From Date',
            //                           helpText: 'SELECT FROM DATE',
            //                           initialDate: DateTime.now());
            //                       if (selectedDate != null) {
            //                         log('slected to time => ${selectedDate.toString()}');
            //                         setState(() {
            //                           totimeController.text =
            //                               fromtimeController.text =
            //                                   DateFormat('dd-MM-yyyy')
            //                                       .format(selectedDate);

            //                           toTime = selectedDate.toString();
            //                         });
            //                       }
            //                     },
            //                     child: AbsorbPointer(
            //                       child: Container(
            //                         width: 40.w,
            //                         // height: 5.h,
            //                         alignment: Alignment.center,
            //                         padding: EdgeInsets.symmetric(
            //                             vertical: 1.3.h, horizontal: 3.w),
            //                         decoration: BoxDecoration(
            //                             borderRadius:
            //                                 BorderRadius.circular(3.w),
            //                             border: const Border.fromBorderSide(
            //                                 BorderSide(
            //                                     width: 1,
            //                                     style: BorderStyle.solid,
            //                                     color: primaryColor))),
            //                         child: Text(
            //                           totimeController.text.isEmpty
            //                               ? 'To Date'
            //                               : totimeController.text,
            //                           style: Controller.kblackSemiNormalStyle(
            //                                   context)
            //                               .copyWith(
            //                                   fontSize: 12.sp,
            //                                   color: primaryColor),
            //                         ),
            //                       ),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //     ],
            //   ),
            // ),

            // SizedBox(
            //   height: 2.h,
            // ),
            GestureDetector(
              onTap: () => setState(() {
                // ploicelawyerexpanded = !ploicelawyerexpanded;
                // _ploicelawyeranimatedHeight != 0.0
                //     ? _ploicelawyeranimatedHeight = 0.0
                //     : _ploicelawyeranimatedHeight = 300.0;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Officer/Policeman',
                        style: TextStyle(fontSize: 13.sp, color: black)),
                    SizedBox(
                      width: 2.w,
                    ),
                    // GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         ploicelawyerexpanded = !ploicelawyerexpanded;
                    //         _ploicelawyeranimatedHeight != 0.0
                    //             ? _ploicelawyeranimatedHeight = 0.0
                    //             : _ploicelawyeranimatedHeight = 300.0;
                    //       });
                    //     },
                    //     child: Icon(
                    //         ploicelawyerexpanded
                    //             ? Icons.arrow_circle_up_sharp
                    //             : Icons.arrow_circle_down_sharp,
                    //         color: primaryColor)),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            ploicelawyerexpanded = !ploicelawyerexpanded;

                            if (_ploicelawyeranimatedHeight != 300.0) {
                              _ploicelawyeranimatedHeight = 300.0;
                            }
                          });
                          DataConstants.criminalControllerMobx.addNewOfficer(
                              DataConstants.criminalControllerMobx.officerList
                                      .isEmpty
                                  ? 0
                                  : DataConstants.criminalControllerMobx
                                      .officerList.length);
                        },
                        child: const Icon(Icons.add, color: primaryColor)),
                  ],
                ),
                color: textfieldbgColor,
                height: 5.h,
                width: double.infinity,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              padding: EdgeInsets.only(left: 2.w),
              // decoration: BoxDecoration(bor),
              child: Observer(builder: (context) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          DataConstants
                              .criminalControllerMobx.officerList[index],
                          SizedBox(
                            width: 3.w,
                          ),
                          GestureDetector(
                              onTap: () {
                                log('you clicked remove');
                                log(DataConstants.criminalControllerMobx
                                    .officerList[index].relation
                                    .toString());

                                DataConstants.criminalControllerMobx
                                    .removeOfficer(index);
                              },
                              child: CircleAvatar(
                                radius: 5.w,
                                backgroundColor: Colors.red,
                                child: const Icon(Icons.remove, color: white),
                              ))
                        ],
                      ),
                    );
                  },
                  itemCount:
                      DataConstants.criminalControllerMobx.officerList.length,
                );
              }),
              // height: _ploicelawyeranimatedHeight,
              color: textfieldbgColor,
              width: double.infinity,
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 5.h,
            ),
            CGradientButton(
              buttonName: "SUBMIT",
              onPress: () {
                sendCheckUpForm();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget Step3Form(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          children: [
            SizedBox(
              height: 2.h,
            ),
            // GestureDetector(
            //   onTap: () async {
            //     Location location = new Location();
            //     LocationData _pos = await location.getLocation();
            //     setState(() {
            //       latlongController.text =
            //           'रेखांश :- ${_pos.latitude!.toStringAsFixed(3)}      अक्षांश :- ${_pos.longitude!.toStringAsFixed(3)}';
            //     });
            //   },
            //   child: AbsorbPointer(
            //     child: CTextField(
            //       lable_text: 'जिपीएस लोकेशन निवडा',
            //       controller: latlongController,
            //       onSaved: (value) {},
            //       hintTextStyle: const TextStyle(color: primaryColor),
            //       width: double.infinity,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 2.h,
            // ),
            // Observer(builder: (context) {
            //   return ExpansionTile(
            //       title: Row(
            //         mainAxisAlignment:
            //             MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text('परिवार/नातेवाईक/मित्र',
            //               style: TextStyle(fontSize: 13.sp)),
            //           GestureDetector(
            //               onTap: () {
            //                 DataConstants.criminalControllerMobx
            //                     .addNewRelation();
            //               },
            //               child: Icon(Icons.add,
            //                   color: primaryColor))
            //         ],
            //       ),
            //       maintainState: true,
            //       children: DataConstants
            //           .criminalControllerMobx.familyList);
            // }),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              color: textfieldbgColor,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Does the accused carried deadly weapon?',
                        style: TextStyle(fontSize: 13.sp, color: black)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: carryingWeapon,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          setState(() {
                            carryingWeaponStrting = 'Yes';
                            carryingWeapon = 1;
                          });
                        },
                      ),
                      Text(
                        'Yes',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Radio(
                        value: 2,
                        groupValue: carryingWeapon,
                        activeColor: primaryColor,
                        onChanged: (val) {
                          setState(() {
                            carryingWeaponStrting = 'No';
                            carryingWeapon = 2;
                          });
                        },
                      ),
                      Text(
                        'No',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 2.h,
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            //   color: textfieldbgColor,
            //   // decoration: BoxDecoration(
            //   //     border: Border.all(color: primaryColor, width: 1)),
            //   child: Column(
            //     children: [
            //       Container(
            //         alignment: Alignment.topLeft,
            //         child: Text('Whether this accused is a deported accused?',
            //             style: TextStyle(fontSize: 13.sp, color: black)),
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Radio(
            //             value: 1,
            //             groupValue: isDeported,
            //             activeColor: primaryColor,
            //             onChanged: (val) {
            //               setState(() {
            //                 isDeportedStrting = 'Yes';
            //                 isDeported = 1;
            //               });
            //             },
            //           ),
            //           Text(
            //             'Yes',
            //             style: Theme.of(context).textTheme.subtitle1,
            //           ),
            //           Radio(
            //             value: 2,
            //             groupValue: isDeported,
            //             activeColor: primaryColor,
            //             onChanged: (val) {
            //               setState(() {
            //                 isDeportedStrting = 'No';
            //                 isDeported = 2;
            //               });
            //             },
            //           ),
            //           Text(
            //             'No',
            //             style: Theme.of(context).textTheme.subtitle1,
            //           ),
            //         ],
            //       ),
            //       if (isDeported == 1)
            //         SizedBox(
            //           height: 2.h,
            //         ),
            //       if (isDeported == 1)
            //         Column(
            //           children: [
            //             CTextField(
            //               lable_text: 'Order Number',
            //               controller: ordernoController,
            //               onSaved: (value) {},
            //               width: double.infinity,
            //             ),
            //             Container(
            //               margin: EdgeInsets.only(top: 2.h),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                   GestureDetector(
            //                     onTap: () async {
            //                       FocusScope.of(context).unfocus();
            //                       var selectedDate = await showDatePicker(
            //                           context: context,
            //                           firstDate: DateTime(1900, 1, 1),
            //                           lastDate: DateTime.now(),
            //                           fieldHintText: 'Select From Date',
            //                           helpText: 'SELECT FROM DATE',
            //                           initialDate: DateTime.now());
            //                       if (selectedDate != null) {
            //                         log(selectedDate.toString());
            //                         setState(() {
            //                           fromtimeController.text =
            //                               DateFormat('dd-MM-yyyy')
            //                                   .format(selectedDate);
            //                           fromTime = selectedDate.toString();
            //                         });
            //                       }
            //                     },
            //                     child: AbsorbPointer(
            //                       child: Container(
            //                         width: 40.w,
            //                         alignment: Alignment.center,
            //                         padding: EdgeInsets.symmetric(
            //                             vertical: 1.3.h, horizontal: 3.w),
            //                         decoration: BoxDecoration(
            //                             borderRadius:
            //                                 BorderRadius.circular(3.w),
            //                             border: const Border.fromBorderSide(
            //                                 BorderSide(
            //                                     width: 1,
            //                                     style: BorderStyle.solid,
            //                                     color: primaryColor))),
            //                         child: Text(
            //                           fromtimeController.text.isEmpty
            //                               ? 'From Date'
            //                               : fromtimeController.text,
            //                           style: Controller.kblackSemiNormalStyle(
            //                                   context)
            //                               .copyWith(
            //                                   fontSize: 12.sp,
            //                                   color: primaryColor),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 5.w,
            //                   ),
            //                   GestureDetector(
            //                     onTap: () async {
            //                       var selectedDate = await showDatePicker(
            //                           context: context,
            //                           firstDate: DateTime(1900, 1, 1),
            //                           lastDate: DateTime.now(),
            //                           fieldHintText: 'Select From Date',
            //                           helpText: 'SELECT FROM DATE',
            //                           initialDate: DateTime.now());
            //                       if (selectedDate != null) {
            //                         log('slected to time => ${selectedDate.toString()}');
            //                         setState(() {
            //                           totimeController.text =
            //                               fromtimeController.text =
            //                                   DateFormat('dd-MM-yyyy')
            //                                       .format(selectedDate);

            //                           toTime = selectedDate.toString();
            //                         });
            //                       }
            //                     },
            //                     child: AbsorbPointer(
            //                       child: Container(
            //                         width: 40.w,
            //                         // height: 5.h,
            //                         alignment: Alignment.center,
            //                         padding: EdgeInsets.symmetric(
            //                             vertical: 1.3.h, horizontal: 3.w),
            //                         decoration: BoxDecoration(
            //                             borderRadius:
            //                                 BorderRadius.circular(3.w),
            //                             border: const Border.fromBorderSide(
            //                                 BorderSide(
            //                                     width: 1,
            //                                     style: BorderStyle.solid,
            //                                     color: primaryColor))),
            //                         child: Text(
            //                           totimeController.text.isEmpty
            //                               ? 'To Date'
            //                               : totimeController.text,
            //                           style: Controller.kblackSemiNormalStyle(
            //                                   context)
            //                               .copyWith(
            //                                   fontSize: 12.sp,
            //                                   color: primaryColor),
            //                         ),
            //                       ),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //     ],
            //   ),
            // ),

            // SizedBox(
            //   height: 2.h,
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Officer/Policeman1',
                      style: TextStyle(fontSize: 13.sp, color: black)),
                  SizedBox(
                    width: 2.w,
                  ),
                  // GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         ploicelawyerexpanded = !ploicelawyerexpanded;
                  //         _ploicelawyeranimatedHeight != 0.0
                  //             ? _ploicelawyeranimatedHeight = 0.0
                  //             : _ploicelawyeranimatedHeight = 300.0;
                  //       });
                  //     },
                  //     child: Icon(
                  //         ploicelawyerexpanded
                  //             ? Icons.arrow_circle_up_sharp
                  //             : Icons.arrow_circle_down_sharp,
                  //         color: primaryColor)),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          ploicelawyerexpanded = !ploicelawyerexpanded;

                          if (_ploicelawyeranimatedHeight != 300.0) {
                            _ploicelawyeranimatedHeight = 300.0;
                          }
                        });
                        DataConstants.criminalControllerMobx.addNewOfficer(
                            DataConstants
                                    .criminalControllerMobx.officerList.isEmpty
                                ? 0
                                : DataConstants
                                    .criminalControllerMobx.officerList.length);
                      },
                      child: const Icon(Icons.add, color: primaryColor)),
                ],
              ),
              color: textfieldbgColor,
              height: 5.h,
              width: double.infinity,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              child: Observer(builder: (context) {
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DataConstants
                                .criminalControllerMobx.officerList[index],
                            GestureDetector(
                                onTap: () {
                                  log('you clicked remove');
                                  log(DataConstants.criminalControllerMobx
                                      .officerList[index].relation
                                      .toString());

                                  DataConstants.criminalControllerMobx
                                      .removeOfficer(index);
                                },
                                child: CircleAvatar(
                                  radius: 5.w,
                                  backgroundColor: Colors.red,
                                  child: const Icon(Icons.remove, color: white),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount:
                      DataConstants.criminalControllerMobx.officerList.length,
                );
              }),
              // height: _ploicelawyeranimatedHeight,
              color: textfieldbgColor,
              width: double.infinity,
            ),
            SizedBox(
              height: 2.h,
            ),
            Observer(builder: (context) {
              return CGradientButton(
                buttonName: DataConstants
                        .criminalControllerMobx.showCheckUpFormUpLoading
                    ? ''
                    : "SUBMIT",
                icon: DataConstants
                        .criminalControllerMobx.showCheckUpFormUpLoading
                    ? const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: white,
                        ),
                      )
                    : null,
                onPress: DataConstants
                        .criminalControllerMobx.showCheckUpFormUpLoading
                    ? null
                    : () {
                        sendCheckUpForm();
                      },
              );
            })
          ],
        ),
      ),
    );
  }

  void sendCheckUpForm() async {
    var map = {};
    if (policeStation == 'Police Station') {
      Controller.showErrorToast('PLease select police station', context);
      setState(() {
        currentStep = 0;
      });
      return;
    } else {
      map["policeStation"] = policeStation;
    }
    var firList = [];
    if (DataConstants.criminalControllerMobx.firnoList.isNotEmpty) {
      for (var element in DataConstants.criminalControllerMobx.firnoList) {
        firList.add(element.firnoController.text);
      }
      map["firstInformationReport"] = firList;
    }
    var sectionList = [];
    if (DataConstants.criminalControllerMobx.sectionList.isNotEmpty) {
      for (var element in DataConstants.criminalControllerMobx.sectionList) {
        sectionList.add(element.sectionController.text);
      }
      map["crimeSection"] = sectionList;
    }

    // // if (currentjobController.text != '' ||
    // //     companyNameController.text != '' ||
    // //     companyOwnerNameController.text != '') {
    // var jobDetails = {};
    // // if (companyowneraddressController.text != '') {
    // jobDetails["companyLocation"] = companyowneraddressController.text != ''
    //     ? companyowneraddressController.text
    //     : 'NA';
    // // }
    // // if (companyNameController.text != '') {
    // jobDetails["companyName"] =
    //     companyNameController.text != '' ? companyNameController.text : 'NA';
    // // }
    // // if (companyOwnerNameController.text != '') {
    // jobDetails["companyOwnerName"] = companyOwnerNameController.text != ''
    //     ? companyOwnerNameController.text
    //     : 'NA';
    // // }
    // // if (currentjobController.text != '') {
    // jobDetails["currentWork"] =
    //     currentjobController.text != '' ? currentjobController.text : 'NA';
    // // }

    // map["currentJobDetails"] = jobDetails;
    // // }

    map["isAccusedCarryingHarmfulWeapon"] = carryingWeapon == 1 ? true : false;

    if (doesDrug == 1 && drugsNameController.text == '') {
      Controller.showErrorToast('Please enter drugs name', context);
      setState(() {
        currentStep = 0;
      });
      return;
    } else {
      map["consumptionOrInfluenceOfNDPSDrugs"] = {
        "doesCriminalConsumesDrugs": doesDrug == 1 ? "Yes" : 'No',
        "drugsConsumed":
            drugsNameController.text != '' ? drugsNameController.text : 'NA'
      };
    }
    if (haveInfo == 1 && moreInfoController.text == '') {
      Controller.showErrorToast('Please enter more info', context);
      setState(() {
        currentStep = 0;
      });
      return;
    } else {
      map["infoAboutCriminals"] = {
        "doesAccusedHaveInfo": haveInfo == 1 ? true : false,
        "description":
            moreInfoController.text != '' ? moreInfoController.text : 'NA'
      };
    }
    // if (usesvehicle == 1 && vehicleController.text == '') {
    //   Controller.showErrorToast('Please enter Vehicle number', context);
    //   return;
    // } else {
    //   map["currentlyUsedVehicleDetails"] = {
    //     "vehicleType": usesvehicleStrting,
    //     "vehicleNo":
    //         vehicleController.text != '' ? vehicleController.text : 'NA'
    //   };
    // }
    // if (isDeported == 1 &&
    //     (ordernoController.text == '' ||
    //         fromtimeController.text == '' ||
    //         totimeController.text == '')) {
    //   Controller.showErrorToast('Please enter all Deported Details', context);
    //   return;
    // } else {
    //   if (isDeported == 1) {
    //     map["deportedAccused"] = {
    //       "isAccusedDeported": isDeported == 1 ? true : false,
    //       "orderNo":
    //           ordernoController.text != '' ? ordernoController.text : 'NA',
    //       "fromDate": fromTime,
    //       "toDate": toTime
    //     };
    //   } else {
    //     map["deportedAccused"] = {
    //       "isAccusedDeported": isDeported == 1 ? true : false,
    //     };
    //   }
    // }
    var officerList = [];
    if (DataConstants.criminalControllerMobx.officerList.isNotEmpty) {
      for (var element in DataConstants.criminalControllerMobx.officerList) {
        if (element.policeStation == "Select Unit" ||
            element.policeStation == "Police Station") {
          Controller.showErrorToast(
              'Please select Police Statio/Sepcial Unit', context);
          return;
        }
        if (element.nameController.text.isEmpty) {
          Controller.showErrorToast(
              'Please enter officer/policeman name', context);
          return;
        }
        officerList.add({
          "department": element.policeStation,
          "officerOrPolicemanName": element.nameController.text,
          "officerOrPolicemanMobileNo": element.mobileController.text,
          "isFromDepartment": element.isFromDepartment
        });
      }
      map["officerOrPolicemanKnowingAccused"] = officerList;
    }

    Location location = new Location();
    LocationData _pos = await location.getLocation();

    map["lat"] = _pos.latitude!.toStringAsFixed(3);
    map["long"] = _pos.longitude!.toStringAsFixed(3);
    // map["lat"] = '19.187';
    // map["long"] = '24.432';
    // log(map.toString());
    log(jsonEncode(map));
    DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = true;
    Controller.getInternetStatus().then((value) async {
      print("this is internet status $value ");
      if (value!) {
        DataConstants.allApisHandling
            .addCheckUpForm(map, context, widget.accused!.sId!);
      } else {
        DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = false;
        Controller.showSuccessToast1("No internet connection!", context);
      }
    });
  }
}
