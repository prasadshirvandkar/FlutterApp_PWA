import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/core/services/firebase_api.dart';
import 'package:flutter/material.dart';

class FavouritesCRUDModel extends ChangeNotifier {
  FavouritesCRUDModel._();
  static final FavouritesCRUDModel favouritesCRUDModel =
      FavouritesCRUDModel._();
  static FirestoreAPI _firestoreAPI;

  final String _collectionFavourites = 'favourite_products';

  FirestoreAPI get firestoreAPI {
    if (_firestoreAPI != null) return _firestoreAPI;

    _firestoreAPI = FirestoreAPI(path: 'userdata');
    return _firestoreAPI;
  }

  Stream<QuerySnapshot> fetchFavouritesAsStream(String userId) {
    return firestoreAPI.getStreamDocumentCollection(
        userId, _collectionFavourites);
  }

  Future<List<Product>> fetchFavouritesForUser(String userId) async {
    var result = await firestoreAPI.getDocumentsCollection(
        userId, _collectionFavourites);
    List<Product> userFavourites = result.documents
        .map((doc) => Product.fromMap(doc.data, doc.documentID))
        .toList();
    return userFavourites;
  }

  Future<Product> getFavouriteById(String userId, String id) async {
    var doc = await firestoreAPI.getDocumentCollectionById(
        userId, _collectionFavourites, id);
    return Product.fromMap(doc.data, doc.documentID);
  }

  Future removeFavourite(String id, String userId) async {
    await firestoreAPI.removeDocumentCollection(
        userId, _collectionFavourites, id);
    return;
  }

  Future addFavourite(Product data, String userId) async {
    await firestoreAPI.addDocumentToCollectionWithDocID(
        userId, _collectionFavourites, data.toJson(), data.productId);
  }

  void onChange() {
    notifyListeners();
  }
}
