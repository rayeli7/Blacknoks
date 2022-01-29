import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserPortfolioPage extends StatefulWidget {
  const UserPortfolioPage({Key? key}) : super(key: key);

  @override
  _UserPortfolioPageState createState() => _UserPortfolioPageState();
}

class _UserPortfolioPageState extends State<UserPortfolioPage> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  <Widget>[
              SizedBox(
                 width: MediaQuery.of(context).size.width/7.5,
                 child:
                 const Padding(
                   padding: EdgeInsets.all(8.0),
                    child: Text("Stock"),
                    ),
                    ),
              SizedBox(
                            width: MediaQuery.of(context).size.width/5,
                            child:
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    "Amount"
                                    ),
                              ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/5,
                            child:
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    "Price"
                                    ),
                              ),
                          ), 
                          SizedBox(
                            width: MediaQuery.of(context).size.width/5,
                            child:
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    "Bought"
                                    ),
                              ),
                          ),  
                          
                          SizedBox(
                            width: MediaQuery.of(context).size.width/5,
                            child:
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    "Gain"
                                    ),
                              ),
                          ), 
                            ],
                          ),
                          
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
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
    
                      return ListView(
                        children: snapshot.data!.docs.map((document) {
                          double price = document['Price'];
                          double cost = document['Cost'];
                          double volume = document['Volume'];
                          String stockTicker = document.id;
                          return Card(
                            margin: const EdgeInsets.all(5),
                            elevation: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/8,
                              child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(stockTicker),
                                ),
                            
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/5,
                              child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "$volume"
                                      ),
                                ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/5,
                              child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      price.toStringAsFixed(2)
                                      ),
                                ),
                            ), 
                            SizedBox(
                              width: MediaQuery.of(context).size.width/5,
                              child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      cost.toStringAsFixed(2)
                                      ),
                                ),
                            ), 
                            SizedBox(
                              width: MediaQuery.of(context).size.width/5.9,
                              child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      cost.toStringAsFixed(0)
                                      ),
                                ),
                              
                            ), 
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
 
  final String x;
  final double y;
}