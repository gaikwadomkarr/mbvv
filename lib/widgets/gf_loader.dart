import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mbvv/utils/color_constants.dart';

class CustomGFLoader extends StatelessWidget {
  const CustomGFLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFLoader(
      loaderColorOne: primaryColor.withOpacity(0.3),
      loaderColorTwo: primaryColor.withOpacity(0.5),
      loaderColorThree: primaryColor.withOpacity(0.9),
      type: GFLoaderType.circle,
      size: GFSize.LARGE,
    );
  }
}
