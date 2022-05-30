import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mbvv/screens/main_screen.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/image_constants.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:mbvv/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController useridController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Observer(builder: (context) {
          return Stack(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          mbvvlogo,
                          height: 25.h,
                        ),
                        Text(
                          ennglishMarathi["taglineen"].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        TextFormField(
                          controller: useridController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: textfieldbgColor,
                            // hintText: 'युझर आयडी',
                            // hintStyle: const TextStyle(
                            //   color: Colors.black,
                            // ),
                            labelText: ennglishMarathi["useriden"].toString(),
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 5.w),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.5.h),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(1.5.h),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              child: Icon(
                                isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: primaryColor,
                              ),
                            ),
                            filled: true,
                            fillColor: textfieldbgColor,
                            // hintText: 'पासवर्ड',
                            // hintStyle: const TextStyle(
                            //   color: Colors.black,
                            // ),
                            labelText: ennglishMarathi["passworden"].toString(),
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 5.w),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.5.h),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(1.5.h),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CGradientButton(
                          buttonName: ennglishMarathi["loginen"].toString(),
                          onPress: () {
                            // Get.to(MainScreen());
                            loginApi();
                          },
                          width: 35.w,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (DataConstants.loginController.showLoginLoader)
                GFLoader(
                  loaderColorOne: primaryColor.withOpacity(0.3),
                  loaderColorTwo: primaryColor.withOpacity(0.5),
                  loaderColorThree: primaryColor.withOpacity(0.9),
                  type: GFLoaderType.circle,
                  size: GFSize.LARGE,
                )
            ],
          );
        }),
      ),
    );
  }

  void loginApi() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (DataConstants.uniqueId != '') {
        var map = {
          "userId": useridController.text,
          "password": passwordController.text,
          "securityId": DataConstants.uniqueId
        };
        log(map.toString());
        Controller.getInternetStatus().then((value) async {
          print("this is internet status $value ");
          if (value!) {
            DataConstants.allApisHandling.login(map, context);
          } else {
            // DataConstants.tenantController.tenantDetailLoading = false;
            Controller.showSuccessToast1("No internet connection!", context);
          }
        });
      } else {
        Controller.showErrorToast("Could not find Security Id", context);
      }
    }
  }
}
