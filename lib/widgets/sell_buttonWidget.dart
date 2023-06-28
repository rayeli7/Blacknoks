import 'package:blacknoks/services/asset_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellButtonWidget extends StatelessWidget {
  const SellButtonWidget({
    Key? key,
    required this.currentStockName,
    required this.stockOrderVolumeController,
    required this.currentStockPrice,
  }) : super(key: key);

  final String? currentStockName;
  final String stockOrderVolumeController;
  final double? currentStockPrice;

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<AssetProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 100), backgroundColor: Colors.red,
          maximumSize: const Size(150, 100),
        ),
        onPressed: () async {
          await Provider.of<AssetProvider>(context, listen: false).sellAssets(
              context,
              currentStockName,
              currentStockPrice,
              stockOrderVolumeController);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Empty Field'),
                  content: p.selling
                      ? SingleChildScrollView(
                          child: Center(child: CircularProgressIndicator()))
                      : Text('Volume Field Cannot Be Empty'),
                  actions: <Widget>[
                    new TextButton(
                      child: new Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
        child: const Text(
          'Sell',
          textScaleFactor: 2.0,
        ),
      ),
    );
  }
}
