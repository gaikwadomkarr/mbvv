import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:mbvv/models/accused_list_response.dart';
import 'package:mbvv/utils/aadhar_input_formatter.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:mbvv/utils/validations.dart';
import 'package:mbvv/widgets/custom_button.dart';
import 'package:mbvv/widgets/custom_textfield.dart';
import 'package:mbvv/widgets/gf_loader.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart' as dio;

import '../../widgets/custom_dropdown.dart';

class AddNewAccused extends StatefulWidget {
  final Accused? accusedDetails;
  const AddNewAccused({Key? key, this.accusedDetails}) : super(key: key);

  @override
  _AddNewAccusedState createState() => _AddNewAccusedState();
}

class _AddNewAccusedState extends State<AddNewAccused> {
  // Step 1 controllers
  ScrollController scrollController = ScrollController();
  TextEditingController criminalnameController = TextEditingController();
  TextEditingController criminalaliasnameController = TextEditingController();
  TextEditingController criminaladdressController = TextEditingController();
  TextEditingController criminalmobileController = TextEditingController();
  TextEditingController criminalaadharnoController = TextEditingController();
  TextEditingController criminalpassportController = TextEditingController();
  TextEditingController criminalbankacntController = TextEditingController();
  TextEditingController criminalpannoController = TextEditingController();
  TextEditingController criminalelectionidController = TextEditingController();
  TextEditingController currentjobController = TextEditingController();
  TextEditingController companyOwnerNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyowneraddressController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  String radioButtonItem = 'Male';
  int id = 1;
  File? profilePicFile;
  late String profilePicFileName = '';
  late String selectedphotoUrl = '';
  File? profilePicFileLeft;
  late String profilePicFileLeftName = '';
  late String selectedphotoLeftUrl = '';
  File? profilePicRightFile;
  late String profilePicRightFileName = '';
  late String selectedphotoRightUrl = '';
  late List<dynamic> selectedModusOperandi = [];
  final _formKey1 = GlobalKey<FormState>();
  late var _items;
  bool isadded = false;
  double _animatedHeight = 0.0;
  bool relativesexpanded = false;
  bool ploicelawyerexpanded = false;
  bool isPassportNumberVerified = false;
  bool isPANNumberVerified = false;
  bool isAadharNumberVerified = false;
  bool isElectionIDVerified = false;
  bool isMobileNumberVerified = false;
  String? usesvehicleStrting = 'noVehicleUsed';
  int usesvehicle = 1;
  DateTime? _chosenDateTime;

  @override
  void initState() {
    super.initState();
    var modusoperandilist = ennglishMarathi["modusopoerandien"] as List;
    _items = modusoperandilist.map((e) => MultiSelectItem(e, e)).toList();
    // var date = DateTime.parse("00:15:00");

    if (widget.accusedDetails != null) {}
  }

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 28.h,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        dateOrder: DatePickerDateOrder.dmy,
                        initialDateTime: DateTime(1990, 1, 01),
                        maximumDate: DateTime.now(),
                        minimumDate: DateTime(1900, 1, 01),
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            _chosenDateTime = dateTime;
                          });
                        }),
                  ),

                  // Close the modal
                  CGradientButton(
                    buttonName: 'Done',
                    onPress: () {
                      Get.back();
                    },
                  )
                ],
              ),
            ));
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
            'Add Accused Details',
            style: Controller.kblackNormalStyle(context).copyWith(color: white),
          ),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
            child: Observer(builder: (context) {
              return Stack(
                children: [
                  Step1Form(context),
                  if (DataConstants.criminalControllerMobx.showLoader)
                    CustomGFLoader()
                ],
              );
            })),
      ),
    );
  }

  Widget Step1Form(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 1.h,
        ),
        Container(
          width: 90.w,
          height: 5.h,
          child: Marquee(
            text: 'कृपया सर्व माहिती इंग्रजी मध्ये भरावी.',
            style: Controller.kblackSemiBoldStyle(
              context,
            ).copyWith(fontSize: 15.sp, color: Colors.red),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 100.0,
            pauseAfterRound: Duration(seconds: 1),
            startPadding: 10.0,
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
        Scrollbar(
          isAlwaysShown: true,
          controller: scrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 0, right: 20),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Card(
                        // color: Colors.transparent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.w)),
                        child: Container(
                            width: 40.w,
                            height: 18.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: (profilePicFile != null)
                                  ? DecorationImage(
                                      image: FileImage(profilePicFile!),
                                      fit: BoxFit.cover)
                                  : null,
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: (profilePicFile == null)
                                ? const Text('Photo\none',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: black))
                                : null),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var from = await Controller.showImagePicker(context);
                          if (from != null) {
                            if (from == 'camera') {
                              profilePicFile = await Controller.imgFromCamera();
                            } else if (from == 'gallery') {
                              profilePicFile =
                                  await Controller.imgFromGallery();
                            }

                            if (profilePicFile != null) {
                              setState(() {
                                profilePicFile = profilePicFile;
                              });
                            }
                            var data = dio.FormData.fromMap({
                              "uploadFile": await dio.MultipartFile.fromFile(
                                  profilePicFile!.path,
                                  filename:
                                      profilePicFile!.path.split('/').last)
                            });
                            log(data.toString());
                            var uploadUrl = await DataConstants.allApisHandling
                                .uploadfile(data, context);
                            if (uploadUrl != null ||
                                !uploadUrl.contains('.png')) {
                              log('uploaded image url => $uploadUrl');
                              setState(() {
                                selectedphotoUrl = uploadUrl;
                              });
                            } else {
                              Controller.showErrorToast(uploadUrl, context);
                            }
                          }
                        },
                        child: Container(
                            // backgroundColor: kwhite,
                            // radius: 20,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10.w),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 0),
                                      blurRadius: 2,
                                      color: black.withOpacity(0.5))
                                ]),
                            child: const Icon(Icons.cloud_upload_outlined)),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 0, right: 20),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Card(
                        // color: Colors.transparent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.w)),
                        child: Container(
                            width: 40.w,
                            height: 18.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: (profilePicFileLeft != null)
                                  ? DecorationImage(
                                      image: FileImage(profilePicFileLeft!),
                                      fit: BoxFit.cover)
                                  : null,
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: (profilePicFileLeft == null)
                                ? const Text('Photo\ntwo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: black))
                                : null),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var from = await Controller.showImagePicker(context);
                          if (from != null) {
                            if (from == 'camera') {
                              profilePicFileLeft =
                                  await Controller.imgFromCamera();
                            } else if (from == 'gallery') {
                              profilePicFileLeft =
                                  await Controller.imgFromGallery();
                            }

                            if (profilePicFileLeft != null) {
                              setState(() {
                                profilePicFileLeft = profilePicFileLeft;
                              });
                            }
                            var data = dio.FormData.fromMap({
                              "uploadFile": await dio.MultipartFile.fromFile(
                                  profilePicFileLeft!.path,
                                  filename:
                                      profilePicFileLeft!.path.split('/').last)
                            });
                            log(data.toString());
                            var uploadUrl = await DataConstants.allApisHandling
                                .uploadfile(data, context);
                            if (uploadUrl != null ||
                                !uploadUrl.contains('.png')) {
                              log('uploaded image url => $uploadUrl');
                              setState(() {
                                selectedphotoLeftUrl = uploadUrl;
                              });
                            } else {
                              Controller.showErrorToast(uploadUrl, context);
                            }
                          }
                        },
                        child: Container(
                            // backgroundColor: kwhite,
                            // radius: 20,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10.w),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 0),
                                      blurRadius: 2,
                                      color: black.withOpacity(0.5))
                                ]),
                            child: const Icon(Icons.cloud_upload_outlined)),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 0, right: 20),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Card(
                        // color: Colors.transparent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.w)),
                        child: Container(
                            width: 40.w,
                            height: 18.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: (profilePicRightFile != null)
                                  ? DecorationImage(
                                      image: FileImage(profilePicRightFile!),
                                      fit: BoxFit.cover)
                                  : null,
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: (profilePicRightFile == null)
                                ? const Text('Photo\nthree',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: black))
                                : null),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var from = await Controller.showImagePicker(context);
                          if (from != null) {
                            if (from == 'camera') {
                              profilePicRightFile =
                                  await Controller.imgFromCamera();
                            } else if (from == 'gallery') {
                              profilePicRightFile =
                                  await Controller.imgFromGallery();
                            }

                            if (profilePicRightFile != null) {
                              setState(() {
                                profilePicRightFile = profilePicRightFile;
                              });
                            }
                            var data = dio.FormData.fromMap({
                              "uploadFile": await dio.MultipartFile.fromFile(
                                  profilePicRightFile!.path,
                                  filename:
                                      profilePicRightFile!.path.split('/').last)
                            });
                            log(data.toString());
                            var uploadUrl = await DataConstants.allApisHandling
                                .uploadfile(data, context);
                            if (uploadUrl != null ||
                                !uploadUrl.contains('.png')) {
                              log('uploaded image url => $uploadUrl');
                              setState(() {
                                selectedphotoRightUrl = uploadUrl;
                              });
                            } else {
                              Controller.showErrorToast(uploadUrl, context);
                            }
                          }
                        },
                        child: Container(
                            // backgroundColor: kwhite,
                            // radius: 20,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10.w),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 0),
                                      blurRadius: 2,
                                      color: black.withOpacity(0.5))
                                ]),
                            child: const Icon(Icons.cloud_upload_outlined)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '1',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text:
                    'Accused ' + ennglishMarathi["accusednameen"].toString(),
                controller: criminalnameController,
                onSaved: (value) {},
                width: double.infinity,
                textCapitalization: TextCapitalization.words,
                validation: (value) => ValidationUtils.requiredCustomField(
                    criminalnameController.text, "Accused Name"),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '2',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text: 'Accused ' +
                    ennglishMarathi["accusedaliasnameen"].toString(),
                controller: criminalaliasnameController,
                onSaved: (value) {},
                width: double.infinity,
                textCapitalization: TextCapitalization.words,
                // validation: (value) =>
                //     ValidationUtils.requiredCustomField(value, "Accused Alias Name"),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '3',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                decoration: BoxDecoration(
                    color: textfieldbgColor,
                    border: Border.all(color: black),
                    borderRadius: BorderRadius.circular(2.h)),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Accused Gender',
                        style: TextStyle(color: black, fontSize: 10.sp),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: id,
                              activeColor: primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'Male';
                                  id = 1;
                                });
                              },
                            ),
                            Text(
                              'Male',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 10.sp),
                            ),
                            Radio(
                              value: 2,
                              groupValue: id,
                              activeColor: primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'Female';
                                  id = 2;
                                });
                              },
                            ),
                            Text(
                              'Female',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 10.sp),
                            ),
                            Radio(
                              value: 3,
                              groupValue: id,
                              activeColor: primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'Other';
                                  id = 3;
                                });
                              },
                            ),
                            Text(
                              'Other',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 5.w,
              backgroundColor: black,
              child: Text(
                '4',
                style: Controller.textfieldTextStyle(context)
                    .copyWith(color: white),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            CGradientButton(
              buttonName: "Pick D.O.B",
              onPress: () => _showDatePicker(context),
              width: 30.w,
            ),
            SizedBox(
              width: 3.w,
            ),
            // const Spacer(),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: textfieldbgColor,
                    border: Border.all(color: black, width: 1),
                    borderRadius: BorderRadius.circular(1.5.h)),
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  _chosenDateTime != null
                      ? DateFormat('dd MMM yyyy').format(_chosenDateTime!)
                      : 'Pick Date Of Birth',
                  textAlign: TextAlign.start,
                  style: Controller.kblackSemiNormalStyle(context),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '4',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text:
                    'Accused ' + ennglishMarathi["accusedaddressen"].toString(),
                controller: criminaladdressController,
                maxline: 2,
                expands: true,
                onSaved: (value) {},
                width: double.infinity,
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '5',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text: ennglishMarathi['currentworken'].toString(),
                controller: currentjobController,
                onSaved: (value) {},
                width: double.infinity,
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '6',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text: ennglishMarathi['currentworkcompanyen'].toString(),
                controller: companyNameController,
                onSaved: (value) {},
                width: double.infinity,
                textCapitalization: TextCapitalization.words,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),

        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '7',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text:
                    'Accused ' + ennglishMarathi["mobilenumberen"].toString(),
                textInputType:
                    const TextInputType.numberWithOptions(signed: true),
                maxLength: 10,
                // suffixWidget: isMobileNumberVerified
                //     ? Icon(
                //         Icons.check_circle,
                //         color: primaryColor,
                //         size: 20.sp,
                //       )
                //     : const SizedBox.shrink(),
                controller: criminalmobileController,
                onSaved: (value) {
                  // if (value.toString().length == 10) {
                  //   var isValidMobile = ValidationUtils.isValidMobile(value);
                  //   if (!isValidMobile) {
                  //     Controller.showErrorToast(
                  //         'Please enter valid mobile number', context);
                  //     return;
                  //   }
                  //   var map = {
                  //     "type": "criminalMobileNo",
                  //     "value": value.toString()
                  //   };
                  //   log(map.toString());
                  //   Controller.getInternetStatus().then((value) async {
                  //     print("this is internet status $value ");
                  //     if (value!) {
                  //       var isValid = await DataConstants.allApisHandling
                  //           .checkUniqueid(map, context);
                  //       if (isValid!) {
                  //         setState(() {
                  //           isMobileNumberVerified = true;
                  //         });
                  //       } else {
                  //         setState(() {
                  //           isMobileNumberVerified = false;
                  //         });
                  //       }
                  //     } else {
                  //       // DataConstants.tenantController.tenantDetailLoading = false;
                  //       Controller.showSuccessToast1(
                  //           "No internet connection!", context);
                  //     }
                  //   });
                  // } else {
                  //   setState(() {
                  //     isMobileNumberVerified = false;
                  //   });
                  // }
                },
                width: double.infinity,
                validation: (value) =>
                    ValidationUtils.isValidateMobile(value, 'Mobile no'),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '8',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text: 'Accused Aadhar Card Number',
                controller: criminalaadharnoController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CardNumberInputFormatter()
                ],
                textInputType: TextInputType.number,
                suffixWidget: isAadharNumberVerified
                    ? Icon(
                        Icons.check_circle,
                        color: primaryColor,
                        size: 20.sp,
                      )
                    : const SizedBox.shrink(),
                maxLength: 14,
                onSaved: (value) {
                  if (value.toString().length == 14) {
                    var isValidPan = ValidationUtils.isValidAadhar(value);
                    if (isValidPan != null) {
                      Controller.showErrorToast(isValidPan, context);
                      return;
                    }
                    var map = {"type": "aadharNo", "value": value.toString()};

                    Controller.getInternetStatus().then((value) async {
                      print("this is internet status $value ");
                      if (value!) {
                        var isValid = await DataConstants.allApisHandling
                            .checkUniqueid(map, context);
                        if (isValid!) {
                          setState(() {
                            isAadharNumberVerified = true;
                          });
                        } else {
                          setState(() {
                            isAadharNumberVerified = false;
                          });
                        }
                      } else {
                        // DataConstants.tenantController.tenantDetailLoading = false;
                        Controller.showSuccessToast1(
                            "No internet connection!", context);
                      }
                    });
                  } else {
                    setState(() {
                      isAadharNumberVerified = false;
                    });
                  }
                },
                width: double.infinity,
                textCapitalization: TextCapitalization.characters,
                validation: (value) =>
                    ValidationUtils.isValidAadhar(value.toString()),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '9',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text:
                    'Accused ' + ennglishMarathi["passportnoen"].toString(),
                controller: criminalpassportController,
                maxLength: 8,
                suffixWidget: isPassportNumberVerified
                    ? Icon(
                        Icons.check_circle,
                        color: primaryColor,
                        size: 20.sp,
                      )
                    : const SizedBox.shrink(),
                suffixIcon: null,
                onSaved: (value) {
                  if (value.toString().length == 8) {
                    var isValidPan = ValidationUtils.isValidpassport(value);
                    if (isValidPan != null) {
                      Controller.showErrorToast(isValidPan, context);
                      return;
                    }
                    var map = {"type": "passportNo", "value": value.toString()};

                    Controller.getInternetStatus().then((value) async {
                      print("this is internet status $value ");
                      if (value!) {
                        var isValid = await DataConstants.allApisHandling
                            .checkUniqueid(map, context);
                        if (isValid!) {
                          setState(() {
                            isPassportNumberVerified = true;
                          });
                        } else {
                          setState(() {
                            isPassportNumberVerified = false;
                          });
                        }
                      } else {
                        // DataConstants.tenantController.tenantDetailLoading = false;
                        Controller.showSuccessToast1(
                            "No internet connection!", context);
                      }
                    });
                  } else {
                    setState(() {
                      isPassportNumberVerified = false;
                    });
                  }
                },
                width: double.infinity,
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '10',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text:
                    'Accused ' + ennglishMarathi["bankacntnoen"].toString(),
                controller: criminalbankacntController,
                onSaved: (value) {},
                width: double.infinity,
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '11',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text: 'Accused ' + ennglishMarathi["pannoen"].toString(),
                controller: criminalpannoController,
                suffixWidget: isPANNumberVerified
                    ? Icon(
                        Icons.check_circle,
                        color: primaryColor,
                        size: 20.sp,
                      )
                    : const SizedBox.shrink(),
                maxLength: 10,
                onSaved: (value) {
                  if (value.toString().length == 10) {
                    var isValidPan = ValidationUtils.isValidPan(value);
                    if (isValidPan != null) {
                      Controller.showErrorToast(isValidPan, context);
                      return;
                    }
                    var map = {"type": "panCardNo", "value": value.toString()};

                    Controller.getInternetStatus().then((value) async {
                      print("this is internet status $value ");
                      if (value!) {
                        var isValid = await DataConstants.allApisHandling
                            .checkUniqueid(map, context);
                        if (isValid!) {
                          setState(() {
                            isPANNumberVerified = true;
                          });
                        } else {
                          setState(() {
                            isPANNumberVerified = false;
                          });
                        }
                      } else {
                        // DataConstants.tenantController.tenantDetailLoading = false;
                        Controller.showSuccessToast1(
                            "No internet connection!", context);
                      }
                    });
                  } else {
                    setState(() {
                      isPANNumberVerified = false;
                    });
                  }
                },
                width: double.infinity,
                textCapitalization: TextCapitalization.characters,
                validation: (value) =>
                    ValidationUtils.isValidPan(value.toString()),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '12',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: CTextField(
                lable_text:
                    'Accused ' + ennglishMarathi["electionen"].toString(),
                controller: criminalelectionidController,
                suffixWidget: isElectionIDVerified
                    ? Icon(
                        Icons.check_circle,
                        color: primaryColor,
                        size: 20.sp,
                      )
                    : const SizedBox.shrink(),
                maxLength: 10,
                onSaved: (value) {
                  if (value.toString().length == 10) {
                    var isValidelectionid =
                        ValidationUtils.isValidelectionid(value.toString());
                    if (isValidelectionid != null) {
                      Controller.showErrorToast(isValidelectionid, context);
                      return;
                    }
                    var map = {"type": "electionId", "value": value.toString()};

                    Controller.getInternetStatus().then((value) async {
                      print("this is internet status $value ");
                      if (value!) {
                        var isValid = await DataConstants.allApisHandling
                            .checkUniqueid(map, context);
                        if (isValid!) {
                          setState(() {
                            isElectionIDVerified = true;
                          });
                        } else {
                          setState(() {
                            isElectionIDVerified = false;
                          });
                        }
                      } else {
                        // DataConstants.tenantController.tenantDetailLoading = false;
                        Controller.showSuccessToast1(
                            "No internet connection!", context);
                      }
                    });
                  } else {
                    setState(() {
                      isElectionIDVerified = false;
                    });
                  }
                },
                width: double.infinity,
                textCapitalization: TextCapitalization.characters,
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '13',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.5.h),
                    border: Border.all(color: black, width: 0.5)),
                padding: EdgeInsets.symmetric(),
                child: MultiSelectBottomSheetField(
                  initialChildSize: 0.4,
                  listType: MultiSelectListType.LIST,
                  // barrierColor: black,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.5.h),
                      border: Border.all(color: black, width: 0.5)),
                  searchable: true,
                  buttonText: Text(
                    "Modus Operandi",
                    style: Controller.kblackSemiNormalStyle(context),
                  ),
                  title: Text(
                    "Modus Operandi",
                    style: Controller.kblackNormalStyle(context),
                  ),
                  items: _items,
                  onConfirm: (values) {
                    selectedModusOperandi = values;
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    chipColor: primaryColor,
                    // scroll: true,
                    icon: const Icon(
                      Icons.close,
                      color: white,
                    ),
                    textStyle: Controller.kwhiteSmallStyle(context, white),
                    onTap: (value) {
                      setState(() {
                        selectedModusOperandi.remove(value);
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '14',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                color: textfieldbgColor,
                // decoration: BoxDecoration(
                //     border: Border.all(color: primaryColor, width: 1)),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('Vehicle used by accused currently?',
                          style: TextStyle(fontSize: 10.sp, color: black)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CDropDown(
                      width: double.infinity,
                      lable_text: "Vehicle Type",
                      // controller: widget.relationController,
                      onSaved: (value) {
                        setState(() {
                          usesvehicleStrting = value.toString();
                          log(usesvehicleStrting.toString());
                        });
                      },
                      value: usesvehicleStrting,
                      itmes: const [
                        "noVehicleUsed",
                        "2W",
                        "3W",
                        "heavyVehicle"
                      ],
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Radio(
                    //         value: 1,
                    //         groupValue: usesvehicle,
                    //         activeColor: primaryColor,
                    //         onChanged: (val) {
                    //           setState(() {
                    //             usesvehicleStrting = '2W';
                    //             usesvehicle = 1;
                    //           });
                    //         },
                    //       ),
                    //       Text(
                    //         '2W',
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .subtitle1!
                    //             .copyWith(fontSize: 10.sp),
                    //       ),
                    //       Radio(
                    //         value: 2,
                    //         groupValue: usesvehicle,
                    //         activeColor: primaryColor,
                    //         onChanged: (val) {
                    //           setState(() {
                    //             usesvehicleStrting = '3W';
                    //             usesvehicle = 2;
                    //           });
                    //         },
                    //       ),
                    //       Text(
                    //         '3W',
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .subtitle1!
                    //             .copyWith(fontSize: 10.sp),
                    //       ),
                    //       Radio(
                    //         value: 3,
                    //         groupValue: usesvehicle,
                    //         activeColor: primaryColor,
                    //         onChanged: (val) {
                    //           setState(() {
                    //             usesvehicleStrting = 'auto';
                    //             usesvehicle = 3;
                    //           });
                    //         },
                    //       ),
                    //       Text(
                    //         'Auto',
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .subtitle1!
                    //             .copyWith(fontSize: 10.sp),
                    //       ),
                    //       Radio(
                    //         value: 4,
                    //         groupValue: usesvehicle,
                    //         activeColor: primaryColor,
                    //         onChanged: (val) {
                    //           setState(() {
                    //             usesvehicleStrting = 'heavyVehicle';
                    //             usesvehicle = 4;
                    //           });
                    //         },
                    //       ),
                    //       Text(
                    //         'Heavy Vehicle',
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .subtitle1!
                    //             .copyWith(fontSize: 10.sp),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    if (usesvehicleStrting != "noVehicleUsed")
                      SizedBox(
                        height: 1.h,
                      ),
                    if (usesvehicleStrting != "noVehicleUsed")
                      CTextField(
                        lable_text: 'Vehicle Number',
                        controller: vehicleController,
                        onSaved: (value) {},
                        textCapitalization: TextCapitalization.characters,
                        width: double.infinity,
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 5.w,
                backgroundColor: black,
                child: Text(
                  '15',
                  style: Controller.textfieldTextStyle(context)
                      .copyWith(color: white),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              flex: 9,
              child: GestureDetector(
                onTap: () => setState(() {
                  relativesexpanded = !relativesexpanded;
                  _animatedHeight != 0.0
                      ? _animatedHeight = 0.0
                      : _animatedHeight = 300.0;
                }),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Family/Relatives/Friends/Lawyer',
                          style: TextStyle(fontSize: 12.sp, color: black)),
                      // SizedBox(
                      //   width: 2.w,
                      // ),
                      // GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         relativesexpanded = !relativesexpanded;
                      //         _animatedHeight != 0.0
                      //             ? _animatedHeight = 0.0
                      //             : _animatedHeight = 300.0;
                      //       });
                      //     },
                      //     child: Icon(
                      //         relativesexpanded
                      //             ? Icons.arrow_circle_up_sharp
                      //             : Icons.arrow_circle_down_sharp,
                      //         color: primaryColor)),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              relativesexpanded = !relativesexpanded;
                              if (_animatedHeight != 300.0) {
                                _animatedHeight = 300.0;
                              }
                            });
                            DataConstants.criminalControllerMobx.addNewRelation(
                                DataConstants.criminalControllerMobx.familyList
                                        .isEmpty
                                    ? 0
                                    : DataConstants.criminalControllerMobx
                                        .familyList.length);
                          },
                          child: const Icon(Icons.add, color: primaryColor)),
                    ],
                  ),
                  color: textfieldbgColor,
                  height: 5.h,
                  width: double.infinity,
                ),
              ),
            )
          ],
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
          child: Observer(builder: (context) {
            return ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DataConstants.criminalControllerMobx.familyList[index],
                      SizedBox(
                        width: 2.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            log('you clicked remove');
                            log(DataConstants.criminalControllerMobx
                                .familyList[index].relation
                                .toString());

                            DataConstants.criminalControllerMobx
                                .removeRelation(index);
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
              itemCount: DataConstants.criminalControllerMobx.familyList.length,
            );
          }),
          // height: _animatedHeight,
          color: textfieldbgColor,
          width: double.infinity,
        ),
        // MultiSelectDialogField(
        //   items: _items,
        //   title: Text("Animals"),
        //   selectedColor: Colors.blue,
        //   decoration: BoxDecoration(
        //     color: Colors.blue.withOpacity(0.1),
        //     borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
        //     border: Border.all(
        //       color: Colors.black,
        //       // width: 2,
        //     ),
        //   ),
        //   // buttonIcon: Icon(
        //   //   Icons.pets,
        //   //   color: Colors.blue,
        //   // ),
        //   buttonText: Text(
        //     "Favorite Animals",
        //     style: TextStyle(
        //       color: Colors.blue[800],
        //       fontSize: 16,
        //     ),
        //   ),
        //   onConfirm: (results) {
        //     //_selectedAnimals = results;
        //   },
        // ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CGradientButton(
              buttonName: "NEXT",
              onPress: () {
                addNewAccused();
              },
            ),
            if (isadded)
              CGradientButton(
                buttonName: 'Check Up Form',
                onPress: () {
                  // addNewAccused();
                },
              ),
          ],
        ),
      ],
    );
  }

  void addNewAccused() async {
    // if (_formKey1.currentState!.validate()) {
    //   _formKey1.currentState!.save();
    if (selectedphotoUrl == '' &&
        selectedphotoLeftUrl == '' &&
        selectedphotoRightUrl == '') {
      Controller.showErrorToast('Please upload atleast one photo', context);
      return;
    }
    if (criminalnameController.text.isEmpty) {
      Controller.showErrorToast('Please enter accused name', context);
      return;
    }
    if (criminalmobileController.text.isEmpty) {
      Controller.showErrorToast('Please enter accused mobile number', context);
      return;
    }

    if (criminalnameController.text.isNotEmpty) {
      var isValid =
          ValidationUtils.isValidMobile(criminalmobileController.text);
      if (!isValid) {
        Controller.showErrorToast('Please enter valid mobile number', context);
        return;
      }
    }

    if (_chosenDateTime == null) {
      Controller.showErrorToast('Please select Date Of Birth', context);
      return;
    }
    if (criminalaadharnoController.text.isEmpty) {
      Controller.showErrorToast('Please enter Aadhar ID Number', context);
      return;
    }

    // if (criminalpannoController.text.isNotEmpty) {
    //   var isValidPan = ValidationUtils.isValidPan(criminalpannoController.text);
    //   if (isValidPan != null) {
    //     Controller.showErrorToast(isValidPan, context);
    //     return;
    //   }
    // }
    // if (criminalpassportController.text.isNotEmpty) {
    //   var isValidPan =
    //       ValidationUtils.isValidPan(criminalpassportController.text);
    //   if (isValidPan != null) {
    //     Controller.showErrorToast(isValidPan, context);
    //     return;
    //   }
    // }
    // if (criminalelectionidController.text.isNotEmpty) {
    //   var isValidPan =
    //       ValidationUtils.isValidPan(criminalelectionidController.text);
    //   if (isValidPan!.isNotEmpty) {
    //     Controller.showErrorToast(isValidPan, context);
    //     return;
    //   }
    // }
    var map = {
      "criminalFullName": criminalnameController.text,
      "criminalGender": radioButtonItem.toLowerCase(),
      "criminalAliasName": criminalaliasnameController.text,
      "criminalMobileNo": criminalmobileController.text,
      "criminalPassportNo": criminalpassportController.text,
      "criminalBankAccNo": criminalbankacntController.text,
      "criminalPanCardNo": criminalpannoController.text,
      "criminalElectionId": criminalelectionidController.text,
      "criminalAddress": criminaladdressController.text,
      "modusOperandi": selectedModusOperandi,
      "criminalAadharIdNo": criminalaadharnoController.text,
      "criminalDOB": DateFormat("yyyy-MM-dd").format(_chosenDateTime!)
    };
    // if (currentjobController.text != '' ||
    //     companyNameController.text != '' ||
    //     companyOwnerNameController.text != '') {
    var jobDetails = {};
    // if (companyowneraddressController.text != '') {
    jobDetails["companyLocation"] = companyowneraddressController.text != ''
        ? companyowneraddressController.text
        : 'NA';
    // }
    // if (companyNameController.text != '') {
    jobDetails["companyName"] =
        companyNameController.text != '' ? companyNameController.text : 'NA';
    // }
    // if (companyOwnerNameController.text != '') {
    jobDetails["companyOwnerName"] = companyOwnerNameController.text != ''
        ? companyOwnerNameController.text
        : 'NA';
    // }
    // if (currentjobController.text != '') {
    jobDetails["jobProfile"] =
        currentjobController.text != '' ? currentjobController.text : 'NA';
    // }

    map["currentJobDetails"] = jobDetails;
    // }

    var familyList = [];
    if (DataConstants.criminalControllerMobx.familyList.isNotEmpty) {
      for (var element in DataConstants.criminalControllerMobx.familyList) {
        if (element.relation == "selectRelation") {
          Controller.showErrorToast('Please select relation', context);
          return;
        }
        if (element.nameController.text.isEmpty) {
          Controller.showErrorToast('Please enter relative name', context);
          return;
        }
        familyList.add({
          "relationWithAccused": element.relation,
          "name": element.nameController.text,
          "mobileNo": element.mobileController.text,
          "address": element.addressController.text
        });
      }
      map["relationsArray"] = familyList;
    }
    if (usesvehicleStrting == "noVehicleUsed") {
      map["currentlyUsedVehicleDetails"] = {
        "vehicleType": usesvehicleStrting,
        "vehicleNo": 'NA'
      };
    } else if (usesvehicleStrting != "noVehicleUsed" &&
        vehicleController.text == '') {
      Controller.showErrorToast('Please enter Vehicle number', context);
      return;
    } else {
      var vehicleerror =
          ValidationUtils.isValidVehicleNumber(vehicleController.text);
      if (vehicleerror != null) {
        Controller.showErrorToast(vehicleerror, context);
        return;
      }
      map["currentlyUsedVehicleDetails"] = {
        "vehicleType": usesvehicleStrting,
        "vehicleNo":
            vehicleController.text != '' ? vehicleController.text : 'NA'
      };
    }
    var imageUrls = [];
    if (selectedphotoUrl != '') {
      imageUrls.add(selectedphotoUrl);
    }
    if (selectedphotoLeftUrl != '') {
      imageUrls.add(selectedphotoLeftUrl);
    }
    if (selectedphotoRightUrl != '') {
      imageUrls.add(selectedphotoRightUrl);
    }
    map["criminalPhoto"] = imageUrls;

    if (criminalpassportController.text.isNotEmpty) {
      if (!isPassportNumberVerified) {
        Controller.showErrorToast(
            'Please verify your passport number', context);
        return;
      }
    }
    if (criminalpannoController.text.isNotEmpty) {
      if (!isPANNumberVerified) {
        Controller.showErrorToast('Please verify your PAN number', context);
        return;
      }
    }
    if (criminalelectionidController.text.isNotEmpty) {
      if (!isElectionIDVerified) {
        Controller.showErrorToast(
            'Please verify your election ID number', context);
        return;
      }
    }
    if (criminalaadharnoController.text.isNotEmpty) {
      if (!isAadharNumberVerified) {
        Controller.showErrorToast('Please verify your Aadhar number', context);
        return;
      }
    }
    log(map.toString());

    // return;
    Controller.getInternetStatus().then((value) async {
      print("this is internet status $value ");
      if (value!) {
        var result =
            await DataConstants.allApisHandling.addNewAccused(map, context);
        if (result.contains('Accused Added Successfully')) {
          setState(() {
            isadded = true;
          });
        }
      } else {
        // DataConstants.tenantController.tenantDetailLoading = false;
        Controller.showSuccessToast1("No internet connection!", context);
      }
    });
    // }
  }
}
