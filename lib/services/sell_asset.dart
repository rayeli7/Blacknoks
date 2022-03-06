import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> sellAsset(
    String currentStockName, String volume, currentStockPrice) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    double value = double.tryParse(volume.toString()) ?? 0;
    double cost = value * currentStockPrice;
    String response;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Portfolio')
        .doc(currentStockName);
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      var newVolume = double.parse(snapshot['Volume']) - value;
      var newCost = double.parse(snapshot['Cost']) - cost;
      var newPrice = newCost / newVolume;
      if (newVolume == 0) {
        documentReference.delete();
        response = ('You have sold all Assets in $currentStockName');
        return (response);
      } else if (newVolume <= 0) {
        response = ("you don't have enough $currentStockName assets");
        return (response);
      }
      transaction.update(documentReference, {
        'Volume': newVolume.toString(),
        'Price': newPrice.toString(),
        'Cost': newCost.toString()
      });
      response = "Success";
      return response;
    });
  } catch (e) {
    return 'failed';
  }
}
