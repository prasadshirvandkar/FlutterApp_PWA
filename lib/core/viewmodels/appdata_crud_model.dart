import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/appdata_model.dart';
import 'package:flutterapp/core/services/firebase_api.dart';

class AppDataCRUDModel extends ChangeNotifier {
  AppDataCRUDModel._();
  static final AppDataCRUDModel appDataCRUDModel = AppDataCRUDModel._();
  static FirestoreAPI _firestoreAPI;

  FirestoreAPI get firestoreAPI {
    if(_firestoreAPI != null) return _firestoreAPI;

    _firestoreAPI = FirestoreAPI(path: 'appdata');
    return _firestoreAPI;
  }
   
  getAppDataById() async {
    var doc = await firestoreAPI.getDocumentById(Constants.APP_DATA_ID);
    return AppData.fromMap(doc.data);
  }
   
  updateAppData(AppData data) async {
    await firestoreAPI.updateDocument(data.toJson(), Constants.APP_DATA_ID);
  }

  void onChange() {
    notifyListeners();
  }
}