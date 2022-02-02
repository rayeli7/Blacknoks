import 'dart:core';

import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:blacknoks/pages/company_info_page.dart';
import 'package:blacknoks/pages/loading_page.dart';
import 'package:blacknoks/widgets/stocklist.dart';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';


class GSEMarketsPage extends StatefulWidget {
  final List<LiveStockData> livestockdata;
  final bool isLoading;

  const GSEMarketsPage({ Key? key,
  required this.livestockdata, required this.isLoading,
   }) : super(key: key);

  @override
  _GSEMarketsPageState createState() => _GSEMarketsPageState();
}

class _GSEMarketsPageState extends State<GSEMarketsPage> {
  final TextEditingController stockOrderVolumeController= TextEditingController(text: '100');
  


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child:widget.isLoading? const LoadingPage(): 
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
                  itemCount: widget.livestockdata.length,
                  itemBuilder: (context, index) {                
                    double? currentStockPrice = widget.livestockdata[index].price!;
                    String? currentStockName = widget.livestockdata[index].name!;
                    if (index == 0) {
                return Container(
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  color: Colors.amber,
                  child: ListTile(
                    title: const Text('Symbol'),
                    trailing: SizedBox(
                      width: 90,
                      child: RichText(
                        text: const TextSpan(
                         style: TextStyle(
                          fontSize:14.0,
                          color: Colors.black
                         ),
                         children: <TextSpan>[
                           TextSpan(text:'Price/GH'),
                           TextSpan(text: '₵',
                           style:TextStyle(
                             fontSize:15 
                             ))
                         ]
                          ),
                      ),
                    ),
                  ),
                );}
                    return OpenContainer(
                         transitionDuration: const Duration(seconds: 1),
                         closedBuilder: (context, action)=>
                         StocklistWidget(livestockdata: widget.livestockdata,
                          stockOrderVolumeController: stockOrderVolumeController, 
                          currentStockPrice: currentStockPrice, 
                          currentStockName: currentStockName, 
                          index: index),
                         openBuilder: (context, action)=> CompanyInfoPage(stockName: currentStockName,),
                       );  
                    }
              ),
        ),
      ],
    );
  }
}

