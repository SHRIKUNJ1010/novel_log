/*
* Created by Shrikunj Patel on 4/10/2023.
*/

import 'dart:async';

class CommonStreamController {
  final StreamController<int> _selectionController = StreamController<int>.broadcast();

  StreamSink<int> get selectionSink => _selectionController.sink;

  Stream<int> get selectionStream => _selectionController.stream;

  CommonStreamController();

  // dispose the listener to eliminate memory leak
  dispose() {
    _selectionController.close();
  }
}
