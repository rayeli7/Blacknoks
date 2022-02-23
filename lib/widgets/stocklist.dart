import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:flutter/material.dart';

import '../services/api(s)/fetch_api.dart';
import 'modal_bottom_sheet.dart';

class StocklistWidget extends StatelessWidget {
  const StocklistWidget({
    Key? key,
    required this.index,
    required this.livestockdata,
  }) : super(key: key);

  final List<LiveStockData> livestockdata;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        textColor: Colors.black,
        enableFeedback: true,
        title: Text(livestockdata[index].name!,
            style: const TextStyle(
              color: Colors.black,
            )),
        subtitle: Text(
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
                currentStockPrice: livestockdata[index].price,
                currentStockName: livestockdata[index].name,
                showSellButton: false,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                livestockdata[index].price!.toString(),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (livestockdata[index].change! > 0) {
                    return Colors.green;
                  } else if (livestockdata[index].change! < 0) {
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
