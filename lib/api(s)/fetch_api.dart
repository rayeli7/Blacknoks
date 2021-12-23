import 'package:http/http.dart' as http;
import 'dart:async';

const baseUrl = "https://dev.kwayisi.org/apis/gse/live";

class API {
  static Future getLiveStockData() {
    var url = baseUrl; //+ "/stockname";
    return http.get(Uri.parse(url));
  }
}

class LiveStockData {
  double? change;
  String? name;
  double? price;
  int? volume;

  LiveStockData(double change, String name, double price, int volume) {
    this.change = change;
    this.name = name;
    this.price = price;
    this.volume = volume;
  }

  LiveStockData.fromJson(Map json)
      : change = json['change'],
        name = json['name'],
        price = json['price'],
        volume = json['volume'];

  Map toJson() {
    return {'change': change, 'name': name, 'price': price, 'volume': price};
  }
}

