import 'package:bongobondhu_app/bongo_bondhu.dart';
import 'package:bongobondhu_app/core/theme/view_model/theme_manager_view_model.dart';
import 'package:bongobondhu_app/core/utils/auth_wrapper.dart';
import 'package:bongobondhu_app/core/utils/shared_preference_manager.dart';
import 'package:bongobondhu_app/features/bookmark/view_model/bookmark_view_model.dart';
import 'package:bongobondhu_app/features/home/view_model/audio_player_view_model.dart';
import 'package:bongobondhu_app/features/home/view_model/home_view_model.dart';
import 'package:bongobondhu_app/features/index/view_model/index_view_model.dart';
import 'package:bongobondhu_app/features/language/view_model/language_view_model.dart';
import 'package:bongobondhu_app/features/login_screen/view_model/login_view_model.dart';
import 'package:bongobondhu_app/features/profile/view_model/profile_view_model.dart';
import 'package:bongobondhu_app/features/sign_up_screen/view_model/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsManager().init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageViewModel(),
      child: ChangeNotifierProvider(
        create: (context) => AccessTokenProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final providers = [
      ChangeNotifierProvider<ThemeManagerViewModel>(
        create: (context) => ThemeManagerViewModel(),
      ),
      ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
      ),
      ChangeNotifierProvider<AudioPlayerViewModel>(
        create: (context) => AudioPlayerViewModel(),
      ),
      ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(),
      ),
      ChangeNotifierProvider<IndexViewModel>(
        create: (context) => IndexViewModel(),
      ),
      ChangeNotifierProvider<LanguageViewModel>(
        create: (context) => LanguageViewModel(),
      ),
      ChangeNotifierProvider<SignupViewModel>(
        create: (context) => SignupViewModel(),
      ),
      ChangeNotifierProvider<ProfileViewModel>(
        create: (context) => ProfileViewModel(),
      ),
      ChangeNotifierProvider<BookmarkViewModel>(
        create: (context) => BookmarkViewModel(),
      ),
    ];
    return AuthViewWrapper(
      child: MultiProvider(
        providers: providers,
        child: const BongoBondhu(),
      ),
    );
  }
}
