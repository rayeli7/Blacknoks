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
        var livestockdata = (widget.liveStockData).where((element) => element.name ==stockTicker );
        final double? currentStockPrice =livestockdata.elementAt(0).price;
        var changeValue=livestockdata.elementAt(0).change;
        return OpenContainer(transitionDuration: const Duration(seconds: 1),
                closedBuilder: (context, action)=>_Card(stockTicker: stockTicker, currentStockPrice: currentStockPrice, price: price, volume: volume,changeValue: changeValue,),
                openBuilder: (context, action)=> ModalBottomSheet(
              stockOrderVolumeController: stockOrderVolumeController,
              currentStockPrice: currentStockPrice, 
              currentStockName: stockTicker,
              changeValue: changeValue,
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
    required this.price,
    required this.volume, 
    required this.currentStockPrice,
    required this.changeValue,
  }) : super(key: key);

  final String stockTicker;
  final double? currentStockPrice;
  final double? changeValue;
  final double price;
  final double volume;

  

  @override
  Widget build(BuildContext context) {

    double gain = (currentStockPrice! - price)*volume ;
    Color? gainColor(){
        if (changeValue! < 0){
          return Colors.red;
        }else if (changeValue! > 0 ){
          return Colors.greenAccent;
        }
        else {
          return null;
        }
    };
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      elevation: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      SizedBox(
        height: MediaQuery.of(context).size.height/14,
        width: MediaQuery.of(context).size.width/7.5,
        child:
          Center(
            child: Text(stockTicker),
          ),
      
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width/6,
        child:
          Text(
              currentStockPrice!.toStringAsFixed(2) //Current Price
              ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width/6,
        child:
          Text(
              price.toStringAsFixed(2) //Purchase Price
              ),
      ), 
      SizedBox(
        width: MediaQuery.of(context).size.width/5,
        child:
          Text(
              volume.toStringAsFixed(0) //Quantity
              ),
      ), 
      Container(
        color: gainColor(),
        width: MediaQuery.of(context).size.width/4,
        child:
          Padding(
            padding: const EdgeInsets.fromLTRB( 0.0, 8.0, 0.0, 8.0),
            child: Center(
              child: RichText(
                            text:  TextSpan(
                             style: const TextStyle(
                              fontSize:18.0,
                              color: Colors.black
                             ),
                             children: <TextSpan>[
                               const TextSpan(text:'GH'),
                               const TextSpan(text: '₵ ',
                               style: TextStyle(
                                 fontSize:15 
                                 )),
                               TextSpan(text: gain.toStringAsFixed(1))
                             ]
                              ),
                          ),
            ),
          ),
        
      ), 
        ],
      ),
    );
  }
}

