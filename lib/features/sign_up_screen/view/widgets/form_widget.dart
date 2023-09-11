import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/styles.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/padding.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/core/utils/validator.dart';
import 'package:bongobondhu_app/core/widgets/common_text_field.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:bongobondhu_app/features/sign_up_screen/view/widgets/exports.dart';
import 'package:bongobondhu_app/features/sign_up_screen/view_model/signup_view_model.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpFormWidget extends StatefulWidget {
  SignUpFormWidget({Key? key}) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  @override
  void initState() {
    final _signupVm = SignupViewModel.read(context);
    _signupVm.emailController.clear();
    _signupVm.passwordController.clear();
    _signupVm.userNameController.clear();
    _signupVm.confirmPasswordController.clear();
    _signupVm.firstNameController.clear();
    _signupVm.lastNameController.clear();
    _signupVm.isSignup = false;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const _sizedBoxHeight10 = SizedBox(
      height: 10,
    );
    const _sizedBoxHeight20 = SizedBox(
      height: 20,
    );
    const _sizedBoxHeight30 = SizedBox(
      height: 30,
    );
    final l10n = Localize().l10n;

    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, _) {
        return Consumer<SignupViewModel>(
          builder: (context, signupVm, _) {
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
                child: Form(
                  key: _formKey,
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
                      _nameWidget(),
                      _sizedBoxHeight20,
                      CommonTextField(
                        labelText: Localize().l10n.email,
                        controller: signupVm.emailController,
                        validator: Validator().nullFieldValidate,
                        isRequired: true,
                      ),
                      _sizedBoxHeight20,
                      CommonTextField(
                        labelText: Localize().l10n.userName,
                        controller: signupVm.userNameController,
                        validator: Validator().nullFieldValidate,
                        isRequired: true,
                      ),
                      _sizedBoxHeight20,
                      _passwordWidget(),
                      _sizedBoxHeight30,
                      _sizedBoxHeight30,
                      _signUpButton(),
                      _sizedBoxHeight10,
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _nameWidget() {
    return Consumer<SignupViewModel>(
      builder: (context, signupVm, _) {
        return NameWidget(
          firstNameController: signupVm.firstNameController,
          lastNameController: signupVm.lastNameController,
        );
      },
    );
  }

  Widget _signUpButton() {
    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, _) {
        return Consumer<SignupViewModel>(
          builder: (context, signupVm, _) {
            return CommonButton(
              buttonColor: themeVm.isDark ? kDarkPrimaryColor : kPrimaryColor,
              width: 130,
              height: 40,
              buttonTitle: Localize().l10n.signUp,
              onTap: () async {
                FocusManager.instance.primaryFocus!.unfocus();
                if (_formKey.currentState!.validate()) {
                  if (signupVm.passwordController.text ==
                      signupVm.confirmPasswordController.text) {
                    final body = {
                      'username': signupVm.userNameController.text,
                      'email': signupVm.emailController.text,
                      'password': signupVm.passwordController.text,
                      'first_name': signupVm.firstNameController.text,
                      'last_name': signupVm.lastNameController.text,
                    };
                    await signupVm.getSignUp(body).then((value) {
                      if (signupVm.isSignup) {
                        Navigator.pop(context);
                        BotToast.showText(text: 'Signup Successful!');
                      }
                    });
                  } else {
                    BotToast.showText(text: 'Password does not match');
                  }
                }
              },
            );
          },
        );
      },
    );
  }

  Widget _phoneField() {
    return CommonTextField(
      labelText: Localize().l10n.phone,
    );
  }

  Widget _dateOfBirth() {
    return const DateOfBirth();
  }

  Widget _countryField() {
    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, _) {
        return CommonTextField(
          readOnly: true,
          labelText: Localize().l10n.country,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color:
                themeVm.themeType == ThemeType.Dark ? primaryWhite : blackColor,
          ),
        );
      },
    );
  }

  Widget _passwordWidget() {
    return Consumer<SignupViewModel>(
      builder: (context, signupVm, _) {
        return PasswordWidget(
          passwordController: signupVm.passwordController,
          confirmPasswordController: signupVm.confirmPasswordController,
        );
      },
    );
  }

  Widget _genderField() {
    return Consumer<ThemeManagerViewModel>(
      builder: (context, themeVm, _) {
        return CommonTextField(
          readOnly: true,
          labelText: Localize().l10n.gender,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color:
                themeVm.themeType == ThemeType.Dark ? primaryWhite : blackColor,
          ),
        );
      },
    );
  }
}
