import 'package:blacknoks/services/sell_asset.dart';
import 'package:flutter/foundation.dart';

class AssetProvider extends ChangeNotifier {
  bool buying = false;
  bool selling = false;

  Future sellAssets(
      context, currentStockName, currentStockPrice, volume) async {
    selling = true;
    await sellAsset(currentStockName, volume, currentStockPrice);
  }
}
