import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServis{

  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  User? getCurentUser(){
    return _auth.currentUser;
  }

  //sign in
  Future<UserCredential?>signInWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential userCredential=await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _firestore.collection("Users").doc(userCredential.user!.uid).set({
      'uid':userCredential.user!.uid,
      'email':email
      });
      return userCredential;
    }
    catch(e){
      print("hata cıktı $e");
    }
  }

  //sıgn up
  Future<UserCredential?>signUpWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential userCredential=await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid':userCredential.user!.uid,
        'email':email
      });
      return userCredential;
    }
    catch(e){
      print("hata cıktı $e");
    }
  }


// sıgn out
  Future<void>signOut()async{
    return await _auth.signOut();
  }
}