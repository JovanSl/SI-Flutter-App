import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final FirebaseAuth _firebaseAuth;

  Auth(this._firebaseAuth);

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
      return "Registration succesfull";
    }on FirebaseAuthException catch(e){
      return e.message;
    }
}
}