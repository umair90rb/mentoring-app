import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'size_config.dart';

class AppTheme {
  static const Color appBackgroundColor = Color(0xFFFFF7EC);
  static const Color topBarBackgroundColor = Color(0xFFFFD974);
  static const Color selectedTabBackgroundColor = Color(0xFFFFC442);
  static const Color primary = Color(0xFF1A385C);
  static const Color secondary = Color(0xFF1A385C);
  static const Color danger = Color(0xFFE02020);
  static const Color success = Color(0xFF6DD400);
  static const Color warning = Color(0xFFF7B500);
  static const Color info = Color(0xFF0095FF);
  static const Color headlineTextColor = Color(0xFF1A385C);
  static Color subTitleTextColor = Color(0xFF1A385C).withOpacity(0.4);
  static const Color bg = Color(0xFF222338);
  static const Color secondaryBg = Color(0xFFF5F8FD);
  static const Color shadow = Color(0xFFEDF1F7);
  static const Color borderCard = Color(0xFFEBF0F9);
  static const Color fb = Color(0xFF0041A8);
  static const Color twitter = Color(0xFF42AAFF);
  static const Color google = Color(0xFFF2F8FF);
  static const Color gradient1 = Color(0xFFF1A3A77);
  static const Color gradient2 = Color(0xFFF1A3A77);
  static Color gradient1_disabled = Color(0xFF1A3A77);
  static Color gradient2_disabled = Color(0xFF1A3A77);

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.bg,
    backgroundColor: AppTheme.bg,
    brightness: Brightness.dark,
    textTheme: darkTextTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final TextTheme darkTextTheme = TextTheme(
    headline1: _headline1,
    headline2: _headline2,
    headline3: _headline3,
    headline4: _headline4,
    button: _button,
    subtitle1: _subtitle1,
    subtitle2: _subtitle2,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
  );

  static final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme.bg,
      statusBarColor: AppTheme.secondary);

  static final TextStyle _headline1 = TextStyle(
    color: Color(0xFF1A385C),
    fontWeight: FontWeight.w900,
    fontFamily: "Raleway",
    fontSize: 3.5 * SizeConfig.textMultiplier,
  );
  static final TextStyle _headline2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: "Raleway",
    color: Color(0xFF1A385C),
    fontSize: 3.0 * SizeConfig.textMultiplier,
  );
  static final TextStyle _headline3 = TextStyle(
    color: Color(0xFF1A385C),
    fontWeight: FontWeight.w500,
    fontFamily: "Raleway",
    fontSize: 2.5 * SizeConfig.textMultiplier,
  );
  static final TextStyle _headline4 = TextStyle(
    color: Color(0xFF1A385C),
    fontWeight: FontWeight.w500,
    fontFamily: "Raleway",
    fontSize: 2.0 * SizeConfig.textMultiplier,
  );

  static final TextStyle _button = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontFamily: "Raleway",
    fontSize: 2.0 * SizeConfig.textMultiplier,
  );

  static final TextStyle _subtitle1 = TextStyle(
    color: Color(0xFF1A385C),
    fontFamily: "Raleway",
    letterSpacing: 1.5,
    height: 1,
    fontSize: 2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _subtitle2 = TextStyle(
    color: Color(0xFF1A385C),
    fontFamily: "Raleway",
    letterSpacing: 1.5,
    height: 1.8,
    fontSize: 1.6 * SizeConfig.textMultiplier,
  );

  static final TextStyle _bodyText1 = TextStyle(
    color: Color(0xFF1A385C),
    fontFamily: "Raleway",
    fontSize: 2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _bodyText2 = TextStyle(
    color: Color(0xFF1A385C),
    fontFamily: "Raleway",
    fontSize: 2 * SizeConfig.textMultiplier,
  );
}
