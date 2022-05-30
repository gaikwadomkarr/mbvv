import 'package:flutter/material.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:sizer/sizer.dart';

class CGradientButton extends StatefulWidget {
  final String? buttonName;
  final Function()? onPress;
  final int flag;
  final Widget? icon;
  final TextStyle? style;
  final double? width, height, iconSpacing;

  const CGradientButton(
      {Key? key,
      this.buttonName,
      this.onPress,
      this.flag = 0,
      this.icon,
      this.width,
      this.height,
      this.iconSpacing = 10,
      this.style})
      : super(key: key);

  @override
  _CGradientButtonState createState() => _CGradientButtonState();
}

class _CGradientButtonState extends State<CGradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      width: widget.width ?? 35.w,
      height: widget.height ?? 5.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          color: primaryColor),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: widget.onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) widget.icon!,
            if (widget.icon != null && widget.buttonName != null)
              SizedBox(
                width: widget.iconSpacing,
              ),
            if (widget.buttonName != null)
              Text(widget.buttonName.toString(),
                  style: widget.style ??
                      Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: white)),
          ],
        ),
      ),
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    onPrimary: Colors.transparent,
    primary: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.w)),
    ),
  );

  // final ButtonStyle raisedButtonStyle1 = ElevatedButton(onPressed: onPressed, child: child)

//  final ButtonStyle raisedButtonStyle2 = ElevatedButton.styleFrom(
//    elevation: 0,
//    onPrimary: kwhite,
//    primary: kwhite,
//    fixedSize: Size(140.w, 42.h),
//    padding: EdgeInsets.symmetric(horizontal: 7.w),
//    shape: const RoundedRectangleBorder(
//      borderRadius: BorderRadius.all(Radius.circular(10)),
//    ),
//  );
}
