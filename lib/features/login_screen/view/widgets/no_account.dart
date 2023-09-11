import 'package:bongobondhu_app/core/theme/styles.dart';
import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:bongobondhu_app/features/sign_up_screen/view/sign_up_screen.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = Localize().l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          l10n.noAccount,
          style: TextStyles.regular16,
        ),
        InkWell(
          onTap: _onTapSignIn,
          child: TextWidget(
            l10n.signUp,
            style:
                TextStyles.regular16.copyWith(color: const Color(0xffA30000)),
          ),
        ),
      ],
    );
  }

  void _onTapSignIn() {
    AppNavigator.push(const SignUpScreen());
  }
}
