import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/utils/auth_wrapper.dart';
import 'package:bongobondhu_app/core/utils/exports.dart';
import 'package:bongobondhu_app/core/utils/language.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/core/widgets/exports.dart';
import 'package:bongobondhu_app/features/bookmark/view/bookmark_page.dart';
import 'package:bongobondhu_app/features/language/view_model/language_view_model.dart';
import 'package:bongobondhu_app/features/login_screen/view/login_screen.dart';
import 'package:bongobondhu_app/features/login_screen/view_model/login_view_model.dart';
import 'package:bongobondhu_app/features/profile/view/profile_sreen.dart';
import 'package:bongobondhu_app/features/splash/view/splash_page.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? _accessVm = '';
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ThemeManagerViewModel.read(context).getTheme();
      _accessVm = await AccessTokenProvider().getToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeVm = ThemeManagerViewModel.watch(context);
    final isDark = themeVm.themeType == ThemeType.Dark || false;
    final l10n = Localize().l10n;
    return Scaffold(
      backgroundColor: isDark ? darkScaffoldColor : kPrimaryColor,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: (_accessVm != '' && _accessVm != null)
          ? Padding(
              padding: const EdgeInsets.all(40),
              child: CommonButton(
                buttonColor: themeVm.isDark
                    ? kDarkPrimaryColor
                    : const Color(0xff90A878),
                width: 130,
                height: 42,
                buttonTitle: 'Log Out',
                onTap: () async {
                  await AccessTokenProvider().setToken('');
                  _accessVm = await AccessTokenProvider().getToken();
                  await AppNavigator.pushAndRemoveUntil(const SplashPage());
                },
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(40),
              child: CommonButton(
                buttonColor: themeVm.isDark
                    ? kDarkPrimaryColor
                    : const Color(0xff90A878),
                width: 130,
                height: 42,
                buttonTitle: l10n.login,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ),
    );
  }

  PreferredSizeWidget _appBar() {
    final themeVm = ThemeManagerViewModel.watch(context);
    return AppBar(
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: themeVm.isDark ? primaryWhite : primaryBlack,
        ),
      ),
      actions: [
        Consumer<LanguageViewModel>(
          builder: (context, languageVm, child) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 12,
                bottom: 9,
              ),
              child: InkWell(
                onTap: () async {
                  await AppNavigator.pushAndRemoveUntil(const SplashPage());
                },
                child: Container(
                  height: 27.5,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xffa4a4a4),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        languageVm.languageType == LanguageType.English
                            ? 'assets/usa_flag.png'
                            : 'assets/bd_flag.png',
                        height: 10,
                        width: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        Localize().l10n.language,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _body() {
    final l10n = Localize().l10n;
    final themeVm = ThemeManagerViewModel.watch(context);
    return Padding(
      padding: const EdgeInsets.all(51),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  final _signVm = LoginViewModel.read(context);
                  if (await _signVm.isLoggedIn()) {
                    await AppNavigator.push(const ProfileScreen());
                  } else {
                    BotToast.showText(text: l10n.loginRequired);
                  }
                },
                child: Text(
                  l10n.profileTextKey,
                  style: TextStyles.regular16.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
            children: [
              InkWell(
                onTap: () async {
                  final _signVm = LoginViewModel.read(context);
                  if (await _signVm.isLoggedIn()) {
                    await AppNavigator.push(const BookmarkPage());
                  } else {
                    BotToast.showText(text: l10n.loginRequired);
                  }
                },
                child: Text(
                  l10n.bookmarkTextKey,
                  style: TextStyles.regular16.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       l10n.notificationsTextKey,
          //       style: TextStyles.regular16.copyWith(
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //     AnimatedToggleSwitch<bool>.dual(
          //       current: _positive,
          //       first: false,
          //       second: true,
          //       dif: 0,
          //       borderColor: Colors.transparent,
          //       height: 30,
          //       boxShadow: const [
          //         BoxShadow(
          //           color: Colors.black26,
          //           spreadRadius: 1,
          //           blurRadius: 1,
          //         ),
          //       ],
          //       onChanged: (b) {
          //         setState(() {
          //           _positive = b;
          //         });
          //         // return Future.delayed(Duration(seconds: 2));
          //       },
          //       colorBuilder: (b) => b ? Colors.green : Colors.red,
          //       indicatorSize: const Size(35, double.infinity),
          //       iconBuilder: (value) => value
          //           ? const Icon(
          //               Icons.notifications_on,
          //               color: Colors.white,
          //             )
          //           : const Icon(
          //               Icons.notifications_off,
          //               color: Colors.white,
          //             ),
          //       textBuilder: (value) => value
          //           ? Center(
          //               child: Text(
          //                 'On',
          //                 style: TextStyles.regular12.copyWith(fontSize: 10),
          //               ),
          //             )
          //           : Center(
          //               child: Text(
          //                 'Off',
          //                 style: TextStyles.regular12.copyWith(fontSize: 10),
          //               ),
          //             ),
          //     )
          //   ],
          // ),
          // const SizedBox(
          //   height: 21,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.darkMoodTextKey,
                style: TextStyles.regular16.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              AnimatedToggleSwitch<bool>.dual(
                current: themeVm.isDark,
                first: false,
                second: true,
                dif: 0,
                borderColor: Colors.transparent,
                borderWidth: 1.5,
                height: 30,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
                onChanged: (b) async {
                  themeVm.isDark = b;
                },
                colorBuilder: (b) {
                  return b ? Colors.black : Colors.yellow;
                },
                indicatorSize: const Size(35, double.infinity),
                iconBuilder: (value) {
                  return value
                      ? const Icon(
                          Icons.dark_mode,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.light_mode,
                          color: Colors.white,
                        );
                },
                textBuilder: (value) => value
                    ? Center(
                        child: Text(
                          'On',
                          style: TextStyles.regular12.copyWith(fontSize: 10),
                        ),
                      )
                    : Center(
                        child: Text(
                          'Off',
                          style: TextStyles.regular12.copyWith(fontSize: 10),
                        ),
                      ),
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
            children: [
              Text(
                l10n.privacySecurityTextKey,
                style: TextStyles.regular16.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
            children: [
              Text(
                'About US',
                style: TextStyles.regular16.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
