import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/cart_model.dart';

class CartCard extends StatefulWidget {
  final Cart cartDetails;
  final VoidCallback onDelete;
  CartCard({Key key, @required this.cartDetails, @required this.onDelete}): super(key: key);
  _CartCard createState() => _CartCard();
}

class _CartCard extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
    child: Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          Hero(
              tag: widget.cartDetails.cartId,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.20,
                height: MediaQuery.of(context).size.height * 0.30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('assets/images/image2.jpg'),
                    fit: BoxFit.fill
                  )
                )
              )),
          Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.cartDetails.productName,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20)),
                  SizedBox(height: 10.0),
                  Text(
                    '\u{20B9} ${widget.cartDetails.productPrice}',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.orangeAccent),
                  ),
                  SizedBox(height: 10.0),
                  /* Text(
                    'Quantity: ${widget.cartDetails.itemCount.toString()}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ), */
                  RaisedButton(
                    onPressed: () async => {
                      widget.onDelete()
                    },
                    shape: StadiumBorder(),
                    color: Colors.red,
                    child: Text('Remove from Cart', style: TextStyle(color: Colors.white)),
                  )
                ],
              ))
        ],
      ),
    )));
  }
}
