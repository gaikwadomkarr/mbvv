import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mbvv/models/checkup_form_list_response.dart';
import 'package:mbvv/utils/common_views.dart';
import 'package:sizer/sizer.dart';

import '../../utils/color_constants.dart';
import '../../utils/controller.dart';
import '../../utils/data_constants.dart';
import '../../widgets/custom_button.dart';

class QuickCheckupDetails extends StatefulWidget {
  final CheckUpForm? checkup;
  const QuickCheckupDetails({Key? key, this.checkup}) : super(key: key);

  @override
  State<QuickCheckupDetails> createState() => _QuickCheckupDetailsState();
}

class _QuickCheckupDetailsState extends State<QuickCheckupDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 95.h,
      color: white,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last Checkup Details',
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
          // Column(
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         // Container(
          //         //   alignment: Alignment.centerLeft,
          //         //   child: Text(
          //         //     Controller.camelToSentence(
          //         //         checkup.policeStation!),
          //         //     style:
          //         //         Controller.kblackSemiBoldStyle(
          //         //             context),
          //         //   ),
          //         // ),
          //         // Expanded(
          //         //   flex: 4,
          //         //   child: CommonView.buildDetails(
          //         //     'Police Station',
          //         //     Controller.camelToSentence(
          //         //         checkup.policeStation!),
          //         //   ),
          //         // ),
          //         CommonView.buildDetails(
          //             'Checked On',
          //             DateFormat('dd/MM/yyyy hh:mm a')
          //                 .format(checkup!.createdAt!.toLocal()),
          //             context,
          //             crossAxisAlignment: CrossAxisAlignment.start),
          //         // Container(
          //         //   alignment: Alignment.centerLeft,
          //         //   child: Text(
          //         //     DateFormat('dd MMM yyy hh:mm a')
          //         //         .format(checkup!.createdAt!
          //         //             .toLocal()),
          //         //     style:
          //         //         Controller.kblackSemiBoldStyle(
          //         //             context),
          //         //   ),
          //         // ),
          //         CommonView.buildDetails(
          //             'Lat', checkup!.lat.toString(), context,
          //             crossAxisAlignment: CrossAxisAlignment.end),
          //       ],
          //     ),
          //     SizedBox(
          //       height: 2.h,
          //     ),
          //     // Container(
          //     //   alignment: Alignment.centerLeft,
          //     //   child: Text(
          //     //     'Checked By - ' +
          //     //         checkup!.checkedBy!.displayName!,
          //     //     style: Controller.kblackSemiBoldStyle(
          //     //         context),
          //     //   ),
          //     // ),
          //   ],
          // ),
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
          //     'Lat: ${checkup!.lat}      Long:  ${checkup!.long}',
          //     style: Controller.kblackSemiNormalStyle(
          //         context),
          //   ),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(
          //       flex: 5,
          //       child: CommonView.buildDetails(
          //           'Checked By', checkup!.checkedBy!.displayName!, context),
          //     ),
          //     CommonView.buildDetails('Long', checkup!.long.toString(), context,
          //         crossAxisAlignment: CrossAxisAlignment.end),
          //   ],
          // ),
          // SizedBox(
          //   height: 2.h,
          // ),
          CommonView.buildDetails(
              'Whether this accused often takes NDPS Drugs or alcohol? ',
              widget.checkup!.consumptionOrInfluenceOfNDPSDrugs!
                  .doesCriminalConsumesDrugs!,
              context),
          SizedBox(
            height: 2.h,
          ),
          if (widget.checkup!.consumptionOrInfluenceOfNDPSDrugs!
                  .doesCriminalConsumesDrugs! ==
              'Yes')
            CommonView.buildDetails(
                'Drugs: ',
                widget
                    .checkup!.consumptionOrInfluenceOfNDPSDrugs!.drugsConsumed!,
                context),
          if (widget.checkup!.consumptionOrInfluenceOfNDPSDrugs!
                  .doesCriminalConsumesDrugs! ==
              'Yes')
            SizedBox(
              height: 2.h,
            ),
          CommonView.buildDetails(
              'Does the accused carried deadly weapon? ',
              widget.checkup!.isAccusedCarryingHarmfulWeapon != null
                  ? widget.checkup!.isAccusedCarryingHarmfulWeapon!
                      ? 'Yes'
                      : 'No'
                  : 'No',
              context),
          SizedBox(
            height: 2.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            margin: EdgeInsets.only(bottom: 2.h),
            color: textfieldbgColor,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Police Station - ',
                        style: Controller.kblackSemiBoldStyle(context),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        Controller.camelToSentence(
                            widget.checkup!.policeStation!),
                        style: Controller.kblackSemiNormalStyle(context),
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
                  itemCount: widget.checkup!.firstInformationReport!.length,
                  itemBuilder: (context, index) {
                    var officer =
                        widget.checkup!.firstInformationReport![index];
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
                          style: Controller.kblackSemiNormalStyle(context),
                        ),
                      ),
                    );
                  },
                ),
                if (widget.checkup!.crimeSection!.isNotEmpty)
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
                        itemCount: widget.checkup!.crimeSection!.length,
                        itemBuilder: (context, index) {
                          var officer = widget.checkup!.crimeSection![index];
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
                                style:
                                    Controller.kblackSemiNormalStyle(context),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),

          if (widget.checkup!.crimeSection!.isNotEmpty)
            SizedBox(
              height: 2.h,
            ),
          if (widget.checkup!.officerOrPolicemanKnowingAccused!.isNotEmpty)
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Officer/Policeman knowing accused',
                    style: Controller.kblackSemiBoldStyle(context),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount:
                      widget.checkup!.officerOrPolicemanKnowingAccused!.length,
                  itemBuilder: (context, index) {
                    var officer = widget
                        .checkup!.officerOrPolicemanKnowingAccused![index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 1.h),
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
                              '${Controller.camelToSentence(officer.relationWithAccused ?? 'Name')} - ${officer.officerOrPolicemanName ?? ''}',
                              style: Controller.kblackSemiNormalStyle(context),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${officer.isFromDepartment == 'policeStation' ? 'Police Station' : 'Special unit'} - ${officer.department.toString() != 'null' ? Controller.camelToSentence(officer.department!) : 'NA'}',
                              style: Controller.kblackSemiNormalStyle(context),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Mobile No. - ${officer.officerOrPolicemanMobileNo.toString() != '' ? officer.officerOrPolicemanMobileNo! : 'NA'}',
                              style: Controller.kblackSemiNormalStyle(context),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          Observer(builder: (context) {
            return CGradientButton(
              buttonName: DataConstants
                      .criminalControllerMobx.showCheckUpHistoryUpLoading
                  ? ''
                  : 'Add as new CheckUp',
              onPress: DataConstants
                      .criminalControllerMobx.showCheckUpHistoryUpLoading
                  ? null
                  : () {
                      addQuickCheckup(context);
                    },
              width: 50.w,
              icon: DataConstants
                      .criminalControllerMobx.showCheckUpHistoryUpLoading
                  ? Container(
                      height: 4.h,
                      width: 8.w,
                      child: const CircularProgressIndicator(
                        color: white,
                        strokeWidth: 2,
                      ),
                    )
                  : null,
            );
          })
        ],
      ),
    );
  }

  void addQuickCheckup(BuildContext context) async {
    var map = widget.checkup!.toJson();
    log(map.toString());
    DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading = true;
    Location location = new Location();
    LocationData _pos = await location.getLocation();

    map["lat"] = _pos.latitude!.toStringAsFixed(3);
    map["long"] = _pos.longitude!.toStringAsFixed(3);
    log(map.toString());
    // return;
    Controller.getInternetStatus().then((value) async {
      print("this is internet status $value ");
      if (value!) {
        DataConstants.allApisHandling.addCheckUpForm(
            map, context, widget.checkup!.accusedId!,
            fromCheckUpHistory: true);
        // Future.delayed(Duration(seconds: 3), () {
        //   DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading =
        //       false;
        // });
      } else {
        DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading =
            false;
        Controller.showSuccessToast1("No internet connection!", context);
      }
    });
  }
}
