import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mbvv/screens/authentication/update_profile.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:mbvv/widgets/custom_button.dart';
import 'package:mbvv/widgets/gf_loader.dart';
import 'package:sizer/sizer.dart';

class ProfileDashboard extends StatefulWidget {
  const ProfileDashboard({Key? key}) : super(key: key);

  @override
  State<ProfileDashboard> createState() => _ProfileDashboardState();
}

class _ProfileDashboardState extends State<ProfileDashboard> {
  @override
  void initState() {
    super.initState();
    DataConstants.allApisHandling.getProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return DataConstants.loginController.showViewProfileLoader
          ? const CustomGFLoader()
          : Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
              // alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 18.w,
                            backgroundColor: primaryColor,
                            backgroundImage: NetworkImage(
                              DataConstants.loginController.userProfile
                                      .profileImageURL ??
                                  'https://s3.amazonaws.com/assets.penpenny.com/profile-placeholder.png',
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            DataConstants
                                .loginController.userProfile.displayName!,
                            style: Controller.kblackNormalStyle(context)
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(
                          //   height: 1.h,
                          // ),
                          // Text(
                          //   'Bhayandar',
                          //   style: Controller.kblackSemiNormalStyle(context),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildDetails(
                              true,
                              'Department:',
                              Controller.camelToSentence(DataConstants
                                      .loginController
                                      .userProfile
                                      .isFromDepartment ??
                                  'notAvailable')),
                          if (DataConstants
                                  .loginController.userProfile.isFromDepartment
                                  .toString() !=
                              'null')
                            buildDetails(
                                true,
                                '${Controller.camelToSentence(DataConstants.loginController.userProfile.isFromDepartment!)}:',
                                Controller.camelToSentence(DataConstants
                                        .loginController
                                        .userProfile
                                        .department ??
                                    'notAvailable')),
                          buildDetails(
                              true,
                              'User Name:',
                              DataConstants
                                  .loginController.userProfile.username!),
                          buildDetails(
                              true,
                              'Email:',
                              DataConstants.loginController.userProfile.email
                                          .toString() !=
                                      ''
                                  ? DataConstants
                                      .loginController.userProfile.email!
                                  : 'NA'),
                          // buildDetails(true, 'Special Unit:', 'Crime Branch'),
                          // buildDetails(true, 'Buckle Number:', '2022'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // CGradientButton(
                    //   buttonName: 'Update Profile',
                    //   onPress: () {
                    //     Get.to(UpdateProfile());
                    //   },
                    //   width: 40.w,
                    // )
                  ],
                ),
              ),
            );
    });
  }

  Widget buildDetails(bool isAvailabel, String heading, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              heading,
              style: Controller.kblackNormalStyle(context)
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 1.h,
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
