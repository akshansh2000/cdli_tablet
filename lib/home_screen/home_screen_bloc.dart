import 'dart:async';
import 'dart:convert';

import 'package:cdli_tablet/home_screen/home_screen_event.dart';

import 'package:http/http.dart';

class HomeScreenBloc {
  bool isLoading = true;
  bool didFail = false;

  List<dynamic> fetchedData = List<Map<String, String>>();

  StreamController<bool> _stateController = StreamController<bool>();
  StreamSink<bool> get _intermediate => _stateController.sink;
  Stream<bool> get output => _stateController.stream;

  StreamController<HomeScreenEvent> _eventController =
      StreamController<HomeScreenEvent>();
  StreamSink<HomeScreenEvent> get input => _eventController.sink;

  HomeScreenBloc() {
    _mapEventToState(HomeScreenEvent event) {
      if (event is FetchArtifacts) {
        _fetchArtifacts();
      }
    }

    _eventController.stream.listen(_mapEventToState);
  }

  _fetchArtifacts() async {
    final apiUri = "https://cdli.ucla.edu/cdlitablet_android/fetchdata";
    final response = await get(apiUri);

    isLoading = false;

    if (response.statusCode != 200)
      didFail = true;
    else
      fetchedData = JsonDecoder().convert(response.body);

    _intermediate.add(isLoading);
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
