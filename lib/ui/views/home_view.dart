import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/appdata_model.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/core/viewmodels/appdata_crud_model.dart';
import 'package:flutterapp/core/viewmodels/favourites_crud_model.dart';
import 'package:flutterapp/persistance/user_box.dart';
import 'package:flutterapp/ui/views/cart_view.dart';
import 'package:flutterapp/ui/views/user_info.dart';
import 'package:flutterapp/ui/widgets/animated_bottombar.dart';
import 'package:flutterapp/ui/widgets/google_signin_button.dart';
import 'package:flutterapp/ui/widgets/home_widgets.dart';
import 'add_product.dart';

class HomeView extends StatefulWidget {
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  bool isSignedIn = false;
  int home = 1;
  Widget _animatedWidget;
  Set<String> favourites = new HashSet();
  bool isServiceUp = false;

  @override
  void initState() {
    super.initState();
    _loadFavourites().then((List<Product> products) => {
          setState(() {
            favourites = products.map((product) => product.productId).toSet();
          })
        });

    _checkIfServiceIsUp().then((value) => {
          setState(() {
            isServiceUp = value.isServiceUp;
            UserBox.userBoxC.addValue(Constants.IS_SERVICE_UP, isServiceUp);
          })
        });

    setState(() {
      isSignedIn = UserBox.userBoxC.getBoolValue(Constants.IS_SIGNED_IN);
      _animatedWidget = HomeWidget.homeView(true, favourites);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      Future.delayed(Duration.zero, () => _showDialog());
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
          Text('Bakes',
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800))
        ]),
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
                        child:
                            AddProduct(operation: 1, existingProduct: null)));
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
              _animatedWidget = HomeWidget.homeView(isServiceUp, favourites);
              break;
            case 1:
              _animatedWidget = HomeWidget.favouritesHome(favourites);
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

  Future<List<Product>> _loadFavourites() async {
    return await FavouritesCRUDModel.favouritesCRUDModel
        .fetchFavouritesForUser('sdadasdasd12e123132');
  }

  Future<AppData> _checkIfServiceIsUp() async {
    return await AppDataCRUDModel.appDataCRUDModel.getAppDataById();
  }
}
