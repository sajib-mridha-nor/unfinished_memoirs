import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  const CommonBottomNavigationBar({
    Key? key,
    required this.bottomNavbarChild,
    this.height = 56,
  }) : super(key: key);
  final Widget bottomNavbarChild;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      height: height,
      child: bottomNavbarChild,
    );
  }
}
