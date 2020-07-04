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

  /* Stream<QuerySnapshot> fetchProductsAsStream(String category) {
    return firestoreAPI.getStreamDocumentCollection(category, _collectionProducts);
  }

  Future<Product> getProductById(String category, String id) async {
    var doc = await firestoreAPI.getDocumentCollectionById(category, _collectionProducts, id);
    return Product.fromMap(doc.data, doc.documentID);
  }

  Future removeProduct(String category, String id) async {
    await firestoreAPI.removeDocumentCollection(category, _collectionProducts, id);
    return;
  }

  Future updateProduct(String category, Product data, String id) async {
    await firestoreAPI.updateDocumentToCollection(category, _collectionProducts, id, data.toJson());
  }

  Future addProduct(String category, Product data) async {
    await firestoreAPI.addDocumentToCollection(category, _collectionProducts, data.toJson());
  } */

  void onChange() {
    notifyListeners();
  }
}