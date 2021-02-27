import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Auth{
 String role='';
 Auth(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;
  final _firestore = FirebaseFirestore.instance;

  Future<String> userRole()async {
    var user;
    try {
       user = await  getCurrentUID();
       try{
          await _firestore.collection('Users').doc(user).get().then((DocumentSnapshot userDetail) {
      if(userDetail.exists){
      role = userDetail.data()['role'];
      }else{
        return Future.value('No user Data');
      }});
      return role;
      }catch (e) {
        return Future.value('document error');
      }
       }catch (e){
          return Future.value('get user error');
      }
  }
  // GET UID
  Future<String> getCurrentUID() async {
    return (_firebaseAuth.currentUser).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }
  Future<void> singOut()async{
    await _firebaseAuth.signOut();
  }
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<String>singIn({String email,String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed In";
    }on FirebaseAuthException catch(e){
      return e.message;
    }
}
 Future<String>singUp({String email,String password})async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      var user = _firebaseAuth.currentUser.uid;
      await _firestore.collection('Users').doc(user).set({
      'uid': user,
      'role': 'user',
      'email': email,
      'time': Timestamp.now(),
      });
      return "Registration succesfull";
    }on FirebaseAuthException catch(e){
      return e.message;
    }
}
Future<String>addItem({String name,String price,String description,String image})async{
    try{
      await _firestore.collection('items').doc().set({
      'name': name,
      'price': price,
      'description': description,
      'image':image,
      'time': Timestamp.now(),
      });
      return "Added succesfull";
    }on FirebaseAuthException catch(e){
      return e.message;
    }
}
}