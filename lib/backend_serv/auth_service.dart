import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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






Future<String> addCoin(String currentStockName, String volume,String currentStockPrice) async {
  try {
    double volume_0 = double.parse(volume);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Portfolio')
        .doc(currentStockName);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({
          "Volume": volume_0.toString(),
          "Price": currentStockPrice
          });
        return 'added';
      }
      double newVolume = snapshot["Volume"] + volume_0;
      transaction.update(documentReference, {"Volume": newVolume.toString()});
      return 'updated';
    });
    return 'succesful!';
  } catch (e) {
    return 'failed!';
  }
}
