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
        ),
        onPressed: stockOrderVolumeController != ''
            ? () async {
                
                await buyAsset(currentStockName!, stockOrderVolumeController,
                        currentStockPrice)
                    .then((value) => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(value.status),
                              content: Text(value.message),
                              actions: <Widget>[
                                new TextButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            )));
              }
            : () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text('Empty Field'),
                          content: Text('Volume Field Cannot Be Empty'),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              },
        child: const Text(
          'Buy',
          textScaleFactor: 2.0,
        ),
      ),
    );
  }
}
