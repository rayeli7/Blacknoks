import 'package:blacknoks/services/sell_asset.dart';
import 'package:flutter/cupertino.dart';

class AssetProvider extends ChangeNotifier {
  bool buying = false;
  bool selling = false;
  TextEditingController stockOrderVolumeController =
      TextEditingController(text: '100');

  Future sellAssets(
      context, currentStockName, currentStockPrice, volume) async {
    selling = true;
    await sellAsset(currentStockName, volume, currentStockPrice)
        .whenComplete(() {
      selling = false;
      notifyListeners();
      print("sell = false");
    });
  }

  Future buyAssets() async {}
}
