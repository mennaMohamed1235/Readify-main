import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences sharedPreferences;
  ThemeCubit(
    this.sharedPreferences,
  ) : super(ThemeInitial());
  Locale locale = const Locale('en');
  Future<void> getCurrentLocale() async {
    emit(ThemeLoadingState());
    if (sharedPreferences.containsKey("locale")) {
      locale = Locale(sharedPreferences.getString('locale')!);
    } else {
      final String devicelocale = Platform.localeName;
      if (devicelocale.contains("ar")) {
        locale = const Locale('ar');
      } else {
        locale = const Locale("en");
      }
    }
    emit(LangChangedState());
  }

  Future<void> changeLocale(Locale lc) async {
    emit(ThemeLoadingState());
    locale = lc;

    await sharedPreferences.setString("locale", lc.languageCode);
    emit(LangChangedState());
  }
}
