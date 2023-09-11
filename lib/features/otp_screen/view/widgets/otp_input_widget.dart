import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, _) {
        final isDark = themeVm.themeType == ThemeType.Dark || false;
        return SizedBox(
          height: 60,
          width: 50,
          child: TextField(
            autofocus: autoFocus,
            style: const TextStyle(
              fontSize: 26,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: controller,
            maxLength: 1,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              counterText: '',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: isDark ? primaryWhite : blackColor,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: isDark ? primaryWhite : blackColor,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: isDark ? primaryWhite : blackColor,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        );
      },
    );
  }
}
