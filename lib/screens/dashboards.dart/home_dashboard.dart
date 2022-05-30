import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mbvv/screens/criminal/add_accused_form.dart';
import 'package:mbvv/screens/criminal/add_criminal.dart';
import 'package:mbvv/screens/criminal/search_criminal.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/image_constants.dart';
import 'package:mbvv/utils/string_constants.dart';
import 'package:sizer/sizer.dart';

import '../../utils/data_constants.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  void initState() {
    super.initState();

    DataConstants.allApisHandling.getAccusedList(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: white,
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.85),
                borderRadius: BorderRadius.circular(2.h)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  criminalpng,
                  width: 10.w,
                  height: 5.h,
                ),
                SizedBox(
                  width: 0.w,
                ),
                Text(
                  "Total Accused ",
                  style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Flexible(
                  child: Observer(builder: (context) {
                    return Text(
                      DataConstants
                              .criminalControllerMobx.showAccusedSearchLoading
                          ? "0"
                          : "${DataConstants.criminalControllerMobx.globalAccusedCount}",
                      style: TextStyle(
                          color: white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    );
                  }),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.heavyImpact();
              Get.to(SearchAccused(
                isFromSearc: true,
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
              decoration: BoxDecoration(
                  color: textfieldbgColor,
                  borderRadius: BorderRadius.circular(2.h)),
              child: Row(
                children: [
                  Image.asset(
                    notepng,
                    width: 12.w,
                    height: 5.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Flexible(
                    child: Text(
                      'Accused on record',
                      style: TextStyle(
                          color: black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 2.h,
          // ),
          // GestureDetector(
          //   onTap: () {
          //     HapticFeedback.heavyImpact();
          //     Get.to(SearchAccused());
          //   },
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
          //     decoration: BoxDecoration(
          //         color: textfieldbgColor,
          //         borderRadius: BorderRadius.circular(2.h)),
          //     child: Row(
          //       children: [
          //         Image.asset(
          //           criminalpng,
          //           width: 12.w,
          //           height: 5.h,
          //         ),
          //         SizedBox(
          //           width: 5.w,
          //         ),
          //         Flexible(
          //           child: Text(
          //             ennglishMarathi["recordcheckformen"].toString(),
          //             style: TextStyle(
          //                 color: black,
          //                 fontSize: 13.sp,
          //                 fontWeight: FontWeight.w600),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
