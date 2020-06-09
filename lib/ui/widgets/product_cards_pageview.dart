import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/ui/widgets/product_card.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProductCards extends StatelessWidget {
  final Stream<QuerySnapshot> productsStream;
  final Map<String, bool> favorites;
  ProductCards({this.productsStream, this.favorites});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Container(
            child: StreamBuilder(
                stream: productsStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error Loading');
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      List<DocumentSnapshot> documents =
                          snapshot.data.documents;
                      List<Product> products = documents
                          .map((doc) =>
                              Product.fromMap(doc.data, doc.documentID))
                          .toList();
                      return snapshot.hashCode != null
                          ? PageView.builder(
                              itemCount: products.length,
                              physics: BouncingScrollPhysics(),
                              controller: PageController(
                                  viewportFraction: kIsWeb ? 0.8 : 0.75),
                              itemBuilder: (buildContext, index) => Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                      top: 24.0,
                                      bottom: 24.0),
                                  child: ProductCard(
                                      productDetails: products[index],
                                      cardNum: index,
                                      favorites: favorites)))
                          : Text('Error');
                  }
                })));
  }
}
