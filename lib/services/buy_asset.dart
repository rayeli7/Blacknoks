import 'package:blacknoks/services/api(s)/momo_api_payment%20_gateway/post_requesttpay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> buyAsset(
    String currentStockName, String volume, currentStockPrice) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    double value = double.tryParse(volume.toString()) ?? 0;
    double cost = value * currentStockPrice;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Portfolio')
        .doc(currentStockName);
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        var finalResponse = await MomoApi.postRequestToPay().then((response) {
          if (response.statusCode == 200) {
            documentReference.set(
                {'Volume': value, 'Price': currentStockPrice, 'Cost': cost});
            return response;
          } else {
            return 'Sorry transaction did not complete';
          }
        });
        return finalResponse.toString();
      }
      var newVolume = snapshot['Volume'] + value;
      var newCost = snapshot['Cost'] + cost;
      var newPrice = newCost / newVolume;
      var finalResponse = await MomoApi.postRequestToPay().then((response) {
        if (response.statusCode == 200) {
          transaction.update(documentReference,
              {'Volume': newVolume, 'Price': newPrice, 'Cost': newCost});
          return response;
        } else {
          return 'Sorry transaction did not complete';
        }
      });
      return finalResponse.toString();
    });
  } catch (e) {
    return 'failed';
  }
}
