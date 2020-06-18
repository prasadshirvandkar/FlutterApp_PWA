import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/cart_model.dart';

class CartCard extends StatefulWidget {
  final Cart cartDetails;
  final VoidCallback onDelete;
  CartCard({Key key, @required this.cartDetails, @required this.onDelete})
      : super(key: key);
  _CartCard createState() => _CartCard();
}

class _CartCard extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
        child: Card(
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110.0,
                  width: 110.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 8.0),
                            blurRadius: 16)
                      ],
                      image: DecorationImage(
                          image: AssetImage('assets/images/image2.jpg'),
                          fit: BoxFit.fill))),
                Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.cartDetails.productName,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20)),
                        SizedBox(height: 10.0),
                        Text(
                          '\u{20B9} ${widget.cartDetails.productPrice}',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.orangeAccent),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Quantity: ${widget.cartDetails.quantity}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.grey),
                        ),
                        SizedBox(height: 16.0),
                        RaisedButton(
                          onPressed: () async => {widget.onDelete()},
                          shape: StadiumBorder(),
                          color: Colors.red,
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Remove',
                                  style: TextStyle(color: Colors.white))),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
