import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/core/models/user_model.dart';
import 'package:flutterapp/core/services/firebase_api.dart';
import 'package:flutter/material.dart';

class UserCRUDModel extends ChangeNotifier {
  UserCRUDModel._();
  static final UserCRUDModel userCRUDModel = UserCRUDModel._();
  static FirestoreAPI _firestoreAPI;

  FirestoreAPI get firestoreAPI {
    if(_firestoreAPI != null) return _firestoreAPI;

    _firestoreAPI = FirestoreAPI(path: 'users');
    return _firestoreAPI;
  }

  Future<User> getUserById(String id) async {
    var doc = await firestoreAPI.getDocumentById(id);
    return User.fromMap(doc.data, doc.documentID);
  }

  Future removeUser(String id) async {
    await firestoreAPI.removeDocument(id);
    return;
  }

  Future updateUser(User data, String id) async {
    await firestoreAPI.updateDocument(data.toMap(), id);
  }

  Future addUser(User data) async {
    await firestoreAPI.addDocument(data.toMap());
  }

  void onChange() {
    notifyListeners();
  }
}