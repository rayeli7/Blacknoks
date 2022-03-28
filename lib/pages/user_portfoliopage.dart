import 'package:blacknoks/models/piechart_chartdata_model.dart';
import 'package:blacknoks/services/livedata_provider.dart';
import 'package:blacknoks/widgets/portfoliolist_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../main.dart';

class UserPortfolioPage extends StatefulWidget {
  const UserPortfolioPage({
    Key? key,
  }) : super(key: key);

  @override
  _UserPortfolioPageState createState() => _UserPortfolioPageState();
}

class _UserPortfolioPageState extends State<UserPortfolioPage> {
  var stockOrderVolumeController = TextEditingController(text: '100');

  @override
  Widget build(BuildContext context) {
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
                        var p =
                            Provider.of<LiveProvider>(context, listen: false);
                        p.getLiveStockData();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuthenticationWrapper(),
                          ),
                        );
                      },
                      icon: Icon(Icons.refresh_rounded),
                      label: Text("Retry")))
            ],
          )
        : Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Portfolio')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<ChartData> chartdataList =
                      (snapshot.data!.docs.map((document) {
                    return ChartData(
                        document.id, double.parse(document['Cost']));
                  }).toList());
                  return chartdataList.isEmpty
                      ? Container(
                          child: EmptyWidget(
                            title: "No Purchase",
                            subTitle:
                                "When you make a purchase, It would appear here in your Portfolio 😊",
                            image: null,
                          ),
                        )
                      : Column(children: <Widget>[
                          SfCircularChart(
                              tooltipBehavior: TooltipBehavior(enable: true),
                              legend: Legend(
                                  position: LegendPosition.bottom,
                                  iconWidth: 40,
                                  iconHeight: 20,
                                  isVisible: true),
                              series: <CircularSeries>[
                                DoughnutSeries<ChartData, String>(
                                    dataSource: chartdataList,
                                    enableTooltip: true,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true,
                                        labelPosition:
                                            ChartDataLabelPosition.outside,
                                        useSeriesColor: true),
                                    explode: true,
                                    explodeIndex: 0,
                                    explodeGesture: ActivationMode.singleTap)
                              ]),
                          Container(
                            color: Colors.amber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 7.5,
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Text("Stock"),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                  child: const Text("Current Price"),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0.0, 8.0, 2.0, 8.0),
                                    child: Text("Purchase Price"),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: const Text("Quantity"),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: const Center(
                                    child: Text("Gain"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                              child: PortfolioListWidget(
                            snapshot: snapshot,
                          )),
                        ]);
                }));
  }
}
