import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mbvv/utils/validations.dart';
import 'package:mbvv/widgets/custom_button.dart';
import 'package:mbvv/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../utils/color_constants.dart';
import '../utils/controller.dart';
import '../utils/data_constants.dart';

class AddMobileAddressWork extends StatefulWidget {
  final String? type;
  final String? accusedId;
  AddMobileAddressWork({Key? key, this.type, this.accusedId}) : super(key: key);

  @override
  State<AddMobileAddressWork> createState() => _AddMobileAddressWorkState();
}

class _AddMobileAddressWorkState extends State<AddMobileAddressWork> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController currentWorkController = TextEditingController();
  TextEditingController currentCompanyNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        child: Observer(builder: (context) {
          return AbsorbPointer(
            absorbing:
                DataConstants.criminalControllerMobx.showupdateDataLoading,
            child: Container(
              // height: 20.h,
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add ${Controller.camelToSentence(widget.type!)}',
                        style: Controller.kblackNormalStyle(context)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      CloseButton(
                        onPressed: () {
                          Get.back();
                        },
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 1.h,
                  // ),
                  const Divider(
                    color: black,
                  ),
                  if (widget.type == "mobile") addMobile(),
                  if (widget.type == "address") addAddress(),
                  if (widget.type == "jobDetails") addWorkDetails(),

                  Center(
                    child: CGradientButton(
                      buttonName: DataConstants
                              .criminalControllerMobx.showupdateDataLoading
                          ? ''
                          : 'Add',
                      onPress: DataConstants
                              .criminalControllerMobx.showupdateDataLoading
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              addDetail();
                            },
                      icon: DataConstants
                              .criminalControllerMobx.showupdateDataLoading
                          ? CircularProgressIndicator()
                          : SizedBox.shrink(),
                    ),
                  ),
                  SizedBox(height: 2.h)
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget addMobile() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: CTextField(
        controller: mobileController,
        lable_text: 'Mobile Number',
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textInputType: TextInputType.numberWithOptions(signed: true),
        maxLength: 10,
        validation: (value) =>
            ValidationUtils.requiredMobileField(value, 'Mobile Number', 10),
      ),
    );
  }

  Widget addAddress() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: CTextField(
        controller: addressController,
        lable_text: 'Address',
        expands: true,
        maxline: 3,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.newline,
        textInputType: TextInputType.streetAddress,
      ),
    );
  }

  Widget addWorkDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        children: [
          CTextField(
            controller: currentWorkController,
            lable_text: 'Current Work',
            textCapitalization: TextCapitalization.words,
            textInputType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          CTextField(
            controller: currentCompanyNameController,
            lable_text: 'Company Name',
            textCapitalization: TextCapitalization.words,
            textInputType: TextInputType.name,
          ),
        ],
      ),
    );
  }

  void addDetail() async {
    var map = {};
    map["type"] = widget.type!;
    if (widget.type == "mobile") {
      var isValidMobile = ValidationUtils.isValidMobile(mobileController.text);
      if (!isValidMobile) {
        Controller.showErrorToast('Please enter valid Mobile Number', context);
        return;
      }
      map["value"] = mobileController.text;
    } else if (widget.type == "address") {
      var error =
          ValidationUtils.requiredField(addressController.text, "Address");
      if (error != null) {
        Controller.showErrorToast(error, context);
        return;
      }
      map["value"] = addressController.text;
    } else {
      var workerror = ValidationUtils.requiredField(
          currentWorkController.text, "Current Work");
      if (workerror != null) {
        Controller.showErrorToast(workerror, context);
        return;
      }
      var nameerror = ValidationUtils.requiredField(
          currentCompanyNameController.text, "Current Company Name");
      if (nameerror != null) {
        Controller.showErrorToast(nameerror, context);
        return;
      }
      map["value"] = {
        "jobProfile": currentWorkController.text,
        "companyName": currentCompanyNameController.text
      };
    }
    Controller.getInternetStatus().then((value) async {
      print("this is internet status $value ");
      if (value!) {
        await DataConstants.allApisHandling
            .updateAccused(map, context, widget.accusedId!);
      } else {
        // DataConstants.tenantController.tenantDetailLoading = false;
        Controller.showSuccessToast1("No internet connection!", context);
      }
    });
  }
}
