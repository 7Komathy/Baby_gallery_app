// lib/providers/app_state.dart

import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  String _fetchedData = 'No data yet';

  String get fetchedData => _fetchedData;

  void setFetchedData(String data) {
    _fetchedData = data;
    notifyListeners();
  }
}
