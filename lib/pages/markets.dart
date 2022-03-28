import 'dart:core';

import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:blacknoks/pages/company_info_page.dart';
import 'package:blacknoks/pages/loading_page.dart';
import 'package:blacknoks/services/connectivity_provider.dart';
import 'package:blacknoks/widgets/stocklist.dart';
import 'package:empty_widget/empty_widget.dart';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../services/api(s)/fetch_api.dart';
import '../services/livedata_provider.dart';

class GSEMarketsPage extends StatelessWidget {
  const GSEMarketsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ConnectivityProvider>(context, listen: false)
        .checkInternetConnection();
    var _p = Provider.of<LiveProvider>(context, listen: false);
    final List<LiveStockData> _livestockdata = _p.livestockdata;

    return !Provider.of<LiveProvider>(context).isConnected
        ? Stack(
            children: <Widget>[
              Container(
                child: EmptyWidget(
                  title: "Bad Connection",
                  subTitle: "Kindly Check Your Internet Connection And Retry",
                  image: null,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                    onPressed: () {
                      var p = Provider.of<LiveProvider>(context, listen: false);
                      p.getLiveStockData();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthenticationWrapper(),
                        ),
                      );
                    },
                    icon: Icon(Icons.refresh_rounded),
                    label: Text("Retry")),
              )
            ],
          )
        : Column(
            children: [
              Flexible(
                child: Provider.of<LiveProvider>(context).isLoading
                    ? const LoadingPage()
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _livestockdata.length,
                        itemBuilder: (context, listIndex) {
                          return OpenContainer(
                              transitionDuration: const Duration(seconds: 1),
                              closedBuilder: (context, action) =>
                                  StocklistWidget(
                                    index: listIndex,
                                  ),
                              openBuilder: (context, action) => CompanyInfoPage(
                                  stockInfo: companyInfoList[listIndex]));
                        }),
              ),
            ],
          );
  }
}
