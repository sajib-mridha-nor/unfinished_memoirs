import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/utils/padding.dart';
import 'package:bongobondhu_app/core/widgets/common_container.dart';
import 'package:flutter/material.dart';

class CommonBottomSheet extends StatelessWidget {
  const CommonBottomSheet({
    Key? key,
    this.shouldShowDivider = true,
    required this.body,
    this.isTitleCenterTile = false,
    this.bottomWidget = const SizedBox(),
    this.title = const SizedBox(),
  }) : super(key: key);

  final Widget title;
  final Widget body;
  final bool shouldShowDivider;
  final Widget bottomWidget;
  final bool isTitleCenterTile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          CommonContainer(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: Padding(
              padding: modalSheetPadding,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isTitleCenterTile) const SizedBox(),
                    title,
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CommonContainer(
                        height: 30,
                        width: 30,
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(50),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
