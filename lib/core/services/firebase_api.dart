import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAPI {
  final Firestore _firestoreDB = Firestore.instance;
  final String path;
  CollectionReference collectionReference;

  FirestoreAPI({this.path}) {
    collectionReference = _firestoreDB.collection(path);
  }

  Future<DocumentReference> addDocument(Map data) {
    return collectionReference.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return collectionReference.document(id).updateData(data);
  }

  Future<QuerySnapshot> getDataCollection() {
    return collectionReference.getDocuments();
  }

  Future<QuerySnapshot> getDataBasedOnCondition(String condition, String id) {
    return collectionReference.where(condition, isEqualTo: id).getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return collectionReference.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return collectionReference.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return collectionReference.document(id).delete();
  }

  Future<DocumentReference> addDocumentToCollection(
      String id, String collectionName, Map data) {
    return collectionReference
        .document(id)
        .collection(collectionName)
        .add(data);
  }

  Future<DocumentReference> addDocumentToCollectionWithDocID(
      String id, String collectionName, Map data, documentId) {
    return collectionReference
        .document(id)
        .collection(collectionName)
        .document(documentId).setData(data);
  }

  Future<QuerySnapshot> getDocumentsCollection(
      String id, String collectionName) {
    return collectionReference
        .document(id)
        .collection(collectionName)
        .getDocuments();
  }

  Stream<QuerySnapshot> getStreamDocumentCollection(
      String id, String collectionName) {
    return collectionReference
        .document(id)
        .collection(collectionName)
        .snapshots();
  }

  Future<QuerySnapshot> getDocumentCollectionBasedOnCondition(
      String id, String collectionName, String condition, String conditionId) {
    return collectionReference
        .document(id)
        .collection(collectionName)
        .where(condition, isEqualTo: conditionId)
        .getDocuments();
  }

  Future<DocumentSnapshot> getDocumentCollectionById(
      String id, String collectionName, String docId) {
    return collectionReference
        .document(id)
        .collection(collectionName)
        .document(docId)
        .get();
  }

  Future<DocumentReference> updateDocumentToCollection(
      String id, String collectionName, String docId, Map data) {
    return collectionReference
        .document(id)
        .collection(collectionName)
        .document(docId)
        .updateData(data);
  }

  Future<void> removeDocumentCollection(
      String id, String collectionName, String docId) {
    return collectionReference
        .document(id)
        .collection(collectionName)
        .document(docId)
        .delete();
  }
}
