import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'api(s)/momo_api_payment _gateway/post_requesttpay.dart';

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
        MomoApi.postRequestToPay().then((response) {
      if (response.statusCode == 200) {
        return documentReference.set({
          'Volume': value,
          'Price': currentStockPrice,
          'Cost': cost
          });
      }
    });
        return true;
      }
      var newVolume = snapshot['Volume'] + value;
      var newCost = snapshot['Cost']+cost;
      var newPrice =  newCost/newVolume;
      MomoApi.postRequestToPay().then((response) {
      if (response.statusCode == 200) {
        return transaction.update(documentReference, {
        'Volume': newVolume,
        'Price': newPrice,
        'Cost': newCost
        });
      }
    });
      
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}