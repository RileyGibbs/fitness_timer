import 'package:flutter/material.dart';

import 'timer.dart';
import 'styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echofi Trade Timer',
      theme: echofiTheme,
      home: Timer(title: 'Echofi Trade Timer'),
    );
  }
}
