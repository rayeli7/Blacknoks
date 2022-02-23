import 'dart:core';

import 'package:blacknoks/models/company_info_model.dart';
import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:blacknoks/pages/company_info_page.dart';
import 'package:blacknoks/pages/loading_page.dart';
import 'package:blacknoks/widgets/stocklist.dart';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../services/api(s)/fetch_api.dart';

class GSEMarketsPage extends StatelessWidget {
  final List<LiveStockData> livestockdata;
  final bool isLoading;

  const GSEMarketsPage({
    Key? key,
    required this.livestockdata,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: isLoading
              ? const LoadingPage()
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: livestockdata.length,
                  itemBuilder: (context, index) {
                    String? currentStockName =
                        livestockdata[index].name!;
                    return OpenContainer(
                      transitionDuration: const Duration(seconds: 1),
                      closedBuilder: (context, action) => StocklistWidget(
                          livestockdata: livestockdata, index: index),
                      openBuilder: (context, action) => FutureBuilder(
                        future: getStockInfo(currentStockName),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                Visibility(
                                  visible: snapshot.hasData,
                                  child: Text(
                                    '${snapshot.data}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 24),
                                  ),
                                )
                              ],
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Text('Error');
                            } else if (snapshot.hasData) {
                              return CompanyInfoPage(
                                  stockInfo: snapshot.data as CompanyInfo);
                            } else {
                              return const Text('Empty data');
                            }
                          } else {
                            return Text('State: ${snapshot.connectionState}');
                          }
                        },
                      ),
                    );
                  }),
        ),
      ],
    );
  }
}
