import 'package:bongobondhu_app/core/utils/validator.dart';
import 'package:bongobondhu_app/core/widgets/common_text_field.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class NameWidget extends StatelessWidget {
  const NameWidget(
      {Key? key,
      required this.firstNameController,
      required this.lastNameController})
      : super(key: key);
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    const _sizedBoxHeight30 = SizedBox(
      height: 30,
    );
    final l10n = Localize().l10n;

    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width * .35,
          child: CommonTextField(
            labelText: l10n.firstName,
            controller: firstNameController,
            validator: Validator().nullFieldValidate,
            isRequired: true,
          ),
        ),
        _sizedBoxHeight30,
        SizedBox(
          width: width * .35,
          child: CommonTextField(
            labelText: l10n.lastName,
            controller: lastNameController,
            validator: Validator().nullFieldValidate,
            isRequired: true,
          ),
        ),
      ],
    );
  }
}
