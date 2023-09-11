import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/styles.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/padding.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:bongobondhu_app/features/otp_screen/view/widgets/otp_input_widget.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpFormWidget extends StatefulWidget {
  const OtpFormWidget({Key? key}) : super(key: key);

  @override
  State<OtpFormWidget> createState() => _OtpFormWidgetState();
}

class _OtpFormWidgetState extends State<OtpFormWidget> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const _sizedBoxHeight10 = SizedBox(
      height: 10,
    );
    const _sizedBoxHeight30 = SizedBox(
      height: 30,
    );
    final l10n = Localize().l10n;

    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, _) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: themeVm.themeType == ThemeType.Dark
                ? kDarkPrimaryColor
                : whiteColor,
          ),
          child: Padding(
            padding: leftRightPadding,
            child: Column(
              children: [
                _sizedBoxHeight10,
                _sizedBoxHeight10,
                TextWidget(l10n.welcome, style: TextStyles.regular18),
                _sizedBoxHeight10,
                TextWidget(
                  l10n.signInToGetStarted,
                  textAlign: TextAlign.center,
                  style: TextStyles.regular16,
                ),
                _sizedBoxHeight30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OtpInput(_fieldOne, true),
                    OtpInput(_fieldTwo, false),
                    OtpInput(_fieldThree, false),
                    OtpInput(_fieldFour, false)
                  ],
                ),
                _sizedBoxHeight30,
                _sizedBoxHeight30,
                CommonButton(
                  width: 130,
                  height: 40,
                  buttonTitle: l10n.verify,
                  onTap: () {},
                ),
                _sizedBoxHeight10,
                _sizedBoxHeight10,
              ],
            ),
          ),
        );
      },
    );
  }
}
