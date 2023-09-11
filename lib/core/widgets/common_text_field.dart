import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/styles.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    Key? key,
    this.focusBorderColor = Colors.transparent,
    this.minimizeBottomPadding = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLength,
    this.validator,
    this.prefix,
    this.errorText,
    this.fontColor = Colors.black,
    this.onChanged,
    this.textInputAction,
    this.controller,
    this.onFieldSubmitted,
    this.focusNode,
    this.hintSize = 14,
    this.isRequired = false,
    this.autofocus = false,
    this.fillColor,
    this.isFilled = true,
    this.hintText,
    this.minLines,
    this.prefixIcon,
    this.obSecure = false,
    this.suffixIcon,
    this.borderRadius = 25,
    this.onTap,
    this.margin = EdgeInsets.zero,
    this.keyboardType,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.maxLines = 1,
    this.textFieldKey,
    this.topPadding = 25,
    this.inputFormatters,
    this.labelText,
    this.enableBorderColor = Colors.transparent,
    this.labelLeftPadding = 0,
    this.labelBottomPadding = 0,
    this.labelFontSize = 16,
  }) : super(key: key);

  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final Color? fontColor;
  final bool? minimizeBottomPadding;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final FocusNode? focusNode;
  final bool? autofocus;
  final bool? enabled;
  final bool? readOnly;
  final bool? isRequired;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? prefix;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final GestureTapCallback? onTap;
  final Key? textFieldKey;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final bool? isFilled;
  final Color? fillColor;
  final bool? obSecure;
  final double? topPadding;
  final double? hintSize;
  final List<TextInputFormatter>? inputFormatters;
  final Color? focusBorderColor;
  final Color? enableBorderColor;
  final String? labelText;
  final double? labelLeftPadding;
  final double? labelBottomPadding;
  final double? labelFontSize;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, _) {
        final isDark = themeVm.themeType == ThemeType.Dark || false;
        return Column(
          children: [
            if (labelText != null)
              Padding(
                padding: EdgeInsets.only(
                  left: labelLeftPadding!,
                  bottom: labelBottomPadding!,
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        labelText ?? '',
                        style: TextStyles.regular14
                            .copyWith(fontSize: labelFontSize),
                      ),
                    ),
                    if (isRequired!)
                      Text(
                        ' *',
                        style: TextStyles.regular14
                            .copyWith(color: const Color(0xffFF5B71)),
                      )
                  ],
                ),
              ),
            TextFormField(
              inputFormatters: inputFormatters,
              obscureText: obSecure!,
              key: textFieldKey,
              onTap: onTap,
              readOnly: readOnly!,
              enabled: enabled,
              maxLength: maxLength,
              style: GoogleFonts.openSans(
                color: isDark ? whiteColor : fontColor,
              ),
              minLines: minLines,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              autofocus: autofocus!,
              focusNode: focusNode,
              maxLines: maxLines,
              keyboardType: keyboardType,
              validator: validator,
              controller: controller,
              textInputAction: textInputAction,
              decoration: InputDecoration(
                filled: isDark ? true : isFilled,
                fillColor:
                    fillColor ?? (isDark ? kDarkPrimaryColor : whiteColor),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                prefix: prefix,
                border: InputBorder.none,
                hintStyle: GoogleFonts.openSans(
                  fontSize: hintSize,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: isDark ? primaryWhite : blackColor),
                ),
                contentPadding: EdgeInsets.zero,
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: isDark ? primaryWhite : blackColor),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                hintText: hintText,
              ),
            ),
          ],
        );
      },
    );
  }
}
