import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/core/services/firebase_api.dart';

class ProductCRUDModel extends ChangeNotifier {
  ProductCRUDModel._();
  static final ProductCRUDModel productCRUDModel = ProductCRUDModel._();
  static FirestoreAPI _firestoreAPI;

  FirestoreAPI get firestoreAPI {
    if(_firestoreAPI != null) return _firestoreAPI;

    _firestoreAPI = FirestoreAPI(path: 'products');
    return _firestoreAPI;
  }

  List<Product> products;

  Future<List<Product>> fetchProducts() async {
    var result = await firestoreAPI.getDataCollection();
    products = result.documents.map((doc) => Product.fromMap(doc.data, doc.documentID)).toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return firestoreAPI.streamDataCollection();
  }

  Future<Product> getProductById(String id) async {
    var doc = await firestoreAPI.getDocumentById(id);
    return Product.fromMap(doc.data, doc.documentID);
  }

  Future removeProduct(String id) async {
    await firestoreAPI.removeDocument(id);
    return;
  }

  Future updateProduct(Product data, String id) async {
    await firestoreAPI.updateDocument(data.toJson(), id);
  }

  Future addProduct(Product data) async {
    await firestoreAPI.addDocument(data.toJson());
  }

  void onChange() {
    notifyListeners();
  }
}