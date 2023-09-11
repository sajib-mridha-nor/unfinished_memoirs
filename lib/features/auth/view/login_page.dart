import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/exports.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final themeVm = ThemeManagerViewModel.watch(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeVm.isDark ? darkScaffoldColor : kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyles.regular12
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 59,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 31),
                decoration: BoxDecoration(
                  color: themeVm.isDark
                      ? kDarkPrimaryColor
                      : const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(49),
                ),
                height: 424,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 26,
                    top: 39,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyles.regular16
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Sign Up to get started and enjoy\nnew experience.',
                        style: TextStyles.regular12
                            .copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 38,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email/Phone',
                            style: TextStyles.regular16.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          const TextField(),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyles.regular16.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          const TextField(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size?>(
                            const Size(132, 27),
                          ),
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyles.regular16.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Forget Password?',
                        style: TextStyles.regular16.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 31),
                decoration: BoxDecoration(
                  color: themeVm.isDark
                      ? kDarkPrimaryColor
                      : const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 41,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      facebookIconPath,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Sign in with Facebook',
                      style: TextStyles.regular16
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 31),
                decoration: BoxDecoration(
                  color: themeVm.isDark
                      ? kDarkPrimaryColor
                      : const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 41,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      gmailIconPath,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Sign in with Google',
                      style: TextStyles.regular16
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  Text('Sign Up', style: TextStyle(color: Color(0xffA30000))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
