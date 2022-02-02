import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String?> signIn({String? email, String? password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email!.trim(), password: password!.trim());
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String?> signUp({String? email, String?  password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email!.trim(), password: password!.trim());
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}


Future<bool> buyAsset(String currentStockName,String volume, currentStockPrice) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    double value = double.tryParse(volume.toString()) ?? 0;
    double cost = value*currentStockPrice;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Portfolio')
        .doc(currentStockName);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({
          'Volume': value,
          'Price': currentStockPrice,
          'Cost': cost
          });
        return true;
      }
      var newVolume = snapshot['Volume'] + value;
      var newCost = snapshot['Cost']+cost;
      var newPrice =  newCost/newVolume;
      transaction.update(documentReference, {
        'Volume': newVolume,
        'Price': newPrice,
        'Cost': newCost
        });
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> sellAsset(String currentStockName,String volume, currentStockPrice) async {
  try{
  String uid = FirebaseAuth.instance.currentUser!.uid;
  double value = double.tryParse(volume.toString()) ?? 0;
  double cost = value*currentStockPrice;
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Portfolio')
      .doc(currentStockName);
      FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      var newVolume = snapshot['Volume'] - value;
      var newCost = snapshot['Cost']-cost;
      var newPrice =  newCost/newVolume;
      if (newVolume == 0){
        documentReference.delete();
        return Text('You have sold all Assets in $currentStockName');
      } else if (newVolume <= 0){
        return false;
      }
      transaction.update(documentReference, {
        'Volume': newVolume,
        'Price': newPrice,
        'Cost': newCost
        });
      });     
  return true;
  } catch(e){
    return false;
  }
}