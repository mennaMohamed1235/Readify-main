import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: false,
  listTileTheme: const ListTileThemeData(
    iconColor: AppColors.primaryColor,
  ), 
  scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.primaryColor,
      elevation: 0.8,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor,
      )),
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor, elevation: 0)),
);
