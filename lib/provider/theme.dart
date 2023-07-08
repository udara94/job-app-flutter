import 'package:flutter/material.dart';
import 'package:job_app/resources/colors.dart';
import 'package:job_app/services/shared_preference.dart';
import 'package:job_app/models/theme.dart';

class ThemeProvider extends ChangeNotifier {
  final darkTheme = CustomThemeData(
      uiColors: UiColors(
          primary: AppColors.purple,
          secondary: AppColors.white,
          tertiary: AppColors.ashWhite,
          quaternary: AppColors.black,
          disabled: AppColors.lightAsh2),
      bgColors: BgColors(
        primary: AppColors.black,
        secondary: AppColors.lightPurple,
        tertiary: AppColors.orangeCream,
        quaternary: AppColors.lightWhite,
      ),
      textColors: TextColors(
          primary: AppColors.white,
          secondary: AppColors.lightPurple,
          label: AppColors.grey,
          inverse: AppColors.white,
          dark: AppColors.black),
      tintColors: TintColors(primary: AppColors.white),
      buttonColors: ButtonColors(primary: AppColors.purple),
      cardColors: CardColors(card: AppColors.lightPurple),
      drawerColors: DrawerColors(
          primary: AppColors.darkGrey,
          secondary: AppColors.white,
          tertiary: AppColors.ashWhite,
          quaternary: AppColors.black,
          disabled: AppColors.grey,
          selected: AppColors.white,
          selectedText: AppColors.purple),
      commonColors: CommonColors(
          primary: AppColors.white,
          error: AppColors.red,
          success: AppColors.green));

  final lightTheme = CustomThemeData(
      uiColors: UiColors(
          primary: AppColors.purple,
          secondary: AppColors.lightPurple,
          tertiary: AppColors.ashWhite,
          quaternary: AppColors.black,
          disabled: AppColors.lightAsh2),
      bgColors: BgColors(
        primary: AppColors.white,
        secondary: AppColors.lightPurple,
        tertiary: AppColors.orangeCream,
        quaternary: AppColors.lightWhite,
      ),
      textColors: TextColors(
          primary: AppColors.purple,
          secondary: AppColors.lightPurple,
          label: AppColors.grey,
          inverse: AppColors.white,
          dark: AppColors.white),
      tintColors: TintColors(primary: AppColors.white),
      buttonColors: ButtonColors(primary: AppColors.purple),
      cardColors: CardColors(card: AppColors.lightWhite),
      drawerColors: DrawerColors(
          primary: AppColors.white,
          secondary: AppColors.black,
          tertiary: AppColors.ashWhite,
          quaternary: AppColors.black,
          disabled: AppColors.grey,
          selected: AppColors.purple,
          selectedText: AppColors.white),
      commonColors: CommonColors(
          primary: AppColors.white,
          error: AppColors.red,
          success: AppColors.green));

  CustomThemeData _customThemeData = CustomThemeData(
      uiColors: UiColors(
          primary: AppColors.purple,
          secondary: AppColors.lightPurple,
          tertiary: AppColors.ashWhite,
          quaternary: AppColors.black,
          disabled: AppColors.lightAsh2),
      bgColors: BgColors(
        primary: AppColors.white,
        secondary: AppColors.lightPurple,
        tertiary: AppColors.orangeCream,
        quaternary: AppColors.lightWhite,
      ),
      textColors: TextColors(
          primary: AppColors.purple,
          secondary: AppColors.lightPurple,
          label: AppColors.grey,
          inverse: AppColors.white,
          dark: AppColors.white),
      tintColors: TintColors(primary: AppColors.white),
      buttonColors: ButtonColors(primary: AppColors.purple),
      cardColors: CardColors(card: AppColors.lightWhite),
      drawerColors: DrawerColors(
          primary: AppColors.white,
          secondary: AppColors.black,
          tertiary: AppColors.ashWhite,
          quaternary: AppColors.black,
          disabled: AppColors.grey,
          selected: AppColors.purple,
          selectedText: AppColors.white),
      commonColors: CommonColors(
          primary: AppColors.white,
          error: AppColors.red,
          success: AppColors.green));

  CustomThemeData get customTheme => _customThemeData;

  ThemeProvider() {
    loadThemeData();
  }

  Future<void> loadThemeData() async {
    var theme = await SharedPreferenceService.readData('theme') ?? 'light';
    _customThemeData = theme == 'light' ? lightTheme : darkTheme;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    if (isDark) {
      _customThemeData = darkTheme;
    } else {
      _customThemeData = lightTheme;
    }
    SharedPreferenceService.saveData("theme", isDark ? "dark" : "light");
    notifyListeners();
  }
}
