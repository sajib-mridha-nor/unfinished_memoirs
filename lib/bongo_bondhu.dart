import 'package:bongobondhu_app/core/theme/theme_constants.dart';
import 'package:bongobondhu_app/core/theme/theme_preferance.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/utils/language.dart';
import 'package:bongobondhu_app/core/utils/language_preference.dart';
import 'package:bongobondhu_app/core/utils/theme_type.dart';
import 'package:bongobondhu_app/features/language/view_model/language_view_model.dart';
import 'package:bongobondhu_app/features/splash/view/splash_page.dart';
import 'package:bongobondhu_app/l10n/l10n.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BongoBondhu extends StatefulWidget {
  const BongoBondhu({Key? key}) : super(key: key);

  @override
  State<BongoBondhu> createState() => _BongoBondhuState();
}

class _BongoBondhuState extends State<BongoBondhu> {
  ThemeManagerViewModel themeVm = ThemeManagerViewModel();
  LanguageViewModel languageViewModel = LanguageViewModel();

  @override
  void initState() {
    getCurrentLanguage();
    getCurrentAppTheme();

    super.initState();
  }

  Future<void> getCurrentAppTheme() async {
    await ThemePreference().getTheme().then(
          (value) => themeVm.toggleTheme(isDark: value),
        );
  }

  Future<void> getCurrentLanguage() async {
    await LanguagePreference().getLanguage().then((value) async {
      await languageViewModel.getLanguage();
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCurrentLanguage();
      getCurrentAppTheme();
    });
    return ChangeNotifierProvider(
      create: (context) {
        return languageViewModel;
      },
      child: Consumer<LanguageViewModel>(
        builder: (context, provider, child) {
          return ChangeNotifierProvider(
            create: (_) {
              return themeVm;
            },
            child: Consumer<ThemeManagerViewModel>(
              builder: (context, themeVm, child) {
                return MaterialApp(
                  key: Key('${themeVm.themeType}${provider.languageType}'),
                  debugShowCheckedModeBanner: false,
                  title: 'Bongobondhu App',
                  theme: themeVm.themeType == ThemeType.Dark
                      ? AppTheme.darkTheme
                      : AppTheme.lightTheme,
                  navigatorKey: appNavigator.navigatorKey,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: Locale(
                    provider.languageType == LanguageType.English ? 'en' : 'bn',
                  ),
                  builder: (context, child) {
                    final scale =
                        MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3);
                    child = BotToastInit()(context, child);

                    child = MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaleFactor: scale),
                      child: child,
                    );
                    return child;
                  },
                  navigatorObservers: [BotToastNavigatorObserver()],
                  home: const SplashPage(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
