import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Localize {
  static AppLocalizations translate() {
    final context = appNavigator.context!;
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

extension AppLocalizationsX on Localize {
  AppLocalizations get l10n => Localize.translate();
}
