class LiveStockData {
  double? change;
  String? name;
  double? price;
  int? volume;

  LiveStockData(this.change, this.name, this.price, this.volume);

  LiveStockData.fromJson(Map json)
      : change = json['change'],
        name = json['name'],
        price = json['price'],
        volume = json['volume'];

  Map toJson() {
    return {'change': change, 'name': name, 'price': price, 'volume': price};
  }
}
