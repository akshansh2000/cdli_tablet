import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CDLI Tablet"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
