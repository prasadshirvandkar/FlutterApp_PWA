import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/order_model.dart';
import 'package:flutterapp/core/services/firebase_api.dart';

class OrderCRUDModel extends ChangeNotifier {
  OrderCRUDModel._();
  static final OrderCRUDModel orderCRUDModel = OrderCRUDModel._();
  static FirestoreAPI _firestoreAPI;

  final String _collectionOrders = 'orders';

  FirestoreAPI get firestoreAPI {
    if(_firestoreAPI != null) return _firestoreAPI;

    _firestoreAPI = FirestoreAPI(path: _collectionOrders);
    return _firestoreAPI;
  }

  List<Order> orders;
  Future<List<Order>> fetchOrders() async {
    var result = await firestoreAPI.getDataCollection();
    orders = result.documents
        .map((doc) => Order.fromMap(doc.data, doc.documentID))
        .toList();
    return orders;
  }

  Stream<QuerySnapshot> fetchOrdersAsStream(String userId) {
    return firestoreAPI.getStreamDocumentCollection(userId, _collectionOrders);
  }

  Future<List<Order>> fetchOrdersForUser(String userId) async {
    var result = await firestoreAPI.getDocumentsCollection(userId, _collectionOrders);
    List<Order> userOrders = result.documents
        .map((doc) => Order.fromMap(doc.data, doc.documentID))
        .toList();
    return userOrders;
  }

  Future<Order> getOrderById(String userId, String id) async {
    var doc = await firestoreAPI.getDocumentCollectionById(userId, _collectionOrders, id);
    return Order.fromMap(doc.data, doc.documentID);
  }

  Future removeOrder(String id, String userId) async {
    await firestoreAPI.removeDocumentCollection(userId, _collectionOrders, id);
    return;
  }

  Future updateOrder(Order data, String id, String userId) async {
    await firestoreAPI.updateDocumentToCollection(_collectionOrders, data.toJson(), userId, id);
  }

  Future addOrder(Order data, String userId) async {
    await firestoreAPI.addDocumentToCollection(userId, _collectionOrders, data.toJson());
  }

  void onChange() {
    notifyListeners();
  }
}
