import 'dart:io';
import 'package:flutter/foundation.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool isConnected = true;

  Future<void> checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('dev.kwayisi.org');
      if (response.isNotEmpty) {
        isConnected = true;
        notifyListeners();
      }
    } on SocketException catch (err) {
      isConnected = false;
      notifyListeners();
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
