import 'package:bongobondhu_app/core/theme/colors.dart';
import 'package:bongobondhu_app/core/theme/styles.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/features/bookmark/view/bookmark_page.dart';
import 'package:bongobondhu_app/features/login_screen/view_model/login_view_model.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class SideBarPage extends StatefulWidget {
  const SideBarPage({super.key});

  @override
  State<SideBarPage> createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {
  @override
  Widget build(BuildContext context) {
    final themeVm = ThemeManagerViewModel.watch(context);
    final isDark = themeVm.themeType == ThemeType.Dark || false;

    return Scaffold(
      backgroundColor: isDark ? darkScaffoldColor : kPrimaryColor,
      appBar: _appBar(),
      body: _body(),
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
    );
  }

  Widget _body() {
    final l10n = Localize.translate();
    return Padding(
      padding: const EdgeInsets.all(51),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       l10n.inceptionTextKey,
          //       style: TextStyles.regular16.copyWith(
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 21,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       l10n.contentsTextKey,
          //       style: TextStyles.regular16.copyWith(
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ],
          // ),
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
                    BotToast.showText(text: 'Login required');
                  }
                },
                child: Text(
                  'Bookmark',
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
              Text(
                'About US',
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
                'Privacy Policy',
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
