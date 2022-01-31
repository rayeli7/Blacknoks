import 'package:animations/animations.dart';
import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'buy_modal_bottom_sheet.dart';


class PortfolioListWidget extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final List<LiveStockData> liveStockData;
  const PortfolioListWidget({
    Key? key,required this.snapshot, required this.liveStockData
  }) : super(key: key);

  @override
  State<PortfolioListWidget> createState() => _PortfolioListWidgetState();
}

class _PortfolioListWidgetState extends State<PortfolioListWidget> {
  var stockOrderVolumeController =  TextEditingController(text: '100');

  @override
  Widget build(BuildContext context) {
    var snapshots = widget.snapshot;
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children:
       snapshots.data!.docs.map((document) {
        double price = document['Price'];
        double cost = document['Cost'];
        double volume = document['Volume'];
        String stockTicker = document.id;
        return OpenContainer(transitionDuration: const Duration(seconds: 1),
                                               closedBuilder: (context, action)=>_Card(stockTicker: stockTicker, cost: cost, price: price, volume: volume),
                                               openBuilder: (context, action)=> ModalBottomSheet(
              stockOrderVolumeController: stockOrderVolumeController,
              currentStockPrice: 5, 
              currentStockName: stockTicker,
              ),
              );
      }).toList(),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.stockTicker,
    required this.cost,
    required this.price,
    required this.volume,
  }) : super(key: key);

  final String stockTicker;
  final double cost;
  final double price;
  final double volume;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      SizedBox(
        width: MediaQuery.of(context).size.width/8,
        child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(stockTicker),
          ),
      
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width/5,
        child:
          Padding(
            padding: const EdgeInsets.fromLTRB( 2.0, 8.0, 2.0, 8.0),
            child: Text(
                cost.toStringAsFixed(2)
                ),
          ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width/5,
        child:
          Padding(
            padding: const EdgeInsets.fromLTRB( 2.0, 8.0, 2.0, 8.0),
            child: Text(
                price.toStringAsFixed(2)
                ),
          ),
      ), 
      SizedBox(
        width: MediaQuery.of(context).size.width/5,
        child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                volume.toStringAsFixed(0)
                ),
          ),
      ), 
      SizedBox(
        width: MediaQuery.of(context).size.width/5.9,
        child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                cost.toStringAsFixed(0)
                ),
          ),
        
      ), 
        ],
      ),
    );
  }
}

