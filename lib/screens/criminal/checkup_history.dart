import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mbvv/models/accused_list_response.dart';
import 'package:mbvv/models/checkup_form_list_response.dart';
import 'package:mbvv/screens/criminal/add_criminal.dart';
import 'package:mbvv/screens/criminal/quick_checkup_details.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/widgets/custom_button.dart';
import 'package:mbvv/widgets/gf_loader.dart';
import 'package:sizer/sizer.dart';

class CheckUpHistory extends StatefulWidget {
  final Accused? accused;
  const CheckUpHistory({Key? key, this.accused}) : super(key: key);

  @override
  State<CheckUpHistory> createState() => _CheckUpHistoryState();
}

class _CheckUpHistoryState extends State<CheckUpHistory> {
  @override
  void initState() {
    super.initState();
    DataConstants.allApisHandling
        .getAccusedCheckupHistory(context, widget.accused!.sId!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   backgroundColor: primaryColor,
        //   centerTitle: true,
        //   leading: BackButton(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     color: white,
        //   ),
        //   title: Text(
        //     'Check Up History',
        //     style: Controller.kblackNormalStyle(context).copyWith(color: white),
        //   ),
        // ),
        body: Observer(builder: (context) {
          return DataConstants
                  .criminalControllerMobx.showCheckUpHistoryUpLoading
              ? const CustomGFLoader()
              : DataConstants.criminalControllerMobx.checkupForm.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: DataConstants
                                  .criminalControllerMobx.checkupForm.length,
                              itemBuilder: (context, index) {
                                var checkup = DataConstants
                                    .criminalControllerMobx.checkupForm[index];
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.h),
                                  decoration: BoxDecoration(
                                      color: textfieldbgColor,
                                      borderRadius: BorderRadius.circular(1.h)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 2.h),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Container(
                                              //   alignment: Alignment.centerLeft,
                                              //   child: Text(
                                              //     Controller.camelToSentence(
                                              //         checkup.policeStation!),
                                              //     style:
                                              //         Controller.kblackSemiBoldStyle(
                                              //             context),
                                              //   ),
                                              // ),
                                              // Expanded(
                                              //   flex: 4,
                                              //   child: buildDetails(
                                              //     'Police Station',
                                              //     Controller.camelToSentence(
                                              //         checkup.policeStation!),
                                              //   ),
                                              // ),
                                              buildDetails(
                                                  'Checked On',
                                                  DateFormat(
                                                          'dd/MM/yyyy hh:mm a')
                                                      .format(checkup.createdAt!
                                                          .toLocal()),
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start),
                                              // Container(
                                              //   alignment: Alignment.centerLeft,
                                              //   child: Text(
                                              //     DateFormat('dd MMM yyy hh:mm a')
                                              //         .format(checkup.createdAt!
                                              //             .toLocal()),
                                              //     style:
                                              //         Controller.kblackSemiBoldStyle(
                                              //             context),
                                              //   ),
                                              // ),
                                              buildDetails(
                                                  'Lat', checkup.lat.toString(),
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          // Container(
                                          //   alignment: Alignment.centerLeft,
                                          //   child: Text(
                                          //     'Checked By - ' +
                                          //         checkup.checkedBy!.displayName!,
                                          //     style: Controller.kblackSemiBoldStyle(
                                          //         context),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 1.h,
                                      // ),
                                      // const Divider(
                                      //   color: primaryColor,
                                      // ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      // Container(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: Text(
                                      //     'Lat: ${checkup.lat}      Long:  ${checkup.long}',
                                      //     style: Controller.kblackSemiNormalStyle(
                                      //         context),
                                      //   ),
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: buildDetails(
                                                'Checked By',
                                                checkup
                                                    .checkedBy!.displayName!),
                                          ),
                                          buildDetails(
                                              'Long', checkup.long.toString(),
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 2.h,
                                      // ),
                                      // Container(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: Flexible(
                                      //     child: Text(
                                      //       'Consumption Or Influence Of NDPS Drugs : ${checkup.consumptionOrInfluenceOfNDPSDrugs!.doesCriminalConsumesDrugs!}',
                                      //       style: Controller.kblackSemiNormalStyle(
                                      //           context),
                                      //     ),
                                      //   ),
                                      // ),
                                      // buildDetails(
                                      //     'Whether this accused often takes NDPS Drugs or alcohol? ',
                                      //     checkup.consumptionOrInfluenceOfNDPSDrugs!
                                      //         .doesCriminalConsumesDrugs!),
                                      // if (checkup.consumptionOrInfluenceOfNDPSDrugs!
                                      //         .doesCriminalConsumesDrugs! ==
                                      //     'Yes')
                                      //   SizedBox(
                                      //     height: 2.h,
                                      //   ),
                                      // if (checkup.consumptionOrInfluenceOfNDPSDrugs!
                                      //         .doesCriminalConsumesDrugs! ==
                                      //     'Yes')
                                      // Container(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: Text(
                                      //     'Drugs : ${checkup.consumptionOrInfluenceOfNDPSDrugs!.drugsConsumed!}',
                                      //     style: Controller.kblackSemiNormalStyle(
                                      //         context),
                                      //   ),
                                      // ),
                                      //   buildDetails(
                                      //       'Drugs: ',
                                      //       checkup.consumptionOrInfluenceOfNDPSDrugs!
                                      //           .drugsConsumed!),
                                      // SizedBox(
                                      //   height: 2.h,
                                      // ),
                                      // buildDetails(
                                      //     'Does the accused carried deadly weapon? ',
                                      //     checkup.isAccusedCarryingHarmfulWeapon !=
                                      //             null
                                      //         ? checkup
                                      //                 .isAccusedCarryingHarmfulWeapon!
                                      //             ? 'Yes'
                                      //             : 'No'
                                      //         : 'No'),
                                      // Container(
                                      //   margin: EdgeInsets.only(bottom: 1.h),
                                      //   decoration: BoxDecoration(
                                      //     border: Border.all(color: primaryColor),
                                      //   ),
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: 3.w, vertical: 1.h),
                                      //   child: Column(
                                      //     children: [
                                      //       Container(
                                      //         alignment: Alignment.centerLeft,
                                      //         child: Text(
                                      //           'Is Deported : ${checkup.deportedAccused!.isAccusedDeported! ? "Yes" : "No"}',
                                      //           style:
                                      //               Controller.kblackSemiNormalStyle(
                                      //                   context),
                                      //         ),
                                      //       ),
                                      //       if (checkup
                                      //           .deportedAccused!.isAccusedDeported!)
                                      //         Column(
                                      //           children: [
                                      //             SizedBox(
                                      //               height: 1.h,
                                      //             ),
                                      //             Container(
                                      //               alignment: Alignment.centerLeft,
                                      //               child: Text(
                                      //                 'Order No. : ${checkup.deportedAccused!.orderNo!}',
                                      //                 style: Controller
                                      //                     .kblackSemiNormalStyle(
                                      //                         context),
                                      //               ),
                                      //             ),
                                      //             SizedBox(
                                      //               height: 1.h,
                                      //             ),
                                      //             Container(
                                      //               alignment: Alignment.centerLeft,
                                      //               child: Text(
                                      //                 'From Date : ${checkup.deportedAccused!.fromDate != null ? DateFormat("dd MMM yyyy").format(checkup.deportedAccused!.fromDate!) : "NA"}',
                                      //                 style: Controller
                                      //                     .kblackSemiNormalStyle(
                                      //                         context),
                                      //               ),
                                      //             ),
                                      //             SizedBox(
                                      //               height: 1.h,
                                      //             ),
                                      //             Container(
                                      //               alignment: Alignment.centerLeft,
                                      //               child: Text(
                                      //                 'To Date : ${checkup.deportedAccused!.toDate != null ? DateFormat("dd MMM yyyy").format(checkup.deportedAccused!.toDate!) : "NA"}',
                                      //                 style: Controller
                                      //                     .kblackSemiNormalStyle(
                                      //                         context),
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
                                      // if (checkup.officerOrPolicemanKnowingAccused!
                                      //     .isNotEmpty)
                                      //   Column(
                                      //     children: [
                                      //       Container(
                                      //         alignment: Alignment.centerLeft,
                                      //         child: Text(
                                      //           'FIR(s)',
                                      //           style: Controller.kblackSemiBoldStyle(
                                      //               context),
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         height: 1.h,
                                      //       ),
                                      //       ListView.builder(
                                      //         shrinkWrap: true,
                                      //         physics: const ClampingScrollPhysics(),
                                      //         itemCount: checkup
                                      //             .firstInformationReport!.length,
                                      //         itemBuilder: (context, index) {
                                      //           var officer = checkup
                                      //               .firstInformationReport![index];
                                      //           return Container(
                                      //             margin:
                                      //                 EdgeInsets.only(bottom: 1.h),
                                      //             decoration: BoxDecoration(
                                      //               border: Border.all(
                                      //                   color: primaryColor),
                                      //             ),
                                      //             padding: EdgeInsets.symmetric(
                                      //                 horizontal: 3.w, vertical: 1.h),
                                      //             child: Container(
                                      //               alignment: Alignment.centerLeft,
                                      //               child: Text(
                                      //                 'FIR No. - $officer',
                                      //                 style: Controller
                                      //                     .kblackSemiNormalStyle(
                                      //                         context),
                                      //               ),
                                      //             ),
                                      //           );
                                      //         },
                                      //       ),
                                      //     ],
                                      //   ),
                                      // if (checkup.officerOrPolicemanKnowingAccused!
                                      //     .isNotEmpty)
                                      //   SizedBox(
                                      //     height: 2.h,
                                      //   ),
                                      // if (checkup.crimeSection!.isNotEmpty)
                                      //   Column(
                                      //     children: [
                                      //       Container(
                                      //         alignment: Alignment.centerLeft,
                                      //         child: Text(
                                      //           'SECTION(s)',
                                      //           style: Controller.kblackSemiBoldStyle(
                                      //               context),
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         height: 1.h,
                                      //       ),
                                      //       ListView.builder(
                                      //         shrinkWrap: true,
                                      //         physics: const ClampingScrollPhysics(),
                                      //         itemCount: checkup.crimeSection!.length,
                                      //         itemBuilder: (context, index) {
                                      //           var officer =
                                      //               checkup.crimeSection![index];
                                      //           return Container(
                                      //             margin:
                                      //                 EdgeInsets.only(bottom: 1.h),
                                      //             decoration: BoxDecoration(
                                      //               border: Border.all(
                                      //                   color: primaryColor),
                                      //             ),
                                      //             padding: EdgeInsets.symmetric(
                                      //                 horizontal: 3.w, vertical: 1.h),
                                      //             child: Container(
                                      //               alignment: Alignment.centerLeft,
                                      //               child: Text(
                                      //                 'SECTION No. - $officer',
                                      //                 style: Controller
                                      //                     .kblackSemiNormalStyle(
                                      //                         context),
                                      //               ),
                                      //             ),
                                      //           );
                                      //         },
                                      //       ),
                                      //     ],
                                      //   ),
                                      // if (checkup.crimeSection!.isNotEmpty)
                                      //   SizedBox(
                                      //     height: 2.h,
                                      //   ),
                                      // if (checkup.officerOrPolicemanKnowingAccused!
                                      //     .isNotEmpty)
                                      //   Column(
                                      //     children: [
                                      //       Container(
                                      //         alignment: Alignment.centerLeft,
                                      //         child: Text(
                                      //           'Officer/Policeman knowing accused',
                                      //           style: Controller.kblackSemiBoldStyle(
                                      //               context),
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         height: 1.h,
                                      //       ),
                                      //       ListView.builder(
                                      //         shrinkWrap: true,
                                      //         physics: const ClampingScrollPhysics(),
                                      //         itemCount: checkup
                                      //             .officerOrPolicemanKnowingAccused!
                                      //             .length,
                                      //         itemBuilder: (context, index) {
                                      //           var officer = checkup
                                      //                   .officerOrPolicemanKnowingAccused![
                                      //               index];
                                      //           return Container(
                                      //             margin:
                                      //                 EdgeInsets.only(bottom: 1.h),
                                      //             decoration: BoxDecoration(
                                      //               border: Border.all(
                                      //                   color: primaryColor),
                                      //             ),
                                      //             padding: EdgeInsets.symmetric(
                                      //                 horizontal: 3.w, vertical: 1.h),
                                      //             child: Column(
                                      //               children: [
                                      //                 Container(
                                      //                   alignment:
                                      //                       Alignment.centerLeft,
                                      //                   child: Text(
                                      //                     '${Controller.camelToSentence(officer.relationWithAccused ?? 'Name')} - ${officer.officerOrPolicemanName ?? ''}',
                                      //                     style: Controller
                                      //                         .kblackSemiNormalStyle(
                                      //                             context),
                                      //                   ),
                                      //                 ),
                                      //                 Container(
                                      //                   alignment:
                                      //                       Alignment.centerLeft,
                                      //                   child: Text(
                                      //                     '${officer.isFromDepartment == 'policeStation' ? 'Police Station' : 'Special unit'} - ${officer.department.toString() != 'null' ? Controller.camelToSentence(officer.department!) : 'NA'}',
                                      //                     style: Controller
                                      //                         .kblackSemiNormalStyle(
                                      //                             context),
                                      //                   ),
                                      //                 ),
                                      //                 Container(
                                      //                   alignment:
                                      //                       Alignment.centerLeft,
                                      //                   child: Text(
                                      //                     'Mobile No. - ${officer.officerOrPolicemanMobileNo.toString() != '' ? officer.officerOrPolicemanMobileNo! : 'NA'}',
                                      //                     style: Controller
                                      //                         .kblackSemiNormalStyle(
                                      //                             context),
                                      //                   ),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           );
                                      //         },
                                      //       ),
                                      //     ],
                                      //   )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          // const Spacer(),
                          CGradientButton(
                            buttonName: 'Quick Check-Up',
                            onPress: () {
                              // addQuickCheckup();
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  backgroundColor: white,
                                  builder: (context) {
                                    return QuickCheckupDetails(
                                      checkup: DataConstants
                                          .criminalControllerMobx
                                          .checkupForm
                                          .first,
                                    );
                                  });
                            },
                            width: 45.w,
                          )
                        ],
                      ),
                    )
                  : Center(
                      // alignment: Alignment.center,
                      // margin: EdgeInsets.only(top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'No Check-Up history',
                            style: Controller.kblackNormalStyle(context),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CGradientButton(
                            buttonName: 'Add Check-Up Details',
                            onPress: () {
                              Get.to(AddEditCriminalRecord(
                                accused: widget.accused,
                              ));
                            },
                            width: 50.w,
                          )
                        ],
                      ),
                    );
        }),
      ),
    );
  }

  Widget buildDetails(String heading, String value,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.h),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(
              heading,
              style: Controller.kblackSemiNormalStyle(context)
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 0.5.h,
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

  void addQuickCheckup() async {
    var map = DataConstants.criminalControllerMobx.checkupForm.first.toJson();
    log(map.toString());
    Location location = new Location();
    LocationData _pos = await location.getLocation();

    map["lat"] = _pos.latitude!.toStringAsFixed(3);
    map["long"] = _pos.longitude!.toStringAsFixed(3);
    log(map.toString());
    // return;
    DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading = true;
    Controller.getInternetStatus().then((value) async {
      print("this is internet status $value ");
      if (value!) {
        DataConstants.allApisHandling
            .addCheckUpForm(map, context, widget.accused!.sId!);
      } else {
        DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading =
            false;
        Controller.showSuccessToast1("No internet connection!", context);
      }
    });
  }
}
