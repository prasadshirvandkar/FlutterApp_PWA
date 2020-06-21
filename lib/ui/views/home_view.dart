import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/core/viewmodels/favourites_crud_model.dart';
import 'package:flutterapp/core/viewmodels/product_crud_model.dart';
import 'package:flutterapp/persistance/user_box.dart';
import 'package:flutterapp/ui/views/cart_view.dart';
import 'package:flutterapp/ui/views/user_info.dart';
import 'package:flutterapp/ui/widgets/animated_bottombar.dart';
import 'package:flutterapp/ui/widgets/category_selector.dart';
import 'package:flutterapp/ui/widgets/google_signin_button.dart';
import 'package:flutterapp/ui/widgets/product_cards_pageview.dart';
import 'add_product.dart';

class HomeView extends StatefulWidget {
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  final List<String> categories = new List();
  bool isSignedIn = false;
  int home = 1;
  Widget _animatedWidget;
  Set<String> favourites = new HashSet();

  @override
  void initState() {
    super.initState();
    setState(() {
      isSignedIn = UserBox.userBoxC.getBoolValue(Constants.IS_SIGNED_IN);
      _animatedWidget = _homeView();
    });

    _loadFavourites().then((List<Product> products) => {
      setState(() {
        favourites = products.map((product) => product.productId).toSet();
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      Future.delayed(Duration.zero, () => _showDialog());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Bakes',
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
                        child: AddProduct(operation: 1, existingProduct: null)));
              })
        },
        child: Icon(Icons.add),
      ),
      body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(child: child, scale: animation);
          },
          child: _animatedWidget),
      bottomNavigationBar: AnimatedBottomBar(onBarTap: (index) {
        setState(() {
          switch (index) {
            case 0:
              _animatedWidget = _homeView();
              break;
            case 1:
              _animatedWidget = _favouritesHome();
              break;
            case 2:
              _animatedWidget = UserInfo();
              break;
          }
        });
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

  Widget _homeView() {
    final Stream<QuerySnapshot> _productsStream =
        ProductCRUDModel.productCRUDModel.fetchProductsAsStream();
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          /* Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.red.shade400),
            height: 50,
            child: Center(
                child: Text(
              'The Service is Temporarily Unavailable',
              style: TextStyle(color: Colors.white),
            )),
          ), */
          SizedBox(
            height: 8.0,
          ),
          CategorySelector(
              categories: ['Cakes', 'Chocolates', 'Cookies', 'Biscuits']),
          SizedBox(
            height: 8.0,
          ),
          ProductCards(productsStream: _productsStream, favourites: favourites)
        ]));
  }

  Widget _favouritesHome() {
    final Stream<QuerySnapshot> _favouritesStream = FavouritesCRUDModel
        .favouritesCRUDModel
        .fetchFavouritesAsStream('sdadasdasd12e123132');
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Your Favourites',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 8.0,
          ),
          ProductCards(productsStream: _favouritesStream, favourites: favourites)
        ]));
  }

  Future<List<Product>> _loadFavourites() async {
    return await FavouritesCRUDModel.favouritesCRUDModel.fetchFavouritesForUser('sdadasdasd12e123132');
  }
}
