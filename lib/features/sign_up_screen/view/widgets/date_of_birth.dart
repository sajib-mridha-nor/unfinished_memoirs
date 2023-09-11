import 'package:bongobondhu_app/core/utils/exports.dart';
import 'package:bongobondhu_app/core/widgets/common_text_field.dart';
import 'package:bongobondhu_app/core/widgets/text_widget.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class DateOfBirth extends StatelessWidget {
  const DateOfBirth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          Localize().l10n.dateOfBirth,
          style: TextStyles.regular16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * .2,
              child: const CommonTextField(
                readOnly: true,
              ),
            ),
            SizedBox(
              width: width * .2,
              child: const CommonTextField(
                readOnly: true,
              ),
            ),
            SizedBox(
              width: width * .2,
              child: const CommonTextField(
                readOnly: true,
              ),
            ),
          ],
        )
      ],
    );
  }
}
