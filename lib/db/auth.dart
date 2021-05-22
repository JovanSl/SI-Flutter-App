import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:v1/models/user.dart';

class Auth {
  String role = '';
  Auth(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;
  final _firestore = FirebaseFirestore.instance;

  Future<dynamic>placeOrder(cartItem,totalPrice)async{
  var user;
      user = await getCurrentUID();
    try {
      DocumentReference documentReference =
      _firestore.collection('orders').doc();
      await documentReference.set({
        'total':totalPrice,
        'order': cartItem,
        'id': documentReference.id,
        'time': Timestamp.now(),
        'userId': user,
      });
      return "Added succesfull";
    } catch (e) {
      return e.toString();
    }
    

  }
  Future<List> userInfo() async {
    var user,address,name;
    var userInfo=[];
    try {
      user = await getCurrentUID();
      try {
        await _firestore
            .collection('Users')
            .doc(user)
            .get()
            .then((DocumentSnapshot userDetail) {
          if (userDetail.exists) {
            role = userDetail.data()['role'];
            name=userDetail.data()['fullname'];
            address=userDetail.data()['adress'];
            userInfo.add(role);
            userInfo.add(name);
            userInfo.add(address);
            return Users.fromJson(userDetail.data());
          } else {
            return Future.value('No user Data');
          }
        });
        return userInfo;
      } catch (e) {
       return null;
      }
    } catch (e) {
      return null;
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

  Future<void> singOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<String> singIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
          return Future.value('Success');
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       return Future.value('No user found for that email.');
      } else if (e.code == 'wrong-password') {
       return Future.value('Wrong password provided for that user.');
      }
    }catch (e){
      return Future.value(e);
    }
    return Future.value('error');
  }

  Future<String> singUp({String email, String password,String fullname,String adress}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = _firebaseAuth.currentUser.uid;
      await _firestore.collection('Users').doc(user).set({
        'uid': user,
        'role': 'user',
        'email': email,
        'fullname':fullname,
        'adress':adress,
        'time': Timestamp.now(),
      });
      return Future.value('Success');
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message);
    }
  }

  Future<String> addItem(
      {String name, String price, String description, dynamic image}) async {
    var dbImage;
    try {
      dbImage = await uploadPic(image);
      DocumentReference documentReference =
          _firestore.collection('items').doc();
      await documentReference.set({
        'name': name,
        'price': price,
        'description': description,
        'image': dbImage,
        'id': documentReference.id,
        'time': Timestamp.now(),
      });
      return "Added succesfull";
    } catch (e) {
      return e.toString();
    }
  }
  Future<String> editUser(
     String fullname,String address)async{
      try {
        DocumentReference documentReference =
          _firestore.collection('Users').doc((_firebaseAuth.currentUser).uid);
      await documentReference.update({
        "fullname": fullname,
        "adress": address,
      });

      } catch (e) {
        return e;
      }
      return 'Error';
    }
  Future<String> editItem(
      {String name,
      String price,
      String description,
      dynamic image,
      String itemId}) async {

    var dbImage;

    if (image.runtimeType == String) {
      dbImage = image.toString();
      try {
      DocumentReference documentReference =
          _firestore.collection('items').doc(itemId);
      await documentReference.update({
        "name": name,
        "price": price,
        'description': description,
        'image': dbImage,
      });
    } catch (e) {
      return e.toString();
    }
    } 
    else if (image.runtimeType.toString() == "_File") {
      try {
        dbImage = await uploadPic(image);
         DocumentReference documentReference =
          _firestore.collection('items').doc(itemId);
      await documentReference.update({
        "name": name,
        "price": price,
        'description': description,
        'image': dbImage,
      });
      } catch (e) {print(e.toString());}
    } else {
      print('error');
    }
    return "error";
  }

  Future uploadPic(image) async {
    var url;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(image);
    await uploadTask.whenComplete(() {
      url = ref.getDownloadURL();
    });
    return url;
  }

  CollectionReference items = FirebaseFirestore.instance.collection('items');

  Future<void> deleteItem(String itemId) {
    return items
        .doc(itemId)
        .delete()
        .then((value) => print("Item Deleted"))
        .catchError((error) => print("Failed to delete item: $error"));
  }

  Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
}
