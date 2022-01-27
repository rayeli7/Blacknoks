import 'dart:convert';
import 'dart:core';

import 'package:blacknoks/api(s)/fetch_api.dart';
import 'package:blacknoks/pages/company_info_page.dart';
import 'package:blacknoks/services/auth_service.dart';
import 'package:blacknoks/pages/loading_page.dart';

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
      setState(() async{
        await _getLiveStockData().then(
        _isLoading = false);
      });
    });     
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Row(
              children:  [
                const Text(' Symbol',
                textScaleFactor: 1.3,),
                SizedBox(
                  width: MediaQuery.of(context).size.width/1.8,
                ),
                const Text('Price(GHS)',
                textScaleFactor: 1.3,),
              ],
            ),
        Flexible(
          child:_isLoading? const LoadingPage(): 
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
                  itemCount: livestockdata.length,
                  itemBuilder: (context, index) {                
                    double? currentStockPrice = livestockdata[index].price!;
                    String? currentStockName = livestockdata[index].name!;
                    return 
                       OpenContainer(
                         transitionDuration: const Duration(milliseconds: 950),
                         closedBuilder: (BuildContext context, void Function() action)=>Card(
                         elevation: 5,
                         child: ListTile(
                           textColor: Colors.black,
                           enableFeedback: true,
                             
                           title: Text(livestockdata[index].name!,
                           style:const TextStyle(
                               color: Colors.black,)
                           ),
                                            
                           subtitle: Text(
                             GSE_Companies[index],
                             style:const TextStyle(
                               color: Colors.grey,
                             ),
                           ),
                                            
                           trailing:Column(
                             children: [
                               SizedBox(
                                 width: 90,
                                 child: ElevatedButton(
                                   onPressed: ()=>showModalBottomSheet(
                                     context: context,
                                      builder: (context)=>
                                      Container(
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
                                               onChanged:(String stockOrderVolumeController){
                                               },
                                             ),
                                             const SizedBox(height:8),
                                             Container(
                                               height: 20,
                                               alignment: Alignment.center,
                                               child: const Text('Deposit at least GHS50.00 to start trading',
                                               style: TextStyle(
                                                 color: Colors.grey,
                               
                                               ),
                                               ),//remember to add condition to remove ifthe user has already done this
                                             ),
                                             //const SizedBox(height:8),
                                             Center(
                                               heightFactor: 3.5,
                                               child: 
                                               Text('GHS ${double.parse(((currentStockPrice*int.parse(stockOrderVolumeController.text)).toStringAsFixed(2)))} of $currentStockName Stocks',
                                               style: const TextStyle(
                                                 fontSize: 25,),
                                                )
                                               ),
                                             //const SizedBox(height:8),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Container(
                                                   padding:const EdgeInsets.symmetric(horizontal: 4,),
                                                   alignment: Alignment.center,
                                                   child: ElevatedButton(
                                                     style: ElevatedButton.styleFrom(
                                                       minimumSize: const Size(150, 100),
                                                       maximumSize: const Size(150, 100),
                                                     ),
                                                     onPressed: () async{
                                                      await  addCoin(currentStockName, stockOrderVolumeController.text, currentStockPrice);
                                                      Navigator.pop(context);
                                                     },
                                                     
                                                     child:const Text('Buy',
                                                     textScaleFactor: 2.0,
                                                     ),
                                                     ),
                                                 ),
                                   
                                                 Container(
                                                   padding:const EdgeInsets.symmetric(horizontal: 4,),
                                                   alignment: Alignment.center,
                                                   child: ElevatedButton(
                                                     style: ElevatedButton.styleFrom(
                                                       minimumSize: const Size(150, 100),
                                                       maximumSize: const Size(150, 100),
                                                       primary: Colors.red,),
                                                     onPressed: ()=>Navigator.pop(context), 
                                                     child:const Text('Sell',
                                                     textScaleFactor: 2.0,
                                                     ),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ],
                                           ),
                                         ),
                                       ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text(
                                       livestockdata[index].price!.toString(),
                                       style: const TextStyle(
                                       color: Colors.black),
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             ),                
                           ),
                         ),
                         openBuilder: (BuildContext context, void Function({Object? returnValue}) action)=>const CompanyInfoPage(),
                       );
                    }
              ),
        ),
      ],
    );
  }
}