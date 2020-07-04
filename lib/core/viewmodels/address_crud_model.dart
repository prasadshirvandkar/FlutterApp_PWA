import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/core/services/firebase_api.dart';
import 'package:flutter/material.dart';

class AddressCRUDModel extends ChangeNotifier {
  AddressCRUDModel._();
  static final AddressCRUDModel addressCRUDModel = AddressCRUDModel._();
  static FirestoreAPI _firestoreAPI;

  final String _collectionAddress = 'user_address';

  FirestoreAPI get firestoreAPI {
    if (_firestoreAPI != null) return _firestoreAPI;

    _firestoreAPI = FirestoreAPI(path: 'orders');
    return _firestoreAPI;
  }

  Future<Product> getAddressById(String userId, String id) async {
    var doc = await firestoreAPI.getDocumentCollectionById(
        userId, _collectionAddress, id);
    return Product.fromMap(doc.data, doc.documentID);
  }

  Future removeAddress(String userId) async {
    await firestoreAPI.removeDocumentCollection(
        userId, _collectionAddress, Constants.ADDRESS_ID);
    return;
  }

  Future updateAddress(String userId, String address) async {
    Map<String, dynamic> addressMap = {'address': address};
    await firestoreAPI.updateDocumentToCollection(
        userId, _collectionAddress, Constants.ADDRESS_ID, addressMap);
    return;
  }

  Future addAddress(String userId, String address) async {
    Map<String, dynamic> addressMap = {'address': address};
    await firestoreAPI.addDocumentToCollectionWithDocID(
        userId, _collectionAddress, addressMap, Constants.ADDRESS_ID);
  }

  void onChange() {
    notifyListeners();
  }
}
