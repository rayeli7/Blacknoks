import 'dart:convert';

import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'api(s)/fetch_api.dart';

class LiveProvider extends ChangeNotifier {
  List<LiveStockData> livestockdata = <LiveStockData>[];
  bool isLoading = false;

  void getLiveStockData() {
    isLoading = true;
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
        }}
        isLoading = false;
        notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      notifyListeners();
      print("===onError $onError");
    });
  }
}
