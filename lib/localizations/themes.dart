
import 'package:flutter/material.dart';

class StarterTheme {
  static get theme {
    final originalTextTheme = new ThemeData.dark().textTheme;
    final originalBody1 = originalTextTheme.body1;

    return new ThemeData.dark().copyWith(
        primaryColor: Colors.grey[800],
        accentColor: Colors.cyan[300],
        buttonColor: Colors.grey[800],
        textSelectionColor: Colors.cyan[100],
        backgroundColor: Colors.grey[800],
        textTheme: originalTextTheme.copyWith(
            body1:
            originalBody1.copyWith(decorationColor: Colors.transparent)));
  }
}
// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.



//class StarterTheme {
//  const StarterTheme._(this.name, this.data);
//
//  final String name;
//  final ThemeData data;
//}
//
//final StarterTheme kDarkStarterTheme = new StarterTheme._('Dark', _buildDarkTheme());
//final StarterTheme kLightStarterTheme = new StarterTheme._('Light', _buildLightTheme());
//
//TextTheme _buildTextTheme(TextTheme base) {
//  return base.copyWith(
//    title: base.title.copyWith(
//      fontFamily: 'GoogleSans',
//    ),
//  );
//}
//
//ThemeData _buildDarkTheme() {
//  const Color primaryColor = const Color(0xFF0175c2);
//  final ThemeData base = new ThemeData.dark();
//  return base.copyWith(
//    primaryColor: primaryColor,
//    buttonColor: primaryColor,
//    indicatorColor: Colors.white,
//    accentColor: const Color(0xFF13B9FD),
//    canvasColor: const Color(0xFF202124),
//    scaffoldBackgroundColor: const Color(0xFF202124),
//    backgroundColor: const Color(0xFF202124),
//    errorColor: const Color(0xFFB00020),
//    buttonTheme: const ButtonThemeData(
//      textTheme: ButtonTextTheme.primary,
//    ),
//    textTheme: _buildTextTheme(base.textTheme),
//    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
//    accentTextTheme: _buildTextTheme(base.accentTextTheme),
//  );
//}
//
//ThemeData _buildLightTheme() {
//  const Color primaryColor = const Color(0xFF0175c2);
//  final ThemeData base = new ThemeData.light();
//  return base.copyWith(
//    primaryColor: primaryColor,
//    buttonColor: primaryColor,
//    indicatorColor: Colors.white,
//    splashColor: Colors.white24,
//    splashFactory: InkRipple.splashFactory,
//    accentColor: const Color(0xFF13B9FD),
//    canvasColor: Colors.white,
//    scaffoldBackgroundColor: Colors.white,
//    backgroundColor: Colors.white,
//    errorColor: const Color(0xFFB00020),
//    buttonTheme: const ButtonThemeData(
//      textTheme: ButtonTextTheme.primary,
//    ),
//    textTheme: _buildTextTheme(base.textTheme),
//    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
//    accentTextTheme: _buildTextTheme(base.accentTextTheme),
//  );
//}
