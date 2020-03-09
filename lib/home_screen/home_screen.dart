import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:cdli_tablet/home_screen/home_screen_bloc.dart';
import 'package:cdli_tablet/home_screen/home_screen_event.dart';

import 'package:preload_page_view/preload_page_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.bloc, {Key key}) : super(key: key);

  final HomeScreenBloc bloc;
  bool upwards = true;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("CDLI Tablet"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => widget.bloc.input.add(FetchArtifacts()),
          ),
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
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
              : snapshot.data
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : widget.bloc.didFail
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "An error occurred. Please check your internet connection, and try again.",
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : PreloadPageView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          preloadPagesCount: 20,
                          children: widget.bloc.fetchedData
                              .map(
                                (element) => Image.network(
                                  element["url"],
                                  loadingBuilder: (context, child, progress) =>
                                      progress == null
                                          ? child
                                          : Center(
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                              ),
                                            ),
                                ),
                              )
                              .toList(),
                        );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Transform.rotate(
              angle: -math.pi / 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    widget.upwards
                        ? Icons.arrow_forward_ios
                        : Icons.arrow_back_ios,
                  ),
                  onPressed: () => setState(
                    () => widget.upwards = !widget.upwards,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                width: size.width,
                height: size.height / 5,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
