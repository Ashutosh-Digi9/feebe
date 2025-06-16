// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterFlowTheme {
  static const double minTextScaleFactor = 1.0;
  static const double maxTextScaleFactor = 1.0;

  static FlutterFlowTheme of(BuildContext context) {
    return LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color tertiaryText;
  late Color lightBg;
  late Color checkBg;
  late Color buttonBg;
  late Color lightblue;
  late Color newBgcolor;
  late Color dIsable;
  late Color text;
  late Color text1;
  late Color snackbar;
  late Color buttonShadow;
  late Color buttonShadow2;
  late Color bgColor1;
  late Color bgColorNewOne;
  late Color textfieldText;
  late Color secondaryBorder;
  late Color disabletext;
  late Color event;
  late Color birthdayfill;
  late Color homework;
  late Color holiday;
  late Color homeworkborder;
  late Color reminderborder;
  late Color generalBorder;
  late Color eventborder;
  late Color holidayborder;
  late Color birthdayborder;
  late Color reminderfill;
  late Color eventtext;
  late Color holidaytext;
  late Color birthdaytext;
  late Color notificationfill;
  late Color notificationBorder;
  late Color textfieldDisable;
  late Color stroke;
  late Color text2;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  bool get displayLargeIsCustom => typography.displayLargeIsCustom;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  bool get displayMediumIsCustom => typography.displayMediumIsCustom;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  bool get displaySmallIsCustom => typography.displaySmallIsCustom;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  bool get headlineLargeIsCustom => typography.headlineLargeIsCustom;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  bool get headlineMediumIsCustom => typography.headlineMediumIsCustom;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  bool get headlineSmallIsCustom => typography.headlineSmallIsCustom;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  bool get titleLargeIsCustom => typography.titleLargeIsCustom;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  bool get titleMediumIsCustom => typography.titleMediumIsCustom;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  bool get titleSmallIsCustom => typography.titleSmallIsCustom;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  bool get labelLargeIsCustom => typography.labelLargeIsCustom;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  bool get labelMediumIsCustom => typography.labelMediumIsCustom;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  bool get labelSmallIsCustom => typography.labelSmallIsCustom;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  bool get bodyLargeIsCustom => typography.bodyLargeIsCustom;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  bool get bodyMediumIsCustom => typography.bodyMediumIsCustom;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  bool get bodySmallIsCustom => typography.bodySmallIsCustom;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF1D61E7);
  late Color secondary = const Color(0xFFFFFFFF);
  late Color tertiary = const Color(0xFFFAFAFA);
  late Color alternate = const Color(0xFFA0A0A0);
  late Color primaryText = const Color(0xFF001B36);
  late Color secondaryText = const Color(0xFFFFFFFF);
  late Color primaryBackground = const Color(0xFF1D61E7);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0xFFFFFCF0);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF249689);
  late Color warning = const Color(0xFFF9CF58);
  late Color error = const Color(0xFFFF3B30);
  late Color info = const Color(0xFFFFFFFF);

  late Color tertiaryText = const Color(0xFF666666);
  late Color lightBg = const Color(0xFFF9DDFE);
  late Color checkBg = const Color(0xFF99D63C);
  late Color buttonBg = const Color(0xFF1D61E7);
  late Color lightblue = const Color(0xFFE4EDFC);
  late Color newBgcolor = const Color(0xFFFAFAFA);
  late Color dIsable = const Color(0xFFC7C7C7);
  late Color text = const Color(0xFFACB5BB);
  late Color text1 = const Color(0xFF000000);
  late Color snackbar = const Color(0xFF505050);
  late Color buttonShadow = const Color(0x79253EA7);
  late Color buttonShadow2 = const Color(0xFF375DFB);
  late Color bgColor1 = const Color(0xFFCCCCCC);
  late Color bgColorNewOne = const Color(0xFFFAFAFA);
  late Color textfieldText = const Color(0xFF747373);
  late Color secondaryBorder = const Color(0xFFEFF0F6);
  late Color disabletext = const Color(0xFFFFFFFF);
  late Color event = const Color(0xFFFFFCF0);
  late Color birthdayfill = const Color(0xFFFBF0FF);
  late Color homework = const Color(0xFFFFFCF0);
  late Color holiday = const Color(0xFFF0FCFF);
  late Color homeworkborder = const Color(0xFFB0FF6A);
  late Color reminderborder = const Color(0xFFADA6EB);
  late Color generalBorder = const Color(0xFFFF976A);
  late Color eventborder = const Color(0xFFFFE26A);
  late Color holidayborder = const Color(0xFF7DD7FE);
  late Color birthdayborder = const Color(0xFFADA6EB);
  late Color reminderfill = const Color(0xFFFBF0FF);
  late Color eventtext = const Color(0xFFC29800);
  late Color holidaytext = const Color(0xFF072F78);
  late Color birthdaytext = const Color(0xFF4E0B6B);
  late Color notificationfill = const Color(0xFFD9E4F8);
  late Color notificationBorder = const Color(0xFF1D61E7);
  late Color textfieldDisable = const Color(0xFF979797);
  late Color stroke = const Color(0xFFEDF1F3);
  late Color text2 = const Color(0xDE000000);
}

abstract class Typography {
  String get displayLargeFamily;
  bool get displayLargeIsCustom;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  bool get displayMediumIsCustom;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  bool get displaySmallIsCustom;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  bool get headlineLargeIsCustom;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  bool get headlineMediumIsCustom;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  bool get headlineSmallIsCustom;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  bool get titleLargeIsCustom;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  bool get titleMediumIsCustom;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  bool get titleSmallIsCustom;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  bool get labelLargeIsCustom;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  bool get labelMediumIsCustom;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  bool get labelSmallIsCustom;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  bool get bodyLargeIsCustom;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  bool get bodyMediumIsCustom;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  bool get bodySmallIsCustom;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Nunito';
  bool get displayLargeIsCustom => false;
  TextStyle get displayLarge => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 64.0,
      );
  String get displayMediumFamily => 'Nunito';
  bool get displayMediumIsCustom => false;
  TextStyle get displayMedium => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 44.0,
      );
  String get displaySmallFamily => 'Nunito';
  bool get displaySmallIsCustom => false;
  TextStyle get displaySmall => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      );
  String get headlineLargeFamily => 'Nunito';
  bool get headlineLargeIsCustom => false;
  TextStyle get headlineLarge => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Nunito';
  bool get headlineMediumIsCustom => false;
  TextStyle get headlineMedium => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 28.0,
      );
  String get headlineSmallFamily => 'Nunito';
  bool get headlineSmallIsCustom => false;
  TextStyle get headlineSmall => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      );
  String get titleLargeFamily => 'Nunito';
  bool get titleLargeIsCustom => false;
  TextStyle get titleLarge => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      );
  String get titleMediumFamily => 'Nunito';
  bool get titleMediumIsCustom => false;
  TextStyle get titleMedium => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Nunito';
  bool get titleSmallIsCustom => false;
  TextStyle get titleSmall => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Nunito';
  bool get labelLargeIsCustom => false;
  TextStyle get labelLarge => GoogleFonts.nunito(
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get labelMediumFamily => 'Nunito';
  bool get labelMediumIsCustom => false;
  TextStyle get labelMedium => GoogleFonts.nunito(
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get labelSmallFamily => 'Nunito';
  bool get labelSmallIsCustom => false;
  TextStyle get labelSmall => GoogleFonts.nunito(
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get bodyLargeFamily => 'Nunito';
  bool get bodyLargeIsCustom => false;
  TextStyle get bodyLarge => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Nunito';
  bool get bodyMediumIsCustom => false;
  TextStyle get bodyMedium => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Nunito';
  bool get bodySmallIsCustom => false;
  TextStyle get bodySmall => GoogleFonts.nunito(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
    String? package,
  }) {
    if (useGoogleFonts && fontFamily != null) {
      font = GoogleFonts.getFont(fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle);
    }

    return font != null
        ? font.copyWith(
            color: color ?? this.color,
            fontSize: fontSize ?? this.fontSize,
            letterSpacing: letterSpacing ?? this.letterSpacing,
            fontWeight: fontWeight ?? this.fontWeight,
            fontStyle: fontStyle ?? this.fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          )
        : copyWith(
            fontFamily: fontFamily,
            package: package,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          );
  }
}
