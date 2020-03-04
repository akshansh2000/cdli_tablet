import 'package:flutter/material.dart';

import 'package:cdli_tablet/home_screen/home_screen_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.bloc, {Key key}) : super(key: key);

  final HomeScreenBloc bloc;

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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        initialData: true,
        stream: widget.bloc.output,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return !snapshot.hasData
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : snapshot.data
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )
                  : PageView();
        },
      ),
    );
  }
}
