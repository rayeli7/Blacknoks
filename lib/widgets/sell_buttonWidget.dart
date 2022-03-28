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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 100),
          maximumSize: const Size(150, 100),
          primary: Colors.red,
        ),
        onPressed: () {
          Provider.of<AssetProvider>(context, listen: false).sellAssets(context,
              currentStockName, currentStockPrice, stockOrderVolumeController);
          Navigator.pop(context);
        },
        child: const Text(
          'Sell',
          textScaleFactor: 2.0,
        ),
      ),
    );
  }
}
