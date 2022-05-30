import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/image_constants.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart' as dio;

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  File? profilePicFile;
  late String profilePicFileName = '';
  late String selectedphotoUrl = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Update Profile Details',
              style: Controller.kblackNormalStyle(context),
            ),
            centerTitle: true,
            backgroundColor: white,
            leading: BackButton(
              onPressed: () {
                Get.back();
              },
              color: primaryColor,
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: profilePicFile != null
                      ? GestureDetector(
                          onTap: () async {
                            var from =
                                await Controller.showImagePicker(context);
                            if (from != null) {
                              if (from == 'camera') {
                                profilePicFile =
                                    await Controller.imgFromCamera();
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
                              var uploadUrl = await DataConstants
                                  .allApisHandling
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
                            width: 45.w,
                            height: 45.w,
                            // radius: 20.w,
                            // backgroundColor: primaryColor,
                            decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(20.h),
                                image: DecorationImage(
                                    image: FileImage(
                                      profilePicFile!,
                                    ),
                                    fit: BoxFit.cover)),

                            child: profilePicFile == null
                                ? Center(
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.image_search,
                                          size: 15.w,
                                        )),
                                  )
                                : null,
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            var from =
                                await Controller.showImagePicker(context);
                            if (from != null) {
                              if (from == 'camera') {
                                profilePicFile =
                                    await Controller.imgFromCamera();
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
                              var uploadUrl = await DataConstants
                                  .allApisHandling
                                  .uploadfile(data, context);
                              if (uploadUrl != '' ||
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
                              width: 45.w,
                              height: 45.w,
                              // radius: 20.w,
                              // backgroundColor: primaryColor,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(20.h)),
                              alignment: Alignment.center,
                              child: profilePicFile == null
                                  ? Center(
                                      child: Icon(
                                      Icons.image_search,
                                      color: white,
                                      size: 15.w,
                                    ))
                                  : null),
                        ),
                ),
              ],
            ),
          )),
    );
  }
}
