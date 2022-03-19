import 'dart:convert';
import 'dart:io';

import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'api(s)/fetch_api.dart';

class LiveProvider extends ChangeNotifier {
  List<LiveStockData> livestockdata = <LiveStockData>[];
  bool isLoading = false;
  bool isConnected = true;

  void getLiveStockData() {
    isLoading = true;
    isConnected = true;
    API.getLiveStockData().then((value) {
      Iterable list = json.decode(value.body);
      livestockdata =
          list.map((model) => LiveStockData.fromJson(model)).toList();
      for (final element in livestockdata) {
        if (companyInfoList.length < livestockdata.length) {
          getStockInfo(element.name).then((value) {
            companyInfoList.add(value);
            companyInfoList.sort((a, b) => a.name.compareTo(b.name));
            print(companyInfoList.length);
          });
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      if (onError.runtimeType == SocketException) {
        isConnected = false;
        notifyListeners();
      }
      isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print("Livedata_provider error ${onError.runtimeType}");
      }
    });
  }
}
