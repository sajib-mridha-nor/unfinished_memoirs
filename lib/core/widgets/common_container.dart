import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    Key? key,
    this.border = const Border(),
    this.borderRadius,
    this.margin = EdgeInsets.zero,
    this.color,
    this.width,
    this.height,
    this.child = const SizedBox(),
    this.boxShadow,
    this.constraints,
  }) : super(key: key);
  final double? height;
  final double? width;
  final BoxBorder border;
  final BorderRadiusGeometry? borderRadius;
  final Widget child;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? constraints;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? kPrimaryColor,
        border: border,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      constraints: constraints,
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      margin: margin,
      child: child,
    );
  }
}
