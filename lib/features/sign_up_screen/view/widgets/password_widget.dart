import 'package:bongobondhu_app/core/utils/validator.dart';
import 'package:bongobondhu_app/core/widgets/common_text_field.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget(
      {Key? key,
      required this.passwordController,
      required this.confirmPasswordController})
      : super(key: key);
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

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
            labelText: l10n.password,
            controller: passwordController,
            validator: Validator().nullFieldValidate,
            isRequired: true,
          ),
        ),
        _sizedBoxHeight30,
        SizedBox(
          width: width * .4,
          child: CommonTextField(
            labelText: l10n.retypePassword,
            controller: confirmPasswordController,
            validator: Validator().nullFieldValidate,
            isRequired: true,
          ),
        ),
      ],
    );
  }
}
