import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mbvv/screens/criminal/add_accused_form.dart';
import 'package:mbvv/screens/criminal/add_criminal.dart';
import 'package:mbvv/screens/criminal/checkup_history.dart';
import 'package:mbvv/screens/criminal/view_accused_details.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:mbvv/widgets/custom_button.dart';
import 'package:mbvv/widgets/gf_loader.dart';
import 'package:sizer/sizer.dart';

class SearchAccused extends StatefulWidget {
  final bool isFromSearc;
  const SearchAccused({Key? key, this.isFromSearc = false}) : super(key: key);

  @override
  State<SearchAccused> createState() => _SearchAccusedState();
}

class _SearchAccusedState extends State<SearchAccused> {
  TextEditingController searchController = TextEditingController();
  bool showCross = false;
  @override
  void initState() {
    super.initState();
    DataConstants.allApisHandling.getAccusedList(context, false);
  }

  @override
  Widget build(BuildContext context) {
    var theme = ThemeData();
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        floatingActionButton: Observer(builder: (context) {
          return DataConstants.criminalControllerMobx.showFloatingbutton
              ? FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: white, width: 2),
                      borderRadius: BorderRadius.circular(3.h)),
                  onPressed: () {
                    Get.to(AddNewAccused());
                  },
                  backgroundColor: primaryColor.withOpacity(0.8),
                  splashColor: black.withOpacity(0.5),
                  label: Text(
                    'Add Accused Details',
                    style: Controller.kwhiteSmallStyle(context, white),
                  ),
                )
              : const SizedBox.shrink();
        }),
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            'Search Accused',
            style: Controller.kblackNormalStyle(context).copyWith(
              color: white,
            ),
          ),
          leading: BackButton(
            onPressed: () {
              Get.back();
            },
            color: white,
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Container(
                height: 6.h,
                margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.h),
                    color: textfieldbgColor),
                child: TextFormField(
                  style: Controller.textfieldTextStyle(context),
                  controller: searchController,
                  autocorrect: false,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      hintText: 'Search accused by name',
                      hintStyle: Controller.hintTextStyle(context),
                      enabledBorder: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: primaryColor,
                      ),
                      suffixIcon: showCross
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  searchController.text = '';
                                  showCross = false;
                                });
                                DataConstants.allApisHandling
                                    .getAccusedList(context, false);
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ))
                          : null),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        showCross = true;
                      });
                      DataConstants.allApisHandling
                          .searchaccused(context, value);
                    } else {
                      setState(() {
                        showCross = false;
                      });
                      DataConstants.allApisHandling
                          .getAccusedList(context, false);
                    }
                    log(value);
                  },
                ),
              ),
              Observer(builder: (context) {
                return DataConstants
                        .criminalControllerMobx.showAccusedSearchLoading
                    ? const CustomGFLoader()
                    : DataConstants
                            .criminalControllerMobx.accusedList.isNotEmpty
                        ? Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                return DataConstants.allApisHandling
                                    .getAccusedList(context, false);
                              },
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: DataConstants
                                      .criminalControllerMobx
                                      .accusedList
                                      .length,
                                  itemBuilder: (context, index) {
                                    var accused = DataConstants
                                        .criminalControllerMobx
                                        .accusedList[index];
                                    log(accused.criminalPhoto!.isNotEmpty
                                        ? '$BASEURL/' +
                                            accused.criminalPhoto![0]
                                        : '-');
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                isDismissible: true,
                                                enableDrag: true,
                                                context: context,
                                                backgroundColor: white,
                                                builder: (context) {
                                                  return ViewAccusedDetails(
                                                    accused: accused,
                                                  );
                                                });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.w,
                                                vertical: 1.5.h),
                                            margin: EdgeInsets.only(
                                                bottom: index ==
                                                        DataConstants
                                                                .criminalControllerMobx
                                                                .accusedList
                                                                .length -
                                                            1
                                                    ? 7.h
                                                    : 0.h),
                                            decoration: BoxDecoration(
                                                color: textfieldbgColor,
                                                borderRadius:
                                                    BorderRadius.circular(1.h)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Material(
                                                                  child: Column(
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            AlignmentDirectional.topEnd,
                                                                        child:
                                                                            CloseButton(
                                                                          onPressed:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          // color: Colors.black,
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          // height: 50.h,
                                                                          decoration: BoxDecoration(
                                                                              color: white,
                                                                              image: DecorationImage(
                                                                                  onError: (object, st) {
                                                                                    // Controller.showErrorToast('Issue loading image', context);
                                                                                  },
                                                                                  image: accused.criminalPhoto!.isNotEmpty ? NetworkImage(BASEURL + '/' + accused.criminalPhoto![0]) : const NetworkImage('https://s3.amazonaws.com/assets.penpenny.com/profile-placeholder.png'))),
                                                                          // child: CloseButton(
                                                                          //   onPressed: () {
                                                                          //     Get.back();
                                                                          //   },
                                                                          //   // color: Colors.black,
                                                                          // ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              });
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 8.w,
                                                          backgroundImage: accused
                                                                  .criminalPhoto!
                                                                  .isNotEmpty
                                                              ? NetworkImage(
                                                                  '$BASEURL/' +
                                                                      accused
                                                                          .criminalPhoto![0],
                                                                )
                                                              : const NetworkImage(
                                                                  'https://s3.amazonaws.com/assets.penpenny.com/profile-placeholder.png'),
                                                          backgroundColor:
                                                              white,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Expanded(
                                                      flex: 8,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            accused
                                                                .criminalFullName!,
                                                            style: Controller
                                                                .kwhiteSemiBoldNormalStyle(
                                                                    context,
                                                                    black),
                                                          ),
                                                          SizedBox(
                                                            height: 1.h,
                                                          ),
                                                          Text(
                                                            Controller
                                                                .camelToSentence(
                                                                    accused
                                                                        .criminalGender!),
                                                            style: Controller
                                                                .kblackSemiNormalStyle(
                                                                    context),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                const Divider(
                                                  color: primaryColor,
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // CGradientButton(
                                                    //   buttonName:
                                                    //       'View History',
                                                    //   onPress: () {
                                                    //     Get.to(CheckUpHistory(
                                                    //       accused: accused,
                                                    //     ));
                                                    //   },
                                                    //   width: 40.w,
                                                    // ),
                                                    CGradientButton(
                                                      buttonName:
                                                          'CheckUp Form',
                                                      onPress: () {
                                                        Get.to(
                                                            AddEditCriminalRecord(
                                                          accused: accused,
                                                        ));
                                                      },
                                                      width: 40.w,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        // ListTile(
                                        //   enabled: true,
                                        //   tileColor: textfieldbgColor,
                                        //   shape: RoundedRectangleBorder(
                                        //       borderRadius:
                                        //           BorderRadius.circular(1.h)),
                                        //   contentPadding: EdgeInsets.symmetric(
                                        //       vertical: 0.5.h, horizontal: 2.w),
                                        //   onTap: () {
                                        //     showModalBottomSheet(
                                        //         isScrollControlled: true,
                                        //         isDismissible: true,
                                        //         context: context,
                                        //         builder: (context) {
                                        //           return ViewAccusedDetails(
                                        //             accused: accused,
                                        //           );
                                        //         });
                                        //   },
                                        //   leading: CircleAvatar(
                                        //     radius: 8.w,
                                        //     backgroundImage: accused
                                        //             .criminalPhoto!.isNotEmpty
                                        //         ? NetworkImage(
                                        //             '$BASEURL/' +
                                        //                 accused.criminalPhoto![0],
                                        //           )
                                        //         : null,
                                        //     backgroundColor: textfieldbgColor,
                                        //   ),
                                        //   title: Text(
                                        //     accused.criminalFullName!,
                                        //     style: Controller
                                        //         .kwhiteSemiBoldNormalStyle(
                                        //             context, black),
                                        //   ),
                                        //   subtitle: Text(
                                        //     Controller.camelToSentence(
                                        //         accused.criminalGender!),
                                        //     style:
                                        //         Controller.kblackSemiNormalStyle(
                                        //             context),
                                        //   ),
                                        //   trailing: widget.isFromSearc
                                        //       ? IconButton(
                                        //           onPressed: () {},
                                        //           icon: const Icon(
                                        //             Icons.mode_edit,
                                        //             color: primaryColor,
                                        //           ),
                                        //         )
                                        //       : IconButton(
                                        //           onPressed: () {
                                        //             Get.to(AddEditCriminalRecord(
                                        //               accused: accused,
                                        //             ));
                                        //           },
                                        //           icon: const Icon(
                                        //             Icons.wysiwyg_outlined,
                                        //             color: primaryColor,
                                        //           ),
                                        //         ),
                                        // ),
                                        SizedBox(
                                          height: 2.h,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                return DataConstants.allApisHandling
                                    .getAccusedList(context, false);
                              },
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    SizedBox(height: 25.h),
                                    Text(
                                      'No Accused found',
                                      style:
                                          Controller.kblackNormalStyle(context),
                                    ),
                                    SizedBox(height: 2.h),
                                    FloatingActionButton.extended(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: white, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(3.h)),
                                      onPressed: () {
                                        Get.to(AddNewAccused());
                                      },
                                      backgroundColor:
                                          primaryColor.withOpacity(0.8),
                                      splashColor: black.withOpacity(0.5),
                                      label: Text(
                                        'Add Accused Details',
                                        style: Controller.kwhiteSmallStyle(
                                            context, white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
              }),
              // SizedBox(
              //   height: 7.h,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
