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
    return Container(
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
                    return Card(
                      elevation: 6,
                      child: ListTile(
                        title: Text(document.id),
                        subtitle: Text(document["Price"]),
                        trailing: Text(document["Volume"]),
                        ),
                    );
                  }).toList(),
                );
              }),
        ),
      );
  }
}