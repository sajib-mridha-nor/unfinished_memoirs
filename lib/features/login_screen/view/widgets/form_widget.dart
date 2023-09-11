import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/styles.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/utils/padding.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/core/utils/validator.dart';
import 'package:bongobondhu_app/core/widgets/common_text_field.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:bongobondhu_app/features/login_screen/view_model/login_view_model.dart';
import 'package:bongobondhu_app/features/splash/view/splash_page.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  void initState() {
    final _loginVm = LoginViewModel.read(context);
    _loginVm.emailController.clear();
    _loginVm.passwordController.clear();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
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
            child: Consumer<LoginViewModel>(builder: (context, loginVm, _) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    _sizedBoxHeight10,
                    _sizedBoxHeight10,
                    TextWidget(l10n.welcome, style: TextStyles.regular18),
                    _sizedBoxHeight10,
                    TextWidget(l10n.signUpToGetStarted,
                        textAlign: TextAlign.center,
                        style: TextStyles.regular16),
                    _sizedBoxHeight30,
                    CommonTextField(
                      labelText: l10n.emailPhone,
                      controller: loginVm.emailController,
                      validator: Validator().nullFieldValidate,
                    ),
                    _sizedBoxHeight30,
                    CommonTextField(
                      labelText: l10n.password,
                      controller: loginVm.passwordController,
                      validator: Validator().nullFieldValidate,
                    ),
                    _sizedBoxHeight30,
                    CommonButton(
                      buttonColor:
                          themeVm.isDark ? kDarkPrimaryColor : kPrimaryColor,
                      width: 130,
                      height: 40,
                      buttonTitle: l10n.login,
                      onTap: _onTapSignIn,
                    ),
                    _sizedBoxHeight30,
                    TextWidget(l10n.forgetPassword),
                    _sizedBoxHeight10,
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Future<void> _onTapSignIn() async {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formKey.currentState!.validate()) {
      final _signVm = LoginViewModel.read(context);
      final body = {
        'email': _signVm.emailController.text,
        'password': _signVm.passwordController.text,
      };
      await _signVm.getLogin(body);
      if (await _signVm.isLoggedIn()) {
        await AppNavigator.pushAndRemoveUntil(const SplashPage());
      }
    }
  }
}
