import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/cart_model.dart';
import 'package:flutterapp/core/viewmodels/cart_crud_model.dart';
import 'package:flutterapp/core/viewmodels/favourites_crud_model.dart';
import 'package:flutterapp/persistance/user_box.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import '../../core/models/product_model.dart';

class ProductDetails extends StatefulWidget {
  final Product productDetails;
  final Color paletteColor;
  final bool isFavourite;
  ProductDetails({this.productDetails, this.paletteColor, this.isFavourite});

  _ProductDetails createState() => _ProductDetails();
}

class _ProductDetails extends State<ProductDetails> {
  List<String> images = new List<String>();
  String price = '';
  bool isFavorite;
  Color color;
  Color textColor;
  bool isServiceUp;

  //User user;

  @override
  void initState() {
    super.initState();
    setState(() {
      isServiceUp = UserBox.userBoxC.getBoolValue(Constants.IS_SERVICE_UP);
      images.add('assets/images/image8.jpg');
      images.add('assets/images/image9.jpg');
      images.add('assets/images/image1.jpg');
      images.add('assets/images/image2.jpg');
      price = double.parse(widget.productDetails.price).toString();
      color = Colors.blue;
      textColor = color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
      isFavorite = widget.isFavourite;
      //user = User.fromMap(UserBox.userBoxC.getUserObject(Constants.USER_INFO));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: textColor,
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: IconButton(
                    color: isFavorite ? Colors.red : textColor,
                    icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border),
                    onPressed: () => {
                      setState(() {
                        isFavorite = !isFavorite;
                        addToFavorites(widget.productDetails, isFavorite);
                      })
                    },
                  )),
            ]),
        body: Stack(children: <Widget>[
          PageView.builder(
              itemCount: images.length,
              physics: AlwaysScrollableScrollPhysics(),
              controller: PageController(),
              itemBuilder: (buildContext, index) => Image(
                    image: AssetImage(images[index]),
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        color.withOpacity(0.95),
                        color.withOpacity(0.75),
                        color.withOpacity(0.55),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.1, 0.35, 0.5, 1]),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Container(
                                  child: Text(
                            widget.productDetails.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 34.0),
                            overflow: TextOverflow.clip,
                          ))),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Flexible(
                          child: Container(
                              child: Text('\u{20B9} $price',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.clip))),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(widget.productDetails.description,
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                          overflow: TextOverflow.clip),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Weight: ',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0),
                              overflow: TextOverflow.clip),
                          Text(widget.productDetails.weight,
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                              overflow: TextOverflow.clip),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Quantity: ',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0),
                              overflow: TextOverflow.clip),
                          Text(widget.productDetails.quantity,
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                              overflow: TextOverflow.clip),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: isServiceUp
                              ? _addToCartButton()
                              : _closedButton())
                    ],
                  ),
                ),
              )),
        ]));
  }

  _addToCart() async {
    QuerySnapshot result = await CartCRUDModel.cartCRUDModel
        .checkIfProductExistsInCart(
            Constants.TEST_USER_ID, widget.productDetails.productId);
    if (result.documents.isNotEmpty) {
      var existingCartData = result.documents[0].data;
      existingCartData['quantity'] =
          (int.parse(existingCartData['quantity']) + 1).toString();
      Cart cartData =
          Cart.fromMap(existingCartData, result.documents[0].documentID);
      await CartCRUDModel.cartCRUDModel
          .updateCart(Constants.TEST_USER_ID, cartData, cartData.cartId);
    } else {
      await CartCRUDModel.cartCRUDModel
          .addCart(getCartData(), Constants.TEST_USER_ID);
    }
  }

  Cart getCartData() {
    return Cart(
        cartId: Uuid().v1().replaceAll('-', '').substring(0, 10),
        productId: widget.productDetails.productId,
        productName: widget.productDetails.name,
        productCategory: widget.productDetails.category,
        productPrice: widget.productDetails.price,
        quantity: widget.productDetails.quantity,
        productImage: '',
        isEggless: 'false',
        extras: '',
        dateTime: new DateTime.now().toString());
  }

  void addToFavorites(Product product, bool favoriteValue) {
    if (favoriteValue) {
      FavouritesCRUDModel.favouritesCRUDModel
          .addFavourite(product, Constants.TEST_USER_ID);
    } else {
      FavouritesCRUDModel.favouritesCRUDModel
          .removeFavourite(product.productId, Constants.TEST_USER_ID);
    }
  }

  _closedButton() {
    return RaisedButton(
        onPressed: () => {},
        color: Colors.red,
        shape: StadiumBorder(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Service Temporarily Closed',
              style: TextStyle(color: Colors.white, fontSize: 18.0)),
        ));
  }

  _addToCartButton() {
    return RaisedButton(
        onPressed: () async => {
              _addToCart(),
              Fluttertoast.showToast(
                  msg: 'Added to Cart', 
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM)
            },
        color: Colors.amber,
        shape: StadiumBorder(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Add To Cart',
              style: TextStyle(color: Colors.white, fontSize: 18.0)),
        ));
  }
}
