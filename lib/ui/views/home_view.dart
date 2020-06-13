import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/viewmodels/product_crud_model.dart';
import 'package:flutterapp/persistance/user_box.dart';
import 'package:flutterapp/ui/views/cart_view.dart';
import 'package:flutterapp/ui/widgets/animated_bottombar.dart';
import 'package:flutterapp/ui/widgets/category_selector.dart';
import 'package:flutterapp/ui/widgets/google_signin_button.dart';
import 'package:flutterapp/ui/widgets/product_cards_pageview.dart';
import 'add_product.dart';

class HomeView extends StatefulWidget {
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  final Stream<QuerySnapshot> _productsStream =
      ProductCRUDModel.productCRUDModel.fetchProductsAsStream();

  final List<String> categories = new List<String>();
  bool isSignedIn = false;
  var favorites;

  @override
  void initState() {
    super.initState();
    setState(() {
      categories.add('Cakes');
      categories.add('Cookies');
      categories.add('Chocolates');
      categories.add('Biscuits');
      isSignedIn = UserBox.userBoxC.getBoolValue(Constants.IS_SIGNED_IN);
      favorites = UserBox.userBoxC.getUserFavorites(Constants.FAVORITES);
      if (favorites == null) {
        favorites = new Map<String, bool>();
      }
      print(favorites);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      Future.delayed(Duration.zero, () => _showDialog());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gaurav Bakes',
            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CartView()))
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade800,
        onPressed: () => {
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
                        child: AddProduct()));
              })
        },
        child: Icon(Icons.add),
      ),
      body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Explorasdasde',
                  style:
                      TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
            ),
            CategorySelector(
                categories: ['Cakes', 'Chocolates', 'Cookies', 'Biscuits']),
            ProductCards(productsStream: _productsStream, favorites: favorites)
          ])),
      bottomNavigationBar: AnimatedBottomBar(onBarTap: (index) {
        print(index);
      }),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Sign In to Continue",
              style: TextStyle(fontWeight: FontWeight.w600)),
          content: GoogleSignInButton(),
        );
      },
    );
  }
}
