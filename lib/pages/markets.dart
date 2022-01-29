import 'dart:convert';
import 'dart:core';

import 'package:blacknoks/api(s)/fetch_api.dart';
import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:blacknoks/pages/company_info_page.dart';
import 'package:blacknoks/services/auth_service.dart';
import 'package:blacknoks/pages/loading_page.dart';
import 'package:blacknoks/widgets/stocklist.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animations/animations.dart';


class GSEMarketsPage extends StatefulWidget {
  const GSEMarketsPage({ Key? key }) : super(key: key);

  @override
  _GSEMarketsPageState createState() => _GSEMarketsPageState();
}

class _GSEMarketsPageState extends State<GSEMarketsPage> {
  final TextEditingController stockOrderVolumeController= TextEditingController(text: '100');
  var livestockdata = <LiveStockData>[];
  late bool _isLoading;


   
  _getLiveStockData() {
    API.getLiveStockData().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        livestockdata = list.map((model) => LiveStockData.fromJson(model)).toList();
      });
    });
  }


  @override
  initState() {
    super.initState();
    _isLoading = true;
    Future.delayed(const Duration(seconds: 0), () {
      setState((){
        _getLiveStockData().then(
        _isLoading = false);
      });
    });     
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child:_isLoading? const LoadingPage(): 
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
                  itemCount: livestockdata.length,
                  itemBuilder: (context, index) {                
                    double? currentStockPrice = livestockdata[index].price!;
                    String? currentStockName = livestockdata[index].name!;
                    if (index == 0) {
                return Container(
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  color: Colors.amber,
                  child: const ListTile(
                    title: Text('Symbol'),
                    trailing: SizedBox(
                      width: 90,
                      child: Text(
                        'Price/GHS'
                        ),
                    ),
                  ),
                );}
                    return OpenContainer(
                         transitionDuration: const Duration(seconds: 1),
                         closedBuilder: (context, action)=>
                         StocklistWidget(livestockdata: livestockdata,
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

