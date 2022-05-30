import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbvv/utils/color_constants.dart';
import 'package:mbvv/utils/common_views.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:sizer/sizer.dart';

class CDropDown extends StatefulWidget {
  final TextEditingController? controller;
  final double? width;
  final String? hint_text;
  final List<String>? itmes;
  final String? lable_text;
  final String? suffix_text;
  final IconData? icon;
  final String? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final TextStyle? style;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validation;
  final ValueChanged? onSaved;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final int? maxline;
  final Function()? onPressed;
  final bool? readOnly;
  final int? maxLength;
  final String? value;

  const CDropDown(
      {Key? key,
      this.controller,
      this.hint_text,
      this.itmes,
      this.lable_text,
      this.suffix_text,
      this.icon,
      this.suffixIcon = null,
      this.textInputType,
      this.textInputAction,
      this.isPassword = false,
      this.style,
      this.enabled,
      this.inputFormatters,
      this.validation,
      this.onSaved,
      this.focusNode,
      this.nextFocusNode,
      this.maxline = 1,
      this.onPressed,
      this.readOnly = false,
      this.maxLength,
      this.value,
      this.width})
      : super(key: key);

  @override
  _CDropDownState createState() => _CDropDownState();
}

class _CDropDownState extends State<CDropDown> {
  bool isPass = false;
  DateTime? selectedDate;

  @override
  void initState() {
    setState(() {
      isPass = widget.isPassword;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: DropdownButtonFormField(
        isExpanded: true,
        value: widget.value,
        focusNode: widget.focusNode ?? widget.focusNode,
        onChanged: (value) {
          if (widget.onSaved != null) {
            return widget.onSaved!(value);
          }
        },
        style: widget.style ??
            Controller.kblackSemiNormalStyle(context).copyWith(fontSize: 11.sp),
        onTap: widget.onPressed,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          counterText: "",
          prefixIcon: widget.icon != null
              ? Container(
                  child: Icon(widget.icon, size: 20.0, color: primaryColor),
                )
              : null,
          suffixText: widget.suffix_text,
          suffixStyle: Theme.of(context).textTheme.subtitle1,
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  icon: SvgPicture.asset(
                    widget.suffixIcon.toString(),
                    color: black.withOpacity(0.7),
                    height: 16,
                    width: 16,
                  ),
                  onPressed: () {},
                )
              : null,
          hintText: widget.hint_text,
          hintStyle: widget.style ??
              Theme.of(context).textTheme.subtitle1!.copyWith(color: grey),
          labelText: widget.lable_text ?? null,
          labelStyle: widget.style ??
              Theme.of(context).textTheme.subtitle1!.copyWith(color: grey),
          focusedErrorBorder: widget.maxline! > 1
              ? CommonView.errorBorderMaxLine
              : CommonView.errorBorder,
          errorBorder: widget.maxline! > 1
              ? CommonView.errorBorderMaxLine
              : CommonView.errorBorder,
          contentPadding:
              EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1.5.h),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(1.5.h),
          ),
          errorMaxLines: 2,
          errorStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
        ),
        items: widget.itmes!
            .map((e) => DropdownMenuItem(
                  child: Text(Controller.camelToSentence(e)),
                  value: e,
                ))
            .toList(),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocusNode) {
    currentFocus!.unfocus();
    if (nextFocusNode != null) {
      FocusScope.of(context).requestFocus(nextFocusNode);
    } else {
      Controller.dismissKeyboard(context);
    }
  }
}
