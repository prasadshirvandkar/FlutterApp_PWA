import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/ui/views/add_product.dart';
import 'package:flutterapp/ui/views/cart_view.dart';
import 'package:flutterapp/ui/views/product_details.dart';
import 'package:flutterapp/ui/views/product_list.dart';
import 'package:flutterapp/ui/views/user_info.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constants.INITIAL_PAGE:
        {
          /* return MaterialPageRoute(
              builder: (_) => FutureBuilder<bool>(
                  future: SharedPreference.sharedPref.getBoolValue(Constants.IS_SIGNED_IN),
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    Widget widget = HomeView();
                    if (snapshot.hasData) {
                      if (!snapshot.data) {
                        widget = FirebaseAuthPractice();
                      }
                    }
                    return widget;
                  })); */
                  return MaterialPageRoute(builder: (_) => ProductList());
        }
      case Constants.PRODUCTS:
        return MaterialPageRoute(builder: (_) => ProductList());
      case Constants.ADD_PRODUCT:
        return MaterialPageRoute(builder: (_) => AddProduct());
      case Constants.PRODUCT_DETAILS:
        return MaterialPageRoute(builder: (_) => ProductDetails());
      case Constants.ORDERS:
        return MaterialPageRoute(builder: (_) => ProductList());
      case Constants.ORDER_DETAILS:
        return MaterialPageRoute(builder: (_) => ProductList());
      case Constants.ROUTE_USER_INFO:
        return MaterialPageRoute(builder: (_) => UserInfo());
      case Constants.CART_ITEMS:
        return MaterialPageRoute(builder: (_) => CartView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
