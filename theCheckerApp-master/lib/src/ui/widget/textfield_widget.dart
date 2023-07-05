import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

class TxtField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final int maxLen;
  final int maxLine;
  final String label;
  final bool isObscure;
  final bool hasSearchIcon;
  final bool readOnly;
  final VoidCallback? obscureTap;

  TxtField({
    Key? key,
    required this.controller,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.maxLen = 20,
    this.maxLine = 1,
    required this.label,
    this.isObscure = true,
    this.obscureTap,
    this.hasSearchIcon = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF757575), width: .7),
        borderRadius: BorderRadius.circular(6));

    return TextField(
      textInputAction: inputAction,
      readOnly: readOnly,
      controller: controller,
      obscureText: obscureTap == null ? false : isObscure,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        suffixIcon: obscureTap == null
            ? const SizedBox()
            : CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: obscureTap,
                child: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Get.theme.primaryColor,
                )),
        prefixIcon: hasSearchIcon
            ? Icon(
                CupertinoIcons.search,
                color: Get.theme.primaryColor,
              )
            : null,
        filled: true,
        counterText: "",
        contentPadding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: 0,
        ),
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        label: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Get.theme.hintColor,
              fontSize: 14),
        ),
      ),
      maxLines: maxLine,
      keyboardType: inputType,
      maxLength: maxLen,
    );
  }
}
