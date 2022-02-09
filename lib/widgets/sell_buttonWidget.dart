// ignore_for_file: file_names

import 'package:another_flushbar/flushbar.dart' show Flushbar;
import 'package:flutter/material.dart';

import '../services/sell_asset.dart';


class SellButtonWidget extends StatelessWidget {
  const SellButtonWidget({
    Key? key,
    required this.currentStockName,
    required this.stockOrderVolumeController,
    required this.currentStockPrice,
  }) : super(key: key);

  final String? currentStockName;
  final TextEditingController stockOrderVolumeController;
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
        onPressed: () async {
          String response = await sellAsset(currentStockName!,
              stockOrderVolumeController.text, currentStockPrice);

          Flushbar(
            title: "Sell Asset",
            message: response,
            duration: const Duration(seconds: 2),
          ).show(context).then((value) => Navigator.pop(context));
        },
        child: const Text(
          'Sell',
          textScaleFactor: 2.0,
        ),
      ),
    );
  }
}
