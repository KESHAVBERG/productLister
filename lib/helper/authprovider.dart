import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:messageapp/model/user.dart';

class AuthProvider {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future<void> register(
      String email, String password, String username, File image,String sn , add) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("userpic").child(user.uid);
    final StorageUploadTask uploadTask = storageReference.putFile(image);
    final StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final mediaUrl = await taskSnapshot.ref.getDownloadURL();

    Firestore.instance.collection('user').document(user.uid).setData({
      'id': user.uid,
      'name': username,
      'email': email,
      'image': mediaUrl,
      'shopName':sn,
      'add':add
    });
  }

  Future<void> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = result.user;
  }

  logout() async {
    await _auth.signOut().then((_) => FirebaseUser == null);
  }

  Stream<User> get usere {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }
}
