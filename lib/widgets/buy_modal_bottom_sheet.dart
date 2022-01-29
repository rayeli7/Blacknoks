import 'package:blacknoks/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    Key? key,
    required this.stockOrderVolumeController,
    required this.currentStockPrice,
    required this.currentStockName,
  }) : super(key: key);

  final TextEditingController stockOrderVolumeController;
  final double? currentStockPrice;
  final String? currentStockName;

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
           Center(
             heightFactor: 3.5,
             child: 
             Text('GHS ${double.parse(((currentStockPrice!*int.parse(stockOrderVolumeController.text)).toStringAsFixed(2)))} of $currentStockName Stocks',
             style: const TextStyle(
               fontSize: 25,),
              )
             ),
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
                    await  addCoin(currentStockName!, stockOrderVolumeController.text, currentStockPrice);
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
       );
  }
}