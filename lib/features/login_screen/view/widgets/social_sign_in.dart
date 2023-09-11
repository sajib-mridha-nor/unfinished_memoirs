import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/core/widgets/common_button.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialSignIn extends StatelessWidget {
  const SocialSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = Localize().l10n;
    final width = MediaQuery.of(context).size.width;
    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, _) {
        final color = themeVm.themeType == ThemeType.Dark
            ? kDarkPrimaryColor
            : whiteColor;
        return Column(
          children: [
            CommonButton(
              buttonTitle: l10n.signInFacebook,
              width: width,
              buttonColor: color,
              borderRadius: 25,
              leadingIcon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  'assets/facebook.png',
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CommonButton(
              buttonTitle: l10n.signInGoogle,
              width: width,
              buttonColor: color,
              borderRadius: 25,
              leadingIcon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  'assets/google.png',
                  height: 20,
                  width: 20,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
