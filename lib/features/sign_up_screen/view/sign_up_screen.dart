import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/exports.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:bongobondhu_app/features/sign_up_screen/view/widgets/exports.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ThemeManagerViewModel>(
        builder: (context, themeVm, _) {
          return Scaffold(
            backgroundColor: themeVm.isDark ? darkScaffoldColor : kPrimaryColor,
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    final l10n = Localize().l10n;
    const _sizedBoxHeight10 = SizedBox(
      height: 10,
    );
    const _sizedBoxHeight40 = SizedBox(
      height: 40,
    );
    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, _) {
        return Padding(
          padding: commonScaffoldPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _sizedBoxHeight40,
                TextWidget(
                  l10n.signUp,
                  style: TextStyles.regular18,
                ),
                _sizedBoxHeight40,
                SignUpFormWidget(),
                const SizedBox(
                  height: 30,
                ),
                _sizedBoxHeight10,
              ],
            ),
          ),
        );
      },
    );
  }
}
