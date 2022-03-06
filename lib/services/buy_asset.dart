import 'package:blacknoks/models/flutterwave_response_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'api(s)/post_requesttpay.dart';

Future<FlutterWaveResponse> buyAsset(
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
        FlutterWaveResponse finalResponse =
            await FlutterWaveApi.postRequestToPay(cost, currentStockName)
                .then((response) {
          if (response.status == "success") {
            documentReference.set({
              'Volume': value.toString(),
              'Price': currentStockPrice.toString(),
              'Cost': cost.toStringAsFixed(2)
            });
            return response;
          } else {
            return response;
          }
        });
        return finalResponse;
      }
      var newVolume = snapshot['Volume'] + value;
      double newCost = snapshot['Cost'] + cost;
      var newPrice = newCost / newVolume;
      FlutterWaveResponse finalResponse =
          await FlutterWaveApi.postRequestToPay(cost, currentStockName)
              .then((response) {
        if (response.status == "success") {
          transaction.update(documentReference, {
            'Volume': newVolume.toString(),
            'Price': newPrice.toString(),
            'Cost': newCost.toStringAsFixed(2)
          });
          return response;
        } else {
          print(response.status);
          return response;
        }
      });
      return finalResponse;
    });
  } catch (e) {
    final FlutterWaveResponse error = FlutterWaveResponse(
        status: 'Failed',
        message: "Error, Transaction did not complete\n${e.toString()}",
        meta: Meta(authorization: Authorization(mode: "", redirect: ""))
        );
    return error;
  }
}
