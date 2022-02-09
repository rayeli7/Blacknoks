import 'package:another_flushbar/flushbar.dart' show Flushbar;
import 'package:blacknoks/services/auth_service.dart';
import 'package:blacknoks/services/buy_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'buy_buttonWidget.dart';
import 'sell_buttonWidget.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    Key? key,
    required this.stockOrderVolumeController,
    required this.currentStockPrice,
    required this.currentStockName,
    required this.showSellButton,
    changeValue,
  }) : super(key: key);

  final TextEditingController stockOrderVolumeController;
  final double? currentStockPrice;
  final String? currentStockName;
  final bool showSellButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
      ),
      child: ListView(
        children: <Widget>[
          const ListTile(),
          TextField(
            controller: stockOrderVolumeController,
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.headline4,
            decoration: const InputDecoration(
              labelText: 'Enter Volume',
              //errorText: ,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (String stockOrderVolumeController) {},
          ),
          const SizedBox(height: 8),
          Container(
            height: 20,
            alignment: Alignment.center,
            child: const Text(
              'Deposit at least GHS50.00 to start trading',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ), //remember to add condition to remove ifthe user has already done this
          ),
          Center(
            heightFactor: 3.5,
            child: RichText(
              text: TextSpan(
                  style: const TextStyle(fontSize: 25.0, color: Colors.black),
                  children: <TextSpan>[
                    const TextSpan(text: 'GH'),
                    const TextSpan(text: '₵ ', style: TextStyle(fontSize: 27)),
                    TextSpan(
                        text:
                            '${double.parse(((currentStockPrice! * int.parse(stockOrderVolumeController.text)).toStringAsFixed(2)))} of $currentStockName Stocks')
                  ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuyButtonWidget(
                  currentStockName: currentStockName,
                  stockOrderVolumeController: stockOrderVolumeController,
                  currentStockPrice: currentStockPrice),
              showSellButton
                  ? SellButtonWidget(
                      currentStockName: currentStockName,
                      stockOrderVolumeController: stockOrderVolumeController,
                      currentStockPrice: currentStockPrice)
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
