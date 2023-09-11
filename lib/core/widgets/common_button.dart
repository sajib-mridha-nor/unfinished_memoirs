import 'package:bongobondhu_app/core/theme/styles.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.buttonTitle,
    this.onTap,
    this.height = 45,
    this.width = 120,
    this.fontSize = 16,
    this.borderRadius = 15,
    this.buttonTextColor,
    this.fontWeight = FontWeight.w400,
    this.buttonColor,
    this.leadingIcon,
    this.trailingIcon,
    this.isIndex = false,
  }) : super(key: key);

  final String buttonTitle;
  final double height;
  final GestureTapCallback? onTap;
  final double width;
  final double borderRadius;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final bool isIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor ?? Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon != null) leadingIcon!,
              const SizedBox(
                height: 10,
              ),
              if (isIndex)
                Center(
                  child: SizedBox(
                    width: width - 10,
                    child: TextWidget(
                      buttonTitle,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyles.regular14.copyWith(
                        color: buttonTextColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ),
                )
              else
                Center(
                  child: TextWidget(
                    buttonTitle,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyles.regular14.copyWith(
                      color: buttonTextColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              if (trailingIcon != null) trailingIcon!,
            ],
          ),
        ),
      ),
    );
  }
}
