import 'dart:convert';
import 'dart:core';

import 'package:another_flushbar/flushbar.dart';

import 'package:blacknoks/models/company_info_model.dart';
import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:blacknoks/pages/company_info_page.dart';
import 'package:blacknoks/pages/loading_page.dart';
import 'package:blacknoks/widgets/stocklist.dart';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:shimmer/shimmer.dart';

import '../models/theme.dart';
import '../services/api(s)/fetch_api.dart';

class GSEMarketsPage extends StatefulWidget {
  final List<LiveStockData> livestockdata;
  final bool isLoading;

  const GSEMarketsPage({
    Key? key,
    required this.livestockdata,
    required this.isLoading,
  }) : super(key: key);

  @override
  _GSEMarketsPageState createState() => _GSEMarketsPageState();
}

class _GSEMarketsPageState extends State<GSEMarketsPage> {
  final TextEditingController stockOrderVolumeController =
      TextEditingController(text: '100');

  Future _getStockInfo(context, stockName) async {
    CompanyInfo? stockInfo;
    try {
      var response = await API.getStockInfo(stockName);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        stockInfo = CompanyInfo.fromJson(jsonResponse);
      } else {
        Flushbar(
          icon: const Icon(
            Icons.email_outlined,
            color: Colors.white,
            size: 30,
          ),
          backgroundColor: const Color(0xFF0277BD),
          duration: const Duration(seconds: 4),
          message: "This email is already registered.",
          messageSize: 18,
          titleText: const Text("Flushbar with Icon.",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ).show(context);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return stockInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: widget.isLoading
              ? const LoadingPage()
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.livestockdata.length,
                  itemBuilder: (context, index) {
                    String? currentStockName =
                        widget.livestockdata[index].name!;
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
                                      fontSize: 14.0, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Price/GH'),
                                    TextSpan(
                                        text: '₵',
                                        style: TextStyle(fontSize: 15))
                                  ]),
                            ),
                          ),
                        ),
                      );
                    }
                    return FutureBuilder(
                        future: _getStockInfo(context, currentStockName),
                        builder: (context, AsyncSnapshot<Object?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                enableFeedback: true,
                                title: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.red,
                                  child: const SizedBox(
                                    height: 20,
                                    width: 100,
                                  ),
                                ),
                                subtitle: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor: Colors.red,
                                    child: const SizedBox(
                                      height: 20,
                                      width: 100,
                                    )),
                                trailing: Column(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.blue,
                                      highlightColor: textWhiteGrey,
                                      child: SizedBox(
                                        width: 90,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Text('Error');
                            } else if (snapshot.hasData) {
                              return OpenContainer(
                                transitionDuration: const Duration(seconds: 1),
                                closedBuilder: (context, action) =>
                                    StocklistWidget(
                                        livestockdata: widget.livestockdata,
                                        stockOrderVolumeController:
                                            stockOrderVolumeController,
                                        stockInfo:
                                            (snapshot.data as CompanyInfo)
                                                .company!
                                                .name,
                                        index: index),
                                openBuilder: (context, action) =>
                                    CompanyInfoPage(
                                  stockInfo: snapshot.data as CompanyInfo,
                                ),
                              );
                            } else {
                              return const Text('Empty data');
                            }
                          } else {
                            return Text('State: ${snapshot.connectionState}');
                          }
                        });
                  }),
        ),
      ],
    );
  }
}
