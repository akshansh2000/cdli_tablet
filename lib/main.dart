import 'package:flutter/material.dart';

import 'package:cdli_tablet/home_screen/home_screen.dart';
import 'package:cdli_tablet/home_screen/home_screen_bloc.dart';
import 'package:cdli_tablet/home_screen/home_screen_event.dart';

void main() {
  final bloc = HomeScreenBloc();
  bloc.input.add(FetchArtifacts());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CDLI Tablet",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}
