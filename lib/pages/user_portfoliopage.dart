
import 'package:animations/animations.dart';
import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:blacknoks/models/piechart_chartdata_model.dart';
import 'package:blacknoks/widgets/buy_modal_bottom_sheet.dart';
import 'package:blacknoks/widgets/portfoliolist_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserPortfolioPage extends StatefulWidget {
  final List<LiveStockData> livestockdata;

  const UserPortfolioPage({Key? key, required this.livestockdata}) : super(key: key);

  @override
  _UserPortfolioPageState createState() => _UserPortfolioPageState();
}

class _UserPortfolioPageState extends State<UserPortfolioPage> {
  var stockOrderVolumeController = TextEditingController(text: '100');

  
  @override
  Widget build(BuildContext context) {
    return Container(
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
    
                    List<ChartData> chartdataList = (snapshot.data!.docs.map((document) {
                    return ChartData(document.id,document['Cost']);
                              }).toList());
                    return Column(
                      children: <Widget>[
                        SfCircularChart(
                          //title: ChartTitle(
                            //  text: 'Your Portfolio:',
                              // Aligns the chart title to left
                              //alignment: ChartAlignment.near,
                              //textStyle: const TextStyle(
                              //  fontSize: 14,
                             // )
                            //),
                          tooltipBehavior:TooltipBehavior (enable:true),
                          legend: Legend(
                            //title: LegendTitle(
                              //text:'Assets',
                              //textStyle: const TextStyle(
                               // fontSize: 20,
                             // )),
                            position:LegendPosition.bottom ,
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
                                    labelPosition: ChartDataLabelPosition.outside,
                                    useSeriesColor: true
                                ),
                            explode: true,
                            explodeIndex: 0,
                            explodeGesture: ActivationMode.singleTap
                    
                          )
                                    ]),
                      Container(
                        color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:  <Widget>[
                            SizedBox(
                               width: MediaQuery.of(context).size.width/7.5,
                               child:
                               const Padding(
                                 padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                 child: Text("Stock"),
                               ),
                                  ),
                            SizedBox(
                                        width: MediaQuery.of(context).size.width/6,
                                        child: const Text(
                                            "Current Price"
                                            ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width/6,
                                        child:
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB( 0.0, 8.0, 2.0, 8.0),
                                            child: Text(
                                                "Purchase Price"
                                                ),
                                          ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width/5,
                                        child:
                                          const Text(
                                              "Quantity"
                                              ),
                                      ),
                    
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width/4,
                                        child:
                                          const Center(
                                            child: Text(
                                                "Gain"
                                                ),
                                          ),
                                      ),
                                      ],
                                   ),
                                 ),
                        Flexible(
                          child: PortfolioListWidget(snapshot: snapshot,liveStockData: widget.livestockdata )
                          ),
                        ]);
                      })
    );}
  }

