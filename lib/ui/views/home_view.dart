import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/core/viewmodels/product_crud_model.dart';
import 'package:flutterapp/ui/views/add_product.dart';
import 'package:flutterapp/ui/widgets/animated_bottombar.dart';
import 'package:flutterapp/ui/widgets/category_selector.dart';
import 'package:flutterapp/ui/widgets/product_card.dart';

class HomeView extends StatefulWidget {
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Stream<QuerySnapshot> _productsStream =
      ProductCRUDModel.productCRUDModel.fetchProductsAsStream();
  List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bakes', style: TextStyle(fontSize: 22.0)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => {
                //Navigator.pushNamed(context, Constants.CART_ITEMS)
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber.shade800,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext buildContext) {
                  return new Container(
                    color: Colors.transparent,
                    child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0))),
                        child: AddProduct()),
                  );
                });
          },
          child: Icon(Icons.add)
        ),
        body: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Explore',
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
              ),
              CategorySelector(
                  categories: ['Cakes', 'Chocolates', 'Cookies', 'Biscuits']),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: StreamBuilder(
                    stream: _productsStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error Loading');
                      }

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          List<DocumentSnapshot> documents =
                              snapshot.data.documents;
                              print('Size: ${documents.length}');
                          List<Product> products = documents
                              .map((doc) =>
                                  Product.fromMap(doc.data, doc.documentID))
                              .toList();
                          return snapshot.hashCode != null
                              ? PageView.builder(
                                  itemCount: products.length,
                                  physics: BouncingScrollPhysics(),
                                  controller:
                                      PageController(viewportFraction: 0.75),
                                  itemBuilder: (buildContext, index) => Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.0,
                                          right: 16.0,
                                          top: 24.0,
                                          bottom: 24.0),
                                      child: ProductCard(
                                          productDetails: products[index],
                                          cardNum: index)))
                              : Center(
                                  child: CircularProgressIndicator(
                                  key: Key("circularProgressIndictor"),
                                  backgroundColor: Colors.orange,
                                ));
                      }
                    },
                  )),
            ])),
        bottomNavigationBar: AnimatedBottomBar(onBarTap: (index) {
          print(index);
        }));
  }
}
