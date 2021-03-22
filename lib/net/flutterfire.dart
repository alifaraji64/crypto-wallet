import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String error;
Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      error = "please first register yor email";
    }

    return false;
  } catch (e) {
    print("error from login" + e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == "weak-password") {
      error = 'the password provided is too weak';
    } else if (e.code == "email-already-in-use") {
      error = "the account already exists for that email";
    }
    return false;
  } catch (e) {
    print('yoooo');
    error = "an unknown error occured";
    return false;
  }
}

Future<bool> addCoin(String id, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    double value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Amount': value});
        return true;
      } else {
        double newAmount = snapshot.data()['Amount'] + value;
        transaction.update(documentReference, {'Amount': newAmount});
        return true;
      }
    });
  } catch (e) {
    return false;
  }
}
