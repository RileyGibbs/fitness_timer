import 'package:flutter/material.dart';

double get standardPadding => 16.0;

Color get backgroundColor => const Color(0x131313FF);

ThemeData get echofiTheme => ThemeData(
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: backgroundColor,
  backgroundColor: backgroundColor,
);