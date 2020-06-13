import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/cart_model.dart';
import 'package:flutterapp/core/services/firebase_api.dart';

class CartCRUDModel extends ChangeNotifier {
  CartCRUDModel._();
  static final CartCRUDModel cartCRUDModel = CartCRUDModel._();
  static FirestoreAPI _firestoreAPI;
  final String _collectionCarts = 'carts';

  FirestoreAPI get firestoreAPI {
    if (_firestoreAPI != null) return _firestoreAPI;

    _firestoreAPI = FirestoreAPI(path: _collectionCarts);
    return _firestoreAPI;
  }

  List<Cart> carts;

  Future<List<Cart>> fetchCartsForUser(String userId) async {
    var result =
        await firestoreAPI.getDocumentsCollection(userId, _collectionCarts);
    List<Cart> userCarts = result.documents
        .map((doc) => Cart.fromMap(doc.data, doc.documentID))
        .toList();
    return userCarts;
  }

  Future<String> fetchTotalPrice(String userId) async {
    var result = await fetchCartsForUser(userId);
    double totalPrice = result
        .map((e) => double.parse(e.productPrice))
        .reduce((value, element) => value + element);
    return totalPrice.toString();
  }

  Stream<QuerySnapshot> fetchCartsAsStream(String userId) {
    return firestoreAPI.getStreamDocumentCollection(userId, _collectionCarts);
  }

  Future<Cart> getCartById(String userId, String id) async {
    var doc = await firestoreAPI.getDocumentCollectionById(
        userId, _collectionCarts, id);
    return Cart.fromMap(doc.data, doc.documentID);
  }

  Future removeItemFromCart(String userId, String id) async {
    await firestoreAPI.removeDocumentCollection(userId, _collectionCarts, id);
    return;
  }

  Future checkIfProductExistsInCart(String userId, String productId) async {
    var result = await firestoreAPI.getDocumentCollectionBasedOnCondition(
        userId, _collectionCarts, 'productId', productId);
    return result;
  }

  Future updateCart(String userId, Cart data, String id) async {
    await firestoreAPI.updateDocumentToCollection(
        userId, _collectionCarts, id, data.toJson());
  }

  Future addCart(Cart data, String userId) async {
    await firestoreAPI.addDocumentToCollection(
        userId, _collectionCarts, data.toJson());
  }

  void onChange() {
    notifyListeners();
  }
}
