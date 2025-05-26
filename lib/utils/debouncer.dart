import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int millisecond;

  VoidCallback? action;
  Timer? _timer;
  Debouncer({this.millisecond = 500});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(Duration(milliseconds: millisecond), action);
  }
}
