import 'dart:async';

import 'package:cdli_tablet/home_screen_event.dart';

class HomeScreenBloc {
  bool isLoading = true;
  bool didFail = false;

  bool _updateState = false;

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

  _fetchArtifacts() async {}

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
