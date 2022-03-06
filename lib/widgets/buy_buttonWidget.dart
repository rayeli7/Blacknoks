// ignore_for_file: file_names

import 'package:another_flushbar/flushbar.dart' show Flushbar;
import 'package:blacknoks/models/flutterwave_response_model.dart';
import 'package:flutter/material.dart';

import '../services/buy_asset.dart';

class BuyButtonWidget extends StatelessWidget {
  const BuyButtonWidget({
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
        ),
        onPressed: () async {
          FlutterWaveResponse response = await buyAsset(currentStockName!,
              stockOrderVolumeController.text, currentStockPrice);

          Navigator.pop(context);

          Flushbar(
            title: response.status,
            message: response.message,
            duration: const Duration(seconds: 5),
          ).show(context);
        },
        child: const Text(
          'Buy',
          textScaleFactor: 2.0,
        ),
      ),
    );
  }
}
