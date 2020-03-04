import 'package:flutter/material.dart';

import 'package:cdli_tablet/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CDLI Tablet",
      home: HomeScreen(),
    );
  }
}
