import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:blacknoks/services/sell_asset.dart';
import 'package:flutter/cupertino.dart';

class AssetProvider extends ChangeNotifier {
  bool buying = false;
  bool selling = false;
  TextEditingController stockOrderVolumeController =
      TextEditingController(text: '100');

  void sellAssets(
      context, currentStockName, currentStockPrice, volume) async {
    selling = true;
    await sellAsset(currentStockName, volume, currentStockPrice).then((value) {
      selling = false;
      notifyListeners();
      showFlushbar(context: context, flushbar: Flushbar(

      ));
    });
  }

  Future buyAssets()async{
    
  } 
}
