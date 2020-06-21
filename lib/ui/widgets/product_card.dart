import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/core/viewmodels/favourites_crud_model.dart';
import 'package:flutterapp/core/viewmodels/product_crud_model.dart';
import 'package:flutterapp/ui/views/product_details.dart';
import 'package:palette_generator/palette_generator.dart';

class ProductCard extends StatefulWidget {
  final Product productDetails;
  final int cardNum;
  final bool isFavourite;

  ProductCard(
      {@required this.productDetails,
      @required this.cardNum,
      this.isFavourite});
  _ProductCard createState() => _ProductCard();
}

class _ProductCard extends State<ProductCard> {
  Color color = Colors.red;
  bool favorite = false;
  PaletteGenerator paletteGenerator;

  @override
  void initState() {
    super.initState();
    //_getImagePalette(AssetImage('assets/images/image8.jpg'));
    favorite = widget.isFavourite;
  }

  /* _getImagePalette(AssetImage assetImage) async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(assetImage, size: Size(256.0, 170.0), maximumColorCount: 20);
    setState(() {
      color = paletteGenerator.darkVibrantColor.color;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProductDetails(
                          productDetails: widget.productDetails,
                          isFavourite: favorite)))
            },
        onLongPress: () => {_showDialog()},
        child: Container(
            child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/image8.jpg'),
                          fit: BoxFit.fill),
                      boxShadow: [
                        BoxShadow(
                            color: color.withOpacity(0.4),
                            offset: Offset(0, 8.0),
                            blurRadius: 16)
                      ],
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.95,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [color, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 200),
                                      child: Text(widget.productDetails.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24.0),
                                          overflow: TextOverflow.clip,
                                          maxLines: 1)),
                                  SizedBox(height: 10.0),
                                  Text(
                                      '\u{20B9} ${widget.productDetails.price}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.clip)
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: InkWell(
                                      onTap: () => {
                                            setState(() {
                                              favorite = !favorite;
                                              addToFavorites(
                                                  widget.productDetails,
                                                  favorite);
                                            })
                                          },
                                      child: Icon(
                                        favorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.pink,
                                        size: 36.0,
                                      )))
                            ])),
                  ),
                ))
          ],
        )));
  }

  void addToFavorites(Product product, bool favoriteValue) {
    if (favoriteValue) {
      FavouritesCRUDModel.favouritesCRUDModel
          .addFavourite(product, 'sdadasdasd12e123132');
    } else {
      FavouritesCRUDModel.favouritesCRUDModel
          .removeFavourite(product.productId, 'sdadasdasd12e123132');
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Product Actions"),
          content: Wrap(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FlatButton(
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Edit",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold))),
                  onPressed: () {
                    
                  },
                ),
                SizedBox(height: 8.0),
                FlatButton(
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Delete",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold))),
                  onPressed: () {
                    Navigator.pop(context);
                    ProductCRUDModel.productCRUDModel
                        .removeProduct(widget.productDetails.productId);
                  },
                )
              ],
            )
          ]),
        );
      },
    );
  }
}
