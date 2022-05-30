import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mbvv/models/accused_list_response.dart';
import 'package:mbvv/screens/criminal/checkup_history.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/common_views.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:mbvv/widgets/add_mobileaddresswork_widget.dart';
import 'package:mbvv/widgets/gf_loader.dart';
import 'package:sizer/sizer.dart';

class ViewAccusedDetails extends StatefulWidget {
  final Accused? accused;
  const ViewAccusedDetails({Key? key, this.accused}) : super(key: key);

  @override
  State<ViewAccusedDetails> createState() => _ViewAccusedDetailsState();
}

class _ViewAccusedDetailsState extends State<ViewAccusedDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    DataConstants.allApisHandling
        .getSingleAccused(context, widget.accused!.sId!);
    DataConstants.allApisHandling
        .getAccusedCheckupHistory(context, widget.accused!.sId!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: white,
        child: Container(
          height: 95.h,
          color: white,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Details',
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
              TabBar(
                  controller: tabController,
                  // isScrollable: true,
                  physics: const BouncingScrollPhysics(),
                  indicatorColor: primaryColor,
                  labelColor: primaryColor,
                  onTap: (index) {
                    setState(() {
                      // currentIndex = index;
                    });
                    tabController.animateTo(index);
                  },
                  unselectedLabelColor: grey,
                  tabs: const [
                    Tab(
                      text: 'Profile Details',
                    ),
                    Tab(
                      text: 'Check Up Record',
                    )
                  ]),
              Expanded(
                  child: TabBarView(controller: tabController, children: [
                profileDetails(context),
                CheckUpHistory(
                  accused: widget.accused,
                )
              ])),
              // SizedBox(height: 2.h)
            ],
          ),
        ),
      ),
    );
  }

  Widget profileDetails(BuildContext context) {
    return Scrollbar(
      // isAlwaysShown: true,
      child: SingleChildScrollView(
        child: Observer(builder: (context) {
          return DataConstants.criminalControllerMobx.showSingleAccusedLoading
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 15.h),
                  child: const CustomGFLoader())
              : Column(
                  children: [
                    personalDetails(context),
                    if (!DataConstants
                        .criminalControllerMobx.showCheckUpHistoryUpLoading)
                      criminalRecord(context)
                  ],
                );
        }),
      ),
    );
  }

  Widget personalDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.h,
        ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalPhoto !=
            null)
          SingleChildScrollView(
            child: Row(
                children: List.generate(
                    DataConstants.criminalControllerMobx.singleAccusedData
                        .criminalPhoto!.length, (index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Material(
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: CloseButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  // color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: ClipRRect(
                                  // borderRadius:
                                  //     BorderRadius.circular(2.h),
                                  child: Container(
                                    child: CachedNetworkImage(
                                        // fit: BoxFit.fill,
                                        placeholder: (conttext, loaded) {
                                          return CustomGFLoader();
                                        },
                                        imageUrl: BASEURL +
                                            '/' +
                                            DataConstants
                                                .criminalControllerMobx
                                                .singleAccusedData
                                                .criminalPhoto![index]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(5.w),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    height: 18.h,
                    width: 30.w,
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (conttext, loaded) {
                          return CustomGFLoader();
                        },
                        imageUrl: BASEURL +
                            '/' +
                            DataConstants.criminalControllerMobx
                                .singleAccusedData.criminalPhoto![index]),
                  ),
                ),
              );
            })),
          ),
        SizedBox(height: 2.h),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalFullName
                .toString() !=
            '')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Name",
                      style: Controller.kblackSemiBoldStyle(context)
                          .copyWith(fontSize: 13.sp),
                      children: [])),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                DataConstants
                    .criminalControllerMobx.singleAccusedData.criminalFullName!,
                style: Controller.kblackSemiNormalStyle(context),
              ),
            ],
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalFullName
                .toString() !=
            '')
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalAliasName
                .toString() !=
            '')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Alias Name ",
                      style: Controller.kblackSemiBoldStyle(context)
                          .copyWith(fontSize: 13.sp),
                      children: [])),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                DataConstants.criminalControllerMobx.singleAccusedData
                    .criminalAliasName!,
                style: Controller.kblackSemiNormalStyle(context),
              ),
            ],
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalAliasName
                .toString() !=
            '')
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalGender
                .toString() !=
            '')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Gender ",
                      style: Controller.kblackSemiBoldStyle(context)
                          .copyWith(fontSize: 13.sp),
                      children: [])),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                Controller.camelToSentence(DataConstants
                    .criminalControllerMobx.singleAccusedData.criminalGender!),
                style: Controller.kblackSemiNormalStyle(context),
              ),
            ],
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalGender
                .toString() !=
            '')
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants.criminalControllerMobx.singleAccusedData
            .criminalMobileNo!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "Mobile No. ",
                                style: Controller.kblackSemiBoldStyle(context)
                                    .copyWith(fontSize: 13.sp),
                                children: [])),
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  builder: (context) {
                                    return AddMobileAddressWork(
                                      type: "mobile",
                                      accusedId: widget.accused!.sId!,
                                    );
                                  });
                            },
                            child: const Icon(
                              Icons.add_circle,
                              color: primaryColor,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          DataConstants.criminalControllerMobx.singleAccusedData
                              .criminalMobileNo!.length, (index) {
                        return Container(
                          // width: 40.w,
                          margin: EdgeInsets.only(bottom: 1.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5.h, horizontal: 0.w),
                          // decoration:
                          //     BoxDecoration(border: Border.all(color: black)),
                          child: Text(
                            '- ' +
                                DataConstants.criminalControllerMobx
                                    .singleAccusedData.criminalMobileNo![index],
                            style: Controller.kblackSemiNormalStyle(context),
                          ),
                        );
                      }),
                    ),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: DataConstants
                    //       .criminalControllerMobx
                    //       .singleAccusedData
                    //       .criminalMobileNo!
                    //       .length,
                    //   itemBuilder: ((context, index) {
                    //     return Container(
                    //       width: 50.w,
                    //       margin: EdgeInsets.only(bottom: 1.h),
                    //       padding: EdgeInsets.symmetric(
                    //           vertical: 1.h, horizontal: 5.w),
                    //       decoration: BoxDecoration(
                    //           border: Border.all(color: black)),
                    //       child: Text(
                    //         DataConstants
                    //             .criminalControllerMobx
                    //             .singleAccusedData
                    //             .criminalMobileNo![index],
                    //         style: Controller.kblackSemiNormalStyle(
                    //             context),
                    //       ),
                    //     );
                    //   }),
                    // ),
                  ],
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: IconButton(
              //       onPressed: () {
              //         showModalBottomSheet(
              //             context: context,
              //             isScrollControlled: true,
              //             isDismissible: false,
              //             builder: (context) {
              //               return AddMobileAddressWork(
              //                 type: "mobile",
              //               );
              //             });
              //       },
              //       icon: Icon(
              //         Icons.add_circle,
              //         color: primaryColor,
              //       )),
              // )
            ],
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalMobileNo
                .toString() !=
            '')
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalAadharIdNo !=
            null)
          CommonView.buildDetails(
              'Aadhar Number',
              DataConstants
                  .criminalControllerMobx.singleAccusedData.criminalAadharIdNo!,
              context),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalAadharIdNo !=
            null)
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalDOB !=
            null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonView.buildDetails(
                  'Date Of Birth',
                  DateFormat("dd MMM yyyy").format(DataConstants
                      .criminalControllerMobx.singleAccusedData.criminalDOB!),
                  context),
              const Spacer(),
              CommonView.buildDetails(
                  'Age',
                  (DateTime.now().year -
                          DataConstants.criminalControllerMobx.singleAccusedData
                              .criminalDOB!.year)
                      .toString(),
                  context),
              const Spacer()
            ],
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalDOB !=
            null)
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalAddress
                .toString() !=
            '')
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "Address ",
                                style: Controller.kblackSemiBoldStyle(context)
                                    .copyWith(fontSize: 13.sp),
                                children: [])),
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  builder: (context) {
                                    return AddMobileAddressWork(
                                      type: "address",
                                      accusedId: widget.accused!.sId!,
                                    );
                                  });
                            },
                            child: const Icon(
                              Icons.add_circle,
                              color: primaryColor,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          DataConstants.criminalControllerMobx.singleAccusedData
                              .criminalAddress!.length, (index) {
                        return Container(
                          // width: 40.w,
                          margin: EdgeInsets.only(bottom: 1.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5.h, horizontal: 0.w),
                          // decoration:
                          //     BoxDecoration(border: Border.all(color: black)),
                          child: Text(
                            '- ' +
                                DataConstants.criminalControllerMobx
                                    .singleAccusedData.criminalAddress![index],
                            style: Controller.kblackSemiNormalStyle(context),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: IconButton(
              //       onPressed: () {
              //         showModalBottomSheet(
              //             context: context,
              //             isScrollControlled: true,
              //             isDismissible: false,
              //             builder: (context) {
              //               return AddMobileAddressWork(
              //                 type: "address",
              //               );
              //             });
              //       },
              //       icon: Icon(
              //         Icons.add_circle,
              //         color: primaryColor,
              //       )),
              // )
            ],
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalAddress
                .toString() !=
            '')
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalPassportNo
                .toString() !=
            '')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Passport No. ",
                      style: Controller.kblackSemiBoldStyle(context)
                          .copyWith(fontSize: 13.sp),
                      children: [])),
              SizedBox(
                height: 0.5.h,
              ),
              SelectableText(
                DataConstants.criminalControllerMobx.singleAccusedData
                    .criminalPassportNo!,
                style: Controller.kblackSemiNormalStyle(context),
              ),
            ],
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalPassportNo
                .toString() !=
            '')
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalBankAccNo
                .toString() !=
            '')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Bank Account No. ",
                      style: Controller.kblackSemiBoldStyle(context)
                          .copyWith(fontSize: 13.sp),
                      children: [])),
              SizedBox(
                height: 0.5.h,
              ),
              SelectableText(
                DataConstants.criminalControllerMobx.singleAccusedData
                    .criminalBankAccNo!,
                style: Controller.kblackSemiNormalStyle(context),
              ),
            ],
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalBankAccNo
                .toString() !=
            '')
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalPanCardNo
                .toString() !=
            '')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "PAN No. ",
                      style: Controller.kblackSemiBoldStyle(context)
                          .copyWith(fontSize: 13.sp),
                      children: [])),
              SizedBox(
                height: 0.5.h,
              ),
              SelectableText(
                DataConstants.criminalControllerMobx.singleAccusedData
                    .criminalPanCardNo!,
                style: Controller.kblackSemiNormalStyle(context),
              ),
            ],
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalPanCardNo
                .toString() !=
            '')
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalElectionId
                .toString() !=
            '')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Election ID ",
                      style: Controller.kblackSemiBoldStyle(context)
                          .copyWith(fontSize: 13.sp),
                      children: [])),
              SizedBox(
                height: 0.5.h,
              ),
              SelectableText(
                DataConstants.criminalControllerMobx.singleAccusedData
                    .criminalElectionId!,
                style: Controller.kblackSemiNormalStyle(context),
              ),
            ],
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.criminalElectionId
                .toString() !=
            '')
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants
                .criminalControllerMobx.singleAccusedData.currentJobDetails !=
            null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Job Details ",
                              style: Controller.kblackSemiBoldStyle(context)
                                  .copyWith(fontSize: 13.sp),
                              children: [])),
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                isDismissible: false,
                                builder: (context) {
                                  return AddMobileAddressWork(
                                    type: "jobDetails",
                                    accusedId: widget.accused!.sId!,
                                  );
                                });
                          },
                          child: const Icon(
                            Icons.add_circle,
                            color: primaryColor,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        DataConstants.criminalControllerMobx.singleAccusedData
                            .currentJobDetails!.length, (index) {
                      return Container(
                        // width: 40.w,
                        margin: EdgeInsets.only(bottom: 1.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 2.w),
                        decoration:
                            BoxDecoration(border: Border.all(color: black)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'Work - ',
                                    style:
                                        Controller.kblackSemiBoldStyle(context),
                                    children: [
                                  TextSpan(
                                    text: DataConstants
                                            .criminalControllerMobx
                                            .singleAccusedData
                                            .currentJobDetails![index]
                                            .jobProfile ??
                                        'NA',
                                    style: Controller.kblackSemiNormalStyle(
                                        context),
                                  )
                                ])),
                            // Text(
                            //   DataConstants
                            //       .criminalControllerMobx
                            //       .singleAccusedData
                            //       .currentJobDetails![index]
                            //       .jobProfile!,
                            //   style:
                            //       Controller.kblackSemiNormalStyle(
                            //           context),
                            // ),
                            RichText(
                                text: TextSpan(
                                    text: 'Company Name - ',
                                    style:
                                        Controller.kblackSemiBoldStyle(context),
                                    children: [
                                  TextSpan(
                                    text: DataConstants
                                        .criminalControllerMobx
                                        .singleAccusedData
                                        .currentJobDetails![index]
                                        .companyName!,
                                    style: Controller.kblackSemiNormalStyle(
                                        context),
                                  )
                                ])),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
              if (DataConstants.criminalControllerMobx.singleAccusedData
                  .currentJobDetails!.isNotEmpty)
                SizedBox(
                  height: 2.h,
                ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     RichText(
              //         text: TextSpan(
              //             text: "Company Name ",
              //             style: Controller.kblackSemiBoldStyle(
              //                     context)
              //                 .copyWith(fontSize: 13.sp),
              //             children: [])),
              //     SizedBox(
              //       height: 0.5.h,
              //     ),
              //     Text(
              //       DataConstants
              //               .criminalControllerMobx
              //               .singleAccusedData
              //               .currentJobDetails!
              //               .first
              //               .companyName ??
              //           'NA',
              //       style:
              //           Controller.kblackSemiNormalStyle(context),
              //     ),
              //   ],
              // ),
              // if (DataConstants
              //         .criminalControllerMobx
              //         .singleAccusedData
              //         .currentJobDetails!
              //         .companyName
              //         .toString() !=
              //     '')
              //   SizedBox(
              //     height: 2.h,
              //   ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     RichText(
              //         text: TextSpan(
              //             text: "Company/Employer Address ",
              //             style: Controller.kblackSemiBoldStyle(context)
              //                 .copyWith(fontSize: 13.sp),
              //             children: [])),
              //     SizedBox(
              //       height: 0.5.h,
              //     ),
              //     Text(
              //       DataConstants.criminalControllerMobx.singleAccusedData.currentJobDetails!.companyLocation ??
              //           'NA',
              //       style: Controller.kblackSemiNormalStyle(context),
              //     ),
              //   ],
              // ),
              // if (DataConstants.criminalControllerMobx.singleAccusedData.currentJobDetails!.companyLocation
              //         .toString() !=
              //     '')
              //   SizedBox(
              //     height: 2.h,
              //   ),
              // Column(
            ],
          ),
        if (DataConstants.criminalControllerMobx.singleAccusedData
                .currentlyUsedVehicles !=
            null)
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Vehicle Type ",
                          style: Controller.kblackSemiBoldStyle(context)
                              .copyWith(fontSize: 13.sp),
                          children: [])),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    Controller.camelToSentence(DataConstants
                        .criminalControllerMobx
                        .singleAccusedData
                        .currentlyUsedVehicles!
                        .vehicleType!),
                    style: Controller.kblackSemiNormalStyle(context),
                  ),
                ],
              ),
              if (DataConstants.criminalControllerMobx.singleAccusedData
                      .currentlyUsedVehicles!.vehicleType
                      .toString() !=
                  '')
                SizedBox(
                  height: 2.h,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Vehicle No. ",
                          style: Controller.kblackSemiBoldStyle(context)
                              .copyWith(fontSize: 13.sp),
                          children: [])),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    DataConstants.criminalControllerMobx.singleAccusedData
                        .currentlyUsedVehicles!.vehicleNo!,
                    style: Controller.kblackSemiNormalStyle(context),
                  ),
                ],
              ),
              if (DataConstants.criminalControllerMobx.singleAccusedData
                      .currentlyUsedVehicles!.vehicleNo
                      .toString() !=
                  '')
                SizedBox(
                  height: 2.h,
                ),
            ],
          ),
        if (DataConstants
            .criminalControllerMobx.singleAccusedData.modusOperandi!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Modus Operandi ",
                      style: Controller.kblackSemiBoldStyle(context)
                          .copyWith(fontSize: 13.sp),
                      children: [])),
              SizedBox(
                height: 0.5.h,
              ),
              ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: DataConstants.criminalControllerMobx
                      .singleAccusedData.modusOperandi!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Text(
                      '- ' +
                          DataConstants.criminalControllerMobx.singleAccusedData
                              .modusOperandi![index],
                      style: Controller.kblackSemiNormalStyle(context).copyWith(
                        height: 1.5,
                      ),
                    );
                  }),
            ],
          ),
        if (DataConstants.criminalControllerMobx.singleAccusedData.modusOperandi
                .toString() !=
            '')
          SizedBox(
            height: 2.h,
          ),
        if (DataConstants.criminalControllerMobx.singleAccusedData.relations !=
                null &&
            DataConstants
                .criminalControllerMobx.singleAccusedData.relations!.isNotEmpty)
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Relatives of accused',
                  style: Controller.kblackSemiBoldStyle(context),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: DataConstants
                    .criminalControllerMobx.singleAccusedData.relations!.length,
                itemBuilder: (context, index) {
                  var relative = DataConstants.criminalControllerMobx
                      .singleAccusedData.relations![index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 1.h, right: 3.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${Controller.camelToSentence(relative.relationWithAccused ?? 'Name')} - ${relative.name ?? ''}',
                            style: Controller.kblackSemiNormalStyle(context),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Address - ${relative.address ?? 'NA'}',
                            style: Controller.kblackSemiNormalStyle(context),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Mobile No. - ${relative.mobileNo ?? 'NA'}',
                            style: Controller.kblackSemiNormalStyle(context),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          )
      ],
    );
  }

  Widget criminalRecord(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 1,
          color: grey,
        ),
        SizedBox(
          height: 1.h,
        ),
        if (DataConstants.criminalControllerMobx.checkupForm.isNotEmpty)
          Container(
            // margin: EdgeInsets.symmetric(),
            child: Text(
              'Criminal Record',
              style: Controller.kblackSemiBoldStyle(context)
                  .copyWith(fontSize: 15.sp),
            ),
          ),
        SizedBox(
          height: 2.h,
        ),
        if (DataConstants.criminalControllerMobx.checkupForm.isNotEmpty)
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount:
                  DataConstants.criminalControllerMobx.checkupForm.length,
              itemBuilder: (context, index) {
                var checkup =
                    DataConstants.criminalControllerMobx.checkupForm[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  margin: EdgeInsets.only(bottom: 2.h),
                  color: textfieldbgColor,
                  // decoration: BoxDecoration(border: Border.all(color: black)),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Police Station - ',
                                  style:
                                      Controller.kblackSemiBoldStyle(context),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  Controller.camelToSentence(
                                      checkup.policeStation!),
                                  style:
                                      Controller.kblackSemiNormalStyle(context),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'FIR(s)',
                              style: Controller.kblackSemiBoldStyle(context),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: checkup.firstInformationReport!.length,
                            itemBuilder: (context, index) {
                              var officer =
                                  checkup.firstInformationReport![index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 1.h),
                                // decoration: BoxDecoration(
                                //   border: Border.all(color: primaryColor),
                                // ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.w, vertical: 0.5.h),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${index + 1})  $officer',
                                    style: Controller.kblackSemiNormalStyle(
                                        context),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      if (checkup.officerOrPolicemanKnowingAccused!.isNotEmpty)
                        SizedBox(
                          height: 2.h,
                        ),
                      if (checkup.crimeSection!.isNotEmpty)
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Section(s)',
                                style: Controller.kblackSemiBoldStyle(context),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: checkup.crimeSection!.length,
                              itemBuilder: (context, index) {
                                var officer = checkup.crimeSection![index];
                                return Container(
                                  margin: EdgeInsets.only(bottom: 1.h),
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(color: primaryColor),
                                  // ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.w, vertical: 0.5.h),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${index + 1})  $officer',
                                      style: Controller.kblackSemiNormalStyle(
                                          context),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              }),
      ],
    );
  }
}
