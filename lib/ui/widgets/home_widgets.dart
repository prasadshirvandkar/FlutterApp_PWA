import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/viewmodels/favourites_crud_model.dart';
import 'package:flutterapp/core/viewmodels/product_crud_model.dart';
import 'package:flutterapp/ui/widgets/category_selector.dart';
import 'package:flutterapp/ui/widgets/product_cards_pageview.dart';

class HomeWidget {
  static Widget homeView(isServiceUp, favourites) {
    final Stream<QuerySnapshot> _productsStream =
        ProductCRUDModel.productCRUDModel.fetchProductsAsStream();
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          !isServiceUp
              ? Container(
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
                )
              : SizedBox(height: 0),
          SizedBox(
            height: 8.0,
          ),
          CategorySelector(
              categories: ['Cakes', 'Slice Cakes', 'Cupcakes', 'Chocolates']),
          SizedBox(
            height: 8.0,
          ),
          ProductCards(productsStream: _productsStream, favourites: favourites)
        ]));
  }

  static Widget favouritesHome(favourites) {
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
          ProductCards(
              productsStream: _favouritesStream, favourites: favourites)
        ]));
  }
}
