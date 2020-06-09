import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/persistance/user_box.dart';
import 'package:flutterapp/ui/views/product_details.dart';

class ProductCard extends StatefulWidget {
  final Product productDetails;
  final int cardNum;
  final Map<String, bool> favorites;
  ProductCard(
      {@required this.productDetails,
      @required this.cardNum,
      @required this.favorites});
  _ProductCard createState() => _ProductCard();
}

class _ProductCard extends State<ProductCard> {
  Color color = Colors.blue;
  bool favorite;

  @override
  void initState() {
    super.initState();
    favorite = isFavorite(widget.productDetails.productId);
    //_getImagePalette(AssetImage('assets/images/image8.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProductDetails(
                          productDetails: widget.productDetails)))
            },
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
                                          addToFavorites(widget.productDetails.productId, favorite);
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

  bool isFavorite(String productId) {
    return widget.favorites[productId] != null
        ? widget.favorites[productId]
        : false;
  }

  void addToFavorites(String productId, bool favoriteValue) {
    widget.favorites[productId] = favoriteValue;
    UserBox.userBoxC.addValue(Constants.FAVORITES, widget.favorites);
  }
}
