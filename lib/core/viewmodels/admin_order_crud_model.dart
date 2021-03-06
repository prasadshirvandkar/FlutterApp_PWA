import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/order_model.dart';
import 'package:flutterapp/core/services/firebase_api.dart';

class AdminOrdersCRUDModel extends ChangeNotifier {

  AdminOrdersCRUDModel._();
  static final AdminOrdersCRUDModel adminOrdersCRUDModel = AdminOrdersCRUDModel._();
  static FirestoreAPI _firestoreAPI;

  final String _collectionOrders = 'admin_orders';

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

  Stream<QuerySnapshot> fetchActiveOrdersAsStream() {
    return firestoreAPI.getStreamDocumentCollection('active', _collectionOrders);
  }

  Stream<QuerySnapshot> fetchPastOrdersAsStream() {
    return firestoreAPI.getStreamDocumentCollection('past', _collectionOrders);
  }

  Future removeOrder(String id, String userId) async {
    await firestoreAPI.removeDocumentCollection(userId, _collectionOrders, id);
    return;
  }

  Future removeOrderFromActive(String id, Order data) async {
    await firestoreAPI.removeDocumentCollection('active', _collectionOrders, id);
    await addOrder(data, 'past');
    return;
  }

  Future updateOrder(Order data, String id, String userId) async {
    await firestoreAPI.updateDocumentToCollection(userId, _collectionOrders, id, data.toJson());
  }

  Future addOrderWithCustomID(Order data, String userId) async {
    await firestoreAPI.addDocumentToCollectionWithDocID(userId, _collectionOrders, data.toJson(), data.orderId);
  }

  Future addOrder(Order data, String orderType) async {
    await firestoreAPI.addDocumentToCollection(orderType, _collectionOrders, data.toJson());
  }

  void onChange() {
    notifyListeners();
  }
}