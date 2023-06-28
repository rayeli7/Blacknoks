import 'package:blacknoks/services/asset_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'buy_buttonWidget.dart';
import 'sell_buttonWidget.dart';

class ModalBottomSheet extends StatelessWidget {
  ModalBottomSheet({
    Key? key,
    required this.currentStockPrice,
    required this.currentStockName,
    required this.showSellButton,
    changeValue,
  }) : super(key: key);

  final double? currentStockPrice;
  final String? currentStockName;
  final bool showSellButton;

  @override
  Widget build(BuildContext context) {
    TextEditingController _p =
        Provider.of<AssetProvider>(context).stockOrderVolumeController;
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller:
                Provider.of<AssetProvider>(context).stockOrderVolumeController,
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.headlineMedium,
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
                            '${double.parse(((currentStockPrice! * int.parse((_p.text == '') ? '0' : _p.text)).toStringAsFixed(2)))} of $currentStockName Stocks')
                  ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuyButtonWidget(
                  currentStockName: currentStockName,
                  stockOrderVolumeController: _p.text,
                  currentStockPrice: currentStockPrice),
              showSellButton
                  ? SellButtonWidget(
                      currentStockName: currentStockName,
                      stockOrderVolumeController: _p.text,
                      currentStockPrice: currentStockPrice)
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
