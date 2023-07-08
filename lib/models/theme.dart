import 'package:flutter/material.dart';

class CustomThemeData {
  CustomThemeData(
      {required this.uiColors,
      required this.bgColors,
      required this.textColors,
      required this.tintColors,
      required this.buttonColors,
      required this.cardColors,
      required this.drawerColors,
      required this.commonColors});

  final UiColors uiColors;
  final BgColors bgColors;
  final TextColors textColors;
  final TintColors tintColors;
  final ButtonColors buttonColors;
  final CardColors cardColors;
  final DrawerColors drawerColors;
  final CommonColors commonColors;
}

class UiColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color quaternary;
  final Color disabled;

  UiColors(
      {required this.primary,
      required this.secondary,
      required this.tertiary,
      required this.quaternary,
      required this.disabled});
}

class BgColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color quaternary;

  BgColors(
      {required this.primary,
      required this.secondary,
      required this.tertiary,
      required this.quaternary});
}

class TextColors {
  final Color primary;
  final Color secondary;
  final Color label;
  final Color inverse;
  final Color dark;

  TextColors(
      {required this.primary,
      required this.secondary,
      required this.label,
      required this.inverse,
      required this.dark});
}

class TintColors {
  final Color primary;

  TintColors({required this.primary});
}

class ButtonColors {
  final Color primary;

  ButtonColors({required this.primary});
}

class CardColors {
  final Color card;

  CardColors({required this.card});
}

class DrawerColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color quaternary;
  final Color disabled;
  final Color selected;
  final Color selectedText;

  DrawerColors(
      {required this.primary,
      required this.secondary,
      required this.tertiary,
      required this.quaternary,
      required this.disabled,
      required this.selected,
      required this.selectedText});
}

class CommonColors {
  CommonColors(
      {required this.primary, required this.error, required this.success});

  final Color primary;
  final Color error;
  final Color success;
}
