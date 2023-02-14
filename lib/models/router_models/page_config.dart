/*
* Created by Shrikunj Patel on 1/12/2023.
*/

import 'dart:async';

class PageConfiguration<T> {
  final String key;
  final String path;
  final Object? arguments;
  late final Completer<T?> popped;

  PageConfiguration({
    required this.key,
    required this.path,
    this.arguments,
  }) {
    this.popped = Completer<T?>();
  }
//end of file
}
