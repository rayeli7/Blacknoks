import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';



Future<LiveStockData> fetchLiveData() async {
  final response = await http
      .get(Uri.parse('https://dev.kwayisi.org/apis/gse/live/MTNGH'),);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return LiveStockData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class LiveStockData {
  final double change;
  final String name;
  final double price ;
  final int volume;

 LiveStockData({
    required this.change,
    required this.name,
    required this.price,
    required this.volume,
  });

  factory LiveStockData.fromJson(Map<String, dynamic> json) {
    return LiveStockData(
      change: json['change'],
      name: json['name'],
      price: json['price'],
      volume: json['volume'],
    );
  }
}
