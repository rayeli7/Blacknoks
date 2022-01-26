import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                            children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Stock"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "Amount"
                                ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "Price"
                                ),
                          ), 
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "Bought"
                                ),
                          ),  
                          
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "Gain: \nprofit/loss"
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
                          return Row(
                            children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(stockTicker),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "$volume"
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                price.toStringAsFixed(2)
                                ),
                          ), 
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                cost.toStringAsFixed(2)
                                ),
                          ),  
                          /*
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "Gain: \nprofit/loss"
                                ),
                          ), */
                            ],
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