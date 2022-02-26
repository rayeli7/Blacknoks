import 'package:blacknoks/services/livedata_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/api(s)/fetch_api.dart';
import 'modal_bottom_sheet.dart';

class StocklistWidget extends StatelessWidget {
  StocklistWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<LiveProvider>(context, listen: false);
    return Card(
      elevation: 5,
      child: ListTile(
        textColor: Colors.black,
        enableFeedback: true,
        title: Text(_provider.livestockdata[index].name,
            style: const TextStyle(
              color: Colors.black,
            )),
        subtitle: //companyInfoList.length != _provider.livestockdata.length ? Container():
            Text(
          '${GSE_Companies[index]}',
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: SizedBox(
          width: 90,
          child: ElevatedButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => ModalBottomSheet(
                showSellButton: false,
                currentStockName: _provider.livestockdata[index].name,
                currentStockPrice: _provider.livestockdata[index].price,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _provider.livestockdata[index].price.toString(),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (_provider.livestockdata[index].change > 0) {
                    return Colors.green;
                  } else if (_provider.livestockdata[index].change < 0) {
                    return Colors.redAccent;
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
