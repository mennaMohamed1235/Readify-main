import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/core/utils/Localization/app_localization.dart';

extension TranslationExtension on BuildContext {
  String translate(String key) => AppLocalizations.of(this)!.translate(key)!;
}
